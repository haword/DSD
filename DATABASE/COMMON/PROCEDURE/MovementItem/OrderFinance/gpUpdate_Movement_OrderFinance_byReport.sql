-- Function: gpInsertUpdate_MI_OrderFinance_byReport()

DROP FUNCTION IF EXISTS gpInsertUpdate_MI_OrderFinance_byReport (Integer, TVarChar);

CREATE OR REPLACE FUNCTION gpInsertUpdate_MI_OrderFinance_byReport(
    IN inMovementId            Integer   , -- ���� ������� <��������>
    IN inSession               TVarChar    -- ������ ������������
)
RETURNS VOID
AS
$BODY$
   DECLARE vbUserId Integer;
   DECLARE vbOrderFinanceId Integer;
   DECLARE vbPaidKindId Integer;
   DECLARE vbOperDate TDateTime;
BEGIN
     -- �������� ���� ������������ �� ����� ���������
     vbUserId := lpCheckRight (inSession, zc_Enum_Process_InsertUpdate_MI_OrderFinance());

     -- ��������
     IF EXISTS (SELECT 1 FROM MovementItem WHERE MovementItem.MovementId = inMovementId AND MovementItem.DescId = zc_MI_Master() AND MovementItem.isErased = FALSE)
     THEN
         RAISE EXCEPTION '������.�������� ��� ��������.';
     END IF;
     
     -- �� ����� ���������
     SELECT Movement.OperDate
          , MovementLinkObject.ObjectId         AS OrderFinanceId
          , OrderFinance_PaidKind.ChildObjectId AS PaidKindId
     INTO vbOperDate, vbOrderFinanceId, vbPaidKindId
     FROM Movement
          LEFT JOIN MovementLinkObject ON MovementLinkObject.MovementId = inMovementId
                                      AND MovementLinkObject.DescId = zc_MovementLinkObject_OrderFinance()
          LEFT JOIN ObjectLink AS OrderFinance_PaidKind
                               ON OrderFinance_PaidKind.ObjectId = MovementLinkObject.ObjectId
                              AND OrderFinance_PaidKind.DescId = zc_ObjectLink_OrderFinance_PaidKind()
     WHERE Movement.Id = inMovementId;
       

    -- ������ �� ������
    CREATE TEMP TABLE _tmpReport (JuridicalId Integer, PaidKindId Integer, ContractId Integer, InfomoneyId Integer
                                , DebetRemains TFloat, KreditRemains TFloat
                                , DefermentPaymentRemains TFloat   --���� � ���������
                                , Remains TFloat) ON COMMIT DROP;
    INSERT INTO _tmpReport (JuridicalId, PaidKindId, ContractId, InfomoneyId
                          , DebetRemains, KreditRemains
                          , DefermentPaymentRemains   --���� � ���������
                          , Remains)
	    SELECT tmp.JuridicalId, tmp.PaidKindId, tmp.ContractId, tmp.InfomoneyId 
                 , tmp.DebetRemains, tmp.KreditRemains
                 , tmp.DefermentPaymentRemains   --���� � ���������
                 , tmp.Remains 
            FROM gpReport_JuridicalDefermentIncome(inOperDate      := vbOperDate 
                                                 , inEmptyParam    := NULL        ::TDateTime
                                                 , inAccountId     := 0
                                                 , inPaidKindId    := COALESCE (vbPaidKindId,0)
                                                 , inBranchId      := 0
                                                 , inJuridicalGroupId := 0
                                                 , inSession       := inSession) AS tmp
            WHERE COALESCE (tmp.DefermentPaymentRemains, 0) <> 0
               OR COALESCE (tmp.Remains, 0) <> 0;

    -- ������ ���������
    CREATE TEMP TABLE _tmpData (Id Integer, JuridicalId Integer, ContractId Integer, PaidKindId Integer, InfoMoneyId Integer) ON COMMIT DROP;
    INSERT INTO _tmpData (Id, JuridicalId, ContractId, PaidKindId, InfoMoneyId)
     WITH
     tmpOrderFinanceProperty AS (SELECT DISTINCT OrderFinanceProperty_Object.ChildObjectId AS Id
                                 FROM ObjectLink AS OrderFinanceProperty_OrderFinance
                                      INNER JOIN ObjectLink AS OrderFinanceProperty_Object
                                                            ON OrderFinanceProperty_Object.ObjectId = OrderFinanceProperty_OrderFinance.ObjectId
                                                           AND OrderFinanceProperty_Object.DescId = zc_ObjectLink_OrderFinanceProperty_Object()
                                                           AND COALESCE (OrderFinanceProperty_Object.ChildObjectId,0) <> 0

                                 WHERE OrderFinanceProperty_OrderFinance.ChildObjectId = vbOrderFinanceId
                                   AND OrderFinanceProperty_OrderFinance.DescId = zc_ObjectLink_OrderFinanceProperty_OrderFinance()
                                )
   , tmpInfoMoney AS (SELECT DISTINCT Object_InfoMoney_View.InfoMoneyId
                      FROM Object_InfoMoney_View
                           INNER JOIN tmpOrderFinanceProperty ON (tmpOrderFinanceProperty.Id = Object_InfoMoney_View.InfoMoneyId
                                                               OR tmpOrderFinanceProperty.Id = Object_InfoMoney_View.InfoMoneyDestinationId
                                                               OR tmpOrderFinanceProperty.Id = Object_InfoMoney_View.InfoMoneyGroupId)
                      )

   , tmpData AS (SELECT DISTINCT 
                        ObjectLink_Contract_Juridical.ChildObjectId AS JuridicalId
                      , ObjectLink_Contract_InfoMoney.ObjectId      AS ContractId
                      , ObjectLink_Contract_InfoMoney.ChildObjectId AS InfoMoneyId
                      , OL_Contract_PaidKind.ChildObjectId          AS PaidKindId
                 FROM ObjectLink AS ObjectLink_Contract_InfoMoney
                      INNER JOIN tmpInfoMoney ON tmpInfoMoney.InfoMoneyId = ObjectLink_Contract_InfoMoney.ChildObjectId
                      LEFT JOIN ObjectLink AS ObjectLink_Contract_Juridical
                                           ON ObjectLink_Contract_Juridical.ObjectId = ObjectLink_Contract_InfoMoney.ObjectId
                                          AND ObjectLink_Contract_Juridical.DescId = zc_ObjectLink_Contract_Juridical()
                      INNER JOIN ObjectLink AS OL_Contract_PaidKind
                                            ON OL_Contract_PaidKind.ObjectId = ObjectLink_Contract_InfoMoney.ObjectId
                                           AND OL_Contract_PaidKind.DescId = zc_ObjectLink_Contract_PaidKind()
                                           AND (OL_Contract_PaidKind.ChildObjectId = vbPaidKindId OR COALESCE (vbPaidKindId,0) = 0)
                 WHERE ObjectLink_Contract_InfoMoney.DescId = zc_ObjectLink_Contract_InfoMoney()
                )

   , tmpMI AS (SELECT MovementItem.Id                     AS Id
                    , MovementItem.ObjectId               AS JuridicalId
                    , MILinkObject_Contract.ObjectId      AS ContractId
                    , OL_Contract_PaidKind.ChildObjectId  AS PaidKindId
                    , OL_Contract_InfoMoney.ChildObjectId AS InfoMoneyId
               FROM MovementItem
                    LEFT JOIN MovementItemLinkObject AS MILinkObject_Contract
                                                     ON MILinkObject_Contract.MovementItemId = MovementItem.Id
                                                    AND MILinkObject_Contract.DescId = zc_MILinkObject_Contract()
                   INNER JOIN ObjectLink AS OL_Contract_PaidKind
                                         ON OL_Contract_PaidKind.ObjectId = MILinkObject_Contract.ObjectId
                                        AND OL_Contract_PaidKind.DescId = zc_ObjectLink_Contract_PaidKind()
                                        AND (OL_Contract_PaidKind.ChildObjectId = vbPaidKindId OR COALESCE (vbPaidKindId,0) = 0)
                   LEFT JOIN ObjectLink AS OL_Contract_InfoMoney
                                        ON OL_Contract_InfoMoney.ObjectId = MILinkObject_Contract.ObjectId
                                       AND OL_Contract_InfoMoney.DescId = zc_ObjectLink_Contract_InfoMoney()
               WHERE MovementItem.MovementId = inMovementId
                 AND MovementItem.DescId     = zc_MI_Master()
                 AND MovementItem.isErased   = FALSE
               )

       -- ���������
       SELECT
             COALESCE (tmpMI.Id, 0)                            AS MI_Id
           , COALESCE (tmpData.JuridicalId, tmpMI.JuridicalId) AS JuridicalId
           , COALESCE (tmpData.ContractId, tmpMI.ContractId)   AS ContractId
           , COALESCE (tmpData.PaidKindId, tmpMI.PaidKindId)   AS PaidKindId
           , COALESCE (tmpData.InfoMoneyId, tmpMI.InfoMoneyId) AS InfoMoneyId

       FROM tmpData
            FULL JOIN tmpMI ON tmpMI.JuridicalId = tmpData.JuridicalId
                           AND tmpMI.ContractId  = tmpData.ContractId
                           AND tmpMI.PaidKindId  = tmpData.PaidKindId
                           AND tmpMI.InfoMoneyId = tmpData.InfoMoneyId;
            
    -- ��������� ������
    PERFORM lpUpdate_MI_OrderFinance_ByReport (inId            := COALESCE (_tmpData.Id, 0)                       ::Integer
                                             , inMovementId    := inMovementId 
                                             , inJuridicalId   := _tmpData.JuridicalId
                                             , inContractId    := _tmpData.ContractId
                                             , inAmountRemains := COALESCE (_tmpReport.Remains,0)                 ::TFloat
                                             , inAmountPartner := COALESCE (_tmpReport.DefermentPaymentRemains,0) ::TFloat
                                             , inUserId        := vbUserId
                                              )
    FROM _tmpData
         INNER JOIN _tmpReport ON _tmpReport.JuridicalId = _tmpData.JuridicalId
                              AND _tmpReport.ContractId  = _tmpData.ContractId
                              AND _tmpReport.InfoMoneyId = _tmpData.InfoMoneyId
                              AND _tmpReport.PaidKindId  = _tmpData.PaidKindId --OR COALESCE (vbPaidKindId,0) = 0)
                              ;

END;
$BODY$
  LANGUAGE plpgsql VOLATILE;

/*
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.
 30.07.19         *
*/

-- ����
--select * from gpInsertUpdate_MI_OrderFinance_byReport(inMovementId := 14022564 ,  inSession := '5');

/*SELECT *
            FROM gpReport_JuridicalDefermentIncome(inOperDate      := '30.07.2019' 
                                                 , inEmptyParam    := '30.07.2019'
                                                 , inAccountId     := 0
                                                 , inPaidKindId    := 3
                                                 , inBranchId      := 0
                                                 , inJuridicalGroupId := 0
                                                 , inSession       := '5'::TVarchar);
*/