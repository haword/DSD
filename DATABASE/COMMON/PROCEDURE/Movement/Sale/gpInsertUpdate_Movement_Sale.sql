-- Function: gpInsertUpdate_Movement_Sale()

DROP FUNCTION IF EXISTS gpInsertUpdate_Movement_Sale (integer, TVarChar, TVarChar, TVarChar, TDateTime, TDateTime, Boolean, Boolean, TFloat, TFloat, Integer, Integer, Integer, Integer, Integer, Integer, Integer, TVarChar);
DROP FUNCTION IF EXISTS gpInsertUpdate_Movement_Sale (integer, TVarChar, TVarChar, TVarChar, TDateTime, TDateTime, Boolean, Boolean, TFloat, TFloat, Integer, Integer, Integer, Integer, Integer, Integer, Integer, Integer, Integer, TVarChar);

CREATE OR REPLACE FUNCTION gpInsertUpdate_Movement_Sale(
 INOUT ioId                  Integer   , -- ���� ������� <�������� �����������>
    IN inInvNumber           TVarChar  , -- ����� ���������
    IN inInvNumberPartner    TVarChar  , -- ����� ��������� � �����������
    IN inInvNumberOrder      TVarChar  , -- ����� ������ �����������
    IN inOperDate            TDateTime , -- ���� ���������
    IN inOperDatePartner     TDateTime , -- ���� ��������� � �����������
    IN inChecked             Boolean   , -- ��������
    IN inPriceWithVAT        Boolean   , -- ���� � ��� (��/���)
    IN inVATPercent          TFloat    , -- % ���
    IN inChangePercent       TFloat    , -- (-)% ������ (+)% �������
    IN inFromId              Integer   , -- �� ���� (� ���������)
    IN inToId                Integer   , -- ���� (� ���������)
    IN inPaidKindId          Integer   , -- ���� ���� ������
    IN inContractId          Integer   , -- ��������
    IN inRouteSortingId      Integer   , -- ���������� ���������
    IN inCurrencyDocumentId  Integer   , -- ������ (���������)
    IN inCurrencyPartnerId   Integer   , -- ������ (�����������)
    IN inDocumentTaxKindId_inf Integer  , -- ��� ������������ ���������� ���������
 INOUT ioPriceListId         Integer   , -- ����� ����
   OUT outPriceListName      TVarChar  , -- ����� ����
    IN inSession             TVarChar    -- ������ ������������
)
RETURNS RECORD AS
$BODY$
   DECLARE vbUserId Integer;
   DECLARE vbMovementId_Tax Integer;
BEGIN
     -- �������� ���� ������������ �� ����� ���������
     vbUserId:= lpCheckRight (inSession, zc_Enum_Process_InsertUpdate_Movement_Sale());

     -- ������������ ��������� ��� ���������
     IF ioId <> 0
     THEN
         vbMovementId_Tax:= (SELECT MovementChildId FROM MovementLinkMovement WHERE MovementId = ioId AND DescId = zc_MovementLinkMovement_Master());
     END IF;

     -- ��������� <��������>
     SELECT tmp.ioId, tmp.ioPriceListId, tmp.outPriceListName
            INTO ioId, ioPriceListId, outPriceListName
     FROM lpInsertUpdate_Movement_Sale (ioId               := ioId
                                      , inInvNumber        := inInvNumber
                                      , inInvNumberPartner := inInvNumberPartner
                                      , inInvNumberOrder   := inInvNumberOrder
                                      , inOperDate         := inOperDate
                                      , inOperDatePartner  := inOperDatePartner
                                      , inChecked          := inChecked
                                      , inPriceWithVAT     := inPriceWithVAT
                                      , inVATPercent       := inVATPercent
                                      , inChangePercent    := inChangePercent
                                      , inFromId           := inFromId
                                      , inToId             := inToId
                                      , inPaidKindId       := inPaidKindId
                                      , inContractId       := inContractId
                                      , inRouteSortingId   := inRouteSortingId
                                      , inCurrencyDocumentId := inCurrencyDocumentId
                                      , inCurrencyPartnerId  := inCurrencyPartnerId
                                      , ioPriceListId      := ioPriceListId
                                      , inUserId           := vbUserId
                                       ) AS tmp;

    -- � ���� ������ ���� ������������/������� ���������
    IF vbMovementId_Tax <> 0
    THEN
        IF inDocumentTaxKindId_inf <> 0
        THEN
             -- �������� <��� �����. ���.> �� ������ ����������
             IF NOT EXISTS (SELECT ObjectId FROM MovementLinkObject WHERE MovementId = vbMovementId_Tax AND DescId = zc_MovementLinkObject_DocumentTaxKind() AND ObjectId = inDocumentTaxKindId_inf)
             THEN
                 RAISE EXCEPTION '������.������ �������� <��� ���������� ���������>.';
             END IF;

             -- �������������� ���������
             IF EXISTS (SELECT Id FROM Movement WHERE Id = vbMovementId_Tax AND StatusId = zc_Enum_Status_Erased())
             THEN
                 PERFORM lpUnComplete_Movement (inMovementId := vbMovementId_Tax
                                              , inUserId     := vbUserId);
             END IF;
        ELSE
             -- �������� ���������
             PERFORM lpSetErased_Movement (inMovementId := vbMovementId_Tax
                                         , inUserId     := vbUserId);
        END IF;

    END IF;

END;
$BODY$
  LANGUAGE plpgsql VOLATILE;

/*
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.   ������ �.
 24.07.14         * add inCurrencyDocumentId
                        inCurrencyPartnerId
 17.04.14                                        * add ������������/������� ��������� 
 10.02.14                                        * � lp-������ ���� ���
 04.02.14                         * add lpInsertUpdate_Movement_Sale
 31.01.14                                                       * add inPriceListId
 30.01.14                                                       * add inInvNumberPartner
 13.01.14                                        * del property from redmain
 11.01.14                                        * add inChecked, inInvNumberOrder
 13.08.13                                        * add RAISE EXCEPTION
 13.07.13         *
*/
/*
-- 1.
update Movement set StatusId = zc_Enum_Status_Erased() where DescId = zc_Movement_Sale() and StatusId <> zc_Enum_Status_Erased();
-- 2.
update dba.Bill set Id_Postgres = null where BillKind = zc_bkSaleToClient() and Id_Postgres is not null;
update dba.fBill set Id_Postgres = null where BillKind = zc_bkSaleToClient() and Id_Postgres is not null;
update dba.fBillItems set Id_Postgres = null where BillKind = zc_bkSaleToClient() and Id_Postgres is not null;
update dba.BillItems join dba.Bill on Bill.Id = BillItems.BillId and isnull(Bill.Id_Postgres,0)=0 set BillItems.Id_Postgres = null where BillItems.Id_Postgres is not null;
*/

-- ����
-- SELECT * FROM gpInsertUpdate_Movement_Sale (ioId:= 0, inInvNumber:= '-1', inOperDate:= '01.01.2013', inOperDatePartner:= '01.01.2013', inInvNumberPartner:= 'xxx', inPriceWithVAT:= true, inVATPercent:= 20, inChangePercent:= 0, inFromId:= 1, inToId:= 2, inCarId:= 0, inPaidKindId:= 1, inContractId:= 0, inPersonalDriverId:= 0, inRouteId:= 0, inRouteSortingId:= 0, inSession:= '2')
