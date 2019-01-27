-- Function: gpSetErased_Movement_IncomeCost (Integer, TVarChar)

DROP FUNCTION IF EXISTS gpSetErased_Movement_IncomeCost (Integer, TVarChar);

CREATE OR REPLACE FUNCTION gpSetErased_Movement_IncomeCost(
    IN inMovementId        Integer               , -- ���� ���������
    IN inSession           TVarChar DEFAULT ''     -- ������ ������������
)
RETURNS VOID
AS
$BODY$
  DECLARE vbUserId Integer;
BEGIN
     -- �������� ���� ������������ �� ����� ���������
     vbUserId:= lpCheckRight (inSession, zc_Enum_Process_SetErased_Income());

     -- ������� ��������
     PERFORM lpSetErased_Movement (inMovementId := inMovementId
                                 , inUserId     := vbUserId
                                  );


END;
$BODY$
  LANGUAGE plpgsql VOLATILE;

/*
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.
 13.01.19                                        *
*/

-- ����
-- SELECT * FROM gpSetErased_Movement_IncomeCost (inMovementId:= 149639, inSession:= zfCalc_UserAdmin())