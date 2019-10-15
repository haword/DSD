-- DROP TABLE IF EXISTS Object_Goods_Juridical_LinkMain;
/*
CREATE TABLE Object_Goods_Juridical_LinkMain (
  ID                  Serial,    -- ID

  GoodsID             integer,   -- Товар поставщика
  GoodsMainID         integer,   -- Связь товаров с главным товаром

  CONSTRAINT Object_Goods_Juridical_LinkMain_pkey PRIMARY KEY(ID)
);

SELECT * FROM Object_Goods_Juridical_LinkMain
LIMIT 1000

*/

--INSERT INTO Object_Goods_Juridical_LinkMain (GoodsID, GoodsMainID)
   SELECT
             Object_Goods.Id
           , ObjectLink_Main.ChildObjectId          AS GoodsMainId


    FROM Object AS Object_Goods

         -- получается GoodsMainId
         LEFT JOIN  ObjectLink AS ObjectLink_Child ON ObjectLink_Child.ChildObjectId = Object_Goods.Id
                                                  AND ObjectLink_Child.DescId = zc_ObjectLink_LinkGoods_Goods()
         LEFT JOIN  ObjectLink AS ObjectLink_Main ON ObjectLink_Main.ObjectId = ObjectLink_Child.ObjectId
                                                 AND ObjectLink_Main.DescId = zc_ObjectLink_LinkGoods_GoodsMain()

         -- связь с Юридические лица или Торговая сеть или ...
         LEFT JOIN ObjectLink AS ObjectLink_Goods_Object
                              ON ObjectLink_Goods_Object.ObjectId = Object_Goods.Id
                             AND ObjectLink_Goods_Object.DescId = zc_ObjectLink_Goods_Object()
         LEFT JOIN Object AS Object_GoodsObject ON Object_GoodsObject.Id = ObjectLink_Goods_Object.ChildObjectId
         LEFT JOIN ObjectDesc AS ObjectDesc_GoodsObject ON ObjectDesc_GoodsObject.Id = Object_GoodsObject.DescId


    WHERE Object_Goods.DescId = zc_Object_Goods()
      AND Object_GoodsObject.DescId = zc_Object_Juridical()
   ;
