-- Function: gpUpdate_MovementItem_EmployeeSchedule_SubstitutionUnit()

DROP FUNCTION IF EXISTS gpUpdate_MovementItem_EmployeeSchedule_SubstitutionUnit (Integer, Integer, Integer, TVarChar);
  
CREATE OR REPLACE FUNCTION gpUpdate_MovementItem_EmployeeSchedule_SubstitutionUnit(
    IN inId                Integer   , -- ���� ������� <�������� ���>
    IN inUnitId            Integer   , -- ������������
    IN inTypeId            Integer   , -- ����
    IN inSession           TVarChar    -- ������ ������������
)
RETURNS void
AS
$BODY$
   DECLARE vbId Integer;
   DECLARE vbMovementId Integer;
   DECLARE vbUserId Integer;
   DECLARE vbStatusId Integer;
BEGIN
    -- �������� ���� ������������ �� ����� ���������
    --vbUserId := lpGetUserBySession (inSession);
--    vbUserId := lpCheckRight (inSession, zc_Enum_Process_Update_Movement_Check_OperDate());

    -- �������� ���� ������������ �� ����� ���������
    IF 758920 <> inSession::Integer AND 4183126 <> inSession::Integer AND 9383066  <> inSession::Integer
    THEN
      RAISE EXCEPTION '��������� <������ ������ �����������> ��� ���������.';
    END IF;
    
    IF COALESCE(inTypeId,0) = 0
    THEN
        RAISE EXCEPTION '�� ���������� �������� ���.';
    END IF;

    IF COALESCE(inId,0) = 0
    THEN
        RAISE EXCEPTION '�������� �� �������.';
    END IF;

    SELECT 
      Movement.id,
      Movement.StatusId
    INTO
      vbMovementId,
      vbStatusId
    FROM MovementItem
         INNER JOIN Movement ON Movement.ID = MovementItem.MovementId
    WHERE MovementItem.Id = inId;
            
    IF vbStatusId <> zc_Enum_Status_UnComplete() 
    THEN
        RAISE EXCEPTION '������.��������� ������������� � ������� <%> �� ��������.', lfGet_Object_ValueData (vbStatusId);
    END IF;

    -- ��������� <������� ���������>
    
    IF EXISTS(SELECT 1
              FROM MovementItem
              WHERE MovementItem.MovementID = vbMovementId 
                AND MovementItem.DescId = inTypeId
                AND MovementItem.Amount = zc_MI_Child() 
                AND MovementItem.ParentId = inId)
    THEN
      SELECT MovementItem.Id
      INTO vbId
      FROM MovementItem
      WHERE MovementItem.MovementID = vbMovementId 
        AND MovementItem.DescId = inTypeId
        AND MovementItem.Amount = zc_MI_Child() 
        AND MovementItem.ParentId = inId;
    ELSE
      vbId := 0;
    END IF;
                
    vbId := lpInsertUpdate_MovementItem (vbId, zc_MI_Child(), inUnitId, vbMovementId, inTypeId, inId);

END;
$BODY$
  LANGUAGE PLPGSQL VOLATILE;

/*
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.   ������ �.�.  ��������� �.�.  ������ �.�.
 25.03.19                                                                                    *
*/
-- ����
-- select * from gpUpdate_MovementItem_EmployeeSchedule_SubstitutionUnit(inId := 7784533 , inUnitId := 183294 ,  inSession := '3');