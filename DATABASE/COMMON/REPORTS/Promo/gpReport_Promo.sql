
DROP FUNCTION IF EXISTS gpSelect_Report_Promo(
    TDateTime, --���� ������ �������
    TDateTime, --���� ��������� �������
    Integer,   --������������� 
    TVarChar   --������ ������������
);
DROP FUNCTION IF EXISTS gpSelect_Report_Promo(
    TDateTime, --���� ������ �������
    TDateTime, --���� ��������� �������
    Boolean,   --�������� ������ �����
    Boolean,   --�������� ������ �������
    Integer,   --������������� 
    TVarChar   --������ ������������
);

DROP FUNCTION IF EXISTS gpSelect_Report_Promo(
    TDateTime, --���� ������ �������
    TDateTime, --���� ��������� �������
    Boolean,   --�������� ������ �����
    Boolean,   --�������� ������ �������
    Boolean,   -- ������������ �� �����
    Integer,   --������������� 
    TVarChar   --������ ������������
);
CREATE OR REPLACE FUNCTION gpSelect_Report_Promo(
    IN inStartDate      TDateTime, --���� ������ �������
    IN inEndDate        TDateTime, --���� ��������� �������
    IN inIsPromo        Boolean,   --�������� ������ �����
    IN inIsTender       Boolean,   --�������� ������ �������
    IN inIsGoodsKind    Boolean,   --������������ �� �����
    IN inUnitId         Integer,   --������������� 
    IN inSession        TVarChar   --������ ������������
)
RETURNS TABLE(
     MovementId           Integer   --�� ��������� �����
    ,InvNumber            Integer   --� ��������� �����
    ,UnitName             TVarChar  --�����
    ,PersonalTradeName    TVarChar  --������������� ������������� ������������� ������
    ,PersonalName         TVarChar  --������������� ������������� �������������� ������	
    ,DateStartSale        TDateTime --���� �������� �� ��������� �����
    ,DeteFinalSale        TDateTime --���� �������� �� ��������� �����
    ,DateStartPromo       TDateTime --���� ���������� �����
    ,DateFinalPromo       TDateTime --���� ���������� �����
    ,MonthPromo           TDateTime --����� �����
    ,CheckDate            TDateTime --���� ������������
    ,RetailName           TBlob     --����, � ������� �������� �����
    ,AreaName             TBlob     --������
    ,GoodsName            TVarChar  --�������
    ,GoodsCode            Integer   --��� �������
    ,MeasureName          TVarChar  --������� ���������
    ,TradeMarkName        TVarChar  --�������� �����
    ,AmountPlanMin        TFloat    --����������� ����� ������ � ��������� ������, ��
    ,AmountPlanMinWeight  TFloat    --����������� ����� ������ � ��������� ������, ��
    ,AmountPlanMax        TFloat    --����������� ����� ������ � ��������� ������, ��
    ,AmountPlanMaxWeight  TFloat    --����������� ����� ������ � ��������� ������, ��
    ,AmountReal           TFloat    --����� ������ � ����������� ������, ��
    ,AmountRealWeight     TFloat    --����� ������ � ����������� ������, �� ���
    ,AmountOrder          TFloat    --���-�� ������ (����)
    ,AmountOrderWeight    TFloat    --���-�� ������ (����) ���
    ,AmountOut            TFloat    --���-�� ���������� (����)
    ,AmountOutWeight      TFloat    --���-�� ���������� (����) ���
    ,AmountIn             TFloat    --���-�� ������� (����)
    ,AmountInWeight       TFloat    --���-�� ������� (����) ���
    ,GoodsKindName        TVarChar  --��� ��������
    ,GoodsKindCompleteName  TVarChar  --��� �������� ( ����������)
    ,GoodsKindName_List   TVarChar  --��� ������ (���������)
    ,GoodsWeight          TFloat    --���
    ,Discount             TBlob     --������, %
    ,PriceWithOutVAT      TFloat    --����������� ��������� ���� ��� ����� ���, ���
    ,PriceWithVAT         TFloat    --����������� ��������� ���� � ������ ���, ���
    ,Price                TFloat    -- * ���� ������������ � ���, ���
    ,CostPromo            TFloat    -- * ��������� �������
    ,AdvertisingName      TBlob     -- * �������.���������
    ,OperDate             TDateTime -- * ������ �������� � ����
    ,PriceSale            TFloat    -- * ���� �� �����/������ ��� ����������
    ,Comment              TVarChar  --�����������
    ,ShowAll              Boolean   --���������� ��� ������
    ,isPromo              Boolean   --����� (��/���)
    ,Checked              Boolean   --����������� (��/���)
    )
AS
$BODY$
    DECLARE vbUserId Integer;
    DECLARE vbShowAll Boolean;
BEGIN
    -- �������� ���� ������������ �� ����� ���������
    -- PERFORM lpCheckRight (inSession, zc_Enum_Process_Select_MI_SheetWorkTime());
     vbUserId:= lpGetUserBySession (inSession);

    -- �������� ���������� �������� �� ����� ����������� ���� �������
    vbShowAll:= EXISTS (SELECT 1 FROM ObjectLink_UserRole_View WHERE UserId = vbUserId AND RoleId IN (112322, 296580, zc_Enum_Role_Admin())); -- ����� ��������� + �������� ��� (����������)
    
    -- ������� ��� ��������� ��� ������ (���������) �� GoodsListSale
    CREATE TEMP TABLE _tmpWord_Split_from (WordList TVarChar) ON COMMIT DROP;
    CREATE TEMP TABLE _tmpWord_Split_to (Ord Integer, Word TVarChar, WordList TVarChar) ON COMMIT DROP;

    INSERT INTO _tmpWord_Split_from (WordList) 
            SELECT DISTINCT ObjectString_GoodsKind.ValueData AS WordList
            FROM ObjectString AS ObjectString_GoodsKind
            WHERE ObjectString_GoodsKind.DescId = zc_ObjectString_GoodsListSale_GoodsKind()
              AND ObjectString_GoodsKind.ValueData <> '';
    
    PERFORM zfSelect_Word_Split (inSep:= ',', inUserId:= vbUserId);
    --


    -- ���������
    RETURN QUERY
     WITH tmpGoodsKind AS (SELECT _tmpWord_Split_to.WordList, Object.ValueData :: TVarChar AS GoodsKindName
                           FROM _tmpWord_Split_to 
                                LEFT JOIN Object ON Object.Id = _tmpWord_Split_to.Word :: Integer
                           GROUP BY _tmpWord_Split_to.WordList, Object.ValueData
                           )
        , tmpMovement AS (SELECT Movement_Promo.*
                               , MovementDate_StartSale.ValueData            AS StartSale          --���� ������ �������� �� ��������� ����
                               , MovementDate_EndSale.ValueData              AS EndSale            --���� ��������� �������� �� ��������� ����
                               , MovementLinkObject_Unit.ObjectId            AS UnitId
                               , COALESCE (MovementBoolean_Promo.ValueData, FALSE)   :: Boolean AS isPromo  -- ����� (��/���)
                          FROM Movement AS Movement_Promo
                             LEFT JOIN MovementLinkObject AS MovementLinkObject_Unit
                                                          ON MovementLinkObject_Unit.MovementId = Movement_Promo.Id
                                                         AND MovementLinkObject_Unit.DescId = zc_MovementLinkObject_Unit()
                                                          
                             LEFT JOIN MovementDate AS MovementDate_StartSale
                                                     ON MovementDate_StartSale.MovementId = Movement_Promo.Id
                                                    AND MovementDate_StartSale.DescId = zc_MovementDate_StartSale()
                             LEFT JOIN MovementDate AS MovementDate_EndSale
                                                     ON MovementDate_EndSale.MovementId = Movement_Promo.Id
                                                    AND MovementDate_EndSale.DescId = zc_MovementDate_EndSale()
                             LEFT JOIN MovementBoolean AS MovementBoolean_Promo
                                                       ON MovementBoolean_Promo.MovementId = Movement_Promo.Id
                                                      AND MovementBoolean_Promo.DescId = zc_MovementBoolean_Promo()

                          WHERE Movement_Promo.DescId = zc_Movement_Promo()
                         AND (MovementDate_StartSale.ValueData BETWEEN inStartDate AND inEndDate
                         OR
                               inStartDate BETWEEN MovementDate_StartSale.ValueData AND MovementDate_EndSale.ValueData
                              )
                         AND (MovementLinkObject_Unit.ObjectId = inUnitId OR inUnitId = 0)
                         AND Movement_Promo.StatusId = zc_Enum_Status_Complete()
                         AND (  (COALESCE (MovementBoolean_Promo.ValueData, FALSE) = TRUE AND inIsPromo = TRUE) 
                             OR (COALESCE (MovementBoolean_Promo.ValueData, FALSE) = FALSE AND inIsTender = TRUE)
                             OR (inIsPromo = FALSE AND inIsTender = FALSE)
                             )
                          )                   
        , tmpMovement_Promo AS ( SELECT     
                                Movement_Promo.Id                                                 --�������������
                              , Movement_Promo.InvNumber :: Integer         AS InvNumber          --����� ���������
                              , Movement_Promo.OperDate                                           --���� ���������
                              , Object_Unit.ValueData                       AS UnitName           --�������������
                              , MovementLinkObject_PersonalTrade.ObjectId   AS PersonalTradeId    --������������� ������������� ������������� ������
                              , Object_PersonalTrade.ValueData              AS PersonalTradeName  --������������� ������������� ������������� ������
                              , MovementLinkObject_Personal.ObjectId        AS PersonalId         --������������� ������������� �������������� ������	
                              , Object_Personal.ValueData                   AS PersonalName       --������������� ������������� �������������� ������
                              , MovementDate_StartPromo.ValueData           AS StartPromo         --���� ������ �����
                              , MovementDate_EndPromo.ValueData             AS EndPromo           --���� ��������� �����
                              , Movement_Promo.StartSale            AS StartSale          --���� ������ �������� �� ��������� ����
                              , Movement_Promo.EndSale              AS EndSale            --���� ��������� �������� �� ��������� ����
                              , MovementDate_EndReturn.ValueData            AS EndReturn          --���� ��������� ��������� �� ��������� ����
                              , MovementDate_Month.ValueData                AS MonthPromo         -- ����� �����
                              , MovementDate_CheckDate.ValueData            AS CheckDate          --���� ������������
                              , MovementFloat_CostPromo.ValueData           AS CostPromo          --��������� ������� � �����
                              , MovementString_Comment.ValueData            AS Comment            --����������
                              , COALESCE (Movement_Promo.isPromo, FALSE)   :: Boolean AS isPromo  -- ����� (��/���)
                              , COALESCE (MovementBoolean_Checked.ValueData, FALSE) :: Boolean AS Checked  -- ����������� (��/���)
      
                         FROM tmpMovement AS Movement_Promo 
                             LEFT JOIN MovementDate AS MovementDate_StartPromo
                                                     ON MovementDate_StartPromo.MovementId = Movement_Promo.Id
                                                    AND MovementDate_StartPromo.DescId = zc_MovementDate_StartPromo()
                             LEFT JOIN MovementDate AS MovementDate_EndPromo
                                                     ON MovementDate_EndPromo.MovementId =  Movement_Promo.Id
                                                    AND MovementDate_EndPromo.DescId = zc_MovementDate_EndPromo()
                                                    
                             
                             LEFT JOIN MovementDate AS MovementDate_EndReturn
                                                    ON MovementDate_EndReturn.MovementId = Movement_Promo.Id
                                                   AND MovementDate_EndReturn.DescId = zc_MovementDate_EndReturn()
                                                    
                             LEFT JOIN MovementDate AS MovementDate_Month
                                                    ON MovementDate_Month.MovementId = Movement_Promo.Id
                                                   AND MovementDate_Month.DescId = zc_MovementDate_Month()
                     
                             LEFT JOIN MovementDate AS MovementDate_CheckDate
                                                    ON MovementDate_CheckDate.MovementId = Movement_Promo.Id
                                                   AND MovementDate_CheckDate.DescId = zc_MovementDate_Check()
                                                   
                             LEFT JOIN MovementFloat AS MovementFloat_CostPromo
                                                     ON MovementFloat_CostPromo.MovementId = Movement_Promo.Id
                                                    AND MovementFloat_CostPromo.DescId = zc_MovementFloat_CostPromo()
                             
                             LEFT JOIN MovementString AS MovementString_Comment
                                                      ON MovementString_Comment.MovementId = Movement_Promo.Id
                                                     AND MovementString_Comment.DescId = zc_MovementString_Comment()
                     
                             LEFT JOIN MovementBoolean AS MovementBoolean_Checked
                                                       ON MovementBoolean_Checked.MovementId = Movement_Promo.Id
                                                      AND MovementBoolean_Checked.DescId = zc_MovementBoolean_Checked()
                     
                             LEFT JOIN Object AS Object_Unit ON Object_Unit.Id = Movement_Promo.UnitId
                     
                             LEFT JOIN MovementLinkObject AS MovementLinkObject_PersonalTrade
                                                          ON MovementLinkObject_PersonalTrade.MovementId = Movement_Promo.Id
                                                         AND MovementLinkObject_PersonalTrade.DescId = zc_MovementLinkObject_PersonalTrade()
                             LEFT JOIN Object AS Object_PersonalTrade 
                                              ON Object_PersonalTrade.Id = MovementLinkObject_PersonalTrade.ObjectId
                     
                             LEFT JOIN MovementLinkObject AS MovementLinkObject_Personal
                                                          ON MovementLinkObject_Personal.MovementId = Movement_Promo.Id
                                                         AND MovementLinkObject_Personal.DescId = zc_MovementLinkObject_Personal()
                             LEFT JOIN Object AS Object_Personal
                                              ON Object_Personal.Id = MovementLinkObject_Personal.ObjectId
                        )

        , tmpMI AS (SELECT *
                    FROM MovementItem
                    WHERE MovementItem.MovementId IN (SELECT DISTINCT tmpMovement_Promo.Id FROM tmpMovement_Promo)
                      AND MovementItem.DescId = zc_MI_Master()
                      AND MovementItem.isErased = FALSE
                    )   
                    
                    
        , tmpMovementItemFloat AS (SELECT *
                                   FROM MovementItemFloat
                                   WHERE MovementItemFloat.MovementItemId IN (SELECT DISTINCT tmpMI.Id FROM tmpMI)
                                     AND MovementItemFloat.DescId IN (zc_MIFloat_Price()
                                                                    , zc_MIFloat_PriceWithOutVAT()
                                                                    , zc_MIFloat_PriceWithVAT()
                                                                    , zc_MIFloat_PriceSale()
                                                                    , zc_MIFloat_AmountOrder()
                                                                    , zc_MIFloat_AmountOut()
                                                                    , zc_MIFloat_AmountIn()
                                                                    , zc_MIFloat_AmountReal()
                                                                    , zc_MIFloat_AmountPlanMin()
                                                                    , zc_MIFloat_AmountPlanMax()
                                                                      )
                                  )
        
        , tmpMovementItemLinkObject AS (SELECT *
                                        FROM MovementItemLinkObject
                                        WHERE MovementItemLinkObject.MovementItemId IN (SELECT DISTINCT tmpMI.Id FROM tmpMI)
                                          AND MovementItemLinkObject.DescId IN (zc_MILinkObject_GoodsKind()
                                                                              , zc_MILinkObject_GoodsKindComplete()
                                                                                )
                                  )
        
        , tmpMI_PromoGoods AS (SELECT
        MovementItem.MovementId                AS MovementId          --�� ��������� <�����>
      , MovementItem.ObjectId                  AS GoodsId             --�� ������� <�����>
      , Object_Goods.ObjectCode::Integer       AS GoodsCode           --��� �������  <�����>
      , Object_Goods.ValueData                 AS GoodsName           --������������ ������� <�����>
      , Object_Measure.Id               AS MeasureId             --������� ���������
      , Object_Measure.ValueData               AS Measure             --������� ���������
      , Object_TradeMark.ValueData             AS TradeMark           --�������� �����
      , Object_GoodsKind.ValueData             AS GoodsKindName       --������������ ������� <��� ������>
      , CASE WHEN ObjectLink_Goods_Measure.ChildObjectId = zc_Measure_Sh() THEN ObjectFloat_Goods_Weight.ValueData ELSE 1 END::TFloat as GoodsWeight -- ���
      , STRING_AGG (DISTINCT Object_GoodsKindComplete.ValueData, '; ') :: TVarChar  AS GoodsKindCompleteName       --������������ ������� <��� ������ (����������)>

      
      , MIFloat_Price.ValueData                AS Price               --���� � ������
      , MIFloat_PriceWithOutVAT.ValueData      AS PriceWithOutVAT     --���� �������� ��� ����� ���, � ������ ������, ���
      , MIFloat_PriceWithVAT.ValueData         AS PriceWithVAT        --���� �������� � ������ ���, � ������ ������, ���
      , MIFloat_PriceSale.ValueData            AS PriceSale           --���� �� �����

      , SUM (MovementItem.Amount)                    AS Amount              --% ������ �� �����
      , SUM (MIFloat_AmountReal.ValueData)           AS AmountReal          --����� ������ � ����������� ������, ��
      , SUM (MIFloat_AmountReal.ValueData
          * CASE WHEN ObjectLink_Goods_Measure.ChildObjectId = zc_Measure_Sh() THEN ObjectFloat_Goods_Weight.ValueData ELSE 1 END) :: TFloat AS AmountRealWeight    --����� ������ � ����������� ������, �� ���

      , SUM (MIFloat_AmountPlanMin.ValueData)        AS AmountPlanMin       --������� ������������ ������ ������ �� ��������� ������ (� ��)
      , SUM (MIFloat_AmountPlanMin.ValueData
          * CASE WHEN ObjectLink_Goods_Measure.ChildObjectId = zc_Measure_Sh() THEN ObjectFloat_Goods_Weight.ValueData ELSE 1 END) :: TFloat AS AmountPlanMinWeight --������� ������������ ������ ������ �� ��������� ������ (� ��) ���
      , SUM (MIFloat_AmountPlanMax.ValueData)        AS AmountPlanMax       --�������� ������������ ������ ������ �� ��������� ������ (� ��)
      , SUM (MIFloat_AmountPlanMax.ValueData
          * CASE WHEN ObjectLink_Goods_Measure.ChildObjectId = zc_Measure_Sh() THEN ObjectFloat_Goods_Weight.ValueData ELSE 1 END) :: TFloat AS AmountPlanMaxWeight --�������� ������������ ������ ������ �� ��������� ������ (� ��) ���
      , SUM (MIFloat_AmountOrder.ValueData)          AS AmountOrder         --���-�� ������ (����)
      , SUM (MIFloat_AmountOrder.ValueData
          * CASE WHEN ObjectLink_Goods_Measure.ChildObjectId = zc_Measure_Sh() THEN ObjectFloat_Goods_Weight.ValueData ELSE 1 END) :: TFloat AS AmountOrderWeight   --���-�� ������ (����) ���
      , SUM (MIFloat_AmountOut.ValueData)            AS AmountOut           --���-�� ���������� (����)
      , SUM (MIFloat_AmountOut.ValueData
          * CASE WHEN ObjectLink_Goods_Measure.ChildObjectId = zc_Measure_Sh() THEN ObjectFloat_Goods_Weight.ValueData ELSE 1 END) :: TFloat AS AmountOutWeight     --���-�� ���������� (����) ���
      , SUM (MIFloat_AmountIn.ValueData)             AS AmountIn            --���-�� ������� (����)
      , SUM (MIFloat_AmountIn.ValueData
          * CASE WHEN ObjectLink_Goods_Measure.ChildObjectId = zc_Measure_Sh() THEN ObjectFloat_Goods_Weight.ValueData ELSE 1 END) :: TFloat AS AmountInWeight      --���-�� ������� (����) ���
     
    FROM tmpMI AS MovementItem
        LEFT JOIN tmpMovementItemFloat AS MIFloat_Price
                                    ON MIFloat_Price.MovementItemId = MovementItem.Id
                                   AND MIFloat_Price.DescId = zc_MIFloat_Price()
        LEFT JOIN tmpMovementItemFloat AS MIFloat_PriceWithOutVAT
                                    ON MIFloat_PriceWithOutVAT.MovementItemId = MovementItem.Id
                                   AND MIFloat_PriceWithOutVAT.DescId = zc_MIFloat_PriceWithOutVAT()
        LEFT JOIN tmpMovementItemFloat AS MIFloat_PriceWithVAT
                                    ON MIFloat_PriceWithVAT.MovementItemId = MovementItem.Id
                                   AND MIFloat_PriceWithVAT.DescId = zc_MIFloat_PriceWithVAT()
        LEFT JOIN tmpMovementItemFloat AS MIFloat_PriceSale
                                    ON MIFloat_PriceSale.MovementItemId = MovementItem.Id
                                   AND MIFloat_PriceSale.DescId = zc_MIFloat_PriceSale()
        LEFT JOIN tmpMovementItemFloat AS MIFloat_AmountOrder
                                    ON MIFloat_AmountOrder.MovementItemId = MovementItem.Id
                                   AND MIFloat_AmountOrder.DescId = zc_MIFloat_AmountOrder()
        LEFT JOIN tmpMovementItemFloat AS MIFloat_AmountOut
                                    ON MIFloat_AmountOut.MovementItemId = MovementItem.Id
                                   AND MIFloat_AmountOut.DescId = zc_MIFloat_AmountOut()
        LEFT JOIN tmpMovementItemFloat AS MIFloat_AmountIn
                                    ON MIFloat_AmountIn.MovementItemId = MovementItem.Id
                                   AND MIFloat_AmountIn.DescId = zc_MIFloat_AmountIn()
        LEFT JOIN tmpMovementItemFloat AS MIFloat_AmountReal
                                    ON MIFloat_AmountReal.MovementItemId = MovementItem.Id
                                   AND MIFloat_AmountReal.DescId = zc_MIFloat_AmountReal()
        LEFT JOIN tmpMovementItemFloat AS MIFloat_AmountPlanMin
                                    ON MIFloat_AmountPlanMin.MovementItemId = MovementItem.Id
                                   AND MIFloat_AmountPlanMin.DescId = zc_MIFloat_AmountPlanMin()
        LEFT JOIN tmpMovementItemFloat AS MIFloat_AmountPlanMax
                                    ON MIFloat_AmountPlanMax.MovementItemId = MovementItem.Id
                                   AND MIFloat_AmountPlanMax.DescId = zc_MIFloat_AmountPlanMax()

        LEFT JOIN Object AS Object_Goods ON Object_Goods.Id = MovementItem.ObjectId

        LEFT JOIN tmpMovementItemLinkObject AS MILinkObject_GoodsKind 
                                         ON MILinkObject_GoodsKind.MovementItemId = MovementItem.Id
                                        AND MILinkObject_GoodsKind.DescId = zc_MILinkObject_GoodsKind()
        LEFT JOIN Object AS Object_GoodsKind ON Object_GoodsKind.Id = MILinkObject_GoodsKind.ObjectId

        LEFT JOIN tmpMovementItemLinkObject AS MILinkObject_GoodsKindComplete
                                         ON MILinkObject_GoodsKindComplete.MovementItemId = MovementItem.Id
                                        AND MILinkObject_GoodsKindComplete.DescId = zc_MILinkObject_GoodsKindComplete()
        LEFT JOIN Object AS Object_GoodsKindComplete ON Object_GoodsKindComplete.Id = MILinkObject_GoodsKindComplete.ObjectId

        LEFT JOIN ObjectLink AS ObjectLink_Goods_Measure
                             ON ObjectLink_Goods_Measure.ObjectId = MovementItem.ObjectId
                            AND ObjectLink_Goods_Measure.DescId = zc_ObjectLink_Goods_Measure()
        LEFT JOIN Object AS Object_Measure ON Object_Measure.Id = ObjectLink_Goods_Measure.ChildObjectId

        LEFT JOIN ObjectLink AS ObjectLink_Goods_TradeMark
                             ON ObjectLink_Goods_TradeMark.ObjectId = MovementItem.ObjectId
                            AND ObjectLink_Goods_TradeMark.DescId = zc_ObjectLink_Goods_TradeMark()
        LEFT JOIN Object AS Object_TradeMark ON Object_TradeMark.Id = ObjectLink_Goods_TradeMark.ChildObjectId

        LEFT OUTER JOIN ObjectFloat AS ObjectFloat_Goods_Weight
                                    ON ObjectFloat_Goods_Weight.ObjectId = MovementItem.ObjectId
                                   AND ObjectFloat_Goods_Weight.DescId = zc_ObjectFloat_Goods_Weight()

                       GROUP BY MovementItem.MovementId
                              , MovementItem.ObjectId
                              , Object_Goods.ObjectCode
                              , Object_Goods.ValueData
                              , Object_Measure.ValueData
                              , Object_Measure.Id
                              , Object_TradeMark.ValueData
                              , Object_GoodsKind.ValueData
                              , CASE WHEN ObjectLink_Goods_Measure.ChildObjectId = zc_Measure_Sh() THEN ObjectFloat_Goods_Weight.ValueData ELSE 1 END
                              , CASE WHEN inIsGoodsKind = FALSE THEN MovementItem.Id ELSE 0 END   
                              , MIFloat_Price.ValueData
                              , MIFloat_PriceWithOutVAT.ValueData
                              , MIFloat_PriceWithVAT.ValueData
                              , MIFloat_PriceSale.ValueData                
                     )

        SELECT
            Movement_Promo.Id                --�� ��������� �����
          , Movement_Promo.InvNumber          --� ��������� �����
          , Movement_Promo.UnitName           --�����
          , Movement_Promo.PersonalTradeName  --������������� ������������� ������������� ������
          , Movement_Promo.PersonalName       --������������� ������������� �������������� ������	
          , Movement_Promo.StartSale          --���� ������ �������� �� ��������� ����
          , Movement_Promo.EndSale            --���� ��������� �������� �� ��������� ����
          , Movement_Promo.StartPromo         --���� ������ �����
          , Movement_Promo.EndPromo           --���� ��������� �����
          , Movement_Promo.MonthPromo         --����� �����
          , Movement_Promo.CheckDate          --���� ������������
          -- , (SELECT STRING_AGG( DISTINCT Movement_PromoPartner.Retail_Name,'; ')
             -- FROM (SELECT DISTINCT Movement_PromoPartner_View.Retail_Name
                   -- FROM Movement_PromoPartner_View
                   -- WHERE Movement_PromoPartner_View.ParentId = Movement_Promo.Id
                     -- AND COALESCE(Movement_PromoPartner_View.Retail_Name,'')<>''
                     -- AND Movement_PromoPartner_View.isErased = FALSE
                  -- ) AS Movement_PromoPartner
            -- )::TBlob AS RetailName
            --------------------------------------
          , COALESCE ((SELECT STRING_AGG (DISTINCT COALESCE (MovementString_Retail.ValueData, Object_Retail.ValueData),'; ')
                       FROM
                          Movement AS Movement_PromoPartner
                          /*INNER JOIN MovementLinkObject AS MLO_Partner
                                                        ON MLO_Partner.MovementId = Movement_PromoPartner.ID
                                                       AND MLO_Partner.DescId     = zc_MovementLinkObject_Partner()
                          LEFT JOIN Object AS Object_Retail ON Object_Retail.Id = MLO_Partner.ObjectId*/
                          INNER JOIN MovementItem AS MI_PromoPartner
                                                  ON MI_PromoPartner.MovementId = Movement_PromoPartner.ID
                                                 AND MI_PromoPartner.DescId     = zc_MI_Master()
                                                 AND MI_PromoPartner.IsErased   = FALSE
                          LEFT JOIN ObjectLink AS ObjectLink_Partner_Juridical
                                               ON ObjectLink_Partner_Juridical.ObjectId = MI_PromoPartner.ObjectId
                                              AND ObjectLink_Partner_Juridical.DescId   = zc_ObjectLink_Partner_Juridical()
                          LEFT JOIN ObjectLink AS ObjectLink_Juridical_Retail
                                               ON ObjectLink_Juridical_Retail.ObjectId = COALESCE (ObjectLink_Partner_Juridical.ChildObjectId, MI_PromoPartner.ObjectId)
                                              AND ObjectLink_Juridical_Retail.DescId   = zc_ObjectLink_Juridical_Retail()
                          LEFT JOIN Object AS Object_Retail ON Object_Retail.Id = ObjectLink_Juridical_Retail.ChildObjectId
                          
                          LEFT OUTER JOIN MovementString AS MovementString_Retail
                                                         ON MovementString_Retail.MovementId = Movement_PromoPartner.Id
                                                        AND MovementString_Retail.DescId = zc_MovementString_Retail()
                                                        AND MovementString_Retail.ValueData <> ''
                                      
                       WHERE Movement_PromoPartner.ParentId = Movement_Promo.Id
                         AND Movement_PromoPartner.DescId   = zc_Movement_PromoPartner()
                         AND Movement_PromoPartner.StatusId <> zc_Enum_Status_Erased()
                      )
            , (SELECT STRING_AGG (DISTINCT Object.ValueData,'; ')
               FROM
                  Movement AS Movement_PromoPartner
                  INNER JOIN MovementLinkObject AS MLO_Partner
                                                ON MLO_Partner.MovementId = Movement_PromoPartner.ID
                                               AND MLO_Partner.DescId     = zc_MovementLinkObject_Partner()
                  INNER JOIN Object ON Object.Id = MLO_Partner.ObjectId
               WHERE Movement_PromoPartner.ParentId = Movement_Promo.Id
                 AND Movement_PromoPartner.DescId   = zc_Movement_PromoPartner()
                 AND Movement_PromoPartner.StatusId <> zc_Enum_Status_Erased()
                ))::TBlob AS RetailName
            --------------------------------------
          , (SELECT STRING_AGG (DISTINCT Object_Area.ValueData,'; ')
             FROM
                Movement AS Movement_PromoPartner
                INNER JOIN MovementItem AS MI_PromoPartner
                                        ON MI_PromoPartner.MovementId = Movement_PromoPartner.ID
                                       AND MI_PromoPartner.DescId     = zc_MI_Master()
                                       AND MI_PromoPartner.IsErased   = FALSE
                INNER JOIN ObjectLink AS ObjectLink_Partner_Area
                                      ON ObjectLink_Partner_Area.ObjectId = MI_PromoPartner.ObjectId
                                     AND ObjectLink_Partner_Area.DescId   = zc_ObjectLink_Partner_Area()
                INNER JOIN Object AS Object_Area ON Object_Area.Id = ObjectLink_Partner_Area.ChildObjectId
                
             WHERE Movement_PromoPartner.ParentId = Movement_Promo.Id
               AND Movement_PromoPartner.DescId   = zc_Movement_PromoPartner()
               AND Movement_PromoPartner.StatusId <> zc_Enum_Status_Erased()
            )::TBlob AS AreaName
          , MI_PromoGoods.GoodsName
          , MI_PromoGoods.GoodsCode
          , MI_PromoGoods.Measure
          , MI_PromoGoods.TradeMark
          , MI_PromoGoods.AmountPlanMin      ::TFloat --������� ������������ ������ ������ �� ��������� ������ (� ��)
          , MI_PromoGoods.AmountPlanMinWeight::TFloat --������� ������������ ������ ������ �� ��������� ������ (� ��) ���
          , MI_PromoGoods.AmountPlanMax      ::TFloat --�������� ������������ ������ ������ �� ��������� ������ (� ��)
          , MI_PromoGoods.AmountPlanMaxWeight::TFloat --�������� ������������ ������ ������ �� ��������� ������ (� ��) ���
          , MI_PromoGoods.AmountReal         ::TFloat --����� ������ � ����������� ������, ��
          , MI_PromoGoods.AmountRealWeight   ::TFloat --����� ������ � ����������� ������, �� ���
          , MI_PromoGoods.AmountOrder        ::TFloat --���-�� ������ (����)
          , MI_PromoGoods.AmountOrderWeight  ::TFloat --���-�� ������ (����) ���
          , MI_PromoGoods.AmountOut          ::TFloat --���-�� ���������� (����)
          , MI_PromoGoods.AmountOutWeight    ::TFloat --���-�� ���������� (����) ���
          , MI_PromoGoods.AmountIn           ::TFloat --���-�� ������� (����)
          , MI_PromoGoods.AmountInWeight     ::TFloat --���-�� ������� (����) ���
          , MI_PromoGoods.GoodsKindName       --������������ ������� <��� ������>
         -- , MI_PromoGoods.GoodsKindCompleteName -- --������������ ������� <��� ������ (����������)>
          
          , CASE WHEN inIsGoodsKind = FALSE THEN MI_PromoGoods.GoodsKindCompleteName
                 ELSE (SELECT STRING_AGG (DISTINCT Object_GoodsKindComplete.ValueData,'; ') AS GoodsKindCompleteName
                       FROM MovementItem AS MI_Promo
                            LEFT JOIN MovementItemLinkObject AS MILinkObject_GoodsKindComplete
                                                             ON MILinkObject_GoodsKindComplete.MovementItemId = MI_Promo.Id
                                                            AND MILinkObject_GoodsKindComplete.DescId = zc_MILinkObject_GoodsKindComplete()
                            LEFT JOIN Object AS Object_GoodsKindComplete ON Object_GoodsKindComplete.Id = MILinkObject_GoodsKindComplete.ObjectId
          
                       WHERE MI_Promo.MovementId = Movement_Promo.Id
                         AND MI_Promo.DescId     = zc_MI_Master()
                         AND MI_Promo.IsErased   = FALSE
                      )
            END  ::TVarChar AS GoodsKindCompleteName

          , (SELECT STRING_AGG (DISTINCT tmpGoodsKind.GoodsKindName,'; ')
             FROM Movement AS Movement_PromoPartner
                INNER JOIN MovementItem AS MI_PromoPartner
                                        ON MI_PromoPartner.MovementId = Movement_PromoPartner.ID
                                       AND MI_PromoPartner.DescId     = zc_MI_Master()
                                       AND MI_PromoPartner.IsErased   = FALSE
                                       
                LEFT JOIN ObjectLink AS ObjectLink_GoodsListSale_Partner
                                     ON ObjectLink_GoodsListSale_Partner.ChildObjectId = MI_PromoPartner.ObjectId
                                    AND ObjectLink_GoodsListSale_Partner.DescId = zc_ObjectLink_GoodsListSale_Partner()
                                     
                INNER JOIN ObjectLink AS ObjectLink_GoodsListSale_Goods
                                     ON ObjectLink_GoodsListSale_Goods.ObjectId = ObjectLink_GoodsListSale_Partner.ObjectId
                                    AND ObjectLink_GoodsListSale_Goods.DescId = zc_ObjectLink_GoodsListSale_Goods()
                                    AND ObjectLink_GoodsListSale_Goods.ChildObjectId = MI_PromoGoods.GoodsId 
                INNER JOIN ObjectString AS ObjectString_GoodsKind
                                        ON ObjectString_GoodsKind.ObjectId = ObjectLink_GoodsListSale_Partner.ObjectId
                                       AND ObjectString_GoodsKind.DescId = zc_ObjectString_GoodsListSale_GoodsKind()
                                       
                LEFT JOIN tmpGoodsKind ON tmpGoodsKind.WordList = ObjectString_GoodsKind.ValueData

             WHERE Movement_PromoPartner.ParentId = Movement_Promo.Id
               AND Movement_PromoPartner.DescId   = zc_Movement_PromoPartner()
               AND Movement_PromoPartner.StatusId <> zc_Enum_Status_Erased()
            )::TVarChar AS GoodsKindName_List
          
          
          , CASE WHEN MI_PromoGoods.MeasureId = zc_Measure_Sh() THEN MI_PromoGoods.GoodsWeight ELSE NULL END :: TFloat AS GoodsWeight
          
          , (REPLACE (TO_CHAR (MI_PromoGoods.Amount,'FM99990D99')||' ','. ','')||'  '||chr(13)||
              (SELECT STRING_AGG (MovementItem_PromoCondition.ConditionPromoName||': '||REPLACE (TO_CHAR (MovementItem_PromoCondition.Amount,'FM999990D09')||' ','.0 ',''), chr(13)) 
               FROM MovementItem_PromoCondition_View AS MovementItem_PromoCondition 
               WHERE MovementItem_PromoCondition.MovementId = Movement_Promo.Id
                 AND MovementItem_PromoCondition.IsErased   = FALSE))  :: TBlob   AS Discount
                 
          , MI_PromoGoods.PriceWithOutVAT                                         AS PriceWithOutVAT
          , MI_PromoGoods.PriceWithVAT                                            AS PriceWithVAT
          , CASE WHEN vbShowAll THEN MI_PromoGoods.Price END         :: TFloat    AS Price
          , CASE WHEN vbShowAll THEN Movement_Promo.CostPromo END    :: TFloat    AS CostPromo
          
          , CASE WHEN vbShowAll THEN 
                (SELECT STRING_AGG (Movement_PromoAdvertising.AdvertisingName,'; ')
                 FROM (SELECT DISTINCT Movement_PromoAdvertising_View.AdvertisingName
                       FROM Movement_PromoAdvertising_View
                       WHERE Movement_PromoAdvertising_View.ParentId = Movement_Promo.Id
                         AND COALESCE (Movement_PromoAdvertising_View.AdvertisingName,'') <> ''
                         AND Movement_PromoAdvertising_View.isErASed = FALSE
                      ) AS Movement_PromoAdvertising
                ) END                                                :: TBlob     AS AdvertisingName
                
          , CASE WHEN vbShowAll THEN Movement_Promo.OperDate END     :: TDateTime AS OperDate
          , CASE WHEN vbShowAll THEN MI_PromoGoods.PriceSale END     :: TFloat    AS PriceSale
          , Movement_Promo.Comment                                                AS Comment
          , vbShowAll                                                             AS ShowAll
          , Movement_Promo.isPromo                                                AS isPromo
          , Movement_Promo.Checked                                                AS Checked
        FROM
            tmpMovement_Promo AS Movement_Promo
            LEFT OUTER JOIN tmpMI_PromoGoods AS MI_PromoGoods
                                                         ON MI_PromoGoods.MovementId = Movement_Promo.Id

               ;

END;
$BODY$
  LANGUAGE PLPGSQL VOLATILE;
--ALTER FUNCTION gpSelect_Report_Promo (TDateTime,TDateTime,Integer,TVarChar) OWNER TO postgres;

/*
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.    ��������� �.�.
 07.11.17         *
 25.07.17         *
 01.12.15                                                          *
*/

-- ����
-- select * from gpSelect_Report_Promo(inStartDate := ('04.04.2019')::TDateTime , inEndDate := ('01.05.2019')::TDateTime , inIsPromo := 'False' , inIsTender := 'False' ,inIsGoodsKind := 'false', inUnitId := 0 ,  inSession := '5'::TVarchar)
--where invnumber = 6862