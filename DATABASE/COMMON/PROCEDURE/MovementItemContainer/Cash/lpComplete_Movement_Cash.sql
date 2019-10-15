-- Function: lpComplete_Movement_Cash (Integer, Boolean)

DROP FUNCTION IF EXISTS lpComplete_Movement_Cash (Integer, Integer);

CREATE OR REPLACE FUNCTION lpComplete_Movement_Cash(
    IN inMovementId        Integer  , -- ���� ���������
    IN inUserId            Integer    -- ������������
)                              
RETURNS VOID
AS
$BODY$
   DECLARE vbServiceDate TDateTime;
   DECLARE vbOperDate_currency TDateTime;
   DECLARE vbPersonalServiceListId Integer;
   DECLARE vbPositionId Integer;
   DECLARE vbSumm_diff TFloat;
BEGIN
     -- ���������� <����� ����������:
     vbServiceDate:= (SELECT MovementDate.ValueData FROM MovementDate WHERE MovementDate.MovementId = (SELECT Movement.ParentId FROM Movement WHERE Movement.Id = inMovementId) AND MovementDate.DescId = zc_MovementDate_ServiceDate());
     
     -- ���������� 
   --vbOperDate_currency:= DATE_TRUNC ('MONTH', (SELECT Movement.OperDate FROM Movement WHERE Movement.Id = inMovementId)); -- + INTERVAL '1 MONTH';
     vbOperDate_currency:= (SELECT Movement.OperDate - INTERVAL '0 DAY' FROM Movement WHERE Movement.Id = inMovementId);


         -- ���� ������������ "�� �����������", ���������� - ������� �� �����
         SELECT ObjectLink_Personal_PersonalServiceList.ChildObjectId
              , ObjectLink_Personal_Position.ChildObjectId
                INTO vbPersonalServiceListId, vbPositionId
         FROM ObjectLink AS ObjectLink_Personal_PersonalServiceList
              LEFT JOIN ObjectLink AS ObjectLink_Personal_Position
                                   ON ObjectLink_Personal_Position.ObjectId = ObjectLink_Personal_PersonalServiceList.ObjectId
                                  AND ObjectLink_Personal_Position.DescId = zc_ObjectLink_Personal_Position()
         WHERE ObjectLink_Personal_PersonalServiceList.ObjectId = (SELECT MovementItemLinkObject.ObjectId
                                                                                              FROM MovementItem
                                                                                                   LEFT JOIN MovementItemLinkObject
                                                                                                          ON MovementItemLinkObject.MovementItemId = MovementItem.Id
                                                                                                         AND MovementItemLinkObject.DescId = zc_MILinkObject_MoneyPlace()
                                                                                              WHERE MovementItem.MovementId = inMovementId
                                                                                                AND MovementItem.DescId = zc_MI_Master()
                                                                                             )
                                      AND ObjectLink_Personal_PersonalServiceList.DescId = zc_ObjectLink_Personal_PersonalServiceList()
        ;
         -- !!!��������!!! - ��������� ����� � <��������� ����������> + <���������>
         IF vbPersonalServiceListId <> 0
            AND (EXISTS (SELECT 1
                        FROM MovementItem
                             INNER JOIN MovementItemLinkObject AS MILO
                                                               ON MILO.MovementItemId = MovementItem.Id
                                                              AND MILO.DescId         = zc_MILinkObject_InfoMoney()
                                                              AND MILO.ObjectId       = zc_Enum_InfoMoney_60101() -- ���������� �����
                        WHERE MovementItem.MovementId = inMovementId
                          AND MovementItem.DescId     = zc_MI_Master()
                       )
              OR vbServiceDate >= '01.01.2019'
                )
         THEN
             --
             PERFORM lpInsertUpdate_MovementLinkObject (zc_MovementLinkObject_PersonalServiceList(), inMovementId, vbPersonalServiceListId);
             --
             PERFORM lpInsertUpdate_MovementItemLinkObject (zc_MILinkObject_Position(), MovementItem.Id, vbPositionId)
             FROM MovementItem
             WHERE MovementItem.MovementId = inMovementId
               AND MovementItem.DescId = zc_MI_Master();
        END IF;



     -- !!!����������� �������� <����� ����������> � ��������� ���������!!!
     PERFORM lpInsertUpdate_MovementItemDate (zc_MIDate_ServiceDate(), MovementItem.Id, vbServiceDate)
     FROM MovementItem
     WHERE MovementItem.MovementId = inMovementId AND MovementItem.DescId = zc_MI_Child();


     -- !!!�����������!!! �������� ������� ��������
     DELETE FROM _tmpMIContainer_insert;
     DELETE FROM _tmpMIReport_insert;
     -- !!!�����������!!! �������� ������� - �������� ���������, �� ����� ���������� ��� ������������ �������� � ���������
     DELETE FROM _tmpItem;

     -- 1.1. ��������� ������� - �������� ���������, �� ����� ���������� ��� ������������ �������� � ���������
     INSERT INTO _tmpItem (MovementDescId, OperDate, ObjectId, ObjectDescId, OperSumm, OperSumm_Currency
                         , MovementItemId, ContainerId
                         , AccountGroupId, AccountDirectionId, AccountId
                         , ProfitLossGroupId, ProfitLossDirectionId
                         , InfoMoneyGroupId, InfoMoneyDestinationId, InfoMoneyId
                         , BusinessId_Balance, BusinessId_ProfitLoss, JuridicalId_Basis
                         , UnitId, PositionId, PersonalServiceListId, BranchId_Balance, BranchId_ProfitLoss, ServiceDateId, ContractId, PaidKindId
                         , PartionMovementId
                         , AnalyzerId
                         , CurrencyId
                         , CarId
                         , IsActive, IsMaster
                          )
        SELECT Movement.DescId
             , Movement.OperDate
             , COALESCE (MovementItem.ObjectId, 0) AS ObjectId
             , COALESCE (Object.DescId, 0) AS ObjectDescId
             , MovementItem.Amount AS OperSumm
             , COALESCE (MovementFloat_AmountCurrency.ValueData, 0) AS OperSumm_Currency
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

               -- ������ ������: ������ �� �����
             , COALESCE (ObjectLink_Cash_Business.ChildObjectId, 0) AS BusinessId_Balance
               -- ������ ����: �� ������������
             , 0 AS BusinessId_ProfitLoss

               -- ������� ��.���� ������ �� �����
             , COALESCE (ObjectLink_Cash_JuridicalBasis.ChildObjectId, 0) AS JuridicalId_Basis

             , 0 AS UnitId                -- �� ������������
             , 0 AS PositionId            -- �� ������������
             , 0 AS PersonalServiceListId -- �� ������������

               -- ������ ������: �� ������������
             , 0 AS BranchId_Balance
               -- ������ ����: �� ������������
             , 0 AS BranchId_ProfitLoss

               -- ����� ����������: �� ������������
             , 0 AS ServiceDateId

             , 0 AS ContractId -- �� ������������
             , COALESCE (ObjectLink_Cash_PaidKind.ChildObjectId, zc_Enum_PaidKind_SecondForm()) AS PaidKindId -- !!!�� ������ ���!!!, �� ��� ���� �������� ���� �� ������������

             , 0 PartionMovementId -- �� ������������

             , 0 AS AnalyzerId

               -- ������
             , COALESCE (MILinkObject_Currency.ObjectId, zc_Enum_Currency_Basis()) AS CurrencyId
             
             , 0 AS CarId

             , CASE WHEN MovementItem.Amount >= 0 THEN TRUE ELSE FALSE END AS IsActive
             , TRUE AS IsMaster

        FROM Movement
             INNER JOIN MovementItem ON MovementItem.MovementId = Movement.Id AND MovementItem.DescId = zc_MI_Master()

             LEFT JOIN MovementFloat AS MovementFloat_AmountCurrency
                                     ON MovementFloat_AmountCurrency.MovementId = Movement.Id
                                    AND MovementFloat_AmountCurrency.DescId = zc_MovementFloat_AmountCurrency()
             LEFT JOIN MovementItemLinkObject AS MILinkObject_InfoMoney
                                              ON MILinkObject_InfoMoney.MovementItemId = MovementItem.Id
                                             AND MILinkObject_InfoMoney.DescId = zc_MILinkObject_InfoMoney()
             LEFT JOIN MovementItemLinkObject AS MILinkObject_Currency
                                              ON MILinkObject_Currency.MovementItemId = MovementItem.Id
                                             AND MILinkObject_Currency.DescId = zc_MILinkObject_Currency()

             LEFT JOIN Object ON Object.Id = MovementItem.ObjectId
             LEFT JOIN ObjectLink AS ObjectLink_Cash_JuridicalBasis ON ObjectLink_Cash_JuridicalBasis.ObjectId = MovementItem.ObjectId
                                                                   AND ObjectLink_Cash_JuridicalBasis.DescId = zc_ObjectLink_Cash_JuridicalBasis()
             LEFT JOIN ObjectLink AS ObjectLink_Cash_Business ON ObjectLink_Cash_Business.ObjectId = MovementItem.ObjectId
                                                             AND ObjectLink_Cash_Business.DescId = zc_ObjectLink_Cash_Business()
             LEFT JOIN ObjectLink AS ObjectLink_Cash_PaidKind
                                  ON ObjectLink_Cash_PaidKind.ObjectId = MovementItem.ObjectId
                                 AND ObjectLink_Cash_PaidKind.DescId = zc_ObjectLink_Cash_PaidKind()
             LEFT JOIN Object_InfoMoney_View AS View_InfoMoney ON View_InfoMoney.InfoMoneyId = MILinkObject_InfoMoney.ObjectId
        WHERE Movement.Id = inMovementId
          AND Movement.DescId = zc_Movement_Cash()
          AND Movement.StatusId IN (zc_Enum_Status_UnComplete(), zc_Enum_Status_Erased())
       ;


     -- ��������
     IF EXISTS (SELECT _tmpItem.ObjectId FROM _tmpItem WHERE _tmpItem.ObjectId = 0)
     THEN
         RAISE EXCEPTION '� ��������� �� ���������� �����. ���������� ����������.';
     END IF;
   
     -- ��������
     IF EXISTS (SELECT _tmpItem.JuridicalId_Basis FROM _tmpItem WHERE _tmpItem.JuridicalId_Basis = 0)
     THEN
         RAISE EXCEPTION '� ����� �� ����������� ������� �� ����. ���������� ����������.';
     END IF;

     -- ��������
     IF EXISTS (SELECT 1 FROM _tmpItem WHERE _tmpItem.OperSumm = 0)
     THEN
         RAISE EXCEPTION '������.������� �����.';
     END IF;

     -- 1.2. ��������� ������� - �������� ���������, �� ����� ���������� ��� ������������ �������� � ���������
     WITH tmpMI_Child AS (SELECT MI.*, COALESCE (MIB.ValueData, FALSE) AS isCalculated FROM MovementItem AS MI LEFT JOIN MovementItemBoolean AS MIB ON MIB.MovementItemId = MI.Id AND MIB.DescId = zc_MIBoolean_Calculated() WHERE MI.MovementId = inMovementId AND MI.DescId = zc_MI_Child() AND MI.isErased = FALSE)
     INSERT INTO _tmpItem (MovementDescId, OperDate, ObjectId, ObjectDescId, OperSumm, OperSumm_Currency
                         , MovementItemId, ContainerId
                         , AccountGroupId, AccountDirectionId, AccountId
                         , ProfitLossGroupId, ProfitLossDirectionId
                         , InfoMoneyGroupId, InfoMoneyDestinationId, InfoMoneyId
                         , BusinessId_Balance, BusinessId_ProfitLoss, JuridicalId_Basis
                         , UnitId, PositionId, PersonalServiceListId, BranchId_Balance, BranchId_ProfitLoss, ServiceDateId, ContractId, PaidKindId
                         , PartionMovementId
                         , AnalyzerId
                         , CurrencyId
                         , CarId
                         , IsActive, IsMaster
                          )
        SELECT _tmpItem.MovementDescId
             , _tmpItem.OperDate
             , COALESCE (MI_Child.ObjectId, COALESCE (ObjectLink_Founder_InfoMoney.ObjectId, COALESCE (MILinkObject_MoneyPlace.ObjectId, 0))) AS ObjectId
             , COALESCE (Object.DescId, 0)                        AS ObjectDescId
             , COALESCE (MI_Child.Amount, -1 * _tmpItem.OperSumm) AS OperSumm
             , CASE WHEN Object.DescId IN (zc_Object_Juridical(), zc_Object_Partner()) AND COALESCE (MILinkObject_CurrencyPartner.ObjectId, zc_Enum_Currency_Basis()) <> zc_Enum_Currency_Basis()
                         THEN -1 * _tmpItem.OperSumm_Currency
                    ELSE 0
               END AS OperSumm_Currency
             , COALESCE (MI_Child.Id, _tmpItem.MovementItemId)    AS MovementItemId

             , 0 AS ContainerId                                               -- ���������� �����
             , 0 AS AccountGroupId, 0 AS AccountDirectionId                   -- ���������� �����
             , CASE WHEN Object.DescId IN (zc_Object_Cash()) AND _tmpItem.ObjectId <> COALESCE (MILinkObject_MoneyPlace.ObjectId, 0)
                     -- AND _tmpItem.CurrencyId <> COALESCE (MILinkObject_CurrencyPartner.ObjectId, zc_Enum_Currency_Basis())
                         THEN zc_Enum_Account_110201() -- ������� + ������ � ����
                    WHEN Object.DescId IN (zc_Object_BankAccount())
                         THEN zc_Enum_Account_110301() -- ������� + ��������� ����
                    ELSE 0
               END AS AccountId -- ... ��� ���������� �����

               -- ������ ����
             , COALESCE (lfObject_Unit_byProfitLossDirection.ProfitLossGroupId, 0) AS ProfitLossGroupId
               -- ��������� ���� - �����������
             , COALESCE (lfObject_Unit_byProfitLossDirection.ProfitLossDirectionId, 0) AS ProfitLossDirectionId

               -- �������������� ������ ����������
             , _tmpItem.InfoMoneyGroupId
               -- �������������� ����������
             , _tmpItem.InfoMoneyDestinationId
               -- �������������� ������ ����������
             , _tmpItem.InfoMoneyId

               -- ������ ������: ������ �� �����
             , _tmpItem.BusinessId_Balance
               -- ������ ����: ObjectLink_Unit_Business
             , CASE WHEN _tmpItem.InfoMoneyId = zc_Enum_InfoMoney_21502() -- ������������� + ��������� + ������ �� ������ �����
                              -- ����� �����������
                         THEN (SELECT Object.Id FROM Object WHERE Object.DescId = zc_Object_Business() AND Object.ObjectCode = 2) -- ����
                    ELSE COALESCE (ObjectLink_Unit_Business.ChildObjectId, 0)
               END AS BusinessId_ProfitLoss

               -- ������� ��.���� ������ �� �����
             , _tmpItem.JuridicalId_Basis

             , COALESCE (MILinkObject_Unit.ObjectId, 0)     AS UnitId
             , COALESCE (MILinkObject_Position.ObjectId, 0) AS PositionId
             , CASE WHEN MI_Child.Id > 0
                         THEN COALESCE (ObjectLink_Personal_PersonalServiceList.ChildObjectId, COALESCE (MILinkObject_MoneyPlace.ObjectId, 0))
                    ELSE COALESCE (MLO_PersonalServiceList.ObjectId, 0)
               END AS PersonalServiceListId

               -- ������ ������: ������ �� ����� (����� ��� ��� ������ ��� ������ ���������) !!!�� ��� �� - ��� � �����������!!!
             , CASE WHEN MI_Child.Id > 0
                         THEN COALESCE (ObjectLink_Unit_Branch.ChildObjectId, zc_Branch_Basis())
                    -- ELSE COALESCE (ObjectLink_Partner_Branch.ChildObjectId, COALESCE (ObjectLink_MoneyPlace_Branch.ChildObjectId, COALESCE (ObjectLink_Cash_Branch.ChildObjectId, zc_Branch_Basis())))
                    ELSE COALESCE (ObjectLink_Cash_Branch.ChildObjectId, zc_Branch_Basis())
               END AS BranchId_Balance
               -- ������ ����: ������ �� ������������� !!!�� ��� ������� �� - �� ������������!!!
             , CASE WHEN MI_Child.Id > 0
                         THEN 0
                    ELSE COALESCE (ObjectLink_Unit_Branch.ChildObjectId, 0)
               END AS BranchId_ProfitLoss

               -- ����� ����������: ����
             , CASE WHEN _tmpItem.InfoMoneyGroupId = zc_Enum_InfoMoneyGroup_60000() -- ���������� �����
                         THEN lpInsertFind_Object_ServiceDate (inOperDate:= MIDate_ServiceDate.ValueData)
                    ELSE 0
               END AS ServiceDateId

             , COALESCE (MILinkObject_Contract.ObjectId, 0) AS ContractId

             , CASE WHEN -- ���� ���������� - "���������" + ��� ������ � ����� - "���������"
                         ObjectLink_Partner_Unit.ChildObjectId > 0
                     AND ObjectLink_Cash_Business.ChildObjectId > 0
                         -- !!!�������� �� ���!!!
                         THEN zc_Enum_PaidKind_SecondForm()

                    WHEN  _tmpItem.InfoMoneyGroupId = zc_Enum_InfoMoneyGroup_70000() -- ����������
                      AND ObjectLink_Contract_PaidKind.ChildObjectId > 0
                         -- !!!�������� �� ��!!!
                         THEN ObjectLink_Contract_PaidKind.ChildObjectId

                    ELSE _tmpItem.PaidKindId -- !!!�� ������ ���!!!

               END AS PaidKindId

             , CASE WHEN ObjectBoolean_PartionDoc.ValueData = TRUE
                         THEN lpInsertFind_Object_PartionMovement (MIFloat_MovementId.ValueData :: Integer, NULL)
                    ELSE 0
               END AS PartionMovementId

             , CASE WHEN MI_Child.Id > 0 AND MI_Child.isCalculated = TRUE
                         THEN zc_Enum_AnalyzerId_Cash_PersonalCardSecond() -- ������� ���������� - �� ��������� ����� �� 2�.
                    WHEN MI_Child.Id > 0
                         THEN zc_Enum_AnalyzerId_Cash_PersonalService() -- ������� ���������� - �� ���������
                    WHEN Object.DescId = zc_Object_Personal()
                         THEN zc_Enum_AnalyzerId_Cash_PersonalAvance() -- ������� ���������� - �����
                    ELSE 0
               END AS AnalyzerId

               -- ������
             , COALESCE (MILinkObject_CurrencyPartner.ObjectId, zc_Enum_Currency_Basis()) AS CurrencyId

             , MILinkObject_Car.ObjectId AS CarId

             , NOT _tmpItem.IsActive
             , NOT _tmpItem.IsMaster
        FROM _tmpItem
             LEFT JOIN tmpMI_Child AS MI_Child ON MI_Child.MovementId = inMovementId
                                               -- AND MI_Child.DescId = zc_MI_Child()
                                               -- AND MI_Child.isErased = FALSE

             LEFT JOIN MovementLinkObject AS MLO_PersonalServiceList
                                          ON MLO_PersonalServiceList.MovementId = inMovementId
                                         AND MLO_PersonalServiceList.DescId = zc_MovementLinkObject_PersonalServiceList()

             LEFT JOIN MovementItemFloat AS MIFloat_MovementId
                                         ON MIFloat_MovementId.MovementItemId = _tmpItem.MovementItemId
                                        AND MIFloat_MovementId.DescId = zc_MIFloat_MovementId()

             LEFT JOIN MovementItemDate AS MIDate_ServiceDate
                                        ON MIDate_ServiceDate.MovementItemId = COALESCE (MI_Child.Id, _tmpItem.MovementItemId)
                                       AND MIDate_ServiceDate.DescId = zc_MIDate_ServiceDate()

             LEFT JOIN MovementItemLinkObject AS MILinkObject_MoneyPlace
                                              ON MILinkObject_MoneyPlace.MovementItemId = _tmpItem.MovementItemId
                                             AND MILinkObject_MoneyPlace.DescId = zc_MILinkObject_MoneyPlace()
             LEFT JOIN MovementItemLinkObject AS MILinkObject_Unit
                                              ON MILinkObject_Unit.MovementItemId = COALESCE (MI_Child.Id, _tmpItem.MovementItemId)
                                             AND MILinkObject_Unit.DescId = zc_MILinkObject_Unit()
             LEFT JOIN MovementItemLinkObject AS MILinkObject_Contract
                                              ON MILinkObject_Contract.MovementItemId = _tmpItem.MovementItemId
                                             AND MILinkObject_Contract.DescId = zc_MILinkObject_Contract()
             LEFT JOIN MovementItemLinkObject AS MILinkObject_Position
                                              ON MILinkObject_Position.MovementItemId = COALESCE (MI_Child.Id, _tmpItem.MovementItemId)
                                             AND MILinkObject_Position.DescId = zc_MILinkObject_Position()

             LEFT JOIN MovementItemLinkObject AS MILinkObject_Car
                                              ON MILinkObject_Car.MovementItemId = _tmpItem.MovementItemId
                                             AND MILinkObject_Car.DescId = zc_MILinkObject_Car()

             LEFT JOIN MovementItemLinkObject AS MILinkObject_CurrencyPartner
                                              ON MILinkObject_CurrencyPartner.MovementItemId = _tmpItem.MovementItemId
                                             AND MILinkObject_CurrencyPartner.DescId = zc_MILinkObject_CurrencyPartner()

             /*LEFT JOIN ObjectLink AS ObjectLink_MoneyPlace_Branch ON ObjectLink_MoneyPlace_Branch.ObjectId = MILinkObject_MoneyPlace.ObjectId
                                                                 AND ObjectLink_MoneyPlace_Branch.DescId = zc_ObjectLink_Unit_Branch() -- !!!�� ������!!!*/

             LEFT JOIN ObjectLink AS ObjectLink_Contract_PaidKind
                                  ON ObjectLink_Contract_PaidKind.ObjectId = MILinkObject_Contract.ObjectId
                                 AND ObjectLink_Contract_PaidKind.DescId   = zc_ObjectLink_Contract_PaidKind()
             LEFT JOIN ObjectLink AS ObjectLink_Founder_InfoMoney
                                  ON ObjectLink_Founder_InfoMoney.ChildObjectId = _tmpItem.InfoMoneyId
                                 AND ObjectLink_Founder_InfoMoney.DescId = zc_ObjectLink_Founder_InfoMoney()

             LEFT JOIN Object ON Object.Id = COALESCE (MI_Child.ObjectId, COALESCE (ObjectLink_Founder_InfoMoney.ObjectId, MILinkObject_MoneyPlace.ObjectId))

             LEFT JOIN ObjectLink AS ObjectLink_Unit_Business ON ObjectLink_Unit_Business.ObjectId = MILinkObject_Unit.ObjectId
                                                             AND ObjectLink_Unit_Business.DescId = zc_ObjectLink_Unit_Business()
             LEFT JOIN ObjectLink AS ObjectLink_Unit_Branch ON ObjectLink_Unit_Branch.ObjectId = MILinkObject_Unit.ObjectId
                                                           AND ObjectLink_Unit_Branch.DescId = zc_ObjectLink_Unit_Branch()
             LEFT JOIN ObjectLink AS ObjectLink_Cash_Branch ON ObjectLink_Cash_Branch.ObjectId = _tmpItem.ObjectId
                                                           AND ObjectLink_Cash_Branch.DescId = zc_ObjectLink_Cash_Branch()
             LEFT JOIN ObjectLink AS ObjectLink_Cash_Business ON ObjectLink_Cash_Business.ObjectId = _tmpItem.ObjectId
                                                             AND ObjectLink_Cash_Business.DescId   = zc_ObjectLink_Cash_Business()
             LEFT JOIN ObjectBoolean AS ObjectBoolean_PartionDoc
                                     ON ObjectBoolean_PartionDoc.ObjectId = ObjectLink_Cash_Branch.ChildObjectId
                                    AND ObjectBoolean_PartionDoc.DescId = zc_ObjectBoolean_Branch_PartionDoc()


             /*LEFT JOIN ObjectLink AS ObjectLink_Partner_Branch ON ObjectLink_Partner_Branch.ObjectId = MILinkObject_MoneyPlace.ObjectId
                                                              AND ObjectLink_Partner_Branch.DescId = zc_ObjectLink_Unit_Branch() -- !!!�� ������!!!*/
             LEFT JOIN lfSelect_Object_Unit_byProfitLossDirection() AS lfObject_Unit_byProfitLossDirection ON lfObject_Unit_byProfitLossDirection.UnitId = MILinkObject_Unit.ObjectId
                                                                                                          AND Object.Id IS NULL -- !!!����� ������ ��� ������!!!
             LEFT JOIN ObjectLink AS ObjectLink_Partner_Unit ON ObjectLink_Partner_Unit.ObjectId = MILinkObject_MoneyPlace.ObjectId
                                                            AND ObjectLink_Partner_Unit.DescId = zc_ObjectLink_Partner_Unit()
             -- ������
             LEFT JOIN ObjectLink AS ObjectLink_Personal_PersonalServiceListCardSecond
                                  ON ObjectLink_Personal_PersonalServiceListCardSecond.ObjectId      = MI_Child.ObjectId
                                 AND ObjectLink_Personal_PersonalServiceListCardSecond.ChildObjectId = MILinkObject_MoneyPlace.ObjectId
                                 AND ObjectLink_Personal_PersonalServiceListCardSecond.DescId        = zc_ObjectLink_Personal_PersonalServiceListCardSecond()
             LEFT JOIN ObjectLink AS ObjectLink_Personal_PersonalServiceList
                                  ON ObjectLink_Personal_PersonalServiceList.ObjectId = ObjectLink_Personal_PersonalServiceListCardSecond.ObjectId
                                 AND ObjectLink_Personal_PersonalServiceList.DescId   = zc_ObjectLink_Personal_PersonalServiceList()
       ;

     -- ��������
     IF EXISTS (SELECT 1 FROM _tmpItem WHERE _tmpItem.IsMaster = FALSE AND _tmpItem.ObjectDescId = 0)
        AND EXISTS (SELECT 1 FROM ObjectBoolean
                    WHERE ObjectBoolean.DescId = zc_ObjectBoolean_InfoMoney_ProfitLoss()
                      AND ObjectBoolean.ValueData = FALSE
                      AND ObjectBoolean.ObjectId  = (SELECT _tmpItem.InfoMoneyId FROM _tmpItem WHERE _tmpItem.IsMaster = FALSE AND _tmpItem.ObjectDescId = 0 AND _tmpItem.InfoMoneyId > 0 LIMIT 1)
                    )
     THEN
         RAISE EXCEPTION '������.��� ������ <%> ������ ��������� ������� �� ������.���������� ��������� <�� ����, ����>.'
                        , lfGet_Object_ValueData_sh ((SELECT _tmpItem.InfoMoneyId FROM _tmpItem WHERE _tmpItem.IsMaster = FALSE AND _tmpItem.ObjectDescId = 0 AND _tmpItem.InfoMoneyId > 0 LIMIT 1))
                         ;
     END IF;


     -- !!!�������� �������!!!
     vbSumm_diff:= (WITH tmpItem AS (SELECT _tmpItem.ObjectId AS CashId, _tmpItem.CurrencyId, _tmpItem.OperSumm, _tmpItem.OperSumm_Currency, _tmpItem.OperDate
                                     FROM _tmpItem
                                     WHERE _tmpItem.IsMaster          = TRUE
                                       AND _tmpItem.OperSumm_Currency <> 0
                                    )
                      -- �������� �����, �� ��� - ����
                    , tmpSumm AS (SELECT SUM (tmp.OperSumm_Currency) AS OperSumm_Currency
                                       , SUM (tmp.OperSumm)          AS OperSumm
                                  FROM (-- ������� ����� �� ���� � ������
                                        SELECT tmpContainer.ContainerId
                                             , tmpContainer.AccountId
                                             , tmpContainer.Amount - COALESCE (SUM (MIContainer.Amount), 0) AS OperSumm_Currency
                                             , 0                                                            AS OperSumm
                                        FROM (SELECT Container.ParentId AS ContainerId
                                                   , Container.Id       AS ContainerId_Currency
                                                   , Container.ObjectId AS AccountId
                                                   , Container.Amount
                                                   , tmpItem.OperDate
                                              FROM tmpItem
                                                   INNER JOIN ContainerLinkObject AS CLO_Currency
                                                                                  ON CLO_Currency.ObjectId = tmpItem.CurrencyId
                                                                                 AND CLO_Currency.DescId   = zc_ContainerLinkObject_Currency()
                                                   INNER JOIN Container ON Container.Id     = CLO_Currency.ContainerId
                                                                       AND Container.DescId = zc_Container_SummCurrency()
                                                   INNER JOIN Object_Account_View AS View_Account
                                                                                  ON View_Account.AccountId      = Container.ObjectId
                                                                                 AND View_Account.AccountGroupId = zc_Enum_AccountGroup_40000() -- �������� �������� 
                                                   INNER JOIN ContainerLinkObject AS CLO_Cash
                                                                                  ON CLO_Cash.ContainerId = CLO_Currency.ContainerId
                                                                                 AND CLO_Cash.DescId      = zc_ContainerLinkObject_Cash()
                                                                                 AND CLO_Cash.ObjectId    = tmpItem.CashId
                                             ) AS tmpContainer
                                             LEFT JOIN MovementItemContainer AS MIContainer
                                                                             ON MIContainer.Containerid = tmpContainer.ContainerId_Currency
                                                                            AND MIContainer.OperDate    >= vbOperDate_currency
                                        GROUP BY tmpContainer.ContainerId
                                               , tmpContainer.ContainerId_Currency
                                               , tmpContainer.AccountId
                                               , tmpContainer.Amount
                                       UNION ALL
                                        -- ������� ����� �� ���� � ���
                                        SELECT tmpContainer.ContainerId
                                             , tmpContainer.AccountId
                                             , 0                                                            AS OperSumm_Currency
                                             , tmpContainer.Amount - COALESCE (SUM (MIContainer.Amount), 0) AS OperSumm
                                        FROM (SELECT Container.Id       AS ContainerId
                                                   , Container.ObjectId AS AccountId
                                                   , Container.Amount
                                                   , tmpItem.OperDate
                                              FROM tmpItem
                                                   INNER JOIN ContainerLinkObject AS CLO_Currency
                                                                                  ON CLO_Currency.ObjectId = tmpItem.CurrencyId
                                                                                 AND CLO_Currency.DescId   = zc_ContainerLinkObject_Currency()
                                                   INNER JOIN Container ON Container.Id     = CLO_Currency.ContainerId
                                                                       AND Container.DescId = zc_Container_Summ()
                                                   INNER JOIN Object_Account_View AS View_Account
                                                                                  ON View_Account.AccountId      = Container.ObjectId
                                                                                 AND View_Account.AccountGroupId = zc_Enum_AccountGroup_40000() -- �������� �������� 
                                                   INNER JOIN ContainerLinkObject AS CLO_Cash
                                                                                  ON CLO_Cash.ContainerId = CLO_Currency.ContainerId
                                                                                 AND CLO_Cash.DescId      = zc_ContainerLinkObject_Cash()
                                                                                 AND CLO_Cash.ObjectId    = tmpItem.CashId
                                             ) AS tmpContainer
                                             LEFT JOIN MovementItemContainer AS MIContainer
                                                                             ON MIContainer.Containerid = tmpContainer.ContainerId
                                                                            AND MIContainer.OperDate    >= vbOperDate_currency
                                        GROUP BY tmpContainer.ContainerId
                                               , tmpContainer.AccountId
                                               , tmpContainer.Amount
                                       ) AS tmp
                                 )
                    -- ��������� - ���� "�������������" - "����"
                    SELECT CASE WHEN tmpSumm.OperSumm_Currency <> 0 AND tmpItem.OperSumm_Currency <> 0 
                                     THEN tmpItem.OperSumm_Currency
                                        * (tmpItem.OperSumm / tmpItem.OperSumm_Currency
                                         - tmpSumm.OperSumm / tmpSumm.OperSumm_Currency
                                          )
                                ELSE 0
                           END
                    FROM tmpItem
                         CROSS JOIN tmpSumm
                   );

     -- 2.1. �������� ������� - ������
     INSERT INTO _tmpItem (MovementDescId, OperDate, ObjectId, ObjectDescId, OperSumm, OperSumm_Diff
                         , MovementItemId, ContainerId
                         , AccountGroupId, AccountDirectionId, AccountId
                         , ProfitLossGroupId, ProfitLossDirectionId
                         , InfoMoneyGroupId, InfoMoneyDestinationId, InfoMoneyId
                         , BusinessId_Balance, BusinessId_ProfitLoss, JuridicalId_Basis
                         , UnitId, PositionId, BranchId_Balance, BranchId_ProfitLoss, ServiceDateId, ContractId, PaidKindId
                         , CurrencyId
                         , IsActive, IsMaster
                          )
        SELECT _tmpItem.MovementDescId
             , _tmpItem.OperDate
             , _tmpItem.ObjectId
             , _tmpItem.ObjectDescId
             , -1 * vbSumm_diff  AS OperSumm
             , 0                 AS OperSumm_Diff
             , _tmpItem.MovementItemId

              -- ���������� �����
             , 0 AS ContainerId                                               
             , 0 AS AccountGroupId
               -- ���������� �����
             , zc_Enum_AccountDirection_40800() AS AccountDirectionId -- �������� �������
             , zc_Enum_Account_40801()          AS AccountId          -- �������� �������

               -- ������ ����: �� ������������
             , 0 AS ProfitLossGroupId
               -- ��������� ���� - �����������: �� ������������
             , 0 AS ProfitLossDirectionId

               -- �������������� ������ ����������: �� ������������
             , 0 AS InfoMoneyGroupId
               -- �������������� ����������: �� ������������
             , 0 AS InfoMoneyDestinationId
               -- �������������� ������ ����������: �� ������������
             , 0 AS InfoMoneyId

               -- ������ ������: �� ������������
             , 0 AS BusinessId_Balance
               -- ������ ����: ������ 0
             , 0 AS BusinessId_ProfitLoss

               -- ������� ��.����: ������ �� ...
             , _tmpItem.JuridicalId_Basis

             , 0 AS UnitId     -- �� ������������
             , 0 AS PositionId -- �� ������������

               -- ������ ������: �� ������������
             , 0 AS BranchId_Balance
             , 0 AS BranchId_ProfitLoss

               -- ����� ����������: �� ������������
             , 0 AS ServiceDateId

             , 0 AS ContractId -- �� ������������
             , 0 AS PaidKindId -- �� ������������

           --, zc_Enum_Currency_Basis() AS CurrencyId
             , _tmpItem.CurrencyId

             , FALSE AS IsActive
             , FALSE AS IsMaster
        FROM _tmpItem
        WHERE _tmpItem.IsMaster = TRUE
          AND vbSumm_diff <> 0

       UNION ALL
        -- ���� ��� ...
        SELECT _tmpItem.MovementDescId
             , _tmpItem.OperDate
             , CASE WHEN Object.DescId = zc_Object_Cash() THEN Object.Id     ELSE 0 END AS ObjectId
             , CASE WHEN Object.DescId = zc_Object_Cash() THEN Object.DescId ELSE 0 END AS ObjectDescId
             , 1 * vbSumm_diff   AS OperSumm
             , CASE WHEN Object.DescId = zc_Object_Cash() THEN 0 ELSE 1 * vbSumm_diff END AS OperSumm_Diff
             , _tmpItem.MovementItemId

              -- ���������� �����
             , 0 AS ContainerId                                               
             , 0 AS AccountGroupId
               -- ���������� �����
             , CASE WHEN Object.DescId = zc_Object_Cash() THEN zc_Enum_AccountDirection_40800() ELSE 0 END AS AccountDirectionId -- �������� �������
             , CASE WHEN Object.DescId = zc_Object_Cash() THEN zc_Enum_Account_40801()          ELSE 0 END AS AccountId          -- �������� �������

               -- ������ ����: �� ������������
             , 0 AS ProfitLossGroupId
               -- ��������� ���� - �����������: �� ������������
             , 0 AS ProfitLossDirectionId

               -- �������������� ������ ����������: �� ������������
             , 0 AS InfoMoneyGroupId
               -- �������������� ����������: �� ������������
             , 0 AS InfoMoneyDestinationId
               -- �������������� ������ ����������: �� ������������
             , 0 AS InfoMoneyId

               -- ������ ������: �� ������������
             , 0 AS BusinessId_Balance
               -- ������ ����: ������ 0
             , 0 AS BusinessId_ProfitLoss

               -- ������� ��.����: ������ �� ...
             , _tmpItem.JuridicalId_Basis

             , 0 AS UnitId     -- �� ������������
             , 0 AS PositionId -- �� ������������

               -- ������ ������: �� ������������
             , 0 AS BranchId_Balance
             , 0 AS BranchId_ProfitLoss

               -- ����� ����������: �� ������������
             , 0 AS ServiceDateId

             , 0 AS ContractId -- �� ������������
             , 0 AS PaidKindId -- �� ������������

             , zc_Enum_Currency_Basis() AS CurrencyId

             , FALSE AS IsActive
             , FALSE AS IsMaster
        FROM _tmpItem
             --
             LEFT JOIN Object ON Object.Id = _tmpItem.ObjectId
        WHERE _tmpItem.IsMaster = FALSE
          AND vbSumm_diff <> 0
       ;


     -- 5.1. ����� - ���������/��������� ��������
     PERFORM lpComplete_Movement_Finance (inMovementId := inMovementId
                                        , inUserId     := inUserId);

     -- 5.2. ����� - ����������� ������ ������ ��������� + ��������� ��������
     PERFORM lpComplete_Movement (inMovementId := inMovementId
                                , inDescId     := zc_Movement_Cash()
                                , inUserId     := inUserId
                                 );

END;$BODY$
  LANGUAGE plpgsql VOLATILE;


/*-------------------------------------------------------------------------------
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.
 20.09.14                                        * add zc_ObjectLink_Founder_InfoMoney
 09.09.14                                        * add PositionId and ServiceDateId and BusinessId_... and BranchId_...
 17.08.14                                        * add MovementDescId
 25.05.14                                        * add lpComplete_Movement
 10.05.14                                        * add lpInsert_MovementProtocol
 22.01.14                                        * add IsMaster
 28.12.13                                        * rename to zc_ObjectLink_Cash_JuridicalBasis
 26.12.13                                        *
*/

-- ����
-- SELECT * FROM lpUnComplete_Movement (inMovementId:= 3581, inUserId:= zfCalc_UserAdmin() :: Integer)
-- SELECT * FROM gpComplete_Movement_Cash (inMovementId:= 3581, inSession:= zfCalc_UserAdmin())
-- SELECT * FROM gpSelect_MovementItemContainer_Movement (inMovementId:= 3581, inSession:= zfCalc_UserAdmin())
