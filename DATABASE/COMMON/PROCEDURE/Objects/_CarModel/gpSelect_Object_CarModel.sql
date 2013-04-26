﻿-- Function: gpSelect_Object_CarModel()

--DROP FUNCTION gpSelect_Object_CarModel();

CREATE OR REPLACE FUNCTION gpSelect_Object_CarModel(
IN inSession     TVarChar       /* текущий пользователь */)
RETURNS TABLE (Id Integer, Code Integer, Name TVarChar, isErased boolean) AS
$BODY$BEGIN

   --PERFORM lpCheckRight(inSession, zc_Enum_Process_User());

   RETURN QUERY 
   SELECT 
     Object.Id
   , Object.ObjectCode
   , Object.ValueData
   , Object.isErased
   FROM Object
   WHERE Object.DescId = zc_Object_CarModel();
  
END;$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100
  ROWS 100;
ALTER FUNCTION gpSelect_Object_CarModel(TVarChar)
  OWNER TO postgres;

-- SELECT * FROM gpSelect_Object_CarModel('2')