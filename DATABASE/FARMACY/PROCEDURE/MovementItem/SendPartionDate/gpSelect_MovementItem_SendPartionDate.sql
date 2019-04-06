-- Function: gpSelect_MovementItem_SendPartionDate()

DROP FUNCTION IF EXISTS gpSelect_MovementItem_SendPartionDate (Integer, Boolean, Boolean, TVarChar);

CREATE OR REPLACE FUNCTION gpSelect_MovementItem_SendPartionDate(
    IN inMovementId  Integer      , -- ���� ���������
    IN inShowAll     Boolean      , --
    IN inIsErased    Boolean      , --
    IN inSession     TVarChar       -- ������ ������������
)
RETURNS SETOF refcursor AS
$BODY$
    DECLARE vbUserId   Integer;
    DECLARE vbUnitId   Integer;
    DECLARE vbOperDate TDateTime;
    DECLARE vbDate180  TDateTime;
    DECLARE vbDate30   TDateTime;

    DECLARE Cursor1 refcursor;
    DECLARE Cursor2 refcursor;
BEGIN
    -- �������� ���� ������������ �� ����� ���������
    -- vbUserId := PERFORM lpCheckRight (inSession, zc_Enum_Process_Select_MovementItem_SendPartionDate());
    vbUserId:= lpGetUserBySession (inSession);

    vbUnitId := (SELECT MovementLinkObject_Unit.ObjectId
                 FROM MovementLinkObject AS MovementLinkObject_Unit
                 WHERE MovementLinkObject_Unit.MovementId = inMovementId
                   AND MovementLinkObject_Unit.DescId = zc_MovementLinkObject_Unit()
                );
    vbOperDate := (SELECT Movement.OperDate FROM Movement WHERE Movement.Id = inMovementId);
    vbDate180 := CURRENT_DATE + INTERVAL '6 MONTH';
    vbDate30  := CURRENT_DATE + INTERVAL '1 MONTH';

    IF inShowAll
    THEN    
        -- ������� �� �������������
    CREATE TEMP TABLE tmpRemains (ContainerId Integer, GoodsId Integer, Amount TFloat, AmountRemains TFloat, ExpirationDate TDateTime) ON COMMIT DROP;
          INSERT INTO tmpRemains (ContainerId, GoodsId, Amount, AmountRemains, ExpirationDate)
           SELECT tmp.ContainerId
                , tmp.GoodsId
                , SUM (CASE WHEN COALESCE (MIDate_ExpirationDate.ValueData, zc_DateEnd()) <= vbDate180 THEN  tmp.Amount ELSE 0 END) AS Amount
                , SUM (tmp.Amount) AS AmountRemains
                , COALESCE (MIDate_ExpirationDate.ValueData, zc_DateEnd())  AS ExpirationDate
           FROM (SELECT Container.Id  AS ContainerId
                      , Container.ObjectId            AS GoodsId
                      , SUM(Container.Amount)::TFloat AS Amount
                 FROM Container
                 WHERE Container.DescId = zc_Container_Count()
                   --AND Container.ObjectId = inGoodsId
                   AND Container.WhereObjectId = vbUnitId
                   AND Container.Amount <> 0
                 GROUP BY Container.Id
                        , Container.ObjectId   
                 HAVING SUM(Container.Amount) <> 0
                 ) AS tmp
              LEFT JOIN ContainerlinkObject AS ContainerLinkObject_MovementItem
                                            ON ContainerLinkObject_MovementItem.Containerid =  tmp.ContainerId
                                           AND ContainerLinkObject_MovementItem.DescId = zc_ContainerLinkObject_PartionMovementItem()
              LEFT OUTER JOIN Object AS Object_PartionMovementItem ON Object_PartionMovementItem.Id = ContainerLinkObject_MovementItem.ObjectId
              -- ������� �������
              LEFT JOIN MovementItem AS MI_Income ON MI_Income.Id = Object_PartionMovementItem.ObjectCode
              -- ���� ��� ������, ������� ���� ������� ��������������� - � ���� �������� ����� "���������" ��������� ������ �� ����������
              LEFT JOIN MovementItemFloat AS MIFloat_MovementItem
                                          ON MIFloat_MovementItem.MovementItemId = MI_Income.Id
                                         AND MIFloat_MovementItem.DescId = zc_MIFloat_MovementItemId()
              -- �������� ������� �� ���������� (���� ��� ������, ������� ���� ������� ���������������)
              LEFT JOIN MovementItem AS MI_Income_find ON MI_Income_find.Id = (MIFloat_MovementItem.ValueData :: Integer)
                         
              LEFT OUTER JOIN MovementItemDate  AS MIDate_ExpirationDate
                                                ON MIDate_ExpirationDate.MovementItemId = COALESCE (MI_Income_find.Id,MI_Income.Id)  --Object_PartionMovementItem.ObjectCode
                                               AND MIDate_ExpirationDate.DescId = zc_MIDate_PartionGoods()
          -- WHERE COALESCE (MIDate_ExpirationDate.ValueData, zc_DateEnd()) <= vbDate180
           GROUP BY tmp.ContainerId
                  , tmp.GoodsId
                  , COALESCE (MIDate_ExpirationDate.ValueData, zc_DateEnd())
           ;
           
       -- ��������� ������
       OPEN Cursor1 FOR
            WITH
            MI_Master AS (SELECT MovementItem.Id                    AS Id
                               , MovementItem.ObjectId              AS GoodsId
                               , MovementItem.Amount                AS Amount
                               , MIFloat_AmountRemains.ValueData    AS AmountRemains
                               , MIFloat_Price.ValueData            AS Price
                               , COALESCE (MIFloat_PriceExp.ValueData, MIFloat_Price.ValueData) AS PriceExp
                               , MovementItem.isErased              AS isErased
                          FROM  MovementItem
                              LEFT JOIN MovementItemFloat AS MIFloat_Price
                                                          ON MIFloat_Price.MovementItemId = MovementItem.Id
                                                         AND MIFloat_Price.DescId = zc_MIFloat_Price()
                              LEFT JOIN MovementItemFloat AS MIFloat_PriceExp
                                                          ON MIFloat_PriceExp.MovementItemId = MovementItem.Id
                                                         AND MIFloat_PriceExp.DescId = zc_MIFloat_PriceExp()
                              LEFT JOIN MovementItemFloat AS MIFloat_AmountRemains
                                                          ON MIFloat_AmountRemains.MovementItemId = MovementItem.Id
                                                         AND MIFloat_AmountRemains.DescId = zc_MIFloat_AmountRemains()
                          WHERE MovementItem.MovementId = inMovementId
                            AND MovementItem.DescId = zc_MI_Master() 
                            AND (MovementItem.isErased = FALSE OR inIsErased = TRUE)
                          )  
                              
          , tmpPrice AS (SELECT Price_Goods.ChildObjectId                AS GoodsId
                              , ROUND(Price_Value.ValueData, 2) ::TFloat AS Price
                         FROM ObjectLink AS ObjectLink_Price_Unit
                              LEFT JOIN ObjectFloat AS Price_Value
                                                    ON Price_Value.ObjectId = ObjectLink_Price_Unit.ObjectId
                                                   AND Price_Value.DescId = zc_ObjectFloat_Price_Value()
                              LEFT JOIN ObjectLink AS Price_Goods
                                                   ON Price_Goods.ObjectId = ObjectLink_Price_Unit.ObjectId
                                                  AND Price_Goods.DescId = zc_ObjectLink_Price_Goods()
                         WHERE ObjectLink_Price_Unit.DescId = zc_ObjectLink_Price_Unit() 
                           AND ObjectLink_Price_Unit.ChildObjectId = vbUnitId
                         )
    
    SELECT COALESCE(MI_Master.Id,0)                     AS Id
         -- , COALESCE (MI_Master.GoodsId, tmpRemains.GoodsId) AS GoodsId
          , Object_Goods.Id            AS GoodsId
          , Object_Goods.ObjectCode    AS GoodsCode
          , Object_Goods.ValueData     AS GoodsName
          , COALESCE (MI_Master.Amount, tmpRemains.Amount)                          AS Amount
          , COALESCE (MI_Master.AmountRemains, tmpRemains.AmountRemains) ::TFloat   AS AmountRemains
          , COALESCE (MI_Master.Price, tmpPrice.Price)    AS Price
          , COALESCE (MI_Master.PriceExp, tmpPrice.Price) AS PriceExp
          --, COALESCE(MI_Master.IsErased, FALSE)          AS isErased
    FROM (SELECT tmpRemains.GoodsId
               , SUM (tmpRemains.AmountRemains) AS AmountRemains
               , SUM (tmpRemains.Amount)        AS Amount
          FROM tmpRemains 
          GROUP BY tmpRemains.GoodsId
          ) AS tmpRemains 
        FULL OUTER JOIN MI_Master ON MI_Master.GoodsId = tmpRemains.GoodsId
        LEFT JOIN tmpPrice ON tmpPrice.GoodsId = COALESCE (MI_Master.GoodsId, tmpRemains.GoodsId)
        LEFT JOIN Object AS Object_Goods ON Object_Goods.Id = COALESCE (MI_Master.GoodsId, tmpRemains.GoodsId)
        ;

       RETURN NEXT Cursor1;

       OPEN Cursor2 FOR
       WITH
           MI_Master AS (SELECT MovementItem.Id       AS Id
                              , MovementItem.ObjectId AS GoodsId
                         FROM  MovementItem
                         WHERE MovementItem.MovementId = inMovementId
                           AND MovementItem.DescId = zc_MI_Master()
                           AND MovementItem.IsErased = FALSE
                         )   
         , MI_Child AS (SELECT MovementItem.Id               AS Id
                             , MovementItem.ParentId         AS ParentId
                             , MovementItem.ObjectId         AS GoodsId
                             , MIFloat_ContainerId.ValueData AS ContainerId
                        FROM MovementItem
                             LEFT JOIN MovementItemFloat AS MIFloat_ContainerId
                                                         ON MIFloat_ContainerId.MovementItemId = MovementItem.Id
                                                        AND MIFloat_ContainerId.DescId = zc_MIFloat_ContainerId()
                        WHERE MovementItem.MovementId = inMovementId
                          AND MovementItem.DescId = zc_MI_Child() 
                          AND MovementItem.isErased = FALSE
                         )
         --���������� ����� � ��������
         SELECT COALESCE (MI_Child.Id,0)                        AS Id
              , COALESCE (MI_Master.Id, MI_Child.ParentId, 0)      AS ParentId
              , COALESCE (MI_Child.GoodsId, tmpRemains.GoodsId) AS GoodsId
              , tmpRemains.Amount                               AS Amount
              , tmpRemains.ContainerId                 ::Integer

              , CASE WHEN tmpRemains.ExpirationDate < vbOperDate THEN '����������'
                     WHEN tmpRemains.ExpirationDate <= vbDate30  THEN '������ 1 ������'
                     WHEN tmpRemains.ExpirationDate <= vbDate180 THEN '������ 6 �������'
                     ELSE ''
                END :: TVarChar AS Expired_text

              , CASE WHEN tmpRemains.ExpirationDate < vbOperDate THEN 0
                     WHEN tmpRemains.ExpirationDate <= vbDate30 THEN 1
                     WHEN tmpRemains.ExpirationDate <= vbDate180 THEN 2
                     ELSE 999
                END                                    ::TFloat AS Expired
              , tmpRemains.ExpirationDate
         FROM (SELECT tmpRemains.*
               FROM tmpRemains 
               WHERE tmpRemains.ExpirationDate <= vbDate180
               ) AS tmpRemains
             FULL JOIN MI_Child ON MI_Child.GoodsId     = tmpRemains.GoodsId
                               AND MI_Child.ContainerId = tmpRemains.ContainerId
             LEFT JOIN MI_Master ON MI_Master.GoodsId = COALESCE (MI_Child.GoodsId, tmpRemains.GoodsId);

       RETURN NEXT Cursor2;
   
   ELSE
            -- ��������� ������
          OPEN Cursor1 FOR
               WITH
                   MI_Master AS (SELECT MovementItem.Id                    AS Id
                                      , MovementItem.ObjectId              AS GoodsId
                                      , MovementItem.Amount                AS Amount
                                      , MIFloat_AmountRemains.ValueData    AS AmountRemains
                                      , MIFloat_Price.ValueData            AS Price
                                      , COALESCE (MIFloat_PriceExp.ValueData, MIFloat_Price.ValueData) AS PriceExp
                                      , MovementItem.isErased              AS isErased
                                 FROM  MovementItem
                                     LEFT JOIN MovementItemFloat AS MIFloat_Price
                                                                 ON MIFloat_Price.MovementItemId = MovementItem.Id
                                                                AND MIFloat_Price.DescId = zc_MIFloat_Price()
                                     LEFT JOIN MovementItemFloat AS MIFloat_PriceExp
                                                                 ON MIFloat_PriceExp.MovementItemId = MovementItem.Id
                                                                AND MIFloat_PriceExp.DescId = zc_MIFloat_PriceExp()
                                     LEFT JOIN MovementItemFloat AS MIFloat_AmountRemains
                                                                 ON MIFloat_AmountRemains.MovementItemId = MovementItem.Id
                                                                AND MIFloat_AmountRemains.DescId = zc_MIFloat_AmountRemains()
                                 WHERE MovementItem.MovementId = inMovementId
                                   AND MovementItem.DescId = zc_MI_Master() 
                                   AND (MovementItem.isErased = FALSE OR inIsErased = TRUE)
                                 )  
                                         
               SELECT MI_Master.Id               AS Id
                    , MI_Master.GoodsId          AS GoodsId
                    , Object_Goods.ObjectCode    AS GoodsCode
                    , Object_Goods.ValueData     AS GoodsName
                    , MI_Master.Amount           AS Amount
                    , MI_Master.AmountRemains    AS AmountRemains
                    , MI_Master.Price            AS Price
                    , MI_Master.PriceExp         AS PriceExp
                    , MI_Master.IsErased         AS isErased
               FROM MI_Master
                   LEFT JOIN Object AS Object_Goods ON Object_Goods.Id = MI_Master.GoodsId;
   
          RETURN NEXT Cursor1;
   
          OPEN Cursor2 FOR
               WITH
                   MI_Child AS (SELECT MovementItem.Id                    AS Id
                                     , MovementItem.ParentId              AS ParentId
                                     , MovementItem.ObjectId              AS GoodsId
                                     , MovementItem.Amount                AS Amount
                                     , MIFloat_ContainerId.ValueData      AS ContainerId
                                     , MIFloat_Expired.ValueData          AS Expired
                                     , MIDate_ExpirationDate.ValueData    AS ExpirationDate
                                     , MovementItem.isErased              AS isErased
                                FROM  MovementItem
                                    LEFT JOIN MovementItemFloat AS MIFloat_ContainerId
                                                                ON MIFloat_ContainerId.MovementItemId = MovementItem.Id
                                                               AND MIFloat_ContainerId.DescId = zc_MIFloat_ContainerId()
                                    LEFT JOIN MovementItemFloat AS MIFloat_Expired
                                                                ON MIFloat_Expired.MovementItemId = MovementItem.Id
                                                               AND MIFloat_Expired.DescId = zc_MIFloat_Expired()
                                    LEFT JOIN MovementItemDate AS MIDate_ExpirationDate
                                                               ON MIDate_ExpirationDate.MovementItemId = MovementItem.Id
                                                              AND MIDate_ExpirationDate.DescId = zc_MIDate_ExpirationDate()
   
                                WHERE MovementItem.MovementId = inMovementId
                                  AND MovementItem.DescId = zc_MI_Child() 
                                  AND (MovementItem.isErased = FALSE OR inIsErased = TRUE)
                                 )
                                         
               SELECT
                   COALESCE (MI_Child.Id, 0)     AS Id
                 , COALESCE (MI_Child.ParentId, 0) AS ParentId
                 , MI_Child.GoodsId AS GoodsId
                 , MI_Child.ExpirationDate ::TDateTime
                 , MI_Child.Amount      ::TFloat AS Amount
                 , MI_Child.ContainerId ::TFloat
                 , MI_Child.Expired
                 , CASE WHEN COALESCE (MI_Child.Expired,0) = 0 THEN '����������'
                        WHEN MI_Child.Expired = 1 THEN '������ 1 ������'
                        WHEN MI_Child.Expired = 2 THEN '������ 6 �������'
                        ELSE ''
                   END :: TVarChar AS Expired_text
                 , MI_Child.IsErased    AS isErased
               FROM MI_Child
               ;  
   
          RETURN NEXT Cursor2;
   END IF; 

END;
$BODY$
  LANGUAGE PLPGSQL VOLATILE;

/*
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.
 03.04.19         *
*/
--select * from gpSelect_MovementItem_SendPartionDate(inMovementId := 4516628 , inShowAll := 'False' , inIsErased := 'False' ,  inSession := '3');
--select * from gpSelect_MovementItem_SendPartionDate(inMovementId := 13671795 , inShowAll := 'True' , inIsErased := 'True' ,  inSession := '3');