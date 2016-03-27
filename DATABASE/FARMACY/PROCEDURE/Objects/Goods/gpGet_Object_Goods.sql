-- Function: gpGet_Object_Goods()

DROP FUNCTION IF EXISTS gpGet_Object_Goods(Integer, TVarChar);

CREATE OR REPLACE FUNCTION gpGet_Object_Goods(
    IN inId          Integer,       -- ����� 
    IN inSession     TVarChar       -- ������ ������������
)
RETURNS TABLE (Id Integer, Code Integer, Name TVarChar, 
               GoodsGroupId Integer, GoodsGroupName TVarChar,
               MeasureId Integer, MeasureName TVarChar,
               NDSKindId Integer, NDSKindName TVarChar,
               MinimumLot TFloat, ReferCode TFloat, ReferPrice TFloat, Price TFloat, 
               isClose boolean, 
               isTOP boolean, PercentMarkup TFloat,  isUpload Boolean,
               isErased boolean
               ) AS
$BODY$
  DECLARE vbUserId Integer;
  DECLARE vbObjectId Integer;
BEGIN
     -- �������� ���� ������������ �� ����� ���������
     -- vbUserId:= lpCheckRight(inSession, zc_Enum_Process_...());
     vbUserId:= lpGetUserBySession (inSession);

  
   IF COALESCE (inId, 0) = 0
   THEN
       -- ����� <�������� ����>
       vbObjectId := lpGet_DefaultValue ('zc_Object_Retail', vbUserId);

       -- ���������
       RETURN QUERY
       SELECT
             CAST (0 as Integer)    AS Id
           , GoodsCodeIntNew        AS Code
           , CAST ('' AS TVarChar)  AS Name
              
           , CAST (0 as Integer)    AS GoodsGroupId
           , CAST ('' as TVarChar)  AS GoodsGroupName  
           , COALESCE(ObjectMeasure.Id, 0)  AS MeasureId
           , COALESCE(ObjectMeasure.ValueData, ''::TVarChar)  AS MeasureName
           , COALESCE(ObjectNDSKind.Id, 0)  AS NDSKindId
           , COALESCE(ObjectNDSKind.ValueData, ''::TVarChar)  AS NDSKindName

           , 0::TFloat     AS MinimumLot
           , 0::TFloat     AS ReferCode
           , 0::TFloat     AS ReferPrice
           , 0::TFloat     AS Price
           , false         AS isClose
           , false         AS isTOP
           , 0::TFloat     AS PercentMarkup
           , false         AS isUpload
           , CAST (NULL AS Boolean) AS isErased

       FROM (SELECT lfGet_ObjectCode_byRetail (vbObjectId, 0, zc_Object_Goods()) AS GoodsCodeIntNew) AS Object_Goods
            LEFT JOIN Object AS ObjectMeasure ON ObjectMeasure.Id = lpGet_DefaultValue('TGoodsEditForm;zc_Object_Measure', vbUserId) :: Integer
            LEFT JOIN Object AS ObjectNDSKind ON ObjectNDSKind.Id = lpGet_DefaultValue('TGoodsEditForm;zc_Object_NDSKind', vbUserId) :: Integer
      ;

   ELSE

     -- ���������
     RETURN QUERY 
     SELECT Object_Goods_View.Id             AS Id 
          , Object_Goods_View.GoodsCodeInt   AS Code
          , Object_Goods_View.GoodsName      AS Name
          
          , COALESCE(Object_Goods_View.GoodsGroupId, 0)   AS GoodsGroupId
          , Object_Goods_View.GoodsGroupName AS GoodsGroupName
   
          , Object_Goods_View.MeasureId      AS MeasureId
          , Object_Goods_View.MeasureName    AS MeasureName
   
          , Object_Goods_View.NDSKindId      AS NDSKindId
          , Object_Goods_View.NDSKindName    AS NDSKindName

          , Object_Goods_View.MinimumLot     AS MinimumLot
          , ObjectFloat_Goods_ReferCode.ValueData  AS ReferCode
          , ObjectFloat_Goods_ReferPrice.ValueData AS ReferPrice
          , Object_Goods_View.Price          AS Price

          , Object_Goods_View.isClose        AS isClose

          , Object_Goods_View.isTOP          AS isTOP
          , Object_Goods_View.PercentMarkup  AS PercentMarkup

          , Object_Goods_View.IsUpload       AS isUpload
          
          , Object_Goods_View.isErased       AS isErased
          
     FROM Object_Goods_View
          LEFT JOIN ObjectFloat  AS ObjectFloat_Goods_ReferCode
                                 ON ObjectFloat_Goods_ReferCode.ObjectId = Object_Goods_View.Id 
                                AND ObjectFloat_Goods_ReferCode.DescId = zc_ObjectFloat_Goods_ReferCode()   
          LEFT JOIN ObjectFloat  AS ObjectFloat_Goods_ReferPrice
                                 ON ObjectFloat_Goods_ReferPrice.ObjectId = Object_Goods_View.Id 
                                AND ObjectFloat_Goods_ReferPrice.DescId = zc_ObjectFloat_Goods_ReferPrice()   
     WHERE Object_Goods_View.Id = inId;

  END IF;
  
END;
$BODY$
  LANGUAGE plpgsql VOLATILE;
ALTER FUNCTION gpGet_Object_Goods(integer, TVarChar) OWNER TO postgres;

/*-------------------------------------------------------------------------------*/
/*
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.
 25.03.16                                        *
 10.06.15                        *  
 23.03.15                        *  
 16.02.15                        *  
 13.11.14                        *  �������
 30.10.14                        *
 24.06.14         *
 20.06.13                        *
*/

-- ����
-- SELECT * FROM gpGet_Object_Goods (zfCalc_UserAdmin())
