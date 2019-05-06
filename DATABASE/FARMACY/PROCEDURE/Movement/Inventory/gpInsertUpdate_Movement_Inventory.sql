-- Function: gpInsertUpdate_Movement_Inventory()

DROP FUNCTION IF EXISTS gpInsertUpdate_Movement_Inventory (Integer, TVarChar, TDateTime, Integer, TVarChar);
DROP FUNCTION IF EXISTS gpInsertUpdate_Movement_Inventory (Integer, TVarChar, TDateTime, Integer, Boolean, TVarChar);

CREATE OR REPLACE FUNCTION gpInsertUpdate_Movement_Inventory(
 INOUT ioId                  Integer   , -- ���� ������� <�������� ������� ����������>
    IN inInvNumber           TVarChar  , -- ����� ���������
    IN inOperDate            TDateTime , -- ���� ���������
    IN inUnitId              Integer   , -- �������������
    IN inFullInvent          Boolean   , -- ������ ��������������
    IN inSession             TVarChar    -- ������ ������������
)                               
RETURNS Integer AS
$BODY$
   DECLARE vbUserId Integer;
   DECLARE vbUserUnitId Integer;
   DECLARE vbOldUnitId Integer;
   DECLARE vbUnitKey TVarChar;
BEGIN
     -- �������� ���� ������������ �� ����� ���������
     vbUserId := inSession; -- lpCheckRight (inSession, zc_Enum_Process_InsertUpdate_Movement_Inventory());
     
     IF EXISTS(SELECT * FROM gpSelect_Object_RoleUser (inSession) AS Object_RoleUser
               WHERE Object_RoleUser.ID = vbUserId AND Object_RoleUser.RoleId = 308121) -- ��� ���� "������ ������"
     THEN
     
        vbUnitKey := COALESCE(lpGet_DefaultValue('zc_Object_Unit', vbUserId), '');
        IF vbUnitKey = '' THEN
          vbUnitKey := '0';
        END IF;
        vbUserUnitId := vbUnitKey::Integer;
        
        IF COALESCE (vbUserUnitId, 0) = 0
        THEN 
          RAISE EXCEPTION '������. �� ������� ������������� ����������.';     
        END IF;     
        
        IF COALESCE (ioId, 0) <> 0
        THEN

          SELECT 
            MLO_Unit.ObjectId 
          INTO
            vbOldUnitId
          FROM Movement
               INNER JOIN MovementLinkObject AS MLO_Unit
                                             ON MLO_Unit.MovementId = Movement.Id
                                            AND MLO_Unit.DescId = zc_MovementLinkObject_Unit()
          WHERE Movement.Id = ioId;

          IF COALESCE (vbOldUnitId, 0) <> COALESCE (inUnitId, 0)
          THEN
            RAISE EXCEPTION '������. ��������� ������������� ���������..';                       
          END IF;
        END IF;
        
        IF COALESCE (inUnitId, 0) = 0
        THEN 
          RAISE EXCEPTION '������. �� ��������� �������������..';             
        END IF;     

        IF COALESCE (inUnitId, 0) <> COALESCE (vbUserUnitId, 0) 
        THEN 
          RAISE EXCEPTION '������. ��� ��������� �������� ������ � �������������� <%>.', (SELECT ValueData FROM Object WHERE ID = vbUserUnitId);     
        END IF;     
        
        IF EXISTS(SELECT 1
                  FROM Movement

                       INNER JOIN MovementLinkObject AS MovementLinkObject_Unit
                                                     ON MovementLinkObject_Unit.MovementId = Movement.Id
                                                    AND MovementLinkObject_Unit.DescId = zc_MovementLinkObject_Unit()

                       INNER JOIN MovementLinkObject AS MovementLinkObject_CashRegister
                                                     ON MovementLinkObject_CashRegister.MovementId = Movement.Id
                                                    AND MovementLinkObject_CashRegister.DescId = zc_MovementLinkObject_CashRegister()

                  WHERE Movement.OperDate >= DATE_TRUNC ('DAY', CURRENT_DATE)
                    AND Movement.OperDate < DATE_TRUNC ('DAY', CURRENT_DATE) + INTERVAL '1 DAY'
                    AND Movement.DescId = zc_Movement_Check()
                    AND MovementLinkObject_Unit.ObjectId = inUnitId
                    AND Movement.StatusId = zc_Enum_Status_Complete()) AND
           (SELECT MAX(Movement.OperDate)
            FROM Movement

                 INNER JOIN MovementLinkObject AS MovementLinkObject_Unit
                                               ON MovementLinkObject_Unit.MovementId = Movement.Id
                                              AND MovementLinkObject_Unit.DescId = zc_MovementLinkObject_Unit()

                 INNER JOIN MovementLinkObject AS MovementLinkObject_CashRegister
                                               ON MovementLinkObject_CashRegister.MovementId = Movement.Id
                                              AND MovementLinkObject_CashRegister.DescId = zc_MovementLinkObject_CashRegister()

            WHERE Movement.OperDate >= DATE_TRUNC ('DAY', CURRENT_DATE)
              AND Movement.OperDate < DATE_TRUNC ('DAY', CURRENT_DATE) + INTERVAL '1 DAY'
              AND Movement.DescId = zc_Movement_Check()
              AND MovementLinkObject_Unit.ObjectId = 183292
              AND Movement.StatusId = zc_Enum_Status_Complete()) > 
            COALESCE ((SELECT MAX(EmployeeWorkLog.DateZReport)
                       FROM EmployeeWorkLog
                       WHERE EmployeeWorkLog.DateLogIn >= DATE_TRUNC ('DAY', CURRENT_DATE)
                         AND EmployeeWorkLog.DateLogIn < DATE_TRUNC ('DAY', CURRENT_DATE) + INTERVAL '1 DAY'
                         AND EmployeeWorkLog.UnitId = inUnitId
                         AND EmployeeWorkLog.DateZReport IS NOT NULL),DATE_TRUNC ('DAY', CURRENT_DATE)) 
        THEN 
          RAISE EXCEPTION '������. ����� �� ������� ���������� �������� � ��������������� ���������.';     
        END IF;             
     END IF;     

     -- ��������� <��������>
     ioId := lpInsertUpdate_Movement_Inventory (ioId               := ioId
                                              , inInvNumber        := inInvNumber
                                              , inOperDate         := inOperDate
                                              , inUnitId           := inUnitId
                                              , inFullInvent       := inFullInvent
                                              , inUserId           := vbUserId
                                               );
END;
$BODY$
  LANGUAGE plpgsql VOLATILE;
  
ALTER FUNCTION gpInsertUpdate_Movement_Inventory (Integer, TVarChar, TDateTime, Integer, Boolean, TVarChar) OWNER TO postgres;
/*
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.    ��������� �.�.   ������ �.�.
 17.12.18                                                                         *
 16.09.15                                                          * + FullInvent
 11.07.15                                                          *
*/