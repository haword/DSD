-- Function: gpSelect_Movement_OrderExternal()

DROP FUNCTION IF EXISTS gpSelect_Movement_OrderExternal (TDateTime, TDateTime, Boolean, TVarChar);
DROP FUNCTION IF EXISTS gpSelect_Movement_OrderExternal (TDateTime, TDateTime, Boolean, Integer, TVarChar);
DROP FUNCTION IF EXISTS gpSelect_Movement_OrderExternal (TDateTime, TDateTime, Boolean, Integer, Integer, TVarChar);

CREATE OR REPLACE FUNCTION gpSelect_Movement_OrderExternal(
    IN inStartDate         TDateTime , --
    IN inEndDate           TDateTime , --
    IN inIsErased          Boolean ,
    IN inJuridicalBasisId  Integer ,
    IN inPersonalTradeId   Integer ,   -- �������� �����
  
    IN inSession           TVarChar    -- ������ ������������
)
RETURNS TABLE (Id Integer, InvNumber TVarChar, OperDate TDateTime, StatusCode Integer, StatusName TVarChar
             , OperDatePartner TDateTime, OperDatePartner_sale TDateTime, OperDateMark TDateTime
             , InvNumberPartner TVarChar
             , FromId Integer, FromName TVarChar
             , ToId Integer, ToName TVarChar
             , PersonalId Integer, PersonalName TVarChar
             , RouteGroupName TVarChar, RouteId Integer, RouteName TVarChar
             , RouteSortingId Integer, RouteSortingName TVarChar
             , PaidKindId Integer, PaidKindName TVarChar
             , ContractId Integer, ContractCode Integer, ContractName TVarChar, ContractTagName TVarChar
             , PriceListId Integer, PriceListName TVarChar
             , PartnerId Integer, PartnerName TVarChar
             , InfoMoneyGroupName TVarChar, InfoMoneyDestinationName TVarChar, InfoMoneyCode Integer, InfoMoneyName TVarChar
             , PriceWithVAT Boolean, isPrinted Boolean,VATPercent TFloat, ChangePercent TFloat
             , TotalSummVAT TFloat, TotalSummMVAT TFloat, TotalSummPVAT TFloat, TotalSumm TFloat
             , TotalCountKg TFloat, TotalCountSh TFloat, TotalCount TFloat, TotalCountSecond TFloat
             , isEDI Boolean, isPromo Boolean
             , MovementPromo TVarChar
             , Comment TVarChar
              )
AS
$BODY$
   DECLARE vbUserId Integer;
   DECLARE vbPersonalTradeId Integer;
   
   DECLARE vbIsUserOrder  Boolean;
BEGIN
     -- �������� ���� ������������ �� ����� ���������
     -- vbUserId:= lpCheckRight (inSession, zc_Enum_Process_Select_Movement_OrderExternal());
     vbUserId:= lpGetUserBySession (inSession);

     -- ������������ ������� �������
     vbIsUserOrder:= EXISTS (SELECT Object_RoleAccessKeyGuide_View.AccessKeyId_UserOrder FROM Object_RoleAccessKeyGuide_View WHERE Object_RoleAccessKeyGuide_View.UserId = vbUserId AND Object_RoleAccessKeyGuide_View.AccessKeyId_UserOrder > 0);

     vbPersonalTradeId:= (SELECT tmp.PersonalId FROM gpGetMobile_Object_Const (inSession) AS tmp);
     IF (COALESCE(inPersonalTradeId,0) <> 0 AND COALESCE(vbPersonalTradeId,0) <> inPersonalTradeId)
        THEN
            RAISE EXCEPTION '������.�� ���������� ���� �������.'; 
     END IF;

--inPersonalTradeId:=0;
     -- ���������
     RETURN QUERY
     WITH tmpStatus AS (SELECT zc_Enum_Status_Complete()   AS StatusId
                  UNION SELECT zc_Enum_Status_UnComplete() AS StatusId
                  UNION SELECT zc_Enum_Status_Erased()     AS StatusId WHERE inIsErased = TRUE
                       )
        , tmpRoleAccessKey_all AS (SELECT AccessKeyId, UserId FROM Object_RoleAccessKey_View)
        , tmpRoleAccessKey_user AS (SELECT AccessKeyId FROM tmpRoleAccessKey_all WHERE UserId = vbUserId GROUP BY AccessKeyId)
        , tmpAccessKey_IsDocumentAll AS (SELECT 1 AS Id FROM ObjectLink_UserRole_View WHERE RoleId = zc_Enum_Role_Admin() AND UserId = vbUserId
                                   UNION SELECT 1 AS Id FROM tmpRoleAccessKey_user WHERE AccessKeyId = zc_Enum_Process_AccessKey_DocumentAll() AND vbIsUserOrder = FALSE
                                        )
        , tmpRoleAccessKey AS (SELECT tmpRoleAccessKey_user.AccessKeyId FROM tmpRoleAccessKey_user WHERE NOT EXISTS (SELECT tmpAccessKey_IsDocumentAll.Id FROM tmpAccessKey_IsDocumentAll)
                         UNION SELECT tmpRoleAccessKey_all.AccessKeyId FROM tmpRoleAccessKey_all WHERE EXISTS (SELECT tmpAccessKey_IsDocumentAll.Id FROM tmpAccessKey_IsDocumentAll) GROUP BY tmpRoleAccessKey_all.AccessKeyId
                         UNION SELECT 0 AS AccessKeyId WHERE EXISTS (SELECT tmpAccessKey_IsDocumentAll.Id FROM tmpAccessKey_IsDocumentAll)
                              )
        , tmpPartner AS (SELECT ObjectLink_Partner_PersonalTrade.ObjectId AS PartnerId
                         FROM ObjectLink AS ObjectLink_Partner_PersonalTrade
                         WHERE ObjectLink_Partner_PersonalTrade.DescId = zc_ObjectLink_Partner_PersonalTrade()
                           AND ObjectLink_Partner_PersonalTrade.ChildObjectId = inPersonalTradeId --301468 --
                         )
        , tmpMovement AS (SELECT tmp.Id, MovementLinkObject_From.ObjectId  AS FromId
                          FROM
                             (SELECT Movement.id
                              FROM tmpStatus
                                   JOIN Movement ON Movement.OperDate BETWEEN '01.02.2017' AND '28.02.2017'  AND Movement.DescId = zc_Movement_OrderExternal() AND Movement.StatusId = tmpStatus.StatusId
                                   JOIN tmpRoleAccessKey ON tmpRoleAccessKey.AccessKeyId = Movement.AccessKeyId
                              ) AS tmp
                                LEFT JOIN MovementLinkObject AS MovementLinkObject_From
                                       ON MovementLinkObject_From.MovementId = tmp.Id
                                      AND MovementLinkObject_From.DescId = zc_MovementLinkObject_From()
                                LEFT JOIN tmpPartner ON tmpPartner.PartnerId = MovementLinkObject_From.ObjectId
                          WHERE (tmpPartner.PartnerId IS NOT NULL AND COALESCE(inPersonalTradeId,0) <> 0) OR COALESCE(inPersonalTradeId,0) = 0 
                          )

       SELECT
             Movement.Id                                    AS Id
           , Movement.InvNumber                             AS InvNumber
           , Movement.OperDate                              AS OperDate
           , Object_Status.ObjectCode                       AS StatusCode
           , Object_Status.ValueData                        AS StatusName
           , MovementDate_OperDatePartner.ValueData         AS OperDatePartner
           , (Movement.OperDate + ((COALESCE (ObjectFloat_PrepareDayCount.ValueData, 0) + COALESCE (ObjectFloat_DocumentDayCount.ValueData, 0)) :: TVarChar || ' DAY') :: INTERVAL) :: TDateTime AS OperDatePartner_sale
           , MovementDate_OperDateMark.ValueData            AS OperDateMark
           , MovementString_InvNumberPartner.ValueData      AS InvNumberPartner
           , Object_From.Id                                 AS FromId
           , Object_From.ValueData                          AS FromName
           , Object_To.Id                                   AS ToId
           , Object_To.ValueData                            AS ToName
           , Object_Personal.Id                             AS PersonalId
           , Object_Personal.ValueData                      AS PersonalName
           , Object_RouteGroup.ValueData                    AS RouteGroupName
           , Object_Route.Id                                AS RouteId
           , Object_Route.ValueData                         AS RouteName
           , Object_RouteSorting.Id                         AS RouteSortingId
           , Object_RouteSorting.ValueData                  AS RouteSortingName
           , Object_PaidKind.Id                             AS PaidKindId
           , Object_PaidKind.ValueData                      AS PaidKindName
           , View_Contract_InvNumber.ContractId             AS ContractId
           , View_Contract_InvNumber.ContractCode           AS ContractCode
           , View_Contract_InvNumber.InvNumber              AS ContractName
           , View_Contract_InvNumber.ContractTagName        AS ContractTagName
           , Object_PriceList.id                            AS PriceListId
           , Object_PriceList.ValueData                     AS PriceListName
           , Object_Partner.id                              AS PartnerId
           , Object_Partner.ValueData                       AS PartnerName
           , View_InfoMoney.InfoMoneyGroupName              AS InfoMoneyGroupName
           , View_InfoMoney.InfoMoneyDestinationName        AS InfoMoneyDestinationName
           , View_InfoMoney.InfoMoneyCode                   AS InfoMoneyCode
           , View_InfoMoney.InfoMoneyName                   AS InfoMoneyName
           , MovementBoolean_PriceWithVAT.ValueData         AS PriceWithVAT
           , COALESCE (MovementBoolean_Print.ValueData, False) AS isPrinted

           , MovementFloat_VATPercent.ValueData             AS VATPercent
           , MovementFloat_ChangePercent.ValueData          AS ChangePercent
           , CAST (COALESCE (MovementFloat_TotalSummPVAT.ValueData, 0) - COALESCE (MovementFloat_TotalSummMVAT.ValueData, 0) AS TFloat) AS TotalSummVAT
           , MovementFloat_TotalSummMVAT.ValueData          AS TotalSummMVAT
           , MovementFloat_TotalSummPVAT.ValueData          AS TotalSummPVAT
           , MovementFloat_TotalSumm.ValueData              AS TotalSumm
           , MovementFloat_TotalCountKg.ValueData           AS TotalCountKg
           , MovementFloat_TotalCountSh.ValueData           AS TotalCountSh
           , MovementFloat_TotalCount.ValueData             AS TotalCount
           , MovementFloat_TotalCountSecond.ValueData       AS TotalCountSecond
          
           , COALESCE (MovementLinkMovement_Order.MovementId, 0) <> 0 AS isEDI

           , COALESCE (MovementBoolean_Promo.ValueData, FALSE) AS isPromo
           , zfCalc_PromoMovementName (NULL, Movement_Promo.InvNumber :: TVarChar, Movement_Promo.OperDate, MD_StartSale.ValueData, MD_EndSale.ValueData) AS MovementPromo

           , MovementString_Comment.ValueData       AS Comment

       FROM tmpMovement

            LEFT JOIN Movement ON Movement.id = tmpMovement.id

            LEFT JOIN Object AS Object_Status ON Object_Status.Id = Movement.StatusId

            LEFT JOIN MovementDate AS MovementDate_OperDatePartner
                                   ON MovementDate_OperDatePartner.MovementId =  Movement.Id
                                  AND MovementDate_OperDatePartner.DescId = zc_MovementDate_OperDatePartner()

            LEFT JOIN MovementDate AS MovementDate_OperDateMark
                                   ON MovementDate_OperDateMark.MovementId =  Movement.Id
                                  AND MovementDate_OperDateMark.DescId = zc_MovementDate_OperDateMark()

            LEFT JOIN MovementFloat AS MovementFloat_TotalCount
                                    ON MovementFloat_TotalCount.MovementId =  Movement.Id
                                   AND MovementFloat_TotalCount.DescId = zc_MovementFloat_TotalCount()

            LEFT JOIN MovementString AS MovementString_InvNumberPartner
                                     ON MovementString_InvNumberPartner.MovementId =  Movement.Id
                                    AND MovementString_InvNumberPartner.DescId = zc_MovementString_InvNumberPartner()

            LEFT JOIN MovementString AS MovementString_Comment 
                                     ON MovementString_Comment.MovementId = Movement.Id
                                    AND MovementString_Comment.DescId = zc_MovementString_Comment()

            /*LEFT JOIN MovementLinkObject AS MovementLinkObject_From
                                         ON MovementLinkObject_From.MovementId = Movement.Id
                                        AND MovementLinkObject_From.DescId = zc_MovementLinkObject_From()*/
            LEFT JOIN Object AS Object_From ON Object_From.Id = tmpMovement.FromId --MovementLinkObject_From.ObjectId

            LEFT JOIN ObjectFloat AS ObjectFloat_PrepareDayCount  ON ObjectFloat_PrepareDayCount.ObjectId = tmpMovement.FromId AND ObjectFloat_PrepareDayCount.DescId = zc_ObjectFloat_Partner_PrepareDayCount()
            LEFT JOIN ObjectFloat AS ObjectFloat_DocumentDayCount ON ObjectFloat_DocumentDayCount.ObjectId = tmpMovement.FromId AND ObjectFloat_DocumentDayCount.DescId = zc_ObjectFloat_Partner_DocumentDayCount()

            LEFT JOIN MovementLinkObject AS MovementLinkObject_To
                                         ON MovementLinkObject_To.MovementId = Movement.Id
                                        AND MovementLinkObject_To.DescId = zc_MovementLinkObject_To()
            LEFT JOIN Object AS Object_To ON Object_To.Id = MovementLinkObject_To.ObjectId

            LEFT JOIN MovementLinkObject AS MovementLinkObject_Personal
                                         ON MovementLinkObject_Personal.MovementId = Movement.Id
                                        AND MovementLinkObject_Personal.DescId = zc_MovementLinkObject_Personal()
            LEFT JOIN Object AS Object_Personal ON Object_Personal.Id = MovementLinkObject_Personal.ObjectId

            LEFT JOIN MovementLinkObject AS MovementLinkObject_Route
                                         ON MovementLinkObject_Route.MovementId = Movement.Id
                                        AND MovementLinkObject_Route.DescId = zc_MovementLinkObject_Route()
            LEFT JOIN Object AS Object_Route ON Object_Route.Id = MovementLinkObject_Route.ObjectId

            LEFT JOIN ObjectLink AS ObjectLink_Route_RouteGroup ON ObjectLink_Route_RouteGroup.ObjectId = Object_Route.Id
                                                               AND ObjectLink_Route_RouteGroup.DescId = zc_ObjectLink_Route_RouteGroup()
            LEFT JOIN Object AS Object_RouteGroup ON Object_RouteGroup.Id = COALESCE (ObjectLink_Route_RouteGroup.ChildObjectId, Object_Route.Id)

            LEFT JOIN MovementLinkObject AS MovementLinkObject_RouteSorting
                                         ON MovementLinkObject_RouteSorting.MovementId = Movement.Id
                                        AND MovementLinkObject_RouteSorting.DescId = zc_MovementLinkObject_RouteSorting()
            LEFT JOIN Object AS Object_RouteSorting ON Object_RouteSorting.Id = MovementLinkObject_RouteSorting.ObjectId

            LEFT JOIN MovementLinkObject AS MovementLinkObject_PaidKind
                                         ON MovementLinkObject_PaidKind.MovementId = Movement.Id
                                        AND MovementLinkObject_PaidKind.DescId = zc_MovementLinkObject_PaidKind()
            LEFT JOIN Object AS Object_PaidKind ON Object_PaidKind.Id = MovementLinkObject_PaidKind.ObjectId

            LEFT JOIN MovementLinkObject AS MovementLinkObject_Contract
                                         ON MovementLinkObject_Contract.MovementId = Movement.Id
                                        AND MovementLinkObject_Contract.DescId = zc_MovementLinkObject_Contract()
            LEFT JOIN Object_Contract_InvNumber_View AS View_Contract_InvNumber ON View_Contract_InvNumber.ContractId = MovementLinkObject_Contract.ObjectId
            LEFT JOIN Object_InfoMoney_View AS View_InfoMoney ON View_InfoMoney.InfoMoneyId = View_Contract_InvNumber.InfoMoneyId

            LEFT JOIN MovementLinkObject AS MovementLinkObject_PriceList
                                         ON MovementLinkObject_PriceList.MovementId = Movement.Id
                                        AND MovementLinkObject_PriceList.DescId = zc_MovementLinkObject_PriceList()
            LEFT JOIN Object AS Object_PriceList ON Object_PriceList.Id = MovementLinkObject_PriceList.ObjectId

            LEFT JOIN MovementBoolean AS MovementBoolean_PriceWithVAT
                                      ON MovementBoolean_PriceWithVAT.MovementId =  Movement.Id
                                     AND MovementBoolean_PriceWithVAT.DescId = zc_MovementBoolean_PriceWithVAT()

            LEFT JOIN MovementBoolean AS MovementBoolean_Print
                                      ON MovementBoolean_Print.MovementId =  Movement.Id
                                     AND MovementBoolean_Print.DescId = zc_MovementBoolean_Print()

            LEFT JOIN MovementBoolean AS MovementBoolean_Promo
                                      ON MovementBoolean_Promo.MovementId =  Movement.Id
                                     AND MovementBoolean_Promo.DescId = zc_MovementBoolean_Promo()

            LEFT JOIN MovementFloat AS MovementFloat_VATPercent
                                    ON MovementFloat_VATPercent.MovementId =  Movement.Id
                                   AND MovementFloat_VATPercent.DescId = zc_MovementFloat_VATPercent()
            LEFT JOIN MovementFloat AS MovementFloat_ChangePercent
                                    ON MovementFloat_ChangePercent.MovementId =  Movement.Id
                                   AND MovementFloat_ChangePercent.DescId = zc_MovementFloat_ChangePercent()
            LEFT JOIN MovementFloat AS MovementFloat_TotalCountSh
                                    ON MovementFloat_TotalCountSh.MovementId =  Movement.Id
                                   AND MovementFloat_TotalCountSh.DescId = zc_MovementFloat_TotalCountSh()
            LEFT JOIN MovementFloat AS MovementFloat_TotalCountKg
                                    ON MovementFloat_TotalCountKg.MovementId =  Movement.Id
                                   AND MovementFloat_TotalCountKg.DescId = zc_MovementFloat_TotalCountKg()
            LEFT JOIN MovementFloat AS MovementFloat_TotalCountSecond
                                    ON MovementFloat_TotalCountSecond.MovementId =  Movement.Id
                                   AND MovementFloat_TotalCountSecond.DescId = zc_MovementFloat_TotalCountSecond()

            LEFT JOIN MovementFloat AS MovementFloat_TotalSummMVAT
                                    ON MovementFloat_TotalSummMVAT.MovementId =  Movement.Id
                                   AND MovementFloat_TotalSummMVAT.DescId = zc_MovementFloat_TotalSummMVAT()
            LEFT JOIN MovementFloat AS MovementFloat_TotalSummPVAT
                                    ON MovementFloat_TotalSummPVAT.MovementId =  Movement.Id
                                   AND MovementFloat_TotalSummPVAT.DescId = zc_MovementFloat_TotalSummPVAT()
            LEFT JOIN MovementFloat AS MovementFloat_TotalSumm
                                    ON MovementFloat_TotalSumm.MovementId =  Movement.Id
                                   AND MovementFloat_TotalSumm.DescId = zc_MovementFloat_TotalSumm()
       
            LEFT JOIN MovementLinkMovement AS MovementLinkMovement_Order
                                           ON MovementLinkMovement_Order.MovementId = Movement.Id
                                          AND MovementLinkMovement_Order.DescId = zc_MovementLinkMovement_Order()
         
            LEFT JOIN MovementLinkObject AS MovementLinkObject_Partner
                                         ON MovementLinkObject_Partner.MovementId = Movement.Id
                                        AND MovementLinkObject_Partner.DescId = zc_MovementLinkObject_Partner()
            LEFT JOIN Object AS Object_Partner ON Object_Partner.Id = MovementLinkObject_Partner.ObjectId

            LEFT JOIN MovementLinkMovement AS MovementLinkMovement_Promo
                                           ON MovementLinkMovement_Promo.MovementId = Movement.Id
                                          AND MovementLinkMovement_Promo.DescId = zc_MovementLinkMovement_Promo()
            LEFT JOIN Movement AS Movement_Promo ON Movement_Promo.Id = MovementLinkMovement_Promo.MovementChildId
            LEFT JOIN MovementDate AS MD_StartSale
                                   ON MD_StartSale.MovementId =  Movement_Promo.Id
                                  AND MD_StartSale.DescId = zc_MovementDate_StartSale()
            LEFT JOIN MovementDate AS MD_EndSale
                                   ON MD_EndSale.MovementId =  Movement_Promo.Id
                                  AND MD_EndSale.DescId = zc_MovementDate_EndSale()

       WHERE COALESCE (Object_From.DescId, 0) <> zc_Object_Unit();

END;
$BODY$
  LANGUAGE PLPGSQL VOLATILE;
--ALTER FUNCTION gpSelect_Movement_OrderExternal (TDateTime, TDateTime, Boolean, TVarChar) OWNER TO postgres;

/*
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.   ������ �.�.
 07.03.17         * add inPersonalTradeId
 05.10.16         * add inJuridicalBasisId
 25.11.15         * add isPromo
 26.05.15         * add Partner
 20.10.14                                        * add isEDI
 26.08.14                                                        *
 18.08.14                                                        *
 06.06.14                                                        *
*/

-- ����
-- SELECT * FROM gpSelect_Movement_OrderExternal (inStartDate:= '01.11.2015', inEndDate:= '01.11.2015', inIsErased := FALSE, inSession:= zfCalc_UserAdmin())