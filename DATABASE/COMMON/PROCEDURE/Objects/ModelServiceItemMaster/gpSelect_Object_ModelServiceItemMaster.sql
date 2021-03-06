-- Function: gpSelect_Object_ModelServiceItemMaster()

DROP FUNCTION IF EXISTS gpSelect_Object_ModelServiceItemMaster(TVarChar);
DROP FUNCTION IF EXISTS gpSelect_Object_ModelServiceItemMaster(Boolean,TVarChar);

CREATE OR REPLACE FUNCTION gpSelect_Object_ModelServiceItemMaster(
    IN inIsShowAll   Boolean,       --
    IN inSession     TVarChar       -- ������ ������������
)
RETURNS TABLE (Id Integer
             , MovementDescId Integer, MovementDescName TVarChar, Ratio TFloat
             , Comment TVarChar
             , FromId Integer, FromName TVarChar                
             , ToId Integer, ToName TVarChar                
             , SelectKindId Integer, SelectKindName TVarChar  
             , ModelServiceId Integer, ModelServiceName TVarChar  
             , DocumentKindId Integer, DocumentKindName TVarChar  
             , isErased boolean
             ) AS
$BODY$ 
BEGIN

     -- �������� ���� ������������ �� ����� ���������
     -- PERFORM lpCheckRight(inSession, zc_Enum_Process_Select_Object_ModelServiceItemMaster());

   RETURN QUERY 
     SELECT 
           Object_ModelServiceItemMaster.Id    AS Id
 
         , MovementDesc.Id  AS MovementDescId
         , MovementDesc.ItemName  AS MovementDescName
         , ObjectFloat_Ratio.ValueData         AS Ratio
         , ObjectString_Comment.ValueData      AS Comment
                                                        
         , Object_From.Id          AS FromId
         , Object_From.ValueData   AS FromName

         , Object_To.Id         AS ToId
         , Object_To.ValueData  AS ToName

         , Object_SelectKind.Id          AS SelectKindId
         , Object_SelectKind.ValueData   AS SelectKindName
         
         , Object_ModelService.Id         AS ModelServiceId
         , Object_ModelService.ValueData  AS ModelServiceName

         , Object_DocumentKind.Id         AS DocumentKindId
         , Object_DocumentKind.ValueData  AS DocumentKindName

         , Object_ModelServiceItemMaster.isErased AS isErased
         
     FROM OBJECT AS Object_ModelServiceItemMaster
          LEFT JOIN ObjectLink AS ObjectLink_ModelServiceItemMaster_From
                               ON ObjectLink_ModelServiceItemMaster_From.ObjectId = Object_ModelServiceItemMaster.Id
                              AND ObjectLink_ModelServiceItemMaster_From.DescId = zc_ObjectLink_ModelServiceItemMaster_From()
          LEFT JOIN Object AS Object_From ON Object_From.Id = ObjectLink_ModelServiceItemMaster_From.ChildObjectId
 
          LEFT JOIN ObjectLink AS ObjectLink_ModelServiceItemMaster_To
                               ON ObjectLink_ModelServiceItemMaster_To.ObjectId = Object_ModelServiceItemMaster.Id
                              AND ObjectLink_ModelServiceItemMaster_To.DescId = zc_ObjectLink_ModelServiceItemMaster_To()
          LEFT JOIN Object AS Object_To ON Object_To.Id = ObjectLink_ModelServiceItemMaster_To.ChildObjectId

          LEFT JOIN ObjectLink AS ObjectLink_ModelServiceItemMaster_SelectKind
                               ON ObjectLink_ModelServiceItemMaster_SelectKind.ObjectId = Object_ModelServiceItemMaster.Id
                              AND ObjectLink_ModelServiceItemMaster_SelectKind.DescId = zc_ObjectLink_ModelServiceItemMaster_SelectKind()
          LEFT JOIN Object AS Object_SelectKind ON Object_SelectKind.Id = ObjectLink_ModelServiceItemMaster_SelectKind.ChildObjectId
          
          LEFT JOIN ObjectLink AS ObjectLink_ModelServiceItemMaster_ModelService
                               ON ObjectLink_ModelServiceItemMaster_ModelService.ObjectId = Object_ModelServiceItemMaster.Id
                              AND ObjectLink_ModelServiceItemMaster_ModelService.DescId = zc_ObjectLink_ModelServiceItemMaster_ModelService()
          LEFT JOIN Object AS Object_ModelService ON Object_ModelService.Id = ObjectLink_ModelServiceItemMaster_ModelService.ChildObjectId

          LEFT JOIN ObjectLink AS ObjectLink_ModelServiceItemMaster_DocumentKind
                               ON ObjectLink_ModelServiceItemMaster_DocumentKind.ObjectId = Object_ModelServiceItemMaster.Id
                              AND ObjectLink_ModelServiceItemMaster_DocumentKind.DescId = zc_ObjectLink_ModelServiceItemMaster_DocumentKind()
          LEFT JOIN Object AS Object_DocumentKind ON Object_DocumentKind.Id = ObjectLink_ModelServiceItemMaster_DocumentKind.ChildObjectId
          
          LEFT JOIN ObjectFloat AS ObjectFloat_MovementDesc 
                                ON ObjectFloat_MovementDesc.ObjectId = Object_ModelServiceItemMaster.Id 
                               AND ObjectFloat_MovementDesc.DescId = zc_ObjectFloat_ModelServiceItemMaster_MovementDesc()
          LEFT JOIN MovementDesc ON MovementDesc.Id = ObjectFloat_MovementDesc.ValueData
          
          LEFT JOIN ObjectFloat AS ObjectFloat_Ratio 
                                ON ObjectFloat_Ratio.ObjectId = Object_ModelServiceItemMaster.Id 
                               AND ObjectFloat_Ratio.DescId = zc_ObjectFloat_ModelServiceItemMaster_Ratio()
                               
          LEFT JOIN ObjectString AS ObjectString_Comment
                                 ON ObjectString_Comment.ObjectId = Object_ModelServiceItemMaster.Id 
                                AND ObjectString_Comment.DescId = zc_ObjectString_ModelServiceItemMaster_Comment()

     WHERE Object_ModelServiceItemMaster.DescId = zc_Object_ModelServiceItemMaster()
      AND (Object_ModelServiceItemMaster.isErased = False OR inIsShowAll = True);
  
END;
$BODY$

LANGUAGE PLPGSQL VOLATILE;
--ALTER FUNCTION gpSelect_Object_ModelServiceItemMaster (TVarChar) OWNER TO postgres;


/*-------------------------------------------------------------------------------
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.
 02.06.17         * add inIsShowAll
 17.06.16         * DocumentKind
 21.11.13                                        * MovementDescName
 19.10.13         * 
*/

-- ����
-- SELECT * FROM gpSelect_Object_ModelServiceItemMaster (False,'2')