-- Function: gpInsertUpdate_Object_PriceListItem_From_Excel (Integer, Integer, TFloat, TVarChar)

DROP FUNCTION IF EXISTS gpInsertUpdate_Object_PriceListItem_From_Excel (TDateTime, Integer, Integer, TVarChar, TFloat, TVarChar);

CREATE OR REPLACE FUNCTION gpInsertUpdate_Object_PriceListItem_From_Excel(
    IN inOperDate        TDateTime,
    IN inPriceListId     Integer  , -- ����� ����
    IN inGoodsCode       Integer  , -- Code �����
    IN inGoodsKindName   TVarChar , -- ��� ������
    IN inPriceValue      TFloat   ,  -- ����
    IN inSession         TVarChar -- ������ ������������
)
RETURNS VOID AS
$BODY$
    DECLARE vbUserId Integer;
    DECLARE vbGoodsId Integer;
    DECLARE vbGoodsKindId Integer;
BEGIN
    -- �������� ���� ������������ �� ����� ���������
    vbUserId:= lpCheckRight(inSession, zc_Enum_Process_InsertUpdate_ObjectHistory_PriceListItem());


    IF COALESCE(inPriceListId,0) = 0
    THEN
        RAISE EXCEPTION '������.�� ������� �����-����.';
    END IF;
    
    IF COALESCE (TRIM (inGoodsKindName), '') <> ''
    THEN 
         -- ����� ���� ������
         vbGoodsKindId := (SELECT Object.Id FROM Object WHERE Object.DescId = zc_Object_GoodsKind() AND Object.ValueData ILIKE TRIM (inGoodsKindName));
         IF COALESCE (vbGoodsKindId, 0) = 0
         THEN
             RAISE EXCEPTION '������.�������� ��� ������ = <%> �� ������.', inGoodsKindName;
         END IF;
    END IF;
    
    -- ����� ������ �� ����
    vbGoodsId := (SELECT Object.Id FROM Object WHERE Object.DescId = zc_Object_Goods() AND Object.ObjectCode = inGoodsCode);
    --
    IF COALESCE (vbGoodsId, 0) = 0
    THEN
        RAISE EXCEPTION '������.�������� ��� ������ = <%> �� ������.', inGoodsCode;
    END IF;

 
    IF inPriceValue < 0
    THEN
        RAISE EXCEPTION '������. ���� = <%> �� ����� ���� ������ ����.', inPriceValue;
    END IF;
   
    -- 
    PERFORM lpInsertUpdate_ObjectHistory_PriceListItem (ioId          := 0
                                                      , inPriceListId := inPriceListId
                                                      , inGoodsId     := vbGoodsId
                                                      , inGoodsKindId := vbGoodsKindId
                                                      , inOperDate    := inOperDate
                                                      , inValue       := inPriceValue
                                                      , inUserId      := vbUserId
                                                       );
    IF 1=1 AND COALESCE (vbGoodsKindId, 0) = 0
    THEN
        PERFORM lpInsertUpdate_ObjectHistory_PriceListItem (ioId          := 0
                                                          , inPriceListId := inPriceListId
                                                          , inGoodsId     := vbGoodsId
                                                          , inGoodsKindId := OL_PriceListItem_GoodsKind.ChildObjectId
                                                          , inOperDate    := inOperDate
                                                          , inValue       := inPriceValue
                                                          , inUserId      := vbUserId
                                                           )
        FROM ObjectLink AS OL_PriceListItem_Goods
             JOIN ObjectLink AS OL_PriceListItem_PriceList
                             ON OL_PriceListItem_PriceList.ObjectId      = OL_PriceListItem_Goods.ObjectId
                            AND OL_PriceListItem_PriceList.DescId        = zc_ObjectLink_PriceListItem_PriceList()
                            AND OL_PriceListItem_PriceList.ChildObjectId = inPriceListId
             JOIN ObjectLink AS OL_PriceListItem_GoodsKind
                             ON OL_PriceListItem_GoodsKind.ObjectId      = OL_PriceListItem_Goods.ObjectId
                            AND OL_PriceListItem_GoodsKind.DescId        = zc_ObjectLink_PriceListItem_GoodsKind()
                            AND OL_PriceListItem_GoodsKind.ChildObjectId > 0
        WHERE OL_PriceListItem_Goods.DescId        = zc_ObjectLink_PriceListItem_Goods()
          AND OL_PriceListItem_Goods.ChildObjectId = vbGoodsId
       ;
    END IF;

END;
$BODY$
  LANGUAGE plpgsql VOLATILE;

/*-------------------------------------------------------------------------------*/
/*
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.
 24.03.20         *
*/

-- ����