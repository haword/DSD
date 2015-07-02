-- Function: gpSelect_MI_OrderInternalBasis()

DROP FUNCTION IF EXISTS gpSelect_MI_OrderInternalBasis (Integer, Boolean, Boolean, TVarChar);

CREATE OR REPLACE FUNCTION gpSelect_MI_OrderInternalBasis(
    IN inMovementId  Integer      , -- ���� ���������
    IN inShowAll     Boolean      , --
    IN inIsErased    Boolean      , --
    IN inSession     TVarChar       -- ������ ������������
)
RETURNS SETOF REFCURSOR
AS
$BODY$
   DECLARE vbUserId Integer;

   DECLARE Cursor1 refcursor;
   DECLARE Cursor2 refcursor;

   DECLARE vbOperDate TDateTime;
   DECLARE vbDayCount Integer;
BEGIN
     -- �������� ���� ������������ �� ����� ���������
     -- vbUserId:= lpCheckRight (inSession, zc_Enum_Process_Select_MI_OrderInternal());
     vbUserId:= lpGetUserBySession (inSession);


     -- ������������
     SELECT Movement.OperDate
          , 1 + EXTRACT (DAY FROM (MovementDate_OperDateEnd.ValueData - MovementDate_OperDateStart.ValueData))
            INTO vbOperDate, vbDayCount
     FROM Movement
          LEFT JOIN MovementDate AS MovementDate_OperDateStart
                                 ON MovementDate_OperDateStart.MovementId =  Movement.Id
                                AND MovementDate_OperDateStart.DescId = zc_MovementDate_OperDateStart()
          LEFT JOIN MovementDate AS MovementDate_OperDateEnd
                                 ON MovementDate_OperDateEnd.MovementId =  Movement.Id
                                AND MovementDate_OperDateEnd.DescId = zc_MovementDate_OperDateEnd()
     WHERE Movement.Id = inMovementId;


     -- 
     CREATE TEMP TABLE _tmpMI_master (MovementItemId Integer, GoodsId Integer, GoodsKindId Integer
                                    , Amount TFloat, AmountSecond TFloat, AmountRemains TFloat, AmountPartner TFloat
                                    , AmountForecast TFloat
                                    , isErased Boolean) ON COMMIT DROP;
     INSERT INTO _tmpMI_master (MovementItemId, GoodsId, GoodsKindId
                              , Amount, AmountSecond, AmountRemains, AmountPartner
                              , AmountForecast
                              , isErased)
                              SELECT MovementItem.Id AS MovementItemId
                                   , MovementItem.ObjectId AS GoodsId
                                   , COALESCE (MILinkObject_GoodsKind.ObjectId, 0) AS GoodsKindId

                                   , MovementItem.Amount                                   AS Amount
                                   , COALESCE (MIFloat_AmountSecond.ValueData, 0)          AS AmountSecond

                                   , COALESCE (MIFloat_AmountRemains.ValueData, 0)         AS AmountRemains
                                   , COALESCE (MIFloat_AmountPartner.ValueData, 0)         AS AmountPartner
                                   , COALESCE (MIFloat_AmountForecast.ValueData, 0)        AS AmountForecast

                                   , MovementItem.isErased                                 AS isErased

                              FROM (SELECT FALSE AS isErased UNION ALL SELECT inIsErased AS isErased WHERE inIsErased = TRUE) AS tmpIsErased
                                   INNER JOIN MovementItem ON MovementItem.MovementId = inMovementId
                                                          AND MovementItem.DescId     = zc_MI_Master()
                                                          AND MovementItem.isErased   = tmpIsErased.isErased
                                   LEFT JOIN MovementItemFloat AS MIFloat_AmountSecond
                                                               ON MIFloat_AmountSecond.MovementItemId = MovementItem.Id
                                                              AND MIFloat_AmountSecond.DescId = zc_MIFloat_AmountSecond()

                                   LEFT JOIN MovementItemFloat AS MIFloat_AmountRemains
                                                               ON MIFloat_AmountRemains.MovementItemId = MovementItem.Id
                                                              AND MIFloat_AmountRemains.DescId = zc_MIFloat_AmountRemains()
                                   LEFT JOIN MovementItemFloat AS MIFloat_AmountPartner
                                                               ON MIFloat_AmountPartner.MovementItemId = MovementItem.Id
                                                              AND MIFloat_AmountPartner.DescId = zc_MIFloat_AmountPartner()
                                   LEFT JOIN MovementItemFloat AS MIFloat_AmountForecast
                                                               ON MIFloat_AmountForecast.MovementItemId = MovementItem.Id
                                                              AND MIFloat_AmountForecast.DescId = zc_MIFloat_AmountForecast()

                                   LEFT JOIN MovementItemLinkObject AS MILinkObject_GoodsKind
                                                                    ON MILinkObject_GoodsKind.MovementItemId = MovementItem.Id
                                                                   AND MILinkObject_GoodsKind.DescId = zc_MILinkObject_GoodsKind()
                             ;

       --
       OPEN Cursor1 FOR
       SELECT
             tmpMI.MovementItemId :: Integer     AS Id
           , Object_Goods.Id                     AS GoodsId
           , Object_Goods.ObjectCode             AS GoodsCode
           , Object_Goods.ValueData              AS GoodsName
           , ObjectString_Goods_GoodsGroupFull.ValueData AS GoodsGroupNameFull

           , tmpMI.Amount           :: TFloat AS Amount           -- ����� �� �����
           , tmpMI.AmountSecond     :: TFloat AS AmountSecond     -- ������� �� �����

           , CASE WHEN tmpMI.AmountRemains < tmpMI.AmountPartner THEN tmpMI.AmountPartner - tmpMI.AmountRemains ELSE 0 END :: TFloat AS Amount_calc  -- ��������� �����

           , tmpMI.AmountRemains :: TFloat AS AmountRemains -- ���. �������.
           , tmpMI.AmountPartner :: TFloat AS AmountPartner -- ������ ������������ �� ������ �� ������������

           , CASE WHEN ABS (tmpMI.AmountForecast) < 1 THEN tmpMI.AmountForecast ELSE CAST (tmpMI.AmountForecast AS NUMERIC (16, 1)) END :: TFloat AS AmountForecast -- ������� �� ����. ������� �� ������������
           , CAST (CASE WHEN vbDayCount <> 0 THEN tmpMI.AmountForecast / vbDayCount ELSE 0 END AS NUMERIC (16, 1))                      :: TFloat AS CountForecast  -- ���� 1� (�� ��.)
           , CAST (CASE WHEN CASE WHEN vbDayCount <> 0 THEN tmpMI.AmountForecast / vbDayCount ELSE 0 END > 0
                             THEN tmpMI.AmountRemains / CASE WHEN vbDayCount <> 0 THEN tmpMI.AmountForecast / vbDayCount ELSE 0 END
                         ELSE 0
                   END
             AS NUMERIC (16, 1)) :: TFloat AS DayCountForecast -- ���. � ���� (�� ��.)

           , Object_GoodsKind.Id                 AS GoodsKindId
           , Object_GoodsKind.ValueData          AS GoodsKindName
           , Object_Measure.ValueData            AS MeasureName

           , CASE WHEN tmpMI.AmountRemains <= 0
                       THEN 1118719 -- clRed
                  ELSE 0 -- clBlack
             END :: Integer AS Color_remains
           , 14862279   :: Integer AS ColorB_DayCountForecast -- $00E2C7C7
           , 11987626   :: Integer AS ColorB_AmountPartner    -- $00B6EAAA
           , 8978431    :: Integer AS ColorB_AmountPrognoz    -- $008FF8F2 9435378

           , tmpMI.isErased

       FROM _tmpMI_master AS tmpMI

            LEFT JOIN Object AS Object_Goods ON Object_Goods.Id = tmpMI.GoodsId
            LEFT JOIN Object AS Object_GoodsKind ON Object_GoodsKind.Id = tmpMI.GoodsKindId
            LEFT JOIN ObjectLink AS ObjectLink_Goods_Measure
                                 ON ObjectLink_Goods_Measure.ObjectId = tmpMI.GoodsId
                                AND ObjectLink_Goods_Measure.DescId = zc_ObjectLink_Goods_Measure()
            LEFT JOIN Object AS Object_Measure ON Object_Measure.Id = ObjectLink_Goods_Measure.ChildObjectId

            LEFT JOIN ObjectString AS ObjectString_Goods_GoodsGroupFull
                                   ON ObjectString_Goods_GoodsGroupFull.ObjectId = tmpMI.GoodsId
                                  AND ObjectString_Goods_GoodsGroupFull.DescId = zc_ObjectString_Goods_GroupNameFull()
          ;
       RETURN NEXT Cursor1;


END;
$BODY$
  LANGUAGE PLPGSQL VOLATILE;
ALTER FUNCTION gpSelect_MI_OrderInternalBasis (Integer, Boolean, Boolean, TVarChar) OWNER TO postgres;

/*
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.   ������ �.�.
 27.06.15                                        *
*/

-- ����
-- SELECT * FROM gpSelect_MI_OrderInternalBasis (inMovementId:= 1828419, inShowAll:= TRUE, inIsErased:= FALSE, inSession:= '9818')
-- SELECT * FROM gpSelect_MI_OrderInternalBasis (inMovementId:= 1828419, inShowAll:= FALSE, inIsErased:= FALSE, inSession:= '2')
