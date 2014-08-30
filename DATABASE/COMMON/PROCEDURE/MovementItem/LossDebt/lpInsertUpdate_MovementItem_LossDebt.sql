-- Function: lpInsertUpdate_MovementItem_LossDebt ()

DROP FUNCTION IF EXISTS lpInsertUpdate_MovementItem_LossDebt (Integer, Integer, Integer, Integer, TFloat, TFloat, Boolean, Integer, Integer, Integer, Integer, Integer);

CREATE OR REPLACE FUNCTION lpInsertUpdate_MovementItem_LossDebt(
 INOUT ioId                  Integer   , -- ���� ������� <������� ���������>
    IN inMovementId          Integer   , -- ���� ���������
    IN inJuridicalId         Integer   , -- ��.����
    IN inPartnerId           Integer   , -- ����������
    IN inAmount              TFloat    , -- �����
    IN inSumm                TFloat    , -- ����� ������� (����)
    IN inIsCalculated        Boolean   , -- ����� �������������� �� ������� (��/���)
    IN inContractId          Integer   , -- �������
    IN inPaidKindId          Integer   , -- ��� ���� ������
    IN inInfoMoneyId         Integer   , -- ������ ����������
    IN inUnitId              Integer   , -- �������������
    IN inUserId              Integer     -- ������������
)                              
RETURNS Integer AS
$BODY$
   DECLARE vbIsInsert Boolean;
BEGIN
     -- ��������
     IF COALESCE (inJuridicalId, 0) = 0 AND inPaidKindId <> zc_Enum_PaidKind_SecondForm()
     THEN
         RAISE EXCEPTION '������.�� ����������� <����������� ����>.';
     END IF;
     IF COALESCE (inContractId, 0) = 0 AND inPaidKindId <> zc_Enum_PaidKind_SecondForm()
     THEN
         RAISE EXCEPTION '������.�� ���������� <� ���.>.';
     END IF;
     IF COALESCE (inPaidKindId, 0) = 0
     THEN
         RAISE EXCEPTION '������.�� ����������� <����� ������>.';
     END IF;
     IF COALESCE (inInfoMoneyId, 0) = 0
     THEN
         RAISE EXCEPTION '������.�� ����������� <�� ������ ����������>.';
     END IF;

     -- ��������
     IF EXISTS (SELECT MovementItem.Id
                FROM MovementItem
                     JOIN MovementItemLinkObject AS MILinkObject_InfoMoney
                                                 ON MILinkObject_InfoMoney.MovementItemId = MovementItem.Id
                                                AND MILinkObject_InfoMoney.DescId = zc_MILinkObject_InfoMoney()
                                                AND MILinkObject_InfoMoney.ObjectId = inInfoMoneyId
                     JOIN MovementItemLinkObject AS MILinkObject_Contract
                                                      ON MILinkObject_Contract.MovementItemId = MovementItem.Id
                                                     AND MILinkObject_Contract.DescId = zc_MILinkObject_Contract()
                                                     AND MILinkObject_Contract.ObjectId = inContractId
                     JOIN MovementItemLinkObject AS MILinkObject_PaidKind
                                                 ON MILinkObject_PaidKind.MovementItemId = MovementItem.Id
                                                AND MILinkObject_PaidKind.DescId = zc_MILinkObject_PaidKind()
                                                AND MILinkObject_PaidKind.ObjectId = inPaidKindId
                     LEFT JOIN MovementItemLinkObject AS MILinkObject_Partner
                                                 ON MILinkObject_Partner.MovementItemId = MovementItem.Id
                                                AND MILinkObject_Partner.DescId = zc_MILinkObject_Partner()
                WHERE MovementItem.MovementId = inMovementId
                  AND MovementItem.ObjectId = inJuridicalId
                  AND MovementItem.DescId = zc_MI_Master()
                  AND COALESCE (MILinkObject_Partner.ObjectId, 0) = COALESCE (inPartnerId, 0) -- AND inPartnerId <> 0
                  AND MovementItem.Id <> COALESCE (ioId, 0))
     THEN
         RAISE EXCEPTION '������.� ��������� ��� ���������� <%>% <%> <%> <%> <%> <%>.������������ ���������.', lfGet_Object_ValueData (inJuridicalId), CASE WHEN inPartnerId <> 0 THEN ' <' || lfGet_Object_ValueData (inPartnerId) || '>' ELSE '' END, lfGet_Object_ValueData (inPaidKindId), lfGet_Object_ValueData (inInfoMoneyId), lfGet_Object_ValueData (inContractId), inJuridicalId, inPartnerId;
     END IF;

     -- ������������ ������� ��������/�������������
     vbIsInsert:= COALESCE (ioId, 0) = 0;

     -- ��������� <������� ���������>
     ioId := lpInsertUpdate_MovementItem (ioId, zc_MI_Master(), inJuridicalId, inMovementId, inAmount, NULL);

     -- ��������� �������� <����� �������������� �� ������� (��/���)>
     PERFORM lpInsertUpdate_MovementItemBoolean (zc_MIBoolean_Calculated(), ioId, inIsCalculated);

     -- ��������� �������� <����� ������� (����)>
     PERFORM lpInsertUpdate_MovementItemFloat (zc_MIFloat_Summ(), ioId, inSumm);

     -- ��������� ����� � <�����������>
     PERFORM lpInsertUpdate_MovementItemLinkObject (zc_MILinkObject_Partner(), ioId, inPartnerId);

     -- ��������� ����� � <�������>
     PERFORM lpInsertUpdate_MovementItemLinkObject (zc_MILinkObject_Contract(), ioId, inContractId);

     -- ��������� ����� � <��� ���� ������>
     PERFORM lpInsertUpdate_MovementItemLinkObject (zc_MILinkObject_PaidKind(), ioId, inPaidKindId);

     -- ��������� ����� � <������ ����������>
     PERFORM lpInsertUpdate_MovementItemLinkObject (zc_MILinkObject_InfoMoney(), ioId, inInfoMoneyId);

     -- ��������� ����� � <�������������>
     PERFORM lpInsertUpdate_MovementItemLinkObject (zc_MILinkObject_Unit(), ioId, inUnitId);

     -- ����������� �������� ����� �� ���������
     PERFORM lpInsertUpdate_MovementFloat_TotalSumm (inMovementId);

     -- ��������� ��������
     PERFORM lpInsert_MovementItemProtocol (ioId, inUserId, vbIsInsert);

END;
$BODY$
  LANGUAGE plpgsql VOLATILE;

/*
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.   ������ �.
 27.08.14                                        * add inPartnerId
 16.05.14                                        * add lpInsert_MovementItemProtocol
 10.03.14                                        *
*/

-- ����
-- SELECT * FROM lpInsertUpdate_MovementItem_LossDebt (ioId:= 0, inMovementId:= 10, inGoodsId:= 1, inAmount:= 0, inAmountPartner:= 0, inPrice:= 1, inCountForPrice:= 1, inLiveWeight:= 0, inHeadCount:= 0, inPartionGoods:= '', inGoodsKindId:= 0, inSession:= '2')
