-- Function: gpSelect_Object_ImportSettings()

DROP FUNCTION IF EXISTS gpGet_Object_ImportSettings(Integer, TVarChar);

CREATE OR REPLACE FUNCTION gpGet_Object_ImportSettings(
    IN inId          Integer , 
    IN inSession     TVarChar       -- ������ ������������
)
RETURNS TABLE (Id Integer, Code Integer, Name TVarChar,
               JuridicalId Integer, JuridicalName TVarChar,
               ContractId Integer, ContractName TVarChar,
               FileTypeId Integer, FileTypeName TVarChar,
               ImportTypeId Integer, ImportTypeName TVarChar,
               StartRow Integer,
               Directory TVarChar,
               isErased boolean, 
               ProcedureName TVarChar) AS
$BODY$
BEGIN

   -- �������� ���� ������������ �� ����� ���������
   -- PERFORM lpCheckRight(inSession, zc_Enum_Process_ImportSettings());

   RETURN QUERY 
       SELECT 
             Object_ImportSettings_View.Id
           , Object_ImportSettings_View.Code
           , Object_ImportSettings_View.Name
         
           , Object_ImportSettings_View.JuridicalId
           , Object_ImportSettings_View.JuridicalName 
                     
           , Object_ImportSettings_View.ContractId
           , Object_ImportSettings_View.ContractName 
           
           , Object_ImportSettings_View.FileTypeId
           , Object_ImportSettings_View.FileTypeName 
           
           , Object_ImportSettings_View.ImportTypeId
           , Object_ImportSettings_View.ImportTypeName 
           
           , Object_ImportSettings_View.StartRow
           , Object_ImportSettings_View.Directory
           
           , Object_ImportSettings_View.isErased
           , Object_ImportSettings_View.ProcedureName
           
       FROM Object_ImportSettings_View WHERE Object_ImportSettings_View.Id = inId;
  
END;
$BODY$

LANGUAGE plpgsql VOLATILE;
ALTER FUNCTION gpGet_Object_ImportSettings(Integer, TVarChar) OWNER TO postgres;

/*-------------------------------------------------------------------------------*/
/*
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.
 04.09.14                        *
 02.07.14         *

*/

-- ����
-- SELECT * FROM gpGet_Object_ImportSettings ('2')