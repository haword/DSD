-- Function: gpSelect_Movement_Income()

DROP FUNCTION IF EXISTS gpSelect_GoodsSearchRemains (TVarChar, TVarChar);
DROP FUNCTION IF EXISTS gpSelect_GoodsSearchRemains (TVarChar, TVarChar, TVarChar);

CREATE OR REPLACE FUNCTION gpSelect_GoodsSearchRemains(
    IN inCodeSearch     TVarChar,    -- ����� ������� �� ����
    IN inGoodsSearch    TVarChar,    -- ����� �������
    IN inSession        TVarChar    -- ������ ������������
)
RETURNS TABLE (Id integer, GoodsCode Integer, GoodsName TVarChar
             , NDSkindName TVarChar
             , NDS TFloat
             , GoodsGroupName TVarChar
             , UnitName TVarChar
             , AreaName TVarChar
             , Address_Unit TVarChar
             , Phone_Unit TVarChar
             , ProvinceCityName_Unit TVarChar
             , JuridicalName_Unit TVarChar
             , Phone TVarChar
             , Amount TFloat
             , AmountIncome TFloat
             , AmountReserve TFloat
             , AmountAll TFloat
             , PriceSale  TFloat
             , SummaSale TFloat
             , PriceSaleIncome  TFloat
             , MinExpirationDate TDateTime
             )
AS
$BODY$
   DECLARE vbUserId Integer;
   DECLARE vbObjectId Integer;
   DECLARE vbRemainsDate TDateTime;
BEGIN

    -- �������� ���� ������������ �� ����� ���������
    -- PERFORM lpCheckRight (inSession, zc_Enum_Process_Select_Movement_Income());
    vbUserId:= lpGetUserBySession (inSession);
    -- ����������� �� �������� ��������� �����������
    vbObjectId := lpGet_DefaultValue('zc_Object_Retail', vbUserId);

    vbRemainsDate = CURRENT_TIMESTAMP;

    -- ���������
    RETURN QUERY
        WITH 
        tmpGoods AS (SELECT Object.Id
                     FROM Object 
                     WHERE Object.DescId = zc_Object_Goods()
                       AND (upper(CAST(Object.ObjectCode AS TVarChar)) LIKE UPPER(inCodeSearch) AND inCodeSearch <> '')
                       OR (upper(Object.ValueData) LIKE UPPER('%'||inGoodsSearch||'%')  AND inGoodsSearch <> '' AND inCodeSearch = '')
                     )

      , containerCount AS (SELECT Container.Id                AS ContainerId
                                , Container.Amount
                                , Container.ObjectID          AS GoodsId
                                , Container.WhereObjectId     AS UnitId
                           FROM tmpGoods
                              LEFT JOIN Container ON Container.ObjectID = tmpGoods.Id
                           WHERE Container.descid = zc_container_count()
                           )

      , tmpcontainerCount AS (SELECT ContainerCount.Amount - COALESCE(SUM(MIContainer.Amount), 0) AS Amount
                                   , ContainerCount.GoodsId 
                                   , ContainerCount.UnitId 
                                   , ContainerCount.ContainerId
                              FROM ContainerCount
                                  LEFT JOIN MovementItemContainer AS MIContainer 
                                                                  ON MIContainer.ContainerId = ContainerCount.ContainerId
                                                                 AND MIContainer.OperDate >= vbRemainsDate
                              GROUP BY ContainerCount.ContainerId, ContainerCount.Amount, ContainerCount.GoodsId , ContainerCount.UnitId 
                              HAVING (ContainerCount.Amount - COALESCE(SUM(MIContainer.Amount), 0)) <> 0
                             )


      , tmpData AS (SELECT tmpData_all.UnitId
                         , tmpData_all.GoodsId
                         , SUM (tmpData_all.Amount)   AS Amount
                         , min (tmpData_all.MinExpirationDate) AS MinExpirationDate
                    FROM (  SELECT SUM(tmpcontainerCount.Amount)    AS Amount
                                 , tmpcontainerCount.GoodsId 
                                 , tmpcontainerCount.UnitId 
                                 , min (COALESCE(MIDate_ExpirationDate.ValueData,zc_DateEnd()))::TDateTime AS MinExpirationDate -- ���� �������� 
                            FROM tmpcontainerCount
                               
                                -- ������� ������ ��� ����������� ����� �������� �������
                                LEFT JOIN ContainerlinkObject AS ContainerLinkObject_MovementItem
                                                              ON ContainerLinkObject_MovementItem.Containerid =  tmpcontainerCount.ContainerId 
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
                                                                                                                                      
                            GROUP BY tmpcontainerCount.GoodsId, tmpcontainerCount.UnitId 
                            ) AS tmpData_all
                    GROUP BY tmpData_all.GoodsId
                           , tmpData_all.UnitId
                    HAVING (SUM (tmpData_all.Amount) <> 0)                                
                     )

      , tmpIncome AS (SELECT MovementLinkObject_To.ObjectId          AS UnitId
                           , MI_Income.ObjectId                      AS GoodsId
                           , SUM(COALESCE (MI_Income.Amount, 0))     AS AmountIncome  
                           , SUM(COALESCE (MI_Income.Amount, 0) * COALESCE(MIFloat_PriceSale.ValueData,0))  AS SummSale    
                      FROM Movement AS Movement_Income
                           INNER JOIN MovementDate AS MovementDate_Branch
                                                   ON MovementDate_Branch.MovementId = Movement_Income.Id
                                                  AND MovementDate_Branch.DescId = zc_MovementDate_Branch()
                                                  AND date_trunc('day', MovementDate_Branch.ValueData) between date_trunc('day', CURRENT_TIMESTAMP)-interval '1 day' AND date_trunc('day', CURRENT_TIMESTAMP)
                            
                           LEFT JOIN MovementLinkObject AS MovementLinkObject_To
                                                         ON MovementLinkObject_To.MovementId = Movement_Income.Id
                                                        AND MovementLinkObject_To.DescId = zc_MovementLinkObject_To()

                           LEFT JOIN MovementItem AS MI_Income 
                                                  ON MI_Income.MovementId = Movement_Income.Id
                                                 AND MI_Income.isErased   = False

                           LEFT JOIN MovementItemFloat AS MIFloat_PriceSale
                                                       ON MIFloat_PriceSale.MovementItemId = MI_Income.Id
                                                      AND MIFloat_PriceSale.DescId = zc_MIFloat_PriceSale()

                           -- left join  Object ON Object.id = MI_Income.ObjectId
                           -- left join  Object AS Object1 ON Object1.id = MovementLinkObject_To.ObjectId                  
                       WHERE Movement_Income.DescId = zc_Movement_Income()
                         AND Movement_Income.StatusId = zc_Enum_Status_UnComplete() 
                       GROUP BY MI_Income.ObjectId
                              , MovementLinkObject_To.ObjectId 
                    )                          

       -- ���������� ����
      , tmpMovReserve AS (SELECT Movement.Id
                               , MovementLinkObject_Unit.ObjectId AS UnitId
                          FROM MovementBoolean AS MovementBoolean_Deferred
                             INNER JOIN Movement ON Movement.Id     = MovementBoolean_Deferred.MovementId
                                                AND Movement.DescId = zc_Movement_Check()
                                                AND Movement.StatusId = zc_Enum_Status_UnComplete()
                             INNER JOIN MovementLinkObject AS MovementLinkObject_Unit
                                                           ON MovementLinkObject_Unit.MovementId = Movement.Id
                                                          AND MovementLinkObject_Unit.DescId = zc_MovementLinkObject_Unit()
                          WHERE MovementBoolean_Deferred.DescId    = zc_MovementBoolean_Deferred()
                            AND MovementBoolean_Deferred.ValueData = TRUE
                         UNION ALL
                          SELECT Movement.Id
                               , MovementLinkObject_Unit.ObjectId AS UnitId
                          FROM MovementString AS MovementString_CommentError
                             INNER JOIN Movement ON Movement.Id     = MovementString_CommentError.MovementId
                                                AND Movement.DescId = zc_Movement_Check()
                                                AND Movement.StatusId = zc_Enum_Status_UnComplete()
                             INNER JOIN MovementLinkObject AS MovementLinkObject_Unit
                                                           ON MovementLinkObject_Unit.MovementId = Movement.Id
                                                          AND MovementLinkObject_Unit.DescId = zc_MovementLinkObject_Unit()
                         WHERE MovementString_CommentError.DescId = zc_MovementString_CommentError()
                           AND MovementString_CommentError.ValueData <> ''
                         )
      , tmpReserve AS (SELECT tmpMovReserve.UnitId             AS UnitId
                            , MovementItem.ObjectId            AS GoodsId
                            , Sum(MovementItem.Amount)::TFloat AS Amount
                       FROM tmpMovReserve
                            INNER JOIN MovementItem ON MovementItem.MovementId = tmpMovReserve.Id
                                                   AND MovementItem.DescId     = zc_MI_Master()
                                                   AND MovementItem.isErased   = FALSE
                       GROUP BY MovementItem.ObjectId, tmpMovReserve.UnitId
                       )
    
        SELECT Object_Goods_View.Id                         AS Id
             , Object_Goods_View.GoodsCodeInt    :: Integer AS GoodsCode
             , Object_Goods_View.GoodsName                  AS GoodsName
             , Object_Goods_View.NDSkindName                as NDSkindName
             , Object_Goods_View.NDS                        AS NDS
             , Object_Goods_View.GoodsGroupName             AS GoodsGroupName
             , Object_Unit.ValueData                        AS UnitName
             , Object_Area.ValueData                        AS AreaName
             , ObjectString_Unit_Address.ValueData          AS Address_Unit
             , ObjectString_Unit_Phone.ValueData            AS Phone_Unit
             , Object_ProvinceCity.ValueData                AS ProvinceCityName_Unit
             , Object_Juridical.ValueData                   AS JuridicalName_Unit

             , ObjectString_Phone.ValueData                 AS Phone
             , COALESCE (tmpData.Amount,0)         :: TFloat AS Amount
             , COALESCE (tmpIncome.AmountIncome,0)                                   :: TFloat AS AmountIncome
             , COALESCE (tmpReserve.Amount, 0)                                       :: TFloat AS AmountReserve
             , (COALESCE (tmpData.Amount,0) + COALESCE (tmpIncome.AmountIncome,0))   :: TFloat AS AmountAll
             , COALESCE (ObjectHistoryFloat_Price.ValueData, 0)                      :: TFloat AS PriceSale
             , (tmpData.Amount * COALESCE (ObjectHistoryFloat_Price.ValueData, 0))   :: TFloat AS SummaSale
             , CASE WHEN COALESCE(tmpIncome.AmountIncome,0) <> 0 THEN COALESCE (tmpIncome.SummSale,0) / COALESCE (tmpIncome.AmountIncome,0) ELSE 0 END  :: TFloat AS PriceSaleIncome
             , tmpData.MinExpirationDate  ::TDateTime
        FROM tmpGoods
            LEFT JOIN Object AS Object_Unit ON Object_Unit.DescId = zc_Object_Unit()
            LEFT JOIN tmpData ON tmpData.GoodsId = tmpGoods.Id
                             AND tmpData.UnitId  = Object_Unit.Id

            LEFT JOIN ObjectLink AS ObjectLink_Unit_Area
                                 ON ObjectLink_Unit_Area.ObjectId = Object_Unit.Id 
                                AND ObjectLink_Unit_Area.DescId = zc_ObjectLink_Unit_Area()
            LEFT JOIN Object AS Object_Area ON Object_Area.Id = ObjectLink_Unit_Area.ChildObjectId

            LEFT JOIN tmpIncome ON tmpIncome.GoodsId = tmpGoods.Id
                               AND tmpIncome.UnitId  = Object_Unit.Id

            LEFT JOIN tmpReserve ON tmpReserve.GoodsId = tmpGoods.Id
                                AND tmpReserve.UnitId  = Object_Unit.Id
     
            LEFT JOIN Object_Goods_View ON Object_Goods_View.Id = tmpGoods.Id

            LEFT OUTER JOIN Object_Price_View AS Object_Price
                                              ON Object_Price.GoodsId = tmpGoods.Id     
                                             AND Object_Price.UnitId  = Object_Unit.Id  

            -- �������� �������� ���� � ��� �� ������� �������� �� ���� �� ������                                                          
            LEFT JOIN ObjectHistory AS ObjectHistory_Price
                                    ON ObjectHistory_Price.ObjectId = Object_Price.Id
                                   AND ObjectHistory_Price.DescId = zc_ObjectHistory_Price()
                                   AND vbRemainsDate >= ObjectHistory_Price.StartDate AND vbRemainsDate < ObjectHistory_Price.EndDate
            LEFT JOIN ObjectHistoryFloat AS ObjectHistoryFloat_Price
                                         ON ObjectHistoryFloat_Price.ObjectHistoryId = ObjectHistory_Price.Id
                                        AND ObjectHistoryFloat_Price.DescId = zc_ObjectHistoryFloat_Price_Value()

            LEFT JOIN ObjectLink AS ContactPerson_ContactPerson_Object
                                 ON ContactPerson_ContactPerson_Object.ChildObjectId = Object_Unit.Id
                                AND ContactPerson_ContactPerson_Object.DescId = zc_ObjectLink_ContactPerson_Object()
            LEFT JOIN ObjectString AS ObjectString_Phone
                                   ON ObjectString_Phone.ObjectId = ContactPerson_ContactPerson_Object.ObjectId
                                  AND ObjectString_Phone.DescId = zc_ObjectString_ContactPerson_Phone()
                                  
            -- ��������� ��� �������������
            LEFT JOIN ObjectLink AS ObjectLink_Unit_Juridical
                                 ON ObjectLink_Unit_Juridical.ObjectId = Object_Unit.Id
                                AND ObjectLink_Unit_Juridical.DescId = zc_ObjectLink_Unit_Juridical()
            LEFT JOIN Object AS Object_Juridical ON Object_Juridical.Id = ObjectLink_Unit_Juridical.ChildObjectId

            LEFT JOIN ObjectLink AS ObjectLink_Unit_ProvinceCity
                                 ON ObjectLink_Unit_ProvinceCity.ObjectId = Object_Unit.Id
                                AND ObjectLink_Unit_ProvinceCity.DescId = zc_ObjectLink_Unit_ProvinceCity()
            LEFT JOIN Object AS Object_ProvinceCity ON Object_ProvinceCity.Id = ObjectLink_Unit_ProvinceCity.ChildObjectId

            LEFT JOIN ObjectString AS ObjectString_Unit_Address
                                   ON ObjectString_Unit_Address.ObjectId = Object_Unit.Id
                                  AND ObjectString_Unit_Address.DescId = zc_ObjectString_Unit_Address()
            LEFT JOIN ObjectString AS ObjectString_Unit_Phone
                                   ON ObjectString_Unit_Phone.ObjectId = Object_Unit.Id
                                  AND ObjectString_Unit_Phone.DescId = zc_ObjectString_Unit_Phone()

          WHERE COALESCE(tmpData.Amount,0)<>0 OR COALESCE(tmpIncome.AmountIncome,0)<>0
          ORDER BY Object_Unit.ValueData 
                 , Object_Goods_View.GoodsGroupName
                 , Object_Goods_View.GoodsName 
           ;

END;
$BODY$
  LANGUAGE PLPGSQL VOLATILE;

/*
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.
 11.12.18         * AmountReserve
 28.08.18         *
 05.01.18         *
 08.07.16         *
 11.05.16         *
 18.04.16         *
*/

-- ����
-- SELECT * FROM gpSelect_GoodsSearchRemains ('4282', '������', inSession := '3')
