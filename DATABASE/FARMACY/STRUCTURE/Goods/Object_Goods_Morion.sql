-- DROP TABLE IF EXISTS Object_Goods_Morion;
/*
CREATE TABLE Object_Goods_Morion (
  id                  Serial,    -- ID товара

  GoodsMain           integer,   -- Связь с главным товаром

  MorionCode          Integer,   -- Код мариона

  isErased            Boolean,   -- Признак удален

  CONSTRAINT Object_Goods_Morion_pkey PRIMARY KEY(ID)
);

select * from Object_Goods_Juridical

*/

SELECT Object_Goods_Morion.ID
     , ObjectLink_Main_Morion.ChildObjectId          AS GoodsMainId
     , Object_Goods_Morion.ObjectCode                AS MorionCode
     , Object_Goods_Morion.isErased
FROM ObjectLink AS ObjectLink_Main_Morion
     JOIN ObjectLink AS ObjectLink_Child_Morion
                     ON ObjectLink_Child_Morion.ObjectId = ObjectLink_Main_Morion.ObjectId
                    AND ObjectLink_Child_Morion.DescId = zc_ObjectLink_LinkGoods_Goods()
     JOIN ObjectLink AS ObjectLink_Goods_Object_Morion
                     ON ObjectLink_Goods_Object_Morion.ObjectId = ObjectLink_Child_Morion.ChildObjectId
                    AND ObjectLink_Goods_Object_Morion.DescId = zc_ObjectLink_Goods_Object()
                    AND ObjectLink_Goods_Object_Morion.ChildObjectId = zc_Enum_GlobalConst_Marion()
     LEFT JOIN Object AS Object_Goods_Morion ON Object_Goods_Morion.Id = ObjectLink_Goods_Object_Morion.ObjectId
WHERE ObjectLink_Main_Morion.DescId = zc_ObjectLink_LinkGoods_GoodsMain()
  AND ObjectLink_Main_Morion.ChildObjectId > 0
--       GROUP BY ObjectLink_Main_Morion.ChildObjectId