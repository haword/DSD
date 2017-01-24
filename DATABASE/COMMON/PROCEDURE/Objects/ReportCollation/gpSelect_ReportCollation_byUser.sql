-- Function: gpSelect_Object_Contract()

DROP FUNCTION IF EXISTS gpSelect_ReportCollation_byUser (TDateTime, TDateTime, TVarChar);


CREATE OR REPLACE FUNCTION gpSelect_ReportCollation_byUser(
    IN inStartDate      TDateTime , --
    IN inEndDate        TDateTime , --
    IN inSession        TVarChar       -- ������ ������������
)
RETURNS TABLE (Id Integer, idBarCode TVarChar
             , StartDate  TDateTime
             , EndDate    TDateTime
             , JuridicalName TVarChar
             , PartnerName TVarChar
             , ContractName TVarChar
             , PaidKindName TVarChar
             , InsertName TVarChar
             , InsertDate TDateTime
             , BuhName TVarChar
             , BuhDate TDateTime
             , isBuh Boolean
            
              )
AS
$BODY$
   DECLARE vbUserId Integer;
   DECLARE vbMemberId_user  Integer;
BEGIN
   -- �������� ���� ������������ �� ����� ���������
   -- PERFORM lpCheckRight (inSession, zc_Enum_Process_Select_Object_Contract());
   vbUserId:= lpGetUserBySession (inSession);

     -- ������������ <���������� ����> - ��� ����������� ���� inReestrKindId
     vbMemberId_user:= CASE WHEN vbUserId = 5 THEN 9457 ELSE
                       (SELECT ObjectLink_User_Member.ChildObjectId
                        FROM ObjectLink AS ObjectLink_User_Member
                        WHERE ObjectLink_User_Member.DescId = zc_ObjectLink_User_Member()
                          AND ObjectLink_User_Member.ObjectId = vbUserId)
                       END
                      ;
     -- ��������
     IF COALESCE (vbMemberId_user, 0) = 0
     THEN 
          RAISE EXCEPTION '������.� ������������ <%> �� ��������� �������� <���.����>.', lfGet_Object_ValueData (vbUserId);
     END IF;


   -- ���������
   RETURN QUERY 
   WITH
     -- �������� �� ������ ��� ������ ������������
     tmpReport AS (SELECT ObjectDate_Buh.ObjectId      AS Id
                        , ObjectLink_Buh.ChildObjectId AS BuhId
                        , ObjectDate_Buh.ValueData     AS BuhDate
                   FROM ObjectDate AS ObjectDate_Buh
                        INNER JOIN ObjectLink AS ObjectLink_Buh
                                ON ObjectLink_Buh.ObjectId = ObjectDate_Buh.ObjectId
                               AND ObjectLink_Buh.DescId = zc_ObjectLink_ReportCollation_Buh()
                               AND (ObjectLink_Buh.ChildObjectId = vbMemberId_user  OR vbUserId = 5)
                   WHERE ObjectDate_Buh.DescId = zc_ObjectDate_ReportCollation_Buh()
                     AND ObjectDate_Buh.ValueData >= inStartDate AND ObjectDate_Buh.ValueData < inEndDate + INTERVAL '1 DAY'
                   )

   SELECT
         tmpReport.Id
       , zfFormat_BarCode (zc_BarCodePref_Object(), tmpReport.Id) ::TVarChar AS idBarCode
       , ObjectDate_Start.ValueData      AS StartDate
       , ObjectDate_End.ValueData        AS EndDate
       , Object_Juridical.ValueData      AS JuridicalName
       , Object_Partner.ValueData        AS PartnerName
       , Object_Contract.ValueData       AS ContractName
       , Object_PaidKind.ValueData       AS PaidKindName

       , Object_Insert.ValueData         AS InsertName
       , ObjectDate_Insert.ValueData     AS InsertDate

       , Object_Buh.ValueData            AS BuhName
       , tmpReport.BuhDate

       , COALESCE (ObjectBoolean_Buh.ValueData, False) ::Boolean  AS isBuh
       
   FROM tmpReport
      LEFT JOIN ObjectDate AS ObjectDate_Start
                           ON ObjectDate_Start.ObjectId = tmpReport.Id
                          AND ObjectDate_Start.DescId = zc_ObjectDate_ReportCollation_Start()
      LEFT JOIN ObjectDate AS ObjectDate_End
                            ON ObjectDate_End.ObjectId = tmpReport.Id
                           AND ObjectDate_End.DescId = zc_ObjectDate_ReportCollation_End()
 
      LEFT JOIN ObjectDate AS ObjectDate_Insert
                           ON ObjectDate_Insert.ObjectId = tmpReport.Id
                          AND ObjectDate_Insert.DescId = zc_ObjectDate_ReportCollation_Insert()

      LEFT JOIN ObjectBoolean AS ObjectBoolean_Buh
                              ON ObjectBoolean_Buh.ObjectId = tmpReport.Id
                             AND ObjectBoolean_Buh.DescId = zc_ObjectBoolean_ReportCollation_Buh()

      LEFT JOIN ObjectLink AS ObjectLink_ReportCollation_PaidKind
                           ON ObjectLink_ReportCollation_PaidKind.ObjectId = tmpReport.Id
                          AND ObjectLink_ReportCollation_PaidKind.DescId = zc_ObjectLink_ReportCollation_PaidKind()
      LEFT JOIN Object AS Object_PaidKind ON Object_PaidKind.Id = ObjectLink_ReportCollation_PaidKind.ChildObjectId
      
      LEFT JOIN ObjectLink AS ObjectLink_ReportCollation_Juridical
                           ON ObjectLink_ReportCollation_Juridical.ObjectId = tmpReport.Id
                          AND ObjectLink_ReportCollation_Juridical.DescId = zc_ObjectLink_ReportCollation_Juridical()
      LEFT JOIN Object AS Object_Juridical ON Object_Juridical.Id = ObjectLink_ReportCollation_Juridical.ChildObjectId
      
      LEFT JOIN ObjectLink AS ObjectLink_ReportCollation_Partner
                           ON ObjectLink_ReportCollation_Partner.ObjectId = tmpReport.Id
                          AND ObjectLink_ReportCollation_Partner.DescId = zc_ObjectLink_ReportCollation_Partner()
      LEFT JOIN Object AS Object_Partner ON Object_Partner.Id = ObjectLink_ReportCollation_Partner.ChildObjectId

      LEFT JOIN ObjectLink AS ObjectLink_ReportCollation_Contract
                           ON ObjectLink_ReportCollation_Contract.ObjectId = tmpReport.Id
                          AND ObjectLink_ReportCollation_Contract.DescId = zc_ObjectLink_ReportCollation_Contract()
      LEFT JOIN Object AS Object_Contract ON Object_Contract.Id = ObjectLink_ReportCollation_Contract.ChildObjectId

      LEFT JOIN ObjectLink AS ObjectLink_Insert
                           ON ObjectLink_Insert.ObjectId = tmpReport.Id
                          AND ObjectLink_Insert.DescId = zc_ObjectLink_ReportCollation_Insert()
      LEFT JOIN Object AS Object_Insert ON Object_Insert.Id = ObjectLink_Insert.ChildObjectId   

      LEFT JOIN Object AS Object_Buh ON Object_Buh.Id = tmpReport.BuhId

 -- WHERE Object_ReportCollation.DescId = zc_Object_ReportCollation()
   ;
  
END;
$BODY$
  LANGUAGE plpgsql VOLATILE;

/*-------------------------------------------------------------------------------*/
/*
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.   ������ �.�.
 23.01.17         *
*/

-- ����
--SELECT * FROM gpSelect_ReportCollation_byUser (inStartDate:= NULL, inEndDate:= NULL, inSession := zfCalc_UserAdmin())


--select * from gpSelect_ReportCollation_byUser(instartdate := ('23.01.2017')::TDateTime , inenddate := ('24.01.2017')::TDateTime ,  inSession := '5');