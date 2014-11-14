-- Function: lpUnComplete_Movement (Integer, Integer)

DROP FUNCTION IF EXISTS lpUnComplete_Movement (Integer, Integer);

CREATE OR REPLACE FUNCTION lpUnComplete_Movement(
    IN inMovementId        Integer  , -- ���� ������� <��������>
    IN inUserId            Integer    -- ������������
)                              
  RETURNS VOID
AS
$BODY$
  DECLARE vbOperDate TDateTime;
  DECLARE vbDescId Integer;
  DECLARE vbAccessKeyId Integer;
BEGIN

  -- 1. �������� �� "�������������" / "��������"
  PERFORM lpCheck_Movement_Status (inMovementId, inUserId);

  -- 2. ����������� ������ ������ ���������
  UPDATE Movement SET StatusId = zc_Enum_Status_UnComplete() WHERE Id = inMovementId
  RETURNING OperDate, DescId, AccessKeyId INTO vbOperDate, vbDescId, vbAccessKeyId;


  -- ��� ������  - ��� �����
  IF NOT EXISTS (SELECT 1 FROM ObjectLink_UserRole_View WHERE RoleId = zc_Enum_Role_Admin() AND UserId = inUserId)
  THEN 
  -- �������� ���� ��� <AccessKey>
  IF vbDescId = zc_Movement_Sale()
  THEN 
      IF lpGetAccessKey (inUserId, COALESCE ((SELECT ProcessId FROM Object_Process_User_View WHERE UserId = inUserId AND ProcessId IN (zc_Enum_Process_InsertUpdate_Movement_Sale(), zc_Enum_Process_InsertUpdate_Movement_Sale_Partner())), zc_Enum_Process_InsertUpdate_Movement_Sale()))
         <> vbAccessKeyId AND COALESCE (vbAccessKeyId, 0) <> 0
      THEN
          RAISE EXCEPTION '������.� ������������ <%> ��� ���� ��� ��������� � ��������� � <%> �� <%>.', lfGet_Object_ValueData (inUserId), (SELECT InvNumber FROM Movement WHERE Id = inMovementId), DATE (vbOperDate);
      END IF;
  ELSE
  IF vbDescId = zc_Movement_ReturnIn()
  THEN 
      IF lpGetAccessKey (inUserId, zc_Enum_Process_InsertUpdate_Movement_ReturnIn()) -- (SELECT ProcessId FROM Object_Process_User_View WHERE UserId = inUserId AND ProcessId IN (zc_Enum_Process_InsertUpdate_Movement_ReturnIn())))
         <> vbAccessKeyId AND COALESCE (vbAccessKeyId, 0) <> 0
      THEN
          RAISE EXCEPTION '������.� ������������ <%> ��� ���� ��� ��������� � ��������� � <%> �� <%>.', lfGet_Object_ValueData (inUserId), (SELECT InvNumber FROM Movement WHERE Id = inMovementId), DATE (vbOperDate);
      END IF;
  ELSE
  IF vbDescId = zc_Movement_Tax()
  THEN 
      IF lpGetAccessKey (inUserId, zc_Enum_Process_InsertUpdate_Movement_Tax()) -- (SELECT ProcessId FROM Object_Process_User_View WHERE UserId = inUserId AND ProcessId IN (zc_Enum_Process_InsertUpdate_Movement_Tax())))
         <> vbAccessKeyId AND COALESCE (vbAccessKeyId, 0) <> 0
      THEN
          RAISE EXCEPTION '������.� ������������ <%> ��� ���� ��� ��������� � ��������� � <%> �� <%>.', lfGet_Object_ValueData (inUserId), (SELECT InvNumber FROM Movement WHERE Id = inMovementId), DATE (vbOperDate);
      END IF;
  ELSE
  IF vbDescId = zc_Movement_TaxCorrective()
  THEN 
      IF lpGetAccessKey (inUserId, zc_Enum_Process_InsertUpdate_Movement_TaxCorrective()) -- (SELECT ProcessId FROM Object_Process_User_View WHERE UserId = inUserId AND ProcessId IN (zc_Enum_Process_InsertUpdate_Movement_TaxCorrective())))
         <> vbAccessKeyId AND COALESCE (vbAccessKeyId, 0) <> 0
      THEN
          RAISE EXCEPTION '������.� ������������ <%> ��� ���� ��� ��������� � ��������� � <%> �� <%>.', lfGet_Object_ValueData (inUserId), (SELECT InvNumber FROM Movement WHERE Id = inMovementId), DATE (vbOperDate);
      END IF;
  END IF;
  END IF;
  END IF;
  END IF;
  END IF;


  -- 3.1. ������� ��� ��������
  PERFORM lpDelete_MovementItemContainer (inMovementId);
  -- 3.2. ������� ��� �������� ��� ������
  PERFORM lpDelete_MovementItemReport (inMovementId);

  -- 4. ��������� ��������
  IF inMovementId <> 0
  THEN
      PERFORM lpInsert_MovementProtocol (inMovementId, inUserId, FALSE);
  END IF;

END;
$BODY$
  LANGUAGE plpgsql VOLATILE;
ALTER FUNCTION lpUnComplete_Movement (Integer, Integer) OWNER TO postgres;

/*-------------------------------------------------------------------------------
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.
 05.09.14                                        * add lpCheck_Movement_Status
 25.05.14                                        * add �������� ���� ��� <�������� �������>
 10.05.14                                        * add �������� <���������������>
 10.05.14                                        * add lpInsert_MovementProtocol
 06.10.13                                        * add inUserId
 29.08.13                                        * add lpDelete_MovementItemReport
 08.07.13                                        * rename to zc_Enum_Status_UnComplete
*/

-- ����
-- SELECT * FROM lpUnComplete_Movement (inMovementId:= 55, inUserId:= 2)
