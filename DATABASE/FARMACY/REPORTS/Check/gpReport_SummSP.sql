-- Function:  gpReport_SummSP()

DROP FUNCTION IF EXISTS gpReport_SummSP (TDateTime, TDateTime, Integer, Integer, TVarChar);


CREATE OR REPLACE FUNCTION  gpReport_SummSP(
    IN inStartDate        TDateTime,  -- ���� ������
    IN inEndDate          TDateTime,  -- ���� ���������
    IN inJuridicalOurId   Integer,    -- ���� ��.����
    IN inUnitId           Integer,    -- �������������
    IN inSession          TVarChar    -- ������ ������������
)
RETURNS SETOF refcursor
AS
$BODY$
   DECLARE vbUserId Integer;
   DECLARE vbObjectId Integer;
   DECLARE Cursor1 refcursor;
BEGIN
    -- �������� ���� ������������ �� ����� ���������
    -- PERFORM lpCheckRight (inSession, zc_Enum_Process_Select_Movement_Income());
    vbUserId:= lpGetUserBySession (inSession);

    -- ������������ <�������� ����>
    vbObjectId:= lpGet_DefaultValue ('zc_Object_Retail', vbUserId);

    -- ���������
    OPEN Cursor1 FOR
          
    WITH
         -- ������ �������������
          tmpUnit AS (SELECT inUnitId                                  AS UnitId
                      WHERE COALESCE (inUnitId, 0) <> 0 
                     UNION 
                      SELECT ObjectLink_Unit_Juridical.ObjectId        AS UnitId
                      FROM ObjectLink AS ObjectLink_Unit_Juridical
                      WHERE ObjectLink_Unit_Juridical.DescId = zc_ObjectLink_Unit_Juridical()
                        AND (ObjectLink_Unit_Juridical.ChildObjectId = inJuridicalOurId)
                        AND COALESCE (inUnitId, 0) = 0
                        AND COALESCE (inJuridicalOurId, 0) <> 0
                     UNION
                      SELECT ObjectLink_Unit_Juridical.ObjectId AS UnitId
                      FROM ObjectLink AS ObjectLink_Unit_Juridical
                         INNER JOIN ObjectLink AS ObjectLink_Juridical_Retail
                                               ON ObjectLink_Juridical_Retail.ObjectId = ObjectLink_Unit_Juridical.ChildObjectId
                                              AND ObjectLink_Juridical_Retail.DescId = zc_ObjectLink_Juridical_Retail()
                                              AND ObjectLink_Juridical_Retail.ChildObjectId = vbObjectId
                      WHERE ObjectLink_Unit_Juridical.DescId = zc_ObjectLink_Unit_Juridical()
                        AND COALESCE (inUnitId, 0) = 0
                        AND COALESCE (inJuridicalOurId, 0) = 0  
                     )

        -- ������ �� ��������
        , tmpData_Container AS (SELECT MIContainer.MovementItemId AS MI_Id
                                     , COALESCE (MIContainer.AnalyzerId,0) :: Integer  AS MovementItemId
                                     , MIContainer.MovementId                          AS MovementId
                                     , MIContainer.WhereObjectId_analyzer              AS UnitId
                                     , SUM (COALESCE (-1 * MIContainer.Amount, 0))     AS Amount
                                     , COALESCE (MIContainer.ObjectIntId_analyzer,0)   AS ObjectIntId_analyzer
                                FROM MovementItemContainer AS MIContainer
                                     INNER JOIN tmpUnit ON tmpUnit.UnitId = MIContainer.WhereObjectId_analyzer
                                WHERE MIContainer.DescId = zc_MIContainer_Count()
                                  AND MIContainer.MovementDescId = zc_Movement_Check()
                                  AND MIContainer.OperDate >= inStartDate AND MIContainer.OperDate < inEndDate + INTERVAL '1 DAY'
                                GROUP BY MIContainer.WhereObjectId_analyzer
                                       , COALESCE (MIContainer.AnalyzerId,0)
                                       , MIContainer.MovementItemId
                                       , MIContainer.MovementId
                                       , COALESCE (MIContainer.ObjectIntId_analyzer,0)
                               )

        -- ���. ��� �������, ���� �������� � �������
        , tmpMS_InvNumberSP AS (SELECT DISTINCT MovementString_InvNumberSP.MovementId
                                     , CASE WHEN MovementLinkObject_SPKind.ObjectId = zc_Enum_SPKind_1303() THEN TRUE ELSE FALSE END AS isSP_1303
                                FROM MovementString AS MovementString_InvNumberSP
                                --- ��������� ���. ��� � ���� 1303
                                     LEFT JOIN MovementLinkObject AS MovementLinkObject_SPKind
                                                                  ON MovementLinkObject_SPKind.MovementId = MovementString_InvNumberSP.MovementId
                                                                 AND MovementLinkObject_SPKind.DescId = zc_MovementLinkObject_SPKind()

                                WHERE MovementString_InvNumberSP.MovementId IN (SELECT DISTINCT tmpData_Container.MovementId FROM tmpData_Container)
                                  AND MovementString_InvNumberSP.DescId = zc_MovementString_InvNumberSP()
                                  AND COALESCE (MovementString_InvNumberSP.ValueData, '') <> ''
                                )
                                           
        , tmpMIF_SummChangePercent AS (SELECT MIFloat_SummChangePercent.*
                                       FROM MovementItemFloat AS MIFloat_SummChangePercent
                                       WHERE MIFloat_SummChangePercent.DescId =  zc_MIFloat_SummChangePercent()
                                         AND MIFloat_SummChangePercent.MovementItemId IN (SELECT DISTINCT tmpData_Container.MI_Id FROM tmpData_Container)
                                      )
        , tmpSP AS (SELECT tmpData_Container.UnitId
                         , SUM (CASE WHEN tmpData_Container.isSP_1303 = TRUE  THEN COALESCE (MovementFloat_SummChangePercent.ValueData, 0) ELSE 0 END) AS SummChangePercent_SP1303
                         , SUM (CASE WHEN tmpData_Container.isSP_1303 = FALSE THEN COALESCE (MovementFloat_SummChangePercent.ValueData, 0) ELSE 0 END) AS SummChangePercent_SP
                    FROM (SELECT DISTINCT tmpData_Container.MI_Id
                               , tmpData_Container.UnitId
                               , tmpMS_InvNumberSP.isSP_1303
                          FROM tmpData_Container
                               INNER JOIN tmpMS_InvNumberSP ON tmpMS_InvNumberSP.MovementId = tmpData_Container.MovementId
                          ) AS tmpData_Container
                            -- ����� ������ SP
                            LEFT JOIN tmpMIF_SummChangePercent AS MovementFloat_SummChangePercent
                                                               ON MovementFloat_SummChangePercent.MovementItemId = tmpData_Container.MI_Id
                    GROUP BY tmpData_Container.UnitId
                    )
                    
        -- �������� ������� �� ������� ���.������� 1303
        , tmpMovement_Sale AS (SELECT MovementLinkObject_Unit.ObjectId             AS UnitId
                                    , Movement_Sale.Id                             AS Id
                               FROM Movement AS Movement_Sale
                                    INNER JOIN MovementLinkObject AS MovementLinkObject_Unit
                                                                  ON MovementLinkObject_Unit.MovementId = Movement_Sale.Id
                                                                 AND MovementLinkObject_Unit.DescId = zc_MovementLinkObject_Unit()
                                    INNER JOIN tmpUnit ON tmpUnit.UnitId = MovementLinkObject_Unit.ObjectId
                                    
                                    INNER JOIN MovementString AS MovementString_InvNumberSP
                                                              ON MovementString_InvNumberSP.MovementId = Movement_Sale.Id
                                                             AND MovementString_InvNumberSP.DescId = zc_MovementString_InvNumberSP()
                                                             AND COALESCE (MovementString_InvNumberSP.ValueData,'') <> ''

                               WHERE Movement_Sale.DescId = zc_Movement_Sale()
                                 AND Movement_Sale.OperDate >= inStartDate AND Movement_Sale.OperDate < inEndDate + INTERVAL '1 DAY'
                                 AND Movement_Sale.StatusId = zc_Enum_Status_Complete()
                               )
 
        , tmpSale_1303 AS (SELECT Movement_Sale.UnitId                    AS UnitId
                                , SUM (COALESCE (-1 * MIContainer.Amount, MI_Sale.Amount) * COALESCE (MIFloat_PriceSale.ValueData, 0)) AS SummSale_1303
                           FROM tmpMovement_Sale AS Movement_Sale
                                INNER JOIN MovementItem AS MI_Sale
                                                        ON MI_Sale.MovementId = Movement_Sale.Id
                                                       AND MI_Sale.DescId = zc_MI_Master()
                                                       AND MI_Sale.isErased = FALSE
                           
                                LEFT JOIN MovementItemFloat AS MIFloat_PriceSale
                                                            ON MIFloat_PriceSale.MovementItemId = MI_Sale.Id
                                                           AND MIFloat_PriceSale.DescId = zc_MIFloat_PriceSale()
  
                                LEFT JOIN MovementItemContainer AS MIContainer
                                                                ON MIContainer.MovementItemId = MI_Sale.Id
                                                               AND MIContainer.DescId = zc_MIContainer_Count() 
                           GROUP BY Movement_Sale.UnitId
                           ) 

    , tmpData_All AS (SELECT tmpSP.UnitId
                                     , COALESCE (tmpSP.SummChangePercent_SP, 0)               AS SummSale_SP
                                     , (COALESCE (tmpSale_1303.SummSale_1303, 0)
                                      + COALESCE (tmpSP.SummChangePercent_SP1303, 0))         AS SummSale_1303
                                FROM tmpSP 
                                     LEFT JOIN tmpSale_1303 ON tmpSale_1303.UnitId = tmpSP.UnitId
                      )

 
                         
     -- ���������  
        SELECT
             Object_JuridicalMain.ObjectCode         AS JuridicalMainCode
           , Object_JuridicalMain.ValueData          AS JuridicalMainName
           , Object_Unit.ObjectCode                  AS UnitCode
           , Object_Unit.ValueData                   AS UnitName

           , tmp.SummSale_SP           :: TFloat
           , tmp.SummSale_1303         :: TFloat

           , (COALESCE (tmp.SummSale_SP,0) + COALESCE (tmp.SummSale_1303,0))  :: TFloat AS SummSale
       FROM tmpData_All AS tmp
                LEFT JOIN Object AS Object_Unit ON Object_Unit.Id = tmp.UnitId

                LEFT JOIN ObjectLink AS ObjectLink_Unit_Juridical
                                     ON ObjectLink_Unit_Juridical.ObjectId = Object_Unit.Id
                                    AND ObjectLink_Unit_Juridical.DescId = zc_ObjectLink_Unit_Juridical()
                LEFT JOIN Object AS Object_JuridicalMain ON Object_JuridicalMain.Id = ObjectLink_Unit_Juridical.ChildObjectId
                
       ORDER BY Object_JuridicalMain.ValueData 
              , Object_Unit.ValueData;
              
    RETURN NEXT Cursor1;

END;
$BODY$
  LANGUAGE PLPGSQL VOLATILE;

/*
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.
 07.04.20         *
*/
-- ����
-- select * from gpReport_SummSP(inStartDate := ('01.02.2020')::TDateTime , inEndDate := ('29.02.2020')::TDateTime , inJuridicalOurId := 0 ,inUnitId:= 183289, inSession := '3');
-- FETCH ALL "<unnamed portal 4>";