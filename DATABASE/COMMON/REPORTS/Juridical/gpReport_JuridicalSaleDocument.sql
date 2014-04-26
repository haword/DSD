-- Function: gpReport_JuridicalSold()

DROP FUNCTION IF EXISTS gpReport_JuridicalSaleDocument (TDateTime, TDateTime, Integer, Integer, Integer, TVarChar);

CREATE OR REPLACE FUNCTION gpReport_JuridicalSaleDocument(
    IN inStartDate        TDateTime , -- 
    IN inEndDate          TDateTime , -- 
    IN inJuridicalId      INTEGER   ,
    IN inAccountId        Integer   , --
    IN inContractId       Integer   , --
    IN inSession          TVarChar    -- ������ ������������
)
RETURNS TABLE (Id Integer, OperDate TDateTime, InvNumber TVarChar, TotalSumm TFloat, FromName TVarChar, ToName TVarChar)
AS
$BODY$
BEGIN

     -- �������� ���� ������������ �� ����� ���������
     -- PERFORM lpCheckRight (inSession, zc_Enum_Process_Report_Fuel());


     -- !!!����� ������ �� �� �������� � �� "�����"!!!
     CREATE TEMP TABLE _tmpContract (ContractId Integer) ON COMMIT DROP; 
     INSERT INTO _tmpContract (ContractId)
         SELECT COALESCE (View_Contract_ContractKey_find.ContractId, View_Contract_ContractKey.ContractId) AS ContractId
         FROM Object_Contract_ContractKey_View AS View_Contract_ContractKey
              LEFT JOIN Object_Contract_ContractKey_View AS View_Contract_ContractKey_find ON View_Contract_ContractKey_find.ContractKeyId = View_Contract_ContractKey.ContractKeyId
         WHERE View_Contract_ContractKey.ContractId = inContractId;



    RETURN QUERY  
        SELECT 
              Movement.Id
            , Movement.OperDate
            , Movement.InvNumber
            , MovementFloat_TotalSumm.ValueData  AS TotalSumm
            , Object_From.ValueData AS FromName
            , Object_To.ValueData   AS ToName
         FROM Movement 
              INNER JOIN MovementLinkObject AS MovementLinkObject_To
                                            ON MovementLinkObject_To.MovementId = Movement.Id
                                           AND MovementLinkObject_To.DescId = zc_MovementLinkObject_To()
              INNER JOIN MovementLinkObject AS MovementLinkObject_From
                                            ON MovementLinkObject_From.MovementId = Movement.Id
                                           AND MovementLinkObject_From.DescId = zc_MovementLinkObject_From()
              INNER JOIN ObjectLink AS ObjectLink_Partner_Juridical
                                    ON ObjectLink_Partner_Juridical.ObjectId = MovementLinkObject_To.ObjectId
                                   AND ObjectLink_Partner_Juridical.DescId = zc_ObjectLink_Partner_Juridical()
              LEFT JOIN MovementFloat AS MovementFloat_TotalSumm
                                      ON MovementFloat_TotalSumm.MovementId =  Movement.Id
                                     AND MovementFloat_TotalSumm.DescId = zc_MovementFloat_TotalSumm()
              LEFT JOIN MovementLinkObject AS MovementLinkObject_Contract
                                           ON MovementLinkObject_Contract.MovementId = Movement.Id
                                          AND MovementLinkObject_Contract.DescId = zc_MovementLinkObject_Contract()
              -- !!!���������� ��������!!!
              LEFT JOIN _tmpContract ON _tmpContract.ContractId = MovementLinkObject_Contract.ObjectId

              LEFT JOIN Object AS Object_From  ON Object_From.Id = MovementLinkObject_From.ObjectId
              LEFT JOIN Object AS Object_To ON Object_To.Id = MovementLinkObject_To.ObjectId

        WHERE Movement.DescId = zc_Movement_Sale()
          AND Movement.StatusId = zc_enum_status_complete()
          AND (_tmpContract.ContractId > 0 OR inContractId = 0)
          AND Movement.OperDate >= inStartDate 
          AND Movement.OperDate < inEndDate
          AND ObjectLink_Partner_Juridical.ChildObjectId = inJuridicalId 
    ORDER BY OperDate;
    
          
          --, zc_Movement_ReturnIn()) 
    -- �����. �������� ��������� ������. 
    -- ����� �������

END;
$BODY$
  LANGUAGE plpgsql VOLATILE;
ALTER FUNCTION gpReport_JuridicalDefermentPaymentByDocument (TDateTime, TDateTime, Integer, Integer, Integer, Integer, TFloat, TVarChar) OWNER TO postgres;

/*-------------------------------------------------------------------------------
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.
 26.04.14                                        * add Object_Contract_ContractKey_View
 17.04.14                          * 
*/

-- ����
-- SELECT * FROM gpReport_JuridicalDefermentPayment ('01.01.2014'::TDateTime, '01.02.2013'::TDateTime, 0, inSession:= '2'::TVarChar); 
