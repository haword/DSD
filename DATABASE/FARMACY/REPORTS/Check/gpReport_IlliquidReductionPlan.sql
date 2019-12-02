-- Function: gpReport_IlliquidReductionPlan()

DROP FUNCTION IF EXISTS gpReport_IlliquidReductionPlan (Integer, TDateTime, TVarChar);

CREATE OR REPLACE FUNCTION gpReport_IlliquidReductionPlan(
    IN inUserId         Integer,    -- Сотрудни
    IN inStartDate      TDateTime , -- Дата в месяце
    IN inNotSalePastDay Integer ,   -- Дата в месяце
    IN inProcGoods      TFloat ,    -- Дата в месяце
    IN inProcUnit       TFloat ,    -- Дата в месяце
    IN inSession        TVarChar    -- сессия пользователя
)
RETURNS SETOF refcursor
AS
$BODY$
   DECLARE vbUserId Integer;
   DECLARE vbUnitId Integer;
   DECLARE cur1 refcursor;
   DECLARE cur2 refcursor;
   DECLARE vbDateStart TDateTime;
   DECLARE vbDateEnd TDateTime;
BEGIN
     -- проверка прав пользователя на вызов процедуры
     -- PERFORM lpCheckRight (inSession, zc_Enum_Process_Select_Movement_OrderInternal());

    vbDateStart := date_trunc('month', inStartDate);
    vbDateEnd := date_trunc('month', vbDateStart + INTERVAL '1 month');
    vbUserId := lpGetUserBySession (inSession);

    IF (inUserId <> vbUserId) AND
       NOT EXISTS (SELECT 1
             FROM ObjectLink AS Object_UserRole_User -- Связь пользователя с объектом роли пользователя
                      JOIN ObjectLink AS Object_UserRole_Role -- Связь ролей с объектом роли пользователя
                                      ON Object_UserRole_Role.DescId = zc_ObjectLink_UserRole_Role()
                                     AND Object_UserRole_Role.ObjectId = Object_UserRole_User.ObjectId
                                     AND Object_UserRole_Role.ChildObjectId = zc_Enum_Role_Admin()
             WHERE Object_UserRole_User.DescId = zc_ObjectLink_UserRole_User()
               AND Object_UserRole_User.ChildObjectId = lpGetUserBySession (inSession)) AND
       NOT EXISTS (SELECT 1
                 FROM ObjectLink AS Object_UserRole_User -- Связь пользователя с объектом роли пользователя
                      JOIN ObjectLink AS Object_UserRole_Role -- Связь ролей с объектом роли пользователя
                                      ON Object_UserRole_Role.DescId = zc_ObjectLink_UserRole_Role()
                                     AND Object_UserRole_Role.ObjectId = Object_UserRole_User.ObjectId
                      JOIN ObjectLink AS RoleRight_Role -- Связь роли с объектом процессы ролей
                                      ON RoleRight_Role.ChildObjectId = Object_UserRole_Role.ChildObjectId
                                     AND RoleRight_Role.DescId = zc_ObjectLink_RoleRight_Role()
                      JOIN ObjectLink AS RoleRight_Process -- Связь процесса с объектом процессы ролей
                                      ON RoleRight_Process.ObjectId = RoleRight_Role.ObjectId
                                     AND RoleRight_Process.DescId = zc_ObjectLink_RoleRight_Process()
                                     AND RoleRight_Process.ChildObjectId = zc_Enum_Process_InsertUpdate_Object_Member()
                 WHERE Object_UserRole_User.DescId = zc_ObjectLink_UserRole_User()
                   AND Object_UserRole_User.ChildObjectId = lpGetUserBySession (inSession))
    THEN
         RAISE EXCEPTION 'Отчет можно запускать только свой.';
    END IF;


      -- Мовементы по сотруднику
    CREATE TEMP TABLE tmpMovement (
            MovementID         Integer,

            OperDate           TDateTime,
            UnitID             Integer,
            ConfirmedKind      Boolean

      ) ON COMMIT DROP;

       -- Добовляем простые продажи
    INSERT INTO tmpMovement
    SELECT
           Movement.ID                                      AS ID
         , date_trunc('day', MovementDate_Insert.ValueData) AS OperDate
         , MovementLinkObject_Unit.ObjectId                 AS UnitId
         , False                                            AS ConfirmedKind
    FROM Movement

          INNER JOIN MovementLinkObject AS MovementLinkObject_Insert
                                        ON MovementLinkObject_Insert.MovementId = Movement.Id
                                       AND MovementLinkObject_Insert.DescId = zc_MovementLinkObject_Insert()

          INNER JOIN MovementDate AS MovementDate_Insert
                                  ON MovementDate_Insert.MovementId = Movement.Id
                                 AND MovementDate_Insert.DescId = zc_MovementDate_Insert()

          INNER JOIN MovementLinkObject AS MovementLinkObject_Unit
                                        ON MovementLinkObject_Unit.MovementId = Movement.Id
                                       AND MovementLinkObject_Unit.DescId = zc_MovementLinkObject_Unit()

    WHERE /*MovementDate_Insert.ValueData >= vbDateStart
      AND MovementDate_Insert.ValueData < vbDateEnd*/
          Movement.OperDate >= vbDateStart
      AND Movement.OperDate < vbDateEnd
      AND MovementLinkObject_Insert.ObjectId = inUserId
      AND Movement.DescId = zc_Movement_Check()
      AND Movement.StatusId = zc_Enum_Status_Complete();

      -- Добовляем отборы
    INSERT INTO tmpMovement
    SELECT
           Movement.ID                           AS ID
         , date_trunc('day', Movement.OperDate)  AS OperDate
         , MovementLinkObject_Unit.ObjectId      AS UnitId
         , True                                  AS ConfirmedKind
    FROM Movement

          INNER JOIN MovementLinkObject AS MovementLinkObject_UserConfirmedKind
                                        ON MovementLinkObject_UserConfirmedKind.MovementId = Movement.Id
                                       AND MovementLinkObject_UserConfirmedKind.DescId = zc_MovementLinkObject_UserConfirmedKind()

          INNER JOIN MovementLinkObject AS MovementLinkObject_Unit
                                        ON MovementLinkObject_Unit.MovementId = Movement.Id
                                       AND MovementLinkObject_Unit.DescId = zc_MovementLinkObject_Unit()

          LEFT JOIN MovementLinkObject AS MovementLinkObject_Insert
                                        ON MovementLinkObject_Insert.MovementId = Movement.Id
                                       AND MovementLinkObject_Insert.DescId = zc_MovementLinkObject_Insert()
    WHERE Movement.OperDate >= vbDateStart
      AND Movement.OperDate < vbDateEnd
      AND MovementLinkObject_UserConfirmedKind.ObjectId = inUserId
      AND MovementLinkObject_Insert.ObjectId IS NULL
      AND Movement.DescId = zc_Movement_Check()
      AND Movement.StatusId = zc_Enum_Status_Complete();

    ANALYSE tmpMovement;

--raise notice 'Value 03: %', (SELECT count(*) FROM tmpMovement);

    IF inUserId = vbUserId
    THEN

      IF NOT EXISTS(SELECT * FROM tmpMovement)
      THEN
           RAISE EXCEPTION 'По вам ненайдены чеки.';
      END IF;
    ELSE

      IF NOT EXISTS(SELECT * FROM tmpMovement)
      THEN
           RAISE EXCEPTION 'По сотруднику не найдены чеки.';
      END IF;
    END IF;

    WITH tmpCount AS (SELECT tmpMovement.UnitId
                           , count(*) AS CountCheck
                      FROM tmpMovement
                      GROUP BY tmpMovement.UnitId)
    SELECT tmpCount.UnitId
    INTO vbUnitId
    FROM tmpCount
    ORDER BY tmpCount.CountCheck DESC
    LIMIT 1;

      -- Товары без продаж
    CREATE TEMP TABLE tmpGoods (
            GoodsID         Integer,
            Remains         TFloat
      ) ON COMMIT DROP;

    WITH tmpContainer AS (SELECT AnalysisContainer.UnitID         AS UnitID
                               , AnalysisContainer.GoodsID        AS GoodsID
                               , SUM(AnalysisContainer.Saldo)     AS Saldo
                          FROM AnalysisContainer
                          WHERE AnalysisContainer.UnitID = vbUnitId
                          GROUP BY AnalysisContainer.UnitID, AnalysisContainer.GoodsID
                         )
       , tmpMovementItemContainer AS (SELECT AnalysisContainerItem.UnitID                                 AS UnitID
                                           , AnalysisContainerItem.GoodsID                                AS GoodsID
                                           , SUM(AnalysisContainerItem.Saldo)                             AS SaldoIn
                                           , SUM(CASE WHEN AnalysisContainerItem.OperDate >= vbDateStart
                                                      THEN AnalysisContainerItem.Saldo END)               AS Saldo
                                           , SUM(CASE WHEN AnalysisContainerItem.OperDate < vbDateStart
                                                      THEN AnalysisContainerItem.AmountCheck END)         AS Check
                                      FROM AnalysisContainerItem
                                      WHERE AnalysisContainerItem.OperDate >= vbDateStart - (inNotSalePastDay||' DAY')::INTERVAL 
                                        AND AnalysisContainerItem.UnitID = vbUnitId
                                      GROUP BY AnalysisContainerItem.UnitID, AnalysisContainerItem.GoodsID)
       , tmpRemains AS (SELECT Container.UnitID
                             , Container.GoodsID
                             , Container.Saldo - COALESCE(MovementItemContainer.Saldo, 0) AS Remains
                        FROM tmpContainer AS Container
                             LEFT JOIN tmpMovementItemContainer AS MovementItemContainer
                                                                ON MovementItemContainer.UnitID = Container.UnitID
                                                               AND MovementItemContainer.GoodsID = Container.GoodsID
                        WHERE (Container.Saldo - COALESCE(MovementItemContainer.Saldo, 0)) > 0
                          AND (Container.Saldo - COALESCE(MovementItemContainer.SaldoIn, 0)) > 0
                          AND COALESCE(MovementItemContainer.Check, 0) = 0)

    INSERT INTO tmpGoods
    SELECT
           Container.GoodsID         AS GoodsId
         , Container.Remains::TFloat AS Remains
    FROM tmpRemains AS Container;

    CREATE TEMP TABLE tmpImplementation (
             GoodsId Integer,
             Amount TFloat
      ) ON COMMIT DROP;

    -- Заполняем данные по продажам
    INSERT INTO tmpImplementation
    SELECT tmpGoods.GoodsId                          AS GoodsId
         , Sum(-1 * MIC.Amount)::TFloat              AS Amount
    FROM tmpGoods

         INNER JOIN MovementItemContainer AS MIC
                                          ON MIC.ObjectId_Analyzer = tmpGoods.GoodsId
                                         AND MIC.OperDate >= vbDateStart
                                         AND MIC.OperDate < vbDateEnd
                                         AND MIC.MovementDescId = zc_Movement_Check()
                                         AND MIC.DescId = zc_MIContainer_Count()

         INNER JOIN tmpMovement ON tmpMovement.MovementId = MIC.MovementId

    GROUP BY tmpGoods.GoodsId
    HAVING Sum(-1 * MIC.Amount)::TFloat > 0;

--raise notice 'Value 03: %', (SELECT count(*) FROM tmpImplementation);
/*    SELECT MovementItem.ObjectId                         AS GoodsId
         , Sum(MovementItem.Amount)::TFloat              AS Amount
    FROM tmpMovement

         INNER JOIN MovementItem AS MovementItem
                                 ON MovementItem.MovementId = tmpMovement.MovementID
                                AND MovementItem.isErased   = FALSE
                                AND MovementItem.DescId     = zc_MI_Master()

         INNER JOIN tmpGoods ON tmpGoods.GoodsId = MovementItem.ObjectId

    GROUP BY MovementItem.ObjectId
    HAVING Sum(MovementItem.Amount)::TFloat > 0;
*/
       -- Вывод результата
     OPEN cur1 FOR SELECT tmpGoods.GoodsId
                        , Object_Goods_Main.ObjectCode AS GoodsCode
                        , Object_Goods_Main.Name       AS GoodsName
                        , tmpGoods.Remains             AS AmountStart
                        , tmpImplementation.Amount     AS AmountSale
                        , CASE WHEN COALESCE(tmpGoods.Remains, 0) = 0 THEN 100
                               ELSE COALESCE(tmpImplementation.Amount, 0) / tmpGoods.Remains * 100 END ::TFloat AS ProcSale
                        , CASE WHEN COALESCE(tmpImplementation.Amount, 0) < 1 OR
                                    CASE WHEN COALESCE(tmpGoods.Remains, 0) = 0 THEN 100
                                         ELSE COALESCE(tmpImplementation.Amount, 0) / tmpGoods.Remains * 100 END < inProcGoods
                               THEN 16440317 ELSE zc_Color_GreenL() END AS Color_calc
                   FROM tmpGoods
                        LEFT JOIN Object_Goods_Retail ON Object_Goods_Retail.ID = tmpGoods.GoodsId
                        LEFT JOIN Object_Goods_Main ON Object_Goods_Main.ID = Object_Goods_Retail.GoodsMainId
                        LEFT JOIN tmpImplementation ON tmpImplementation.GoodsId = tmpGoods.GoodsId
                   ORDER BY Object_Goods_Main.ObjectCode;
     RETURN NEXT cur1;

     OPEN cur2 FOR SELECT 1::Integer             AS ID
                        , COUNT(*)::Integer      AS AmountStart
                        , SUM(CASE WHEN COALESCE(tmpImplementation.Amount, 0) < 1 OR
                                    CASE WHEN COALESCE(tmpGoods.Remains, 0) = 0 THEN 100
                                         ELSE COALESCE(tmpImplementation.Amount, 0) / tmpGoods.Remains * 100 END < inProcGoods
                               THEN 0 ELSE 1 END)::Integer AS AmountSale
                        , CASE WHEN COUNT(*) = 0 THEN 100.0
                               ELSE 1.0 *SUM(CASE WHEN COALESCE(tmpImplementation.Amount, 0) < 1 OR
                                        CASE WHEN COALESCE(tmpGoods.Remains, 0) = 0 THEN 100
                                        ELSE COALESCE(tmpImplementation.Amount, 0) / tmpGoods.Remains * 100 END < inProcGoods
                               THEN 0.0 ELSE 1.0 END) / COUNT(*)::TFloat * 100.0 END::TFloat  AS ProcSale
                        , CASE WHEN CASE WHEN COUNT(*) = 0 THEN 100
                                         ELSE 1.0 *SUM(CASE WHEN COALESCE(tmpImplementation.Amount, 0) < 1 OR
                                                  CASE WHEN COALESCE(tmpGoods.Remains, 0) = 0 THEN 100.0
                                                  ELSE COALESCE(tmpImplementation.Amount, 0) / tmpGoods.Remains * 100 END < inProcGoods
                               THEN 0.0 ELSE 1.0 END) / COUNT(*)::TFloat * 100.0 END < inProcUnit
                               THEN 16440317 ELSE zc_Color_GreenL() END::TFloat AS Color_calc
                   FROM tmpGoods
                        LEFT JOIN Object_Goods_Retail ON Object_Goods_Retail.ID = tmpGoods.GoodsId
                        LEFT JOIN Object_Goods_Main ON Object_Goods_Main.ID = Object_Goods_Retail.GoodsMainId
                        LEFT JOIN tmpImplementation ON tmpImplementation.GoodsId = tmpGoods.GoodsId
                   ;
     RETURN NEXT cur2;

END;
$BODY$
  LANGUAGE PLPGSQL VOLATILE;

/*
 ИСТОРИЯ РАЗРАБОТКИ: ДАТА, АВТОР
               Фелонюк И.В.   Кухтин И.В.   Климентьев К.И.   Шаблий О.В.
 27.10.19         *
*/

-- тест select * from gpReport_IlliquidReductionPlan(inUserId := 3998962 , inStartDate := ('27.11.2019')::TDateTime ,  inSession := '3');