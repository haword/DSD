-- Function: zfFormat_BarCode

DROP FUNCTION IF EXISTS zfFormat_BarCode (Integer, TVarChar);
DROP FUNCTION IF EXISTS zfFormat_BarCode (TVarChar, Integer);

CREATE OR REPLACE FUNCTION zfFormat_BarCode(
    IN inBarCodePref TVarChar,
    IN inId          Integer
)
RETURNS BIGINT AS
$BODY$
  DECLARE vbValue BIGINT;
BEGIN
     vbValue:= (inBarCodePref
             || CASE CHAR_LENGTH (inId :: TVarChar)
                     WHEN 0 THEN '000000000'
                     WHEN 1 THEN '00000000'
                     WHEN 2 THEN '0000000'
                     WHEN 3 THEN '000000'
                     WHEN 4 THEN '00000'
                     WHEN 5 THEN '0000'
                     WHEN 6 THEN '000'
                     WHEN 7 THEN '00'
                     WHEN 8 THEN '0'
                     ELSE ''
                END
             || inId :: TVarChar) :: BIGINT;
     
     RETURN (vbValue);

END;
$BODY$
LANGUAGE PLPGSQL IMMUTABLE;
ALTER FUNCTION zfFormat_BarCode (TVarChar, Integer) OWNER TO postgres;

/*-------------------------------------------------------------------------------*/
/*
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.   ������ �.�.
 01.02.15                        *
*/

-- ����
-- SELECT * FROM zfFormat_BarCode (zc_BarCodePref_Object(), 12345)
-- SELECT * FROM zfFormat_BarCode (zc_BarCodePref_Movement(), 12345)