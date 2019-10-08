-- DROP TABLE IF EXISTS Object_Goods_Retail;
/*
CREATE TABLE Object_Goods_Retail (
  id                  Integer,   -- ID товара
  GoodsMain           integer,   -- Связь товаров с главным товаром
  Retail              integer,   -- Связь товаров с торговой сетью

  ObjectCode          Integer,   -- Код товара
  isErased            Boolean,   -- Признак удален

  Appointment         integer,   -- Назначение товара                          (zc_ObjectLink_Goods_Appointment)
  Exchange            integer,   -- Связь товаров с одиницей виміру            (zc_ObjectLink_Goods_Exchange)
  GoodsGroupPromo     integer,   -- Связь товаров с группой товаров маркетинга (zc_ObjectLink_Goods_GoodsGroupPromo)

  ReferCode           integer,   -- Код референтной цены                       (zc_ObjectFloat_Goods_ReferCode)
  ReferPrice          TFloat,    -- Референтная цена                           (zc_ObjectFloat_Goods_ReferPrice)
  PercentMarkup       TFloat,    -- % наценки                                  (zc_ObjectFloat_Goods_PercentMarkup)
  Price               TFloat,    -- цена реализации                            (zc_ObjectFloat_Goods_Price)

  Site                integer,   -- Ключ товара на сайте                       (zc_ObjectFloat_Goods_Site)
  isClose             Boolean,   -- Закрыт для заказа                          (zc_ObjectBoolean_Goods_Close)
  isTOP               Boolean,   -- ТОП - позиция                              (zc_ObjectBoolean_Goods_TOP)
  isPublished         Boolean,   -- Опубликован на сайте                       (zc_ObjectBoolean_Goods_Published)
  isFirst             Boolean,   -- 1-выбор                                    (zc_ObjectBoolean_Goods_First)
  isSecond            Boolean,   -- Неприоритетный выбор                       (zc_ObjectBoolean_Goods_Second)
  isNotUploadSites    Boolean,   -- Не выгружать для сайтов                    (zc_ObjectBoolean_Goods_isNotUploadSites)
  isDoesNotShare      Boolean,   -- Не делить медикамент на кассах (фармацевты)(zc_ObjectBoolean_Goods_DoesNotShare)
  isAllowDivision     Boolean,   -- Разрешить деление товара на кассе          (zc_ObjectBoolean_Goods_AllowDivision)
  isNotTransferTime   Boolean,   -- Не переводить в сроки                      (zc_ObjectBoolean_Goods_NotTransferTime)

  Foto                TVarChar,  -- Путь к фото                                (zc_ObjectString_Goods_Foto)
  Thumb               TVarChar,  -- Путь к превью фото                         (zc_ObjectString_Goods_Thumb)

  Description         TBlob,     -- Описание товара на сайте                   (zc_objectBlob_Goods_Description)
  NameSite            TBlob,     -- Название товара на сайте                   (zc_objectBlob_Goods_Site)

  PRIMARY KEY (id)
);
*/

   SELECT
             Object_Goods.Id
           , ObjectLink_Main.ChildObjectId                    AS GoodsMainId
           , ObjectLink_Goods_Object.ChildObjectId            AS RetailId

           , Object_Goods.ObjectCode                          AS Code
           , Object_Goods.ValueData                           AS Name
           , Object_Goods.isErased

           , ObjectLink_Goods_Appointment.ChildObjectId       AS Appointment
           , ObjectLink_Goods_Exchange.ChildObjectId          AS Exchange
           , ObjectLink_Goods_GoodsGroupPromo.ChildObjectId   AS GoodsGroupPromo

           , ObjectFloat_Goods_ReferCode.ValueData::Integer   AS ReferCode
           , ObjectFloat_Goods_ReferPrice.ValueData           AS ReferPrice
           , ObjectFloat_Goods_PercentMarkup.ValueData        AS PercentMarkup
           , ObjectFloat_Goods_Price.ValueData                AS Price

           , ObjectFloat_Goods_Site.ValueData::Integer        AS Site
           , ObjectBoolean_Goods_Close.ValueData              AS Close
           , ObjectBoolean_Goods_TOP.ValueData                AS TOP
           , ObjectBoolean_Goods_Published.ValueData          AS Published
           , ObjectBoolean_Goods_First.ValueData              AS First
           , ObjectBoolean_Goods_Second.ValueData             AS Second
           , ObjectBoolean_Goods_isNotUploadSites.ValueData   AS isNotUploadSites
           , ObjectBoolean_Goods_DoesNotShare.ValueData       AS DoesNotShare
           , ObjectBoolean_Goods_AllowDivision.ValueData      AS AllowDivision
           , ObjectBoolean_Goods_NotTransferTime.ValueData    AS NotTransferTime

           , ObjectString_Goods_Foto.ValueData                AS Foto
           , ObjectString_Goods_Thumb.ValueData               AS Thumb

           , ObjectString_Goods_NameUkr.ValueData             AS NameUkr
           , ObjectString_Goods_CodeUKTZED.ValueData          AS CodeUKTZED

           , ObjectBlob_Goods_Description.ValueData           AS Description
           , ObjectBlob_Goods_Site.ValueData                  AS NameSite

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

         LEFT JOIN ObjectLink AS ObjectLink_Goods_Appointment
                              ON ObjectLink_Goods_Appointment.ObjectId = Object_Goods.Id
                             AND ObjectLink_Goods_Appointment.DescId = zc_ObjectLink_Goods_Appointment()

         LEFT JOIN ObjectLink AS ObjectLink_Goods_Exchange
                              ON ObjectLink_Goods_Exchange.ObjectId = Object_Goods.Id
                             AND ObjectLink_Goods_Exchange.DescId = zc_ObjectLink_Goods_Exchange()

         LEFT JOIN ObjectLink AS ObjectLink_Goods_GoodsGroupPromo
                              ON ObjectLink_Goods_GoodsGroupPromo.ObjectId = Object_Goods.Id
                             AND ObjectLink_Goods_GoodsGroupPromo.DescId = zc_ObjectLink_Goods_GoodsGroupPromo()

         LEFT JOIN ObjectFloat AS ObjectFloat_Goods_ReferCode
                               ON ObjectFloat_Goods_ReferCode.ObjectId = Object_Goods.Id
                              AND ObjectFloat_Goods_ReferCode.DescId = zc_ObjectFloat_Goods_ReferCode()
         LEFT JOIN ObjectFloat AS ObjectFloat_Goods_ReferPrice
                               ON ObjectFloat_Goods_ReferPrice.ObjectId = Object_Goods.Id
                              AND ObjectFloat_Goods_ReferPrice.DescId = zc_ObjectFloat_Goods_ReferPrice()
         LEFT JOIN ObjectFloat AS ObjectFloat_Goods_PercentMarkup
                               ON ObjectFloat_Goods_PercentMarkup.ObjectId = Object_Goods.Id
                              AND ObjectFloat_Goods_PercentMarkup.DescId = zc_ObjectFloat_Goods_PercentMarkup()
         LEFT JOIN ObjectFloat AS ObjectFloat_Goods_Price
                               ON ObjectFloat_Goods_Price.ObjectId = Object_Goods.Id
                              AND ObjectFloat_Goods_Price.DescId = zc_ObjectFloat_Goods_Price()

         LEFT JOIN ObjectFloat AS ObjectFloat_Goods_Site
                               ON ObjectFloat_Goods_Site.ObjectId = Object_Goods.Id
                              AND ObjectFloat_Goods_Site.DescId = zc_ObjectFloat_Goods_Site()

         LEFT JOIN ObjectBoolean AS ObjectBoolean_Goods_Close
                                 ON ObjectBoolean_Goods_Close.ObjectId = Object_Goods.Id
                                AND ObjectBoolean_Goods_Close.DescId = zc_ObjectBoolean_Goods_Close()

         LEFT JOIN ObjectBoolean AS ObjectBoolean_Goods_TOP
                                 ON ObjectBoolean_Goods_TOP.ObjectId = Object_Goods.Id
                                AND ObjectBoolean_Goods_TOP.DescId = zc_ObjectBoolean_Goods_TOP()

         LEFT JOIN ObjectBoolean AS ObjectBoolean_Goods_Published
                                 ON ObjectBoolean_Goods_Published.ObjectId = Object_Goods.Id
                                AND ObjectBoolean_Goods_Published.DescId = zc_ObjectBoolean_Goods_Published()

         LEFT JOIN ObjectBoolean AS ObjectBoolean_Goods_First
                                 ON ObjectBoolean_Goods_First.ObjectId = Object_Goods.Id
                                AND ObjectBoolean_Goods_First.DescId = zc_ObjectBoolean_Goods_First()

         LEFT JOIN ObjectBoolean AS ObjectBoolean_Goods_Second
                                 ON ObjectBoolean_Goods_Second.ObjectId = Object_Goods.Id
                                AND ObjectBoolean_Goods_Second.DescId = zc_ObjectBoolean_Goods_Second()

         LEFT JOIN ObjectBoolean AS ObjectBoolean_Goods_isNotUploadSites
                                 ON ObjectBoolean_Goods_isNotUploadSites.ObjectId = Object_Goods.Id
                                AND ObjectBoolean_Goods_isNotUploadSites.DescId = zc_ObjectBoolean_Goods_isNotUploadSites()

         LEFT JOIN ObjectBoolean AS ObjectBoolean_Goods_DoesNotShare
                                 ON ObjectBoolean_Goods_DoesNotShare.ObjectId = Object_Goods.Id
                                AND ObjectBoolean_Goods_DoesNotShare.DescId = zc_ObjectBoolean_Goods_DoesNotShare()

         LEFT JOIN ObjectBoolean AS ObjectBoolean_Goods_AllowDivision
                                 ON ObjectBoolean_Goods_AllowDivision.ObjectId = Object_Goods.Id
                                AND ObjectBoolean_Goods_AllowDivision.DescId = zc_ObjectBoolean_Goods_AllowDivision()

         LEFT JOIN ObjectBoolean AS ObjectBoolean_Goods_NotTransferTime
                                 ON ObjectBoolean_Goods_NotTransferTime.ObjectId = Object_Goods.Id
                                AND ObjectBoolean_Goods_NotTransferTime.DescId = zc_ObjectBoolean_Goods_NotTransferTime()

         LEFT JOIN ObjectString AS ObjectString_Goods_Foto
                                ON ObjectString_Goods_Foto.ObjectId = Object_Goods.Id
                               AND ObjectString_Goods_Foto.DescId = zc_ObjectString_Goods_Foto()

         LEFT JOIN ObjectString AS ObjectString_Goods_Thumb
                                ON ObjectString_Goods_Thumb.ObjectId = Object_Goods.Id
                               AND ObjectString_Goods_Thumb.DescId = zc_ObjectString_Goods_Thumb()

         LEFT JOIN ObjectString AS ObjectString_Goods_NameUkr
                                ON ObjectString_Goods_NameUkr.ObjectId = Object_Goods.Id
                               AND ObjectString_Goods_NameUkr.DescId = zc_ObjectString_Goods_NameUkr()

         LEFT JOIN ObjectString AS ObjectString_Goods_CodeUKTZED
                                ON ObjectString_Goods_CodeUKTZED.ObjectId = Object_Goods.Id
                               AND ObjectString_Goods_CodeUKTZED.DescId = zc_ObjectString_Goods_CodeUKTZED()

         LEFT JOIN ObjectBlob AS ObjectBlob_Goods_Description
                              ON ObjectBlob_Goods_Description.ObjectId = Object_Goods.Id
                             AND ObjectBlob_Goods_Description.DescId = zc_objectBlob_Goods_Description()
                             AND ObjectBlob_Goods_Description.ValueData Is Not Null

         LEFT JOIN ObjectBlob AS ObjectBlob_Goods_Site
                              ON ObjectBlob_Goods_Site.ObjectId = Object_Goods.Id
                             AND ObjectBlob_Goods_Site.DescId = zc_objectBlob_Goods_Site()
                             AND ObjectBlob_Goods_Site.ValueData Is Not Null

    WHERE Object_Goods.DescId = zc_Object_Goods()
      AND Object_GoodsObject.DescId = zc_Object_Retail()
      AND Object_GoodsObject.ID <> 4
      AND ObjectString_Goods_NameUkr.ValueData Is Not Null
    ORDER BY Object_Goods.Id
    LIMIT 1000
   ;
