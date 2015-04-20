-- Function: lpInsertUpdate_Movement_TaxCorrective()

DROP FUNCTION IF EXISTS lpInsert_Movement_TaxCorrectiveMedoc (Integer, TVarChar, TVarChar, TDateTime, TFloat, Integer, Integer, Integer);

CREATE OR REPLACE FUNCTION lpInsert_Movement_TaxCorrectiveMedoc(
   OUT outId                 Integer   , -- ���� ������� <�������� ���������>
    IN inInvNumberPartner    TVarChar  , -- ����� ���������� ���������
    IN inInvNumberBranch     TVarChar  , -- ����� �������
    IN inOperDate            TDateTime , -- ���� ���������
    IN inVATPercent          TFloat    , -- % ���
    IN inFromId              Integer   , -- �� ���� (� ���������)
    IN inToId                Integer   , -- ���� (� ���������)
    IN inUserId              Integer     -- ������������
)
RETURNS Integer AS
$BODY$
   DECLARE vbAccessKeyId Integer;
   DECLARE vbIsInsert Boolean;
   DECLARE vbBranchId Integer;
BEGIN
     -- ��������
     IF inOperDate <> DATE_TRUNC ('DAY', inOperDate)
     THEN
         RAISE EXCEPTION '������.�������� ������ ����.';
     END IF;


     SELECT ObjectId INTO vbBranchId 
        FROM ObjectString AS ObjectString_InvNumber
                               WHERE ObjectString_InvNumber.DescId = zc_objectString_Branch_InvNumber()    
                                 AND ObjectString_InvNumber.ValueData = inInvNumberBranch;   

     -- ���������� ������� ��������/�������������
     vbIsInsert := true;

     -- ��������� <��������>
     outId := lpInsertUpdate_Movement (outId, zc_Movement_TaxCorrective(), inInvNumberPartner, inOperDate, NULL, vbAccessKeyId);

     -- ��������� �������� <����� ���������� ���������>
     PERFORM lpInsertUpdate_MovementString (zc_MovementString_InvNumberPartner(), outId, inInvNumberPartner);

     -- ��������� �������� <����� �������>
     PERFORM lpInsertUpdate_MovementString (zc_MovementString_InvNumberBranch(), outId, inInvNumberBranch);

     PERFORM lpInsertUpdate_MovementBoolean(zc_MovementBoolean_Medoc(), outId, true);
     -- ��������� �������� <���� � ��� (��/���)>
     PERFORM lpInsertUpdate_MovementBoolean (zc_MovementBoolean_PriceWithVAT(), outId, false);

     -- ��������� �������� <% ���>
     PERFORM lpInsertUpdate_MovementFloat (zc_MovementFloat_VATPercent(), outId, inVATPercent);

     -- ��������� ����� � <�� ���� (� ���������)>
     PERFORM lpInsertUpdate_MovementLinkObject (zc_MovementLinkObject_From(), outId, inFromId);
     -- ��������� ����� � <���� (� ���������)>
     PERFORM lpInsertUpdate_MovementLinkObject (zc_MovementLinkObject_To(), outId, inToId);
     -- ��������� ����� � <��� ������������ ���������� ���������>
--     PERFORM lpInsertUpdate_MovementLinkObject (zc_MovementLinkObject_DocumentTaxKind(), ioId, inDocumentTaxKindId);

     -- ��������� ����� � <������>
     PERFORM lpInsertUpdate_MovementLinkObject (zc_MovementLinkObject_Branch(), ioId, vbBranchId);


     -- ����������� �������� ����� �� ���������
     PERFORM lpInsertUpdate_MovementFloat_TotalSumm (ioId);

     IF 1 = 1 -- NOT EXISTS (SELECT UserId FROM ObjectLink_UserRole_View WHERE UserId = inUserId AND RoleId = zc_Enum_Role_Admin())
     THEN
         -- ��������� ��������
         PERFORM lpInsert_MovementProtocol (ioId, inUserId, vbIsInsert);
     END IF;

END;
$BODY$
  LANGUAGE plpgsql VOLATILE;

/*
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.   ������ �.�.
 16.04.15                         *
*/

-- ����
-- SELECT * FROM lpInsertUpdate_Movement_Tax (ioId:= 0, ioInvNumber:= '-1',ioInvNumberPartner:= '-1', inOperDate:= '01.01.2013', inChecked:= FALSE, inDocument:=FALSE, inPriceWithVAT:= true, inVATPercent:= 20, inFromId:= 1, inToId:= 2, inContractId:= 0, inDocumentTaxKind:= 0, inUserId:=24)
