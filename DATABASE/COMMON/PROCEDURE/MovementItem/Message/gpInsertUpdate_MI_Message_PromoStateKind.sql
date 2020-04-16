-- Function: gpInsertUpdate_MI_Message_PromoStateKind()

DROP FUNCTION IF EXISTS gpInsertUpdate_MI_Message_PromoStateKind (Integer, Integer, Integer, Boolean, TVarChar, TVarChar);

CREATE OR REPLACE FUNCTION gpInsertUpdate_MI_Message_PromoStateKind(
 INOUT ioId                  Integer   , --
    IN inMovementId          Integer   , -- ���� ������� <��������>
    IN inPromoStateKindId    Integer   ,
    IN inIsQuickly           Boolean   ,
    IN inComment             TVarChar  ,
    IN inSession             TVarChar    -- ������ ������������
)
RETURNS Integer AS
$BODY$
  DECLARE vbUserId   Integer;
  DECLARE vbIsInsert Boolean;
  DECLARE vbAmount   TFloat;
  DECLARE vbIsChange Boolean;
BEGIN
     -- �������� ���� ������������ �� ����� ���������
     vbUserId := lpCheckRight (inSession, zc_Enum_Process_InsertUpdate_MI_Promo());

     -- ������������ ������� ��������/�������������
     vbIsInsert:= COALESCE (ioId, 0) = 0;

     vbAmount := (CASE WHEN inIsQuickly = TRUE THEN 1 ELSE 0 END);


     -- ��������
     IF COALESCE (inPromoStateKindId, 0) = 0
     THEN
         RAISE EXCEPTION '������.��������� �� ����� ���� ������.';
     END IF;

     -- ��������
     IF EXISTS (SELECT 1 FROM MovementItem WHERE MovementItem.Id = ioId AND MovementItem.ObjectId = zc_Enum_PromoStateKind_Start())
        AND inPromoStateKindId <> zc_Enum_PromoStateKind_Start()
     THEN
         RAISE EXCEPTION '������.��������� <%> �� ����� ���� �������� �� <%>.', lfGet_Object_ValueData_sh (zc_Enum_PromoStateKind_Start()), lfGet_Object_ValueData_sh (inPromoStateKindId);
     END IF;


     -- ����������
     vbIsChange:= inPromoStateKindId <> COALESCE ((SELECT MovementItem.ObjectId FROM MovementItem WHERE MovementItem.Id = ioId), 0);

     -- ��������� <������� ���������>
     ioId:= lpInsertUpdate_MovementItem (ioId, zc_MI_Message(), inPromoStateKindId, inMovementId, vbAmount, NULL);

     -- ��������� �������� <>
     PERFORM lpInsertUpdate_MovementItemString (zc_MIString_Comment(), ioId, inComment);


     IF vbIsInsert = TRUE
     THEN
         -- ��������� ����� � <>
         PERFORM lpInsertUpdate_MovementItemLinkObject (zc_MILinkObject_Insert(), ioId, vbUserId);
         -- ��������� �������� <>
         PERFORM lpInsertUpdate_MovementItemDate (zc_MIDate_Insert(), ioId, CURRENT_TIMESTAMP);
     END IF;


     IF vbIsChange = TRUE
     THEN
         -- !!!����������� ��� ��������/������� + ��������� ������!!!
         PERFORM lpUpdate_MI_Sign_Promo_recalc (inMovementId, inPromoStateKindId, vbUserId);


         -- ����� ��������� - � ��������� � �����
         PERFORM lpInsertUpdate_MovementLinkObject (zc_MovementLinkObject_PromoStateKind(), inMovementId, tmp.ObjectId)
               , lpInsertUpdate_MovementFloat (zc_MovementFloat_PromoStateKind(), inMovementId, tmp.Amount)
                  -- ��������� �������� <���� ������������>
               , lpInsertUpdate_MovementDate (zc_MovementDate_Check(), inMovementId
                                            , CASE WHEN inPromoStateKindId = zc_Enum_PromoStateKind_Complete() THEN CURRENT_DATE ELSE NULL END
                                             )
                  -- ��������� �������� <�����������>
               , lpInsertUpdate_MovementBoolean (zc_MovementBoolean_Checked(), inMovementId
                                               , CASE WHEN inPromoStateKindId = zc_Enum_PromoStateKind_Complete() THEN TRUE ELSE FALSE END
                                                )

         FROM (SELECT MI.ObjectId, MI.Amount
               FROM MovementItem AS MI
                    JOIN Object ON Object.Id = MI.ObjectId AND Object.DescId = zc_Object_PromoStateKind()
               WHERE MI.MovementId = inMovementId
                 AND MI.DescId     = zc_MI_Message()
                 AND MI.isErased   = FALSE
               ORDER BY MI.Id DESC
               LIMIT 1
              ) AS tmp;

     END IF;
/*
    RAISE EXCEPTION '������.<%>  %', (SELECT zfCalc_WordNumber_Split (tmp.strIdSign,   ',', vbUserId :: TVarChar)
                            || '  _  ' || zfCalc_WordNumber_Split (tmp.strIdSignNo, ',', vbUserId :: TVarChar)
                                   FROM lpSelect_MI_Sign (inMovementId:= inMovementId) AS tmp)
                                , (SELECT count(*) FROM MovementItem WHERE MovementId = inMovementId and DescId = zc_MI_Sign())
                                   ;
*/


     -- ��������� ��������
     PERFORM lpInsert_MovementItemProtocol (ioId, vbUserId, vbIsInsert);

END;
$BODY$
  LANGUAGE PLPGSQL VOLATILE;

/*
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.  ���������� �.�.
 01.04.20         *
*/

-- ����
--