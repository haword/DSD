-- Function: gpSetErased_Movement_IlliquidUnit (Integer, TVarChar)

DROP FUNCTION IF EXISTS gpSetErased_Movement_IlliquidUnit (Integer, TVarChar);

CREATE OR REPLACE FUNCTION gpSetErased_Movement_IlliquidUnit(
    IN inMovementId        Integer               , -- ���� ���������
    IN inSession           TVarChar DEFAULT ''     -- ������ ������������
)
RETURNS VOID
AS
$BODY$
  DECLARE vbUserId Integer;
BEGIN
    -- �������� ���� ������������ �� ����� ���������
    -- vbUserId:= lpCheckRight (inSession, zc_Enum_Process_SetErased_IlliquidUnit());
    vbUserId:= lpGetUserBySession (inSession);


    -- ������� ��������
    PERFORM lpSetErased_Movement (inMovementId := inMovementId
                                 , inUserId     := vbUserId);

END;
$BODY$
  LANGUAGE plpgsql VOLATILE;

/*
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.   ������ �.�.
 23.12.19                                                       *
*/
