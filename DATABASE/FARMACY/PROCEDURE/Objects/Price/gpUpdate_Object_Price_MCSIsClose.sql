-- Function: gpInsertUpdate_Object_Price (Integer, Integer, Boolean, TVarChar)

DROP FUNCTION IF EXISTS gpUpdate_Object_Price_MCSIsClose (Integer, Integer, Boolean, TVarChar);

CREATE OR REPLACE FUNCTION gpUpdate_Object_Price_MCSIsClose(
    IN inUnitId              Integer   ,    -- ���� ������� < ������������� >
    IN inGoodsId             Integer   ,    -- �����
    IN inMCSIsClose          Boolean   ,    -- ��� ������
    IN inSession             TVarChar       -- ������ ������������
)
RETURNS Void
AS
$BODY$
    DECLARE
        vbUserId Integer;
        vbMCSIsClose Boolean;
        vbId Integer;
BEGIN
    -- �������� ���� ������������ �� ����� ���������
    vbUserId := inSession;

    -- �������� �������������
    IF COALESCE (inUnitId,0) = 0
    THEN
        RAISE EXCEPTION '������.������������� �� ����������.';
    END IF; 

    -- ������� ������ - ������� � ����� ����.-�����
    SELECT Price_Goods.ObjectId                  AS Id
         , COALESCE(MCS_isClose.ValueData,False) AS MCSIsClose
      INTO vbId, vbMCSIsClose
    FROM ObjectLink AS Price_Goods
        INNER JOIN ObjectLink AS ObjectLink_Price_Unit
                              ON ObjectLink_Price_Unit.ObjectId = Price_Goods.ObjectId
                             AND ObjectLink_Price_Unit.DescId = zc_ObjectLink_Price_Unit()
                             AND ObjectLink_Price_Unit.ChildObjectId = inUnitId
        LEFT JOIN ObjectBoolean AS MCS_isClose
                             ON MCS_isClose.ObjectId = Price_Goods.ObjectId
                            AND MCS_isClose.DescId = zc_ObjectBoolean_Price_MCSIsClose()
       WHERE Price_Goods.DescId = zc_ObjectLink_Price_Goods()
         AND Price_Goods.ChildObjectId = inGoodsId;
       
    IF (inMCSIsClose is not null) AND (COALESCE(vbMCSIsClose,False) <> inMCSIsClose)
    THEN
        PERFORM lpInsertUpdate_objectBoolean(zc_ObjectBoolean_Price_MCSIsClose(), vbId, inMCSIsClose);
        PERFORM lpInsertUpdate_objectDate(zc_ObjectDate_Price_MCSIsCloseDateChange(), vbId, CURRENT_DATE);
    END IF;
    
    -- ��������� ��������
    PERFORM lpInsert_ObjectProtocol (vbId, vbUserId);
    
END;
$BODY$
LANGUAGE plpgsql VOLATILE;

/*-------------------------------------------------------------------------------*/
/*
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.  ��������� �.�.
 15.07.17         *
*/

-- ����
-- SELECT * FROM gpUpdate_Object_Price_MCSIsClose()