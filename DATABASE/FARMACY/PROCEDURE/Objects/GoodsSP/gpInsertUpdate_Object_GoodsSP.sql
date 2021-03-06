-- Function: gpInsertUpdate_Object_GoodsSP()

DROP FUNCTION IF EXISTS gpInsertUpdate_Object_GoodsSP (Integer, TVarChar, Boolean, TFloat, TFloat, TVarChar, TVarChar, TVarChar, TVarChar);
DROP FUNCTION IF EXISTS gpInsertUpdate_Object_GoodsSP (Integer, Boolean, TFloat, TFloat, TFloat, TVarChar, TVarChar, TVarChar, TVarChar, TVarChar);
DROP FUNCTION IF EXISTS gpInsertUpdate_Object_GoodsSP (Integer, Boolean, TFloat, TFloat, TFloat,  TFloat, TFloat, TFloat, TFloat, TFloat, TFloat
                                                     , TDateTime, TVarChar, TVarChar, TVarChar, TVarChar, TVarChar, TVarChar, TVarChar, TVarChar);

DROP FUNCTION IF EXISTS gpInsertUpdate_Object_GoodsSP (Integer, Boolean, TFloat, TFloat,  TFloat, TFloat, TFloat, TFloat, TFloat, TFloat
                                                     , TDateTime, TVarChar, TVarChar, TVarChar, TVarChar, TVarChar, TVarChar, TVarChar, TVarChar);

DROP FUNCTION IF EXISTS gpInsertUpdate_Object_GoodsSP (Integer, Boolean, TFloat, TFloat,  TFloat, TFloat, TFloat, TFloat, TFloat, TFloat
                                                     , TVarChar, TVarChar, TVarChar, TVarChar, TVarChar, TVarChar, TVarChar, TVarChar, TVarChar);

DROP FUNCTION IF EXISTS gpInsertUpdate_Object_GoodsSP (Integer, Boolean, TFloat, TFloat,  TFloat, TFloat, TFloat, TFloat, TFloat, TFloat
                                                     , TVarChar, TVarChar, TVarChar, TVarChar, TVarChar, TVarChar, TVarChar, TVarChar
                                                     , TDateTime, TVarChar);


CREATE OR REPLACE FUNCTION gpInsertUpdate_Object_GoodsSP(
    IN inId                  Integer   ,    -- ���� ������� <�����> MainID
    IN inisSP                Boolean   ,    -- ��������� � ���. �������
    IN inPriceSP             TFloat    ,    -- ���������� ���� �� ��, ��� (���. ������)
   -- IN inGroupSP             TFloat    ,    -- ����� �������-����� � � ��� ��
    IN inCountSP             TFloat    ,    -- ʳ������ ������� ���������� ������ � ��������� �������� (���. ������)

    IN inColSP               TFloat    ,    --
    IN inPriceOptSP          TFloat    ,    --
    IN inPriceRetSP          TFloat    ,    --
    IN inDailyNormSP         TFloat    ,    --
    IN inDailyCompensationSP TFloat    ,    --
    IN inPaymentSP           TFloat    ,    --

    IN inDateReestrSP        TVarChar  ,    --
    IN inPack                TVarChar  ,    -- ���������
    IN inIntenalSPName       TVarChar  ,    -- ̳�������� ������������� ����� (���. ������)
    IN inBrandSPName         TVarChar  ,    -- ����������� ����� ���������� ������ (���. ������)
    IN inKindOutSPName       TVarChar  ,    -- ����� ������� (���. ������)
    IN inCodeATX             TVarChar  ,    --
    IN inMakerSP             TVarChar  ,    --
    IN inReestrSP            TVarChar  ,    --
    IN inInsertDateSP        TDateTime ,    --
    IN inSession             TVarChar       -- ������� ������������
)
RETURNS Void
AS
$BODY$
   DECLARE vbUserId Integer;
   DECLARE vbIntenalSPId Integer;
   DECLARE vbKindOutSPId Integer;
   DECLARE vbBrandSPId Integer;
   DECLARE vbName TVarChar;

   DECLARE vbId Integer;
   DECLARE text_var1 text;
BEGIN
     -- �������� ���� ������������ �� ����� ���������
     -- vbUserId:= lpCheckRight(inSession, zc_Enum_Process_...());
     vbUserId:= lpGetUserBySession (inSession);

     -- �������� <inName>
     IF COALESCE (inId, 0) = 0 THEN
        RAISE EXCEPTION '������.�������� <�����> ������ ���� �����������.';
     END IF;

    -- !!!����� �� �������� ������!!!
   /* inId:= (SELECT ObjectLink_Main.ChildObjectId
                        FROM ObjectLink AS ObjectLink_Child
                             LEFT JOIN ObjectLink AS ObjectLink_Main
                                                  ON ObjectLink_Main.ObjectId = ObjectLink_Child.ObjectId
                                                 AND ObjectLink_Main.DescId = zc_ObjectLink_LinkGoods_GoodsMain()
                        WHERE ObjectLink_Child.ChildObjectId = inId                      --Object_Goods.Id
                          AND ObjectLink_Child.DescId = zc_ObjectLink_LinkGoods_Goods());
   */

     -- �������� ����� "̳�������� ������������� ����� (���. ������)"
     -- ���� �� ������� ��������� ����� ������� � ����������
     vbIntenalSPId := (SELECT Object.Id FROM Object WHERE Object.DescId = zc_Object_IntenalSP() AND UPPER (TRIM(Object.ValueData)) LIKE UPPER (TRIM(inIntenalSPName)) );
     IF COALESCE (vbIntenalSPId, 0) = 0 AND COALESCE (inIntenalSPName, '')<> '' THEN
        -- ���������� ����� �������
        vbIntenalSPId := gpInsertUpdate_Object_IntenalSP (ioId     := 0
                                                        , inCode   := lfGet_ObjectCode(0, zc_Object_IntenalSP())
                                                        , inName   := TRIM(inIntenalSPName)
                                                        , inSession:= inSession
                                                          );
     END IF;
     -- �������� ����� "����������� ����� ���������� ������ (���. ������)"
     -- ���� �� ������� ��������� ����� ������� � ����������
     vbKindOutSPId := (SELECT Object.Id FROM Object WHERE Object.DescId = zc_Object_KindOutSP() AND UPPER (TRIM(Object.ValueData)) LIKE UPPER (TRIM(inKindOutSPName)));
     IF COALESCE (vbKindOutSPId, 0) = 0 AND COALESCE (inKindOutSPName, '')<> '' THEN
        -- ���������� ����� �������
        vbKindOutSPId := gpInsertUpdate_Object_KindOutSP (ioId     := 0
                                                        , inCode   := lfGet_ObjectCode(0, zc_Object_KindOutSP())
                                                        , inName   := TRIM(inKindOutSPName)
                                                        , inSession:= inSession
                                                          );
     END IF;
     -- �������� ����� "����� ������� (���. ������)"
     -- ���� �� ������� ��������� ����� ������� � ����������
     vbBrandSPId := (SELECT Object.Id FROM Object WHERE Object.DescId = zc_Object_BrandSP() AND UPPER (TRIM(Object.ValueData)) LIKE UPPER (TRIM(inBrandSPName)));
     IF COALESCE (vbBrandSPId, 0) = 0 AND COALESCE (inBrandSPName, '')<> '' THEN
        -- ���������� ����� �������
        vbBrandSPId := gpInsertUpdate_Object_BrandSP (ioId     := 0
                                                    , inCode   := lfGet_ObjectCode(0, zc_Object_BrandSP())
                                                    , inName   := TRIM(inBrandSPName)
                                                    , inSession:= inSession
                                                     );
     END IF;

     -- ���� � �.�. �� ������ ���� ������� � ���������� �, ���� ������� ��������
     IF COALESCE (inColSP, 0) <> 0
        THEN
            vbId := (SELECT ObjectFloat.ObjectId
                     FROM ObjectFloat
                     WHERE ObjectFloat.DescId = zc_ObjectFloat_Goods_ColSP()
                       AND ObjectFloat.ValueData = inColSP
                       AND ObjectFloat.ObjectId <> COALESCE (inId, 0)
                    );

            IF COALESCE (vbId, 0) <> 0
               THEN
                   --������� � �.�. ���� �����
                   PERFORM lpInsertUpdate_ObjectFloat (zc_ObjectFloat_Goods_ColSP(), vbId, Null);
            END IF;
     END IF;

    -- ��������� ����� � <>
    PERFORM lpInsertUpdate_ObjectLink (zc_ObjectLink_Goods_IntenalSP(), inId, vbIntenalSPId);
    -- ��������� ����� � <>
    PERFORM lpInsertUpdate_ObjectLink(zc_ObjectLink_Goods_BrandSP(), inId, vbBrandSPId);
    -- ��������� �������� <>
    PERFORM lpInsertUpdate_ObjectLink(zc_ObjectLink_Goods_KindOutSP(), inId, vbKindOutSPId );

    -- ��������� �������� <>
    PERFORM lpInsertUpdate_ObjectString(zc_ObjectString_Goods_Pack(), inId, inPack);

    -- ��������� �������� <>
    PERFORM lpInsertUpdate_ObjectFloat (zc_ObjectFloat_Goods_PriceSP(), inId, inPriceSP);
    -- ��������� �������� <>
    --PERFORM lpInsertUpdate_ObjectFloat (zc_ObjectFloat_Goods_GroupSP(), inId, inGroupSP);
    -- ��������� �������� <>
    PERFORM lpInsertUpdate_ObjectFloat (zc_ObjectFloat_Goods_CountSP(), inId, inCountSP);
    -- ��������� �������� <>
    PERFORM lpInsertUpdate_ObjectBoolean (zc_ObjectBoolean_Goods_SP(), inId, TRUE);

    -- ��������� �������� <>
    PERFORM lpInsertUpdate_ObjectFloat (zc_ObjectFloat_Goods_PriceOptSP(), inId, inPriceOptSP);
    -- ��������� �������� <>
    PERFORM lpInsertUpdate_ObjectFloat (zc_ObjectFloat_Goods_PriceRetSP(), inId, inPriceRetSP);
    -- ��������� �������� <>
    PERFORM lpInsertUpdate_ObjectFloat (zc_ObjectFloat_Goods_DailyNormSP(), inId, inDailyNormSP);
    -- ��������� �������� <>
    PERFORM lpInsertUpdate_ObjectFloat (zc_ObjectFloat_Goods_DailyCompensationSP(), inId, inDailyCompensationSP);
    -- ��������� �������� <>
    PERFORM lpInsertUpdate_ObjectFloat (zc_ObjectFloat_Goods_PaymentSP(), inId, inPaymentSP);
    -- ��������� �������� <>
    PERFORM lpInsertUpdate_ObjectFloat (zc_ObjectFloat_Goods_ColSP(), inId, inColSP);

    -- ��������� �������� <>
    PERFORM lpInsertUpdate_ObjectString(zc_ObjectString_Goods_CodeATX(), inId, inCodeATX);
    -- ��������� �������� <>
    PERFORM lpInsertUpdate_ObjectString(zc_ObjectString_Goods_ReestrSP(), inId, inReestrSP);
    -- ��������� �������� <>
    PERFORM lpInsertUpdate_ObjectString(zc_ObjectString_Goods_MakerSP(), inId, inMakerSP);
    -- ��������� �������� <>
    PERFORM lpInsertUpdate_ObjectString(zc_ObjectString_Goods_ReestrDateSP(), inId, inDateReestrSP);

    -- ��������� �������� <���� ��������>
    PERFORM lpInsertUpdate_ObjectDate (zc_ObjectDate_Protocol_InsertSP(), inId, inInsertDateSP);

     -- ��������� � ������� �������
    BEGIN
      IF NOT EXISTS(SELECT 1 FROM Object_Goods_SP WHERE Object_Goods_SP.Id = inId)
      THEN
        INSERT INTO Object_Goods_SP (id, isSP) VALUES (inId, False);
      END IF;

      UPDATE Object_Goods_SP SET isSP                = TRUE
                               , IntenalSPID         = vbIntenalSPId
                               , BrandSPID           = vbBrandSPId
                               , KindOutSPID         = vbKindOutSPId
                              -- , GroupSP             = inGroupSP
                               , PriceSP             = inPriceSP
                               , CountSP             = inCountSP
                               , PriceOptSP          = inPriceOptSP
                               , PriceRetSP          = inPriceRetSP
                               , DailyNormSP         = inDailyNormSP
                               , PaymentSP           = inPaymentSP
                               , ColSP               = inColSP
                               , DailyCompensationSP = inDailyCompensationSP
                               , ReestrDateSP        = inDateReestrSP
                               , MakerSP             = inMakerSP
                               , ReestrSP            = inReestrSP
                               , Pack                = inPack
                               , CodeATX             = inCodeATX
      WHERE Object_Goods_SP.Id = inId;
    EXCEPTION
       WHEN others THEN
         GET STACKED DIAGNOSTICS text_var1 = MESSAGE_TEXT;
         PERFORM lpAddObject_Goods_Temp_Error('gpInsertUpdate_Object_GoodsSP', text_var1::TVarChar, vbUserId);
    END;


    -- ��������� ��������
    PERFORM lpInsert_ObjectProtocol (inId, vbUserId);

END;
$BODY$
  LANGUAGE plpgsql VOLATILE;
/*
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.   ������ �.�.
 22.10.19                                                       *
 07.04.17         *
 04.04.17         *
 19.12.16         *
*/

-- ����
-- SELECT * FROM gpInsertUpdate_Object_GoodsSP (324, '17', True, 4::TFloat, 5::TFloat, 0, 0, 0, '3');