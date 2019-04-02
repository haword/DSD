-- Function: lpInsertUpdate_MovementFloat_TotalSummReturnIn (Integer)

DROP FUNCTION IF EXISTS lpInsertUpdate_MovementFloat_TotalSummReturnIn (Integer);

CREATE OR REPLACE FUNCTION lpInsertUpdate_MovementFloat_TotalSummReturnIn(
    IN inMovementId Integer -- Ключ объекта <Документ>
)
  RETURNS VOID AS
$BODY$
  DECLARE vbTotalCountReturnIn TFloat;
  DECLARE vbTotalSummReturnIn TFloat;
  DECLARE vbRoundingTo10 Boolean;
  DECLARE vbRoundingDown Boolean;
BEGIN
    IF COALESCE (inMovementId, 0) = 0
    THEN
        RAISE EXCEPTION 'Ошибка.Элемент документа не сохранен.';
    END IF;

    vbRoundingTo10 := False;
    vbRoundingDown := False;

    SELECT
      MB_RoundingTo10.ValueData
    INTO
      vbRoundingTo10
    FROM MovementBoolean AS MB_RoundingTo10
    WHERE MB_RoundingTo10.MovementId = inMovementId
      AND MB_RoundingTo10.DescId = zc_MovementBoolean_RoundingTo10();

    SELECT
      MB_RoundingDown.ValueData
    INTO
      vbRoundingDown
    FROM MovementBoolean AS MB_RoundingDown
    WHERE MB_RoundingDown.MovementId = inMovementId
      AND MB_RoundingDown.DescId = zc_MovementBoolean_RoundingDown();

    SELECT SUM(COALESCE(MovementItem.Amount,0))
         , CASE WHEN COALESCE (vbRoundingDown, False) = True
                THEN SUM(TRUNC(COALESCE(MovementItem.Amount,0) * COALESCE(MovementItemFloat_Price.ValueData,0), 1)::NUMERIC (16, 2))
                ELSE CASE WHEN COALESCE (vbRoundingTo10, False) = True
                THEN SUM(((COALESCE(MovementItem.Amount,0) * COALESCE(MovementItemFloat_Price.ValueData,0))::NUMERIC (16, 1))::NUMERIC (16, 2))
                ELSE SUM((COALESCE(MovementItem.Amount,0) * COALESCE(MovementItemFloat_Price.ValueData,0))::NUMERIC (16, 2)) 
           END END
    INTO
        vbTotalCountReturnIn,
        vbTotalSummReturnIn
    FROM MovementItem
        LEFT OUTER JOIN MovementItemFloat AS MovementItemFloat_Price
                                          ON MovementItemFloat_Price.MovementItemId = MovementItem.Id
                                         AND MovementItemFloat_Price.DescId = zc_MIFloat_Price()
    WHERE MovementItem.MovementId = inMovementId
      AND MovementItem.isErased = false;


    -- Сохранили свойство <Итого количество>
    PERFORM lpInsertUpdate_MovementFloat (zc_MovementFloat_TotalCount(), inMovementId, vbTotalCountReturnIn);
    -- Сохранили свойство <Итого Сумма>
    PERFORM lpInsertUpdate_MovementFloat (zc_MovementFloat_TotalSumm(), inMovementId, vbTotalSummReturnIn);


END;
$BODY$
  LANGUAGE plpgsql VOLATILE;

-------------------------------------------------------------------------------
/*
 ИСТОРИЯ РАЗРАБОТКИ: ДАТА, АВТОР
               Фелонюк И.В.   Кухтин И.В.   Климентьев К.И.   Шаблий О.В.
 02.04.19                                                       *
 19.01.19         *
*/
