-- Function: gpInsertUpdate_MI_EDI()

DROP FUNCTION IF EXISTS gpInsertUpdate_MI_EDIOrder(Integer, Integer, TVarChar, TVarChar, TFloat, TVarChar);
DROP FUNCTION IF EXISTS gpInsertUpdate_MI_EDIOrder(Integer, Integer, TVarChar, TVarChar, TFloat, TFloat, TVarChar);

CREATE OR REPLACE FUNCTION gpInsertUpdate_MI_EDIOrder(
    IN inMovementId          Integer   , -- ���� ������� <��������>
    IN inGoodsPropertyId     Integer   , 
    IN inGoodsName           TVarChar  , -- �����
    IN inGLNCode             TVarChar  , -- �����
    IN inAmountOrder         TFloat    , -- ���������� ������
    IN inPriceOrder          TFloat    , -- ���� �� �������
    IN inSession             TVarChar    -- ������ ������������
)                              
RETURNS VOID AS
$BODY$
   DECLARE vbUserId   Integer;
   DECLARE vbIsInsert Boolean;

   DECLARE vbGoodsId        Integer;
   DECLARE vbGoodsKindId    Integer;
   DECLARE vbMovementItemId Integer;
BEGIN
     -- �������� ���� ������������ �� ����� ���������
     -- PERFORM lpCheckRight (inSession, zc_Enum_Process_InsertUpdate_MovementItem_EDI());
     vbUserId:= lpGetUserBySession (inSession);


     -- ��������
     IF 1 < (SELECT COUNT (*)
             FROM MovementItemString 
                  INNER JOIN MovementItem ON MovementItem.Id = MovementItemString.MovementItemId 
                                         AND MovementItem.MovementId = inMovementId
                                         AND MovementItem.DescId = zc_MI_Master() 
                                         AND MovementItem.isErased = FALSE
             WHERE MovementItemString.ValueData = inGLNCode
               AND MovementItemString.DescId = zc_MIString_GLNCode()
             )
     THEN
         -- ��������� ��������� ... �����������, �.�. �� �������� ��� ��� ��������
         /**/
         UPDATE MovementItem SET isErased = TRUE
         WHERE MovementItem.MovementId = inMovementId
           AND MovementItem.DescId = zc_MI_Master() 
           AND MovementItem.isErased = FALSE
           AND MovementItem.Id IN (SELECT tmp.Id
                                   FROM
                                 (SELECT MovementItem.Id
                                        , ROW_NUMBER() OVER (PARTITION BY MovementItemString.ValueData ORDER BY MovementItem.Id ASC) AS Ord
                                   FROM MovementItemString 
                                        INNER JOIN MovementItem ON MovementItem.Id = MovementItemString.MovementItemId 
                                                               AND MovementItem.MovementId = inMovementId
                                                               AND MovementItem.DescId = zc_MI_Master() 
                                                               AND MovementItem.isErased = FALSE
                                   WHERE MovementItemString.ValueData = inGLNCode
                                     AND MovementItemString.DescId = zc_MIString_GLNCode()
                                  ) AS tmp
                                  WHERE tmp.Ord = 1
                                  );
         /**/

         -- �������� ����� �����������
         IF 1 < (SELECT COUNT (*)
                 FROM MovementItemString 
                      INNER JOIN MovementItem ON MovementItem.Id = MovementItemString.MovementItemId 
                                             AND MovementItem.MovementId = inMovementId
                                             AND MovementItem.DescId = zc_MI_Master() 
                                             AND MovementItem.isErased = FALSE
                 WHERE MovementItemString.ValueData = inGLNCode
                   AND MovementItemString.DescId = zc_MIString_GLNCode()
                 )
         THEN
             RAISE EXCEPTION '������.� ��������� EDI � <%> �� <%> ������������ ������ � GLN = <%>', (SELECT Movement.InvNumber FROM Movement WHERE Movement.Id = inMovementId AND Movement.DescId = zc_Movement_EDI())
                                                                                                  , DATE ((SELECT Movement.OperDate  FROM Movement WHERE Movement.Id = inMovementId AND Movement.DescId = zc_Movement_EDI()))
                                                                                                  , inGLNCode;
        END IF;
     END IF;

     -- ������� ������� (�� ���� ���� ����� - ���� GLN-���)
     vbMovementItemId := COALESCE((SELECT MovementItem.Id
                                   FROM MovementItemString 
                                        JOIN MovementItem ON MovementItem.Id = MovementItemString.MovementItemId 
                                                         AND MovementItem.MovementId = inMovementId
                                                         AND MovementItem.DescId = zc_MI_Master() 
                                                         AND MovementItem.isErased = FALSE
                                   WHERE MovementItemString.ValueData = inGLNCode
                                     AND MovementItemString.DescId = zc_MIString_GLNCode()), 0);

     -- ���� ���� �������������
     IF COALESCE (inGoodsPropertyId, 0) <> 0
     THEN
         -- ������� vbGoodsId � vbGoodsKindId
         SELECT ObjectLink_GoodsPropertyValue_Goods.ChildObjectId     AS GoodsId
              , ObjectLink_GoodsPropertyValue_GoodsKind.ChildObjectId AS GoodsKindId
                INTO vbGoodsId, vbGoodsKindId
         FROM ObjectString AS ObjectString_ArticleGLN
              JOIN ObjectLink AS ObjectLink_GoodsPropertyValue_GoodsProperty
                              ON ObjectLink_GoodsPropertyValue_GoodsProperty.ObjectId      = ObjectString_ArticleGLN.objectid
                             AND ObjectLink_GoodsPropertyValue_GoodsProperty.DescId        = zc_ObjectLink_GoodsPropertyValue_GoodsProperty()
                             AND ObjectLink_GoodsPropertyValue_GoodsProperty.ChildObjectId = inGoodsPropertyId
              LEFT JOIN ObjectLink AS ObjectLink_GoodsPropertyValue_GoodsKind
                                   ON ObjectLink_GoodsPropertyValue_GoodsKind.ObjectId = ObjectString_ArticleGLN.objectid
                                  AND ObjectLink_GoodsPropertyValue_GoodsKind.DescId   = zc_ObjectLink_GoodsPropertyValue_GoodsKind()
              LEFT JOIN ObjectLink AS ObjectLink_GoodsPropertyValue_Goods
                                   ON ObjectLink_GoodsPropertyValue_Goods.ObjectId = ObjectString_ArticleGLN.objectid
                                  AND ObjectLink_GoodsPropertyValue_Goods.DescId   = zc_ObjectLink_GoodsPropertyValue_Goods()
         WHERE ObjectString_ArticleGLN.DescId    = zc_ObjectString_GoodsPropertyValue_ArticleGLN()           
           AND ObjectString_ArticleGLN.ValueData = inGLNCode;
     END IF;


     -- ���������� ������� ��������/�������������
     vbIsInsert:= COALESCE (vbMovementItemId, 0) = 0;

     -- ��������� <������� ���������>
     vbMovementItemId := lpInsertUpdate_MovementItem (vbMovementItemId, zc_MI_Master(), vbGoodsId, inMovementId, inAmountOrder, NULL);

     -- ���������
     PERFORM lpInsertUpdate_MovementItemString (zc_MIString_GLNCode(), vbMovementItemId, inGLNCode);

     -- ���������
     PERFORM lpInsertUpdate_MovementItemString (zc_MIString_GoodsName(), vbMovementItemId, inGoodsName);

     -- ��������� ����� � <���� �������>
     PERFORM lpInsertUpdate_MovementItemLinkObject (zc_MILinkObject_GoodsKind(), vbMovementItemId, vbGoodsKindId);

     -- ��������� <���� �� �������>
     PERFORM lpInsertUpdate_MovementItemFloat (zc_MIFloat_Price(), vbMovementItemId, inPriceOrder);

     -- ��������
     IF 1 < (SELECT COUNT (*)
             FROM MovementItemString
                  INNER JOIN MovementItem ON MovementItem.Id = MovementItemString.MovementItemId 
                                         AND MovementItem.MovementId = inMovementId
                                         AND MovementItem.DescId = zc_MI_Master() 
                                         AND MovementItem.isErased = FALSE
             WHERE MovementItemString.ValueData = inGLNCode
               AND MovementItemString.DescId = zc_MIString_GLNCode())
     THEN
         RAISE EXCEPTION '������.� ��������� EDI � <%> �� <%> ������������ ������ � GLN = <%>. ��������� �������� ����� 25 ���.'
                                                                                              , (SELECT Movement.InvNumber FROM Movement WHERE Movement.Id = inMovementId AND Movement.DescId = zc_Movement_EDI())
                                                                                              , DATE ((SELECT Movement.OperDate  FROM Movement WHERE Movement.Id = inMovementId AND Movement.DescId = zc_Movement_EDI()))
                                                                                              , inGLNCode;
     END IF;


     -- �������� ����� ������������
     IF vbIsInsert = TRUE
     THEN
         PERFORM lpInsert_LockUnique (inKeyData:= 'MI'
                                        || ';' || zc_Movement_EDI() :: TVarChar
                                        || ';' || inMovementId :: TVarChar
                                        || ';' || inGLNCode
                                    , inUserId:= vbUserId);
     END IF;


     -- ������ 1 ���
     IF vbIsInsert = TRUE
     THEN
         -- ��������� ��������
         PERFORM lpInsert_MovementItemProtocol (vbMovementItemId, vbUserId, vbIsInsert);
     END iF;

END;
$BODY$
LANGUAGE PLPGSQL VOLATILE;

/*
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.
 29.05.14                         * 
*/

-- ����
-- SELECT * FROM gpInsertUpdate_MI_EDIOrder (inMovementId:= 16086413, inGoodsPropertyId:= 536616, inGoodsName:= '������� ���� ������� �/� �/� 1/2 �/� ���', inGLNCode:= '9-0034180', inAmountOrder:= 0.6, inPriceOrder:= 215.7, inSession:= '5')
