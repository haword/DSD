-- Function: gpSetErased_Movement_TransferDebtIn (Integer, TVarChar)

DROP FUNCTION IF EXISTS gpSetErased_Movement_TransferDebtIn (Integer, TVarChar);

CREATE OR REPLACE FUNCTION gpSetErased_Movement_TransferDebtIn(
    IN inMovementId        Integer               , -- ���� ���������
    IN inSession           TVarChar DEFAULT ''     -- ������ ������������
)
RETURNS VOID
AS
$BODY$
  DECLARE vbUserId Integer;
BEGIN
     -- �������� ���� ������������ �� ����� ���������
     vbUserId:= lpCheckRight(inSession, zc_Enum_Process_SetErased_TransferDebtIn());

     -- ������� ��������
     PERFORM lpSetErased_Movement (inMovementId := inMovementId
                                 , inUserId     := vbUserId);

END;
$BODY$
  LANGUAGE plpgsql VOLATILE;

/*
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.   ������ �.�.
 25.04.14         *
*/

-- ����
-- SELECT * FROM gpSetErased_Movement_TransferDebtIn (inMovementId:= 149639, inSession:= zfCalc_UserAdmin())
