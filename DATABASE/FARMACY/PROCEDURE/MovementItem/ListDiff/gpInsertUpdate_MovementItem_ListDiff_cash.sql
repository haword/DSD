-- Function: gpInsertUpdate_MovementItem_ListDiff_cash ()

--DROP FUNCTION IF EXISTS gpInsertUpdate_MovementItem_ListDiff_cash  (Integer, Integer, TFloat, TFloat, TVarChar, Integer, Integer, TDateTime, Integer, TVarChar);
DROP FUNCTION IF EXISTS gpInsertUpdate_MovementItem_ListDiff_cash  (Integer, Integer, TFloat, TFloat, Integer, TVarChar, Integer, Integer, TDateTime, Integer, TVarChar);

CREATE OR REPLACE FUNCTION gpInsertUpdate_MovementItem_ListDiff_cash(
    IN inUnitId            Integer,
    IN inGoodsId           Integer,
    IN inAmount            TFloat,
    IN inPrice             TFloat,
    IN inDiffKindId        Integer,
    IN inComment           TVarChar,
    IN inJuridicalId       Integer,
    IN inContractId        Integer,
    IN inDateInput         TDateTime,
    -- IN inGUID              TVarChar  , -- GUID строки
    IN inUserId            Integer,
    IN inSession           TVarChar
)
RETURNS VOID AS
$BODY$
   DECLARE vbUserId         Integer;
   DECLARE vbUnitId         Integer;
   DECLARE vbMovementId     Integer;
   DECLARE vbMovementItemId Integer;
BEGIN
     -- проверка прав пользователя на вызов процедуры
     vbUserId := inUserId;

     -- определяется - временно
     IF inUnitId > 0
     THEN
         vbUnitId:= inUnitId;
     ELSE
         vbUnitId:= lpGet_DefaultValue ('zc_Object_Unit', vbUserId);
     END IF;
     
     IF COALESCE(inGoodsId, 0) = 0
     THEN
       RETURN;
     END IF;

     -- определяется
     vbMovementId:= (SELECT Movement.Id
                     FROM Movement
                          INNER JOIN MovementLinkObject AS MovementLinkObject_Unit
                                                        ON MovementLinkObject_Unit.MovementId = Movement.Id
                                                       AND MovementLinkObject_UNit.DescId     = zc_MovementLinkObject_Unit()
                                                       AND MovementLinkObject_UNit.ObjectId   = vbUnitId
                     WHERE Movement.OperDate = DATE_TRUNC ('DAY', inDateInput)
                       AND Movement.DescId = zc_Movement_ListDiff() 
                       AND Movement.StatusId <> zc_Enum_Status_Erased()
                    );

     -- Insert
     IF COALESCE (vbMovementId, 0) = 0
     THEN
         vbMovementId:= gpInsertUpdate_Movement_ListDiff (ioId        := vbMovementId
                                                        , inInvNumber := NEXTVAL ('Movement_ListDiff_seq')::TVarChar
                                                        , inOperDate  := DATE_TRUNC ('DAY', inDateInput)
                                                        , inUnitId    := vbUnitId
                                                        , inSession   := inUserId :: TVarChar
                                                         );
     END IF;

     IF (SELECT Movement.StatusId FROM Movement WHERE Movement.ID = vbMovementId) <> zc_Enum_Status_UnComplete()
     THEN
        RETURN;
     END IF;

     IF EXISTS (SELECT 1 FROM MovementItem 
                         INNER JOIN MovementItemDate AS MIDate_Insert
                                                     ON MIDate_Insert.MovementItemId = MovementItem.Id
                                                    AND MIDate_Insert.DescId         = zc_MIDate_Insert()
                                                    AND MIDate_Insert.ValueData      = inDateInput
                WHERE MovementItem.MovementID = vbMovementId
                  AND MovementItem.ObjectId = inGoodsId)
     THEN
        RETURN;
     END IF;

     -- Insert
     vbMovementItemId:= gpInsertUpdate_MovementItem_ListDiff (ioId         := 0
                                                            , inMovementId := vbMovementId
                                                            , inGoodsId    := inGoodsId
                                                            , inJuridicalId:= inJuridicalId
                                                            , inContractId := inContractId
                                                            , inDiffKindId := inDiffKindId
                                                            , inAmount     := inAmount
                                                            , inPrice      := inPrice
                                                            , inComment    := inComment
                                                            , inSession    := inUserId :: TVarChar
                                                             );
     -- сохранили свойство <>
     PERFORM lpInsertUpdate_MovementItemDate (zc_MIDate_Insert(), vbMovementItemId, inDateInput);


END;
$BODY$
  LANGUAGE plpgsql VOLATILE;

/*
 ИСТОРИЯ РАЗРАБОТКИ: ДАТА, АВТОР
               Фелонюк И.В.   Кухтин И.В.   Климентьев К.И.   Шаблий О.В.
 12.12.18                                                      * 
 25.09.18                                        * 
*/
