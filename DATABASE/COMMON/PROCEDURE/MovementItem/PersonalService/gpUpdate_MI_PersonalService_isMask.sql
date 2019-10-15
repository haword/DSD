-- Function: gpUpdate_MI_PersonalService_isMask()

DROP FUNCTION IF EXISTS gpUpdate_MI_PersonalService_isMask (Integer, Integer, TVarChar);


CREATE OR REPLACE FUNCTION gpUpdate_MI_PersonalService_isMask(
    IN inMovementId      Integer      , -- ���� ���������
    IN inMovementMaskId  Integer      , -- ���� ��������� �����
    IN inSession         TVarChar       -- ������ ������������
)
RETURNS VOID
AS
$BODY$
   DECLARE vbUserId Integer;
BEGIN
     -- �������� ���� ������������ �� ����� ���������
     -- vbUserId := lpCheckRight (inSession, zc_Enum_Process_Select_MI_PersonalService());
     vbUserId:= lpGetUserBySession (inSession);


      -- �������� - ��� � �� ���������� ��� ����
      IF EXISTS (SELECT Id FROM MovementItem WHERE isErased = FALSE AND DescId = zc_MI_Master() AND MovementId = inMovementId AND Amount <> 0)
         THEN RAISE EXCEPTION '������.� ��������� ��� ���� ������ �� �����������.';
      END IF;


      -- ���������
       CREATE TEMP TABLE tmpMI (MovementItemId Integer, PersonalId Integer, isMain Boolean
             , UnitId Integer, PositionId Integer, InfoMoneyId Integer, MemberId Integer, PersonalServiceListId Integer
             , Amount TFloat, SummService TFloat, SummCardRecalc TFloat, SummCardSecondRecalc TFloat, SummCardSecondCash TFloat
             , SummNalogRecalc TFloat, SummNalogRetRecalc TFloat, SummNalogRet TFloat, SummMinus TFloat, SummAdd TFloat, SummAddOthRecalc TFloat
             , SummHoliday TFloat, SummSocialIn TFloat, SummSocialAdd TFloat, SummChildRecalc TFloat, SummMinusExtRecalc TFloat, SummFineRecalc TFloat, SummHospRecalc TFloat) ON COMMIT DROP;

       WITH tmpMI AS (SELECT MAX (MovementItem.Id)                     AS MovementItemId
                           , MovementItem.ObjectId                     AS PersonalId
                           , MILinkObject_Unit.ObjectId                AS UnitId
                           , MILinkObject_Position.ObjectId            AS PositionId
                           , MILinkObject_InfoMoney.ObjectId           AS InfoMoneyId
                      FROM MovementItem
                           LEFT JOIN MovementItemLinkObject AS MILinkObject_InfoMoney
                                                            ON MILinkObject_InfoMoney.MovementItemId = MovementItem.Id
                                                           AND MILinkObject_InfoMoney.DescId = zc_MILinkObject_InfoMoney()
                           LEFT JOIN MovementItemLinkObject AS MILinkObject_Unit
                                                            ON MILinkObject_Unit.MovementItemId = MovementItem.Id
                                                           AND MILinkObject_Unit.DescId = zc_MILinkObject_Unit()
                           LEFT JOIN MovementItemLinkObject AS MILinkObject_Position
                                                            ON MILinkObject_Position.MovementItemId = MovementItem.Id
                                                           AND MILinkObject_Position.DescId = zc_MILinkObject_Position()
                      WHERE MovementItem.isErased = FALSE
                        AND MovementItem.DescId = zc_MI_Master()
                        AND MovementItem.MovementId =  inMovementId
                      GROUP BY MovementItem.ObjectId
                             , MILinkObject_Unit.ObjectId
                             , MILinkObject_Position.ObjectId
                             , MILinkObject_InfoMoney.ObjectId
                     )
         INSERT INTO tmpMI  (MovementItemId, PersonalId, isMain, UnitId, PositionId, InfoMoneyId, MemberId, PersonalServiceListId
                           , Amount, SummService, SummCardRecalc, SummCardSecondRecalc, SummCardSecondCash
                           , SummNalogRecalc, SummNalogRetRecalc, SummNalogRet, SummMinus, SummAdd, SummAddOthRecalc
                           , SummHoliday, SummSocialIn, SummSocialAdd, SummChildRecalc, SummMinusExtRecalc, SummFineRecalc, SummHospRecalc)
            SELECT COALESCE (tmpMI.MovementItemId, 0)        AS MovementItemId
                 , MovementItem.ObjectId                     AS PersonalId
                 , COALESCE (MIBoolean_Main.ValueData, FALSE) :: Boolean   AS isMain
                 , MILinkObject_Unit.ObjectId                AS UnitId
                 , MILinkObject_Position.ObjectId            AS PositionId
                 , MILinkObject_InfoMoney.ObjectId           AS InfoMoneyId
                 , MILinkObject_Member.ObjectId              AS MemberId
                 , MILinkObject_PersonalServiceList.ObjectId AS PersonalServiceListId
                 , COALESCE (MovementItem.Amount, 0)                   :: TFloat  AS Amount
                 , COALESCE (MIFloat_SummService.ValueData, 0)         :: TFloat  AS SummService
                 , COALESCE (MIFloat_SummCardRecalc.ValueData, 0)      :: TFloat  AS SummCardRecalc
                 , COALESCE (MIFloat_SummCardSecondRecalc.ValueData, 0):: TFloat  AS SummCardSecondRecalc
                 , COALESCE (MIFloat_SummCardSecondCash.ValueData, 0)  :: TFloat  AS SummCardSecondCash
                 , COALESCE (MIFloat_SummNalogRecalc.ValueData, 0)     :: TFloat  AS SummNalogRecalc
                 , COALESCE (MIFloat_SummNalogRetRecalc.ValueData, 0)  :: TFloat  AS SummNalogRetRecalc
                 , COALESCE (MIFloat_SummNalogRet.ValueData, 0)        :: TFloat  AS SummNalogRet
                 , COALESCE (MIFloat_SummMinus.ValueData, 0)           :: TFloat  AS SummMinus
                 , COALESCE (MIFloat_SummAdd.ValueData, 0)             :: TFloat  AS SummAdd
                 , COALESCE (MIFloat_SummAddOthRecalc.ValueData, 0)    :: TFloat  AS SummAddOthRecalc
                 , COALESCE (MIFloat_SummHoliday.ValueData, 0)         :: TFloat  AS SummHoliday
                 , COALESCE (MIFloat_SummSocialIn.ValueData, 0)        :: TFloat  AS SummSocialIn
                 , COALESCE (MIFloat_SummSocialAdd.ValueData, 0)       :: TFloat  AS SummSocialAdd
                 , COALESCE (MIFloat_SummChildRecalc.ValueData, 0)     :: TFloat  AS SummChildRecalc
                 , COALESCE (MIFloat_SummMinusExtRecalc.ValueData, 0)  :: TFloat  AS SummMinusExtRecalc
                 , COALESCE (MIFloat_SummFineRecalc.ValueData, 0)      :: TFloat  AS SummFineRecalc
                 , COALESCE (MIFloat_SummHospRecalc.ValueData, 0)      :: TFloat  AS SummHospRecalc
            FROM MovementItem
                 LEFT JOIN MovementItemLinkObject AS MILinkObject_InfoMoney
                                             ON MILinkObject_InfoMoney.MovementItemId = MovementItem.Id
                                            AND MILinkObject_InfoMoney.DescId = zc_MILinkObject_InfoMoney()
                 LEFT JOIN MovementItemLinkObject AS MILinkObject_Unit
                                                  ON MILinkObject_Unit.MovementItemId = MovementItem.Id
                                                 AND MILinkObject_Unit.DescId = zc_MILinkObject_Unit()
                 LEFT JOIN MovementItemLinkObject AS MILinkObject_Position
                                                  ON MILinkObject_Position.MovementItemId = MovementItem.Id
                                                 AND MILinkObject_Position.DescId = zc_MILinkObject_Position()
                 LEFT JOIN MovementItemLinkObject AS MILinkObject_Member
                                                  ON MILinkObject_Member.MovementItemId = MovementItem.Id
                                                 AND MILinkObject_Member.DescId = zc_MILinkObject_Member()
                 LEFT JOIN MovementItemLinkObject AS MILinkObject_PersonalServiceList
                                                  ON MILinkObject_PersonalServiceList.MovementItemId = MovementItem.Id
                                                 AND MILinkObject_PersonalServiceList.DescId = zc_MILinkObject_PersonalServiceList()

                 LEFT JOIN MovementItemFloat AS MIFloat_SummToPay
                                             ON MIFloat_SummToPay.MovementItemId = MovementItem.Id
                                            AND MIFloat_SummToPay.DescId = zc_MIFloat_SummToPay()
                 LEFT JOIN MovementItemFloat AS MIFloat_SummService
                                             ON MIFloat_SummService.MovementItemId = MovementItem.Id
                                            AND MIFloat_SummService.DescId = zc_MIFloat_SummService()

                 LEFT JOIN MovementItemFloat AS MIFloat_SummCardRecalc
                                             ON MIFloat_SummCardRecalc.MovementItemId = MovementItem.Id
                                            AND MIFloat_SummCardRecalc.DescId = zc_MIFloat_SummCardRecalc()
                 LEFT JOIN MovementItemFloat AS MIFloat_SummCardSecondRecalc
                                             ON MIFloat_SummCardSecondRecalc.MovementItemId = MovementItem.Id
                                            AND MIFloat_SummCardSecondRecalc.DescId = zc_MIFloat_SummCardSecondRecalc()
                 LEFT JOIN MovementItemFloat AS MIFloat_SummCardSecondCash
                                             ON MIFloat_SummCardSecondCash.MovementItemId = MovementItem.Id
                                            AND MIFloat_SummCardSecondCash.DescId = zc_MIFloat_SummCardSecondCash()
                 LEFT JOIN MovementItemFloat AS MIFloat_SummNalogRecalc
                                             ON MIFloat_SummNalogRecalc.MovementItemId = MovementItem.Id
                                            AND MIFloat_SummNalogRecalc.DescId = zc_MIFloat_SummNalogRecalc()
                 LEFT JOIN MovementItemFloat AS MIFloat_SummNalogRetRecalc
                                             ON MIFloat_SummNalogRetRecalc.MovementItemId = MovementItem.Id
                                            AND MIFloat_SummNalogRetRecalc.DescId = zc_MIFloat_SummNalogRetRecalc()
                 LEFT JOIN MovementItemFloat AS MIFloat_SummNalogRet
                                             ON MIFloat_SummNalogRet.MovementItemId = MovementItem.Id
                                            AND MIFloat_SummNalogRet.DescId = zc_MIFloat_SummNalogRet()

                 LEFT JOIN MovementItemFloat AS MIFloat_SummMinus
                                             ON MIFloat_SummMinus.MovementItemId = MovementItem.Id
                                            AND MIFloat_SummMinus.DescId = zc_MIFloat_SummMinus()
                 LEFT JOIN MovementItemFloat AS MIFloat_SummAdd
                                             ON MIFloat_SummAdd.MovementItemId = MovementItem.Id
                                            AND MIFloat_SummAdd.DescId = zc_MIFloat_SummAdd()
                 LEFT JOIN MovementItemFloat AS MIFloat_SummAddOthRecalc
                                             ON MIFloat_SummAddOthRecalc.MovementItemId = MovementItem.Id
                                            AND MIFloat_SummAddOthRecalc.DescId = zc_MIFloat_SummAddOthRecalc()

                 LEFT JOIN MovementItemFloat AS MIFloat_SummHoliday
                                             ON MIFloat_SummHoliday.MovementItemId = MovementItem.Id
                                            AND MIFloat_SummHoliday.DescId = zc_MIFloat_SummHoliday()

                 LEFT JOIN MovementItemFloat AS MIFloat_SummSocialIn
                                             ON MIFloat_SummSocialIn.MovementItemId = MovementItem.Id
                                            AND MIFloat_SummSocialIn.DescId = zc_MIFloat_SummSocialIn()
                 LEFT JOIN MovementItemFloat AS MIFloat_SummSocialAdd
                                             ON MIFloat_SummSocialAdd.MovementItemId = MovementItem.Id
                                            AND MIFloat_SummSocialAdd.DescId = zc_MIFloat_SummSocialAdd()

                 LEFT JOIN MovementItemFloat AS MIFloat_SummChildRecalc
                                             ON MIFloat_SummChildRecalc.MovementItemId = MovementItem.Id
                                            AND MIFloat_SummChildRecalc.DescId = zc_MIFloat_SummChildRecalc()

                 LEFT JOIN MovementItemFloat AS MIFloat_SummMinusExtRecalc
                                             ON MIFloat_SummMinusExtRecalc.MovementItemId = MovementItem.Id
                                            AND MIFloat_SummMinusExtRecalc.DescId = zc_MIFloat_SummMinusExtRecalc()

                 LEFT JOIN MovementItemFloat AS MIFloat_SummFineRecalc
                                             ON MIFloat_SummFineRecalc.MovementItemId = MovementItem.Id
                                            AND MIFloat_SummFineRecalc.DescId = zc_MIFloat_SummFineRecalc()
                 LEFT JOIN MovementItemFloat AS MIFloat_SummHospRecalc
                                             ON MIFloat_SummHospRecalc.MovementItemId = MovementItem.Id
                                            AND MIFloat_SummHospRecalc.DescId = zc_MIFloat_SummHospRecalc()

                 LEFT JOIN MovementItemBoolean AS MIBoolean_Main
                                               ON MIBoolean_Main.MovementItemId = MovementItem.Id
                                              AND MIBoolean_Main.DescId = zc_MIBoolean_Main()
                 LEFT JOIN tmpMI ON tmpMI.PersonalId  = MovementItem.ObjectId
                                AND tmpMI.UnitId      = MILinkObject_Unit.ObjectId
                                AND tmpMI.PositionId  = MILinkObject_Position.ObjectId
                                AND tmpMI.InfoMoneyId = MILinkObject_InfoMoney.ObjectId
       WHERE MovementItem.isErased = FALSE
         AND MovementItem.DescId = zc_MI_Master()
         AND MovementItem.MovementId =  inMovementMaskId ;


     PERFORM lpInsertUpdate_MovementItem_PersonalService (ioId                 := MovementItemId
                                                        , inMovementId         := inMovementId
                                                        , inPersonalId         := PersonalId
                                                        , inisMain             := isMain
                                                        , inSummService        := SummService
                                                        , inSummCardRecalc     := SummCardRecalc
                                                        , inSummCardSecondRecalc:= SummCardSecondRecalc
                                                        , inSummCardSecondCash := 0 -- SummCardSecondCash
                                                        , inSummNalogRecalc    := SummNalogRecalc
                                                        , inSummNalogRetRecalc := SummNalogRetRecalc
                                                        , inSummMinus          := SummMinus
                                                        , inSummAdd            := SummAdd
                                                        , inSummAddOthRecalc   := SummAddOthRecalc
                                                        , inSummHoliday        := SummHoliday
                                                        , inSummSocialIn       := SummSocialIn
                                                        , inSummSocialAdd      := SummSocialAdd
                                                        , inSummChildRecalc    := SummChildRecalc
                                                        , inSummMinusExtRecalc := SummMinusExtRecalc
                                                        , inSummFineRecalc     := SummFineRecalc
                                                        , inSummHospRecalc     := SummHospRecalc
                                                        , inComment            := '����������� �� ������ ���������'
                                                        , inInfoMoneyId        := InfoMoneyId
                                                        , inUnitId             := UnitId
                                                        , inPositionId         := PositionId
                                                        , inMemberId           := MemberId
                                                        , inPersonalServiceListId:= PersonalServiceListId
                                                        , inUserId             := vbUserId
                                                         )

     FROM tmpMI
    ;


     PERFORM lpInsertUpdate_MovementItemFloat (zc_MIFloat_SummNalogRet(), tmp.MovementItemId, tmp.SummNalogRet)
     FROM (WITH tmpMI_find AS (SELECT MAX (MovementItem.Id)            AS MovementItemId
                                    , MovementItem.ObjectId            AS PersonalId
                                    , MILinkObject_Unit.ObjectId       AS UnitId
                                    , MILinkObject_Position.ObjectId   AS PositionId
                                    , MILinkObject_InfoMoney.ObjectId  AS InfoMoneyId
                               FROM MovementItem
                                    LEFT JOIN MovementItemLinkObject AS MILinkObject_InfoMoney
                                                                     ON MILinkObject_InfoMoney.MovementItemId = MovementItem.Id
                                                                    AND MILinkObject_InfoMoney.DescId = zc_MILinkObject_InfoMoney()
                                    LEFT JOIN MovementItemLinkObject AS MILinkObject_Unit
                                                                     ON MILinkObject_Unit.MovementItemId = MovementItem.Id
                                                                    AND MILinkObject_Unit.DescId = zc_MILinkObject_Unit()
                                    LEFT JOIN MovementItemLinkObject AS MILinkObject_Position
                                                                     ON MILinkObject_Position.MovementItemId = MovementItem.Id
                                                                    AND MILinkObject_Position.DescId = zc_MILinkObject_Position()
                               WHERE MovementItem.isErased = FALSE
                                 AND MovementItem.DescId = zc_MI_Master()
                                 AND MovementItem.MovementId =  inMovementId
                               GROUP BY MovementItem.ObjectId
                                      , MILinkObject_Unit.ObjectId
                                      , MILinkObject_Position.ObjectId
                                      , MILinkObject_InfoMoney.ObjectId
                              )
           SELECT tmpMI_find.MovementItemId
                , tmpMI.SummNalogRet
           FROM tmpMI_find
                INNER JOIN tmpMI ON tmpMI.PersonalId  = tmpMI_find.PersonalId
                                AND tmpMI.UnitId      = tmpMI_find.UnitId
                                AND tmpMI.PositionId  = tmpMI_find.PositionId
                                AND tmpMI.InfoMoneyId = tmpMI_find.InfoMoneyId
          ) AS tmp
         ;


if inSession = '5'
then
    RAISE EXCEPTION 'admin - Net Prav';
end if;


END;
$BODY$
  LANGUAGE PLPGSQL VOLATILE;

/*
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.   ������ �.�.
 15.09.19         *
 29.07.19         *
 05.01.18         * add SummNalogRetRecalc
 20.06.17         * add SummCardSecondCash
 24.02.17         *
 20.02.17         * add SummCardSecondRecalc
 20.04.16         * inSummHoliday
 23.05.15                                        *
 24.10.14         *
*/

-- ����
-- SELECT * FROM gpUpdate_MI_PersonalService_isMask (inMovementId:= 393522 , inMovementMaskId :=393501 ,  inSession := '5');
