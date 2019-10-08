-- DROP TABLE IF EXISTS Object_Goods_BarCode;
/*
CREATE TABLE Object_Goods_BarCode (
  id                  Integer,   -- ID товара

  GoodsMain           integer,   -- Связь с главным товаром

  BarCode             TVarChar,  -- Штрих код

  isErased            Boolean,   -- Признак удален

  PRIMARY KEY (id)
);

select * from Object_Goods_Juridical

*/

SELECT Object_Goods_BarCode.ID
    , ObjectLink_Main_BarCode.ChildObjectId                    AS GoodsMainId
    , Object_Goods_BarCode.ValueData                           AS BarCode
    , Object_Goods_BarCode.isErased                            AS isErased
FROM ObjectLink AS ObjectLink_Main_BarCode
    JOIN ObjectLink AS ObjectLink_Child_BarCode
                    ON ObjectLink_Child_BarCode.ObjectId = ObjectLink_Main_BarCode.ObjectId
                   AND ObjectLink_Child_BarCode.DescId = zc_ObjectLink_LinkGoods_Goods()
    JOIN ObjectLink AS ObjectLink_Goods_Object_BarCode
                    ON ObjectLink_Goods_Object_BarCode.ObjectId = ObjectLink_Child_BarCode.ChildObjectId
                   AND ObjectLink_Goods_Object_BarCode.DescId = zc_ObjectLink_Goods_Object()
                   AND ObjectLink_Goods_Object_BarCode.ChildObjectId = zc_Enum_GlobalConst_BarCode()
    LEFT JOIN Object AS Object_Goods_BarCode ON Object_Goods_BarCode.Id = ObjectLink_Goods_Object_BarCode.ObjectId
WHERE ObjectLink_Main_BarCode.DescId        = zc_ObjectLink_LinkGoods_GoodsMain()
 AND ObjectLink_Main_BarCode.ChildObjectId > 0
 AND TRIM (Object_Goods_BarCode.ValueData) <> ''
 AND LengTh(Object_Goods_BarCode.ValueData) <= 13
 AND zfCheck_BarCode(Object_Goods_BarCode.ValueData, False) = True
 AND Object_Goods_BarCode.ID = 309680