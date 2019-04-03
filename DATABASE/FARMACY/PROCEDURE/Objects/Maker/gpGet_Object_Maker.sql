-- Function: gpGet_Object_Maker()

DROP FUNCTION IF EXISTS gpGet_Object_Maker(Integer,TVarChar);

CREATE OR REPLACE FUNCTION gpGet_Object_Maker(
    IN inId          Integer,       -- ���� ������� <>
    IN inSession     TVarChar       -- ������ ������������
)
RETURNS TABLE (Id Integer, Code Integer, Name TVarChar 
             , CountryId Integer, CountryCode Integer, CountryName TVarChar
             , ContactPersonId Integer, ContactPersonCode Integer, ContactPersonName TVarChar
             , SendPlan TDateTime
             , SendReal TDateTime
             , AmountDay TFloat
             , AmountMonth TFloat
             , isReport1  Boolean
             , isReport2  Boolean
             , isReport3  Boolean
             , isReport4  Boolean
             , isQuarter  Boolean
             , isErased   Boolean
             ) AS
$BODY$
BEGIN

  -- �������� ���� ������������ �� ����� ���������
  -- PERFORM lpCheckRight(inSession, zc_Enum_Process_Get_Object_Maker());

   IF COALESCE (inId, 0) = 0 
   THEN
       RETURN QUERY 
       SELECT
             CAST (0 as Integer)    AS Id
           , lfGet_ObjectCode(0, zc_Object_Maker()) AS Code
           , CAST ('' as TVarChar)  AS NAME
           
           , CAST (0 as Integer)   AS CountryId
           , CAST (0 as Integer)   AS CountryCode
           , CAST ('' as TVarChar) AS CountryName

           , CAST (0 as Integer)   AS CountryId
           , CAST (0 as Integer)   AS CountryCode
           , CAST ('' as TVarChar) AS CountryName

           , NULL  :: TDateTime AS SendPlan
           , NULL  :: TDateTime AS SendReal

           , NULL  :: TFloat    AS AmountDay
           , NULL  :: TFloat    AS AmountMonth

           , FALSE :: Boolean   AS isReport1
           , FALSE :: Boolean   AS isReport2
           , FALSE :: Boolean   AS isReport3
           , FALSE :: Boolean   AS isReport4
           , FALSE :: Boolean   AS isQuarter

           , CAST (NULL AS Boolean) AS isErased
           ;
   ELSE
       RETURN QUERY 
       SELECT 
             Object_Maker.Id          AS Id
           , Object_Maker.ObjectCode  AS Code
           , Object_Maker.ValueData   AS Name
           
           , Object_Country.Id    AS CountryId
           , Object_Country.ObjectCode  AS CountryCode
           , Object_Country.ValueData   AS CountryName

           , Object_ContactPerson.Id          AS ContactPersonId
           , Object_ContactPerson.ObjectCode  AS ContactPersonCode
           , Object_ContactPerson.ValueData   AS ContactPersonName

           , COALESCE (ObjectDate_SendPlan.ValueData, NULL) :: TDateTime AS SendPlan
           , COALESCE (ObjectDate_SendReal.ValueData, NULL) :: TDateTime AS SendReal

           , COALESCE (ObjectFloat_Day.ValueData, NULL)   :: TFloat AS AmountDay
           , COALESCE (ObjectFloat_Month.ValueData, NULL) :: TFloat AS AmountMonth

           , COALESCE (ObjectBoolean_Maker_Report1.ValueData, FALSE) :: Boolean AS isReport1
           , COALESCE (ObjectBoolean_Maker_Report2.ValueData, FALSE) :: Boolean AS isReport2
           , COALESCE (ObjectBoolean_Maker_Report3.ValueData, FALSE) :: Boolean AS isReport3
           , COALESCE (ObjectBoolean_Maker_Report4.ValueData, FALSE) :: Boolean AS isReport4
           , COALESCE (ObjectBoolean_Maker_Quarter.ValueData, FALSE) :: Boolean AS isQuarter

           , Object_Maker.isErased AS isErased
           
       FROM Object AS Object_Maker
       
           LEFT JOIN ObjectLink AS ObjectLink_Maker_Country 
                                ON ObjectLink_Maker_Country.ObjectId = Object_Maker.Id 
                               AND ObjectLink_Maker_Country.DescId = zc_ObjectLink_Maker_Country()
           LEFT JOIN Object AS Object_Country ON Object_Country.Id = ObjectLink_Maker_Country.ChildObjectId              

           LEFT JOIN ObjectLink AS ObjectLink_Maker_ContactPerson 
                                ON ObjectLink_Maker_ContactPerson.ObjectId = Object_Maker.Id 
                               AND ObjectLink_Maker_ContactPerson.DescId = zc_ObjectLink_Maker_ContactPerson()
           LEFT JOIN Object AS Object_ContactPerson ON Object_ContactPerson.Id = ObjectLink_Maker_ContactPerson.ChildObjectId 

           LEFT JOIN ObjectDate AS ObjectDate_SendPlan
                                ON ObjectDate_SendPlan.ObjectId = Object_Maker.Id
                               AND ObjectDate_SendPlan.DescId = zc_ObjectDate_Maker_SendPlan()
           LEFT JOIN ObjectDate AS ObjectDate_SendReal
                                ON ObjectDate_SendReal.ObjectId = Object_Maker.Id
                               AND ObjectDate_SendReal.DescId = zc_ObjectDate_Maker_SendReal()

           LEFT JOIN ObjectBoolean AS ObjectBoolean_Maker_Report1
                                   ON ObjectBoolean_Maker_Report1.ObjectId = Object_Maker.Id
                                  AND ObjectBoolean_Maker_Report1.DescId = zc_ObjectBoolean_Maker_Report1()
           LEFT JOIN ObjectBoolean AS ObjectBoolean_Maker_Report2
                                   ON ObjectBoolean_Maker_Report2.ObjectId = Object_Maker.Id
                                  AND ObjectBoolean_Maker_Report2.DescId = zc_ObjectBoolean_Maker_Report2()
           LEFT JOIN ObjectBoolean AS ObjectBoolean_Maker_Report3
                                   ON ObjectBoolean_Maker_Report3.ObjectId = Object_Maker.Id
                                  AND ObjectBoolean_Maker_Report3.DescId = zc_ObjectBoolean_Maker_Report3()
           LEFT JOIN ObjectBoolean AS ObjectBoolean_Maker_Report4
                                   ON ObjectBoolean_Maker_Report4.ObjectId = Object_Maker.Id
                                  AND ObjectBoolean_Maker_Report4.DescId = zc_ObjectBoolean_Maker_Report4()
           LEFT JOIN ObjectBoolean AS ObjectBoolean_Maker_Quarter
                                   ON ObjectBoolean_Maker_Quarter.ObjectId = Object_Maker.Id
                                  AND ObjectBoolean_Maker_Quarter.DescId = zc_ObjectBoolean_Maker_Quarter()

           LEFT JOIN ObjectFloat AS ObjectFloat_Day
                                 ON ObjectFloat_Day.ObjectId = Object_Maker.Id
                                AND ObjectFloat_Day.DescId = zc_ObjectFloat_Maker_Day()
           LEFT JOIN ObjectFloat AS ObjectFloat_Month
                                 ON ObjectFloat_Month.ObjectId = Object_Maker.Id
                                AND ObjectFloat_Month.DescId = zc_ObjectFloat_Maker_Month()

       WHERE Object_Maker.Id = inId;
      
   END IF;
  
END;
$BODY$

LANGUAGE plpgsql VOLATILE;
ALTER FUNCTION gpGet_Object_Maker(integer, TVarChar) OWNER TO postgres;

/*-------------------------------------------------------------------------------
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.   ������ �.�.
 03.04.19                                                       *
 18.01.19         *
 11.01.19         *
 11.02.14         *  

*/

-- ����
-- SELECT * FROM gpGet_Object_Maker (2, '')
