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
               isPromo boolean,
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
               DoesNotShare boolean, GoodsAnalogId Integer, GoodsAnalogName TVarChar,
               CountSP TFloat, IdSP TVarChar, DosageIdSP TVarChar, PriceRetSP TFloat, PaymentSP TFloat,
               AmountMonth TFloat, PartionDateDiscount TFloat
               )
AS
$BODY$
   DECLARE vbUserId Integer;
   DECLARE vbUnitId Integer;
   DECLARE vbUnitKey TVarChar;
   DECLARE vbObjectId Integer;
   DECLARE vbRetailId Integer;

   DECLARE vbMonth_0  TFloat;
   DECLARE vbMonth_1  TFloat;
   DECLARE vbMonth_6  TFloat;

   DECLARE vbDate0    TDateTime;
   DECLARE vbDate180  TDateTime;
   DECLARE vbDate30   TDateTime;
BEGIN
-- if inSession = '3' then return; end if;

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

    vbObjectId := COALESCE(lpGet_DefaultValue('zc_Object_Retail', vbUserId), '0');

    -- �������� �������� �� ����������� ��� ���������� �� ������
    vbMonth_0 := (SELECT ObjectFloat_Month.ValueData
                  FROM Object  AS Object_PartionDateKind
                       LEFT JOIN ObjectFloat AS ObjectFloat_Month
                                             ON ObjectFloat_Month.ObjectId = Object_PartionDateKind.Id
                                            AND ObjectFloat_Month.DescId = zc_ObjectFloat_PartionDateKind_Month()
                  WHERE Object_PartionDateKind.Id = zc_Enum_PartionDateKind_0());
    vbMonth_1 := (SELECT ObjectFloat_Month.ValueData
                  FROM Object  AS Object_PartionDateKind
                       LEFT JOIN ObjectFloat AS ObjectFloat_Month
                                             ON ObjectFloat_Month.ObjectId = Object_PartionDateKind.Id
                                            AND ObjectFloat_Month.DescId = zc_ObjectFloat_PartionDateKind_Month()
                  WHERE Object_PartionDateKind.Id = zc_Enum_PartionDateKind_1());
    vbMonth_6 := (SELECT ObjectFloat_Month.ValueData
                  FROM Object  AS Object_PartionDateKind
                       LEFT JOIN ObjectFloat AS ObjectFloat_Month
                                             ON ObjectFloat_Month.ObjectId = Object_PartionDateKind.Id
                                            AND ObjectFloat_Month.DescId = zc_ObjectFloat_PartionDateKind_Month()
                  WHERE Object_PartionDateKind.Id = zc_Enum_PartionDateKind_6());

    -- ���� + 6 �������, + 1 �����
    vbDate180 := CURRENT_DATE + (vbMonth_6||' MONTH' ) ::INTERVAL;
    vbDate30  := CURRENT_DATE + (vbMonth_1||' MONTH' ) ::INTERVAL;
    vbDate0   := CURRENT_DATE + (vbMonth_0||' MONTH' ) ::INTERVAL;

    -- �������� ����� ������ ��������� ����� / �������� ���� ���������� ���������
    PERFORM lpInsertUpdate_CashSession (inCashSessionId := inCashSessionId
                                      , inDateConnect   := CURRENT_TIMESTAMP :: TDateTime
                                      , inUserId        := vbUserId
                                       );

    --�������� ���������� �������� ������
    DELETE FROM CashSessionSnapShot
    WHERE CashSessionId = inCashSessionId;

    -- ������
    WITH tmpContainer AS (SELECT Container.Id, Container.ObjectId, Container.Amount
                          FROM Container
                          WHERE Container.DescId = zc_Container_Count()
                            AND Container.WhereObjectId = vbUnitId
                            AND Container.Amount <> 0
                         )
       , tmpCLO AS (SELECT CLO.*
                    FROM ContainerlinkObject AS CLO
                    WHERE CLO.ContainerId IN (SELECT DISTINCT tmpContainer.Id FROM tmpContainer)
                      AND CLO.DescId = zc_ContainerLinkObject_PartionMovementItem()
                   )
       , tmpObject AS (SELECT Object.* FROM Object WHERE Object.Id IN (SELECT DISTINCT tmpCLO.ObjectId FROM tmpCLO))

       , tmpMIDate AS (SELECT MovementItemDate.*
                       FROM MovementItemDate
                       WHERE MovementItemDate.MovementItemId IN (SELECT DISTINCT tmpObject.ObjectCode FROM tmpObject)
                         AND MovementItemDate.DescId = zc_MIDate_PartionGoods()
                      )

       , tmpExpirationDate AS (SELECT tmpCLO.ContainerId, MIDate_ExpirationDate.ValueData
                               FROM tmpCLO
                                    INNER JOIN tmpObject ON tmpObject.Id = tmpCLO.ObjectId
                                    INNER JOIN tmpMIDate AS MIDate_ExpirationDate
                                                         ON MIDate_ExpirationDate.MovementItemId = tmpObject.ObjectCode
                                                        -- AND MIDate_ExpirationDate.DescId = zc_MIDate_PartionGoods()
                               )
       , tmpGoodsRemains AS (SELECT Container.ObjectId
                                  , SUM (Container.Amount) AS Remains
                                  , MIN (COALESCE (tmpExpirationDate.ValueData, zc_DateEnd())) :: TDateTime AS MinExpirationDate -- ���� ��������
                             FROM tmpContainer AS Container
                                  -- ������� ������
                                  LEFT JOIN tmpExpirationDate ON tmpExpirationDate.Containerid = Container.Id
                                GROUP BY Container.ObjectId
                             )

          -- ������� �� ������
       , tmpPDContainer AS (SELECT Container.Id, Container.ObjectId, Container.Amount
                            FROM Container
                            WHERE Container.DescId = zc_Container_CountPartionDate()
                              AND Container.WhereObjectId = vbUnitId
                              AND Container.Amount <> 0)
       , tmpPDCLO AS (SELECT CLO.*
                    FROM ContainerlinkObject AS CLO
                    WHERE CLO.ContainerId IN (SELECT DISTINCT tmpPDContainer.Id FROM tmpPDContainer)
                      AND CLO.DescId = zc_ContainerLinkObject_PartionMovementItem()
                   )
       , tmpPDObject AS (SELECT Object.* FROM Object WHERE Object.Id IN (SELECT DISTINCT tmpPDCLO.ObjectId FROM tmpPDCLO))

       , tmpPDMIDate AS (SELECT MovementItemDate.*
                       FROM MovementItemDate
                       WHERE MovementItemDate.MovementItemId IN (SELECT DISTINCT tmpPDObject.ObjectCode FROM tmpPDObject)
                         AND MovementItemDate.DescId = zc_MIDate_PartionGoods()
                      )
       , tmpPDMIIncomeFind AS (SELECT MIFloat_MovementItem.MovementItemId        AS MovementItemId
                                    , MIFloat_MovementItem.ValueData::Integer    AS ID
                               FROM MovementItemFloat AS MIFloat_MovementItem
                               WHERE MIFloat_MovementItem.MovementItemId IN (SELECT DISTINCT tmpPDObject.ObjectCode FROM tmpPDObject)
                               AND MIFloat_MovementItem.DescId = zc_MIFloat_MovementItemId())
       , tmpPDMIDateFind AS (SELECT MovementItemDate.*
                             FROM MovementItemDate
                             WHERE MovementItemDate.MovementItemId IN (SELECT DISTINCT tmpPDMIIncomeFind.ID FROM tmpPDMIIncomeFind)
                               AND MovementItemDate.DescId = zc_MIDate_PartionGoods()
                            )

       , tmpPDExpirationDate AS (SELECT tmpPDCLO.ContainerId, COALESCE(MIDate_ExpirationDateFind.ValueData, MIDate_ExpirationDate.ValueData) AS ExpirationDate
                                 FROM tmpPDCLO
                                      LEFT JOIN tmpPDObject ON tmpPDObject.Id = tmpPDCLO.ObjectId
                                      LEFT JOIN tmpPDMIDate AS MIDate_ExpirationDate
                                                            ON MIDate_ExpirationDate.MovementItemId = tmpPDObject.ObjectCode
                                      LEFT JOIN tmpPDMIIncomeFind ON tmpPDMIIncomeFind.MovementItemId = tmpPDObject.ObjectCode
                                      LEFT JOIN tmpPDMIDateFind AS MIDate_ExpirationDateFind
                                                            ON MIDate_ExpirationDateFind.MovementItemId = tmpPDMIIncomeFind.Id
                                )
       , tmpPDGoodsRemains AS (SELECT Container.ObjectId
                                    , Object_PartionDateKind.Id                                         AS PartionDateKindId
                                    , SUM (Container.Amount)                                            AS Remains
                                    , MIN (tmpPDExpirationDate.ExpirationDate)::TDateTime               AS MinExpirationDate
                               FROM tmpPDContainer AS Container

                                    LEFT JOIN tmpPDExpirationDate ON tmpPDExpirationDate.Containerid = Container.Id

                                    LEFT OUTER JOIN Object AS Object_PartionDateKind ON Object_PartionDateKind.Id =
                                         CASE WHEN tmpPDExpirationDate.ExpirationDate <= vbDate0 THEN zc_Enum_PartionDateKind_0() ELSE       -- ����������
                                         CASE WHEN tmpPDExpirationDate.ExpirationDate <= vbDate30 THEN zc_Enum_PartionDateKind_1() ELSE      -- ������ 1 ������
                                         CASE WHEN tmpPDExpirationDate.ExpirationDate <= vbDate180 THEN zc_Enum_PartionDateKind_6() ELSE     -- ������ 6 ������
                                         NULL END END END

                               GROUP BY Container.ObjectId
                                      , Object_PartionDateKind.Id
                              )
       , tmpPDGoodsRemainsAll AS (SELECT tmpPDGoodsRemains.ObjectId
                                       , SUM (tmpPDGoodsRemains.Remains)                                                         AS Remains
                                  FROM tmpPDGoodsRemains
                                  GROUP BY tmpPDGoodsRemains.ObjectId
                                 )
          -- ��������������� �������
       , GoodsRemains AS (SELECT Container.ObjectId
                               , Container.Remains - COALESCE(tmpPDGoodsRemainsAll.Remains, 0)  AS Remains
                               , Container.MinExpirationDate
                               , NULL                                                           AS PartionDateKindId
                          FROM tmpGoodsRemains AS Container
                               LEFT JOIN tmpPDGoodsRemainsAll ON tmpPDGoodsRemainsAll.ObjectId = Container.ObjectId
                          UNION ALL
                          SELECT tmpPDGoodsRemains.ObjectId
                               , tmpPDGoodsRemains.Remains
                               , tmpPDGoodsRemains.MinExpirationDate
                               , tmpPDGoodsRemains.PartionDateKindId
                          FROM tmpPDGoodsRemains
                         )

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
  , RESERVE
    AS
    (
        SELECT MovementItem.ObjectId                       AS GoodsId
             , Sum(MovementItem.Amount)::TFloat            AS Amount
             , MovementLinkObject_PartionDateKind.ObjectId AS PartionDateKindId
        FROM tmpMov
                     INNER JOIN MovementItem ON MovementItem.MovementId = tmpMov.Id
                                            AND MovementItem.DescId     = zc_MI_Master()
                                            AND MovementItem.isErased   = FALSE

                     LEFT JOIN MovementLinkObject AS MovementLinkObject_PartionDateKind
                                                  ON MovementLinkObject_PartionDateKind.MovementId = tmpMov.Id
                                                 AND MovementLinkObject_PartionDateKind.DescId = zc_MovementLinkObject_PartionDateKind()
        GROUP BY MovementItem.ObjectId, MovementLinkObject_PartionDateKind.ObjectId
    )


    --������ �������
    INSERT INTO CashSessionSnapShot(CashSessionId,ObjectId,PartionDateKindId,Price,Remains,MCSValue,Reserved,MinExpirationDate,AccommodationId)
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
        inCashSessionId                              AS CashSession
       ,GoodsRemains.ObjectId                        AS GoodsId
       ,COALESCE (GoodsRemains.PartionDateKindId, 0) AS PartionDateKindId
       ,COALESCE(tmpObject_Price.Price,0)            AS Price
       ,(GoodsRemains.Remains
            - COALESCE(Reserve.Amount,0))::TFloat    AS Remains
       ,tmpObject_Price.MCSValue                     AS MCSValue
       ,Reserve.Amount::TFloat                       AS Reserved
       ,GoodsRemains.MinExpirationDate               AS MinExpirationDate
       ,Accommodation.AccommodationId                AS AccommodationId

    FROM
        GoodsRemains
        LEFT OUTER JOIN tmpObject_Price ON tmpObject_Price.GoodsId = GoodsRemains.ObjectId
        LEFT OUTER JOIN RESERVE ON RESERVE.GoodsId = GoodsRemains.ObjectId
                               AND COALESCE(RESERVE.PartionDateKindId, 0) = COALESCE(GoodsRemains.PartionDateKindId, 0)
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
         , GoodsPromo AS (SELECT DISTINCT ObjectLink_Child_retail.ChildObjectId AS GoodsId  -- ����� ����� "����"
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
                                            , COALESCE (ObjectFloat_Month.ValueData, 0) :: TFLoat AS AmountMonth
                                       FROM Object AS Object_PartionDateKind
                                            LEFT JOIN ObjectFloat AS ObjectFloat_Month
                                                                  ON ObjectFloat_Month.ObjectId = Object_PartionDateKind.Id
                                                                 AND ObjectFloat_Month.DescId = zc_ObjectFloat_PartionDateKind_Month()
                                       WHERE Object_PartionDateKind.DescId = zc_Object_PartionDateKind()
                                      )
              , tmpMovSendPartion AS (SELECT
                                             Movement.Id                               AS Id
                                           , MovementFloat_ChangePercent.ValueData     AS ChangePercent
                                           , MovementFloat_ChangePercentMin.ValueData  AS ChangePercentMin
                                      FROM Movement

                                           LEFT JOIN MovementFloat AS MovementFloat_ChangePercent
                                                                   ON MovementFloat_ChangePercent.MovementId =  Movement.Id
                                                                  AND MovementFloat_ChangePercent.DescId = zc_MovementFloat_ChangePercent()

                                           LEFT JOIN MovementFloat AS MovementFloat_ChangePercentMin
                                                                   ON MovementFloat_ChangePercentMin.MovementId =  Movement.Id
                                                                  AND MovementFloat_ChangePercentMin.DescId = zc_MovementFloat_ChangePercentMin()

                                           LEFT JOIN MovementLinkObject AS MovementLinkObject_Unit
                                                                        ON MovementLinkObject_Unit.MovementId = Movement.Id
                                                                       AND MovementLinkObject_Unit.DescId = zc_MovementLinkObject_Unit()

                                      WHERE Movement.DescId = zc_Movement_SendPartionDate()
                                        AND Movement.StatusId = zc_Enum_Status_Complete()
                                        AND MovementLinkObject_Unit.ObjectId = vbUnitId
                                      ORDER BY Movement.OperDate
                                      LIMIT 1
                                     )
              , tmpMovItemSendPartion AS (SELECT
                                                 MovementItem.ObjectId    AS GoodsId
                                               , MIFloat_ChangePercent.ValueData    AS ChangePercent
                                               , MIFloat_ChangePercentMin.ValueData AS ChangePercentMin

                                          FROM MovementItem

                                               LEFT JOIN MovementItemFloat AS MIFloat_ChangePercent
                                                                           ON MIFloat_ChangePercent.MovementItemId = MovementItem.Id
                                                                          AND MIFloat_ChangePercent.DescId = zc_MIFloat_ChangePercent()
                                               LEFT JOIN MovementItemFloat AS MIFloat_ChangePercentMin
                                                                           ON MIFloat_ChangePercentMin.MovementItemId = MovementItem.Id
                                                                          AND MIFloat_ChangePercentMin.DescId = zc_MIFloat_ChangePercentMin()

                                          WHERE MovementItem.MovementId = (select tmpMovSendPartion.Id from tmpMovSendPartion)
                                            AND MovementItem.DescId = zc_MI_Master()
                                            AND (MIFloat_ChangePercent.ValueData is not Null OR MIFloat_ChangePercentMin.ValueData is not Null)

                                         )
              , tmpPDChangePercent AS (SELECT Object_PartionDateKind.Id           AS Id,
                                              CASE Object_PartionDateKind.Id
                                                   WHEN zc_Enum_PartionDateKind_0() THEN tmpMovSendPartion.ChangePercentMin
                                                   WHEN zc_Enum_PartionDateKind_1() THEN tmpMovSendPartion.ChangePercentMin
                                                   WHEN zc_Enum_PartionDateKind_6() THEN tmpMovSendPartion.ChangePercent END AS PartionDateDiscount
                                       FROM Object AS Object_PartionDateKind
                                            LEFT JOIN tmpMovSendPartion ON 1 = 1
                                       WHERE Object_PartionDateKind.DescId = zc_Object_PartionDateKind()
                                       )

              , tmpPDChangePercentGoods AS (SELECT Object_PartionDateKind.Id           AS Id
                                                 , tmpMovItemSendPartion.GoodsId
                                                 , CASE Object_PartionDateKind.Id
                                                        WHEN zc_Enum_PartionDateKind_0() THEN tmpMovItemSendPartion.ChangePercentMin
                                                        WHEN zc_Enum_PartionDateKind_1() THEN tmpMovItemSendPartion.ChangePercentMin
                                                        WHEN zc_Enum_PartionDateKind_6() THEN tmpMovItemSendPartion.ChangePercent END AS PartionDateDiscount
                                            FROM Object AS Object_PartionDateKind
                                                 LEFT JOIN tmpMovItemSendPartion ON 1 = 1
                                            WHERE Object_PartionDateKind.DescId = zc_Object_PartionDateKind()
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
            CASE WHEN tmpGoodsSP.GoodsId IS NULL THEN FALSE ELSE TRUE END :: Boolean  AS isSP,
            Object_IntenalSP.ValueData AS IntenalSPName,
            CashSessionSnapShot.MinExpirationDate,
            NULLIF (CashSessionSnapShot.PartionDateKindId, 0)  AS PartionDateKindId,
            Object_PartionDateKind.Name                        AS PartionDateKindName,
            CASE WHEN CashSessionSnapShot.MinExpirationDate < CURRENT_DATE + zc_Interval_ExpirationDate() THEN zc_Color_Red() ELSE zc_Color_Black() END AS Color_ExpirationDate,                --vbAVGDateEnd
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
          , Object_GoodsAnalog.Id                                  AS GoodsAnalogId
          , Object_GoodsAnalog.ValueData                           AS GoodsAnalogName
          , tmpGoodsSP.CountSP                                     AS CountSP
          , tmpGoodsSP.IdSP                                        AS IdSP
          , tmpGoodsSP.DosageIdSP                                  AS DosageIdSP
          , tmpGoodsSP.PriceRetSP                                  AS PriceRetSP
          , tmpGoodsSP.PaymentSP                                   AS PaymentSP
          , Object_PartionDateKind.AmountMonth                          AS AmountMonth
          , COALESCE(tmpPDChangePercentGoods.PartionDateDiscount,
                     tmpPDChangePercent.PartionDateDiscount)::TFloat    AS PartionDateDiscount

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
           LEFT JOIN ObjectLink AS ObjectLink_Goods_GoodsAnalog
                                ON ObjectLink_Goods_GoodsAnalog.ObjectId = Goods.Id
                               AND ObjectLink_Goods_GoodsAnalog.DescId = zc_ObjectLink_Goods_GoodsAnalog()
           LEFT JOIN Object AS Object_GoodsAnalog ON Object_GoodsAnalog.Id = ObjectLink_Goods_GoodsAnalog.ChildObjectId

           -- ��� ����/�� ����
           LEFT JOIN tmpPartionDateKind AS Object_PartionDateKind ON Object_PartionDateKind.Id = NULLIF (CashSessionSnapShot.PartionDateKindId, 0)
           LEFT JOIN tmpPDChangePercent ON tmpPDChangePercent.Id = NULLIF (CashSessionSnapShot.PartionDateKindId, 0)
           LEFT JOIN tmpPDChangePercentGoods ON tmpPDChangePercentGoods.Id = NULLIF (CashSessionSnapShot.PartionDateKindId, 0)
                                            AND tmpPDChangePercentGoods.GoodsId = CashSessionSnapShot.ObjectId

        WHERE
            CashSessionSnapShot.CashSessionId = inCashSessionId
        ORDER BY
            Goods.Id;

END;
$BODY$
  LANGUAGE PLPGSQL VOLATILE;
ALTER FUNCTION gpSelect_CashRemains_ver2 (TVarChar, TVarChar) OWNER TO postgres;

/*
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.   ������ �.�.   ��������� �.�.  �������� �.�.  ������ �.�.
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
-- SELECT * FROM gpSelect_CashRemains_ver2(inCashSessionId := '{0B05C610-B172-4F81-99B8-25BF5385ADD6}' ,  inSession := '3');
