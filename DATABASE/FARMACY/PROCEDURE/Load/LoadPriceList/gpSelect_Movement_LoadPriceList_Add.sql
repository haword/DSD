 -- Function: gpSelect_Movement_LoadPriceList_Add()

DROP FUNCTION IF EXISTS gpSelect_Movement_LoadPriceList_Add (TVarChar);

CREATE OR REPLACE FUNCTION gpSelect_Movement_LoadPriceList_Add(
    IN inSession       TVarChar    -- ������ ������������
)
RETURNS TABLE (Id Integer, OperDate TDateTime
             , JuridicalId Integer, JuridicalName TVarChar
             , AreaId Integer, AreaName TVarChar
             , ContractId Integer, ContractName TVarChar
             , MemberId Integer, MemberName TVarChar       -- ���. �� �����
             , InsertName TVarChar, InsertDate TDateTime
             , UpdateName TVarChar, UpdateDate TDateTime
             , isAllGoodsConcat Boolean, NDSinPrice Boolean
             , isMoved Boolean
             , Amount_all    TFloat
             , Amount_tied   TFloat
             , Amount_untied TFloat
           )

AS
$BODY$
   DECLARE vbUserId Integer;
BEGIN

     -- �������� ���� ������������ �� ����� ���������
     -- PERFORM lpCheckRight (inSession, zc_Enum_Process_Select_Movement_PriceList());
--     vbUserId:= lpGetUserBySession (inSession);

     RETURN QUERY
     WITH
       tmpLoadPriceListItem AS (SELECT LoadPriceListItem.LoadPriceListId
                                     , COUNT (*)                                                                      AS Amount_all     -- ����� �������
                                     , SUM (CASE WHEN COALESCE (LoadPriceListItem.GoodsId, 0) <> 0 THEN 1 ELSE 0 END) AS Amount_tied    --�����������
                                     , SUM (CASE WHEN COALESCE (LoadPriceListItem.GoodsId, 0) <> 0 THEN 0 ELSE 1 END) AS Amount_untied  -- �� �����������
                                FROM LoadPriceListItem 
                                GROUP BY LoadPriceListItem.LoadPriceListId
                               )

       SELECT
             LoadPriceList.Id               AS Id
           , LoadPriceList.OperDate	    AS OperDate -- ���� ���������
           , Object_Juridical.Id            AS JuridicalId
           , Object_Juridical.ValueData     AS JuridicalName
           , Object_Area.Id                 AS AreaId
           , Object_Area.ValueData          AS AreaName
           , Object_Contract.Id             AS ContractId
           , Object_Contract.ValueData      AS ContractName

           , Object_Member.Id               AS MemberId
           , Object_Member.ValueData        AS MemberName

           , Object_User_Insert.ValueData   AS InsertName
           , LoadPriceList.Date_Insert      AS InsertDate

           , Object_User_Update.ValueData   AS UpdateName
           , LoadPriceList.Date_Update      AS UpdateDate
          
           , LoadPriceList.isAllGoodsConcat           
           , LoadPriceList.NDSinPrice           
           , COALESCE (LoadPriceList.isMoved, FALSE) :: Boolean AS isMoved
           
           , tmpLoadPriceListItem.Amount_all     ::TFloat
           , tmpLoadPriceListItem.Amount_tied    ::TFloat
           , tmpLoadPriceListItem.Amount_untied  ::TFloat
       FROM LoadPriceList
            LEFT JOIN Object AS Object_Juridical ON Object_Juridical.Id = LoadPriceList.JuridicalId
            
            LEFT JOIN Object AS Object_Contract ON Object_Contract.Id = LoadPriceList.ContractId

            LEFT JOIN Object AS Object_User_Insert ON Object_User_Insert.Id = LoadPriceList.UserId_Insert
            LEFT JOIN Object AS Object_User_Update ON Object_User_Update.Id = LoadPriceList.UserId_Update
            
            LEFT JOIN Object AS Object_Area ON Object_Area.Id = LoadPriceList.AreaId  
            
            LEFT JOIN tmpLoadPriceListItem ON tmpLoadPriceListItem.LoadPriceListId = LoadPriceList.Id

            LEFT JOIN ObjectLink AS ObjectLink_Contract_Member
                                 ON ObjectLink_Contract_Member.ObjectId = LoadPriceList.ContractId
                                AND ObjectLink_Contract_Member.DescId = zc_ObjectLink_Contract_Member()
            LEFT JOIN Object AS Object_Member ON Object_Member.Id = ObjectLink_Contract_Member.ChildObjectId

       ORDER BY LoadPriceList.Date_Insert ASC, LoadPriceList.Id ASC
      ;

END;
$BODY$
  LANGUAGE PLPGSQL VOLATILE;

/*
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.
 23.09.18         *
 10.10.17         * LoadPriceList.AreaId
 25.09.17         * add AreaName
 01.07.14                        *

*/

-- ����
-- SELECT * FROM gpSelect_Movement_LoadPriceList_Add (inSession:= '2') AS tmp WHERE isMoved = FALSE;
