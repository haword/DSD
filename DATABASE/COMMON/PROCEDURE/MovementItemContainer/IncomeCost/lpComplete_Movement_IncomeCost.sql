-- Function: lpComplete_Movement_IncomeCost ()

DROP FUNCTION IF EXISTS lpComplete_Movement_IncomeCost  (Integer, Integer);

CREATE OR REPLACE FUNCTION lpComplete_Movement_IncomeCost(
    IN inMovementId        Integer               , -- ���� ���������
    IN inUserId            Integer                 -- ������������
)
RETURNS VOID
AS
$BODY$
   DECLARE vbMovementId_from       Integer;
   DECLARE vbMovementDescId_from   Integer;
   DECLARE vbMovementId_to         Integer;
   DECLARE vbOperDate_to           TDateTime;
   DECLARE vbUnitId                Integer;
   DECLARE vbJuridicalId_Basis     Integer;
   DECLARE vbAccountDirectionId_To Integer;
BEGIN
     -- ����� �������� �� �������� ���� ����� ����� "������"
     vbMovementId_from:= (SELECT MovementFloat.ValueData :: Integer FROM MovementFloat WHERE MovementFloat.MovementId = inMovementId AND MovementFloat.DescId = zc_MovementFloat_MovementId());
     vbMovementDescId_from:= (SELECT Movement.DescId FROM Movement WHERE Movement.Id = vbMovementId_from);

     -- ����� ��������, ��� ������� �������� ����������� ����� "������" - !!!�� ��� ������������ � inMovementId!!!
     vbMovementId_to:= (SELECT Movement.ParentId FROM Movement WHERE Movement.Id = inMovementId);
     vbOperDate_to:= (SELECT Movement.OperDate FROM Movement WHERE Movement.Id = vbMovementId_to);
     --
     SELECT MovementLinkObject_To.ObjectId                   AS UnitId
          , ObjectLink_UnitTo_Juridical.ChildObjectId        AS JuridicalId_Basis
          , ObjectLink_UnitTo_AccountDirection.ChildObjectId AS AccountDirectionId_To
            INTO vbUnitId, vbJuridicalId_Basis, vbAccountDirectionId_To
     FROM MovementLinkObject AS MovementLinkObject_To
          LEFT JOIN ObjectLink AS ObjectLink_UnitTo_Juridical
                               ON ObjectLink_UnitTo_Juridical.ObjectId = MovementLinkObject_To.ObjectId
                              AND ObjectLink_UnitTo_Juridical.DescId   = zc_ObjectLink_Unit_Juridical()
          LEFT JOIN ObjectLink AS ObjectLink_UnitTo_AccountDirection
                               ON ObjectLink_UnitTo_AccountDirection.ObjectId = MovementLinkObject_To.ObjectId
                              AND ObjectLink_UnitTo_AccountDirection.DescId = zc_ObjectLink_Unit_AccountDirection()
     WHERE MovementLinkObject_To.MovementId = vbMovementId_to
       AND MovementLinkObject_To.DescId     = zc_MovementLinkObject_To()
     ;


     -- ��������������, ��� � "�������" ��������� �� ���� "������� ������� ��������"
     IF vbMovementDescId_from = zc_Movement_TransportService() -- AND 1=0
     THEN
         PERFORM gpReComplete_Movement_TransportService (vbMovementId_from, inUserId :: TVarChar);
         --
         DROP TABLE _tmpItem;

     ELSEIF vbMovementDescId_from = zc_Movement_Transport() -- AND 1=0
     THEN
         PERFORM gpReComplete_Movement_Transport (vbMovementId_from, NULL, inUserId :: TVarChar);
         --
         DROP TABLE _tmpItem;

     END IF;
     
     -- ��������� ��������� ������� - ��� ������������ ������ ��� ��������
     PERFORM lpComplete_Movement_IncomeCost_CreateTemp();


     -- !!!�����������!!! �������� ������� ��������
     DELETE FROM _tmpMIContainer_insert;
     DELETE FROM _tmpMIReport_insert;



     -- ���������� ����� "������" - ���� ��� � ������� ��� ������� ������� ��������
     INSERT INTO _tmpItem_From (InfoMoneyId, OperSumm)
        -- ������� ������� ��������
        WITH tmpAccount AS (SELECT * FROM Object_Account_View WHERE Object_Account_View.AccountGroupId = zc_Enum_AccountGroup_50000())
        SELECT CLO_InfoMoney.ObjectId, SUM (MIContainer.Amount) AS Amount
        FROM MovementItemContainer AS MIContainer
             INNER JOIN tmpAccount ON tmpAccount.AccountId = MIContainer.AccountId
             LEFT JOIN ContainerLinkObject AS CLO_InfoMoney ON CLO_InfoMoney.ContainerId = MIContainer.ContainerId AND CLO_InfoMoney.DescId = zc_ContainerLinkObject_InfoMoney()
        WHERE MIContainer.MovementId = vbMovementId_from
          AND MIContainer.DescId     = zc_MIContainer_Summ()
        GROUP BY CLO_InfoMoney.ObjectId
        ;
     -- ���������� ��������� � ������� ���� ������������ "������"
     INSERT INTO _tmpItem_To (MovementId_cost, MovementId_in, InfoMoneyId, OperCount, OperSumm, OperSumm_calc)
        -- ������� ������� ��������
        SELECT Movement.Id AS MovementId_cost, Movement_Income.Id AS MovementId_in, _tmpItem_From.InfoMoneyId
               -- ���
             , SUM (CASE WHEN ObjectLink_Goods_Measure.ChildObjectId = zc_Measure_Sh()
                              THEN MovementItem.Amount * COALESCE (ObjectFloat_Weight.ValueData, 0)
                         ELSE MovementItem.Amount
                    END) AS OperCount
             , 0 /*MovementFloat_TotalSumm.ValueData*/ AS OperSumm
             , 0 AS OperSumm_calc
        FROM MovementFloat
             INNER JOIN Movement ON Movement.Id = MovementFloat.MovementId
                                AND (Movement.StatusId = zc_Enum_Status_Complete()
                                  OR Movement.Id       = inMovementId)
             INNER JOIN Movement AS Movement_Income ON Movement_Income.Id       = Movement.ParentId
                                                   AND Movement_Income.DescId   = zc_Movement_Income()
                                                   AND Movement_Income.StatusId = zc_Enum_Status_Complete()
             INNER JOIN MovementItem ON MovementItem.Id       = Movement_Income.Id
                                    AND MovementItem.DescId   = zc_MI_Master()
                                    AND MovementItem.isErased = FALSE
             LEFT JOIN ObjectFloat AS ObjectFloat_Weight
                                   ON ObjectFloat_Weight.ObjectId = MovementItem.ObjectId
                                  AND ObjectFloat_Weight.DescId = zc_ObjectFloat_Goods_Weight()
             LEFT JOIN ObjectLink AS ObjectLink_Goods_Measure
                                  ON ObjectLink_Goods_Measure.ObjectId = MovementItem.ObjectId
                                 AND ObjectLink_Goods_Measure.DescId = zc_ObjectLink_Goods_Measure()
             /*LEFT JOIN MovementFloat AS MovementFloat_TotalSumm
                                     ON MovementFloat_TotalSumm.MovementId = Movement_Income.Id
                                    AND MovementFloat_TotalSumm.DescId     = zc_MovementFloat_TotalSumm()*/
             CROSS JOIN _tmpItem_From
        WHERE MovementFloat.ValueData = vbMovementId_from
          AND MovementFloat.DescId    = zc_MovementFloat_MovementId()
        GROUP BY Movement.Id, Movement_Income.Id, _tmpItem_From.InfoMoneyId
        ;

     -- ������������� "������"
     UPDATE _tmpItem_To SET OperSumm_calc = tmp.OperSumm_calc
     FROM (WITH tmpItem_To_summ AS (SELECT _tmpItem_To.InfoMoneyId, SUM (_tmpItem_To.OperCount) AS OperCount FROM _tmpItem_To GROUP BY _tmpItem_To.InfoMoneyId)
                       , tmpRes AS (SELECT _tmpItem_To.MovementId_cost
                                         , _tmpItem_To.InfoMoneyId
                                         , CAST (_tmpItem_From.OperSumm * _tmpItem_To.OperCount / tmpItem_To_summ.OperCount AS Numeric(16, 2)) AS OperSumm_calc
                                           -- � �/�
                                         , ROW_NUMBER() OVER (PARTITION BY _tmpItem_To.InfoMoneyId ORDER BY _tmpItem_To.OperCount DESC) AS Ord
                                    FROM _tmpItem_To
                                         INNER JOIN tmpItem_To_summ ON tmpItem_To_summ.InfoMoneyId = _tmpItem_To.InfoMoneyId
                                                                   AND tmpItem_To_summ.OperCount   <> 0
                                         INNER JOIN _tmpItem_From   ON _tmpItem_From.InfoMoneyId    = _tmpItem_To.InfoMoneyId
                                   )
                       , tmpDiff AS (SELECT tmpRes_summ.InfoMoneyId
                                          , tmpRes_summ.OperSumm_calc - _tmpItem_From.OperSumm AS OperSumm_diff
                                    FROM (SELECT tmpRes.InfoMoneyId, SUM (tmpRes.OperSumm_calc) AS OperSumm_calc FROM tmpRes GROUP BY tmpRes.InfoMoneyId
                                         ) AS tmpRes_summ
                                         INNER JOIN _tmpItem_From ON _tmpItem_From.InfoMoneyId = tmpRes_summ.InfoMoneyId
                                    WHERE _tmpItem_From.OperSumm <> tmpRes_summ.OperSumm_calc
                                   )
           -- ���������
           SELECT tmpRes.MovementId_cost, tmpRes.InfoMoneyId, tmpRes.OperSumm_calc - COALESCE (tmpdiff.OperSumm_diff, 0) As OperSumm_calc
           FROM tmpRes
                LEFT JOIN tmpDiff ON tmpDiff.InfoMoneyId = tmpRes.InfoMoneyId
                                 AND                   1 = tmpRes.Ord
          ) AS tmp
     WHERE tmp.MovementId_cost = _tmpItem_To.MovementId_cost
       AND tmp.InfoMoneyId     = _tmpItem_To.InfoMoneyId
    ;

     -- ��������� ������������� "������" - !!!�� ��� zc_Movement_IncomeCost, ���� ��� ��������������!!!
     PERFORM lpInsertUpdate_MovementFloat (zc_MovementFloat_AmountCost(), tmp.MovementId_cost, tmp.OperSumm_calc)
     FROM (SELECT _tmpItem_To.MovementId_cost, SUM (_tmpItem_To.OperSumm_calc) AS OperSumm_calc FROM _tmpItem_To GROUP BY _tmpItem_To.MovementId_cost) AS tmp
    ;


     -- �������� ������ ��� !!!������!!! zc_Movement_IncomeCost = inMovementId
        WITH -- ������ �� �������, � ������� ����������� ����� "������"
             tmpMIContainer_all AS (SELECT MIContainer.*
                                    FROM MovementItemContainer AS MIContainer
                                    WHERE MIContainer.MovementId = vbMovementId_to
                                   )
            , tmpMIContainer AS (SELECT tmpMIContainer_Count.MovementItemId
                                      , tmpMIContainer_Count.ContainerId
                                      , tmpMIContainer_Count.ObjectId_Analyzer    AS GoodsId
                                      , tmpMIContainer_Count.ObjectIntId_Analyzer AS GoodsKindId
                                      , tmpMIContainer_Count.Amount
                                      , tmpMIContainer_Summ.OperSumm
                                 FROM tmpMIContainer_all AS tmpMIContainer_Count
                                      LEFT JOIN (SELECT tmpMIContainer_all.MovementItemId, SUM (tmpMIContainer_all.Amount) AS OperSumm FROM tmpMIContainer_all WHERE tmpMIContainer_all.DescId = zc_MIContainer_Summ() AND tmpMIContainer_all.Amount > 0 GROUP BY tmpMIContainer_all.MovementItemId
                                                ) AS tmpMIContainer_Summ
                                                  ON tmpMIContainer_Summ.MovementItemId = tmpMIContainer_Count.MovementItemId
                                 WHERE tmpMIContainer_Count.DescId = zc_MIContainer_Count()
                                   AND tmpMIContainer_Count.Amount > 0
                                )
             -- ������������� "������"
           , tmpItem_To_summ AS (SELECT SUM (tmpMIContainer.Amount) AS Amount FROM tmpMIContainer)
                    , tmpRes AS (SELECT tmpMIContainer.*
                                      , _tmpItem_To.InfoMoneyId
                                      , CAST (_tmpItem_To.OperSumm_calc * tmpMIContainer.Amount / tmpItem_To_summ.Amount AS Numeric(16, 2)) AS OperSumm_calc
                                        -- � �/�
                                      , ROW_NUMBER() OVER (PARTITION BY _tmpItem_To.InfoMoneyId ORDER BY tmpMIContainer.Amount DESC) AS Ord
                                 FROM tmpMIContainer
                                      INNER JOIN tmpItem_To_summ ON tmpItem_To_summ.Amount    <> 0
                                      INNER JOIN _tmpItem_To     ON _tmpItem_To.MovementId_cost = inMovementId
                                )
                       , tmpDiff AS (SELECT tmpRes_summ.InfoMoneyId
                                          , tmpRes_summ.OperSumm_calc - _tmpItem_To.OperSumm_calc AS OperSumm_diff
                                    FROM (SELECT tmpRes.InfoMoneyId, SUM (tmpRes.OperSumm_calc) AS OperSumm_calc FROM tmpRes GROUP BY tmpRes.InfoMoneyId
                                         ) AS tmpRes_summ
                                         INNER JOIN _tmpItem_To ON _tmpItem_To.InfoMoneyId = tmpRes_summ.InfoMoneyId
                                    WHERE _tmpItem_To.OperSumm_calc <> tmpRes_summ.OperSumm_calc
                                   )
     INSERT INTO _tmpItem (MovementItemId, ContainerId_Goods, ContainerId_summ
                         , GoodsId, GoodsKindId
                         , OperCount, OperSumm, OperSumm_calc
                         , AccountId, InfoMoneyGroupId, InfoMoneyDestinationId, InfoMoneyId, InfoMoneyId_Detail
                         , isPartionCount, isPartionSumm
                         , PartionGoodsId
                          )
           -- ���������
           SELECT tmpRes.MovementItemId
                , tmpRes.ContainerId                                         AS ContainerId_Goods
                , 0                                                          AS ContainerId_summ
                , tmpRes.GoodsId                                             AS GoodsId
                , tmpRes.GoodsKindId                                         AS GoodsKindId
                , tmpRes.Amount                                              AS OperCount
                , tmpRes.OperSumm                                            AS OperSumm
                , tmpRes.OperSumm_calc - COALESCE (tmpdiff.OperSumm_diff, 0) AS OperSumm_calc
                , 0                                                          AS AccountId
                , View_InfoMoney.InfoMoneyGroupId                            AS InfoMoneyGroupId
                , View_InfoMoney.InfoMoneyDestinationId                      AS InfoMoneyDestinationId
                , View_InfoMoney.InfoMoneyId                                 AS InfoMoneyId
                , tmpRes.InfoMoneyId                                         AS InfoMoneyId_Detail
                , COALESCE (ObjectBoolean_PartionCount.ValueData, FALSE)     AS isPartionCount
                , COALESCE (ObjectBoolean_PartionSumm.ValueData, FALSE)      AS isPartionSumm
                , CLO_PartionGoods.ObjectId                                  As PartionGoodsId
           FROM tmpRes
                LEFT JOIN tmpDiff ON tmpDiff.InfoMoneyId = tmpRes.InfoMoneyId
                                 AND                   1 = tmpRes.Ord
                LEFT JOIN ContainerLinkObject AS CLO_PartionGoods
                                              ON CLO_PartionGoods.ContainerId = tmpRes.ContainerId
                                             AND CLO_PartionGoods.DescId      = zc_ContainerLinkObject_PartionGoods()
                LEFT JOIN ObjectLink AS ObjectLink_Goods_InfoMoney
                                     ON ObjectLink_Goods_InfoMoney.ObjectId = tmpRes.GoodsId
                                    AND ObjectLink_Goods_InfoMoney.DescId   = zc_ObjectLink_Goods_InfoMoney()
                LEFT JOIN Object_InfoMoney_View AS View_InfoMoney ON View_InfoMoney.InfoMoneyId = ObjectLink_Goods_InfoMoney.ChildObjectId
                LEFT JOIN ObjectBoolean AS ObjectBoolean_PartionCount
                                        ON ObjectBoolean_PartionCount.ObjectId = tmpRes.GoodsId
                                       AND ObjectBoolean_PartionCount.DescId   = zc_ObjectBoolean_Goods_PartionCount()
                LEFT JOIN ObjectBoolean AS ObjectBoolean_PartionSumm
                                        ON ObjectBoolean_PartionSumm.ObjectId  = tmpRes.GoodsId
                                       AND ObjectBoolean_PartionSumm.DescId    = zc_ObjectBoolean_Goods_PartionSumm()
          ;

     -- 1.3.1. ������������ ����(�����������) ��� �������� �� ��������� �����
     UPDATE _tmpItem SET AccountId = _tmpItem_byAccount.AccountId
     FROM (SELECT lpInsertFind_Object_Account (inAccountGroupId         := zc_Enum_AccountGroup_20000() -- ������
                                             , inAccountDirectionId     := vbAccountDirectionId_To
                                             , inInfoMoneyDestinationId := _tmpItem_group.InfoMoneyDestinationId
                                             , inInfoMoneyId            := NULL
                                             , inUserId                 := inUserId
                                              ) AS AccountId
                , _tmpItem_group.InfoMoneyDestinationId
           FROM (SELECT DISTINCT _tmpItem.InfoMoneyDestinationId FROM _tmpItem) AS _tmpItem_group
          ) AS _tmpItem_byAccount
     WHERE _tmpItem.InfoMoneyDestinationId = _tmpItem_byAccount.InfoMoneyDestinationId
     ;

     -- 1.3.2. ������������ ContainerId_Summ ��� �������� �� ��������� ����� + ����������� ��������� <������� �/�>
     UPDATE _tmpItem SET ContainerId_Summ = lpInsertUpdate_ContainerSumm_Goods (inOperDate               := vbOperDate_to
                                                                              , inUnitId                 := vbUnitId
                                                                              , inCarId                  := NULL
                                                                              , inMemberId               := NULL
                                                                              , inBranchId               := NULL -- ��� ��������� ����� ��� �������
                                                                              , inJuridicalId_basis      := vbJuridicalId_Basis
                                                                              , inBusinessId             := NULL
                                                                              , inAccountId              := _tmpItem.AccountId
                                                                              , inInfoMoneyDestinationId := _tmpItem.InfoMoneyDestinationId
                                                                              , inInfoMoneyId            := _tmpItem.InfoMoneyId
                                                                              , inInfoMoneyId_Detail     := _tmpItem.InfoMoneyId_Detail
                                                                              , inContainerId_Goods      := _tmpItem.ContainerId_Goods
                                                                              , inGoodsId                := _tmpItem.GoodsId
                                                                              , inGoodsKindId            := _tmpItem.GoodsKindId
                                                                              , inIsPartionSumm          := _tmpItem.isPartionSumm
                                                                              , inPartionGoodsId         := _tmpItem.PartionGoodsId
                                                                              , inAssetId                := NULL
                                                                               )
     ;



     -- �������� ����, �.�. � �������� ��� ������������� ���� ��������� � �������� ����������� �������
     UPDATE Movement SET OperDate = vbOperDate_to WHERE Movement.Id = inMovementId AND OperDate <> vbOperDate_to;


     -- 5.1. ����� - ����������� ��������� ��������
     PERFORM lpInsertUpdate_MovementItemContainer_byTable ();

     -- 5.2. ����� - ����������� ������ ������ ��������� + ��������� ��������
     PERFORM lpComplete_Movement (inMovementId := inMovementId
                                , inDescId     := zc_Movement_IncomeCost()
                                , inUserId     := inUserId
                                 );


     RAISE EXCEPTION 'OK';

END;$BODY$
  LANGUAGE plpgsql VOLATILE;

/*-------------------------------------------------------------------------------
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.
 13.01.19                                        *
*/

-- ����
-- SELECT * FROM lpComplete_Movement_IncomeCost ()
