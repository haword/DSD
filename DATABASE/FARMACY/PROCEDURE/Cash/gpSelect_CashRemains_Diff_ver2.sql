-- Function: gpSelect_CashRemains_ver2()

DROP FUNCTION IF EXISTS gpSelect_CashRemains_ver2 (TVarChar, TVarChar);

CREATE OR REPLACE FUNCTION gpSelect_CashRemains_ver2(
    IN inCashSessionId TVarChar,   -- ������ ��������� �����
    IN inSession       TVarChar    -- ������ ������������
)
RETURNS TABLE (Id Integer, GoodsId_main Integer, GoodsGroupName TVarChar, GoodsName TVarChar, GoodsCode Integer,
               Remains TFloat, Price TFloat, PriceSP TFloat, PriceSaleSP TFloat, DiffSP1 TFloat, DiffSP2 TFloat, Reserved TFloat, MCSValue TFloat,
               AlternativeGroupId Integer, NDS TFloat,
               isFirst boolean, isSecond boolean, Color_calc Integer,
               isPromo boolean, MakerName TVarChar,
               isSP boolean,
               IntenalSPName TVarChar,
               MinExpirationDate TDateTime,
               PartionDateKindId  Integer,
               PartionDateKindName  TVarChar,
               Color_ExpirationDate Integer,
               ConditionsKeepName TVarChar,
               AmountIncome TFloat, PriceSaleIncome TFloat,
               MorionCode Integer, BarCode TVarChar,
               MCSValueOld TFloat,
               StartDateMCSAuto TDateTime, EndDateMCSAuto TDateTime,
               isMCSAuto Boolean, isMCSNotRecalcOld Boolean,
               AccommodationId Integer, AccommodationName TVarChar,
               PriceChange TFloat, FixPercent TFloat, Multiplicity TFloat,
               DoesNotShare boolean, GoodsAnalogId Integer, GoodsAnalogName TVarChar, GoodsAnalog TVarChar,
               CountSP TFloat, IdSP TVarChar, DosageIdSP TVarChar, PriceRetSP TFloat, PaymentSP TFloat,
               AmountMonth TFloat, PricePartionDate TFloat,
               PartionDateDiscount TFloat,
               NotSold boolean
             , PartionDateKindId_check   Integer
             , Price_check               TFloat
             , PriceWithVAT_check        TFloat
             , PartionDateDiscount_check TFloat
              )
AS
$BODY$
   DECLARE vbUserId Integer;
   DECLARE vbUnitId Integer;
   DECLARE vbUnitKey TVarChar;
   DECLARE vbObjectId Integer;
   DECLARE vbRetailId Integer;

   DECLARE vbOperDate_StartBegin TDateTime;
   DECLARE vb1 TVarChar;
   DECLARE vb2 TVarChar;

   DECLARE vbDay_6  Integer;
   DECLARE vbDate_6 TDateTime;
   DECLARE vbDate_1 TDateTime;
   DECLARE vbDate_0 TDateTime;

   DECLARE vbDividePartionDate   boolean;

   DECLARE vbAreaId   Integer;
BEGIN
-- if inSession = '3' then return; end if;

    -- !!!�������� - ������� ��������!!!
    vbOperDate_StartBegin:= CLOCK_TIMESTAMP();


    -- �������� ���� ������������ �� ����� ���������
    -- PERFORM lpCheckRight (inSession, zc_Enum_Process_Select_Movement_Income());
    vbUserId:= lpGetUserBySession (inSession);
    vbUnitKey := COALESCE(lpGet_DefaultValue('zc_Object_Unit', vbUserId), '');
    IF vbUnitKey = '' THEN
       vbUnitKey := '0';
    END IF;
    vbUnitId := vbUnitKey::Integer;

    vbRetailId := (SELECT ObjectLink_Juridical_Retail.ChildObjectId AS RetailId
                   FROM ObjectLink AS ObjectLink_Unit_Juridical
                        INNER JOIN ObjectLink AS ObjectLink_Juridical_Retail
                                              ON ObjectLink_Juridical_Retail.ObjectId = ObjectLink_Unit_Juridical.ChildObjectId
                                             AND ObjectLink_Juridical_Retail.DescId = zc_ObjectLink_Juridical_Retail()
                   WHERE ObjectLink_Unit_Juridical.ObjectId = vbUnitId
                     AND ObjectLink_Unit_Juridical.DescId = zc_ObjectLink_Unit_Juridical());

    -- ��� �����
    -- IF inSession = '3' then vbUnitId:= 1781716; END IF;

    -- ���� ������������
    vbObjectId := COALESCE (lpGet_DefaultValue('zc_Object_Retail', vbUserId), '0');
    -- ��������� ������ ������������
    vbAreaId:= (SELECT outAreaId FROM gpGet_Area_byUser (inSession));
    --
    IF COALESCE (vbAreaId, 0) = 0
    THEN
        vbAreaId:= (SELECT AreaId FROM gpGet_User_AreaId (inSession));
    END IF;


    -- �������� ��� ���������� �� ������
    -- ���� + 6 �������
    SELECT CURRENT_DATE + tmp.Date_6, tmp.Day_6
           INTO vbDate_6, vbDay_6
    FROM (WITH tmp AS (SELECT CASE WHEN ObjectFloat_Day.ValueData > 0 THEN ObjectFloat_Day.ValueData ELSE COALESCE (ObjectFloat_Month.ValueData, 0) END AS Value
                            , CASE WHEN ObjectFloat_Day.ValueData > 0 THEN FALSE ELSE TRUE END AS isMonth
                       FROM Object  AS Object_PartionDateKind
                            LEFT JOIN ObjectFloat AS ObjectFloat_Month
                                                  ON ObjectFloat_Month.ObjectId = Object_PartionDateKind.Id
                                                 AND ObjectFloat_Month.DescId = zc_ObjectFloat_PartionDateKind_Month()
                            LEFT JOIN ObjectFloat AS ObjectFloat_Day
                                                  ON ObjectFloat_Day.ObjectId = Object_PartionDateKind.Id
                                                 AND ObjectFloat_Day.DescId = zc_ObjectFloat_PartionDateKind_Day()
                       WHERE Object_PartionDateKind.Id = zc_Enum_PartionDateKind_6()
                      )
          SELECT CASE WHEN tmp.isMonth = TRUE THEN tmp.Value ||' MONTH'  ELSE tmp.Value ||' DAY' END :: INTERVAL AS Date_6
               , tmp.Value AS Day_6
          FROM tmp
         ) AS tmp;
    -- ���� + 1 �����
    vbDate_1:= CURRENT_DATE
             + (WITH tmp AS (SELECT CASE WHEN ObjectFloat_Day.ValueData > 0 THEN ObjectFloat_Day.ValueData ELSE COALESCE (ObjectFloat_Month.ValueData, 0) END AS Value
                                  , CASE WHEN ObjectFloat_Day.ValueData > 0 THEN FALSE ELSE TRUE END AS isMonth
                             FROM Object  AS Object_PartionDateKind
                                  LEFT JOIN ObjectFloat AS ObjectFloat_Month
                                                        ON ObjectFloat_Month.ObjectId = Object_PartionDateKind.Id
                                                       AND ObjectFloat_Month.DescId = zc_ObjectFloat_PartionDateKind_Month()
                                  LEFT JOIN ObjectFloat AS ObjectFloat_Day
                                                        ON ObjectFloat_Day.ObjectId = Object_PartionDateKind.Id
                                                       AND ObjectFloat_Day.DescId = zc_ObjectFloat_PartionDateKind_Day()
                             WHERE Object_PartionDateKind.Id = zc_Enum_PartionDateKind_1()
                            )
                SELECT CASE WHEN tmp.isMonth = TRUE THEN tmp.Value ||' MONTH'  ELSE tmp.Value ||' DAY' END :: INTERVAL FROM tmp
               );
    -- ���� + 0 �������
    vbDate_0:= CURRENT_DATE
             + (WITH tmp AS (SELECT CASE WHEN ObjectFloat_Day.ValueData > 0 THEN ObjectFloat_Day.ValueData ELSE COALESCE (ObjectFloat_Month.ValueData, 0) END AS Value
                                  , CASE WHEN ObjectFloat_Day.ValueData > 0 THEN FALSE ELSE TRUE END AS isMonth
                             FROM Object  AS Object_PartionDateKind
                                  LEFT JOIN ObjectFloat AS ObjectFloat_Month
                                                        ON ObjectFloat_Month.ObjectId = Object_PartionDateKind.Id
                                                       AND ObjectFloat_Month.DescId = zc_ObjectFloat_PartionDateKind_Month()
                                  LEFT JOIN ObjectFloat AS ObjectFloat_Day
                                                        ON ObjectFloat_Day.ObjectId = Object_PartionDateKind.Id
                                                       AND ObjectFloat_Day.DescId = zc_ObjectFloat_PartionDateKind_Day()
                             WHERE Object_PartionDateKind.Id = zc_Enum_PartionDateKind_0()
                            )
                SELECT CASE WHEN tmp.isMonth = TRUE THEN tmp.Value ||' MONTH'  ELSE tmp.Value ||' DAY' END :: INTERVAL FROM tmp
               );


    IF EXISTS(SELECT 1 FROM ObjectBoolean AS ObjectBoolean_DividePartionDate
              WHERE ObjectBoolean_DividePartionDate.ObjectId = vbUnitId
                AND ObjectBoolean_DividePartionDate.DescId = zc_ObjectBoolean_Unit_DividePartionDate())
    THEN

      SELECT COALESCE (ObjectBoolean_DividePartionDate.ValueData, FALSE)
      INTO vbDividePartionDate
      FROM ObjectBoolean AS ObjectBoolean_DividePartionDate
      WHERE ObjectBoolean_DividePartionDate.ObjectId = vbUnitId
        AND ObjectBoolean_DividePartionDate.DescId = zc_ObjectBoolean_Unit_DividePartionDate();

    ELSE
      vbDividePartionDate := False;
    END IF;

    -- �������� ����� ������ ��������� ����� / �������� ���� ���������� ���������
    PERFORM lpInsertUpdate_CashSession (inCashSessionId := inCashSessionId
                                      , inDateConnect   := CURRENT_TIMESTAMP :: TDateTime
                                      , inUserId        := vbUserId
                                       );

    -- �������� ���������� SnapShot ������
    DELETE FROM CashSessionSnapShot
    WHERE CashSessionId = inCashSessionId;

    -- ������
    WITH tmpMovContainerId AS (SELECT Movement.Id
                               FROM Movement
                                    INNER JOIN MovementLinkObject AS MovementLinkObject_Unit
                                                                  ON MovementLinkObject_Unit.MovementId = Movement.Id
                                                                 AND MovementLinkObject_Unit.DescId = zc_MovementLinkObject_Unit()
                                                                 AND MovementLinkObject_Unit.ObjectId = vbUnitId
                               WHERE Movement.DescId = zc_Movement_Check()
                                 AND Movement.StatusId = zc_Enum_Status_UnComplete()
                               )
       , ReserveContainer AS (SELECT MIFloat_ContainerId.ValueData::Integer      AS ContainerId
                                   , Sum(MovementItemChild.Amount)::TFloat       AS Amount
                              FROM tmpMovContainerId
                                   INNER JOIN MovementItem AS MovementItemMaster
                                                           ON MovementItemMaster.MovementId = tmpMovContainerId.Id
                                                          AND MovementItemMaster.DescId     = zc_MI_Master()
                                                          AND MovementItemMaster.isErased   = FALSE

                                   INNER JOIN MovementItem AS MovementItemChild
                                                           ON MovementItemChild.MovementId = tmpMovContainerId.Id
                                                          AND MovementItemChild.ParentId = MovementItemMaster.Id
                                                          AND MovementItemChild.DescId     = zc_MI_Child()
                                                          AND MovementItemChild.Amount     > 0
                                                          AND MovementItemChild.isErased   = FALSE

                                   LEFT JOIN MovementItemFloat AS MIFloat_ContainerId
                                                               ON MIFloat_ContainerId.MovementItemId = MovementItemChild.Id
                                                              AND MIFloat_ContainerId.DescId = zc_MIFloat_ContainerId()
                              GROUP BY MIFloat_ContainerId.ValueData
                              )
          -- ������� �� ������
       , tmpPDContainerAll AS (SELECT Container.Id,
                                     Container.ObjectId,
                                     Container.ParentId,
                                     Container.Amount,
                                     ContainerLinkObject.ObjectId                       AS PartionGoodsId,
                                     ReserveContainer.Amount                            AS Reserve
                              FROM Container

                                   LEFT JOIN ContainerLinkObject ON ContainerLinkObject.ContainerId = Container.Id
                                                                AND ContainerLinkObject.DescId = zc_ContainerLinkObject_PartionGoods()

                                  LEFT OUTER JOIN ReserveContainer ON ReserveContainer.ContainerID = Container.Id

                            WHERE Container.DescId = zc_Container_CountPartionDate()
                              AND Container.WhereObjectId = vbUnitId
                              AND (Container.Amount <> 0 OR COALESCE(ReserveContainer.Amount, 0) <> 0)
                              AND vbDividePartionDate = True
                           -- !!!
                           -- AND 1=0
                            )
       , tmpPDContainer AS (SELECT Container.Id,
                                   Container.ObjectId,
                                   Container.Amount,
                                   COALESCE (ObjectDate_ExpirationDate.ValueData, zc_DateEnd())  AS ExpirationDate,
                                   COALESCE (ObjectFloat_PartionGoods_ValueMin.ValueData, 0)     AS PercentMin,
                                   COALESCE (ObjectFloat_PartionGoods_Value.ValueData, 0)        AS Percent,
                                   COALESCE (ObjectFloat_PartionGoods_PriceWithVAT.ValueData, 0) AS PriceWithVAT,
                                   CASE WHEN ObjectDate_ExpirationDate.ValueData <= vbDate_0 AND
                                             COALESCE (ObjectBoolean_PartionGoods_Cat_5.ValueData, FALSE) = TRUE
                                                                                              THEN zc_Enum_PartionDateKind_Cat_5() -- 5 ��� (��������� ��� �������)
                                        WHEN ObjectDate_ExpirationDate.ValueData <= vbDate_0   THEN zc_Enum_PartionDateKind_0()     -- ����������
                                        WHEN ObjectDate_ExpirationDate.ValueData <= vbDate_1  THEN zc_Enum_PartionDateKind_1()     -- ������ 1 ������
                                        WHEN ObjectDate_ExpirationDate.ValueData <= vbDate_6 THEN zc_Enum_PartionDateKind_6()     -- ������ 6 ������
                                        ELSE zc_Enum_PartionDateKind_Good() END                  AS PartionDateKindId,             -- ����������� � ���������

                                   Container.Reserve                                             AS Reserve
                            FROM tmpPDContainerAll AS Container

                                 LEFT JOIN Object AS Object_PartionGoods ON Object_PartionGoods.ID = Container.PartionGoodsId

                                 LEFT JOIN ObjectDate AS ObjectDate_ExpirationDate
                                                      ON ObjectDate_ExpirationDate.ObjectId = Container.PartionGoodsId
                                                     AND ObjectDate_ExpirationDate.DescId = zc_ObjectDate_PartionGoods_Value()

                                 LEFT JOIN ObjectFloat AS ObjectFloat_PartionGoods_ValueMin
                                                       ON ObjectFloat_PartionGoods_ValueMin.ObjectId =  Container.PartionGoodsId
                                                      AND ObjectFloat_PartionGoods_ValueMin.DescId = zc_ObjectFloat_PartionGoods_ValueMin()

                                 LEFT JOIN ObjectFloat AS ObjectFloat_PartionGoods_Value
                                                        ON ObjectFloat_PartionGoods_Value.ObjectId =  Container.PartionGoodsId
                                                      AND ObjectFloat_PartionGoods_Value.DescId = zc_ObjectFloat_PartionGoods_Value()

                                 LEFT JOIN ObjectFloat AS ObjectFloat_PartionGoods_PriceWithVAT
                                                        ON ObjectFloat_PartionGoods_PriceWithVAT.ObjectId =  Container.PartionGoodsId
                                                      AND ObjectFloat_PartionGoods_PriceWithVAT.DescId = zc_ObjectFloat_PartionGoods_PriceWithVAT()

                                 LEFT JOIN ObjectBoolean AS ObjectBoolean_PartionGoods_Cat_5
                                                         ON ObjectBoolean_PartionGoods_Cat_5.ObjectId =  Container.PartionGoodsId
                                                        AND ObjectBoolean_PartionGoods_Cat_5.DescID = zc_ObjectBoolean_PartionGoods_Cat_5()
                         -- !!!
                         -- WHERE 1=0
                           )

         -- ������ �������, ��� ������� ����� ����-����
       , tmpGoods_PD AS (SELECT DISTINCT tmpPDContainer.ObjectId AS GoodsId FROM tmpPDContainer)
         -- ����-����
--     , tmpCashGoodsPriceWithVAT AS (SELECT * FROM gpSelect_CashGoodsPriceWithVAT('3'))
--     , tmpCashGoodsPriceWithVAT AS (SELECT 0 :: Integer AS Id, 0 :: TFloat AS PriceWithVAT WHERE 1=0)
       , tmpCashGoodsPriceWithVAT AS (WITH
                                 DD AS (SELECT DISTINCT Object_MarginCategoryItem_View.MarginPercent,
                                                        Object_MarginCategoryItem_View.MinPrice,
                                                        Object_MarginCategoryItem_View.MarginCategoryId,
                                                        ROW_NUMBER() OVER (PARTITION BY Object_MarginCategoryItem_View.MarginCategoryId
                                                                           ORDER BY Object_MarginCategoryItem_View.MinPrice) AS ORD
                                        FROM Object_MarginCategoryItem_View
                                             INNER JOIN Object AS Object_MarginCategoryItem ON Object_MarginCategoryItem.Id       = Object_MarginCategoryItem_View.Id
                                                                                           AND Object_MarginCategoryItem.isErased = FALSE
                                       )
                  , MarginCondition AS (SELECT
                                            D1.MarginCategoryId,
                                            D1.MarginPercent,
                                            D1.MinPrice,
                                            COALESCE(D2.MinPrice, 1000000) AS MaxPrice
                                        FROM DD AS D1
                                            LEFT OUTER JOIN DD AS D2 ON D1.MarginCategoryId = D2.MarginCategoryId AND D1.ORD = D2.ORD-1
                                       )

                         -- ������ ���� + ���
                      /*, GoodsPrice AS (SELECT ObjectLink_Price_Goods.ChildObjectId              AS GoodsId
                                             , COALESCE (ObjectBoolean_Top.ValueData, FALSE)     AS isTOP
                                             , COALESCE (ObjectFloat_PercentMarkup.ValueData, 0) AS PercentMarkup
                                        FROM ObjectLink AS ObjectLink_Price_Unit
                                             INNER JOIN ObjectLink AS ObjectLink_Price_Goods
                                                                   ON ObjectLink_Price_Goods.ObjectId = ObjectLink_Price_Unit.ObjectId
                                                                  AND ObjectLink_Price_Goods.DescId   = zc_ObjectLink_Price_Goods()
                                             -- !!!���������� ������ ���� �������!!!
                                             INNER JOIN tmpGoods_PD ON tmpGoods_PD.GoodsId = ObjectLink_Price_Goods.ChildObjectId

                                             LEFT JOIN ObjectBoolean AS ObjectBoolean_Top
                                                                     ON ObjectBoolean_Top.ObjectId  = ObjectLink_Price_Unit.ObjectId
                                                                    AND ObjectBoolean_Top.DescId    = zc_ObjectBoolean_Price_Top()
                                             LEFT JOIN ObjectFloat AS ObjectFloat_PercentMarkup
                                                                   ON ObjectFloat_PercentMarkup.ObjectId = ObjectLink_Price_Unit.ObjectId
                                                                  AND ObjectFloat_PercentMarkup.DescId = zc_ObjectFloat_Price_PercentMarkup()
                                        WHERE ObjectLink_Price_Unit.ChildObjectId = vbUnitId
                                          AND ObjectLink_Price_Unit.DescId        = zc_ObjectLink_Price_Unit()
                                       -- AND (ObjectBoolean_Top.ValueData = TRUE OR ObjectFloat_PercentMarkup.ValueData <> 0)
                                       )*/
                , JuridicalSettings AS (SELECT DISTINCT JuridicalId, ContractId, isPriceCloseOrder
                                        FROM lpSelect_Object_JuridicalSettingsRetail (vbObjectId) AS JuridicalSettings
                                             LEFT JOIN Object AS Object_ContractSettings ON Object_ContractSettings.Id = JuridicalSettings.MainJuridicalId
                                        WHERE COALESCE (Object_ContractSettings.isErased, FALSE) = FALSE
                                         AND JuridicalSettings.MainJuridicalId <> 5603474
                                       )
                     -- !!!������ �� ������ tmpGoods_PD!!!
                   , tmpGoodsPartner AS (SELECT tmpGoods_PD.GoodsId                               AS GoodsId_retail -- ����� ����
                                              , ObjectLink_LinkGoods_Main.ChildObjectId           AS GoodsId_main   -- ����� �������
                                              , ObjectLink_LinkGoods_jur.ChildObjectId            AS GoodsId_jur    -- ����� ����������
                                           -- , Object_Goods_jur.ObjectCode                       AS GoodsCode_jur  -- ����� ����������
                                              , ObjectString_Goods_Code.ValueData                 AS GoodsCode_jur  -- ����� ����������
                                              , ObjectLink_Goods_Object_jur.ChildObjectId         AS JuridicalId    -- ���������
                                              , COALESCE (ObjectBoolean_Top.ValueData, FALSE)     AS isTOP          -- ��� � ���. ����
                                              , COALESCE (ObjectFloat_PercentMarkup.ValueData, 0) AS PercentMarkup  -- % ���. � ���. ����
                                              , COALESCE (ObjectFloat_Goods_Price.ValueData, 0)   AS Price_retail   -- ������������� ���� � ���. ����
                                              , COALESCE (ObjectFloat_NDSKind_NDS.ValueData, 0)   AS NDS            -- NDS � ���. �������
                                         FROM tmpGoods_PD
                                              -- ������ - ����
                                              INNER JOIN ObjectLink AS ObjectLink_LinkGoods
                                                                    ON ObjectLink_LinkGoods.ChildObjectId = tmpGoods_PD.GoodsId
                                                                   AND ObjectLink_LinkGoods.DescId        = zc_ObjectLink_LinkGoods_Goods()
                                              -- ������� ����� - ��� ������� ����
                                              INNER JOIN ObjectLink AS ObjectLink_LinkGoods_Main
                                                                    ON ObjectLink_LinkGoods_Main.ObjectId = ObjectLink_LinkGoods.ObjectId
                                                                   AND ObjectLink_LinkGoods_Main.DescId   = zc_ObjectLink_LinkGoods_GoodsMain()
                                              -- ������� ����� - ��� � ���� �� "����� ��" - ����� ��� ����� � ����� ����������
                                              INNER JOIN ObjectLink AS ObjectLink_LinkGoods_Main_jur
                                                                    ON ObjectLink_LinkGoods_Main_jur.ChildObjectId = ObjectLink_LinkGoods_Main.ChildObjectId
                                                                   AND ObjectLink_LinkGoods_Main_jur.DescId        = zc_ObjectLink_LinkGoods_GoodsMain()
                                              -- ��� ������� - ���� - ����� ��� ����� � ��� ������� ����������
                                              INNER JOIN ObjectLink AS ObjectLink_LinkGoods_jur
                                                                    ON ObjectLink_LinkGoods_jur.ObjectId = ObjectLink_LinkGoods_Main_jur.ObjectId
                                                                   AND ObjectLink_LinkGoods_jur.DescId   = zc_ObjectLink_LinkGoods_Goods()
                                              -- ����� ����������, ����� ��� GoodsCode_int
                                              -- INNER JOIN Object AS Object_Goods_jur ON Object_Goods_jur.Id = ObjectLink_LinkGoods_jur.ChildObjectId
                                              -- ����� ����������, ����� ��� GoodsCode_str
                                              LEFT JOIN ObjectString AS ObjectString_Goods_Code
                                                                     ON ObjectString_Goods_Code.ObjectId = ObjectLink_LinkGoods_jur.ChildObjectId
                                                                    AND ObjectString_Goods_Code.DescId   = zc_ObjectString_Goods_Code()
                                              -- � ������ ���������� - ��� ���������
                                              INNER JOIN ObjectLink AS ObjectLink_Goods_Object_jur
                                                                    ON ObjectLink_Goods_Object_jur.ObjectId = ObjectLink_LinkGoods_jur.ChildObjectId
                                                                   AND ObjectLink_Goods_Object_jur.DescId   = zc_ObjectLink_Goods_Object()
                                              -- !!!���������� ��� ��� �� ����!!!
                                              INNER JOIN Object AS Object_Juridical ON Object_Juridical.Id     = ObjectLink_Goods_Object_jur.ChildObjectId
                                                                                   AND Object_Juridical.DescId = zc_Object_Juridical()
                                              -- ������ ���� + ��� + PercentMarkup ��� ���. ����
                                              LEFT JOIN ObjectFloat AS ObjectFloat_Goods_Price
                                                                    ON ObjectFloat_Goods_Price.ObjectId = tmpGoods_PD.GoodsId
                                                                   AND ObjectFloat_Goods_Price.DescId   = zc_ObjectFloat_Goods_Price()
                                              INNER JOIN ObjectLink AS ObjectLink_Price_Goods
                                                                    ON ObjectLink_Price_Goods.ChildObjectId = tmpGoods_PD.GoodsId
                                                                   AND ObjectLink_Price_Goods.DescId        = zc_ObjectLink_Price_Goods()
                                              INNER JOIN ObjectLink AS ObjectLink_Price_Unit
                                                                    ON ObjectLink_Price_Unit.ObjectId      = ObjectLink_Price_Goods.ObjectId
                                                                   AND ObjectLink_Price_Unit.DescId        = zc_ObjectLink_Price_Unit()
                                                                   AND ObjectLink_Price_Unit.ChildObjectId = vbUnitId
                                              LEFT JOIN ObjectBoolean AS ObjectBoolean_Top
                                                                      ON ObjectBoolean_Top.ObjectId  = ObjectLink_Price_Unit.ObjectId
                                                                     AND ObjectBoolean_Top.DescId    = zc_ObjectBoolean_Price_Top()
                                              LEFT JOIN ObjectFloat AS ObjectFloat_PercentMarkup
                                                                    ON ObjectFloat_PercentMarkup.ObjectId = ObjectLink_Price_Unit.ObjectId
                                                                   AND ObjectFloat_PercentMarkup.DescId   = zc_ObjectFloat_Price_PercentMarkup()
                                              -- ��� ���. �������
                                              LEFT JOIN ObjectLink AS ObjectLink_Goods_NDSKind
                                                                   ON ObjectLink_Goods_NDSKind.ObjectId = ObjectLink_LinkGoods_Main.ChildObjectId
                                                                  AND ObjectLink_Goods_NDSKind.DescId   = zc_ObjectLink_Goods_NDSKind()
                                              LEFT JOIN ObjectFloat AS ObjectFloat_NDSKind_NDS
                                                                    ON ObjectFloat_NDSKind_NDS.ObjectId = ObjectLink_Goods_NDSKind.ChildObjectId
                                                                   AND ObjectFloat_NDSKind_NDS.DescId   = zc_ObjectFloat_NDSKind_NDS()
                                        )

                   , _GoodsPriceAll AS (SELECT -- LinkGoodsObject.GoodsId             AS GoodsId,
                                               tmpGoodsPartner.GoodsId_retail         AS GoodsId, -- ����� ����
                                             /*zfCalc_SalePrice((LoadPriceListItem.Price * (100 + Object_Goods.NDS)/100),                         -- ���� � ���
                                                                 CASE WHEN COALESCE (ObjectFloat_Contract_Percent.ValueData, 0) <> 0
                                                                          THEN MarginCondition.MarginPercent + COALESCE (ObjectFloat_Contract_Percent.ValueData, 0)
                                                                      ELSE MarginCondition.MarginPercent + COALESCE (ObjectFloat_Juridical_Percent.ValueData, 0)
                                                                 END,                                                                             -- % ������� � ���������
                                                                 COALESCE (NULLIF (GoodsPrice.isTOP, FALSE), ObjectGoodsView.isTop),              -- ��� �������
                                                                 COALESCE (NULLIF (GoodsPrice.PercentMarkup, 0), ObjectGoodsView.PercentMarkup),  -- % ������� � ������
                                                                 0.0, --ObjectFloat_Juridical_Percent.ValueData,                                  -- % ������������� � �� ���� ��� ����
                                                                 ObjectGoodsView.Price                                                            -- ���� � ������ (�������������)
                                                               )         :: TFloat AS Price,
                                               LoadPriceListItem.Price * (100 + Object_Goods.NDS)/100 AS PriceWithVAT*/
                                               zfCalc_SalePrice ((LoadPriceListItem.Price * (100 + tmpGoodsPartner.NDS) / 100),                         -- ���� � ���
                                                                 CASE WHEN COALESCE (ObjectFloat_Contract_Percent.ValueData, 0) <> 0
                                                                          THEN MarginCondition.MarginPercent + COALESCE (ObjectFloat_Contract_Percent.ValueData, 0)
                                                                      ELSE MarginCondition.MarginPercent + COALESCE (ObjectFloat_Juridical_Percent.ValueData, 0)
                                                                 END,                                                                             -- % ������� � ���������
                                                                 COALESCE (tmpGoodsPartner.isTOP, FALSE),                                         -- ��� �������
                                                                 COALESCE (tmpGoodsPartner.PercentMarkup, 0),                                     -- % ������� � ������
                                                                 0.0, --ObjectFloat_Juridical_Percent.ValueData,                                  -- % ������������� � �� ���� ��� ����
                                                                 tmpGoodsPartner.Price_retail                                                            -- ���� � ������ (�������������)
                                                               )         :: TFloat AS Price,
                                               LoadPriceListItem.Price * (100 + tmpGoodsPartner.NDS)/100 AS PriceWithVAT

                                        FROM LoadPriceListItem

                                             INNER JOIN LoadPriceList ON LoadPriceList.Id = LoadPriceListItem.LoadPriceListId

                                             LEFT JOIN JuridicalSettings
                                                     ON JuridicalSettings.JuridicalId = LoadPriceList.JuridicalId
                                                    AND JuridicalSettings.ContractId  = LoadPriceList.ContractId

                                             -- !!!���������� ������ ���� �������!!!
                                             INNER JOIN tmpGoodsPartner ON tmpGoodsPartner.JuridicalId   = LoadPriceList.JuridicalId
                                                                       AND tmpGoodsPartner.GoodsId_main  = LoadPriceListItem.GoodsId
                                                                       AND tmpGoodsPartner.GoodsCode_jur = LoadPriceListItem.GoodsCode

                                             LEFT JOIN ObjectFloat AS ObjectFloat_Juridical_Percent
                                                                   ON ObjectFloat_Juridical_Percent.ObjectId = LoadPriceList.JuridicalId
                                                                  AND ObjectFloat_Juridical_Percent.DescId = zc_ObjectFloat_Juridical_Percent()

                                             LEFT JOIN ObjectFloat AS ObjectFloat_Contract_Percent
                                                                   ON ObjectFloat_Contract_Percent.ObjectId = LoadPriceList.ContractId
                                                                  AND ObjectFloat_Contract_Percent.DescId = zc_ObjectFloat_Contract_Percent()

                                             LEFT JOIN Object_MarginCategoryLink_View AS Object_MarginCategoryLink
                                                                                      ON (Object_MarginCategoryLink.UnitId = vbUnitId)
                                                                                     AND Object_MarginCategoryLink.JuridicalId = LoadPriceList.JuridicalId

                                             LEFT JOIN Object_MarginCategoryLink_View AS Object_MarginCategoryLink_all
                                                                                      ON COALESCE (Object_MarginCategoryLink_all.UnitId, 0) = 0
                                                                                     AND Object_MarginCategoryLink_all.JuridicalId = LoadPriceList.JuridicalId
                                                                                     AND Object_MarginCategoryLink_all.isErased    = FALSE
                                                                                     AND Object_MarginCategoryLink.JuridicalId IS NULL

                                             LEFT JOIN MarginCondition ON MarginCondition.MarginCategoryId = COALESCE (Object_MarginCategoryLink.MarginCategoryId, Object_MarginCategoryLink_all.MarginCategoryId)
                                                                  -- AND (LoadPriceListItem.Price * (100 + Object_Goods.NDS)/100)::TFloat BETWEEN MarginCondition.MinPrice AND MarginCondition.MaxPrice
                                                                     AND (LoadPriceListItem.Price * (100 + tmpGoodsPartner.NDS)/100)::TFloat BETWEEN MarginCondition.MinPrice AND MarginCondition.MaxPrice

                                             -- 1.������� �����
                                             /*LEFT JOIN Object_Goods_Main_View AS Object_Goods ON Object_Goods.Id = LoadPriceListItem.GoodsId

                                             -- 2.����� ����������
                                             LEFT JOIN Object_Goods_View AS PartnerGoods ON PartnerGoods.ObjectId  = LoadPriceList.JuridicalId
                                                                                        AND PartnerGoods.GoodsCode = LoadPriceListItem.GoodsCode
                                             -- ���������� 1�2
                                             LEFT JOIN Object_LinkGoods_View AS LinkGoods ON LinkGoods.GoodsMainId = Object_Goods.Id
                                                                                         AND LinkGoods.GoodsId     = PartnerGoods.Id

                                             -- ����� ����� ����
                                             LEFT JOIN Object_LinkGoods_View AS LinkGoodsObject ON LinkGoodsObject.GoodsMainId = Object_Goods.Id
                                                                                               AND LinkGoodsObject.ObjectId    = vbObjectId
                                             -- ��-�� ������ ����
                                             LEFT JOIN Object_Goods_View AS ObjectGoodsView ON ObjectGoodsView.Id = LinkGoodsObject.GoodsId

                                             -- !!!���������� ������ ���� �������!!!
                                             INNER JOIN tmpGoods_PD ON tmpGoods_PD.GoodsId = LinkGoodsObject.GoodsId

                                             LEFT JOIN GoodsPrice ON GoodsPrice.GoodsId = LinkGoodsObject.GoodsId*/

                                        WHERE COALESCE(JuridicalSettings.isPriceCloseOrder, TRUE)  = FALSE
                                          AND (LoadPriceList.AreaId = 0 OR COALESCE (LoadPriceList.AreaId, 0) = vbAreaId OR COALESCE(vbAreaId, 0) = 0
                                            OR COALESCE (LoadPriceList.AreaId, 0) = zc_Area_Basis()
                                              )
                                       )
                              , GoodsPriceAll AS (SELECT
                                                       ROW_NUMBER() OVER (PARTITION BY _GoodsPriceAll.GoodsId ORDER BY _GoodsPriceAll.Price)::Integer AS Ord,
                                                       _GoodsPriceAll.GoodsId           AS GoodsId,
                                                       _GoodsPriceAll.PriceWithVAT      AS PriceWithVAT
                                                  FROM _GoodsPriceAll
                                                 )
                            -- ��������� - ����-����
                            SELECT GoodsPriceAll.GoodsId      AS Id,
                                   GoodsPriceAll.PriceWithVAT AS PriceWithVAT
                            FROM GoodsPriceAll
                            WHERE Ord = 1
                           )

       , tmpPDPriceWithVAT AS (SELECT ROW_NUMBER()OVER(PARTITION BY Container.ObjectId, Container.PartionDateKindId ORDER BY Container.Id DESC) as ORD
                                    , Container.ObjectId
                                    , Container.PartionDateKindId
                                    , CASE WHEN Container.PriceWithVAT <= 15
                                           THEN COALESCE (tmpCashGoodsPriceWithVAT.PriceWithVAT, Container.PriceWithVAT)
                                           ELSE Container.PriceWithVAT END       AS PriceWithVAT
                               FROM tmpPDContainer AS Container
                                    LEFT JOIN tmpCashGoodsPriceWithVAT ON tmpCashGoodsPriceWithVAT.ID = Container.ObjectId
                               WHERE COALESCE (Container.PriceWithVAT , 0) <> 0
                               )
       , tmpPDGoodsRemains AS (SELECT Container.ObjectId
                                    , Container.PartionDateKindId                                       AS PartionDateKindId
                                    , SUM (Container.Amount)                                            AS Remains
                                    , SUM (Container.Reserve)                                           AS Reserve
                                    , MIN (Container.ExpirationDate)::TDateTime                         AS MinExpirationDate
                                    , MAX (tmpPDPriceWithVAT.PriceWithVAT)                              AS PriceWithVAT

                                    , MIN (CASE WHEN Container.PartionDateKindId = zc_Enum_PartionDateKind_Good()
                                                THEN 0
                                                WHEN Container.PartionDateKindId in (zc_Enum_PartionDateKind_6(), zc_Enum_PartionDateKind_Cat_5())
                                                THEN Container.Percent
                                                ELSE Container.PercentMin END)::TFloat                  AS PartionDateDiscount
                               FROM tmpPDContainer AS Container

                                    LEFT JOIN tmpPDPriceWithVAT ON tmpPDPriceWithVAT.ObjectId = Container.ObjectId
                                                               AND tmpPDPriceWithVAT.PartionDateKindId = Container.PartionDateKindId
                                                               AND tmpPDPriceWithVAT.Ord = 1

                               GROUP BY Container.ObjectId
                                      , Container.PartionDateKindId
                               )
       , tmpPDGoodsRemainsAll AS (SELECT tmpPDGoodsRemains.ObjectId
                                       , SUM (tmpPDGoodsRemains.Remains)                                                         AS Remains
                                       , SUM (tmpPDGoodsRemains.Reserve)                                                         AS Reserve
                                  FROM tmpPDGoodsRemains
                                  GROUP BY tmpPDGoodsRemains.ObjectId
                                 )
          -- ������� �� �������� �����������
       , tmpContainer AS (SELECT Container.Id, Container.ObjectId, Container.Amount
                          FROM Container
                          WHERE Container.DescId = zc_Container_Count()
                            AND Container.WhereObjectId = vbUnitId
                            AND Container.Amount <> 0
                         )
       , tmpExpirationDate AS (SELECT tmp.Id       AS ContainerId
                                    , MIDate_ExpirationDate.ValueData
                               FROM tmpContainer AS tmp
                                  LEFT JOIN  tmpPDContainerAll on tmpPDContainerAll.ParentId = tmp.Id
                                  LEFT JOIN ContainerlinkObject AS ContainerLinkObject_MovementItem
                                                                ON ContainerLinkObject_MovementItem.Containerid = tmp.Id
                                                               AND ContainerLinkObject_MovementItem.DescId = zc_ContainerLinkObject_PartionMovementItem()
                                  LEFT OUTER JOIN Object AS Object_PartionMovementItem ON Object_PartionMovementItem.Id = ContainerLinkObject_MovementItem.ObjectId
                                  -- ������� �������
                                  LEFT JOIN MovementItem AS MI_Income ON MI_Income.Id = Object_PartionMovementItem.ObjectCode
                                  -- ���� ��� ������, ������� ���� ������� ��������������� - � ���� �������� ����� "���������" ��������� ������ �� ����������
                                  LEFT JOIN MovementItemFloat AS MIFloat_MovementItem
                                                              ON MIFloat_MovementItem.MovementItemId = MI_Income.Id
                                                             AND MIFloat_MovementItem.DescId = zc_MIFloat_MovementItemId()
                                  -- �������� ������� �� ���������� (���� ��� ������, ������� ���� ������� ���������������)
                                  LEFT JOIN MovementItem AS MI_Income_find ON MI_Income_find.Id  = (MIFloat_MovementItem.ValueData :: Integer)
                                                                       -- AND 1=0
                                   LEFT OUTER JOIN MovementItemDate  AS MIDate_ExpirationDate
                                                                    ON MIDate_ExpirationDate.MovementItemId = COALESCE (MI_Income_find.Id,MI_Income.Id)  --Object_PartionMovementItem.ObjectCode
                                                                   AND MIDate_ExpirationDate.DescId = zc_MIDate_PartionGoods()
                               WHERE COALESCE (tmpPDContainerAll.ParentId, 0) = 0
                               )
       , tmpGoodsRemains AS (SELECT Container.ObjectId
                                  , SUM (Container.Amount) AS Remains
                                  , MIN (COALESCE (tmpExpirationDate.ValueData, zc_DateEnd())) :: TDateTime AS MinExpirationDate -- ���� ��������
                             FROM tmpContainer AS Container
                                  -- ������� ������
                                  LEFT JOIN tmpExpirationDate ON tmpExpirationDate.Containerid = Container.Id
                                GROUP BY Container.ObjectId
                             )

          -- �������
        , tmpMov AS (
            SELECT Movement.Id
            FROM MovementBoolean AS MovementBoolean_Deferred
                      INNER JOIN Movement ON Movement.Id     = MovementBoolean_Deferred.MovementId
                                         AND Movement.DescId = zc_Movement_Check()
                                         AND Movement.StatusId = zc_Enum_Status_UnComplete()
                      INNER JOIN MovementLinkObject AS MovementLinkObject_Unit
                                                    ON MovementLinkObject_Unit.MovementId = Movement.Id
                                                   AND MovementLinkObject_Unit.DescId = zc_MovementLinkObject_Unit()
                                                   AND MovementLinkObject_Unit.ObjectId = vbUnitId
                    WHERE MovementBoolean_Deferred.DescId    = zc_MovementBoolean_Deferred()
                      AND MovementBoolean_Deferred.ValueData = TRUE
                   UNION ALL
                    SELECT Movement.Id
                    FROM MovementString AS MovementString_CommentError
                      INNER JOIN Movement ON Movement.Id     = MovementString_CommentError.MovementId
                                         AND Movement.DescId = zc_Movement_Check()
                                         AND Movement.StatusId = zc_Enum_Status_UnComplete()
                      INNER JOIN MovementLinkObject AS MovementLinkObject_Unit
                                                    ON MovementLinkObject_Unit.MovementId = Movement.Id
                                                   AND MovementLinkObject_Unit.DescId = zc_MovementLinkObject_Unit()
                                                   AND MovementLinkObject_Unit.ObjectId = vbUnitId
                   WHERE MovementString_CommentError.DescId = zc_MovementString_CommentError()
                     AND MovementString_CommentError.ValueData <> ''
           )
      , Reserve
        AS
        (
            SELECT MovementItem.ObjectId                       AS GoodsId
                 , Sum(MovementItem.Amount)::TFloat            AS Amount
            FROM tmpMov
                         INNER JOIN MovementItem ON MovementItem.MovementId = tmpMov.Id
                                                AND MovementItem.DescId     = zc_MI_Master()
                                                AND MovementItem.isErased   = FALSE
                                                AND MovementItem.Amount    <> 0

            GROUP BY MovementItem.ObjectId
         )
          -- ��������������� �������
       , GoodsRemains AS (SELECT Container.ObjectId
                               , Container.Remains - COALESCE(tmpPDGoodsRemainsAll.Remains, 0)                   AS Remains
                               , COALESCE(Reserve.Amount, 0) - COALESCE(tmpPDGoodsRemainsAll.Reserve, 0)::TFloat AS Reserve
                               , Container.MinExpirationDate
                               , NULL                                                                            AS PartionDateKindId
                               , NULL                                                                            AS PartionDateDiscount
                               , NULL                                                                            AS PriceWithVAT
                          FROM tmpGoodsRemains AS Container
                               LEFT JOIN tmpPDGoodsRemainsAll ON tmpPDGoodsRemainsAll.ObjectId = Container.ObjectId
                               LEFT JOIN Reserve ON Reserve.GoodsId = Container.ObjectId
                          UNION ALL
                          SELECT tmpPDGoodsRemains.ObjectId
                               , tmpPDGoodsRemains.Remains
                               , tmpPDGoodsRemains.Reserve
                               , tmpPDGoodsRemains.MinExpirationDate
                               , tmpPDGoodsRemains.PartionDateKindId
                               , NULLIF (tmpPDGoodsRemains.PartionDateDiscount, 0)
                               , tmpPDGoodsRemains.PriceWithVAT
                          FROM tmpPDGoodsRemains
                          UNION ALL
                          SELECT Reserve.GoodsId                                                       AS GoodsId
                               , 0::TFloat                                                             AS Remains
                               , (Reserve.Amount - COALESCE(tmpPDGoodsRemainsAll.Reserve, 0))::TFloat  AS Reserved
                               , Null::TDateTime                                                       AS MinExpirationDate
                               , NULL                                                                  AS PartionDateKindId
                               , NULL                                                                  AS PartionDateDiscount
                               , NULL                                                                  AS PriceWithVAT
                          FROM Reserve
                             LEFT OUTER JOIN tmpGoodsRemains ON Reserve.GoodsId = tmpGoodsRemains.ObjectId
                             LEFT OUTER JOIN tmpPDGoodsRemainsAll ON tmpPDGoodsRemainsAll.ObjectId = Reserve.GoodsId
                          WHERE COALESCE(tmpGoodsRemains.ObjectId, 0) = 0
                            AND (Reserve.Amount - COALESCE(tmpPDGoodsRemainsAll.Reserve, 0)) <> 0
                         )

    --������ �������
    INSERT INTO CashSessionSnapShot(CashSessionId,ObjectId,PartionDateKindId,Price,Remains,MCSValue,Reserved,MinExpirationDate,AccommodationId,PartionDateDiscount,PriceWithVAT
    )
    WITH
    tmpObject_Price AS (SELECT CASE WHEN ObjectBoolean_Goods_TOP.ValueData = TRUE
                                     AND ObjectFloat_Goods_Price.ValueData > 0
                                    THEN ROUND (ObjectFloat_Goods_Price.ValueData, 2)
                                    ELSE ROUND (Price_Value.ValueData, 2)
                               END :: TFloat                           AS Price
                             , MCS_Value.ValueData                     AS MCSValue
                             , Price_Goods.ChildObjectId               AS GoodsId
                        FROM ObjectLink AS ObjectLink_Price_Unit
                           LEFT JOIN ObjectLink AS Price_Goods
                                                ON Price_Goods.ObjectId = ObjectLink_Price_Unit.ObjectId
                                               AND Price_Goods.DescId = zc_ObjectLink_Price_Goods()
                           LEFT JOIN ObjectFloat AS Price_Value
                                                 ON Price_Value.ObjectId = ObjectLink_Price_Unit.ObjectId
                                                AND Price_Value.DescId = zc_ObjectFloat_Price_Value()
                           LEFT JOIN ObjectFloat AS MCS_Value
                                                 ON MCS_Value.ObjectId = ObjectLink_Price_Unit.ObjectId
                                                AND MCS_Value.DescId = zc_ObjectFloat_Price_MCSValue()
                           -- ���� ���� ��� ���� ����
                           LEFT JOIN ObjectFloat  AS ObjectFloat_Goods_Price
                                                  ON ObjectFloat_Goods_Price.ObjectId = Price_Goods.ChildObjectId
                                                 AND ObjectFloat_Goods_Price.DescId   = zc_ObjectFloat_Goods_Price()
                           LEFT JOIN ObjectBoolean AS ObjectBoolean_Goods_TOP
                                                   ON ObjectBoolean_Goods_TOP.ObjectId = Price_Goods.ChildObjectId
                                                  AND ObjectBoolean_Goods_TOP.DescId   = zc_ObjectBoolean_Goods_TOP()
                        WHERE ObjectLink_Price_Unit.DescId        = zc_ObjectLink_Price_Unit()
                          AND ObjectLink_Price_Unit.ChildObjectId = vbUnitId
                        )
    SELECT
        inCashSessionId                                                  AS CashSession
       ,GoodsRemains.ObjectId                                            AS GoodsId
       ,COALESCE (GoodsRemains.PartionDateKindId, 0)                     AS PartionDateKindId
       ,COALESCE(tmpObject_Price.Price,0)                                AS Price
       ,(GoodsRemains.Remains
            - COALESCE(GoodsRemains.Reserve,0))::TFloat                  AS Remains
       ,tmpObject_Price.MCSValue                                         AS MCSValue
       , NULLIF (GoodsRemains.Reserve, 0)::TFloat                        AS Reserved
       ,GoodsRemains.MinExpirationDate                                   AS MinExpirationDate
       ,Accommodation.AccommodationId                                    AS AccommodationId
       , CASE WHEN COALESCE (GoodsRemains.PartionDateKindId, 0) <> 0
              THEN GoodsRemains.PartionDateDiscount ELSE NULL END        AS PartionDateDiscount
       ,GoodsRemains.PriceWithVAT                                        AS PriceWithVAT
    FROM
        GoodsRemains
        LEFT OUTER JOIN tmpObject_Price ON tmpObject_Price.GoodsId = GoodsRemains.ObjectId

        LEFT OUTER JOIN AccommodationLincGoods AS Accommodation
                                               ON Accommodation.UnitId = vbUnitId
                                              AND Accommodation.GoodsId = GoodsRemains.ObjectId;

    RETURN QUERY
      WITH -- ������ ���-������
           tmpGoodsSP AS (SELECT MovementItem.ObjectId         AS GoodsId
                               , MI_IntenalSP.ObjectId         AS IntenalSPId
                               , MIFloat_PriceRetSP.ValueData  AS PriceRetSP
                               , MIFloat_PriceSP.ValueData     AS PriceSP
                               , MIFloat_PaymentSP.ValueData   AS PaymentSP
                               , MIFloat_CountSP.ValueData     AS CountSP
                               , MIString_IdSP.ValueData       AS IdSP
                               , MIString_DosageIdSP.ValueData AS DosageIdSP
                                                                -- � �/� - �� ������ ������
                               , ROW_NUMBER() OVER (PARTITION BY MovementItem.ObjectId ORDER BY Movement.OperDate DESC) AS Ord
                          FROM Movement
                               INNER JOIN MovementDate AS MovementDate_OperDateStart
                                                       ON MovementDate_OperDateStart.MovementId = Movement.Id
                                                      AND MovementDate_OperDateStart.DescId     = zc_MovementDate_OperDateStart()
                                                      AND MovementDate_OperDateStart.ValueData  <= CURRENT_DATE

                               INNER JOIN MovementDate AS MovementDate_OperDateEnd
                                                       ON MovementDate_OperDateEnd.MovementId = Movement.Id
                                                      AND MovementDate_OperDateEnd.DescId     = zc_MovementDate_OperDateEnd()
                                                      AND MovementDate_OperDateEnd.ValueData  >= CURRENT_DATE
                               LEFT JOIN MovementItem ON MovementItem.MovementId = Movement.Id
                                                     AND MovementItem.DescId     = zc_MI_Master()
                                                     AND MovementItem.isErased   = FALSE

                               LEFT JOIN MovementItemLinkObject AS MI_IntenalSP
                                                                ON MI_IntenalSP.MovementItemId = MovementItem.Id
                                                               AND MI_IntenalSP.DescId = zc_MILinkObject_IntenalSP()
                               -- ��������  ���� �� ��������, ���
                               LEFT JOIN MovementItemFloat AS MIFloat_PriceRetSP
                                                           ON MIFloat_PriceRetSP.MovementItemId = MovementItem.Id
                                                          AND MIFloat_PriceRetSP.DescId = zc_MIFloat_PriceRetSP()
                               -- ����� ������������ �� �������� (���. ������) - (15)
                               LEFT JOIN MovementItemFloat AS MIFloat_PriceSP
                                                           ON MIFloat_PriceSP.MovementItemId = MovementItem.Id
                                                          AND MIFloat_PriceSP.DescId = zc_MIFloat_PriceSP()
                               -- ���� ������� �� ��������, ��� (���. ������) - 16)
                               LEFT JOIN MovementItemFloat AS MIFloat_PaymentSP
                                                           ON MIFloat_PaymentSP.MovementItemId = MovementItem.Id
                                                          AND MIFloat_PaymentSP.DescId = zc_MIFloat_PaymentSP()

                               -- ʳ������ ������� ���������� ������ � ��������� �������� (���. ������)(6)
                               LEFT JOIN MovementItemFloat AS MIFloat_CountSP
                                                           ON MIFloat_CountSP.MovementItemId = MovementItem.Id
                                                          AND MIFloat_CountSP.DescId = zc_MIFloat_CountSP()
                               -- ID ���������� ������
                               LEFT JOIN MovementItemString AS MIString_IdSP
                                                            ON MIString_IdSP.MovementItemId = MovementItem.Id
                                                           AND MIString_IdSP.DescId = zc_MIString_IdSP()
                               -- DosageID ���������� ������
                               LEFT JOIN MovementItemString AS MIString_DosageIdSP
                                                            ON MIString_DosageIdSP.MovementItemId = MovementItem.Id
                                                           AND MIString_DosageIdSP.DescId = zc_MIString_DosageIdSP()

                          WHERE Movement.DescId = zc_Movement_GoodsSP()
                            AND Movement.StatusId IN (zc_Enum_Status_Complete(), zc_Enum_Status_UnComplete())
                         )
         , GoodsPromo AS (SELECT ObjectLink_Child_retail.ChildObjectId AS GoodsId  -- ����� ����� "����"
                               , MAX(tmp.MakerID)                      AS MakerID
                         --   , tmp.ChangePercent
                          FROM lpSelect_MovementItem_Promo_onDate (inOperDate:= CURRENT_DATE) AS tmp   --CURRENT_DATE
                                    INNER JOIN ObjectLink AS ObjectLink_Child
                                                          ON ObjectLink_Child.ChildObjectId = tmp.GoodsId
                                                         AND ObjectLink_Child.DescId        = zc_ObjectLink_LinkGoods_Goods()
                                    INNER JOIN  ObjectLink AS ObjectLink_Main ON ObjectLink_Main.ObjectId = ObjectLink_Child.ObjectId
                                                                             AND ObjectLink_Main.DescId   = zc_ObjectLink_LinkGoods_GoodsMain()
                                    INNER JOIN ObjectLink AS ObjectLink_Main_retail ON ObjectLink_Main_retail.ChildObjectId = ObjectLink_Main.ChildObjectId
                                                                                   AND ObjectLink_Main_retail.DescId        = zc_ObjectLink_LinkGoods_GoodsMain()
                                    INNER JOIN ObjectLink AS ObjectLink_Child_retail ON ObjectLink_Child_retail.ObjectId = ObjectLink_Main_retail.ObjectId
                                                                                    AND ObjectLink_Child_retail.DescId   = zc_ObjectLink_LinkGoods_Goods()
                                    INNER JOIN ObjectLink AS ObjectLink_Goods_Object
                                                          ON ObjectLink_Goods_Object.ObjectId = ObjectLink_Child_retail.ChildObjectId
                                                         AND ObjectLink_Goods_Object.DescId = zc_ObjectLink_Goods_Object()
                                                         AND ObjectLink_Goods_Object.ChildObjectId = vbObjectId
                          GROUP BY ObjectLink_Child_retail.ChildObjectId
                          )
                -- ����� � ���� - ������������� ������� �������
                , tmpIncome AS (SELECT MI_Income.ObjectId                      AS GoodsId
                                     , SUM(COALESCE (MI_Income.Amount, 0))     AS AmountIncome
                                     , SUM(COALESCE (MI_Income.Amount, 0) * COALESCE(MIFloat_PriceSale.ValueData,0))  AS SummSale
                                FROM Movement AS Movement_Income
                                     INNER JOIN MovementLinkObject AS MovementLinkObject_To
                                                                   ON MovementLinkObject_To.MovementId = Movement_Income.Id
                                                                  AND MovementLinkObject_To.DescId = zc_MovementLinkObject_To()
                                                                  AND MovementLinkObject_To.ObjectId = vbUnitId

                                     LEFT JOIN MovementItem AS MI_Income
                                                            ON MI_Income.MovementId = Movement_Income.Id
                                                           AND MI_Income.isErased   = False

                                     LEFT JOIN MovementItemFloat AS MIFloat_PriceSale
                                                                 ON MIFloat_PriceSale.MovementItemId = MI_Income.Id
                                                                AND MIFloat_PriceSale.DescId = zc_MIFloat_PriceSale()

                                 WHERE Movement_Income.DescId = zc_Movement_Income()
                                   AND Movement_Income.StatusId = zc_Enum_Status_UnComplete()
                                   -- AND date_trunc('day', Movement_Income.OperDate) = CURRENT_DATE
	                                 GROUP BY MI_Income.ObjectId
                                        , MovementLinkObject_To.ObjectId
                              )
           -- ���� �������
         , tmpGoodsMorion AS (SELECT ObjectLink_Main_Morion.ChildObjectId  AS GoodsMainId
                                   , MAX (Object_Goods_Morion.ObjectCode)  AS MorionCode
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
                              GROUP BY ObjectLink_Main_Morion.ChildObjectId
                             )
           -- �����-���� �������������
         , tmpGoodsBarCode AS (SELECT ObjectLink_Main_BarCode.ChildObjectId AS GoodsMainId
                                    , string_agg(Object_Goods_BarCode.ValueData, ',' ORDER BY Object_Goods_BarCode.ID desc)           AS BarCode
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
                               GROUP BY ObjectLink_Main_BarCode.ChildObjectId
                              )
              -- ������ �� ������
              , tmpObject_Price AS (SELECT ObjectLink_Price_Unit.ObjectId                                AS Id
                                         , Price_Goods.ChildObjectId                                     AS GoodsId
                                         , COALESCE(Price_MCSValueOld.ValueData,0)          ::TFloat     AS MCSValueOld
                                         , MCS_StartDateMCSAuto.ValueData                                AS StartDateMCSAuto
                                         , MCS_EndDateMCSAuto.ValueData                                  AS EndDateMCSAuto
                                         , COALESCE(Price_MCSAuto.ValueData,False)          :: Boolean   AS isMCSAuto
                                         , COALESCE(Price_MCSNotRecalcOld.ValueData,False)  :: Boolean   AS isMCSNotRecalcOld
                                    FROM ObjectLink AS ObjectLink_Price_Unit
                                         INNER JOIN ObjectLink AS Price_Goods
                                                               ON Price_Goods.ObjectId = ObjectLink_Price_Unit.ObjectId
                                                              AND Price_Goods.DescId = zc_ObjectLink_Price_Goods()
                                         LEFT JOIN ObjectFloat AS Price_MCSValueOld
                                                               ON Price_MCSValueOld.ObjectId = ObjectLink_Price_Unit.ObjectId
                                                              AND Price_MCSValueOld.DescId = zc_ObjectFloat_Price_MCSValueOld()
                                         LEFT JOIN ObjectDate AS MCS_StartDateMCSAuto
                                                              ON MCS_StartDateMCSAuto.ObjectId = ObjectLink_Price_Unit.ObjectId
                                                             AND MCS_StartDateMCSAuto.DescId = zc_ObjectDate_Price_StartDateMCSAuto()
                                         LEFT JOIN ObjectDate AS MCS_EndDateMCSAuto
                                                              ON MCS_EndDateMCSAuto.ObjectId = ObjectLink_Price_Unit.ObjectId
                                                             AND MCS_EndDateMCSAuto.DescId = zc_ObjectDate_Price_EndDateMCSAuto()
                                         LEFT JOIN ObjectBoolean AS Price_MCSAuto
                                                                 ON Price_MCSAuto.ObjectId = ObjectLink_Price_Unit.ObjectId
                                                                AND Price_MCSAuto.DescId = zc_ObjectBoolean_Price_MCSAuto()
                                         LEFT JOIN ObjectBoolean AS Price_MCSNotRecalcOld
                                                                 ON Price_MCSNotRecalcOld.ObjectId = ObjectLink_Price_Unit.ObjectId
                                                                AND Price_MCSNotRecalcOld.DescId = zc_ObjectBoolean_Price_MCSNotRecalcOld()
                                    WHERE ObjectLink_Price_Unit.DescId        = zc_ObjectLink_Price_Unit()
                                      AND ObjectLink_Price_Unit.ChildObjectId = vbUnitId
                                    )
                -- MCS - Auto
              , tmpMCSAuto AS (SELECT DISTINCT
                                      CashSessionSnapShot.ObjectId
                                    , tmpObject_Price.MCSValueOld
                                    , tmpObject_Price.StartDateMCSAuto
                                    , tmpObject_Price.EndDateMCSAuto
                                    , tmpObject_Price.isMCSAuto
                                    , tmpObject_Price.isMCSNotRecalcOld
                               FROM CashSessionSnapShot
                                    INNER JOIN tmpObject_Price ON tmpObject_Price.GoodsId = CashSessionSnapShot.ObjectId
                               WHERE CashSessionSnapShot.CashSessionId = inCashSessionId
                              )
                -- ���� �� �������
              , tmpPriceChange AS (SELECT DISTINCT ObjectLink_PriceChange_Goods.ChildObjectId                             AS GoodsId
                                        , COALESCE (PriceChange_Value_Unit.ValueData, PriceChange_Value_Retail.ValueData) AS PriceChange
                                        , COALESCE (PriceChange_FixPercent_Unit.ValueData, PriceChange_FixPercent_Retail.ValueData)::TFloat           AS FixPercent
                                        , COALESCE (PriceChange_Multiplicity_Unit.ValueData, PriceChange_Multiplicity_Retail.ValueData) ::TFloat AS Multiplicity
                                   FROM Object AS Object_PriceChange
                                        -- ������ �� �������
                                        LEFT JOIN ObjectLink AS ObjectLink_PriceChange_Unit
                                                             ON ObjectLink_PriceChange_Unit.ObjectId = Object_PriceChange.Id
                                                            AND ObjectLink_PriceChange_Unit.DescId = zc_ObjectLink_PriceChange_Unit()
                                                            AND ObjectLink_PriceChange_Unit.ChildObjectId = vbUnitId
                                        -- ���� �� ������� �� �������.
                                        LEFT JOIN ObjectFloat AS PriceChange_Value_Unit
                                                              ON PriceChange_Value_Unit.ObjectId = ObjectLink_PriceChange_Unit.ObjectId
                                                             AND PriceChange_Value_Unit.DescId = zc_ObjectFloat_PriceChange_Value()
                                                             AND COALESCE (PriceChange_Value_Unit.ValueData, 0) <> 0
                                        -- ������� ������ �� �������.
                                        LEFT JOIN ObjectFloat AS PriceChange_FixPercent_Unit
                                                              ON PriceChange_FixPercent_Unit.ObjectId = ObjectLink_PriceChange_Unit.ObjectId
                                                             AND PriceChange_FixPercent_Unit.DescId = zc_ObjectFloat_PriceChange_FixPercent()
                                                             AND COALESCE (PriceChange_FixPercent_Unit.ValueData, 0) <> 0
                                        -- ��������� �������
                                        LEFT JOIN ObjectFloat AS PriceChange_Multiplicity_Unit
                                                              ON PriceChange_Multiplicity_Unit.ObjectId = ObjectLink_PriceChange_Unit.ObjectId
                                                             AND PriceChange_Multiplicity_Unit.DescId = zc_ObjectFloat_PriceChange_Multiplicity()
                                                             AND COALESCE (PriceChange_Multiplicity_Unit.ValueData, 0) <> 0
                                        -- ������ �� ����
                                        LEFT JOIN ObjectLink AS ObjectLink_PriceChange_Retail
                                                             ON ObjectLink_PriceChange_Retail.ObjectId = Object_PriceChange.Id
                                                            AND ObjectLink_PriceChange_Retail.DescId = zc_ObjectLink_PriceChange_Retail()
                                                            AND ObjectLink_PriceChange_Retail.ChildObjectId = vbRetailId
                                        -- ���� �� ������� �� ����
                                        LEFT JOIN ObjectFloat AS PriceChange_Value_Retail
                                                              ON PriceChange_Value_Retail.ObjectId = COALESCE (ObjectLink_PriceChange_Unit.ObjectId, ObjectLink_PriceChange_Retail.ObjectId)
                                                             AND PriceChange_Value_Retail.DescId = zc_ObjectFloat_PriceChange_Value()
                                                             AND COALESCE (PriceChange_Value_Retail.ValueData, 0) <> 0
                                        -- ������� ������ �� ����.
                                        LEFT JOIN ObjectFloat AS PriceChange_FixPercent_Retail
                                                              ON PriceChange_FixPercent_Retail.ObjectId = COALESCE (ObjectLink_PriceChange_Unit.ObjectId, ObjectLink_PriceChange_Retail.ObjectId)
                                                             AND PriceChange_FixPercent_Retail.DescId = zc_ObjectFloat_PriceChange_FixPercent()
                                                             AND COALESCE (PriceChange_FixPercent_Retail.ValueData, 0) <> 0
                                        -- ��������� ������� �� ����.
                                        LEFT JOIN ObjectFloat AS PriceChange_Multiplicity_Retail
                                                              ON PriceChange_Multiplicity_Retail.ObjectId = COALESCE (ObjectLink_PriceChange_Unit.ObjectId, ObjectLink_PriceChange_Retail.ObjectId)
                                                             AND PriceChange_Multiplicity_Retail.DescId = zc_ObjectFloat_PriceChange_Multiplicity()
                                                             AND COALESCE (PriceChange_Multiplicity_Retail.ValueData, 0) <> 0

                                        LEFT JOIN ObjectLink AS ObjectLink_PriceChange_Goods
                                                             ON ObjectLink_PriceChange_Goods.ObjectId = COALESCE (ObjectLink_PriceChange_Unit.ObjectId, ObjectLink_PriceChange_Retail.ObjectId)
                                                            AND ObjectLink_PriceChange_Goods.DescId = zc_ObjectLink_PriceChange_Goods()

                                   WHERE Object_PriceChange.DescId = zc_Object_PriceChange()
                                     AND Object_PriceChange.isErased = FALSE
                                     AND (COALESCE (PriceChange_Value_Retail.ValueData, 0) <> 0 OR COALESCE (PriceChange_Value_Unit.ValueData, 0) <> 0 OR
                                         COALESCE (PriceChange_FixPercent_Unit.ValueData, PriceChange_FixPercent_Retail.ValueData, 0) <> 0) -- �������� ������ ���� <> 0
                                  )
              , tmpPartionDateKind AS (SELECT Object_PartionDateKind.Id           AS Id
                                            , Object_PartionDateKind.ObjectCode   AS Code
                                            , Object_PartionDateKind.ValueData    AS Name
                                            , COALESCE (ObjectFloatDay.ValueData / 30, 0) :: TFLoat AS AmountMonth
                                       FROM Object AS Object_PartionDateKind
                                            LEFT JOIN ObjectFloat AS ObjectFloatDay
                                                                  ON ObjectFloatDay.ObjectId = Object_PartionDateKind.Id
                                                                 AND ObjectFloatDay.DescId = zc_ObjectFloat_PartionDateKind_Day()
                                       WHERE Object_PartionDateKind.DescId = zc_Object_PartionDateKind()
                                      )
               , tmpContainer AS (SELECT CashSessionSnapShot.ObjectId        AS GoodsID   
                                       , SUM(CashSessionSnapShot.Remains)    AS Amount
                                  FROM CashSessionSnapShot
                                  WHERE CashSessionSnapShot.CashSessionId = inCashSessionId
                                  GROUP BY CashSessionSnapShot.ObjectId
                                 )
               , tmpMovementItemContainer AS (SELECT MovementItemContainer.WhereObjectId_Analyzer    AS UnitID
                                                   , MovementItemContainer.ObjectId_Analyzer         AS GoodsID  
                                                   , SUM(MovementItemContainer.Amount)               AS Amount
                                                   , SUM(CASE WHEN MovementItemContainer.MovementDescId = zc_Movement_Check() THEN 1 ELSE 0 END) AS Check
                                              FROM MovementItemContainer 
                                              WHERE MovementItemContainer.WhereObjectId_Analyzer = vbUnitId
                                                AND MovementItemContainer.OperDate >= CURRENT_DATE -  ('100 DAY')::INTERVAL 
                                              GROUP BY MovementItemContainer.WhereObjectId_Analyzer, MovementItemContainer.ObjectId_Analyzer
                                              )
               , tmpNotSold AS (SELECT Container.GoodsID
                                FROM tmpContainer AS Container
                                     LEFT JOIN tmpMovementItemContainer AS MovementItemContainer
                                                                        ON MovementItemContainer.GoodsID = Container.GoodsID 
                                WHERE (Container.Amount >= COALESCE(MovementItemContainer.Amount, 0)) AND COALESCE(MovementItemContainer.Check, 0) = 0
                                )


        -- ���������
        SELECT
            Goods.Id,
            ObjectLink_Main.ChildObjectId AS GoodsId_main,
            Object_GoodsGroup.ValueData   AS GoodsGroupName,
            Goods.ValueData,
            Goods.ObjectCode,
            CashSessionSnapShot.Remains,
            CashSessionSnapShot.Price,

            --
            -- ���� �� ������� ��� ��
            --
            CASE WHEN COALESCE (tmpGoodsSP.PaymentSP, 0) = 0
                      THEN 0 -- �� 0, �.�. ���� ������� = 0

                 WHEN CashSessionSnapShot.Price < COALESCE (tmpGoodsSP.PriceSP, 0)
                      THEN 0 -- �� 0, �.�. ���� ������ ��� ���� ����������

                 -- WHEN CashSessionSnapShot.Price < COALESCE (tmpGoodsSP.PaymentSP, 0)
                 --      THEN CashSessionSnapShot.Price -- �� ����� ����, �.�. ��� ������ ��� ���� �������

                 WHEN CashSessionSnapShot.Price < COALESCE (tmpGoodsSP.PriceSP, 0) + COALESCE (FLOOR (tmpGoodsSP.PaymentSP * 100) / 100, 0)
                   AND 0 > COALESCE (FLOOR (tmpGoodsSP.PaymentSP * 100) / 100, 0) -- "��������� � �������" � ���� ������� �������� �� ...
                         - (COALESCE (CEIL (tmpGoodsSP.PriceSP * 100) / 100, 0) + COALESCE (FLOOR (tmpGoodsSP.PaymentSP * 100) / 100, 0) - CashSessionSnapShot.Price
                           ) -- ������� � ����� ���������� � "��������� � �������"
                      THEN 0

                 WHEN CashSessionSnapShot.Price < COALESCE (tmpGoodsSP.PriceSP, 0) + COALESCE (FLOOR (tmpGoodsSP.PaymentSP * 100) / 100, 0)
                      THEN COALESCE (FLOOR (tmpGoodsSP.PaymentSP * 100) / 100, 0) -- "��������� � �������" � ���� ������� �������� �� ...
                         - (COALESCE (CEIL (tmpGoodsSP.PriceSP * 100) / 100, 0) + COALESCE (FLOOR (tmpGoodsSP.PaymentSP * 100) / 100, 0) - CashSessionSnapShot.Price
                           ) -- ������� � ����� ���������� � "��������� � �������"

                 ELSE COALESCE (FLOOR (tmpGoodsSP.PaymentSP * 100) / 100, 0) -- ����� ������ ���� ������� "��������� � �������"

            END :: TFloat AS PriceSP,


            --
            -- ���� ��� ������ ��� ��
            --
            CASE WHEN CashSessionSnapShot.Price < COALESCE (tmpGoodsSP.PriceSP, 0)
                      THEN CashSessionSnapShot.Price -- �� ����� ����, �.�. ��� ������ ��� ���� ����������

                 /*WHEN CashSessionSnapShot.Price < COALESCE (tmpGoodsSP.PriceSP, 0) + COALESCE (FLOOR (tmpGoodsSP.PaymentSP * 100) / 100, 0)
                      THEN CashSessionSnapShot.Price -- �� ����� ����, �.�. ��� ������ ��� ���� ���������� + ���� ������� "��������� � �������"

                 ELSE COALESCE (tmpGoodsSP.PriceSP, 0)           -- ����� ������ ���� ����������
                    + COALESCE (FLOOR (tmpGoodsSP.PaymentSP * 100) / 100, 0) -- ���� ���� ������� "��������� � �������"
*/
                 ELSE

            CASE WHEN COALESCE (tmpGoodsSP.PaymentSP, 0) = 0
                      THEN 0 -- �� 0, �.�. ���� ������� = 0

                 WHEN CashSessionSnapShot.Price < COALESCE (tmpGoodsSP.PriceSP, 0)
                      THEN 0 -- �� 0, �.�. ���� ������ ��� ���� ����������

                 -- WHEN CashSessionSnapShot.Price < COALESCE (tmpGoodsSP.PaymentSP, 0)
                 --      THEN CashSessionSnapShot.Price -- �� ����� ����, �.�. ��� ������ ��� ���� �������

                 WHEN CashSessionSnapShot.Price < COALESCE (tmpGoodsSP.PriceSP, 0) + COALESCE (FLOOR (tmpGoodsSP.PaymentSP * 100) / 100, 0)
                   AND 0 > COALESCE (FLOOR (tmpGoodsSP.PaymentSP * 100) / 100, 0) -- "��������� � �������" � ���� ������� �������� �� ...
                         - (COALESCE (CEIL (tmpGoodsSP.PriceSP * 100) / 100, 0) + COALESCE (FLOOR (tmpGoodsSP.PaymentSP * 100) / 100, 0) - CashSessionSnapShot.Price
                           ) -- ������� � ����� ���������� � "��������� � �������"
                      THEN 0

                 WHEN CashSessionSnapShot.Price < COALESCE (tmpGoodsSP.PriceSP, 0) + COALESCE (FLOOR (tmpGoodsSP.PaymentSP * 100) / 100, 0)
                      THEN COALESCE (FLOOR (tmpGoodsSP.PaymentSP * 100) / 100, 0) -- "��������� � �������" � ���� ������� �������� �� ...
                         - (COALESCE (CEIL (tmpGoodsSP.PriceSP * 100) / 100, 0) + COALESCE (FLOOR (tmpGoodsSP.PaymentSP * 100) / 100, 0) - CashSessionSnapShot.Price
                           ) -- ������� � ����� ���������� � "��������� � �������"

                 ELSE COALESCE (FLOOR (tmpGoodsSP.PaymentSP * 100) / 100, 0) -- ����� ������ ���� ������� "��������� � �������"

            END
          + COALESCE (tmpGoodsSP.PriceSP, 0)

            END :: TFloat AS PriceSaleSP,

            -- �������� ��� ��������1
           (CASE WHEN tmpGoodsSP.GoodsId IS NULL THEN 0 ELSE
            COALESCE (CashSessionSnapShot.Price, 0)
          - CASE WHEN CashSessionSnapShot.Price < COALESCE (tmpGoodsSP.PriceSP, 0)
                      THEN CashSessionSnapShot.Price -- �� ����� ����, �.�. ��� ������ ��� ���� ����������

                 ELSE
            CASE WHEN COALESCE (tmpGoodsSP.PaymentSP, 0) = 0
                      THEN 0 -- �� 0, �.�. ���� ������� = 0

                 WHEN CashSessionSnapShot.Price < COALESCE (tmpGoodsSP.PriceSP, 0)
                      THEN 0 -- �� 0, �.�. ���� ������ ��� ���� ����������

                 -- WHEN CashSessionSnapShot.Price < COALESCE (tmpGoodsSP.PaymentSP, 0)
                 --      THEN CashSessionSnapShot.Price -- �� ����� ����, �.�. ��� ������ ��� ���� �������

                 WHEN CashSessionSnapShot.Price < COALESCE (tmpGoodsSP.PriceSP, 0) + COALESCE (FLOOR (tmpGoodsSP.PaymentSP * 100) / 100, 0)
                   AND 0 > COALESCE (FLOOR (tmpGoodsSP.PaymentSP * 100) / 100, 0) -- "��������� � �������" � ���� ������� �������� �� ...
                         - (COALESCE (CEIL (tmpGoodsSP.PriceSP * 100) / 100, 0) + COALESCE (FLOOR (tmpGoodsSP.PaymentSP * 100) / 100, 0) - CashSessionSnapShot.Price
                           ) -- ������� � ����� ���������� � "��������� � �������"
                      THEN 0

                 WHEN CashSessionSnapShot.Price < COALESCE (tmpGoodsSP.PriceSP, 0) + COALESCE (FLOOR (tmpGoodsSP.PaymentSP * 100) / 100, 0)
                      THEN COALESCE (FLOOR (tmpGoodsSP.PaymentSP * 100) / 100, 0) -- "��������� � �������" � ���� ������� �������� �� ...
                         - (COALESCE (CEIL (tmpGoodsSP.PriceSP * 100) / 100, 0) + COALESCE (FLOOR (tmpGoodsSP.PaymentSP * 100) / 100, 0) - CashSessionSnapShot.Price
                           ) -- ������� � ����� ���������� � "��������� � �������"

                 ELSE COALESCE (FLOOR (tmpGoodsSP.PaymentSP * 100) / 100, 0) -- ����� ������ ���� ������� "��������� � �������"

            END
          + COALESCE (tmpGoodsSP.PriceSP, 0)


            END
            END
            -- COALESCE (CEIL (tmpGoodsSP.PriceSP * 100) / 100, 0) + COALESCE (FLOOR (tmpGoodsSP.PaymentSP * 100) / 100, 0) - CashSessionSnapShot.Price
            ) :: TFloat AS DiffSP1,

            -- �������� ��� ��������2
           (CASE WHEN CashSessionSnapShot.Price < COALESCE (tmpGoodsSP.PriceSP, 0)
                      THEN CashSessionSnapShot.Price -- �� ����� ����, �.�. ��� ������ ��� ���� ����������

                 ELSE

            CASE WHEN COALESCE (tmpGoodsSP.PaymentSP, 0) = 0
                      THEN 0 -- �� 0, �.�. ���� ������� = 0

                 WHEN CashSessionSnapShot.Price < COALESCE (tmpGoodsSP.PriceSP, 0)
                      THEN 0 -- �� 0, �.�. ���� ������ ��� ���� ����������

                 -- WHEN CashSessionSnapShot.Price < COALESCE (tmpGoodsSP.PaymentSP, 0)
                 --      THEN CashSessionSnapShot.Price -- �� ����� ����, �.�. ��� ������ ��� ���� �������

                 WHEN CashSessionSnapShot.Price < COALESCE (tmpGoodsSP.PriceSP, 0) + COALESCE (FLOOR (tmpGoodsSP.PaymentSP * 100) / 100, 0)
                   AND 0 > COALESCE (FLOOR (tmpGoodsSP.PaymentSP * 100) / 100, 0) -- "��������� � �������" � ���� ������� �������� �� ...
                         - (COALESCE (CEIL (tmpGoodsSP.PriceSP * 100) / 100, 0) + COALESCE (FLOOR (tmpGoodsSP.PaymentSP * 100) / 100, 0) - CashSessionSnapShot.Price
                           ) -- ������� � ����� ���������� � "��������� � �������"
                      THEN 0

                 WHEN CashSessionSnapShot.Price < COALESCE (tmpGoodsSP.PriceSP, 0) + COALESCE (FLOOR (tmpGoodsSP.PaymentSP * 100) / 100, 0)
                      THEN COALESCE (FLOOR (tmpGoodsSP.PaymentSP * 100) / 100, 0) -- "��������� � �������" � ���� ������� �������� �� ...
                         - (COALESCE (CEIL (tmpGoodsSP.PriceSP * 100) / 100, 0) + COALESCE (FLOOR (tmpGoodsSP.PaymentSP * 100) / 100, 0) - CashSessionSnapShot.Price
                           ) -- ������� � ����� ���������� � "��������� � �������"

                 ELSE COALESCE (FLOOR (tmpGoodsSP.PaymentSP * 100) / 100, 0) -- ����� ������ ���� ������� "��������� � �������"

            END
          + COALESCE (tmpGoodsSP.PriceSP, 0)

            END

          - CASE WHEN COALESCE (tmpGoodsSP.PaymentSP, 0) = 0
                      THEN 0 -- �� 0, �.�. ���� ������� = 0

                 WHEN CashSessionSnapShot.Price < COALESCE (tmpGoodsSP.PriceSP, 0)
                      THEN 0 -- �� 0, �.�. ���� ������ ��� ���� ����������

                 -- WHEN CashSessionSnapShot.Price < COALESCE (tmpGoodsSP.PaymentSP, 0)
                 --      THEN CashSessionSnapShot.Price -- �� ����� ����, �.�. ��� ������ ��� ���� �������

                 WHEN CashSessionSnapShot.Price < COALESCE (tmpGoodsSP.PriceSP, 0) + COALESCE (FLOOR (tmpGoodsSP.PaymentSP * 100) / 100, 0)
                   AND 0 > COALESCE (FLOOR (tmpGoodsSP.PaymentSP * 100) / 100, 0) -- "��������� � �������" � ���� ������� �������� �� ...
                         - (COALESCE (CEIL (tmpGoodsSP.PriceSP * 100) / 100, 0) + COALESCE (FLOOR (tmpGoodsSP.PaymentSP * 100) / 100, 0) - CashSessionSnapShot.Price
                           ) -- ������� � ����� ���������� � "��������� � �������"
                      THEN 0

                 WHEN CashSessionSnapShot.Price < COALESCE (tmpGoodsSP.PriceSP, 0) + COALESCE (FLOOR (tmpGoodsSP.PaymentSP * 100) / 100, 0)
                      THEN COALESCE (FLOOR (tmpGoodsSP.PaymentSP * 100) / 100, 0) -- "��������� � �������" � ���� ������� �������� �� ...
                         - (COALESCE (CEIL (tmpGoodsSP.PriceSP * 100) / 100, 0) + COALESCE (FLOOR (tmpGoodsSP.PaymentSP * 100) / 100, 0) - CashSessionSnapShot.Price
                           ) -- ������� � ����� ���������� � "��������� � �������"

                 ELSE COALESCE (FLOOR (tmpGoodsSP.PaymentSP * 100) / 100, 0) -- ����� ������ ���� ������� "��������� � �������"

            END
           ) :: TFloat AS DiffSP2,

            NULLIF (CashSessionSnapShot.Reserved, 0) :: TFloat AS Reserved,
            CashSessionSnapShot.MCSValue,
            Link_Goods_AlternativeGroup.ChildObjectId as AlternativeGroupId,
            ObjectFloat_NDSKind_NDS.ValueData AS NDS,
            COALESCE(ObjectBoolean_First.ValueData, False)          AS isFirst,
            COALESCE(ObjectBoolean_Second.ValueData, False)         AS isSecond,
            CASE WHEN COALESCE(ObjectBoolean_Second.ValueData, False) = TRUE THEN 16440317 WHEN COALESCE(ObjectBoolean_First.ValueData, False) = TRUE THEN zc_Color_GreenL() ELSE zc_Color_White() END AS Color_calc,
            CASE WHEN COALESCE(GoodsPromo.GoodsId,0) <> 0 THEN TRUE ELSE FALSE END AS isPromo,
            Object_Maker.ValueData                                                 AS MakerName, 
            CASE WHEN tmpGoodsSP.GoodsId IS NULL THEN FALSE ELSE TRUE END :: Boolean  AS isSP,
            Object_IntenalSP.ValueData AS IntenalSPName,
            CashSessionSnapShot.MinExpirationDate,
            NULLIF (CashSessionSnapShot.PartionDateKindId, 0)  AS PartionDateKindId,
            Object_PartionDateKind.Name                        AS PartionDateKindName,
            CASE WHEN vbDividePartionDate = False
              THEN
                CASE WHEN CashSessionSnapShot.MinExpirationDate < CURRENT_DATE + zc_Interval_ExpirationDate() THEN zc_Color_Red() ELSE zc_Color_Black() END
              ELSE
                CASE CashSessionSnapShot.PartionDateKindId WHEN zc_Enum_PartionDateKind_0() THEN zc_Color_Red()
                                                           WHEN zc_Enum_PartionDateKind_1() THEN 36095
                                                           WHEN zc_Enum_PartionDateKind_6() THEN zc_Color_Blue()
                                                           WHEN zc_Enum_PartionDateKind_Cat_5() THEN 32768
                                                           ELSE zc_Color_Black() END END::Integer                     AS Color_ExpirationDate,
            COALESCE(Object_ConditionsKeep.ValueData, '') ::TVarChar  AS ConditionsKeepName,

            COALESCE(tmpIncome.AmountIncome,0)            :: TFloat   AS AmountIncome,
            CASE WHEN COALESCE(tmpIncome.AmountIncome,0) <> 0 THEN COALESCE(tmpIncome.SummSale,0) / COALESCE(tmpIncome.AmountIncome,0) ELSE 0 END  :: TFloat AS PriceSaleIncome,
            COALESCE (tmpGoodsMorion.MorionCode, 0) :: Integer  AS MorionCode,
            COALESCE (tmpGoodsBarCode.BarCode, '')  :: TVarChar AS BarCode

          , tmpMCSAuto.MCSValueOld
          , tmpMCSAuto.StartDateMCSAuto
          , tmpMCSAuto.EndDateMCSAuto
          , tmpMCSAuto.isMCSAuto
          , tmpMCSAuto.isMCSNotRecalcOld
          , CashSessionSnapShot.AccommodationId
          , Object_Accommodation.ValueData AS AccommodationName
          , tmpPriceChange.PriceChange
          , tmpPriceChange.FixPercent
          , tmpPriceChange.Multiplicity
          , COALESCE (ObjectBoolean_DoesNotShare.ValueData, FALSE) AS DoesNotShare
          , NULL::Integer                                          AS GoodsAnalogId
          , NULL::TVarChar                                         AS GoodsAnalogName
          , ObjectString_Goods_Analog.ValueData                    AS GoodsAnalog
          , tmpGoodsSP.CountSP                                     AS CountSP
          , tmpGoodsSP.IdSP                                        AS IdSP
          , tmpGoodsSP.DosageIdSP                                  AS DosageIdSP
          , tmpGoodsSP.PriceRetSP                                  AS PriceRetSP
          , tmpGoodsSP.PaymentSP                                   AS PaymentSP
          , CASE CashSessionSnapShot.PartionDateKindId
            WHEN zc_Enum_PartionDateKind_Good() THEN vbDay_6 / 30.0 + 1.0
            WHEN zc_Enum_PartionDateKind_Cat_5() THEN vbDay_6 / 30.0 - 1.0
            ELSE Object_PartionDateKind.AmountMonth END::TFloat AS AmountMonth
          , CASE CashSessionSnapShot.PartionDateKindId
                 WHEN zc_Enum_PartionDateKind_0() THEN ROUND(CashSessionSnapShot.Price * (100.0 - CashSessionSnapShot.PartionDateDiscount) / 100, 2)
                 WHEN zc_Enum_PartionDateKind_1() THEN ROUND(CashSessionSnapShot.Price * (100.0 - CashSessionSnapShot.PartionDateDiscount) / 100, 2)
                 WHEN zc_Enum_PartionDateKind_6() THEN
                     CASE WHEN CashSessionSnapShot.Price > CashSessionSnapShot.PriceWithVAT
                          THEN ROUND(CashSessionSnapShot.Price - (CashSessionSnapShot.Price - CashSessionSnapShot.PriceWithVAT) *
                                     CashSessionSnapShot.PartionDateDiscount / 100, 2)
                          ELSE CashSessionSnapShot.Price
                     END
                 WHEN zc_Enum_PartionDateKind_Cat_5() THEN
                     CASE WHEN CashSessionSnapShot.Price > CashSessionSnapShot.PriceWithVAT
                          THEN ROUND(CashSessionSnapShot.Price - (CashSessionSnapShot.Price - CashSessionSnapShot.PriceWithVAT) *
                                     CashSessionSnapShot.PartionDateDiscount / 100, 2)
                          ELSE CashSessionSnapShot.Price
                     END
                 ELSE NULL
            END                                          :: TFloat AS PricePartionDate
          , CashSessionSnapShot.PartionDateDiscount                AS PartionDateDiscount
          , COALESCE(tmpNotSold.GoodsID, 0) <> 0                   AS NotSold


          , CashSessionSnapShot.PartionDateKindId   AS PartionDateKindId_check
          , CashSessionSnapShot.Price               AS Price_check
          , CashSessionSnapShot.PriceWithVAT        AS PriceWithVAT_check
          , CashSessionSnapShot.PartionDateDiscount AS PartionDateDiscount_check

         FROM
            CashSessionSnapShot
            INNER JOIN Object AS Goods ON Goods.Id = CashSessionSnapShot.ObjectId
            LEFT JOIN tmpMCSAuto ON tmpMCSAuto.ObjectId = CashSessionSnapShot.ObjectId
            LEFT OUTER JOIN ObjectLink AS Link_Goods_AlternativeGroup
                                       ON Link_Goods_AlternativeGroup.ObjectId = Goods.Id
                                      AND Link_Goods_AlternativeGroup.DescId = zc_ObjectLink_Goods_AlternativeGroup()
            LEFT OUTER JOIN ObjectLink AS ObjectLink_Goods_NDSKind
                                       ON ObjectLink_Goods_NDSKind.ObjectId = Goods.Id
                                      AND ObjectLink_Goods_NDSKind.DescId = zc_ObjectLink_Goods_NDSKind()
            LEFT OUTER JOIN ObjectFloat AS ObjectFloat_NDSKind_NDS
                                        ON ObjectFloat_NDSKind_NDS.ObjectId = ObjectLink_Goods_NDSKind.ChildObjectId

            LEFT JOIN ObjectBoolean AS ObjectBoolean_First
                                    ON ObjectBoolean_First.ObjectId = Goods.Id
                                   AND ObjectBoolean_First.DescId = zc_ObjectBoolean_Goods_First()
            LEFT JOIN ObjectBoolean AS ObjectBoolean_Second
                                    ON ObjectBoolean_Second.ObjectId = Goods.Id
                                   AND ObjectBoolean_Second.DescId = zc_ObjectBoolean_Goods_Second()

            LEFT JOIN GoodsPromo ON GoodsPromo.GoodsId = Goods.Id
            -- �������������
            LEFT JOIN Object AS Object_Maker  ON Object_Maker.ID = GoodsPromo.MakerID
            
            LEFT JOIN tmpIncome ON tmpIncome.GoodsId = Goods.Id

            -- ���������� GoodsMainId
            LEFT JOIN  ObjectLink AS ObjectLink_Child ON ObjectLink_Child.ChildObjectId = Goods.Id
                                                     AND ObjectLink_Child.DescId = zc_ObjectLink_LinkGoods_Goods()
            LEFT JOIN  ObjectLink AS ObjectLink_Main ON ObjectLink_Main.ObjectId = ObjectLink_Child.ObjectId
                                                    AND ObjectLink_Main.DescId = zc_ObjectLink_LinkGoods_GoodsMain()
            -- ��� ������
            LEFT JOIN tmpGoodsSP ON tmpGoodsSP.GoodsId = ObjectLink_Main.ChildObjectId
                                AND tmpGoodsSP.Ord     = 1 -- � �/� - �� ������ ������
            LEFT JOIN  Object AS Object_IntenalSP ON Object_IntenalSP.Id = tmpGoodsSP.IntenalSPId

            -- ������� ��������
            LEFT JOIN ObjectLink AS ObjectLink_Goods_ConditionsKeep
                                 ON ObjectLink_Goods_ConditionsKeep.ObjectId = Goods.Id
                                AND ObjectLink_Goods_ConditionsKeep.DescId = zc_ObjectLink_Goods_ConditionsKeep()
            LEFT JOIN Object AS Object_ConditionsKeep ON Object_ConditionsKeep.Id = ObjectLink_Goods_ConditionsKeep.ChildObjectId
            --
            LEFT JOIN ObjectLink AS ObjectLink_Goods_GoodsGroup
                                 ON ObjectLink_Goods_GoodsGroup.ObjectId = Goods.Id
                                AND ObjectLink_Goods_GoodsGroup.DescId = zc_ObjectLink_Goods_GoodsGroup()
            LEFT JOIN Object AS Object_GoodsGroup ON Object_GoodsGroup.Id = ObjectLink_Goods_GoodsGroup.ChildObjectId
            -- �����-��� �������������
            LEFT JOIN tmpGoodsBarCode ON tmpGoodsBarCode.GoodsMainId = ObjectLink_Main.ChildObjectId
            -- ��� �������
            LEFT JOIN tmpGoodsMorion ON tmpGoodsMorion.GoodsMainId = ObjectLink_Main.ChildObjectId
            -- ���������� ������
            LEFT JOIN Object AS Object_Accommodation  ON Object_Accommodation.ID = CashSessionSnapShot.AccommodationId
            -- ���� �� �������
            LEFT JOIN tmpPriceChange ON tmpPriceChange.GoodsId = Goods.Id
            -- �� ������ ���������� �� ������
            LEFT JOIN ObjectBoolean AS ObjectBoolean_DoesNotShare
                                    ON ObjectBoolean_DoesNotShare.ObjectId = Goods.Id
                                   AND ObjectBoolean_DoesNotShare.DescId = zc_ObjectBoolean_Goods_DoesNotShare()

           -- ������� ������
           LEFT JOIN ObjectString AS ObjectString_Goods_Analog
                                  ON ObjectString_Goods_Analog.ObjectId = ObjectLink_Main.ChildObjectId
                                 AND ObjectString_Goods_Analog.DescId = zc_ObjectString_Goods_Analog()

           -- ��� ����/�� ����
           LEFT JOIN tmpPartionDateKind AS Object_PartionDateKind ON Object_PartionDateKind.Id = NULLIF (CashSessionSnapShot.PartionDateKindId, 0)

           -- ������� �� ��������� 100 ����
           LEFT JOIN tmpNotSold ON tmpNotSold.GoodsID = Goods.Id

        WHERE
            CashSessionSnapShot.CashSessionId = inCashSessionId
        ORDER BY
            Goods.Id;

    vb1:= (SELECT COUNT (*) FROM CashSessionSnapShot WHERE CashSessionSnapShot.CashSessionId = inCashSessionId) :: TVarChar;
    vb2:= ((CLOCK_TIMESTAMP() - vbOperDate_StartBegin) :: INTERVAL) :: TVarChar;

    -- !!!�������� - ������� ��������!!!
    INSERT INTO Log_Reprice (InsertDate, StartDate, EndDate, MovementId, UserId, TextValue)
      VALUES (CURRENT_TIMESTAMP, vbOperDate_StartBegin, CLOCK_TIMESTAMP(), vbUnitId, vbUserId
            , vb2
    || ' '   || REPEAT ('0', 8 - LENGTH (vb1)) || vb1 || '-1'
    || ' '   || lfGet_Object_ValueData_sh (vbUnitId)
    || ' + ' || lfGet_Object_ValueData_sh (vbUserId)
    || ','   || vbUnitId              :: TVarChar
    || ','   || CHR (39) || inCashSessionId || CHR (39)
             );

END;
$BODY$
  LANGUAGE PLPGSQL VOLATILE;
ALTER FUNCTION gpSelect_CashRemains_ver2 (TVarChar, TVarChar) OWNER TO postgres;

/*
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.   ������ �.�.   ��������� �.�.  �������� �.�.  ������ �.�.
 15.07.19                                                                                                    *
 28.05.19                                                                                                    * PartionDateKindId
 13.05.19                                                                                                    *
 24.04.19                                                                                                    * Helsi
 04.04.19                                                                                                    * GoodsAnalog
 06.03.19                                                                                                    * DoesNotShare
 11.02.19                                                                                                    *
 30.10.18                                                                                                    *
 01.10.18         * tmpPriceChange - ���� ������ �������������
 21.06.17         *
 09.06.17         *
 24.05.17                                                                                      * MorionCode
 23.05.17                                                                                      * BarCode
 25.01.16         *
 24.01.17         * add ConditionsKeepName
 06.09.16         *
 12.04.16         *
 02.11.15                                                                       *NDS
 10.09.15                                                                       *CashSessionSnapShot
 22.08.15                                                                       *���������� ��� � ���������
 19.08.15                                                                       *CurrentMovement
 05.05.15                        *

*/

-- ����
-- SELECT * FROM gpSelect_CashRemains_ver2 ('{85E257DE-0563-4B9E-BE1C-4D5C123FB33A}-', '10411288')
-- SELECT * FROM gpSelect_CashRemains_ver2 ('{85E257DE-0563-4B9E-BE1C-4D5C123FB33A}-', '3998773') WHERE GoodsCode = 1240
