-- Function: gpUnComplete_Movement_Inventory (Integer, TVarChar)

DROP FUNCTION IF EXISTS gpUnComplete_Movement_Inventory (Integer, TVarChar);

CREATE OR REPLACE FUNCTION gpUnComplete_Movement_Inventory(
    IN inMovementId        Integer               , -- ���� ���������
    IN inSession           TVarChar DEFAULT ''     -- ������ ������������
)
RETURNS VOID
AS
$BODY$
  DECLARE vbUserId Integer;
  DECLARE vbUnitId Integer;
  DECLARE vbUnitKey TVarChar;
  DECLARE vbUserUnitId Integer;
BEGIN
     -- �������� ���� ������������ �� ����� ���������
     vbUserId:= inSession; -- lpCheckRight(inSession, zc_Enum_Process_UnComplete_Inventory());

     -- ��������� ������ ����������� � ������� ������    
     IF NOT EXISTS (SELECT 1 FROM ObjectLink_UserRole_View  WHERE UserId = vbUserId AND RoleId = zc_Enum_Role_Admin())
     THEN
       RAISE EXCEPTION '������������� ��� ���������, ���������� � ���������� ��������������';
     END IF;

     IF EXISTS(SELECT * FROM gpSelect_Object_RoleUser (inSession) AS Object_RoleUser
               WHERE Object_RoleUser.ID = vbUserId AND Object_RoleUser.RoleId = 308121) -- ��� ���� "������ ������"
     THEN
     
        vbUnitKey := COALESCE(lpGet_DefaultValue('zc_Object_Unit', vbUserId), '');
        IF vbUnitKey = '' THEN
           vbUnitKey := '0';
        END IF;
        vbUserUnitId := vbUnitKey::Integer;

        SELECT MLO_Unit.ObjectId
        INTO vbUnitId
        FROM  Movement
              INNER JOIN MovementLinkObject AS MLO_Unit
                                            ON MLO_Unit.MovementId = Movement.Id
                                           AND MLO_Unit.DescId = zc_MovementLinkObject_Unit()
        WHERE Movement.Id = inMovementId;

        IF COALESCE (vbUnitId, 0) <> COALESCE (vbUserUnitId, 0)
        THEN
           RAISE EXCEPTION '������. ��� ��������� �������� ������ � �������������� <%>.', (SELECT ValueData FROM Object WHERE ID = vbUserUnitId);     
        END IF;     

        RAISE EXCEPTION '������. ������ ������� �������������� ��� ���������.';     
     END IF;     

     -- �������� - ���� <Master> ������, �� <������>
     PERFORM lfCheck_Movement_ParentStatus (inMovementId:= inMovementId, inNewStatusId:= zc_Enum_Status_UnComplete(), inComment:= '�����������');

     -- ����������� ��������
     PERFORM lpUnComplete_Movement (inMovementId := inMovementId
                                  , inUserId     := vbUserId);

     --������� ��� ������, ������� ��������� ��� ����������
     PERFORM lpDelete_MovementItem(MovementItem.Id,inSession)
     FROM
         MovementItem
         INNER JOIN MovementItemBoolean AS MIBoolean_IsAuto
                                        ON MIBoolean_IsAuto.MovementItemId = MovementItem.Id
                                       AND MIBoolean_IsAuto.DescId = zc_MIBoolean_isAuto()
     WHERE
         MovementItem.MovementId = inMovementId;

END;
$BODY$
  LANGUAGE plpgsql VOLATILE;

/*
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.   ������ �.�.  ��������� �.�.   ������ �.�.
 02.07.19                                                                                    *
 17.12.18                                                                                    *
 16.09.2015                                                                   *  + ������� ��� ������, ������� ��������� ��� ����������
 01.09.14                                                       *
*/

-- ����
-- SELECT * FROM gpUnComplete_Movement_Inventory (inMovementId:= 149639, inSession:= zfCalc_UserAdmin())
