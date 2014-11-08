-- Function: gpSelect_Movement_PriceList()

DROP FUNCTION IF EXISTS gpSelect_GoodsSearch (TVarChar, TVarChar);

CREATE OR REPLACE FUNCTION gpSelect_GoodsSearch(
    IN inGoodsSearch   TVarChar    -- ����� �������
  , IN inSession       TVarChar    -- ������ ������������
)
RETURNS TABLE (Id Integer, CommonCode Integer, BarCode TVarChar, 
               GoodsCode TVarChar, GoodsName TVarChar, GoodsNDS TVarChar, 
               GoodsId Integer, Code Integer, Name TVarChar, 
               Price TFloat, ProducerName TVarChar, JuridicalName TVarChar)

AS
$BODY$
   DECLARE vbUserId Integer;
BEGIN

     -- �������� ���� ������������ �� ����� ���������
     -- PERFORM lpCheckRight (inSession, zc_Enum_Process_Select_Movement_PriceList());
--     vbUserId:= lpGetUserBySession (inSession);

     RETURN QUERY
       SELECT
         LoadPriceListItem.Id, 
         LoadPriceListItem.CommonCode, 
         LoadPriceListItem.BarCode, 
         LoadPriceListItem.GoodsCode, 
         LoadPriceListItem.GoodsName, 
         LoadPriceListItem.GoodsNDS, 
         LoadPriceListItem.GoodsId,
         Object_Goods.ObjectCode AS Code,
         Object_Goods.ValueData  AS Name, 
         LoadPriceListItem.Price, 
         LoadPriceListItem.ProducerName, 
         Object_Juridical.ValueData AS JuridicalName

       FROM LoadPriceListItem 

            JOIN LoadPriceList ON LoadPriceList.Id = LoadPriceListItem.LoadPriceListId
            LEFT JOIN Object AS Object_Goods ON Object_Goods.Id = LoadPriceListItem.GoodsId
            LEFT JOIN Object AS Object_Juridical ON Object_Juridical.Id = LoadPriceList.JuridicalId

      WHERE upper(LoadPriceListItem.GoodsName) LIKE UPPER('%'||inGoodsSearch||'%') AND inGoodsSearch <> ''; 

END;
$BODY$
  LANGUAGE PLPGSQL VOLATILE;
ALTER FUNCTION gpSelect_GoodsSearch (TVarChar, TVarChar) OWNER TO postgres;


/*
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.   ������ �.�.
 29.10.14                        *

*/

-- ����
-- SELECT * FROM gpSelect_Movement_PriceList (inStartDate:= '30.01.2014', inEndDate:= '01.02.2014', inIsErased := FALSE, inSession:= '2')