-- Function: gpDelete_Cash_AccommodationAll()

DROP FUNCTION IF EXISTS gpDelete_Cash_AccommodationAll (TVarChar);

CREATE OR REPLACE FUNCTION gpDelete_Cash_AccommodationAll(
    IN inSession               TVarChar     -- ������ ������������
)
  RETURNS Void 
AS
$BODY$
   DECLARE vbUserId Integer;
   DECLARE vbUnitId Integer;
   DECLARE vbUnitKey TVarChar;
BEGIN
   -- �������� ���� ������������ �� ����� ���������
    vbUserId:= lpGetUserBySession (inSession);
    vbUnitKey := COALESCE(lpGet_DefaultValue('zc_Object_Unit', vbUserId), '');
    IF vbUnitKey = '' THEN
        RAISE EXCEPTION '�� ���������� �������������';
    END IF;
    vbUnitId := vbUnitKey::Integer;
    
    
      -- ������� ����� � <������������> ���� ����
    IF EXISTS (SELECT * FROM AccommodationLincGoods WHERE UnitId = vbUnitId)
    THEN
      DELETE FROM AccommodationLincGoods WHERE AccommodationLincGoods.UnitId = vbUnitId;
    END IF;
          
END;$BODY$
  LANGUAGE plpgsql VOLATILE;


-------------------------------------------------------------------------------
/*
 ������� ����������: ����, �����
               ������ �.�.
 08.05.19         *
*/

