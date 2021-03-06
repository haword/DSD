-- Function: lpInsertUpdate_MI_Sale_Child()

DROP FUNCTION IF EXISTS lpUpdate_MI_Sale_Total (Integer);

CREATE OR REPLACE FUNCTION lpUpdate_MI_Sale_Total(
    IN inMovementItemId      Integer
)
RETURNS VOID
AS
$BODY$
   DECLARE vbTotalChangePercentPay TFloat;   -- �������������� ������ � �������� ���
   DECLARE vbTotalPayOth           TFloat;   -- ������ � �������� ���
   DECLARE vbTotalCountReturn      TFloat;   -- ���-�� �������
   DECLARE vbTotalReturn           TFloat;   -- ����� �������� ���
   DECLARE vbTotalPayReturn        TFloat;   -- ����� �������� ������ ���
   -- DECLARE vbOperPriceToPay        TFloat;   -- ���� � ������
   -- DECLARE vbMovementId            Integer;  -- ��� ��������
BEGIN

     -- ��� ��������
     -- vbMovementId:= (SELECT MovementItem.MovementId FROM MovementItem WHERE MovementItem.Id = inMovementItemId);
     
     -- ���������� ���� � ������
     /*vbOperPriceToPay := COALESCE ((SELECT (-- ����� �� ����� �������
                                            zfCalc_SummPriceList (MovementItem.Amount, MIFloat_OperPriceList.ValueData)
                                            -- ����� - ����� ����� ������ (� ���) - ��� ���� ���������� - ����������� 1)�� %������ + 2)�������������� + 3)�������������� � �������
                                          - COALESCE (MIFloat_TotalChangePercent.ValueData, 0) - COALESCE (MIFloat_TotalChangePercentPay.ValueData, 0)
                                           ) / MovementItem.Amount
                                    FROM MovementItem
                                         LEFT JOIN MovementItemFloat AS MIFloat_OperPriceList
                                                                     ON MIFloat_OperPriceList.MovementItemId = MovementItem.Id
                                                                    AND MIFloat_OperPriceList.DescId         = zc_MIFloat_OperPriceList()
                                         LEFT JOIN MovementItemFloat AS MIFloat_TotalChangePercent
                                                                     ON MIFloat_TotalChangePercent.MovementItemId = MovementItem.Id
                                                                    AND MIFloat_TotalChangePercent.DescId         = zc_MIFloat_TotalChangePercent()
                                         LEFT JOIN MovementItemFloat AS MIFloat_TotalChangePercentPay
                                                                     ON MIFloat_TotalChangePercentPay.MovementItemId = MovementItem.Id
                                                                    AND MIFloat_TotalChangePercentPay.DescId         = zc_MIFloat_TotalChangePercentPay()

                                    WHERE MovementItem.MovementId = vbMovementId
                                      AND MovementItem.Id         = inMovementItemId
                                      AND MovementItem.DescId     = zc_MI_Master()
                                      -- AND MovementItem.isErased   = FALSE
                                   ), 0);*/

     -- ������
     SELECT  -- �������������� ������ � �������� ���
             COALESCE (SUM (CASE WHEN Movement.DescId = zc_Movement_GoodsAccount() THEN COALESCE (MIFloat_SummChangePercent.ValueData, 0) ELSE 0 END), 0) AS TotalChangePercentPay
             -- ������ � �������� ���
           , COALESCE (SUM (CASE WHEN Movement.DescId = zc_Movement_GoodsAccount() THEN COALESCE (MIFloat_TotalPay.ValueData, 0)  ELSE 0         END), 0) AS TotalPayOth
             -- ���-�� �������
           , COALESCE (SUM (CASE WHEN Movement.DescId = zc_Movement_ReturnIn()     THEN MovementItem.Amount                       ELSE 0         END), 0) AS TotalCountReturn
             -- ����� �������� �� ������� (� ���)
           , COALESCE (SUM (CASE WHEN Movement.DescId = zc_Movement_ReturnIn()     THEN zfCalc_SummPriceList (MovementItem.Amount, MIFloat_OperPriceList.ValueData) - COALESCE (MIFloat_TotalChangePercent.ValueData, 0) ELSE 0 END), 0) AS TotalReturn
             -- ����� �������� ������ ��� + ����� ����� �������� ������ �� ��������
           , COALESCE (SUM (CASE WHEN Movement.DescId = zc_Movement_ReturnIn()     THEN COALESCE (MIFloat_TotalPay.ValueData, 0) + COALESCE (MIFloat_TotalPayOth.ValueData, 0) ELSE 0 END), 0) AS TotalPayReturn

             INTO vbTotalChangePercentPay, vbTotalPayOth, vbTotalCountReturn, vbTotalReturn, vbTotalPayReturn

      FROM  Object AS Object_PartionMI
            INNER JOIN MovementItemLinkObject AS MILinkObject_PartionMI
                                              ON MILinkObject_PartionMI.ObjectId =  Object_PartionMI.Id
                                             AND MILinkObject_PartionMI.DescId   = zc_MILinkObject_PartionMI()
            INNER JOIN MovementItem ON MovementItem.Id       = MILinkObject_PartionMI.MovementItemId
                                   AND MovementItem.DescId   = zc_MI_Master()
                                   AND MovementItem.isErased = FALSE

            INNER JOIN Movement ON Movement.Id       = MovementItem.MovementId
                               AND Movement.StatusId = zc_Enum_Status_Complete()

            LEFT JOIN MovementItemFloat AS MIFloat_OperPriceList
                                        ON MIFloat_OperPriceList.MovementItemId = MovementItem.Id
                                       AND MIFloat_OperPriceList.DescId         = zc_MIFloat_OperPriceList()

            LEFT JOIN MovementItemFloat AS MIFloat_TotalPay
                                        ON MIFloat_TotalPay.MovementItemId = MovementItem.Id
                                       AND MIFloat_TotalPay.DescId         = zc_MIFloat_TotalPay()
            LEFT JOIN MovementItemFloat AS MIFloat_TotalPayOth
                                        ON MIFloat_TotalPayOth.MovementItemId = MovementItem.Id
                                       AND MIFloat_TotalPayOth.DescId         = zc_MIFloat_TotalPayOth()

            LEFT JOIN MovementItemFloat AS MIFloat_TotalChangePercent
                                        ON MIFloat_TotalChangePercent.MovementItemId = MovementItem.Id
                                       AND MIFloat_TotalChangePercent.DescId         = zc_MIFloat_TotalChangePercent()
            LEFT JOIN MovementItemFloat AS MIFloat_SummChangePercent
                                        ON MIFloat_SummChangePercent.MovementItemId = MovementItem.Id
                                       AND MIFloat_SummChangePercent.DescId         = zc_MIFloat_SummChangePercent()

     WHERE Object_PartionMI.ObjectCode = inMovementItemId
       AND Object_PartionMI.DescId     = zc_Object_PartionMI();

     -- ��������� �������� <�������������� ������ � �������� ���>
     PERFORM lpInsertUpdate_MovementItemFloat (zc_MIFloat_TotalChangePercentPay(), inMovementItemId, vbTotalChangePercentPay);
     -- ��������� �������� <����� ������ � �������� ���>
     PERFORM lpInsertUpdate_MovementItemFloat (zc_MIFloat_TotalPayOth(), inMovementItemId, vbTotalPayOth);
     -- ��������� �������� <���-�� �������>
     PERFORM lpInsertUpdate_MovementItemFloat (zc_MIFloat_TotalCountReturn(), inMovementItemId, vbTotalCountReturn);
     -- ��������� �������� <����� �������� ���>
     PERFORM lpInsertUpdate_MovementItemFloat (zc_MIFloat_TotalReturn(), inMovementItemId, vbTotalReturn);
     -- ��������� �������� <����� �������� ������ ���>
     PERFORM lpInsertUpdate_MovementItemFloat (zc_MIFloat_TotalPayReturn(), inMovementItemId, vbTotalPayReturn);


END;
$BODY$
  LANGUAGE plpgsql VOLATILE;

/*
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.
 06.07.17         *
*/

-- ����
--
