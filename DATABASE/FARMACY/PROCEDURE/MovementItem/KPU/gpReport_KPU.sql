-- Function: gpReport_KPU()

DROP FUNCTION IF EXISTS gpReport_KPU (TDateTime, Boolean, TVarChar);

CREATE OR REPLACE FUNCTION gpReport_KPU(
    IN inStartDate     TDateTime , -- Дата в месяце
    IN inRecount       Boolean ,   -- Пересчитать данные
    IN inSession       TVarChar    -- сессия пользователя
)
RETURNS TABLE (
  ID                 Integer,
  UserID             Integer,
  UserCode           Integer,
  UserName           TVarChar,

  PositionName       TVarChar,
  DateIn             TDateTime,

  UnitID             Integer,
  UnitCode           Integer,
  UnitName           TVarChar,

  KPU                TFloat,

  FactOfManDays      Integer,
  AmountTheFineTab   TFloat,
  BonusAmountTab     TFloat,
  MarkRatio          Integer,

  PrevAverageCheck   TFloat,
  AverageCheck       TFloat,
  AverageCheckRatio  TFloat,

  LateTimeRatio      Integer,

  FinancPlan         TFloat,
  FinancPlanFact     TFloat,
  FinancPlanRatio    Integer,

  CorrectAnswers     Integer,
  ExamPercentage     TFloat,
  NumberAttempts     Integer,
  ExamResult         TVarChar,
  IT_ExamRatio       Integer,

  ComplaintsRatio    Integer,
  ComplaintsNote     TVarChar,

  DirectorRatio      Integer,
  DirectorNote       TVarChar,

  YuriIT             Integer,
  OlegIT             Integer,
  MaximIT            Integer,
  CollegeITRatio     Integer,
  CollegeITNote      TVarChar,

  VIPDepartRatio     Integer,
  VIPDepartRatioNote TVarChar,

  Romanova           Integer,
  Golovko            Integer,
  ControlRGRatio     Integer,
  ControlRGNote      TVarChar
)
AS
$BODY$
   DECLARE vbDateStart TDateTime;
   DECLARE vbEndDate TDateTime;
   DECLARE vbMovementID Integer;
   DECLARE vbMovementItemID Integer;
BEGIN
     -- проверка прав пользователя на вызов процедуры
     -- PERFORM lpCheckRight (inSession, zc_Enum_Process_Select_Movement_OrderInternal());


  vbDateStart := date_trunc('month', inStartDate);
  vbEndDate := date_trunc('month', inStartDate) + Interval '1 MONTH';

  IF vbDateStart >= date_trunc('month', CURRENT_TIMESTAMP)
  THEN
     RAISE EXCEPTION 'Ошибка. Запускать отчет можно толькуо после окончания месяца.';
  END IF;

  IF vbDateStart < ('01.07.2018')::TDateTime
  THEN
     RAISE EXCEPTION 'Ошибка. Запускать отчет можно датой не ранее 01.09.2018.';
  END IF;

  IF (inRecount = True) OR NOT EXISTS(SELECT 1 FROM Movement WHERE OperDate = vbDateStart AND DescId = zc_Movement_KPU())
  THEN
    CREATE TEMP TABLE tmpImplementationPlan (
            UserID             Integer,
            UserName           TVarChar,

            UnitID             Integer,
            UnitName           TVarChar,

            FactOfManDays      Integer,

            AmountTheFineTab   TFloat,
            BonusAmountTab     TFloat,

            PrevAverageCheck   TFloat,
            AverageCheck       TFloat

      ) ON COMMIT DROP;

    INSERT INTO tmpImplementationPlan
    SELECT
            T.UserID
          , T.UserName
          , T.UnitID
          , T.UnitName
          , T.FactOfManDays
          , T.AmountTheFineTab
          , T.BonusAmountTab
    FROM gpReport_ImplementationPlanEmployeeAll (vbDateStart, inSession) AS T;


      -- Средний чек за прошлый месяц
    UPDATE tmpImplementationPlan SET PrevAverageCheck = ROUND(T1.Average *
      CASE date_part('month', vbDateStart - INTERVAL '1 month')
           WHEN 1 THEN 0.98
           WHEN 2 THEN 1.07
           WHEN 3 THEN 1.07
           WHEN 4 THEN 0.99
           WHEN 5 THEN 0.94
           WHEN 6 THEN 0.96
           WHEN 7 THEN 1.01
           WHEN 8 THEN 0.99
           WHEN 9 THEN 1.07
           WHEN 10 THEN 1.09
           WHEN 11 THEN 1.06
           WHEN 12 THEN 1.04 END, 2)
    FROM (SELECT
                 MovementLinkObject_Insert.ObjectId                   AS UserId
               , SUM(MovementFloat_TotalSumm.ValueData) / Count(*)    AS Average
      FROM Movement


            LEFT JOIN MovementLinkObject AS MovementLinkObject_Unit
                                         ON MovementLinkObject_Unit.MovementId = Movement.Id
                                        AND MovementLinkObject_Unit.DescId = zc_MovementLinkObject_Unit()


            LEFT JOIN MovementLinkObject AS MovementLinkObject_Insert
                                         ON MovementLinkObject_Insert.MovementId = Movement.Id
                                        AND MovementLinkObject_Insert.DescId = zc_movementlinkobject_insert()

            LEFT JOIN MovementDate AS MovementDate_Insert
                                   ON MovementDate_Insert.MovementId = Movement.Id
                                  AND MovementDate_Insert.DescId = zc_MovementDate_Insert()

            LEFT JOIN  MovementFloat AS MovementFloat_TotalSumm
                                     ON MovementFloat_TotalSumm.MovementId =  Movement.Id
                                    AND MovementFloat_TotalSumm.DescId = zc_MovementFloat_TotalSumm()

      WHERE COALESCE(MovementDate_Insert.ValueData, Movement.OperDate) >= vbDateStart - INTERVAL '1 month'
        AND COALESCE(MovementDate_Insert.ValueData, Movement.OperDate) < vbDateStart
        AND Movement.DescId = zc_Movement_Check()
        AND Movement.StatusId = zc_Enum_Status_Complete()
        AND MovementLinkObject_Insert.ObjectId is Not Null
      GROUP BY MovementLinkObject_Insert.ObjectId) AS T1
    WHERE tmpImplementationPlan.UserId = T1.UserId;

      -- Средний чекк за текущий месяц
    UPDATE tmpImplementationPlan SET AverageCheck = ROUND(T1.Average, 2)
    FROM (SELECT
                 MovementLinkObject_Insert.ObjectId                   AS UserId
               , SUM(MovementFloat_TotalSumm.ValueData) / Count(*)    AS Average
      FROM Movement


            LEFT JOIN MovementLinkObject AS MovementLinkObject_Unit
                                         ON MovementLinkObject_Unit.MovementId = Movement.Id
                                        AND MovementLinkObject_Unit.DescId = zc_MovementLinkObject_Unit()


            LEFT JOIN MovementLinkObject AS MovementLinkObject_Insert
                                         ON MovementLinkObject_Insert.MovementId = Movement.Id
                                        AND MovementLinkObject_Insert.DescId = zc_movementlinkobject_insert()

            LEFT JOIN MovementDate AS MovementDate_Insert
                                   ON MovementDate_Insert.MovementId = Movement.Id
                                  AND MovementDate_Insert.DescId = zc_MovementDate_Insert()

            LEFT JOIN  MovementFloat AS MovementFloat_TotalSumm
                                     ON MovementFloat_TotalSumm.MovementId =  Movement.Id
                                    AND MovementFloat_TotalSumm.DescId = zc_MovementFloat_TotalSumm()

      WHERE COALESCE(MovementDate_Insert.ValueData, Movement.OperDate) >= vbDateStart
        AND COALESCE(MovementDate_Insert.ValueData, Movement.OperDate) < vbDateStart + INTERVAL '1 month'
        AND Movement.DescId = zc_Movement_Check()
        AND Movement.StatusId = zc_Enum_Status_Complete()
        AND MovementLinkObject_Insert.ObjectId is Not Null
      GROUP BY MovementLinkObject_Insert.ObjectId) AS T1
    WHERE tmpImplementationPlan.UserId = T1.UserId;


       -- Получаем Movement
    IF EXISTS(SELECT Movement.ID FROM Movement WHERE Movement.OperDate = vbDateStart AND Movement.DescId = zc_Movement_KPU())
    THEN
      SELECT Movement.ID
      INTO vbMovementID
      FROM Movement
      WHERE Movement.OperDate = vbDateStart
        AND Movement.DescId = zc_Movement_KPU();
    ELSE
      vbMovementID := 0;
      vbMovementID := lpInsertUpdate_Movement (vbMovementID, zc_Movement_KPU(), Null, vbDateStart, NULL);
    END IF;

      -- Создаем MovementItem
    IF EXISTS(SELECT tmpImplementationPlan.UserID
              FROM tmpImplementationPlan
                   LEFT OUTER JOIN MovementItem ON tmpImplementationPlan.UserID = MovementItem.ObjectId
                                               AND MovementItem.MovementID = vbMovementID
              WHERE MovementItem.ID IS NULL)
    THEN
      PERFORM lpInsertUpdate_MovementItem (0, zc_MI_Master(), tmpImplementationPlan.UserID, vbMovementID, 30, NULL)
      FROM tmpImplementationPlan
           LEFT OUTER JOIN MovementItem ON tmpImplementationPlan.UserID = MovementItem.ObjectId
                                       AND MovementItem.MovementID = vbMovementID
      WHERE MovementItem.ID IS NULL;
    END IF;

      -- Сохраняем результат
    PERFORM lpInsertUpdate_MovementItemLinkObject (zc_MILinkObject_Unit(),  MovementItem.Id, tmpImplementationPlan.UnitID),
            lpInsertUpdate_MovementItemFloat (zc_MIFloat_FactOfManDays(), MovementItem.Id, tmpImplementationPlan.FactOfManDays),
            lpInsertUpdate_MovementItemFloat (zc_MIFloat_AmountTheFineTab(), MovementItem.Id, tmpImplementationPlan.AmountTheFineTab),
            lpInsertUpdate_MovementItemFloat (zc_MIFloat_BonusAmountTab(), MovementItem.Id, tmpImplementationPlan.BonusAmountTab),
            CASE WHEN tmpImplementationPlan.PrevAverageCheck is not Null THEN
              lpInsertUpdate_MovementItemFloat (zc_MIFloat_PrevAverageCheck(), MovementItem.Id, tmpImplementationPlan.PrevAverageCheck) END,
            CASE WHEN tmpImplementationPlan.AverageCheck is not Null THEN
              lpInsertUpdate_MovementItemFloat (zc_MIFloat_AverageCheck(), MovementItem.Id, tmpImplementationPlan.AverageCheck) END
    FROM tmpImplementationPlan
         INNER JOIN MovementItem ON tmpImplementationPlan.UserID = MovementItem.ObjectId
                                AND MovementItem.MovementID = vbMovementID;

      -- Подститываем КПУ
    PERFORM lpUpdate_MovementItem_KPU (MovementItem.Id)
    FROM MovementItem
    WHERE MovementItem.MovementID = vbMovementID;
  END IF;


       -- Результат
  RETURN QUERY
   WITH tmpTestingUser AS (SELECT
                             MovementItem.ObjectId                                          AS UserID
                           , MovementItem.Amount::Integer                                   AS Result
                           , CASE WHEN COALESCE (MovementFloat.ValueData, 0) > 0 THEN
                             Round(MovementItem.Amount / MovementFloat.ValueData * 100, 2)
                             ELSE 0 END::TFloat                                             AS ExamPercentage
                           , MovementItemFloat.ValueData::Integer                           AS Attempts
                      FROM Movement

                           INNER JOIN MovementFloat ON MovementFloat.MovementId = Movement.Id
                                                   AND MovementFloat.DescId = zc_MovementFloat_TestingUser_Question()

                           INNER JOIN MovementItem ON MovementItem.MovementId = Movement.Id
                                                  AND MovementItem.DescId = zc_MI_Master()

                           INNER JOIN MovementItemFloat ON MovementItemFloat.MovementItemId = MovementItem.Id
                                                       AND MovementItemFloat.DescId = zc_MIFloat_TestingUser_Attempts()

                      WHERE Movement.DescId = zc_Movement_TestingUser()
                        AND Movement.OperDate = vbDateStart),

        tmpPlanAmount AS (SELECT
                                 Object_ReportSoldParams.UnitId                 AS UnitId,
                                 Object_ReportSoldParams.PlanAmount             AS PlanAmount
                          FROM
                               Object_ReportSoldParams_View AS Object_ReportSoldParams
                          WHERE Object_ReportSoldParams.PlanDate >= vbDateStart
                            AND Object_ReportSoldParams.PlanDate < vbEndDate),

        tmpFactAmount AS (SELECT
                                 MovementCheck.UnitId                           AS UnitID,
                                 SUM(TotalSumm)                                 AS FactAmount
                          FROM
                               Movement_Check_View AS MovementCheck
                          WHERE MovementCheck.OperDate >= vbDateStart
                            AND MovementCheck.OperDate < vbEndDate
                            AND MovementCheck.StatusId = zc_Enum_Status_Complete()
                          GROUP BY  MovementCheck.UnitID)



  SELECT
          MovementItem.Id                             AS ID
        , Object_Member.Id                            AS UserID
        , Object_Member.ObjectCode                    AS UserCode
        , Object_Member.ValueData                     AS UserName

        , Object_Personal_View.PositionName
        , Object_Personal_View.DateIn

        , Object_Unit.ID                              AS UnitID
        , Object_Unit.ObjectCode                      AS UnitCode
        , Object_Unit.ValueData                       AS UnitName

        , MovementItem.Amount                         AS KPU

        , MIFloat_FactOfManDays.ValueData::Integer    AS FactOfManDays
        , MIFloat_AmountTheFineTab.ValueData          AS AmountTheFineTab
        , MIFloat_BonusAmountTab.ValueData            AS BonusAmountTab
        , COALESCE (MIFloat_MarkRatio.ValueData,
            CASE WHEN COALESCE (MIFloat_AmountTheFineTab.ValueData, 0) = COALESCE (MIFloat_BonusAmountTab.ValueData, 0)
            THEN 0 ELSE CASE WHEN COALESCE (MIFloat_AmountTheFineTab.ValueData, 0) <= COALESCE (MIFloat_BonusAmountTab.ValueData, 0)
            THEN 1 ELSE -1 END END)::Integer              AS MarkRatio

        , MIFloat_PrevAverageCheck.ValueData          AS PrevAverageCheck
        , MIFloat_AverageCheck.ValueData              AS AverageCheck
        , COALESCE (MIFloat_AverageCheckRatio.ValueData,
            CASE WHEN COALESCE (MIFloat_PrevAverageCheck.ValueData, 0) = 0
            THEN 0 ELSE ROUND((COALESCE (MIFloat_AverageCheck.ValueData, 0) / COALESCE (MIFloat_PrevAverageCheck.ValueData, 0) - 1) * 100, 1)
            END)::TFloat                              AS AverageCheckRatio

        , MIFloat_LateTimeRatio.ValueData::Integer    AS LateTimeRatio

        , tmpPlanAmount.PlanAmount::TFloat            AS FinancPlan
        , tmpFactAmount.FactAmount::TFloat            AS FinancPlanFact
        , COALESCE (MIFloat_FinancPlanRatio.ValueData,
            CASE WHEN COALESCE (tmpPlanAmount.PlanAmount, 0) = 0 or COALESCE (tmpFactAmount.FactAmount, 0) = 0
            THEN 0 ELSE CASE WHEN tmpPlanAmount.PlanAmount <= tmpFactAmount.FactAmount THEN 1 ELSE -1 END
            END)::Integer                             AS FinancPlanRatio

        , TestingUser.Result                          AS CorrectAnswers
        , TestingUser.ExamPercentage                  AS ExamPercentage
        , TestingUser.Attempts                        AS NumberAttempts
        , CASE WHEN TestingUser.ExamPercentage IS NULL
          THEN NULL ELSE
          CASE WHEN TestingUser.ExamPercentage >= 80
          THEN 'Сдан' ELSE 'Не сдан' END END::TVarChar       AS ExamResult
        , COALESCE (MIFloat_IT_ExamRatio.ValueData::Integer,
          CASE WHEN TestingUser.ExamPercentage IS NULL
          THEN NULL ELSE
          CASE WHEN TestingUser.ExamPercentage >= 80
          THEN 4 - TestingUser.Attempts ELSE Null END END)   AS IT_ExamRatio

        , MIFloat_ComplaintsRatio.ValueData::Integer  AS ComplaintsRatio
        , MIString_ComplaintsNote.ValueData           AS ComplaintsNote

        , MIFloat_DirectorRatio.ValueData::Integer    AS DirectorRatio
        , MIString_DirectorNote.ValueData             AS DirectorNote

        , MIFloat_YuriIT.ValueData::Integer           AS YuriIT
        , MIFloat_OlegIT.ValueData::Integer           AS OlegIT
        , MIFloat_MaximIT.ValueData::Integer          AS MaximIT
        , MIFloat_CollegeITRatio.ValueData::Integer   AS CollegeITRatio
        , MIString_CollegeITNote.ValueData            AS CollegeITNote

        , MIFloat_VIPDepartRatio.ValueData::Integer   AS VIPDepartRatio
        , MIString_VIPDepartRatioNote.ValueData       AS VIPDepartRatioNote

        , MIFloat_Romanova.ValueData::Integer         AS Romanova
        , MIFloat_Golovko.ValueData::Integer          AS Golovko
        , MIFloat_ControlRGRatio.ValueData::Integer   AS ControlRGRatio
        , MIString_ControlRGNote.ValueData            AS ControlRGNote


  FROM Movement

       INNER JOIN MovementItem ON MovementItem.MovementId = Movement.id
                              AND MovementItem.DescId = zc_MI_Master()

       LEFT JOIN MovementItemLinkObject AS MILinkObject_Unit
                                        ON MILinkObject_Unit.MovementItemId = MovementItem.Id
                                       AND MILinkObject_Unit.DescId = zc_MILinkObject_Unit()
       LEFT JOIN Object AS Object_Unit ON Object_Unit.Id = MILinkObject_Unit.ObjectId

       LEFT JOIN ObjectLink AS ObjectLink_User_Member
                            ON ObjectLink_User_Member.ObjectId = MovementItem.ObjectId
                           AND ObjectLink_User_Member.DescId = zc_ObjectLink_User_Member()
       LEFT JOIN Object AS Object_Member ON Object_Member.Id = ObjectLink_User_Member.ChildObjectid

       LEFT JOIN Object_Personal_View ON Object_Personal_View.MemberId = ObjectLink_User_Member.ChildObjectid

       LEFT JOIN MovementItemFloat AS MIFloat_FactOfManDays
                                   ON MIFloat_FactOfManDays.MovementItemId = MovementItem.Id
                                  AND MIFloat_FactOfManDays.DescId = zc_MIFloat_FactOfManDays()

       LEFT JOIN MovementItemFloat AS MIFloat_AmountTheFineTab
                                   ON MIFloat_AmountTheFineTab.MovementItemId = MovementItem.Id
                                  AND MIFloat_AmountTheFineTab.DescId = zc_MIFloat_AmountTheFineTab()

       LEFT JOIN MovementItemFloat AS MIFloat_BonusAmountTab
                                   ON MIFloat_BonusAmountTab.MovementItemId = MovementItem.Id
                                  AND MIFloat_BonusAmountTab.DescId = zc_MIFloat_BonusAmountTab()

       LEFT JOIN MovementItemFloat AS MIFloat_MarkRatio
                                   ON MIFloat_MarkRatio.MovementItemId = MovementItem.Id
                                  AND MIFloat_MarkRatio.DescId = zc_MIFloat_MarkRatio()

       LEFT JOIN MovementItemFloat AS MIFloat_PrevAverageCheck
                                   ON MIFloat_PrevAverageCheck.MovementItemId = MovementItem.Id
                                  AND MIFloat_PrevAverageCheck.DescId = zc_MIFloat_PrevAverageCheck()

       LEFT JOIN MovementItemFloat AS MIFloat_AverageCheck
                                   ON MIFloat_AverageCheck.MovementItemId = MovementItem.Id
                                  AND MIFloat_AverageCheck.DescId = zc_MIFloat_AverageCheck()

       LEFT JOIN MovementItemFloat AS MIFloat_AverageCheckRatio
                                   ON MIFloat_AverageCheckRatio.MovementItemId = MovementItem.Id
                                  AND MIFloat_AverageCheckRatio.DescId = zc_MIFloat_AverageCheckRatio()

       LEFT JOIN MovementItemFloat AS MIFloat_LateTimeRatio
                                   ON MIFloat_LateTimeRatio.MovementItemId = MovementItem.Id
                                  AND MIFloat_LateTimeRatio.DescId = zc_MIFloat_LateTimeRatio()

       LEFT JOIN tmpPlanAmount ON tmpPlanAmount.UnitID = MILinkObject_Unit.ObjectId

       LEFT JOIN tmpFactAmount ON tmpFactAmount.UnitID = MILinkObject_Unit.ObjectId

       LEFT JOIN MovementItemFloat AS MIFloat_FinancPlanRatio
                                   ON MIFloat_FinancPlanRatio.MovementItemId = MovementItem.Id
                                  AND MIFloat_FinancPlanRatio.DescId = zc_MIFloat_FinancPlanRatio()

       LEFT JOIN tmpTestingUser AS TestingUser
                                ON TestingUser.UserId = MovementItem.ObjectId

       LEFT JOIN MovementItemFloat AS MIFloat_IT_ExamRatio
                                   ON MIFloat_IT_ExamRatio.MovementItemId = MovementItem.Id
                                  AND MIFloat_IT_ExamRatio.DescId = zc_MIFloat_IT_ExamRatio()

       LEFT JOIN MovementItemFloat AS MIFloat_ComplaintsRatio
                                   ON MIFloat_ComplaintsRatio.MovementItemId = MovementItem.Id
                                  AND MIFloat_ComplaintsRatio.DescId = zc_MIFloat_ComplaintsRatio()

       LEFT JOIN MovementItemString AS MIString_ComplaintsNote
                                    ON MIString_ComplaintsNote.MovementItemId = MovementItem.Id
                                   AND MIString_ComplaintsNote.DescId = zc_MIString_ComplaintsNote()

       LEFT JOIN MovementItemFloat AS MIFloat_DirectorRatio
                                   ON MIFloat_DirectorRatio.MovementItemId = MovementItem.Id
                                  AND MIFloat_DirectorRatio.DescId = zc_MIFloat_DirectorRatio()

       LEFT JOIN MovementItemString AS MIString_DirectorNote
                                    ON MIString_DirectorNote.MovementItemId = MovementItem.Id
                                   AND MIString_DirectorNote.DescId = zc_MIString_DirectorNote()

       LEFT JOIN MovementItemFloat AS MIFloat_YuriIT
                                   ON MIFloat_YuriIT.MovementItemId = MovementItem.Id
                                  AND MIFloat_YuriIT.DescId = zc_MIFloat_YuriIT()

       LEFT JOIN MovementItemFloat AS MIFloat_OlegIT
                                   ON MIFloat_OlegIT.MovementItemId = MovementItem.Id
                                  AND MIFloat_OlegIT.DescId = zc_MIFloat_OlegIT()

       LEFT JOIN MovementItemFloat AS MIFloat_MaximIT
                                   ON MIFloat_MaximIT.MovementItemId = MovementItem.Id
                                  AND MIFloat_MaximIT.DescId = zc_MIFloat_MaximIT()

       LEFT JOIN MovementItemFloat AS MIFloat_CollegeITRatio
                                   ON MIFloat_CollegeITRatio.MovementItemId = MovementItem.Id
                                  AND MIFloat_CollegeITRatio.DescId = zc_MIFloat_CollegeITRatio()

       LEFT JOIN MovementItemString AS MIString_CollegeITNote
                                    ON MIString_CollegeITNote.MovementItemId = MovementItem.Id
                                   AND MIString_CollegeITNote.DescId = zc_MIString_CollegeITNote()

       LEFT JOIN MovementItemFloat AS MIFloat_VIPDepartRatio
                                   ON MIFloat_VIPDepartRatio.MovementItemId = MovementItem.Id
                                  AND MIFloat_VIPDepartRatio.DescId = zc_MIFloat_VIPDepartRatio()

       LEFT JOIN MovementItemString AS MIString_VIPDepartRatioNote
                                    ON MIString_VIPDepartRatioNote.MovementItemId = MovementItem.Id
                                   AND MIString_VIPDepartRatioNote.DescId = zc_MIString_VIPDepartRatioNote()

       LEFT JOIN MovementItemFloat AS MIFloat_Romanova
                                   ON MIFloat_Romanova.MovementItemId = MovementItem.Id
                                  AND MIFloat_Romanova.DescId = zc_MIFloat_Romanova()

       LEFT JOIN MovementItemFloat AS MIFloat_Golovko
                                   ON MIFloat_Golovko.MovementItemId = MovementItem.Id
                                  AND MIFloat_Golovko.DescId = zc_MIFloat_Golovko()

       LEFT JOIN MovementItemFloat AS MIFloat_ControlRGRatio
                                   ON MIFloat_ControlRGRatio.MovementItemId = MovementItem.Id
                                  AND MIFloat_ControlRGRatio.DescId = zc_MIFloat_ControlRGRatio()

       LEFT JOIN MovementItemString AS MIString_ControlRGNote
                                    ON MIString_ControlRGNote.MovementItemId = MovementItem.Id
                                   AND MIString_ControlRGNote.DescId = zc_MIString_ControlRGNote()


  WHERE Movement.OperDate = vbDateStart
    AND Movement.DescId = zc_Movement_KPU()
  ORDER BY Object_Member.ValueData;

END;
$BODY$
  LANGUAGE PLPGSQL VOLATILE;

/*
 ИСТОРИЯ РАЗРАБОТКИ: ДАТА, АВТОР
               Шаблий О.В.
 05.11.18         *
 15.10.18         *
 03.10.18         *
*/

-- тест
-- select * from gpReport_KPU(inStartDate := ('01.07.2018')::TDateTime ,  inRecount := False, inSession := '3');