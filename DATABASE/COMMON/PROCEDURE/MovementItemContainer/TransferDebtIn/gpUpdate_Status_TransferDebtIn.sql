-- Function: gpUpdate_Status_TransferDebtIn()

DROP FUNCTION IF EXISTS gpUpdate_Status_TransferDebtIn (Integer, Integer, TVarChar);

CREATE OR REPLACE FUNCTION gpUpdate_Status_TransferDebtIn(
    IN inMovementId          Integer   , -- ���� ������� <��������>
 INOUT ioStatusCode          Integer   , -- ������ ���������. ������������ ������� ������ ����
   OUT outMessageText        Text      ,
    IN inSession             TVarChar    -- ������ ������������
)
RETURNS RECORD
AS
$BODY$
BEGIN

     CASE ioStatusCode
         WHEN zc_Enum_StatusCode_UnComplete() THEN
            PERFORM gpUnComplete_Movement_TransferDebtIn (inMovementId, inSession);
         WHEN zc_Enum_StatusCode_Complete() THEN
            outMessageText:= (SELECT tmp.outMessageText FROM gpComplete_Movement_TransferDebtIn (inMovementId, inSession) AS tmp);
         WHEN zc_Enum_StatusCode_Erased() THEN
            PERFORM gpSetErased_Movement_TransferDebtIn (inMovementId, inSession);
         ELSE
            RAISE EXCEPTION '��� ������� � ����� <%>', inStatusCode;
     END CASE;

     -- ������� ������ (����� �� �� ���������)
     ioStatusCode:= (SELECT Object.ObjectCode FROM Movement INNER JOIN Object ON Object.Id = Movement.StatusId WHERE Movement.Id = inMovementId);

END;
$BODY$
  LANGUAGE plpgsql VOLATILE;

/*
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.   ������ �.�.
 04.05.14                                        * del isLastComplete
 25.04.14         *
*/

-- ����
-- SELECT * FROM gpUpdate_Status_TransferDebtIn (ioId:= 0, inSession:= zfCalc_UserAdmin())
