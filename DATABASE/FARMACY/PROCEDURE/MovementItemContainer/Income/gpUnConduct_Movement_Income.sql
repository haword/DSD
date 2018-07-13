-- Function: gpUnConduct_Movement_Income (Integer, TVarChar)

DROP FUNCTION IF EXISTS gpUnConduct_Movement_Income (Integer, TVarChar);

CREATE OR REPLACE FUNCTION gpUnConduct_Movement_Income(
    IN inMovementId        Integer               , -- ключ Документа
    IN inSession           TVarChar DEFAULT ''     -- сессия пользователя
)
RETURNS VOID
AS
$BODY$
  DECLARE vbUserId Integer;
  DECLARE vbOperDate    TDateTime;
  DECLARE vbUnit        Integer;
BEGIN
     -- проверка прав пользователя на вызов процедуры
--     vbUserId:= lpCheckRight(inSession, zc_Enum_Process_UnComplete_Income());
     vbUserId:= inSession;

     -- !!!Проверка что б второй раз не провели накладную и проводки не задвоились!!!
     IF EXISTS (SELECT 1 FROM Movement WHERE Movement.Id = inMovementId AND Movement.StatusId = zc_Enum_Status_Complete())
     THEN
         RAISE EXCEPTION 'Ошибка.Документ уже проведен.';
     END IF;

     IF NOT EXISTS(SELECT ValueData FROM MovementItem
                      INNER JOIN MovementItemBoolean ON MovementItemBoolean.DescId = zc_MIBoolean_Conduct()
                                                   AND MovementItemBoolean.MovementItemId = MovementItem.Id
                                                   AND MovementItemBoolean.ValueData = TRUE
                      WHERE MovementItem.MovementId = inMovementId)
     THEN
         RAISE EXCEPTION 'Ошибка. Нет проведенных строк в документе..';
     END IF;

     -- Проверяем на уменьшение количества
/*     IF NOT EXISTS (SELECT 1
             FROM ObjectLink AS Object_UserRole_User -- Связь пользователя с объектом роли пользователя
                      JOIN ObjectLink AS Object_UserRole_Role -- Связь ролей с объектом роли пользователя
                                      ON Object_UserRole_Role.DescId = zc_ObjectLink_UserRole_Role()
                                     AND Object_UserRole_Role.ObjectId = Object_UserRole_User.ObjectId
                                     AND Object_UserRole_Role.ChildObjectId = zc_Enum_Role_Admin()
             WHERE Object_UserRole_User.DescId = zc_ObjectLink_UserRole_User()
               AND Object_UserRole_User.ChildObjectId = vbUserId) AND
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
                                     AND RoleRight_Process.ChildObjectId =  zc_Enum_Process_SetErased_MI_Income()
                 WHERE Object_UserRole_User.DescId = zc_ObjectLink_UserRole_User()
                   AND Object_UserRole_User.ChildObjectId = vbUserId)
     THEN
         RAISE EXCEPTION 'Ошибка. Отмена проведения по фактическому количеству вам запрещено.';
     END IF; */

     PERFORM lpUnConduct_MovementItem_Income (inMovementId, MovementItem.Id, vbUserId) FROM MovementItem
                   INNER JOIN MovementItemBoolean ON MovementItemBoolean.DescId = zc_MIBoolean_Conduct()
                                                 AND MovementItemBoolean.MovementItemId = MovementItem.Id
                                                 AND MovementItemBoolean.ValueData = TRUE
                    WHERE MovementItem.MovementId = inMovementId;

END;
$BODY$
  LANGUAGE plpgsql VOLATILE;

/*
 ИСТОРИЯ РАЗРАБОТКИ: ДАТА, АВТОР
               Шаблий О.В.
 26.06.18         *
*/

-- тест
-- SELECT * FROM gpUnConduct_Movement_Income (inMovementId:= 149639, inSession:= zfCalc_UserAdmin())
