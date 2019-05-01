-- Function: gpInsert_MI_SendPartionDate()

DROP FUNCTION IF EXISTS gpInsert_MI_SendPartionDate (Integer, Integer, TDateTime, TVarChar);

CREATE OR REPLACE FUNCTION gpInsert_MI_SendPartionDate(
    IN inMovementId          Integer   , -- ���� ������� <��������>
    IN inUnitId              Integer   , -- 
    IN inOperDate            TDateTime , --
    IN inSession             TVarChar    -- ������ ������������
)
RETURNS VOID
AS
$BODY$
   DECLARE vbUserId   Integer;
   DECLARE vbDate180  TDateTime;
   DECLARE vbDate30   TDateTime;
   DECLARE vbDate0    TDateTime;
   DECLARE vbMonth_0  TFloat;
   DECLARE vbMonth_1  TFloat;
   DECLARE vbMonth_6  TFloat;
BEGIN
    -- �������� ���� ������������ �� ����� ���������
    --vbUserId := lpCheckRight (inSession, zc_Enum_Process_InsertUpdate_MI_SendPartionDate());
    vbUserId := inSession;

    -- �������� �������� �� ����������� 
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

     -- ������� �������� �� ���� �����
     UPDATE MovementItem
     SET isErased = FALSE
     WHERE MovementItem.MovementId = inMovementId;

    -- ������� �� �������������
    CREATE TEMP TABLE tmpRemains (ContainerId Integer, MovementId_Income Integer, GoodsId Integer, Amount TFloat, ExpirationDate TDateTime) ON COMMIT DROP;
          INSERT INTO tmpRemains (ContainerId, MovementId_Income, GoodsId, Amount, ExpirationDate)
           SELECT tmp.ContainerId
                , COALESCE (MI_Income_find.MovementId,MI_Income.MovementId) AS MovementId_Income
                , tmp.GoodsId
                , SUM (tmp.Amount) AS Amount                                                                    -- �������
                , COALESCE (MIDate_ExpirationDate.ValueData, zc_DateEnd()) ::TDateTime AS ExpirationDate        -- ���� ��������
           FROM (SELECT Container.Id  AS ContainerId
                      , Container.ObjectId            AS GoodsId
                      , SUM(Container.Amount)::TFloat AS Amount
                 FROM Container
                 WHERE Container.DescId = zc_Container_Count()
                   AND Container.WhereObjectId = inUnitId
                   AND Container.Amount <> 0
                 GROUP BY Container.Id
                        , Container.ObjectId   
                 HAVING SUM(Container.Amount) <> 0
                 ) AS tmp
              LEFT JOIN ContainerlinkObject AS ContainerLinkObject_MovementItem
                                            ON ContainerLinkObject_MovementItem.Containerid = tmp.ContainerId
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
                  , COALESCE (MI_Income_find.MovementId,MI_Income.MovementId)
           ;

    -- 
    CREATE TEMP TABLE tmpMaster (Id Integer, GoodsId Integer, Amount TFloat, AmountRemains TFloat, Price TFloat, PriceExp TFloat) ON COMMIT DROP;
    INSERT INTO tmpMaster (Id, GoodsId, Amount, AmountRemains, Price, PriceExp)
    WITH
      MI_Master AS (SELECT MovementItem.Id                    AS Id
                         , MovementItem.ObjectId              AS GoodsId
                         , MIFloat_Price.ValueData            AS Price
                         , COALESCE (MIFloat_PriceExp.ValueData, MIFloat_Price.ValueData) AS PriceExp
                    FROM MovementItem
                         LEFT JOIN MovementItemFloat AS MIFloat_Price
                                                     ON MIFloat_Price.MovementItemId = MovementItem.Id
                                                    AND MIFloat_Price.DescId = zc_MIFloat_Price()
                         LEFT JOIN MovementItemFloat AS MIFloat_PriceExp
                                                     ON MIFloat_PriceExp.MovementItemId = MovementItem.Id
                                                    AND MIFloat_PriceExp.DescId = zc_MIFloat_PriceExp()
                    WHERE MovementItem.MovementId = inMovementId
                      AND MovementItem.DescId = zc_MI_Master()
                      --AND MovementItem.IsErased = FALSE
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
                     AND ObjectLink_Price_Unit.ChildObjectId = inUnitId
                   )
    
    SELECT COALESCE(MI_Master.Id,0)                     AS Id
          , COALESCE (MI_Master.GoodsId, tmpRemains.GoodsId) AS GoodsId
          , tmpRemains.Amount                            AS Amount
          , tmpRemains.AmountRemains          ::TFloat   AS AmountRemains
          , COALESCE(MI_Master.Price, tmpPrice.Price)    AS Price
          , COALESCE(MI_Master.PriceExp, tmpPrice.Price) AS PriceExp
    FROM (SELECT tmpRemains.GoodsId
               , SUM (tmpRemains.Amount) AS AmountRemains
               , SUM (CASE WHEN tmpRemains.ExpirationDate <= vbDate180
                            AND tmpRemains.ExpirationDate > zc_DateStart()
                            AND tmpRemains.ExpirationDate > CURRENT_DATE - INTERVAL '3 YEAR'
                                THEN tmpRemains.Amount
                           ELSE 0
                      END) AS Amount
          FROM tmpRemains 
          GROUP BY tmpRemains.GoodsId
          HAVING SUM (CASE WHEN tmpRemains.ExpirationDate <= vbDate180
                            AND tmpRemains.ExpirationDate > zc_DateStart()
                            AND tmpRemains.ExpirationDate > CURRENT_DATE - INTERVAL '3 YEAR'
                                THEN tmpRemains.Amount
                           ELSE 0
                      END) <> 0
          ) AS tmpRemains
        FULL OUTER JOIN MI_Master ON MI_Master.GoodsId = tmpRemains.GoodsId
        LEFT JOIN tmpPrice ON tmpPrice.GoodsId = COALESCE (MI_Master.GoodsId, tmpRemains.GoodsId);

    --- ��������� MI_Master
    PERFORM lpInsertUpdate_MI_SendPartionDate_Master(ioId            := tmpMaster.Id
                                                   , inMovementId    := inMovementId
                                                   , inGoodsId       := tmpMaster.GoodsId  
                                                   , inAmount        := COALESCE (tmpMaster.Amount,0)        :: TFloat     -- ����������
                                                   , inAmountRemains := COALESCE (tmpMaster.AmountRemains,0) :: TFloat     --
                                                   , inPrice         := COALESCE (tmpMaster.Price,0)         :: TFloat     -- ���� (���� �� 1 ��� �� 6 ���)
                                                   , inPriceExp      := COALESCE (tmpMaster.PriceExp,0)      :: TFloat     -- ���� (���� ������ ������)
                                                   , inUserId       := vbUserId)
    FROM tmpMaster; 
                                  
    
    -- ������ � ������� �������� ������
    -- �������� ���� ������
    CREATE TEMP TABLE tmpChild (Id Integer, ParentId Integer, GoodsId Integer, Amount TFloat, ContainerId Integer, MovementId_Income Integer, PartionDateKindId Integer, ExpirationDate TDateTime) ON COMMIT DROP;
          INSERT INTO tmpChild (Id, ParentId, GoodsId, Amount, ContainerId, MovementId_Income, PartionDateKindId, ExpirationDate)
    WITH
      MI_Master AS (SELECT MovementItem.Id       AS Id
                         , MovementItem.ObjectId AS GoodsId
                    FROM  MovementItem
                    WHERE MovementItem.MovementId = inMovementId
                      AND MovementItem.DescId = zc_MI_Master()
                      AND MovementItem.IsErased = FALSE
                    )   

    , MI_Child AS (SELECT MovementItem.Id                    AS Id
                        , MovementItem.ParentId              AS ParentId
                        , MovementItem.ObjectId              AS GoodsId
                        , MIFloat_ContainerId.ValueData      AS ContainerId
                   FROM  MovementItem
                        LEFT JOIN MovementItemFloat AS MIFloat_ContainerId
                                                    ON MIFloat_ContainerId.MovementItemId = MovementItem.Id
                                                   AND MIFloat_ContainerId.DescId = zc_MIFloat_ContainerId()

                   WHERE MovementItem.MovementId = inMovementId
                     AND MovementItem.DescId = zc_MI_Child() 
                     AND MovementItem.isErased = FALSE
                    )

    --���������� ����� � ��������
    SELECT COALESCE (MI_Child.Id,0)                        AS Id
         , COALESCE (MI_Master.Id, MI_Child.ParentId, 0)   AS ParentId
         , COALESCE (MI_Child.GoodsId, tmpRemains.GoodsId) AS GoodsId
         , tmpRemains.Amount                               AS Amount
         , tmpRemains.ContainerId                 ::Integer
         , tmpRemains.MovementId_Income
         , CASE WHEN tmpRemains.ExpirationDate <= vbDate0 THEN zc_Enum_PartionDateKind_0()
                WHEN tmpRemains.ExpirationDate <= vbDate30 THEN zc_Enum_PartionDateKind_1()
                ELSE zc_Enum_PartionDateKind_6()
           END                                             AS PartionDateKindId
         , tmpRemains.ExpirationDate
    FROM (SELECT tmpRemains.*
          FROM tmpRemains 
          WHERE tmpRemains.ExpirationDate <= vbDate180
          ) AS tmpRemains
        FULL JOIN MI_Child ON MI_Child.GoodsId = tmpRemains.GoodsId
                          AND MI_Child.ContainerId = tmpRemains.ContainerId
        LEFT JOIN MI_Master ON MI_Master.GoodsId = COALESCE (MI_Child.GoodsId, tmpRemains.GoodsId);
    


    --- ��������� MI_Child
    PERFORM lpInsertUpdate_MI_SendPartionDate_Child(ioId                 := tmpChild.Id
                                                  , inParentId           := tmpChild.ParentId
                                                  , inMovementId         := inMovementId
                                                  , inGoodsId            := tmpChild.GoodsId  
                                                  , inPartionDateKindId  := tmpChild.PartionDateKindId
                                                  , inExpirationDate     := tmpChild.ExpirationDate
                                                  , inAmount             := COALESCE (tmpChild.Amount,0)        :: TFloat
                                                  , inContainerId        := COALESCE (tmpChild.ContainerId,0)   :: TFloat
                                                  , inMovementId_Income  := COALESCE (tmpChild.MovementId_Income,0):: TFloat
                                                  , inUserId             := vbUserId)
    FROM tmpChild
    WHERE COALESCE (tmpChild.Amount,0) <> 0;

     -- ������� ������, ������� ��� �� �����
     UPDATE MovementItem 
     SET isErased = TRUE
     WHERE MovementItem.Id IN (SELECT tmpMaster.Id
                               FROM tmpMaster 
                               WHERE COALESCE (tmpMaster.AmountRemains, 0) = 0
                                 AND tmpMaster.Id <> 0);
     -- ������� ������ �����, ������� ��� �� �����
     UPDATE MovementItem 
     SET isErased = TRUE
     WHERE MovementItem.Id IN (SELECT tmpChild.Id
                               FROM tmpChild 
                               WHERE COALESCE (tmpChild.Amount, 0) = 0
                                 AND COALESCE (tmpChild.Id, 0) <> 0);

END;
$BODY$
  LANGUAGE plpgsql VOLATILE;

/*
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.
 05.04.19         *
*/