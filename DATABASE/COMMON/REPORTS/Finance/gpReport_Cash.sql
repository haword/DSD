-- Function: gpReport_Cash

DROP FUNCTION IF EXISTS gpReport_Cash (TDateTime, TDateTime, Integer, Integer, TVarChar);
DROP FUNCTION IF EXISTS gpReport_Cash (TDateTime, TDateTime, Integer, Integer, Integer, TVarChar);

CREATE OR REPLACE FUNCTION gpReport_Cash(
    IN inStartDate        TDateTime , --
    IN inEndDate          TDateTime , --
    IN inAccountId        Integer,    -- ����
    IN inCashId           Integer,    --
    IN inCurrencyId       Integer   , -- ������
    IN inSession          TVarChar    -- ������ ������������
)
RETURNS TABLE (ContainerId Integer, CashCode Integer, CashName TVarChar, CurrencyName TVarChar
             , GroupId Integer, GroupName TVarChar
             , BranchName TVarChar
             , InfoMoneyGroupName TVarChar, InfoMoneyDestinationName TVarChar, InfoMoneyCode Integer, InfoMoneyName TVarChar, InfoMoneyName_all TVarChar
             , AccountName TVarChar
             , UnitCode Integer, UnitName TVarChar
             , ProfitLossGroupCode Integer, ProfitLossGroupName TVarChar
             , ProfitLossDirectionCode Integer, ProfitLossDirectionName TVarChar
             , MoneyPlaceCode Integer, MoneyPlaceName TVarChar, ItemName TVarChar
             , ContractCode Integer, ContractInvNumber TVarChar, ContractTagName TVarChar
             , StartAmount TFloat, StartAmountD TFloat, StartAmountK TFloat
             , DebetSumm TFloat, KreditSumm TFloat
             , EndAmount TFloat, EndAmountD TFloat, EndAmountK TFloat
             , StartAmount_Currency TFloat, StartAmountD_Currency TFloat, StartAmountK_Currency TFloat
             , DebetSumm_Currency TFloat, KreditSumm_Currency TFloat
             , EndAmount_Currency TFloat, EndAmountD_Currency TFloat, EndAmountK_Currency TFloat
             , Summ_Currency TFloat
             , Comment TVarChar
              )
AS
$BODY$
   DECLARE vbUserId Integer;
BEGIN
     -- �������� ���� ������������ �� ����� ���������
     -- vbUserId:= lpCheckRight (inSession, zc_Enum_Process_Select_...());
     vbUserId:= lpGetUserBySession (inSession);

     -- ��������� ��� ��������
     IF vbUserId = 9457 -- ���������� �.�.
     THEN
         vbUserId:= NULL;
         RETURN;

     -- ��������� ��� �������� �� ������ ������
     ELSEIF EXISTS (SELECT 1 AS Id FROM ObjectLink_UserRole_View WHERE RoleId = zc_Enum_Role_CashReplace() AND UserId = vbUserId)
        -- AND inCashId    <> 296540 -- ����� ����� ��
        AND (inStartDate < zc_DateStart_Role_CashReplace() OR inStartDate > zc_DateEnd_Role_CashReplace()
          OR inEndDate   < zc_DateStart_Role_CashReplace() OR inEndDate   > zc_DateEnd_Role_CashReplace()
          OR inCashId    <> 14462 -- ����� �����
            )
     THEN
         IF inStartDate < zc_DateStart_Role_CashReplace() OR inStartDate > zc_DateEnd_Role_CashReplace() THEN inStartDate:= zc_DateStart_Role_CashReplace(); END IF;
         IF inEndDate   < zc_DateStart_Role_CashReplace() OR inEndDate   > zc_DateEnd_Role_CashReplace() THEN inEndDate  := zc_DateEnd_Role_CashReplace();   END IF;

     END IF;


     -- ��-�� ���� ������ �������� ���������
     IF COALESCE (inCashId, 0) = 0 AND (EXISTS (SELECT AccessKeyId_Guide FROM Object_RoleAccessKeyGuide_View WHERE AccessKeyId_Guide <> 0 AND UserId = vbUserId)
                                     OR EXISTS (SELECT AccessKeyId FROM Object_RoleAccessKey_View WHERE UserId = vbUserId
                                                                                                    AND AccessKeyId IN (SELECT AccessKeyId FROM Object_RoleAccessKeyDocument_View WHERE ProcessId = zc_Enum_Process_InsertUpdate_Movement_Cash())
                                               )
                                       )
     THEN inCashId:= -1;
     END IF;


     -- ���������
  RETURN QUERY
     WITH tmpUnit_byProfitLoss AS (SELECT * FROM lfSelect_Object_Unit_byProfitLossDirection ())
        , tmpContainer AS (SELECT Container.Id                            AS ContainerId
                                , Container_Currency.Id                   AS ContainerId_Currency
                                , Container.ObjectId                      AS ObjectId
                                , CLO_Cash.ObjectId                       AS CashId
                                , COALESCE (CLO_Currency.ObjectId, 0)     AS CurrencyId
                                , COALESCE (Container.Amount,0)           AS Amount
                                , COALESCE (Container_Currency.Amount, 0) AS Amount_Currency
                           FROM ContainerLinkObject AS CLO_Cash
                               INNER JOIN Container ON Container.Id = CLO_Cash.ContainerId AND Container.DescId = zc_Container_Summ()
                               LEFT JOIN ContainerLinkObject AS CLO_Currency ON CLO_Currency.ContainerId = Container.Id AND CLO_Currency.DescId = zc_ContainerLinkObject_Currency()
                               LEFT JOIN Container AS Container_Currency ON Container_Currency.ParentId = Container.Id AND Container_Currency.DescId = zc_Container_SummCurrency()
                           WHERE CLO_Cash.DescId = zc_ContainerLinkObject_Cash()
                             AND (Container.ObjectId = inAccountId OR inAccountId = 0)
                             AND (CLO_Cash.ObjectId = inCashId OR inCashId = 0)
                             -- AND (CLO_Currency.ObjectId = inCurrencyId OR inCurrencyId = 0)
                           )
         , tmpAccount AS (SELECT Object_Account.Id           AS AccountId
                               , Object_Account.ObjectCode   AS AccountCode
                               , CAST (CASE WHEN Object_Account.ObjectCode < 100000
                                                 THEN '0'
                                            ELSE ''
                                       END
                                    || Object_Account.ObjectCode || ' '
                                    || Object_AccountGroup.ValueData
                                    || CASE WHEN Object_AccountDirection.ValueData <> Object_AccountGroup.ValueData
                                                 THEN ' ' || Object_AccountDirection.ValueData
                                            ELSE ''
                                       END
                                    || CASE WHEN Object_Account.ValueData <> Object_AccountDirection.ValueData
                                                 THEN ' ' || Object_Account.ValueData
                                            ELSE ''
                                       END                   AS TVarChar) AS AccountName_all 
                               
                          FROM Object AS Object_Account
                               LEFT JOIN ObjectLink AS ObjectLink_Account_AccountGroup
                                                    ON ObjectLink_Account_AccountGroup.ObjectId = Object_Account.Id 
                                                   AND ObjectLink_Account_AccountGroup.DescId = zc_ObjectLink_Account_AccountGroup()
                               LEFT JOIN Object AS Object_AccountGroup ON Object_AccountGroup.Id = ObjectLink_Account_AccountGroup.ChildObjectId
                   
                               LEFT JOIN ObjectLink AS ObjectLink_Account_AccountDirection
                                                    ON ObjectLink_Account_AccountDirection.ObjectId = Object_Account.Id 
                                                   AND ObjectLink_Account_AccountDirection.DescId = zc_ObjectLink_Account_AccountDirection()
                               LEFT JOIN Object AS Object_AccountDirection ON Object_AccountDirection.Id = ObjectLink_Account_AccountDirection.ChildObjectId
                    
                          WHERE Object_Account.DescId = zc_Object_Account()
                         )  
                                   
        , tmpInfoMoney AS (SELECT Object_InfoMoneyGroup.ValueData                          AS InfoMoneyGroupName
                                , Object_InfoMoneyDestination.ValueData                    AS InfoMoneyDestinationName
                                , Object_InfoMoney.Id                                      AS InfoMoneyId
                                , Object_InfoMoney.ObjectCode                              AS InfoMoneyCode
                                , Object_InfoMoney.ValueData                               AS InfoMoneyName
                         
                                , CAST ('(' || CAST (Object_InfoMoney.ObjectCode AS TVarChar)
                                    || ') '|| Object_InfoMoneyGroup.ValueData
                                    || ' ' || Object_InfoMoneyDestination.ValueData
                                    || CASE WHEN Object_InfoMoneyDestination.ValueData <> Object_InfoMoney.ValueData THEN ' ' || Object_InfoMoney.ValueData ELSE '' END
                                       AS TVarChar)                                        AS InfoMoneyName_all
                           FROM Object AS Object_InfoMoney
                                LEFT JOIN ObjectLink AS ObjectLink_InfoMoney_InfoMoneyDestination
                                                     ON ObjectLink_InfoMoney_InfoMoneyDestination.ObjectId = Object_InfoMoney.Id
                                                    AND ObjectLink_InfoMoney_InfoMoneyDestination.DescId = zc_ObjectLink_InfoMoney_InfoMoneyDestination()
                                LEFT JOIN Object AS Object_InfoMoneyDestination ON Object_InfoMoneyDestination.Id = ObjectLink_InfoMoney_InfoMoneyDestination.ChildObjectId
                          
                                LEFT JOIN ObjectLink AS ObjectLink_InfoMoney_InfoMoneyGroup
                                                     ON ObjectLink_InfoMoney_InfoMoneyGroup.ObjectId = Object_InfoMoney.Id
                                                    AND ObjectLink_InfoMoney_InfoMoneyGroup.DescId = zc_ObjectLink_InfoMoney_InfoMoneyGroup()
                                LEFT JOIN Object AS Object_InfoMoneyGroup ON Object_InfoMoneyGroup.Id = ObjectLink_InfoMoney_InfoMoneyGroup.ChildObjectId
                         
                          WHERE Object_InfoMoney.DescId = zc_Object_InfoMoney()
                          )
                                  
        , tmpContract AS (SELECT Object_Contract.Id                            AS ContractId
                               , Object_Contract.ObjectCode                    AS ContractCode  
                               , Object_Contract.ValueData                     AS InvNumber
                               , Object_ContractTag.ValueData                  AS ContractTagName
                          FROM Object AS Object_Contract
                               LEFT JOIN ObjectLink AS ObjectLink_Contract_ContractTag
                                                    ON ObjectLink_Contract_ContractTag.ObjectId = Object_Contract.Id
                                                   AND ObjectLink_Contract_ContractTag.DescId = zc_ObjectLink_Contract_ContractTag()
                               LEFT JOIN Object AS Object_ContractTag ON Object_ContractTag.Id = ObjectLink_Contract_ContractTag.ChildObjectId
                        
                          WHERE Object_Contract.DescId = zc_Object_Contract()
                         )                           
     --
     SELECT
        Operation.ContainerId,
        Object_Cash.ObjectCode                                                                      AS CashCode,
        Object_Cash.ValueData                                                                       AS CashName,
        Object_Currency.ValueData                                                                   AS CurrencyName,
        CASE WHEN Operation.ContainerId > 0 THEN 1          WHEN Operation.DebetSumm > 0 THEN 2               WHEN Operation.KreditSumm > 0 THEN 3           ELSE -1 END :: Integer AS GroupId,
        CASE WHEN Operation.ContainerId > 0 THEN '1.������' WHEN Operation.DebetSumm > 0 THEN '2.�����������' WHEN Operation.KreditSumm > 0 THEN '3.�������' ELSE '' END :: TVarChar AS GroupName,
        Object_Branch.ValueData                                                                     AS BranchName,
        tmpInfoMoney.InfoMoneyGroupName                                                             AS InfoMoneyGroupName,
        tmpInfoMoney.InfoMoneyDestinationName                                                       AS InfoMoneyDestinationName,
        tmpInfoMoney.InfoMoneyCode                                                                  AS InfoMoneyCode,
        tmpInfoMoney.InfoMoneyName                                                                  AS InfoMoneyName,
        tmpInfoMoney.InfoMoneyName_all                                                              AS InfoMoneyName_all,
        tmpAccount.AccountName_all                                                                  AS AccountName,
        Object_Unit.ObjectCode                                                                      AS UnitCode,
        Object_Unit.ValueData                                                                       AS UnitName,
        tmpUnit_byProfitLoss.ProfitLossGroupCode,
        tmpUnit_byProfitLoss.ProfitLossGroupName,
        tmpUnit_byProfitLoss.ProfitLossDirectionCode,
        tmpUnit_byProfitLoss.ProfitLossDirectionName,
        Object_MoneyPlace.ObjectCode                                                                AS MoneyPlaceCode,
        Object_MoneyPlace.ValueData                                                                 AS MoneyPlaceName,
        ObjectDesc.ItemName                                                                         AS ItemName,
        tmpContract.ContractCode                                                                    AS ContractCode,
        tmpContract.InvNumber                                                                       AS ContractInvNumber,
        tmpContract.ContractTagName                                                                 AS ContractTagName,
        Operation.StartAmount ::TFloat                                                              AS StartAmount,
        CASE WHEN Operation.StartAmount > 0 THEN Operation.StartAmount ELSE 0 END ::TFloat          AS StartAmountD,
        CASE WHEN Operation.StartAmount < 0 THEN -1 * Operation.StartAmount ELSE 0 END :: TFloat    AS StartAmountK,
        Operation.DebetSumm::TFloat                                                                 AS DebetSumm,
        Operation.KreditSumm::TFloat                                                                AS KreditSumm,
        Operation.EndAmount ::TFloat                                                                AS EndAmount,
        CASE WHEN Operation.EndAmount > 0 THEN Operation.EndAmount ELSE 0 END :: TFloat             AS EndAmountD,
        CASE WHEN Operation.EndAmount < 0 THEN -1 * Operation.EndAmount ELSE 0 END :: TFloat        AS EndAmountK,

        Operation.StartAmount_Currency ::TFloat                                                                       AS StartAmount_Currency,
        CASE WHEN Operation.StartAmount_Currency > 0 THEN Operation.StartAmount_Currency ELSE 0 END ::TFloat          AS StartAmountD_Currency,
        CASE WHEN Operation.StartAmount_Currency < 0 THEN -1 * Operation.StartAmount_Currency ELSE 0 END :: TFloat    AS StartAmountK_Currency,
        Operation.DebetSumm_Currency::TFloat                                                                          AS DebetSumm_Currency,
        Operation.KreditSumm_Currency::TFloat                                                                         AS KreditSumm_Currency,
        Operation.EndAmount_Currency ::TFloat                                                                         AS EndAmount_Currency,
        CASE WHEN Operation.EndAmount_Currency > 0 THEN Operation.EndAmount_Currency ELSE 0 END :: TFloat             AS EndAmountD_Currency,
        CASE WHEN Operation.EndAmount_Currency < 0 THEN -1 * Operation.EndAmount_Currency ELSE 0 END :: TFloat        AS EndAmountK_Currency,

        Operation.Summ_Currency :: TFloat,  

        Operation.Comment :: TVarChar                                                               AS Comment

     FROM
         (SELECT Operation_all.ContainerId, Operation_all.ObjectId, Operation_all.CashId, Operation_all.InfoMoneyId, Operation_all.CurrencyId,
                 Operation_all.UnitId, Operation_all.MoneyPlaceId, Operation_all.ContractId, Operation_all.Comment,
                     SUM (Operation_all.StartAmount) AS StartAmount,
                     SUM (Operation_all.DebetSumm)   AS DebetSumm,
                     SUM (Operation_all.KreditSumm)  AS KreditSumm,
                     SUM (Operation_all.EndAmount)   AS EndAmount,
                     SUM (Operation_all.StartAmount_Currency) AS StartAmount_Currency,
                     SUM (Operation_all.DebetSumm_Currency)   AS DebetSumm_Currency,
                     SUM (Operation_all.KreditSumm_Currency)  AS KreditSumm_Currency,
                     SUM (Operation_all.EndAmount_Currency)   AS EndAmount_Currency,
                     SUM (Operation_all.Summ_Currency)        AS Summ_Currency
          FROM
           -- �������  � ������ �������
          (SELECT tmpContainer.ContainerId,
                  tmpContainer.ObjectId,
                  tmpContainer.CashId,
                  tmpContainer.CurrencyId,
                  0                         AS InfoMoneyId,
                  0                         AS UnitId,
                  0                         AS MoneyPlaceId,
                  0                         AS ContractId,
                  tmpContainer.Amount - COALESCE(SUM (MIContainer.Amount), 0)                                                             AS StartAmount,
                  0                         AS DebetSumm,
                  0                         AS KreditSumm,
                  tmpContainer.Amount - COALESCE(SUM (CASE WHEN MIContainer.OperDate > inEndDate THEN MIContainer.Amount ELSE 0 END), 0)  AS EndAmount,

                  0                         AS StartAmount_Currency,
                  0                         AS EndAmount_Currency,
                  0                         AS DebetSumm_Currency,
                  0                         AS KreditSumm_Currency,
                  0                         AS Summ_Currency,

                  '' AS Comment,
                  NULL :: Boolean           AS isActive

           FROM tmpContainer
                LEFT JOIN MovementItemContainer AS MIContainer ON MIContainer.Containerid = tmpContainer.ContainerId
                                               AND MIContainer.OperDate >= inStartDate
           GROUP BY tmpContainer.ContainerId, tmpContainer.ObjectId, tmpContainer.CashId, tmpContainer.Amount, tmpContainer.CurrencyId

           UNION ALL
           -- ������� � ������ ��������
           SELECT tmpContainer.ContainerId,
                  tmpContainer.ObjectId,
                  tmpContainer.CashId,
                  tmpContainer.CurrencyId,
                  0                         AS InfoMoneyId,
                  0                         AS UnitId,
                  0                         AS MoneyPlaceId,
                  0                         AS ContractId,
                  0                         AS StartAmount,
                  0                         AS DebetSumm,
                  0                         AS KreditSumm,
                  0                         AS EndAmount,

                  tmpContainer.Amount_Currency - COALESCE (SUM (MIContainer.Amount), 0)  AS StartAmount_Currency,
                  tmpContainer.Amount_Currency - COALESCE (SUM (CASE WHEN MIContainer.OperDate > inEndDate THEN MIContainer.Amount ELSE 0 END), 0) AS EndAmount_Currency,
                  0                         AS DebetSumm_Currency,
                  0                         AS KreditSumm_Currency,
                  0                         AS Summ_Currency,

                  '' AS Comment,
                  NULL :: Boolean           AS isActive

           FROM tmpContainer
                LEFT JOIN MovementItemContainer AS MIContainer 
                                                ON MIContainer.Containerid = tmpContainer.ContainerId_Currency
                                               AND MIContainer.OperDate >= inStartDate
           WHERE tmpContainer.ContainerId_Currency > 0
           GROUP BY tmpContainer.ContainerId, tmpContainer.ObjectId, tmpContainer.CashId, tmpContainer.Amount_Currency, tmpContainer.CurrencyId

           UNION ALL
           -- �������� � ������ �������
           SELECT 0                                 AS ContainerId,
                  tmpContainer.ObjectId,
                  tmpContainer.CashId,
                  tmpContainer.CurrencyId,
                  MILO_InfoMoney.ObjectId           AS InfoMoneyId,
                  MILO_Unit.ObjectId                AS UnitId,
                  MILO_MoneyPlace.ObjectId          AS MoneyPlaceId,
                  MILO_Contract.ObjectId            AS ContractId,
                  0                                 AS StartAmount,
                  SUM (CASE WHEN MIContainer.OperDate <= inEndDate THEN CASE WHEN MIContainer.Amount > 0 THEN MIContainer.Amount ELSE 0 END ELSE 0 END)         AS DebetSumm,
                  SUM (CASE WHEN MIContainer.OperDate <= inEndDate THEN CASE WHEN MIContainer.Amount < 0 THEN -1 * MIContainer.Amount ELSE 0 END ELSE 0 END)    AS KreditSumm,
                  0                                 AS EndAmount,

                  0                         AS StartAmount_Currency,
                  0                         AS EndAmount_Currency,
                  0                         AS DebetSumm_Currency,
                  0                         AS KreditSumm_Currency,
                  SUM (CASE WHEN MIContainer.MovementDescId = zc_Movement_Currency() THEN MIContainer.Amount ELSE 0 END) AS Summ_Currency,

                  COALESCE (MIString_Comment.ValueData, '') AS Comment,
                  MIContainer.isActive
           FROM tmpContainer
                  LEFT JOIN MovementItemContainer AS MIContainer ON MIContainer.Containerid = tmpContainer.ContainerId
                                                                AND MIContainer.OperDate >= inStartDate
                  LEFT JOIN MovementItemString AS MIString_Comment
                                               ON MIString_Comment.MovementItemId = MIContainer.MovementItemId
                                              AND MIString_Comment.DescId = zc_MIString_Comment()
                  LEFT JOIN MovementItemLinkObject AS MILO_MoneyPlace
                                                   ON MILO_MoneyPlace.MovementItemId = MIContainer.MovementItemId
                                                  AND MILO_MoneyPlace.DescId = zc_MILinkObject_MoneyPlace()
                  LEFT JOIN MovementItemLinkObject AS MILO_Contract
                                                   ON MILO_Contract.MovementItemId = MIContainer.MovementItemId
                                                  AND MILO_Contract.DescId = zc_MILinkObject_Contract()
                  LEFT JOIN MovementItemLinkObject AS MILO_Unit
                                                   ON MILO_Unit.MovementItemId = MIContainer.MovementItemId
                                                  AND MILO_Unit.DescId = zc_MILinkObject_Unit()
                  LEFT JOIN MovementItemLinkObject AS MILO_InfoMoney
                                                   ON MILO_InfoMoney.MovementItemId = MIContainer.MovementItemId
                                                  AND MILO_InfoMoney.DescId = zc_MILinkObject_InfoMoney()
                 -- LEFT JOIN Object_InfoMoney_View ON Object_InfoMoney_View.InfoMoneyId = MILO_InfoMoney.ObjectId
           GROUP BY tmpContainer.ContainerId, tmpContainer.ObjectId, tmpContainer.CashId, tmpContainer.CurrencyId,
                    MILO_InfoMoney.ObjectId, 
                    MILO_Unit.ObjectId, MILO_MoneyPlace.ObjectId, MILO_Contract.ObjectId,
                    MIString_Comment.ValueData,
                    MIContainer.isActive
           UNION ALL
           -- ��������  � ������ ��������
           SELECT 0                                 AS ContainerId,
                  tmpContainer.ObjectId,
                  tmpContainer.CashId,
                  tmpContainer.CurrencyId,
                  MILO_InfoMoney.ObjectId           AS InfoMoneyId,
                  MILO_Unit.ObjectId                AS UnitId,
                  MILO_MoneyPlace.ObjectId          AS MoneyPlaceId,
                  MILO_Contract.ObjectId            AS ContractId,
                  0                                 AS StartAmount,
                  0                                 AS DebetSumm,
                  0                                 AS KreditSumm,
                  0                                 AS EndAmount,

                  0                                 AS StartAmount_Currency,
                  0                                 AS EndAmount_Currency,
                  SUM (CASE WHEN MIContainer.Amount > 0 THEN MIContainer.Amount ELSE 0 END)      AS DebetSumm_Currency,
                  SUM (CASE WHEN MIContainer.Amount < 0 THEN -1 * MIContainer.Amount ELSE 0 END) AS KreditSumm_Currency,
                  0                                 AS Summ_Currency,

                  COALESCE (MIString_Comment.ValueData, '') AS Comment,
                  MIContainer.isActive
           FROM tmpContainer
                  LEFT JOIN MovementItemContainer AS MIContainer ON MIContainer.Containerid = tmpContainer.ContainerId_Currency
                                                                AND MIContainer.OperDate >= inStartDate
                  LEFT JOIN MovementItemString AS MIString_Comment
                                               ON MIString_Comment.MovementItemId = MIContainer.MovementItemId
                                              AND MIString_Comment.DescId = zc_MIString_Comment()
                  LEFT JOIN MovementItemLinkObject AS MILO_MoneyPlace
                                                   ON MILO_MoneyPlace.MovementItemId = MIContainer.MovementItemId
                                                  AND MILO_MoneyPlace.DescId = zc_MILinkObject_MoneyPlace()
                  LEFT JOIN MovementItemLinkObject AS MILO_Contract
                                                   ON MILO_Contract.MovementItemId = MIContainer.MovementItemId
                                                  AND MILO_Contract.DescId = zc_MILinkObject_Contract()
                  LEFT JOIN MovementItemLinkObject AS MILO_Unit
                                                   ON MILO_Unit.MovementItemId = MIContainer.MovementItemId
                                                  AND MILO_Unit.DescId = zc_MILinkObject_Unit()
                  LEFT JOIN MovementItemLinkObject AS MILO_InfoMoney
                                                   ON MILO_InfoMoney.MovementItemId = MIContainer.MovementItemId
                                                  AND MILO_InfoMoney.DescId = zc_MILinkObject_InfoMoney()
                  --LEFT JOIN Object_InfoMoney_View ON Object_InfoMoney_View.InfoMoneyId = MILO_InfoMoney.ObjectId
           WHERE tmpContainer.ContainerId_Currency > 0
           GROUP BY tmpContainer.ContainerId, tmpContainer.ObjectId, tmpContainer.CashId, tmpContainer.CurrencyId,
                    MILO_InfoMoney.ObjectId,
                    MILO_Unit.ObjectId, MILO_MoneyPlace.ObjectId, MILO_Contract.ObjectId,
                    MIString_Comment.ValueData,
                    MIContainer.isActive
           ) AS Operation_all

          GROUP BY Operation_all.ContainerId, Operation_all.ObjectId, Operation_all.CashId, Operation_all.CurrencyId,
                   Operation_all.InfoMoneyId, Operation_all.UnitId, Operation_all.MoneyPlaceId, Operation_all.ContractId, Operation_all.Comment, 
                   Operation_all.isActive
         ) AS Operation


     LEFT JOIN tmpAccount ON tmpAccount.AccountId = Operation.ObjectId
     LEFT JOIN Object AS Object_Cash ON Object_Cash.Id = Operation.CashId
     LEFT JOIN Object AS Object_Currency ON Object_Currency.Id = Operation.CurrencyId
     LEFT JOIN tmpInfoMoney ON tmpInfoMoney.InfoMoneyId = Operation.InfoMoneyId
     LEFT JOIN Object AS Object_Unit ON Object_Unit.Id = Operation.UnitId
     LEFT JOIN Object AS Object_MoneyPlace ON Object_MoneyPlace.Id = Operation.MoneyPlaceId
     LEFT JOIN ObjectDesc ON ObjectDesc.Id = Object_MoneyPlace.DescId

     LEFT JOIN tmpUnit_byProfitLoss ON tmpUnit_byProfitLoss.UnitId = Operation.UnitId

     LEFT JOIN ObjectLink AS ObjectLink_Cash_Branch
                          ON ObjectLink_Cash_Branch.ObjectId = Operation.CashId
                         AND ObjectLink_Cash_Branch.DescId = zc_ObjectLink_Cash_Branch()
     LEFT JOIN Object AS Object_Branch ON Object_Branch.Id = ObjectLink_Cash_Branch.ChildObjectId

     LEFT JOIN tmpContract ON tmpContract.ContractId = Operation.ContractId

     WHERE (Operation.StartAmount <> 0 OR Operation.EndAmount <> 0 OR Operation.DebetSumm <> 0 OR Operation.KreditSumm <> 0
         OR Operation.StartAmount_Currency <> 0 OR Operation.EndAmount_Currency <> 0 OR Operation.DebetSumm_Currency <> 0 OR Operation.KreditSumm_Currency <> 0);


END;
$BODY$
  LANGUAGE plpgsql VOLATILE;
--ALTER FUNCTION gpReport_Cash (TDateTime, TDateTime, Integer, Integer, TVarChar) OWNER TO postgres;

/*-------------------------------------------------------------------------------
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.   ������ �.�.
 27.09.14                                        *
 09.09.14                                                        *
*/

-- ����
-- SELECT * FROM gpReport_Cash (inStartDate:= '03.12.2016' ::TDateTime, inEndDate:= '31.12.2016'::TDateTime, inAccountId:= 0, inCashId:=280296 , inCurrencyId:=0,  inSession:= '2'::TVarChar);
