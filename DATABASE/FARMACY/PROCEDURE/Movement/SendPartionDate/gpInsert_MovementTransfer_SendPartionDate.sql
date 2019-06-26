-- Function: gpInsert_MovementTransfer_SendPartionDate()

DROP FUNCTION IF EXISTS gpInsert_MovementTransfer_SendPartionDate (TVarChar);

CREATE OR REPLACE FUNCTION gpInsert_MovementTransfer_SendPartionDate(
    IN inSession       TVarChar    -- ������ ������������
)
RETURNS VOID AS
$BODY$
   DECLARE vbUserId Integer;
BEGIN

  vbUserId:= lpGetUserBySession (inSession);

  PERFORM lpInsert_MovementUnit_SendPartionDate (inUnitID      := UnitId
                                               , inMovementID  := Movementid
                                               , inSession      := inSession)
  FROM (
    WITH tmpMovement AS (SELECT MovementLinkObject_Unit.ObjectId   AS UnitID
                              , MAX(Movement.id)                   AS Movementid
                         FROM Movement

                              LEFT JOIN MovementLinkObject AS MovementLinkObject_Unit
                                                           ON MovementLinkObject_Unit.MovementId = Movement.Id
                                                          AND MovementLinkObject_Unit.DescId = zc_MovementLinkObject_Unit()

                         WHERE Movement.DescId = zc_Movement_SendPartionDate()
                           AND Movement.StatusId = zc_Enum_Status_Complete()
                         GROUP BY MovementLinkObject_Unit.ObjectId)

    SELECT Object_Unit.Id AS UnitID
         , tmpMovement.Movementid
    FROM Object AS Object_Unit

         INNER JOIN ObjectBoolean AS ObjectBoolean_DividePartionDate
                                 ON ObjectBoolean_DividePartionDate.ObjectId = Object_Unit.Id
                                AND ObjectBoolean_DividePartionDate.DescId = zc_ObjectBoolean_Unit_DividePartionDate()
                                AND ObjectBoolean_DividePartionDate.ValueData = True

         INNER JOIN tmpMovement ON tmpMovement.UnitID = Object_Unit.Id

    WHERE Object_Unit.DescId = zc_Object_Unit()) T1;

END;
$BODY$
  LANGUAGE PLPGSQL VOLATILE;

/*
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.   ������ �.�.
 18.06.19                                                       *
*/

-- ����
-- SELECT * FROM gpInsert_MovementTransfer_SendPartionDate (inSession:= '3')       