-- Function: lpComplete_Movement_SendDebt (Integer, Integer)

DROP FUNCTION IF EXISTS lpComplete_Movement_SendDebt (Integer, Integer);

CREATE OR REPLACE FUNCTION lpComplete_Movement_SendDebt(
    IN inMovementId        Integer  , -- ���� ���������
    IN inUserId            Integer    -- ������������
)                              
RETURNS VOID
--  RETURNS TABLE (MovementItemId Integer, MovementId Integer, OperDate TDateTime, JuridicalId_From Integer, isCorporate Boolean, PersonalId_From Integer, UnitId Integer, BranchId_Unit Integer, PersonalId_Packer Integer, PaidKindId Integer, ContractId Integer, ContainerId_Goods Integer, GoodsId Integer, GoodsKindId Integer, AssetId Integer, PartionGoods TVarChar, OperCount TFloat, tmpOperSumm_Partner TFloat, OperSumm_Partner TFloat, tmpOperSumm_Packer TFloat, OperSumm_Packer TFloat, AccountDirectionId Integer, InfoMoneyDestinationId Integer, InfoMoneyId Integer, InfoMoneyDestinationId_isCorporate Integer, InfoMoneyId_isCorporate Integer, JuridicalId_basis Integer, BusinessId Integer, isPartionCount Boolean, isPartionSumm Boolean, PartionMovementId Integer, PartionGoodsId Integer)
AS
$BODY$
BEGIN

     -- !!!�����������!!! �������� ������� ��������
     DELETE FROM _tmpMIContainer_insert;
     DELETE FROM _tmpMIReport_insert;
     -- !!!�����������!!! �������� ������� - �������� ���������, �� ����� ���������� ��� ������������ �������� � ���������
     DELETE FROM _tmpItem;

     -- ��������� ������� - �������� ���������, �� ����� ���������� ��� ������������ �������� � ���������
     WITH tmpMovement AS (SELECT Movement.DescId, Movement.Id AS MovementId, Movement.OperDate
                          FROM Movement
                          WHERE Movement.Id = inMovementId
                            AND Movement.DescId = zc_Movement_SendDebt()
                            AND Movement.StatusId IN (zc_Enum_Status_UnComplete(), zc_Enum_Status_Erased())
                          )
     -- ������
     INSERT INTO _tmpItem (MovementDescId, OperDate, ObjectId, ObjectDescId, OperSumm, OperSumm_Currency
                         , MovementItemId, ContainerId
                         , AccountGroupId, AccountDirectionId, AccountId
                         , ProfitLossGroupId, ProfitLossDirectionId
                         , InfoMoneyGroupId, InfoMoneyDestinationId, InfoMoneyId
                         , BusinessId_Balance, BusinessId_ProfitLoss, JuridicalId_Basis
                         , UnitId, PositionId, BranchId_Balance, BranchId_ProfitLoss, ServiceDateId, ContractId, PaidKindId
                         , CurrencyId
                         , IsActive, IsMaster
                          )
        SELECT tmpMovement.DescId
             , tmpMovement.OperDate
             , COALESCE (MovementItem.ObjectId, 0) AS ObjectId
             , COALESCE (Object.DescId, 0) AS ObjectDescId

             , MovementItem.Amount AS OperSumm
             , CASE WHEN COALESCE (MILinkObject_Currency.ObjectId, zc_Enum_Currency_Basis()) <> zc_Enum_Currency_Basis() AND MIFloat_CurrencyValue.ValueData <> 0
                         THEN CAST (MovementItem.Amount / MIFloat_CurrencyValue.ValueData * MIFloat_ParValue.ValueData AS NUMERIC (16, 2))
                         ELSE 0
               END AS OperSumm_Currency

             , MovementItem.Id AS MovementItemId

             , 0 AS ContainerId                                                     -- ���������� �����
             , 0 AS AccountGroupId, 0 AS AccountDirectionId, 0 AS AccountId         -- ���������� �����
             , 0 AS ProfitLossGroupId, 0 AS ProfitLossDirectionId                   -- �� ������������

               -- �������������� ������ ����������
             , COALESCE (View_InfoMoney.InfoMoneyGroupId, 0) AS InfoMoneyGroupId
               -- �������������� ����������
             , COALESCE (View_InfoMoney.InfoMoneyDestinationId, 0) AS InfoMoneyDestinationId
               -- �������������� ������ ����������
             , COALESCE (View_InfoMoney.InfoMoneyId, 0) AS InfoMoneyId

               -- ������ ������: �� ������������
             , 0 AS BusinessId_Balance
               -- ������ ����: �� ������������
             , 0 AS BusinessId_ProfitLoss

               -- ������� ��.����: ������ �� ��������
             , COALESCE (ObjectLink_Contract_JuridicalBasis.ChildObjectId, 0) AS JuridicalId_Basis

             , 0 AS UnitId     -- �� ������������
             , 0 AS PositionId -- �� ������������

               -- ������ ������: ����� ��� ��� ������
             , MILinkObject_Branch.ObjectId AS BranchId_Balance
               -- ������ ����: �� ������������
             , 0 AS BranchId_ProfitLoss

               -- ����� ����������: �� ������������
             , 0 AS ServiceDateId

             , COALESCE (MILinkObject_Contract.ObjectId, 0) AS ContractId
             , COALESCE (MILinkObject_PaidKind.ObjectId, 0) AS PaidKindId

               -- ������
             , COALESCE (MILinkObject_Currency.ObjectId, zc_Enum_Currency_Basis()) AS CurrencyId

             , TRUE AS IsActive
             , TRUE AS IsMaster
        FROM tmpMovement
             JOIN MovementItem ON MovementItem.MovementId = tmpMovement.MovementId AND MovementItem.DescId = zc_MI_Master()

             LEFT JOIN MovementItemLinkObject AS MILinkObject_InfoMoney
                                              ON MILinkObject_InfoMoney.MovementItemId = MovementItem.Id
                                             AND MILinkObject_InfoMoney.DescId = zc_MILinkObject_InfoMoney()
             LEFT JOIN MovementItemLinkObject AS MILinkObject_Contract
                                              ON MILinkObject_Contract.MovementItemId = MovementItem.Id
                                             AND MILinkObject_Contract.DescId = zc_MILinkObject_Contract()
             LEFT JOIN MovementItemLinkObject AS MILinkObject_PaidKind
                                              ON MILinkObject_PaidKind.MovementItemId = MovementItem.Id
                                             AND MILinkObject_PaidKind.DescId = zc_MILinkObject_PaidKind()
             LEFT JOIN MovementItemLinkObject AS MILinkObject_Branch
                                              ON MILinkObject_Branch.MovementItemId = MovementItem.Id
                                             AND MILinkObject_Branch.DescId = zc_MILinkObject_Branch()

             LEFT JOIN MovementItemLinkObject AS MILinkObject_Currency
                                              ON MILinkObject_Currency.MovementItemId = MovementItem.Id
                                             AND MILinkObject_Currency.DescId         = zc_MILinkObject_Currency()
             LEFT JOIN MovementItemFloat AS MIFloat_CurrencyValue
                                         ON MIFloat_CurrencyValue.MovementItemId = MovementItem.Id
                                        AND MIFloat_CurrencyValue.DescId         = zc_MIFloat_CurrencyValue()
             LEFT JOIN MovementItemFloat AS MIFloat_ParValue
                                         ON MIFloat_ParValue.MovementItemId = MovementItem.Id
                                        AND MIFloat_ParValue.DescId         = zc_MIFloat_ParValue()

             LEFT JOIN Object ON Object.Id = MovementItem.ObjectId
             LEFT JOIN ObjectLink AS ObjectLink_Contract_JuridicalBasis ON ObjectLink_Contract_JuridicalBasis.ObjectId = MILinkObject_Contract.ObjectId
                                                                       AND ObjectLink_Contract_JuridicalBasis.DescId = zc_ObjectLink_Contract_JuridicalBasis()
             LEFT JOIN Object_InfoMoney_View AS View_InfoMoney ON View_InfoMoney.InfoMoneyId = MILinkObject_InfoMoney.ObjectId
       UNION ALL
        SELECT tmpMovement.DescId
             , tmpMovement.OperDate
             , COALESCE (MovementItem.ObjectId, 0) AS ObjectId
             , COALESCE (Object.DescId, 0) AS ObjectDescId

             , -1 * MovementItem.Amount AS OperSumm
             , -1 * CASE WHEN COALESCE (MILinkObject_Currency.ObjectId, zc_Enum_Currency_Basis()) <> zc_Enum_Currency_Basis() AND MIFloat_CurrencyValue.ValueData <> 0
                              THEN CAST (MovementItem.Amount / MIFloat_CurrencyValue.ValueData * MIFloat_ParValue.ValueData AS NUMERIC (16, 2))
                              ELSE 0
                    END AS OperSumm_Currency

             , MovementItem.Id AS MovementItemId

             , 0 AS ContainerId                                                     -- ���������� �����
             , 0 AS AccountGroupId, 0 AS AccountDirectionId, 0 AS AccountId         -- ���������� �����
             , 0 AS ProfitLossGroupId, 0 AS ProfitLossDirectionId                   -- �� ������������

               -- �������������� ������ ����������
             , COALESCE (View_InfoMoney.InfoMoneyGroupId, 0) AS InfoMoneyGroupId
               -- �������������� ����������
             , COALESCE (View_InfoMoney.InfoMoneyDestinationId, 0) AS InfoMoneyDestinationId
               -- �������������� ������ ����������
             , COALESCE (View_InfoMoney.InfoMoneyId, 0) AS InfoMoneyId

               -- ������ ������: �� ������������
             , 0 AS BusinessId_Balance
               -- ������ ����: �� ������������
             , 0 AS BusinessId_ProfitLoss

               -- ������� ��.����: ������ �� ��������
             , COALESCE (ObjectLink_Contract_JuridicalBasis.ChildObjectId, 0) AS JuridicalId_Basis

             , 0 AS UnitId     -- �� ������������
             , 0 AS PositionId -- �� ������������

               -- ������ ������: ����� ��� ��� ������
             , MILinkObject_Branch.ObjectId AS BranchId_Balance
               -- ������ ����: �� ������������
             , 0 AS BranchId_ProfitLoss

               -- ����� ����������: �� ������������
             , 0 AS ServiceDateId

             , COALESCE (MILinkObject_Contract.ObjectId, 0) AS ContractId
             , COALESCE (MILinkObject_PaidKind.ObjectId, 0) AS PaidKindId

               -- ������
             , COALESCE (MILinkObject_Currency.ObjectId, zc_Enum_Currency_Basis()) AS CurrencyId

             , FALSE AS IsActive
             , FALSE AS IsMaster
        FROM tmpMovement
             JOIN MovementItem ON MovementItem.MovementId = tmpMovement.MovementId AND MovementItem.DescId = zc_MI_Child()

             LEFT JOIN MovementItemLinkObject AS MILinkObject_InfoMoney
                                              ON MILinkObject_InfoMoney.MovementItemId = MovementItem.Id
                                             AND MILinkObject_InfoMoney.DescId = zc_MILinkObject_InfoMoney()
             LEFT JOIN MovementItemLinkObject AS MILinkObject_Contract
                                              ON MILinkObject_Contract.MovementItemId = MovementItem.Id
                                             AND MILinkObject_Contract.DescId = zc_MILinkObject_Contract()
             LEFT JOIN MovementItemLinkObject AS MILinkObject_PaidKind
                                              ON MILinkObject_PaidKind.MovementItemId = MovementItem.Id
                                             AND MILinkObject_PaidKind.DescId = zc_MILinkObject_PaidKind()
             LEFT JOIN MovementItemLinkObject AS MILinkObject_Branch
                                              ON MILinkObject_Branch.MovementItemId = MovementItem.Id
                                             AND MILinkObject_Branch.DescId = zc_MILinkObject_Branch()

             LEFT JOIN MovementItemLinkObject AS MILinkObject_Currency
                                              ON MILinkObject_Currency.MovementItemId = MovementItem.Id
                                             AND MILinkObject_Currency.DescId         = zc_MILinkObject_Currency()
             LEFT JOIN MovementItemFloat AS MIFloat_CurrencyValue
                                         ON MIFloat_CurrencyValue.MovementItemId = MovementItem.Id
                                        AND MIFloat_CurrencyValue.DescId         = zc_MIFloat_CurrencyValue()
             LEFT JOIN MovementItemFloat AS MIFloat_ParValue
                                         ON MIFloat_ParValue.MovementItemId = MovementItem.Id
                                        AND MIFloat_ParValue.DescId         = zc_MIFloat_ParValue()

             LEFT JOIN Object ON Object.Id = MovementItem.ObjectId
             LEFT JOIN ObjectLink AS ObjectLink_Contract_JuridicalBasis ON ObjectLink_Contract_JuridicalBasis.ObjectId = MILinkObject_Contract.ObjectId
                                                                       AND ObjectLink_Contract_JuridicalBasis.DescId = zc_ObjectLink_Contract_JuridicalBasis()

             LEFT JOIN Object_InfoMoney_View AS View_InfoMoney ON View_InfoMoney.InfoMoneyId = MILinkObject_InfoMoney.ObjectId
       ;

     -- ��������
     IF EXISTS (SELECT _tmpItem.ObjectId FROM _tmpItem WHERE _tmpItem.ObjectId = 0 AND _tmpItem.IsMaster = TRUE)
     THEN
         RAISE EXCEPTION '������.� ��������� �� ���������� <����������� ���� (�����)>.���������� ����������.';
     END IF;
     IF EXISTS (SELECT _tmpItem.JuridicalId_Basis FROM _tmpItem WHERE _tmpItem.JuridicalId_Basis = 0 AND _tmpItem.IsMaster = TRUE)
     THEN
         RAISE EXCEPTION '������.� <�������� (�����)> �� ����������� ������� �� ����.���������� ����������.';
     END IF;
     -- ��������
     IF EXISTS (SELECT _tmpItem.ObjectId FROM _tmpItem WHERE _tmpItem.ObjectId = 0 AND _tmpItem.IsMaster = FALSE)
     THEN
         RAISE EXCEPTION '������.� ��������� �� ���������� <����������� ���� (������)>.���������� ����������.';
     END IF;
     IF EXISTS (SELECT _tmpItem.JuridicalId_Basis FROM _tmpItem WHERE _tmpItem.JuridicalId_Basis = 0 AND _tmpItem.IsMaster = FALSE)
     THEN
         RAISE EXCEPTION '������.� <�������� (������)> �� ����������� ������� �� ����.���������� ����������.';
     END IF;

     -- 5.1. ����� - ���������/��������� ��������
     PERFORM lpComplete_Movement_Finance (inMovementId := inMovementId
                                        , inUserId     := inUserId);

     -- 5.2. ����� - ����������� ������ ������ ��������� + ��������� ��������
     PERFORM lpComplete_Movement (inMovementId := inMovementId
                                , inDescId     := zc_Movement_SendDebt()
                                , inUserId     := inUserId
                                 );

END;
$BODY$
  LANGUAGE plpgsql VOLATILE;

/*
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.   ������ �.
 12.09.14                                        * add PositionId and ServiceDateId and BusinessId_... and BranchId_...
 17.08.14                                        * add MovementDescId
 25.05.14                                        * add lpComplete_Movement
 10.05.14                                        * add lpInsert_MovementProtocol
 28.01.14                                        * all
 27.01.14         * 
*/

-- ����
-- SELECT * FROM gpUnComplete_Movement (inMovementId:= 103, inSession:= zfCalc_UserAdmin())
-- SELECT * FROM lpComplete_Movement_SendDebt (inMovementId:= 103, inUserId:= zfCalc_UserAdmin())
-- SELECT * FROM gpSelect_MovementItemContainer_Movement (inMovementId:= 103, inSession:= zfCalc_UserAdmin())
