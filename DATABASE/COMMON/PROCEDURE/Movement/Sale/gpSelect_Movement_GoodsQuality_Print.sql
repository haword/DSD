-- Function: gpSelect_Movement_GoodsQuality_Print()

DROP FUNCTION IF EXISTS gpSelect_Movement_GoodsQuality_Print (Integer, TVarChar);

CREATE OR REPLACE FUNCTION gpSelect_Movement_GoodsQuality_Print(
    IN inMovementId         Integer  , -- ���� ���������
    IN inSession            TVarChar    -- ������ ������������
)
RETURNS SETOF refcursor
AS
$BODY$
    DECLARE vbUserId Integer;

    DECLARE vbOperDate  TDateTime;

    DECLARE Cursor1 refcursor;
    DECLARE Cursor2 refcursor;
BEGIN
     -- �������� ���� ������������ �� ����� ���������
     -- vbUserId:= lpCheckRight (inSession, zc_Enum_Process_...());
     vbUserId:= lpGetUserBySession (inSession);


     -- �������� �� ���������
     vbOperDate := (SELECT OperDate FROM Movement WHERE Id = inMovementId);


     -- ������: ��������� + �������� ����� ��� ����� 1
     OPEN Cursor1 FOR
       WITH tmpMI AS
            (SELECT MovementItem.*
                  , MIFloat_AmountPartner.ValueData AS AmountPartner
             FROM MovementItem
                  INNER JOIN MovementItemFloat AS MIFloat_Price
                                               ON MIFloat_Price.MovementItemId = MovementItem.Id
                                              AND MIFloat_Price.DescId = zc_MIFloat_Price()
                                              AND MIFloat_Price.ValueData <> 0
                  INNER JOIN MovementItemFloat AS MIFloat_AmountPartner
                                               ON MIFloat_AmountPartner.MovementItemId = MovementItem.Id
                                              AND MIFloat_AmountPartner.DescId = zc_MIFloat_AmountPartner()
                                              AND MIFloat_AmountPartner.ValueData <> 0
             WHERE MovementItem.MovementId =  inMovementId
               AND MovementItem.DescId     = zc_MI_Master()
               AND MovementItem.isErased   = FALSE
            )
          , tmpMIGoods AS (SELECT DISTINCT tmpMI.ObjectId AS GoodsId FROM tmpMI)
          , tmpGoodsQuality AS
            (SELECT tmpMIGoods.GoodsId          AS GoodsId
                  , Object_Quality.Id           AS QualityId
                  , Object_Quality.ObjectCode   AS QualityCode
                  , Object_Quality.ValueData    AS QualityName
                  , OS_QualityComment.ValueData AS QualityComment

                  , Object_GoodsQuality.ValueData AS Value17
                  , ObjectString_Value1.ValueData AS Value1
                  , ObjectString_Value2.ValueData AS Value2
                  , ObjectString_Value3.ValueData AS Value3
                  , ObjectString_Value4.ValueData AS Value4
                  , ObjectString_Value5.ValueData AS Value5
                  , ObjectString_Value6.ValueData AS Value6
                  , ObjectString_Value7.ValueData AS Value7
                  , ObjectString_Value8.ValueData AS Value8
                  , ObjectString_Value9.ValueData AS Value9
                  , ObjectString_Value10.ValueData AS Value10
              FROM tmpMIGoods
                   INNER JOIN ObjectLink AS ObjectLink_GoodsQuality_Goods
                                         ON ObjectLink_GoodsQuality_Goods.ChildObjectId = tmpMIGoods.GoodsId
                                        AND ObjectLink_GoodsQuality_Goods.DescId = zc_ObjectLink_GoodsQuality_Goods()
                   LEFT JOIN ObjectLink AS ObjectLink_GoodsQuality_Quality
                                        ON ObjectLink_GoodsQuality_Quality.ObjectId = ObjectLink_GoodsQuality_Goods.ObjectId
                                       AND ObjectLink_GoodsQuality_Quality.DescId = zc_ObjectLink_GoodsQuality_Quality()

                   LEFT JOIN Object AS Object_GoodsQuality ON Object_GoodsQuality.Id = ObjectLink_GoodsQuality_Quality.ObjectId

                   LEFT JOIN Object AS Object_Quality ON Object_Quality.Id = ObjectLink_GoodsQuality_Quality.ChildObjectId
                   LEFT JOIN ObjectString AS OS_QualityComment
                                          ON OS_QualityComment.ObjectId = ObjectLink_GoodsQuality_Quality.ChildObjectId
                                         AND OS_QualityComment.DescId = zc_ObjectString_Quality_Comment()

                   LEFT JOIN ObjectString AS ObjectString_Value1
                                          ON ObjectString_Value1.ObjectId = ObjectLink_GoodsQuality_Goods.ObjectId
                                         AND ObjectString_Value1.DescId = zc_ObjectString_GoodsQuality_Value1()
                   LEFT JOIN ObjectString AS ObjectString_Value2
                                          ON ObjectString_Value2.ObjectId = ObjectLink_GoodsQuality_Goods.ObjectId
                                         AND ObjectString_Value2.DescId = zc_ObjectString_GoodsQuality_Value2()
                   LEFT JOIN ObjectString AS ObjectString_Value3
                                          ON ObjectString_Value3.ObjectId = ObjectLink_GoodsQuality_Goods.ObjectId
                                         AND ObjectString_Value3.DescId = zc_ObjectString_GoodsQuality_Value3()
                   LEFT JOIN ObjectString AS ObjectString_Value4
                                          ON ObjectString_Value4.ObjectId = ObjectLink_GoodsQuality_Goods.ObjectId
                                         AND ObjectString_Value4.DescId = zc_ObjectString_GoodsQuality_Value4()
                   LEFT JOIN ObjectString AS ObjectString_Value5
                                          ON ObjectString_Value5.ObjectId = ObjectLink_GoodsQuality_Goods.ObjectId
                                         AND ObjectString_Value5.DescId = zc_ObjectString_GoodsQuality_Value5()
                   LEFT JOIN ObjectString AS ObjectString_Value6
                                          ON ObjectString_Value6.ObjectId = ObjectLink_GoodsQuality_Goods.ObjectId
                                         AND ObjectString_Value6.DescId = zc_ObjectString_GoodsQuality_Value6()
                   LEFT JOIN ObjectString AS ObjectString_Value7
                                          ON ObjectString_Value7.ObjectId = ObjectLink_GoodsQuality_Goods.ObjectId
                                         AND ObjectString_Value7.DescId = zc_ObjectString_GoodsQuality_Value7()
                   LEFT JOIN ObjectString AS ObjectString_Value8
                                          ON ObjectString_Value8.ObjectId = ObjectLink_GoodsQuality_Goods.ObjectId
                                         AND ObjectString_Value8.DescId = zc_ObjectString_GoodsQuality_Value8()
                   LEFT JOIN ObjectString AS ObjectString_Value9
                                          ON ObjectString_Value9.ObjectId = ObjectLink_GoodsQuality_Goods.ObjectId
                                         AND ObjectString_Value9.DescId = zc_ObjectString_GoodsQuality_Value9()
                   LEFT JOIN ObjectString AS ObjectString_Value10
                                          ON ObjectString_Value10.ObjectId = ObjectLink_GoodsQuality_Goods.ObjectId
                                         AND ObjectString_Value10.DescId = zc_ObjectString_GoodsQuality_Value10()
/* 
                   LEFT JOIN ObjectLink AS ObjectLink_Quality_Juridical
                                        ON ObjectLink_Quality_Juridical.ObjectId = Object_Quality.Id
                                       AND ObjectLink_Quality_Juridical.DescId = zc_ObjectLink_Quality_Juridical()
                   LEFT JOIN Object AS Object_Juridical ON Object_Juridical.Id = ObjectLink_Quality_Juridical.ChildObjectId
*/
            )

          , tmpMovement_list AS
            (SELECT tmp.QualityId, Movement.OperDate, Movement.Id AS MovementId
             FROM (SELECT QualityId FROM tmpGoodsQuality GROUP BY QualityId) AS tmp
                  INNER JOIN MovementLinkObject AS MLO_Quality
                                                ON MLO_Quality.ObjectId = tmp.QualityId
                                               AND MLO_Quality.DescId = zc_MovementLinkObject_Quality()
                  INNER JOIN Movement ON Movement.Id = MLO_Quality.MovementId
                                     AND Movement.DescId = zc_Movement_GoodsQuality()
                                     AND Movement.StatusId = zc_Enum_Status_Complete()
                                     AND Movement.OperDate <= vbOperDate
            )
          , tmpMovement_find AS
            (SELECT tmp.QualityId, MAX (tmpMovement_list.MovementId) AS MovementId
             FROM (SELECT tmpMovement_list.QualityId, MAX (tmpMovement_list.OperDate) AS OperDate FROM tmpMovement_list GROUP BY tmpMovement_list.QualityId) AS tmp
                  INNER JOIN tmpMovement_list ON tmpMovement_list.QualityId = tmp.QualityId
                                             AND tmpMovement_list.OperDate = tmp.OperDate
             GROUP BY tmp.QualityId
            )
          , tmpMovement_Quality AS
            (SELECT tmpMovement_find.QualityId
                  , Movement.Id                                        AS Id
                  , Movement.InvNumber                                 AS InvNumber
                  , Movement.OperDate                                  AS OperDate
                  , MD_OperDateCertificate.ValueData                   AS OperDateCertificate
                  , MS_CertificateNumber.ValueData                     AS CertificateNumber
                  , MS_CertificateSeries.ValueData                     AS CertificateSeries
                  , MS_CertificateSeriesNumber.ValueData               AS CertificateSeriesNumber
                  , MS_ExpertPrior.ValueData                           AS ExpertPrior
                  , MS_ExpertLast.ValueData                            AS ExpertLast
                  , MS_QualityNumber.ValueData                         AS QualityNumber
                  , MB_Comment.ValueData                               AS Comment
                  , 0                                                  AS ReportType
             FROM tmpMovement_find
                  LEFT JOIN Movement ON Movement.Id = tmpMovement_find.MovementId
                  LEFT JOIN MovementDate AS MD_OperDateCertificate
                                         ON MD_OperDateCertificate.MovementId =  tmpMovement_find.MovementId
                                        AND MD_OperDateCertificate.DescId = zc_MovementDate_OperDateCertificate()
                  LEFT JOIN MovementString AS MS_CertificateNumber
                                           ON MS_CertificateNumber.MovementId =  tmpMovement_find.MovementId
                                          AND MS_CertificateNumber.DescId = zc_MovementString_CertificateNumber()
                  LEFT JOIN MovementString AS MS_CertificateSeries
                                           ON MS_CertificateSeries.MovementId =  tmpMovement_find.MovementId
                                          AND MS_CertificateSeries.DescId = zc_MovementString_CertificateSeries()
                  LEFT JOIN MovementString AS MS_CertificateSeriesNumber
                                           ON MS_CertificateSeriesNumber.MovementId =  tmpMovement_find.MovementId
                                          AND MS_CertificateSeriesNumber.DescId = zc_MovementString_CertificateSeriesNumber()
                  LEFT JOIN MovementString AS MS_ExpertPrior
                                           ON MS_ExpertPrior.MovementId =  tmpMovement_find.MovementId
                                          AND MS_ExpertPrior.DescId = zc_MovementString_ExpertPrior()
                  LEFT JOIN MovementString AS MS_ExpertLast
                                           ON MS_ExpertLast.MovementId =  tmpMovement_find.MovementId
                                          AND MS_ExpertLast.DescId = zc_MovementString_ExpertLast()
                  LEFT JOIN MovementString AS MS_QualityNumber
                                           ON MS_QualityNumber.MovementId =  tmpMovement_find.MovementId
                                          AND MS_QualityNumber.DescId = zc_MovementString_QualityNumber()
                  LEFT JOIN MovementBlob AS MB_Comment
                                         ON MB_Comment.MovementId =  tmpMovement_find.MovementId
                                        AND MB_Comment.DescId = zc_MovementBlob_Comment()
            )

      SELECT Movement.Id				                              AS MovementId
           , Movement.InvNumber				                              AS InvNumber
           , Movement.OperDate				                              AS OperDate
           , COALESCE (MovementString_InvNumberPartner.ValueData, Movement.InvNumber) AS InvNumberPartner
           , COALESCE (MovementDate_OperDatePartner.ValueData, Movement.OperDate)     AS OperDatePartner
           , OH_JuridicalDetails_From.FullName                                        AS JuridicalName_From
           , OH_JuridicalDetails_From.JuridicalAddress                                AS JuridicalAddress_From

           , Object_GoodsGroup.ValueData                                              AS GoodsGroupName
           , Object_Measure.ValueData                                                 AS MeasureName
           , Object_Goods.ObjectCode                                                  AS GoodsCode
           , (Object_Goods.ValueData || CASE WHEN COALESCE (Object_GoodsKind.Id, zc_Enum_GoodsKind_Main()) = zc_Enum_GoodsKind_Main() THEN '' ELSE ' ' || Object_GoodsKind.ValueData END) :: TVarChar AS GoodsName
           , (CASE WHEN COALESCE (Object_GoodsKind.Id, zc_Enum_GoodsKind_Main()) = zc_Enum_GoodsKind_Main() THEN '' ELSE Object_GoodsKind.ValueData END)                                  :: TVarChar AS GoodsKindName

           , tmpMI.AmountPartner                                                                                AS AmountPartner
           , CAST (CASE WHEN Object_Measure.Id = zc_Measure_Kg() THEN tmpMI.AmountPartner ELSE 0 END AS TFloat) AS Amount5
           , 0                                                                                                  AS Amount9
           , CAST (CASE WHEN Object_Measure.Id = zc_Measure_Sh() THEN tmpMI.AmountPartner ELSE 0 END AS TFloat) AS Amount13

           , tmpGoodsQuality.QualityCode
           , tmpGoodsQuality.QualityName
           , tmpGoodsQuality.QualityComment
           , tmpGoodsQuality.Value17
           , tmpGoodsQuality.Value1
           , tmpGoodsQuality.Value2
           , tmpGoodsQuality.Value3
           , tmpGoodsQuality.Value4
           , tmpGoodsQuality.Value5
           , tmpGoodsQuality.Value6
           , tmpGoodsQuality.Value7
           , tmpGoodsQuality.Value8
           , tmpGoodsQuality.Value9
           , tmpGoodsQuality.Value10

           , tmpMovement_Quality.InvNumber AS InvNumber_Quality
           , tmpMovement_Quality.OperDate AS OperDate_Quality
           , tmpMovement_Quality.OperDateCertificate
           , tmpMovement_Quality.CertificateNumber
           , tmpMovement_Quality.CertificateSeries
           , tmpMovement_Quality.CertificateSeriesNumber
           , tmpMovement_Quality.ExpertPrior
           , tmpMovement_Quality.ExpertLast
           , tmpMovement_Quality.QualityNumber
           , tmpMovement_Quality.Comment AS QualityComment_Movement
           , tmpMovement_Quality.ReportType

       FROM tmpMI
            INNER JOIN Movement ON Movement.Id =  tmpMI.MovementId
            LEFT JOIN Object AS Object_Goods ON Object_Goods.Id = tmpMI.ObjectId

            LEFT JOIN tmpGoodsQuality ON tmpGoodsQuality.GoodsId = tmpMI.ObjectId
            LEFT JOIN tmpMovement_Quality ON tmpMovement_Quality.QualityId = tmpGoodsQuality.QualityId

            LEFT JOIN ObjectLink AS ObjectLink_Goods_GoodsGroup
                                 ON ObjectLink_Goods_GoodsGroup.ObjectId = tmpMI.ObjectId
                                AND ObjectLink_Goods_GoodsGroup.DescId = zc_ObjectLink_Goods_GoodsGroup()
            LEFT JOIN Object AS Object_GoodsGroup ON Object_GoodsGroup.Id = ObjectLink_Goods_GoodsGroup.ChildObjectId

            LEFT JOIN ObjectLink AS ObjectLink_Goods_Measure
                                 ON ObjectLink_Goods_Measure.ObjectId = tmpMI.ObjectId
                                AND ObjectLink_Goods_Measure.DescId = zc_ObjectLink_Goods_Measure()
            LEFT JOIN Object AS Object_Measure ON Object_Measure.Id = ObjectLink_Goods_Measure.ChildObjectId

            LEFT JOIN MovementItemLinkObject AS MILinkObject_GoodsKind
                                             ON MILinkObject_GoodsKind.MovementItemId = tmpMI.Id
                                            AND MILinkObject_GoodsKind.DescId = zc_MILinkObject_GoodsKind()
            LEFT JOIN Object AS Object_GoodsKind ON Object_GoodsKind.Id = MILinkObject_GoodsKind.ObjectId

            LEFT JOIN MovementLinkObject AS MovementLinkObject_From
                                         ON MovementLinkObject_From.MovementId = tmpMI.MovementId
                                        AND MovementLinkObject_From.DescId = zc_MovementLinkObject_From()
            LEFT JOIN MovementLinkObject AS MovementLinkObject_Contract
                                         ON MovementLinkObject_Contract.MovementId = tmpMI.MovementId
                                        AND MovementLinkObject_Contract.DescId IN (zc_MovementLinkObject_Contract(), zc_MovementLinkObject_ContractTo())
            LEFT JOIN Object_Contract_View AS View_Contract ON View_Contract.ContractId = MovementLinkObject_Contract.ObjectId

            LEFT JOIN MovementDate AS MovementDate_OperDatePartner
                                   ON MovementDate_OperDatePartner.MovementId =  tmpMI.MovementId
                                  AND MovementDate_OperDatePartner.DescId = zc_MovementDate_OperDatePartner()
            LEFT JOIN MovementString AS MovementString_InvNumberPartner
                                     ON MovementString_InvNumberPartner.MovementId =  tmpMI.MovementId
                                    AND MovementString_InvNumberPartner.DescId = zc_MovementString_InvNumberPartner()

            LEFT JOIN ObjectHistory_JuridicalDetails_ViewByDate AS OH_JuridicalDetails_From
                                                                ON OH_JuridicalDetails_From.JuridicalId = COALESCE (View_Contract.JuridicalBasisId, MovementLinkObject_From.ObjectId)
                                                               AND COALESCE (MovementDate_OperDatePartner.ValueData, Movement.OperDate) >= OH_JuridicalDetails_From.StartDate
                                                               AND COALESCE (MovementDate_OperDatePartner.ValueData, Movement.OperDate) <  OH_JuridicalDetails_From.EndDate

      ORDER BY tmpGoodsQuality.QualityCode
             , Object_GoodsGroup.ValueData
             , Object_Goods.ValueData
             , Object_GoodsKind.ValueData
      ;
     RETURN NEXT Cursor1;


     -- ������: ��������� + �������� ����� ��� ����� 2
     OPEN Cursor2 FOR
       WITH tmpMI AS
            (SELECT MovementItem.*
                  , MIFloat_AmountPartner.ValueData AS AmountPartner
             FROM MovementItem
                  INNER JOIN MovementItemFloat AS MIFloat_Price
                                               ON MIFloat_Price.MovementItemId = MovementItem.Id
                                              AND MIFloat_Price.DescId = zc_MIFloat_Price()
                                              AND MIFloat_Price.ValueData <> 0
                  INNER JOIN MovementItemFloat AS MIFloat_AmountPartner
                                               ON MIFloat_AmountPartner.MovementItemId = MovementItem.Id
                                              AND MIFloat_AmountPartner.DescId = zc_MIFloat_AmountPartner()
                                              AND MIFloat_AmountPartner.ValueData <> 0
             WHERE MovementItem.MovementId =  inMovementId
               AND MovementItem.DescId     = zc_MI_Master()
               AND MovementItem.isErased   = FALSE
            )
          , tmpMIGoods AS (SELECT DISTINCT tmpMI.ObjectId AS GoodsId FROM tmpMI)
          , tmpGoodsQuality AS
            (SELECT tmpMIGoods.GoodsId          AS GoodsId
                  , Object_Quality.Id           AS QualityId
                  , Object_Quality.ObjectCode   AS QualityCode
                  , Object_Quality.ValueData    AS QualityName
                  , OS_QualityComment.ValueData AS QualityComment

                  , Object_GoodsQuality.ValueData AS Value17
                  , ObjectString_Value1.ValueData AS Value1
                  , ObjectString_Value2.ValueData AS Value2
                  , ObjectString_Value3.ValueData AS Value3
                  , ObjectString_Value4.ValueData AS Value4
                  , ObjectString_Value5.ValueData AS Value5
                  , ObjectString_Value6.ValueData AS Value6
                  , ObjectString_Value7.ValueData AS Value7
                  , ObjectString_Value8.ValueData AS Value8
                  , ObjectString_Value9.ValueData AS Value9
                  , ObjectString_Value10.ValueData AS Value10
              FROM tmpMIGoods
                   INNER JOIN ObjectLink AS ObjectLink_GoodsQuality_Goods
                                         ON ObjectLink_GoodsQuality_Goods.ChildObjectId = tmpMIGoods.GoodsId
                                        AND ObjectLink_GoodsQuality_Goods.DescId = zc_ObjectLink_GoodsQuality_Goods()
                   LEFT JOIN ObjectLink AS ObjectLink_GoodsQuality_Quality
                                        ON ObjectLink_GoodsQuality_Quality.ObjectId = ObjectLink_GoodsQuality_Goods.ObjectId
                                       AND ObjectLink_GoodsQuality_Quality.DescId = zc_ObjectLink_GoodsQuality_Quality()

                   LEFT JOIN Object AS Object_GoodsQuality ON Object_GoodsQuality.Id = ObjectLink_GoodsQuality_Quality.ObjectId

                   LEFT JOIN Object AS Object_Quality ON Object_Quality.Id = ObjectLink_GoodsQuality_Quality.ChildObjectId
                   LEFT JOIN ObjectString AS OS_QualityComment
                                          ON OS_QualityComment.ObjectId = ObjectLink_GoodsQuality_Quality.ChildObjectId
                                         AND OS_QualityComment.DescId = zc_ObjectString_Quality_Comment()

                   LEFT JOIN ObjectString AS ObjectString_Value1
                                          ON ObjectString_Value1.ObjectId = ObjectLink_GoodsQuality_Goods.ObjectId
                                         AND ObjectString_Value1.DescId = zc_ObjectString_GoodsQuality_Value1()
                   LEFT JOIN ObjectString AS ObjectString_Value2
                                          ON ObjectString_Value2.ObjectId = ObjectLink_GoodsQuality_Goods.ObjectId
                                         AND ObjectString_Value2.DescId = zc_ObjectString_GoodsQuality_Value2()
                   LEFT JOIN ObjectString AS ObjectString_Value3
                                          ON ObjectString_Value3.ObjectId = ObjectLink_GoodsQuality_Goods.ObjectId
                                         AND ObjectString_Value3.DescId = zc_ObjectString_GoodsQuality_Value3()
                   LEFT JOIN ObjectString AS ObjectString_Value4
                                          ON ObjectString_Value4.ObjectId = ObjectLink_GoodsQuality_Goods.ObjectId
                                         AND ObjectString_Value4.DescId = zc_ObjectString_GoodsQuality_Value4()
                   LEFT JOIN ObjectString AS ObjectString_Value5
                                          ON ObjectString_Value5.ObjectId = ObjectLink_GoodsQuality_Goods.ObjectId
                                         AND ObjectString_Value5.DescId = zc_ObjectString_GoodsQuality_Value5()
                   LEFT JOIN ObjectString AS ObjectString_Value6
                                          ON ObjectString_Value6.ObjectId = ObjectLink_GoodsQuality_Goods.ObjectId
                                         AND ObjectString_Value6.DescId = zc_ObjectString_GoodsQuality_Value6()
                   LEFT JOIN ObjectString AS ObjectString_Value7
                                          ON ObjectString_Value7.ObjectId = ObjectLink_GoodsQuality_Goods.ObjectId
                                         AND ObjectString_Value7.DescId = zc_ObjectString_GoodsQuality_Value7()
                   LEFT JOIN ObjectString AS ObjectString_Value8
                                          ON ObjectString_Value8.ObjectId = ObjectLink_GoodsQuality_Goods.ObjectId
                                         AND ObjectString_Value8.DescId = zc_ObjectString_GoodsQuality_Value8()
                   LEFT JOIN ObjectString AS ObjectString_Value9
                                          ON ObjectString_Value9.ObjectId = ObjectLink_GoodsQuality_Goods.ObjectId
                                         AND ObjectString_Value9.DescId = zc_ObjectString_GoodsQuality_Value9()
                   LEFT JOIN ObjectString AS ObjectString_Value10
                                          ON ObjectString_Value10.ObjectId = ObjectLink_GoodsQuality_Goods.ObjectId
                                         AND ObjectString_Value10.DescId = zc_ObjectString_GoodsQuality_Value10()
/* 
                   LEFT JOIN ObjectLink AS ObjectLink_Quality_Juridical
                                        ON ObjectLink_Quality_Juridical.ObjectId = Object_Quality.Id
                                       AND ObjectLink_Quality_Juridical.DescId = zc_ObjectLink_Quality_Juridical()
                   LEFT JOIN Object AS Object_Juridical ON Object_Juridical.Id = ObjectLink_Quality_Juridical.ChildObjectId
*/
            )

          , tmpMovement_list AS
            (SELECT tmp.QualityId, Movement.OperDate, Movement.Id AS MovementId
             FROM (SELECT QualityId FROM tmpGoodsQuality GROUP BY QualityId) AS tmp
                  INNER JOIN MovementLinkObject AS MLO_Quality
                                                ON MLO_Quality.ObjectId = tmp.QualityId
                                               AND MLO_Quality.DescId = zc_MovementLinkObject_Quality()
                  INNER JOIN Movement ON Movement.Id = MLO_Quality.MovementId
                                     AND Movement.DescId = zc_Movement_GoodsQuality()
                                     AND Movement.StatusId = zc_Enum_Status_Complete()
                                     AND Movement.OperDate <= vbOperDate
            )
          , tmpMovement_find AS
            (SELECT tmp.QualityId, MAX (tmpMovement_list.MovementId) AS MovementId
             FROM (SELECT tmpMovement_list.QualityId, MAX (tmpMovement_list.OperDate) AS OperDate FROM tmpMovement_list GROUP BY tmpMovement_list.QualityId) AS tmp
                  INNER JOIN tmpMovement_list ON tmpMovement_list.QualityId = tmp.QualityId
                                             AND tmpMovement_list.OperDate = tmp.OperDate
             GROUP BY tmp.QualityId
            )
          , tmpMovement_Quality AS
            (SELECT tmpMovement_find.QualityId
                  , Movement.Id                                        AS Id
                  , Movement.InvNumber                                 AS InvNumber
                  , Movement.OperDate                                  AS OperDate
                  , MD_OperDateCertificate.ValueData                   AS OperDateCertificate
                  , MS_CertificateNumber.ValueData                     AS CertificateNumber
                  , MS_CertificateSeries.ValueData                     AS CertificateSeries
                  , MS_CertificateSeriesNumber.ValueData               AS CertificateSeriesNumber
                  , MS_ExpertPrior.ValueData                           AS ExpertPrior
                  , MS_ExpertLast.ValueData                            AS ExpertLast
                  , MS_QualityNumber.ValueData                         AS QualityNumber
                  , MB_Comment.ValueData                               AS Comment
                  , 0                                                  AS ReportType
             FROM tmpMovement_find
                  LEFT JOIN Movement ON Movement.Id = tmpMovement_find.MovementId
                  LEFT JOIN MovementDate AS MD_OperDateCertificate
                                         ON MD_OperDateCertificate.MovementId =  tmpMovement_find.MovementId
                                        AND MD_OperDateCertificate.DescId = zc_MovementDate_OperDateCertificate()
                  LEFT JOIN MovementString AS MS_CertificateNumber
                                           ON MS_CertificateNumber.MovementId =  tmpMovement_find.MovementId
                                          AND MS_CertificateNumber.DescId = zc_MovementString_CertificateNumber()
                  LEFT JOIN MovementString AS MS_CertificateSeries
                                           ON MS_CertificateSeries.MovementId =  tmpMovement_find.MovementId
                                          AND MS_CertificateSeries.DescId = zc_MovementString_CertificateSeries()
                  LEFT JOIN MovementString AS MS_CertificateSeriesNumber
                                           ON MS_CertificateSeriesNumber.MovementId =  tmpMovement_find.MovementId
                                          AND MS_CertificateSeriesNumber.DescId = zc_MovementString_CertificateSeriesNumber()
                  LEFT JOIN MovementString AS MS_ExpertPrior
                                           ON MS_ExpertPrior.MovementId =  tmpMovement_find.MovementId
                                          AND MS_ExpertPrior.DescId = zc_MovementString_ExpertPrior()
                  LEFT JOIN MovementString AS MS_ExpertLast
                                           ON MS_ExpertLast.MovementId =  tmpMovement_find.MovementId
                                          AND MS_ExpertLast.DescId = zc_MovementString_ExpertLast()
                  LEFT JOIN MovementString AS MS_QualityNumber
                                           ON MS_QualityNumber.MovementId =  tmpMovement_find.MovementId
                                          AND MS_QualityNumber.DescId = zc_MovementString_QualityNumber()
                  LEFT JOIN MovementBlob AS MB_Comment
                                         ON MB_Comment.MovementId =  tmpMovement_find.MovementId
                                        AND MB_Comment.DescId = zc_MovementBlob_Comment()
            )

      SELECT Movement.Id				                              AS MovementId
           , Movement.InvNumber				                              AS InvNumber
           , Movement.OperDate				                              AS OperDate
           , COALESCE (MovementString_InvNumberPartner.ValueData, Movement.InvNumber) AS InvNumberPartner
           , COALESCE (MovementDate_OperDatePartner.ValueData, Movement.OperDate)     AS OperDatePartner
           , OH_JuridicalDetails_From.FullName                                        AS JuridicalName_From
           , OH_JuridicalDetails_From.JuridicalAddress                                AS JuridicalAddress_From

           , Object_GoodsGroup.ValueData                                              AS GoodsGroupName
           , Object_Measure.ValueData                                                 AS MeasureName
           , Object_Goods.ObjectCode                                                  AS GoodsCode
           , (Object_Goods.ValueData || CASE WHEN COALESCE (Object_GoodsKind.Id, zc_Enum_GoodsKind_Main()) = zc_Enum_GoodsKind_Main() THEN '' ELSE ' ' || Object_GoodsKind.ValueData END) :: TVarChar AS GoodsName
           , (CASE WHEN COALESCE (Object_GoodsKind.Id, zc_Enum_GoodsKind_Main()) = zc_Enum_GoodsKind_Main() THEN '' ELSE Object_GoodsKind.ValueData END)                                  :: TVarChar AS GoodsKindName

           , tmpMI.AmountPartner                                                                                AS AmountPartner
           , CAST (CASE WHEN Object_Measure.Id = zc_Measure_Kg() THEN tmpMI.AmountPartner ELSE 0 END AS TFloat) AS Amount5
           , 0                                                                                                  AS Amount9
           , CAST (CASE WHEN Object_Measure.Id = zc_Measure_Sh() THEN tmpMI.AmountPartner ELSE 0 END AS TFloat) AS Amount13

           , tmpGoodsQuality.QualityCode
           , tmpGoodsQuality.QualityName
           , tmpGoodsQuality.QualityComment
           , tmpGoodsQuality.Value17
           , tmpGoodsQuality.Value1
           , tmpGoodsQuality.Value2
           , tmpGoodsQuality.Value3
           , tmpGoodsQuality.Value4
           , tmpGoodsQuality.Value5
           , tmpGoodsQuality.Value6
           , tmpGoodsQuality.Value7
           , tmpGoodsQuality.Value8
           , tmpGoodsQuality.Value9
           , tmpGoodsQuality.Value10

           , tmpMovement_Quality.InvNumber AS InvNumber_Quality
           , tmpMovement_Quality.OperDate AS OperDate_Quality
           , tmpMovement_Quality.OperDateCertificate
           , tmpMovement_Quality.CertificateNumber
           , tmpMovement_Quality.CertificateSeries
           , tmpMovement_Quality.CertificateSeriesNumber
           , tmpMovement_Quality.ExpertPrior
           , tmpMovement_Quality.ExpertLast
           , tmpMovement_Quality.QualityNumber
           , tmpMovement_Quality.Comment AS QualityComment_Movement
           , tmpMovement_Quality.ReportType

       FROM tmpMI
            INNER JOIN Movement ON Movement.Id =  tmpMI.MovementId
            LEFT JOIN Object AS Object_Goods ON Object_Goods.Id = tmpMI.ObjectId

            LEFT JOIN tmpGoodsQuality ON tmpGoodsQuality.GoodsId = tmpMI.ObjectId
            LEFT JOIN tmpMovement_Quality ON tmpMovement_Quality.QualityId = tmpGoodsQuality.QualityId

            LEFT JOIN ObjectLink AS ObjectLink_Goods_GoodsGroup
                                 ON ObjectLink_Goods_GoodsGroup.ObjectId = tmpMI.ObjectId
                                AND ObjectLink_Goods_GoodsGroup.DescId = zc_ObjectLink_Goods_GoodsGroup()
            LEFT JOIN Object AS Object_GoodsGroup ON Object_GoodsGroup.Id = ObjectLink_Goods_GoodsGroup.ChildObjectId

            LEFT JOIN ObjectLink AS ObjectLink_Goods_Measure
                                 ON ObjectLink_Goods_Measure.ObjectId = tmpMI.ObjectId
                                AND ObjectLink_Goods_Measure.DescId = zc_ObjectLink_Goods_Measure()
            LEFT JOIN Object AS Object_Measure ON Object_Measure.Id = ObjectLink_Goods_Measure.ChildObjectId

            LEFT JOIN MovementItemLinkObject AS MILinkObject_GoodsKind
                                             ON MILinkObject_GoodsKind.MovementItemId = tmpMI.Id
                                            AND MILinkObject_GoodsKind.DescId = zc_MILinkObject_GoodsKind()
            LEFT JOIN Object AS Object_GoodsKind ON Object_GoodsKind.Id = MILinkObject_GoodsKind.ObjectId

            LEFT JOIN MovementLinkObject AS MovementLinkObject_From
                                         ON MovementLinkObject_From.MovementId = tmpMI.MovementId
                                        AND MovementLinkObject_From.DescId = zc_MovementLinkObject_From()
            LEFT JOIN MovementLinkObject AS MovementLinkObject_Contract
                                         ON MovementLinkObject_Contract.MovementId = tmpMI.MovementId
                                        AND MovementLinkObject_Contract.DescId IN (zc_MovementLinkObject_Contract(), zc_MovementLinkObject_ContractTo())
            LEFT JOIN Object_Contract_View AS View_Contract ON View_Contract.ContractId = MovementLinkObject_Contract.ObjectId

            LEFT JOIN MovementDate AS MovementDate_OperDatePartner
                                   ON MovementDate_OperDatePartner.MovementId =  tmpMI.MovementId
                                  AND MovementDate_OperDatePartner.DescId = zc_MovementDate_OperDatePartner()
            LEFT JOIN MovementString AS MovementString_InvNumberPartner
                                     ON MovementString_InvNumberPartner.MovementId =  tmpMI.MovementId
                                    AND MovementString_InvNumberPartner.DescId = zc_MovementString_InvNumberPartner()

            LEFT JOIN ObjectHistory_JuridicalDetails_ViewByDate AS OH_JuridicalDetails_From
                                                                ON OH_JuridicalDetails_From.JuridicalId = COALESCE (View_Contract.JuridicalBasisId, MovementLinkObject_From.ObjectId)
                                                               AND COALESCE (MovementDate_OperDatePartner.ValueData, Movement.OperDate) >= OH_JuridicalDetails_From.StartDate
                                                               AND COALESCE (MovementDate_OperDatePartner.ValueData, Movement.OperDate) <  OH_JuridicalDetails_From.EndDate

      ORDER BY tmpGoodsQuality.QualityCode
             , Object_GoodsGroup.ValueData
             , Object_Goods.ValueData
             , Object_GoodsKind.ValueData
      ;
     RETURN NEXT Cursor2;


END;
$BODY$
  LANGUAGE plpgsql VOLATILE;
ALTER FUNCTION gpSelect_Movement_GoodsQuality_Print (Integer, TVarChar) OWNER TO postgres;

/*
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.   ������ �.�.
 31.03.15                                        * all
 11.02.15                                                       *
*/

-- ����
-- SELECT * FROM gpSelect_Movement_GoodsQuality_Print (inMovementId:= 130359, inSession:= zfCalc_UserAdmin());
