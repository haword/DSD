-- DROP TABLE IF EXISTS Object_Goods;
/*
CREATE TABLE Object_Goods (
  id                  Integer,   -- ID товара
  ObjectCode          Integer,   -- Код товара
  Name                TVarChar,  -- Название товара
  isErased            Boolean,   -- Признак удален

  GoodsGroup          integer,   -- Связь товаров с группой товаров          (zc_ObjectLink_Goods_GoodsGroup)
  Measure             integer,   -- Связь товаров с единицей измерения       (zc_ObjectLink_Goods_Measure)
  NDSKind             integer,   -- Связь товаров с Видом НДС                (ObjectLink_Goods_NDSKind)

  isSP                Boolean,   -- участвует в Соц. проекте                 (zc_ObjectLink_Goods_IntenalSP)

  IntenalSP           integer,   -- Міжнародна непатентована назва (2)(СП)   (zc_ObjectLink_Goods_IntenalSP)
  BrandSP             integer,   -- Торгова назва лікарського засобу (3)(СП) (zc_ObjectLink_Goods_BrandSP)
  KindOutSP           integer,   -- Форма випуску (4)(СП)                    (zc_ObjectLink_Goods_KindOutSP)

  GroupSP             TFloat,    -- Групи відшкоду-вання – І або ІІ                                   (zc_ObjectFloat_Goods_GroupSP)
  PriceSP             TFloat,    -- Розмір відшкодування за упаковку лікарського засобу (15)(СП)      (zc_ObjectFloat_Goods_PriceSP)
  CountSP             Integer,   -- Кількість одиниць лікарського засобу у споживчій упаковці (6)(СП) (zc_ObjectFloat_Goods_CountSP)
  PriceOptSP          TFloat,    -- Оптово-відпускна ціна за упаковку (11)(СП)                        (zc_ObjectFloat_Goods_PriceOptSP)
  PriceRetSP          TFloat,    -- Роздрібна ціна за упаковку (12)(СП)                               (zc_ObjectFloat_Goods_PriceRetSP)
  DailyNormSP         TFloat,    -- Добова доза лікарського засобу, рекомендована ВООЗ (13)(СП)       (zc_ObjectFloat_Goods_DailyNormSP)
  PaymentSP           TFloat,    -- Сума доплати за упаковку (16)(СП)                                 (zc_ObjectFloat_Goods_PaymentSP)
  ColSP               Integer,   -- № п.п.(1)(СП)                                                     (zc_ObjectFloat_Goods_ColSP)
  DailyCompensationSP TFloat,    -- Розмір відшкодування добової дози лікарського засобу (14)(СП)     (zc_ObjectFloat_Goods_DailyCompensationSP)
  ReestrDateSP        TVarChar,  -- Дата закінчення строку дії реєстраційного посвідчення на лікарський засіб(10)(СП) (zc_ObjectString_Goods_ReestrDateSP)
  MakerSP             TVarChar,  -- Найменування виробника, країна(8)(СП)                             (zc_ObjectString_Goods_MakerSP)

  CountPrice          TFloat,    -- Кол-во прайсов                            (zc_ObjectFloat_Goods_CountPrice)

  LastPrice           TDateTime, -- Дата загрузки прайса                      (zc_ObjectDate_Goods_LastPrice)
  LastPriceOld        TDateTime, -- Пред Послед. дата наличия на рынке        (zc_ObjectDate_Goods_LastPriceOld)

  Pack                TVarChar,  -- Сила дії/ дозування (5)(СП)               (zc_ObjectString_Goods_Pack)

  CodeATX             TVarChar,  -- Код АТХ (7)(СП)                           (zc_ObjectString_Goods_CodeATX)

  NameUkr             TVarChar,  -- Название украинское                       (zc_ObjectString_Goods_NameUkr)
  CodeUKTZED          TVarChar,  -- Код УКТЗЭД                                (zc_ObjectString_Goods_CodeUKTZED)
  Analog              TVarChar,  -- Перечень аналогов товара                  (zc_ObjectString_Goods_Analog)

  PRIMARY KEY (id)
);

*/

      WITH GoodsRetail AS (
      SELECT ObjectLink_Main.ChildObjectId                            AS GoodsMainId

           , NULLIF(ObjectString_Goods_NameUkr.ValueData, '')         AS NameUkr
           , NULLIF(ObjectString_Goods_CodeUKTZED.ValueData, '')      AS CodeUKTZED


      FROM Object AS Object_Goods

           -- получается GoodsMainId
           LEFT JOIN  ObjectLink AS ObjectLink_Child ON ObjectLink_Child.ChildObjectId = Object_Goods.Id
                                                    AND ObjectLink_Child.DescId = zc_ObjectLink_LinkGoods_Goods()
           LEFT JOIN  ObjectLink AS ObjectLink_Main ON ObjectLink_Main.ObjectId = ObjectLink_Child.ObjectId
                                                   AND ObjectLink_Main.DescId = zc_ObjectLink_LinkGoods_GoodsMain()

           LEFT JOIN ObjectLink AS ObjectLink_Goods_Object
                                ON ObjectLink_Goods_Object.ObjectId = Object_Goods.Id
                               AND ObjectLink_Goods_Object.DescId = zc_ObjectLink_Goods_Object()
           LEFT JOIN Object AS Object_GoodsObject ON Object_GoodsObject.Id = ObjectLink_Goods_Object.ChildObjectId
           LEFT JOIN ObjectDesc AS ObjectDesc_GoodsObject ON ObjectDesc_GoodsObject.Id = Object_GoodsObject.DescId

           LEFT JOIN ObjectString AS ObjectString_Goods_NameUkr
                                  ON ObjectString_Goods_NameUkr.ObjectId = Object_Goods.Id
                                 AND ObjectString_Goods_NameUkr.DescId = zc_ObjectString_Goods_NameUkr()

           LEFT JOIN ObjectString AS ObjectString_Goods_CodeUKTZED
                                  ON ObjectString_Goods_CodeUKTZED.ObjectId = Object_Goods.Id
                                 AND ObjectString_Goods_CodeUKTZED.DescId = zc_ObjectString_Goods_CodeUKTZED()


      WHERE Object_Goods.DescId = zc_Object_Goods()
        AND Object_GoodsObject.DescId = zc_Object_Retail()
        AND Object_GoodsObject.ID = 4
     )

 SELECT
             ObjectBoolean_Goods_isMain.ObjectId              AS Id
           , Object_Goods.ObjectCode                          AS GoodsCode
           , Object_Goods.ValueData                           AS GoodsName
           , Object_Goods.isErased                            AS isErased

           , ObjectLink_Goods_GoodsGroup.ChildObjectId        AS GoodsGroupId
           , ObjectLink_Goods_Measure.ChildObjectId           AS MeasureId


           , ObjectLink_Goods_NDSKind.ChildObjectId           AS NDSKindId

           , ObjectBoolean_Goods_SP.ValueData                 AS isSP

           , ObjectLink_Goods_IntenalSP.ChildObjectId         AS IntenalSP
           , ObjectLink_Goods_BrandSP.ChildObjectId           AS BrandSP
           , ObjectLink_Goods_KindOutSP.ChildObjectId         AS KindOutSP

           , ObjectFloat_Goods_GroupSP.ValueData              AS GroupSP
           , ObjectFloat_Goods_PriceSP.ValueData              AS PriceSP
           , ObjectFloat_Goods_CountSP.ValueData::Integer     AS CountSP
           , ObjectFloat_Goods_PriceOptSP.ValueData           AS PriceOptSP
           , ObjectFloat_Goods_PriceRetSP.ValueData           AS PriceRetSP
           , ObjectFloat_Goods_DailyNormSP.ValueData          AS DailyNormSP
           , ObjectFloat_Goods_PaymentSP.ValueData            AS PaymentSP
           , ObjectFloat_Goods_ColSP.ValueData::Integer       AS ColSP
           , ObjectFloat_Goods_DailyCompensationSP.ValueData  AS DailyCompensationSP

           , ObjectString_Goods_ReestrDateSP.ValueData        AS ReestrDateSP
           , ObjectString_Goods_MakerSP.ValueData             AS MakerSP

           , ObjectFloat_Goods_CountPrice.ValueData           AS CountPrice

           , ObjectDate_Goods_LastPrice.ValueData             AS LastPrice
           , ObjectDate_Goods_LastPriceOld.ValueData          AS LastPriceOld

           , ObjectString_Goods_Pack.ValueData                AS Pack
           , ObjectString_Goods_CodeATX.ValueData             AS CodeATX

           , GoodsRetail.NameUkr                              AS NameUkr
           , GoodsRetail.CodeUKTZED                           AS CodeUKTZED
           , ObjectString_Goods_Analog.ValueData              AS Analog

       FROM ObjectBoolean AS ObjectBoolean_Goods_isMain

            LEFT JOIN Object AS Object_Goods
                             ON Object_Goods.Id = ObjectBoolean_Goods_isMain.ObjectId

            LEFT JOIN ObjectLink AS ObjectLink_Goods_GoodsGroup
                                 ON ObjectLink_Goods_GoodsGroup.ObjectId = Object_Goods.Id
                                AND ObjectLink_Goods_GoodsGroup.DescId = zc_ObjectBoolean_Goods_First()


            LEFT JOIN ObjectLink AS ObjectLink_Goods_Measure
                                 ON ObjectLink_Goods_Measure.ObjectId = Object_Goods.Id
                                AND ObjectLink_Goods_Measure.DescId = zc_ObjectLink_Goods_Measure()


            LEFT JOIN ObjectLink AS ObjectLink_Goods_NDSKind
                                 ON ObjectLink_Goods_NDSKind.ObjectId = Object_Goods.Id
                                AND ObjectLink_Goods_NDSKind.DescId = zc_ObjectLink_Goods_NDSKind()

            LEFT JOIN ObjectLink AS ObjectLink_Goods_IntenalSP
                                 ON ObjectLink_Goods_IntenalSP.ObjectId = Object_Goods.Id
                                AND ObjectLink_Goods_IntenalSP.DescId = zc_ObjectLink_Goods_IntenalSP()

            LEFT JOIN ObjectLink AS ObjectLink_Goods_BrandSP
                                 ON ObjectLink_Goods_BrandSP.ObjectId = Object_Goods.Id
                                AND ObjectLink_Goods_BrandSP.DescId = zc_ObjectLink_Goods_BrandSP()

            LEFT JOIN ObjectLink AS ObjectLink_Goods_KindOutSP
                                 ON ObjectLink_Goods_KindOutSP.ObjectId = Object_Goods.Id
                                AND ObjectLink_Goods_KindOutSP.DescId = zc_ObjectLink_Goods_KindOutSP()

            LEFT JOIN ObjectFloat AS ObjectFloat_Goods_GroupSP
                                  ON ObjectFloat_Goods_GroupSP.ObjectId = Object_Goods.Id
                                 AND ObjectFloat_Goods_GroupSP.DescId = zc_ObjectFloat_Goods_GroupSP()
            LEFT JOIN ObjectFloat AS ObjectFloat_Goods_PriceSP
                                  ON ObjectFloat_Goods_PriceSP.ObjectId = Object_Goods.Id
                                 AND ObjectFloat_Goods_PriceSP.DescId = zc_ObjectFloat_Goods_PriceSP()
            LEFT JOIN ObjectFloat AS ObjectFloat_Goods_CountSP
                                  ON ObjectFloat_Goods_CountSP.ObjectId = Object_Goods.Id
                                 AND ObjectFloat_Goods_CountSP.DescId = zc_ObjectFloat_Goods_CountSP()
            LEFT JOIN ObjectFloat AS ObjectFloat_Goods_PriceOptSP
                                  ON ObjectFloat_Goods_PriceOptSP.ObjectId = Object_Goods.Id
                                 AND ObjectFloat_Goods_PriceOptSP.DescId = zc_ObjectFloat_Goods_PriceOptSP()
            LEFT JOIN ObjectFloat AS ObjectFloat_Goods_PriceRetSP
                                  ON ObjectFloat_Goods_PriceRetSP.ObjectId = Object_Goods.Id
                                 AND ObjectFloat_Goods_PriceRetSP.DescId = zc_ObjectFloat_Goods_PriceRetSP()
            LEFT JOIN ObjectFloat AS ObjectFloat_Goods_DailyNormSP
                                  ON ObjectFloat_Goods_DailyNormSP.ObjectId = Object_Goods.Id
                                 AND ObjectFloat_Goods_DailyNormSP.DescId = zc_ObjectFloat_Goods_DailyNormSP()
            LEFT JOIN ObjectFloat AS ObjectFloat_Goods_PaymentSP
                                  ON ObjectFloat_Goods_PaymentSP.ObjectId = Object_Goods.Id
                                 AND ObjectFloat_Goods_PaymentSP.DescId = zc_ObjectFloat_Goods_PaymentSP()
            LEFT JOIN ObjectFloat AS ObjectFloat_Goods_ColSP
                                  ON ObjectFloat_Goods_ColSP.ObjectId = Object_Goods.Id
                                 AND ObjectFloat_Goods_ColSP.DescId = zc_ObjectFloat_Goods_ColSP()
            LEFT JOIN ObjectFloat AS ObjectFloat_Goods_DailyCompensationSP
                                  ON ObjectFloat_Goods_DailyCompensationSP.ObjectId = Object_Goods.Id
                                 AND ObjectFloat_Goods_DailyCompensationSP.DescId = zc_ObjectFloat_Goods_DailyCompensationSP()
            LEFT JOIN ObjectString AS ObjectString_Goods_ReestrDateSP
                                   ON ObjectString_Goods_ReestrDateSP.ObjectId = Object_Goods.Id
                                  AND ObjectString_Goods_ReestrDateSP.DescId = zc_ObjectString_Goods_ReestrDateSP()
            LEFT JOIN ObjectString AS ObjectString_Goods_MakerSP
                                   ON ObjectString_Goods_MakerSP.ObjectId = Object_Goods.Id
                                  AND ObjectString_Goods_MakerSP.DescId = zc_ObjectString_Goods_MakerSP()

            LEFT JOIN ObjectFloat AS ObjectFloat_Goods_CountPrice
                                  ON ObjectFloat_Goods_CountPrice.ObjectId = Object_Goods.Id
                                 AND ObjectFloat_Goods_CountPrice.DescId = zc_ObjectFloat_Goods_CountPrice()

            LEFT JOIN ObjectBoolean AS ObjectBoolean_Goods_SP
                                    ON ObjectBoolean_Goods_SP.ObjectId = Object_Goods.Id
                                   AND ObjectBoolean_Goods_SP.DescId = zc_ObjectBoolean_Goods_SP()

            LEFT JOIN ObjectDate AS ObjectDate_Goods_LastPrice
                                 ON ObjectDate_Goods_LastPrice.ObjectId = Object_Goods.Id
                                AND ObjectDate_Goods_LastPrice.DescId = zc_ObjectDate_Goods_LastPrice()

            LEFT JOIN ObjectDate AS ObjectDate_Goods_LastPriceOld
                                 ON ObjectDate_Goods_LastPriceOld.ObjectId = Object_Goods.Id
                                AND ObjectDate_Goods_LastPriceOld.DescId = zc_ObjectDate_Goods_LastPriceOld()

            LEFT JOIN ObjectString AS ObjectString_Goods_Pack
                                   ON ObjectString_Goods_Pack.ObjectId = Object_Goods.Id
                                  AND ObjectString_Goods_Pack.DescId = zc_ObjectString_Goods_Pack()

            LEFT JOIN ObjectString AS ObjectString_Goods_CodeATX
                                   ON ObjectString_Goods_CodeATX.ObjectId = Object_Goods.Id
                                  AND ObjectString_Goods_CodeATX.DescId = zc_ObjectString_Goods_CodeATX()

            LEFT JOIN ObjectString AS ObjectString_Goods_Analog
                                   ON ObjectString_Goods_Analog.ObjectId = Object_Goods.Id
                                  AND ObjectString_Goods_Analog.DescId = zc_ObjectString_Goods_Analog()

            LEFT JOIN GoodsRetail ON GoodsRetail.GoodsMainId = ObjectBoolean_Goods_isMain.ObjectId

   WHERE ObjectBoolean_Goods_isMain.DescId = zc_ObjectBoolean_Goods_isMain();

