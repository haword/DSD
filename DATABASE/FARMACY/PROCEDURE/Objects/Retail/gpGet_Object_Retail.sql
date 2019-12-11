-- Function: gpGet_Object_Retail()

DROP FUNCTION IF EXISTS gpGet_Object_Retail(integer, TVarChar);

CREATE OR REPLACE FUNCTION gpGet_Object_Retail(
    IN inId          Integer,       -- ���� ������� <�������� ����>
    IN inSession     TVarChar       -- ������ ������������
)
RETURNS TABLE (Id Integer, Code Integer, Name TVarChar
             , MarginPercent TFloat
             , SummSUN TFloat
             , LimitSUN TFloat
             , ShareFromPrice TFloat
             , isErased Boolean) AS
$BODY$
BEGIN

   -- �������� ���� ������������ �� ����� ���������
   -- PERFORM lpCheckRight(inSession, zc_Enum_Process_User());

   IF COALESCE (inId, 0) = 0
   THEN
       RETURN QUERY 
       SELECT
             CAST (0 as Integer)     AS Id
           , lfGet_ObjectCode(0, zc_Object_Retail()) AS Code
           , CAST ('' as TVarChar)   AS Name
           , CAST (0 AS TFloat)      AS MarginPercent
           , CAST (0 AS TFloat)      AS SummSUN
           , CAST (0 AS TFloat)      AS LimitSUN
           , CAST (0 AS TFloat)      AS ShareFromPrice

           , CAST (NULL AS Boolean)  AS isErased;
   ELSE
       RETURN QUERY 
       SELECT 
             Object_Retail.Id         AS Id
           , Object_Retail.ObjectCode AS Code
           , Object_Retail.ValueData  AS Name

           , COALESCE (ObjectFloat_MarginPercent.ValueData, 0) :: TFloat AS MarginPercent
           , COALESCE (ObjectFloat_SummSUN.ValueData, 0)       :: TFloat AS SummSUN
           , COALESCE (ObjectFloat_LimitSUN.ValueData, 0)      :: TFloat AS LimitSUN
           , COALESCE (ObjectFloat_ShareFromPrice.ValueData, 0):: TFloat AS ShareFromPrice

           , Object_Retail.isErased   AS isErased
       FROM Object AS Object_Retail
            LEFT JOIN ObjectFloat AS ObjectFloat_MarginPercent
                                  ON ObjectFloat_MarginPercent.ObjectId = Object_Retail.Id 
                                 AND ObjectFloat_MarginPercent.DescId = zc_ObjectFloat_Retail_MarginPercent()
            LEFT JOIN ObjectFloat AS ObjectFloat_SummSUN
                                  ON ObjectFloat_SummSUN.ObjectId = Object_Retail.Id 
                                 AND ObjectFloat_SummSUN.DescId = zc_ObjectFloat_Retail_SummSUN()
            LEFT JOIN ObjectFloat AS ObjectFloat_LimitSUN
                                  ON ObjectFloat_LimitSUN.ObjectId = Object_Retail.Id 
                                 AND ObjectFloat_LimitSUN.DescId = zc_ObjectFloat_Retail_LimitSUN()
            LEFT JOIN ObjectFloat AS ObjectFloat_ShareFromPrice
                                  ON ObjectFloat_ShareFromPrice.ObjectId = Object_Retail.Id 
                                 AND ObjectFloat_ShareFromPrice.DescId = zc_ObjectFloat_Retail_ShareFromPrice()
       WHERE Object_Retail.Id = inId;

   END IF; 
  
END;
$BODY$

LANGUAGE plpgsql VOLATILE;

/*-------------------------------------------------------------------------------
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.   ������ �.�.
 11.12.19                                                       * LimitSUN
 23.07.19         * SummSUN
 25.03.19         *
*/

-- ����
-- SELECT * FROM gpGet_Object_Retail (0, '2')
