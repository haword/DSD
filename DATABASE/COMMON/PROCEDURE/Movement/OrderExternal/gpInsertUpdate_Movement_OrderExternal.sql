-- Function: gpInsertUpdate_Movement_OrderExternal()

DROP FUNCTION IF EXISTS gpInsertUpdate_Movement_OrderExternal (Integer, TVarChar, TVarChar, TDateTime, TDateTime, TFloat, Integer, Integer, Integer, Integer, Integer, Integer, Integer, Integer, TVarChar);
DROP FUNCTION IF EXISTS gpInsertUpdate_Movement_OrderExternal (Integer, TVarChar, TVarChar, TDateTime, TDateTime, TFloat, Integer, Integer, Integer, Integer, Integer, Integer, Integer, Integer, Integer, TVarChar);
DROP FUNCTION IF EXISTS gpInsertUpdate_Movement_OrderExternal (Integer, TVarChar, TVarChar, TDateTime, TDateTime, TFloat, Integer, Integer, Integer, Integer, Integer, Integer, Integer, Integer, Integer, TVarChar, TVarChar);
DROP FUNCTION IF EXISTS gpInsertUpdate_Movement_OrderExternal (Integer, TVarChar, TVarChar, TDateTime, TDateTime, TDateTime, TFloat, Integer, Integer, Integer, Integer, Integer, Integer, Integer, Integer, Integer, TVarChar, Boolean, TVarChar);

CREATE OR REPLACE FUNCTION gpInsertUpdate_Movement_OrderExternal(
 INOUT ioId                      Integer   , -- ���� ������� <�������� �����������>
    IN inInvNumber               TVarChar  , -- ����� ���������
    IN inInvNumberPartner        TVarChar  , -- ����� ������ � �����������
    IN inOperDate                TDateTime , -- ���� ���������
 INOUT ioOperDatePartner         TDateTime , -- ���� �������� �� ������
   OUT outOperDatePartner_sale   TDateTime , -- ���� ���������� ��������� � �����������
    IN inOperDateMark            TDateTime , -- ���� ����������
   OUT outPriceWithVAT           Boolean   , -- ���� � ��� (��/���)
   OUT outVATPercent             TFloat    , -- % ���
    IN inChangePercent           TFloat    , -- (-)% ������ (+)% �������
    IN inFromId                  Integer   , -- �� ���� (� ���������)
    IN inToId                    Integer   , -- ���� (� ���������)
    IN inPaidKindId              Integer   , -- ���� ���� ������
    IN inContractId              Integer   , -- ��������
    IN inRouteId                 Integer   , -- �������
    IN inRouteSortingId          Integer   , -- ���������� ���������
 INOUT ioPersonalId              Integer   , -- ��������� (����������)
   OUT outPersonalName           TVarChar  , -- ��������� (����������)
 INOUT ioPriceListId             Integer   , -- ����� ����
   OUT outPriceListName          TVarChar  , -- ����� ����
    IN inPartnerId               Integer   , -- ����������
    IN inComment                 TVarChar  , -- ����������
    IN inIsAuto                  Boolean   , -- ����� �������  ���� �������� TRUE - ������, FALSE - ������ �����
    IN inSession                 TVarChar    -- ������ ������������
)
RETURNS RECORD AS
$BODY$
   DECLARE vbUserId Integer;
BEGIN
     -- �������� ���� ������������ �� ����� ���������
     vbUserId:= lpCheckRight (inSession, zc_Enum_Process_InsertUpdate_Movement_OrderExternal());

     -- ��������
     IF COALESCE (inContractId, 0) = 0 AND NOT EXISTS (SELECT Id FROM Object WHERE Id = inFromId AND DescId = zc_Object_ArticleLoss())
     THEN
         RAISE EXCEPTION '������.�� ����������� �������� <�������>.';
     END IF;


     -- !!!����������� ��������!!!
     IF EXISTS (SELECT View_Contract_InvNumber.ContractId FROM Object_Contract_InvNumber_View AS View_Contract_InvNumber WHERE View_Contract_InvNumber.ContractId = inContractId AND View_Contract_InvNumber.InfoMoneyId = zc_Enum_InfoMoney_30201()) -- ������ + ������ ����� + ������ �����
     THEN inToId:= 133049; -- ����� ���������� ����
     END IF;

     -- 1. ��� ��������� ������ �� �����������
     IF inIsAuto = TRUE   -- ���� ����� ����� ������� ���� �������� ����, ����� ����������� �������� 
     THEN 
         ioOperDatePartner:= inOperDate + (COALESCE ((SELECT ValueData FROM ObjectFloat WHERE ObjectId = inFromId AND DescId = zc_ObjectFloat_Partner_PrepareDayCount()), 0) :: TVarChar || ' DAY') :: INTERVAL;
     END IF;
     -- ������ �� zc_MovementDate_OperDatePartner
     outOperDatePartner_sale:= ioOperDatePartner + (COALESCE ((SELECT ValueData FROM ObjectFloat WHERE ObjectId = inFromId AND DescId = zc_ObjectFloat_Partner_DocumentDayCount()), 0) :: TVarChar || ' DAY') :: INTERVAL;

     -- 2. ��� ��������� ������ �� �����-�����
     IF COALESCE (ioPriceListId, 0) = 0
        OR 1=1 -- !!!������ ������!!!
     THEN
         -- !!!������!!!
         SELECT tmp.PriceListId, tmp.PriceListName, tmp.PriceWithVAT, tmp.VATPercent
                INTO ioPriceListId, outPriceListName, outPriceWithVAT, outVATPercent
         FROM lfGet_Object_Partner_PriceList_onDate (inContractId     := inContractId
                                                   , inPartnerId      := inFromId
                                                   , inMovementDescId := zc_Movement_Sale() -- !!!�� ������!!!
                                                   , inOperDate_order := inOperDate
                                                   , inOperDatePartner:= NULL
                                                   , inDayPrior_PriceReturn:= 0 -- !!!�������� ����� �� �����!!!
                                                   , inIsPrior        := FALSE -- !!!�������� ����� �� �����!!!
                                                    ) AS tmp;
         -- !!!������!!!
         -- !!!�� ���� outOperDatePartner!!!
         -- SELECT tmp.PriceListId, tmp.PriceListName, tmp.PriceWithVAT, tmp.VATPercent
         --        INTO ioPriceListId, outPriceListName, outPriceWithVAT, outVATPercent
         -- FROM lfGet_Object_Partner_PriceList (inContractId:= inContractId, inPartnerId:= inFromId, inOperDate:= outOperDatePartner) AS tmp;
     ELSE
         SELECT Object_PriceList.ValueData                             AS PriceListName
              , COALESCE (ObjectBoolean_PriceWithVAT.ValueData, FALSE) AS PriceWithVAT
              , ObjectFloat_VATPercent.ValueData                       AS VATPercent
                INTO outPriceListName, outPriceWithVAT, outVATPercent
         FROM Object AS Object_PriceList
              LEFT JOIN ObjectBoolean AS ObjectBoolean_PriceWithVAT
                                      ON ObjectBoolean_PriceWithVAT.ObjectId = Object_PriceList.Id
                                     AND ObjectBoolean_PriceWithVAT.DescId = zc_ObjectBoolean_PriceList_PriceWithVAT()
              LEFT JOIN ObjectFloat AS ObjectFloat_VATPercent
                                    ON ObjectFloat_VATPercent.ObjectId = Object_PriceList.Id
                                   AND ObjectFloat_VATPercent.DescId = zc_ObjectFloat_PriceList_VATPercent()
         WHERE Object_PriceList.Id = ioPriceListId;
     END IF;


     -- ����������� ����������� �� ��� ������ ��� ��� �� �����
     ioPersonalId:= COALESCE ((SELECT ObjectLink_Partner_MemberTake.ChildObjectId
                               FROM ObjectLink AS ObjectLink_Partner_MemberTake
                               WHERE ObjectLink_Partner_MemberTake.ObjectId = inFromId
                                 AND ObjectLink_Partner_MemberTake.DescId = CASE EXTRACT (DOW FROM inOperDate
                                                                                                 + (((COALESCE ((SELECT ObjectFloat.ValueData FROM ObjectFloat WHERE ObjectFloat.ObjectId = inFromId AND ObjectFloat.DescId = zc_ObjectFloat_Partner_PrepareDayCount()),  0)
                                                                                                    + COALESCE ((SELECT ObjectFloat.ValueData FROM ObjectFloat WHERE ObjectFloat.ObjectId = inFromId AND ObjectFloat.DescId = zc_ObjectFloat_Partner_DocumentDayCount()), 0)
                                                                                                     ) :: TVarChar || ' DAY') :: INTERVAL)
                                                                                          )
                                                       WHEN 1 THEN zc_ObjectLink_Partner_MemberTake1()
                                                       WHEN 2 THEN zc_ObjectLink_Partner_MemberTake2()
                                                       WHEN 3 THEN zc_ObjectLink_Partner_MemberTake3()
                                                       WHEN 4 THEN zc_ObjectLink_Partner_MemberTake4()
                                                       WHEN 5 THEN zc_ObjectLink_Partner_MemberTake5()
                                                       WHEN 6 THEN zc_ObjectLink_Partner_MemberTake6()
                                                       WHEN 0 THEN zc_ObjectLink_Partner_MemberTake7()
                                                    END
                              ), ioPersonalId);
     -- �������� ������ �� ioPersonalId
     outPersonalName:= (SELECT Object.ValueData FROM Object WHERE Object.Id = ioPersonalId);


     -- ����������
     ioId:= lpInsertUpdate_Movement_OrderExternal (ioId                  := ioId
                                                 , inInvNumber           := inInvNumber
                                                 , inInvNumberPartner    := inInvNumberPartner
                                                 , inOperDate            := inOperDate
                                                 , inOperDatePartner     := ioOperDatePartner
                                                 , inOperDateMark        := inOperDateMark
                                                 , inPriceWithVAT        := outPriceWithVAT
                                                 , inVATPercent          := outVATPercent
                                                 , inChangePercent       := inChangePercent
                                                 , inFromId              := inFromId
                                                 , inToId                := inToId
                                                 , inPaidKindId          := inPaidKindId
                                                 , inContractId          := inContractId
                                                 , inRouteId             := inRouteId
                                                 , inRouteSortingId      := inRouteSortingId
                                                 , inPersonalId          := ioPersonalId
                                                 , inPriceListId         := ioPriceListId
                                                 , inPartnerId           := inPartnerId
                                                 , inUserId              := vbUserId
                                                  );

     -- �����������
     PERFORM lpInsertUpdate_MovementString (zc_MovementString_Comment(), ioId, inComment);

     -- ��������� �������� <����� �������>
     PERFORM lpInsertUpdate_MovementBoolean (zc_MovementBoolean_isAuto(), ioId, inIsAuto);


END;
$BODY$
  LANGUAGE plpgsql VOLATILE;

/*
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.   ������ �.�.
 20.06.18         *
 13.09.15         * add ioPersonalId, ioPersonalName
 26.05.15         * add inPartnerId
 18.08.14                                        * add lpInsertUpdate_Movement_OrderExternal
 26.08.14                                                        *
 25.08.14                                        * all
 18.08.14                                                        *
 06.06.14                                                        *
 01.08.13         *
*/

-- ����
-- SELECT * FROM gpInsertUpdate_Movement_OrderExternal (ioId:= 0, inInvNumber:= '-1', inOperDate:= '01.01.2013', inOperDatePartner:= '01.01.2013', inOperDateMark:= '01.01.2013', inInvNumberPartner:= 'xxx', inFromId:= 1, inPersonalId:= 0, inRouteId:= 0, inRouteSortingId:= 0, inSession:= '2')
