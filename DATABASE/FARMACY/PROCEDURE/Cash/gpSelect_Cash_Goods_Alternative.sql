﻿DROP FUNCTION IF EXISTS gpSelect_Cash_Goods_Alternative(TVarChar);
DROP FUNCTION IF EXISTS gpSelect_Cash_Goods_Alternative(Integer,TVarChar);

CREATE OR REPLACE FUNCTION gpSelect_Cash_Goods_Alternative (inMovementId Integer, inSession Tvarchar)
RETURNS TABLE (
  LinkType           integer,
  MainGoodsID        Integer,
  AlternativeGroupId Integer,
  Id                 integer,
  GoodsCode          Integer,
  GoodsName          TVarChar,
  Price              TFloat,
  Remains            TFloat,
  TypeColor          Integer
) AS
$body$
  DECLARE vbUserId Integer;
  DECLARE vbUnitId Integer;
  DECLARE vbObjectId Integer;
  DECLARE vbUnitKey TVarChar;
BEGIN
  vbUserId:= lpGetUserBySession (inSession);
  vbUnitKey := COALESCE(lpGet_DefaultValue('zc_Object_Unit', vbUserId), '');
  IF vbUnitKey = '' THEN
    vbUnitKey := '0';
  END IF;
  vbUnitId := vbUnitKey::Integer;
  vbObjectId := lpGet_DefaultValue('zc_Object_Retail', vbUserId);
  RETURN QUERY
    WITH
    CurrentMovement
    AS
    (
        SELECT
            ObjectId,
            SUM(Amount)::TFloat as Amount
        FROM
            MovementItem
        WHERE
            MovementId = inMovementId
            AND
            Amount <> 0
        Group By
            ObjectId
    ),
    RESERVE
    AS
    (
        SELECT
            MovementItem_Reserve.GoodsId,
            SUM(MovementItem_Reserve.Amount)::TFloat as Amount
        FROM
            gpSelect_MovementItem_CheckDeferred(inSession) as MovementItem_Reserve
        WHERE
            MovementItem_Reserve.MovementId <> inMovementId
        Group By
            MovementItem_Reserve.GoodsId
    ),
    Rem
    AS
      (
        SELECT
            Container.ObjectId    AS GoodsId
           ,(SUM(Container.amount) 
             - COALESCE(CurrentMovement.Amount,0) 
             - COALESCE(Reserve.Amount,0))::TFloat as Remains
        from Container
            Inner Join object_Goods_View ON Container.ObjectId = object_Goods_View.Id
                                        AND object_Goods_View.ObjectId = vbObjectId                             
            LEFT OUTER JOIN RESERVE ON container.objectid = RESERVE.GoodsId
            LEFT OUTER JOIN CurrentMovement ON container.objectid = CurrentMovement.ObjectId                            
        WHERE
            container.descid = zc_container_count()
            AND
            Container.WhereObjectId = vbUnitId
        GROUP BY
            Container.ObjectId
           ,CurrentMovement.Amount
           ,Reserve.Amount
        HAVING
            SUM(Container.Amount)>0
      )
    SELECT
      RES.LinkType                   as LinkType
      ,RES.maingoodsid               as MainGoodsId
      ,RES.AlternativeGroupId        as AlternativeGroupId
      ,Object_Goods.Id               as Id
      ,Object_Goods.objectcode       as GoodsCode
      ,Object_Goods.valuedata        as GoodsName
      ,Object_Price_View.price       as Price
      ,RES.remains::TFloat           as Remains
      ,RES.TypeColor::Integer        as TypeColor
    FROM(  
            Select --Additional Goods
                0                                       as LinkType
               ,zc_Color_Goods_Additional()/*14941410*/ as TypeColor
               ,Object_AdditionalGoods_View.GoodsMainId AS MainGoodsId
               ,0                                       as AlternativeGroupId
               ,Rem.GoodsId                             AS GoodsId
               ,Rem.Remains                             AS Remains
            FROM Rem
               Inner Join Object_AdditionalGoods_View ON Object_AdditionalGoods_View.GoodsSecondId = Rem.GoodsId
            UNION ALL
            Select --Alternative Goods
                1                                                as LinkType
               ,zc_Color_Goods_Alternative()/*16380671*/         as TypeColor
               ,0                                                as MainGoodsId
               ,AlternativeGroup.Id                              as AlternativeGroupId
               ,Rem.GoodsId                                      AS GoodsId
               ,Rem.Remains                                      as Remains
            from Rem
                Inner Join ObjectLink AS ObjectLink_Goods_AlternativeGroup
                                      ON Rem.GoodsId = ObjectLink_Goods_AlternativeGroup.ObjectId
                                     AND ObjectLink_Goods_AlternativeGroup.DescId = zc_objectlink_goods_alternativegroup()
                Inner Join Object AS AlternativeGroup
                                  ON ObjectLink_Goods_AlternativeGroup.ChildObjectId = AlternativeGroup.Id
            Where
                AlternativeGroup.isErased = False
        ) AS RES
        INNER JOIN Object AS Object_Goods
                          ON RES.GoodsId = Object_Goods.id
        LEFT OUTER JOIN Object_Price_View ON RES.GoodsId = Object_Price_View.goodsid
                                         AND Object_Price_View.unitid = vbUnitId
    WHERE
        Object_Goods.IsErased = False                                   
    ORDER BY
        RES.LinkType
       ,RES.maingoodsid
       ,Object_Goods.valuedata;



END;
$body$
LANGUAGE plpgsql VOLATILE;

ALTER FUNCTION gpSelect_Cash_Goods_Alternative(Integer, TVarChar) OWNER TO postgres;

/*
 ИСТОРИЯ РАЗРАБОТКИ: ДАТА, АВТОР
               Фелонюк И.В.   Кухтин И.В.   Климентьев К.И.   Манько Д.А.     Воробкало А.А
 22.08.15                                                                          *inMovementId
 03.07.15                                                                          *

*/

-- тест
--Select * from gpSelect_Cash_Goods_Alternative('308120')
