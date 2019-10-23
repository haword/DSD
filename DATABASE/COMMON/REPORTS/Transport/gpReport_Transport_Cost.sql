-- Function: gpReport_Transport_Cost ()

DROP FUNCTION IF EXISTS gpReport_Transport_Cost (TDateTime, TDateTime, Integer, Integer, Integer, Integer, Boolean, Boolean, Boolean, TVarChar);

CREATE OR REPLACE FUNCTION gpReport_Transport_Cost (
    IN inStartDate        TDateTime ,  
    IN inEndDate          TDateTime ,
    IN inBusinessId       Integer   ,
    IN inBranchId         Integer   ,
    IN inUnitId           Integer   ,
    IN inCarId            Integer   ,
    IN inIsMovement       Boolean   ,
    IN inIsPartner        Boolean   ,
    IN inIsGoods          Boolean   ,
    IN inSession          TVarChar    -- ������ ������������
)
RETURNS TABLE (Invnumber TVarChar, OperDate TDateTime, MovementDescName TVarChar
             , FuelName TVarChar, CarModelName TVarChar, CarName TVarChar--, FuelMasterName TVarChar
             , RouteName TVarChar, PersonalDriverName TVarChar
             , UnitName TVarChar, BranchName TVarChar,  BusinessName TVarChar
             , ProfitLossGroupName TVarChar, ProfitLossDirectionName TVarChar, ProfitLossName TVarChar, ProfitLossName_all TVarChar
             , SumCount_Transport TFloat, SumAmount_Transport TFloat, PriceFuel TFloat
             , SumAmount_TransportAdd TFloat, SumAmount_TransportAddLong TFloat, SumAmount_TransportTaxi TFloat
             , SumAmount_TransportService TFloat, SumAmount_ServiceAdd TFloat, SumAmount_ServiceTotal TFloat, SumAmount_PersonalSendCash TFloat
             , SumTotal TFloat
             , Distance TFloat
             , WeightTransport TFloat, WeightSale TFloat
             , One_KM TFloat, One_KG TFloat
             , isAccount_50000 Boolean

             , MovemenId_Sale Integer
             , OperDate_Sale  TDateTime
             , Invnumber_Sale TVarChar
             , GoodsId        Integer
             , GoodsCode      Integer
             , GoodsName      TVarChar
             , GoodsKindId    Integer
             , GoodsKindName  TVarChar
             , Amount_Sale    TFloat
             )   
AS
$BODY$
 DECLARE vbUserId Integer;
 DECLARE vbIsGroup Boolean;
BEGIN
      vbUserId:= lpGetUserBySession (inSession);

      vbIsGroup:= (inSession = '');

    -- ���������
    RETURN QUERY
    WITH tmpAccount_50000 AS (SELECT * FROM Object_Account_View WHERE Object_Account_View.AccountGroupId = zc_Enum_AccountGroup_50000())
        , tmpContainer AS (SELECT tmpContainer.MovementId               
                                , tmpContainer.MovementDescId           
                                , tmpContainer.FuelId
                                , tmpContainer.SumCount_Transport
                                , tmpContainer.SumAmount_Transport
                                , tmpContainer.SumAmount_TransportAdd
                                , tmpContainer.SumAmount_TransportAddLong
                                , tmpContainer.SumAmount_TransportTaxi
                                , tmpContainer.SumAmount_TransportService
                                , tmpContainer.SumAmount_ServiceAdd
                                , tmpContainer.SumAmount_PersonalSendCash
                                , tmpContainer.CarId
                                , tmpContainer.UnitId
                                , tmpContainer.BranchId
                                , tmpContainer.PersonalDriverId
                                , tmpContainer.RouteId
                                , tmpContainer.ProfitLossId
                                , tmpContainer.BusinessId
                                , tmpContainer.isAccount_50000
                   
                                , SUM (CASE WHEN tmpContainer.MovementDescId = zc_Movement_TransportService() THEN MIFloat_Distance.ValueData
                                       WHEN tmpContainer.MovementDescId = zc_Movement_Transport() THEN (MovementItem.Amount + COALESCE(MIFloat_Distance.ValueData,0))
                                       ELSE 0 END)   AS Distance
                                , SUM (CASE WHEN tmpContainer.MovementDescId = zc_Movement_Transport() THEN MIFloat_WeightTransport.ValueData ELSE 0 END)  AS WeightTransport
                                
                           FROM (
                                  SELECT MIContainer.MovementId               AS MovementId
                                       , MIContainer.MovementDescId           AS MovementDescId
                                       , CASE WHEN MIContainer.MovementDescId = zc_Movement_Transport() AND MovementItem.Id IS NULL THEN MIContainer.ObjectId_Analyzer ELSE 0 END AS FuelId
                                       , SUM (CASE WHEN MIContainer.DescId = zc_MIContainer_Count() AND MIContainer.MovementDescId = zc_Movement_Transport() THEN -1 * MIContainer.Amount ELSE 0 END) AS SumCount_Transport
                                       , SUM (CASE WHEN MIContainer.DescId = zc_MIContainer_Summ() AND MIContainer.MovementDescId = zc_Movement_Transport()        AND COALESCE (MIContainer.AnalyzerId, 0) IN (0, zc_Enum_AnalyzerId_ProfitLoss()) THEN -1 * MIContainer.Amount ELSE 0 END) AS SumAmount_Transport
                                       , SUM (CASE WHEN MIContainer.DescId = zc_MIContainer_Summ() AND MIContainer.MovementDescId = zc_Movement_Transport()        AND MIContainer.AnalyzerId = zc_Enum_AnalyzerId_Transport_Add() THEN -1 * MIContainer.Amount ELSE 0 END) AS SumAmount_TransportAdd
                                       , SUM (CASE WHEN MIContainer.DescId = zc_MIContainer_Summ() AND MIContainer.AnalyzerId     = zc_Enum_AnalyzerId_Transport_AddLong() THEN -1 * MIContainer.Amount ELSE 0 END) AS SumAmount_TransportAddLong
                                       , SUM (CASE WHEN MIContainer.DescId = zc_MIContainer_Summ() AND MIContainer.AnalyzerId     = zc_Enum_AnalyzerId_Transport_Taxi()    THEN -1 * MIContainer.Amount ELSE 0 END) AS SumAmount_TransportTaxi
                                       , SUM (CASE WHEN MIContainer.DescId = zc_MIContainer_Summ() AND MIContainer.MovementDescId = zc_Movement_TransportService() AND MIContainer.AnalyzerId = zc_Enum_AnalyzerId_ProfitLoss()    THEN -1 * MIContainer.Amount ELSE 0 END) AS SumAmount_TransportService
                                       , SUM (CASE WHEN MIContainer.DescId = zc_MIContainer_Summ() AND MIContainer.MovementDescId = zc_Movement_TransportService() AND MIContainer.AnalyzerId = zc_Enum_AnalyzerId_Transport_Add() THEN -1 * MIContainer.Amount ELSE 0 END) AS SumAmount_ServiceAdd
                                       , SUM (CASE WHEN MIContainer.DescId = zc_MIContainer_Summ() AND MIContainer.MovementDescId = zc_Movement_PersonalSendCash()         THEN -1 * MIContainer.Amount ELSE 0 END) AS SumAmount_PersonalSendCash
                                       , MIContainer.WhereObjectId_Analyzer          AS CarId
                                       , MIContainer.ObjectIntId_Analyzer            AS UnitId
                                       , MIContainer.ObjectExtId_Analyzer            AS BranchId
                                       , CASE WHEN MIContainer.MovementDescId = zc_Movement_Transport() AND COALESCE (MIContainer.AnalyzerId, 0) NOT IN (zc_Enum_AnalyzerId_Transport_Add(), zc_Enum_AnalyzerId_Transport_AddLong(), zc_Enum_AnalyzerId_Transport_Taxi()) THEN MovementLinkObject_PersonalDriver.ObjectId ELSE MIContainer.ObjectId_Analyzer END AS PersonalDriverId
                                       , COALESCE (MovementItem.ObjectId, MILinkObject_Route.ObjectId)  AS RouteId
                                       , CLO_ProfitLoss.ObjectId                     AS ProfitLossId
                                       , CLO_Business.ObjectId                       AS BusinessId
                                       -- , MIContainer.AnalyzerId
                                    -- , CASE WHEN tmpAccount_50000.AccountId > 0 THEN TRUE ELSE FALSE END AS isAccount_50000
                                       , FALSE AS isAccount_50000
                               
                                  FROM MovementItemContainer AS MIContainer
                                       INNER JOIN ContainerLinkObject AS CLO_ProfitLoss
                                                                      ON CLO_ProfitLoss.ContainerId = MIContainer.ContainerId_Analyzer
                                                                     AND CLO_ProfitLoss.DescId      = zc_ContainerLinkObject_ProfitLoss()   
                                       LEFT JOIN ContainerLinkObject AS CLO_Business
                                                                     ON CLO_Business.ContainerId = MIContainer.ContainerId_Analyzer
                                                                    AND CLO_Business.DescId = zc_ContainerLinkObject_Business()
                                                           
                                       LEFT JOIN MovementLinkObject AS MovementLinkObject_PersonalDriver
                                                                    ON MovementLinkObject_PersonalDriver.MovementId = MIContainer.MovementId
                                                                   AND MovementLinkObject_PersonalDriver.DescId = zc_MovementLinkObject_PersonalDriver()
         
                                       LEFT JOIN MovementItemLinkObject AS MILinkObject_Route
                                                                        ON MILinkObject_Route.MovementItemId = MIContainer.MovementItemId
                                                                       AND MILinkObject_Route.DescId = zc_MILinkObject_Route()
                                       LEFT JOIN MovementItem ON MovementItem.Id = MIContainer.MovementItemId
                                                             AND MovementItem.DescId = zc_MI_Master()
                                                             AND MIContainer.MovementDescId = zc_Movement_Transport()
                                       -- LEFT JOIN tmpAccount_50000 ON tmpAccount_50000.AccountId = MIContainer.AccountId
                                       LEFT JOIN tmpAccount_50000 ON tmpAccount_50000.AccountId = MIContainer.AccountId_Analyzer
                                                      
                                  WHERE MIContainer.OperDate BETWEEN inStartDate AND inEndDate  
                                    AND MIContainer.MovementDescId in (zc_Movement_Transport(), zc_Movement_TransportService(),zc_Movement_PersonalSendCash())
                                    -- AND MIContainer.AnalyzerId = zc_Enum_AnalyzerId_ProfitLoss()
                                    AND (MIContainer.ObjectExtId_Analyzer   = inBranchId   OR inBranchId   = 0) -- ������
                                    AND (MIContainer.ObjectIntId_Analyzer   = inUnitId     OR inUnitId     = 0) -- �������������
                                    AND (MIContainer.WhereObjectId_Analyzer = inCarId      OR inCarId      = 0) -- ����������
                                    AND (CLO_Business.ObjectId              = inBusinessId OR inBusinessId = 0) -- ������  
                                 -- AND (CLO_ProfitLoss.ContainerId > 0 OR tmpAccount_50000.AccountId > 0)
                                  GROUP BY  MIContainer.MovementId, MIContainer.MovementDescId
                                          , MIContainer.ObjectId_Analyzer
                                          , MIContainer.WhereObjectId_Analyzer 
                                          , MIContainer.ObjectIntId_Analyzer 
                                          , MIContainer.ObjectExtId_Analyzer
                                          , CASE WHEN MIContainer.MovementDescId = zc_Movement_Transport() AND COALESCE (MIContainer.AnalyzerId, 0) NOT IN (zc_Enum_AnalyzerId_Transport_Add(), zc_Enum_AnalyzerId_Transport_AddLong(), zc_Enum_AnalyzerId_Transport_Taxi()) THEN MovementLinkObject_PersonalDriver.ObjectId ELSE MIContainer.ObjectId_Analyzer END
                                          , MILinkObject_Route.ObjectId
                                          , CLO_ProfitLoss.ObjectId
                                          , CLO_Business.ObjectId 
                                          -- , MovementLinkObject_PersonalDriver.ObjectId   
                                          , MovementItem.Id
                                          , MovementItem.ObjectId
                                       -- , CASE WHEN tmpAccount_50000.AccountId > 0 THEN TRUE ELSE FALSE END
                                 UNION ALL
                                  SELECT MIContainer.MovementId               AS MovementId
                                       , MIContainer.MovementDescId           AS MovementDescId
                                       , CASE WHEN MIContainer.MovementDescId = zc_Movement_Transport() AND MovementItem.Id IS NULL THEN MIContainer.ObjectId_Analyzer ELSE 0 END AS FuelId
                                       , SUM (CASE WHEN MIContainer.DescId = zc_MIContainer_Count() AND MIContainer.MovementDescId = zc_Movement_Transport() THEN -1 * MIContainer.Amount ELSE 0 END) AS SumCount_Transport
                                       , SUM (CASE WHEN MIContainer.DescId = zc_MIContainer_Summ() AND MIContainer.MovementDescId = zc_Movement_Transport()        AND COALESCE (MIContainer.AnalyzerId, 0) IN (0, zc_Enum_AnalyzerId_ProfitLoss()) THEN -1 * MIContainer.Amount ELSE 0 END) AS SumAmount_Transport
                                       , SUM (CASE WHEN MIContainer.DescId = zc_MIContainer_Summ() AND MIContainer.MovementDescId = zc_Movement_Transport()        AND MIContainer.AnalyzerId = zc_Enum_AnalyzerId_Transport_Add() THEN -1 * MIContainer.Amount ELSE 0 END) AS SumAmount_TransportAdd
                                       , SUM (CASE WHEN MIContainer.DescId = zc_MIContainer_Summ() AND MIContainer.AnalyzerId     = zc_Enum_AnalyzerId_Transport_AddLong() THEN -1 * MIContainer.Amount ELSE 0 END) AS SumAmount_TransportAddLong
                                       , SUM (CASE WHEN MIContainer.DescId = zc_MIContainer_Summ() AND MIContainer.AnalyzerId     = zc_Enum_AnalyzerId_Transport_Taxi()    THEN -1 * MIContainer.Amount ELSE 0 END) AS SumAmount_TransportTaxi
                                       , SUM (CASE WHEN MIContainer.DescId = zc_MIContainer_Summ() AND MIContainer.MovementDescId = zc_Movement_TransportService() AND MIContainer.AnalyzerId = zc_Enum_AnalyzerId_ProfitLoss()    THEN -1 * MIContainer.Amount ELSE 0 END) AS SumAmount_TransportService
                                       , SUM (CASE WHEN MIContainer.DescId = zc_MIContainer_Summ() AND MIContainer.MovementDescId = zc_Movement_TransportService() AND MIContainer.AnalyzerId = zc_Enum_AnalyzerId_Transport_Add() THEN -1 * MIContainer.Amount ELSE 0 END) AS SumAmount_ServiceAdd
                                       , SUM (CASE WHEN MIContainer.DescId = zc_MIContainer_Summ() AND MIContainer.MovementDescId = zc_Movement_PersonalSendCash()         THEN -1 * MIContainer.Amount ELSE 0 END) AS SumAmount_PersonalSendCash
                                       , MIContainer.WhereObjectId_Analyzer          AS CarId
                                       , MIContainer.ObjectIntId_Analyzer            AS UnitId
                                       , MIContainer.ObjectExtId_Analyzer            AS BranchId
                                       , CASE WHEN MIContainer.MovementDescId = zc_Movement_Transport() AND COALESCE (MIContainer.AnalyzerId, 0) NOT IN (zc_Enum_AnalyzerId_Transport_Add(), zc_Enum_AnalyzerId_Transport_AddLong(), zc_Enum_AnalyzerId_Transport_Taxi()) THEN MovementLinkObject_PersonalDriver.ObjectId ELSE MIContainer.ObjectId_Analyzer END AS PersonalDriverId
                                       , COALESCE (MovementItem.ObjectId, MILinkObject_Route.ObjectId)  AS RouteId
                                       , MIContainer.AccountId_Analyzer              AS ProfitLossId
                                       , 0                                           AS BusinessId
                                       -- , MIContainer.AnalyzerId
                                       , TRUE AS isAccount_50000
                               
                                  FROM MovementItemContainer AS MIContainer
                                       INNER JOIN tmpAccount_50000 ON tmpAccount_50000.AccountId = MIContainer.AccountId_Analyzer
                                                          
                                       LEFT JOIN MovementLinkObject AS MovementLinkObject_PersonalDriver
                                                                    ON MovementLinkObject_PersonalDriver.MovementId = MIContainer.MovementId
                                                                   AND MovementLinkObject_PersonalDriver.DescId = zc_MovementLinkObject_PersonalDriver()
         
                                       LEFT JOIN MovementItemLinkObject AS MILinkObject_Route
                                                                        ON MILinkObject_Route.MovementItemId = MIContainer.MovementItemId
                                                                       AND MILinkObject_Route.DescId = zc_MILinkObject_Route()
                                       LEFT JOIN MovementItem ON MovementItem.Id = MIContainer.MovementItemId
                                                             AND MovementItem.DescId = zc_MI_Master()
                                                             AND MIContainer.MovementDescId = zc_Movement_Transport()
                                                      
                                  WHERE MIContainer.OperDate BETWEEN inStartDate AND inEndDate  
                                    AND MIContainer.MovementDescId in (zc_Movement_Transport(), zc_Movement_TransportService(),zc_Movement_PersonalSendCash())
                                    -- AND MIContainer.AnalyzerId = zc_Enum_AnalyzerId_ProfitLoss()
                                    AND (MIContainer.ObjectExtId_Analyzer   = inBranchId   OR inBranchId   = 0) -- ������
                                    AND (MIContainer.ObjectIntId_Analyzer   = inUnitId     OR inUnitId     = 0) -- �������������
                                    AND (MIContainer.WhereObjectId_Analyzer = inCarId      OR inCarId      = 0) -- ����������
                                    AND (                                                     inBusinessId = 0) -- ������  
                                  GROUP BY  MIContainer.MovementId, MIContainer.MovementDescId
                                          , MIContainer.ObjectId_Analyzer
                                          , MIContainer.WhereObjectId_Analyzer 
                                          , MIContainer.ObjectIntId_Analyzer 
                                          , MIContainer.ObjectExtId_Analyzer
                                          , CASE WHEN MIContainer.MovementDescId = zc_Movement_Transport() AND COALESCE (MIContainer.AnalyzerId, 0) NOT IN (zc_Enum_AnalyzerId_Transport_Add(), zc_Enum_AnalyzerId_Transport_AddLong(), zc_Enum_AnalyzerId_Transport_Taxi()) THEN MovementLinkObject_PersonalDriver.ObjectId ELSE MIContainer.ObjectId_Analyzer END
                                          , MILinkObject_Route.ObjectId
                                          , MIContainer.AccountId_Analyzer
                                          , MovementItem.Id
                                          , MovementItem.ObjectId
                            ) AS tmpContainer   
                                 LEFT JOIN MovementItem ON MovementItem.MovementId = tmpContainer.MovementId
                                                       AND MovementItem.ObjectId   = tmpContainer.RouteId
                                                       AND MovementItem.DescId     = zc_MI_Master()
                                                       AND MovementItem.isErased   = FALSE
                                 LEFT JOIN MovementItemFloat AS MIFloat_Distance
                                                             ON MIFloat_Distance.MovementItemId = MovementItem.Id
                                                            AND MIFloat_Distance.DescId = CASE WHEN tmpContainer.MovementDescId = zc_Movement_Transport() THEN zc_MIFloat_DistanceFuelChild()
                                                                                               WHEN tmpContainer.MovementDescId = zc_Movement_TransportService() THEN zc_MIFloat_Distance() END
                                LEFT JOIN MovementItemFloat AS MIFloat_WeightTransport
                                                            ON MIFloat_WeightTransport.MovementItemId = MovementItem.Id
                                                           AND MIFloat_WeightTransport.DescId = zc_MIFloat_Weight()--zc_MIFloat_WeightTransport()
                                GROUP BY tmpContainer.MovementId               
                                       , tmpContainer.MovementDescId           
                                       , tmpContainer.FuelId
                                       , tmpContainer.SumCount_Transport
                                       , tmpContainer.SumAmount_Transport
                                       , tmpContainer.SumAmount_TransportAdd
                                       , tmpContainer.SumAmount_TransportAddLong
                                       , tmpContainer.SumAmount_TransportTaxi
                                       , tmpContainer.SumAmount_TransportService
                                       , tmpContainer.SumAmount_ServiceAdd
                                       , tmpContainer.SumAmount_PersonalSendCash
                                       , tmpContainer.CarId
                                       , tmpContainer.UnitId
                                       , tmpContainer.BranchId
                                       , tmpContainer.PersonalDriverId
                                       , tmpContainer.RouteId
                                       , tmpContainer.ProfitLossId
                                       , tmpContainer.BusinessId
                                       , tmpContainer.isAccount_50000
                          )
        -- �������� ������ ������� �� �������, �������� ���. ������ ������� ������� � �������
        , tmpWeight AS (SELECT MLM_Transport.MovementChildId                  AS MovementTransportId
                             , MLO_Route.ObjectId                             AS RouteId
                             , MovementLinkObject_Car.ObjectId                AS CarId
                             , MovementLinkObject_PersonalDriver.ObjectId     AS PersonalDriverId
                             , MovementFloat_MovementItemId.MovementId        AS MovementId_Sale
                             , MovementLinkObject_To.ObjectId                 AS PartnerId_Sale
                             , SUM (MovemenTFloat_TotalCountKg.ValueData)     AS TotalCountKg
                        FROM MovementLinkMovement AS MLM_Transport
                             JOIN Movement ON Movement.Id = MLM_Transport.MovementId 
                                          AND Movement.DescId = zc_Movement_Reestr()
                                          --AND Movement.OperDate = '21.10.2019'
                                          AND Movement.StatusId <> zc_Enum_Status_Erased()
                             LEFT JOIN MovementItem ON MovementItem.MovementId = Movement.Id
                                                   AND MovementItem.DescId     = zc_MI_Master()
                                                   AND MovementItem.isErased   = FALSE

                             LEFT JOIN MovementFloat AS MovementFloat_MovementItemId
                                                     ON MovementFloat_MovementItemId.ValueData = MovementItem.Id
                                                    AND MovementFloat_MovementItemId.DescId = zc_MovementFloat_MovementItemId()

                             LEFT JOIN MovementLinkObject AS MovementLinkObject_To
                                                          ON MovementLinkObject_To.MovementId = MovementFloat_MovementItemId.MovementId -- ����������
                                                         AND MovementLinkObject_To.DescId = zc_MovementLinkObject_To()
                                                         AND inIsPartner = TRUE

                             LEFT JOIN MovemenTFloat AS MovemenTFloat_TotalCountKg
                                                     ON MovemenTFloat_TotalCountKg.MovementId = MovementFloat_MovementItemId.MovementId
                                                    AND MovemenTFloat_TotalCountKg.DescId = zc_MovemenTFloat_TotalCountKg()

                             LEFT JOIN MovementLinkMovement AS MLM_Order						-- �� ��������� ������ �������� �������
                                                            ON MLM_Order.MovementId = MovementFloat_MovementItemId.MovementId
                                                           AND MLM_Order.DescId = zc_MovementLinkMovement_Order()

                             LEFT JOIN MovementLinkObject AS MLO_Route
                                                          ON MLO_Route.MovementId = MLM_Order.MovementChildId
                                                         AND MLO_Route.DescId = zc_MovementLinkObject_Route()

                             LEFT JOIN MovementLinkObject AS MovementLinkObject_Car
                                                          ON MovementLinkObject_Car.MovementId = Movement.Id
                                                         AND MovementLinkObject_Car.DescId = zc_MovementLinkObject_Car()

                             LEFT JOIN MovementLinkObject AS MovementLinkObject_PersonalDriver
                                                          ON MovementLinkObject_PersonalDriver.MovementId = Movement.Id
                                                         AND MovementLinkObject_PersonalDriver.DescId = zc_MovementLinkObject_PersonalDriver()

                        WHERE MLM_Transport.DescId = zc_MovementLinkMovement_Transport()
                          AND MLM_Transport.MovementChildId in (SELECT tmpContainer.MovementId FROM tmpContainer)
                        GROUP BY MLM_Transport.MovementChildId
                               , MLO_Route.ObjectId   
                               , MovementLinkObject_Car.ObjectId     
                               , MovementLinkObject_PersonalDriver.ObjectId
                               , MovementFloat_MovementItemId.MovementId
                               , MovementLinkObject_To.ObjectId
                       )

        -- ��������� ������ �� ���. ������ �� �������
       , tmpSale_MI AS (SELECT MovementItem.MovementId
                             , CASE WHEN inisGoods = TRUE THEN MovementItem.Id ELSE 0 END AS MI_Id
                             , CASE WHEN inisGoods = TRUE THEN MovementItem.ObjectId ELSE 0 END AS GoodsId
                             , SUM (MovementItem.Amount)    AS Amount
                         FROM (SELECT DISTINCT tmpWeight.MovementId_Sale FROM tmpWeight) AS tmpSale
                              INNER JOIN MovementItem ON MovementItem.MovementId = tmpSale.MovementId_Sale
                                                     AND MovementItem.DescId     = zc_MI_Master()
                                                     AND MovementItem.isErased   = FALSE
                         GROUP BY MovementItem.MovementId
                                , CASE WHEN inisGoods = TRUE THEN MovementItem.Id ELSE 0 END
                                , CASE WHEN inisGoods = TRUE THEN MovementItem.ObjectId ELSE 0 END
                       )
       , tmpMILO_GoodsKind AS (SELECT *
                               FROM MovementItemLinkObject
                               WHERE MovementItemLinkObject.MovementItemId IN (SELECT DISTINCT tmpSale_MI.MI_Id FROM tmpSale_MI)
                                 AND MovementItemLinkObject.DescId = zc_MILinkObject_GoodsKind()
                                 AND inisGoods = TRUE
                              )

        , tmpSale_Goods AS (SELECT tmpSale_MI.MovementId
                                 , tmpSale_MI.GoodsId
                                 , COALESCE (MILinkObject_GoodsKind.ObjectId, 0) AS GoodsKindId
                                 , SUM (tmpSale_MI.Amount) AS Amount
                            FROM tmpSale_MI
                                 LEFT JOIN tmpMILO_GoodsKind AS MILinkObject_GoodsKind
                                                             ON MILinkObject_GoodsKind.MovementItemId = tmpSale_MI.MI_Id
                                                            AND MILinkObject_GoodsKind.DescId = zc_MILinkObject_GoodsKind()
                            GROUP BY tmpSale_MI.MovementId
                                   , tmpSale_MI.GoodsId
                                   , COALESCE (MILinkObject_GoodsKind.ObjectId, 0)
                             )

        , tmpWeight_All AS (SELECT tmpWeight.MovementTransportId 
                                 , tmpWeight.TotalCountKg
                                 , COALESCE (tmpContainer.CarId, tmpWeight.CarId) AS CarId
                                 , tmpContainer.FuelId
                                 , tmpContainer.UnitId
                                 , tmpContainer.BranchId
                                 , COALESCE (tmpContainer.PersonalDriverId, tmpWeight.PersonalDriverId) AS PersonalDriverId
                                 , tmpContainer.RouteId --tmpWeight.RouteId
                                 , tmpContainer.ProfitLossId
                                 , tmpContainer.BusinessId
                                 , tmpContainer.isAccount_50000
                                 , tmpWeight.PartnerId_Sale
                                 , tmpWeight.MovementId_Sale
                            FROM tmpWeight
                                 LEFT JOIN tmpContainer ON tmpContainer.MovementId = tmpWeight.MovementTransportId
                                                       --AND tmpContainer.RouteId    = tmpWeight.RouteId 
                            )
                            

        , tmpUnion AS (SELECT tmpAll.MovementId
                            , tmpAll.CarId
                            , tmpAll.FuelId
                            , tmpAll.UnitId
                            , tmpAll.BranchId
                            , tmpAll.PersonalDriverId
                            , tmpAll.RouteId
                            , tmpAll.ProfitLossId
                            , tmpAll.BusinessId
                            , tmpAll.isAccount_50000
                            , SUM(tmpAll.WeightSale)                 AS WeightSale
                            , SUM(tmpAll.SumCount_Transport)         AS SumCount_Transport
                            , SUM(tmpAll.SumAmount_Transport)        AS SumAmount_Transport
                            , SUM(tmpAll.SumAmount_TransportAdd)     AS SumAmount_TransportAdd
                            , SUM(tmpAll.SumAmount_TransportAddLong) AS SumAmount_TransportAddLong
                            , SUM(tmpAll.SumAmount_TransportTaxi)    AS SumAmount_TransportTaxi
                            , SUM(tmpAll.SumAmount_TransportService) AS SumAmount_TransportService
                            , SUM(tmpAll.SumAmount_ServiceAdd)       AS SumAmount_ServiceAdd
                            , SUM(tmpAll.SumAmount_PersonalSendCash) AS SumAmount_PersonalSendCash
                            , SUM(tmpAll.Distance)        AS Distance
                            , SUM(tmpAll.WeightTransport) AS WeightTransport
                            , tmpAll.MovementId_Sale
                            , tmpAll.PartnerId_Sale
        
                       FROM ( SELECT tmpContainer.MovementId
                                   , tmpContainer.CarId
                                   , tmpContainer.FuelId
                                   , tmpContainer.UnitId
                                   , tmpContainer.BranchId
                                   , tmpContainer.PersonalDriverId
                                   , tmpContainer.RouteId
                                   , tmpContainer.ProfitLossId
                                   , tmpContainer.BusinessId
                                   , tmpContainer.isAccount_50000
                                   , 0           AS WeightSale
                                   , tmpContainer.SumCount_Transport
                                   , tmpContainer.SumAmount_Transport
                                   , tmpContainer.SumAmount_TransportAdd
                                   , tmpContainer.SumAmount_TransportAddLong
                                   , tmpContainer.SumAmount_TransportTaxi
                                   , tmpContainer.SumAmount_TransportService
                                   , tmpContainer.SumAmount_ServiceAdd
                                   , tmpContainer.SumAmount_PersonalSendCash
                                   , tmpContainer.Distance
                                   , tmpContainer.WeightTransport
                                   , 0 AS MovementId_Sale
                                   , 0 AS PartnerId_Sale
 
                              FROM tmpContainer
                             UNION ALL
                              SELECT tmpWeight_All.MovementTransportId AS MovementId
                                   , tmpWeight_All.CarId
                                   , tmpWeight_All.FuelId
                                   , tmpWeight_All.UnitId
                                   , tmpWeight_All.BranchId
                                   , tmpWeight_All.PersonalDriverId
                                   , tmpWeight_All.RouteId
                                   , tmpWeight_All.ProfitLossId
                                   , tmpWeight_All.BusinessId
                                   , tmpWeight_All.isAccount_50000
                                   , tmpWeight_All.TotalCountKg AS WeightSale
                                   , 0 AS SumCount_Transport
                                   , 0 AS SumAmount_Transport
                                   , 0 AS SumAmount_TransportAdd
                                   , 0 AS SumAmount_TransportAddLong
                                   , 0 AS SumAmount_TransportTaxi
                                   , 0 AS SumAmount_TransportService
                                   , 0 AS SumAmount_ServiceAdd
                                   , 0 AS SumAmount_PersonalSendCash
                                   , 0 AS Distance
                                   , 0 AS WeightTransport
                                   , tmpWeight_All.MovementId_Sale
                                   , tmpWeight_All.PartnerId_Sale

                              FROM tmpWeight_All
                             ) AS tmpAll

                       GROUP BY tmpAll.MovementId
                              , tmpAll.CarId
                              , tmpAll.FuelId
                              , tmpAll.UnitId
                              , tmpAll.BranchId
                              , tmpAll.PersonalDriverId
                              , tmpAll.RouteId
                              , tmpAll.ProfitLossId
                              , tmpAll.BusinessId
                              , tmpAll.isAccount_50000
                              , tmpAll.MovementId_Sale
                              , tmpAll.PartnerId_Sale
                       )


       -- ���������
       SELECT COALESCE (Movement.Invnumber, '') :: TVarChar          AS Invnumber
            , COALESCE (Movement.OperDate, CAST (NULL as TDateTime)) AS OperDate
            , COALESCE (MovementDesc.ItemName, '') :: TVarChar       AS MovementDescName
            , COALESCE (Object_Fuel.ValueData, Object_FuelMaster.ValueData)    :: TVarChar         AS FuelName
            , Object_CarModel.ValueData        AS CarModelName
            , Object_Car.ValueData             AS CarName
           
            , Object_Route.ValueData           AS RouteName
            , Object_PersonalDriver.ValueData  AS PersonalDriverName
            , Object_Unit_View.Name            AS UnitName
            , Object_Unit_View.BranchName
            , Object_Business.ValueData        AS BusinessName 
            , COALESCE (View_ProfitLoss.ProfitLossGroupName, View_Account.AccountGroupName)         :: TVarChar AS ProfitLossGroupName
            , COALESCE (View_ProfitLoss.ProfitLossDirectionName, View_Account.AccountDirectionName) :: TVarChar AS ProfitLossDirectionName
            , COALESCE (View_ProfitLoss.ProfitLossName, View_Account.AccountName)                   :: TVarChar AS ProfitLossName
            , COALESCE (View_ProfitLoss.ProfitLossName_all, View_Account.AccountName_all)           :: TVarChar AS ProfitLossName_all
                        
            , SUM (tmpUnion.SumCount_Transport)         :: TFloat  AS SumCount_Transport 
            , SUM (tmpUnion.SumAmount_Transport)        :: TFloat  AS SumAmount_Transport
            , CASE WHEN SUM (tmpUnion.SumCount_Transport)<>0 THEN CAST (SUM (tmpUnion.SumAmount_Transport)/SUM (tmpUnion.SumCount_Transport) AS NUMERIC (16, 4)) ELSE 0 END :: TFloat AS PriceFuel
            , SUM (tmpUnion.SumAmount_TransportAdd)     :: TFloat AS SumAmount_TransportAdd
            , SUM (tmpUnion.SumAmount_TransportAddLong) :: TFloat AS SumAmount_TransportAddLong
            , SUM (tmpUnion.SumAmount_TransportTaxi)    :: TFloat AS SumAmount_TransportTaxi
            , SUM (tmpUnion.SumAmount_TransportService) :: TFloat AS SumAmount_TransportService
            , SUM (tmpUnion.SumAmount_ServiceAdd)       :: TFloat AS SumAmount_ServiceAdd
            , SUM (tmpUnion.SumAmount_TransportService + tmpUnion.SumAmount_ServiceAdd) :: TFloat AS SumAmount_ServiceTotal
            , SUM (tmpUnion.SumAmount_PersonalSendCash) :: TFloat AS SumAmount_PersonalSendCash
            , SUM (tmpUnion.SumAmount_Transport + tmpUnion.SumAmount_TransportAdd + tmpUnion.SumAmount_TransportAddLong + tmpUnion.SumAmount_TransportTaxi + tmpUnion.SumAmount_TransportService + tmpUnion.SumAmount_ServiceAdd + tmpUnion.SumAmount_PersonalSendCash) :: TFloat AS SumTotal

            , SUM (tmpUnion.Distance):: TFloat         AS Distance
            , SUM (tmpUnion.WeightTransport):: TFloat  AS WeightTransport
            , SUM (tmpUnion.WeightSale):: TFloat       AS WeightSale
            , CAST (CASE WHEN SUM (tmpUnion.Distance) <> 0 THEN  SUM (tmpUnion.SumAmount_Transport + tmpUnion.SumAmount_TransportAdd + tmpUnion.SumAmount_TransportAddLong + tmpUnion.SumAmount_TransportTaxi + tmpUnion.SumAmount_TransportService + tmpUnion.SumAmount_ServiceAdd + tmpUnion.SumAmount_PersonalSendCash) / SUM (tmpUnion.Distance) 

                         ELSE 0 END  AS TFloat)  AS One_KM
            , CAST (CASE WHEN SUM (tmpUnion.WeightTransport) <> 0 THEN  SUM (tmpUnion.SumAmount_Transport + tmpUnion.SumAmount_TransportAdd + tmpUnion.SumAmount_TransportAddLong + tmpUnion.SumAmount_TransportTaxi + tmpUnion.SumAmount_TransportService + tmpUnion.SumAmount_ServiceAdd + tmpUnion.SumAmount_PersonalSendCash) /SUM (tmpUnion.WeightTransport)
                         ELSE 0 END AS TFloat)  AS One_KG
            , tmpUnion.isAccount_50000 :: Boolean AS isAccount_50000
            
            , Movemen_Sale.Id            AS MovemenId_Sale
            , Movemen_Sale.OperDate      AS OperDate_Sale
            , Movemen_Sale.Invnumber     AS Invnumber_Sale

            , Object_Goods.Id            AS GoodsId
            , Object_Goods.ObjectCode    AS GoodsCode
            , Object_Goods.ValueData     AS GoodsName

            , Object_GoodsKind.Id         AS GoodsKindId
            , Object_GoodsKind.ValueData  AS GoodsKindName
            , SUM (tmpSale_Goods.Amount)  ::TFloat AS Amount_Sale
      FROM tmpUnion
                 LEFT JOIN Object AS Object_Route on Object_Route.Id = tmpUnion.RouteId
                 LEFT JOIN Object_Unit_View  on Object_Unit_View.Id = tmpUnion.UnitId
                 LEFT JOIN Object AS Object_PersonalDriver on Object_PersonalDriver.Id = tmpUnion.PersonalDriverId
                 LEFT JOIN Object AS Object_Fuel ON Object_Fuel.Id = tmpUnion.FuelId

                 LEFT JOIN Object AS Object_Car ON Object_Car.Id = tmpUnion.CarId

                 LEFT JOIN ObjectLink AS ObjectLink_Car_FuelMaster 
                                      ON ObjectLink_Car_FuelMaster.ObjectId = Object_Car.Id
                                     AND ObjectLink_Car_FuelMaster.DescId = zc_ObjectLink_Car_FuelMaster()
                 LEFT JOIN Object AS Object_FuelMaster ON Object_FuelMaster.Id = ObjectLink_Car_FuelMaster.ChildObjectId
 
                 LEFT JOIN Movement ON Movement.Id = tmpUnion.MovementId
                                   AND inisMovement = TRUE 
                                   
                 LEFT JOIN MovementDesc ON MovementDesc.Id = Movement.DescId                
                 LEFT JOIN ObjectLink AS ObjectLink_Car_CarModel ON ObjectLink_Car_CarModel.ObjectId = Object_Car.Id
                                                            AND ObjectLink_Car_CarModel.DescId = zc_ObjectLink_Car_CarModel()
                 LEFT JOIN Object                 AS Object_CarModel ON Object_CarModel.Id           = ObjectLink_Car_CarModel.ChildObjectId
                 LEFT JOIN Object_ProfitLoss_View AS View_ProfitLoss ON View_ProfitLoss.ProfitLossId = tmpUnion.ProfitLossId
                 LEFT JOIN Object_Account_View    AS View_Account    ON View_Account.AccountId       = tmpUnion.ProfitLossId
                 LEFT JOIN Object                 AS Object_Business ON Object_Business.Id           = tmpUnion.BusinessId

                 LEFT JOIN Object AS Object_Partner ON Object_Partner.Id           = tmpUnion.PartnerId_Sale
                 LEFT JOIN Movement AS Movemen_Sale
                                    ON Movemen_Sale.Id = tmpUnion.MovementId_Sale
                                   AND inisMovement = TRUE 
                 LEFT JOIN tmpSale_Goods ON tmpSale_Goods.MovementId = Movemen_Sale.Id

                 LEFT JOIN Object AS Object_Goods     ON Object_Goods.Id     = tmpSale_Goods.GoodsId
                 LEFT JOIN Object AS Object_GoodsKind ON Object_GoodsKind.Id = tmpSale_Goods.GoodsKindId

       GROUP BY COALESCE (Movement.Invnumber, '') , COALESCE (MovementDesc.ItemName, '')
              , COALESCE (Movement.OperDate, CAST (NULL as TDateTime))
              , Object_Fuel.ValueData 
              , Object_FuelMaster.ValueData
              , Object_Car.ValueData 
              , Object_Unit_View.Name
              , Object_Unit_View.BusinessName 
              , Object_Unit_View.BranchName
              , Object_Route.ValueData 
              , Object_PersonalDriver.ValueData
              , Object_CarModel.ValueData
              , Object_Business.ValueData 
              , COALESCE (View_ProfitLoss.ProfitLossGroupName, View_Account.AccountGroupName)
              , COALESCE (View_ProfitLoss.ProfitLossDirectionName, View_Account.AccountDirectionName)
              , COALESCE (View_ProfitLoss.ProfitLossName, View_Account.AccountName)
              , COALESCE (View_ProfitLoss.ProfitLossName_all, View_Account.AccountName_all)
              , tmpUnion.isAccount_50000

            , Movemen_Sale.Id
            , Movemen_Sale.OperDate
            , Movemen_Sale.Invnumber
            , Object_Goods.Id
            , Object_Goods.ObjectCode
            , Object_Goods.ValueData
            , Object_GoodsKind.Id
            , Object_GoodsKind.ValueData

       ORDER BY Object_Unit_View.BusinessName
              , Object_Unit_View.BranchName
              , Object_Unit_View.Name
              , COALESCE (Movement.Invnumber, '') 
              , COALESCE (Movement.OperDate, CAST (NULL as TDateTime))
              , Object_Car.ValueData 
              , Object_Fuel.ValueData 
              , Object_Route.ValueData 
  ;
         
END;
$BODY$
  LANGUAGE plpgsql VOLATILE;

/*-------------------------------------------------------------------------------
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.
 22.10.19         * 
*/

-- ����
-- select * from gpReport_Transport_Cost  (inStartDate := ('01.10.2019')::TDateTime , inEndDate := ('02.10.2019')::TDateTime , inBusinessId := 0 , inBranchId := 0 , inUnitId := 0, inCarId := 1200072  , inIsMovement := False ,  inIsPartner:=False, inIsGoods:= False, inSession := '5');