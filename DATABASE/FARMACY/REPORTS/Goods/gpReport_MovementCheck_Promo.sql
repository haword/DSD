-- Function: gpSelect_Movement_PriceList()

DROP FUNCTION IF EXISTS gpReport_MovementCheck_Promo (Integer, TDateTime, TDateTime, TVarChar);

CREATE OR REPLACE FUNCTION gpReport_MovementCheck_Promo(
    IN inMakerId       Integer     -- �������������
  , IN inStartDate     TDateTime 
  , IN inEndDate       TDateTime
  , IN inSession       TVarChar    -- ������ ������������
)
RETURNS TABLE (MovementId Integer      --�� ���������
              ,ItemName TVarChar       --��������(���) ���������
              ,Amount TFloat           --���-�� ������ � ���������
              ,Code Integer            --��� ������
              ,Name TVarChar           --������������ ������
  --            ,PartnerGoodsName TVarChar  --������������ ����������
  --            ,MakerName  TVarChar     --�������������
              ,NDSKindName TVarChar    --��� ���
              ,OperDate TDateTime      --���� ���������
              ,InvNumber TVarChar      --� ���������
              ,StatusName TVarChar     --��������� ���������
              ,UnitName TVarChar       --�������������
              ,MainJuridicalName TVarChar  --���� ��. ����
              ,JuridicalName TVarChar  --��. ����
              ,RetailName TVarChar     --�������� ����
              ,Price TFloat            --���� � ���������
              ,PriceWithVAT TFloat     --���� ������� � ��� 
              ,PriceSale TFloat        --���� �������
              ,Comment  TVarChar       --����������� � ���������
              ,PartionGoods TVarChar   --� ����� ���������
              ,ExpirationDate TDateTime--���� ��������
              ,InsertDate TDateTime    --���� (����.)
              )
AS
$BODY$
   DECLARE vbUserId Integer;
BEGIN
    -- �������� ���� ������������ �� ����� ���������
    -- PERFORM lpCheckRight (inSession, zc_Enum_Process_Select_Movement_PriceList());
    vbUserId:= lpGetUserBySession (inSession);
 
    RETURN QUERY
      WITH
        tmpGoods AS (SELECT MI_Goods.ObjectId                AS GoodsId_MI     -- ����� ����� "����"
                          , ObjectLink_Child_R.ChildObjectId AS GoodsId        -- ����� �����
                       FROM Movement
                              INNER JOIN MovementLinkObject AS MovementLinkObject_Maker
                                                            ON MovementLinkObject_Maker.MovementId = Movement.Id
                                                           AND MovementLinkObject_Maker.DescId = zc_MovementLinkObject_Maker()
                                                           AND MovementLinkObject_Maker.ObjectId = inMakerId

                              INNER JOIN MovementItem AS MI_Goods ON MI_Goods.MovementId = Movement.Id
                                                                 AND MI_Goods.DescId = zc_MI_Master()
                                                                 AND MI_Goods.isErased = FALSE
                               -- !!!
                              INNER JOIN ObjectLink AS ObjectLink_Child
                                                    ON ObjectLink_Child.ChildObjectId = MI_Goods.ObjectId 
                                                   AND ObjectLink_Child.DescId        = zc_ObjectLink_LinkGoods_Goods()
                              INNER JOIN ObjectLink AS ObjectLink_Main ON ObjectLink_Main.ObjectId = ObjectLink_Child.ObjectId
                                                                      AND ObjectLink_Main.DescId   = zc_ObjectLink_LinkGoods_GoodsMain()
                              INNER JOIN ObjectLink AS ObjectLink_Main_R ON ObjectLink_Main_R.ChildObjectId = ObjectLink_Main.ChildObjectId
                                                                        AND ObjectLink_Main_R.DescId        = zc_ObjectLink_LinkGoods_GoodsMain()
                              INNER JOIN ObjectLink AS ObjectLink_Child_R ON ObjectLink_Child_R.ObjectId = ObjectLink_Main_R.ObjectId
                                                                         AND ObjectLink_Child_R.DescId   = zc_ObjectLink_LinkGoods_Goods()
                         WHERE Movement.StatusId = zc_Enum_Status_Complete()
                           AND Movement.DescId = zc_Movement_Promo()
                        ) ,
               tmpMI AS (SELECT MIContainer.ContainerId
                              , Movement_Check.Id                   AS MovementId_Check
                              , MovementLinkObject_Unit.ObjectId    AS UnitId
                              , MI_Check.ObjectId                   AS GoodsId
                              , SUM (COALESCE (-1 * MIContainer.Amount, MI_Check.Amount)) AS Amount
                              , SUM (COALESCE (-1 * MIContainer.Amount, MI_Check.Amount) * COALESCE (MIFloat_Price.ValueData, 0)) AS SummaSale
                         FROM Movement AS Movement_Check
                              INNER JOIN MovementLinkObject AS MovementLinkObject_Unit
                                                            ON MovementLinkObject_Unit.MovementId = Movement_Check.Id
                                                           AND MovementLinkObject_Unit.DescId = zc_MovementLinkObject_Unit()
                                                           
                              INNER JOIN MovementItem AS MI_Check
                                                      ON MI_Check.MovementId = Movement_Check.Id
                                                     AND MI_Check.DescId = zc_MI_Master()
                                                     AND MI_Check.isErased = FALSE
                              -- ������ ������ ����.�����.
                              INNER JOIN tmpGoods ON tmpGoods.GoodsId = MI_Check.ObjectId

                              LEFT JOIN MovementItemFloat AS MIFloat_Price
                                                          ON MIFloat_Price.MovementItemId = MI_Check.Id
                                                         AND MIFloat_Price.DescId = zc_MIFloat_Price()
                              LEFT JOIN MovementItemContainer AS MIContainer
                                                              ON MIContainer.MovementItemId = MI_Check.Id
                                                             AND MIContainer.DescId = zc_MIContainer_Count() 
                         WHERE Movement_Check.DescId = zc_Movement_Check()
                           AND Movement_Check.OperDate >= inStartDate AND Movement_Check.OperDate < inEndDate + INTERVAL '1 DAY'
                           AND Movement_Check.StatusId = zc_Enum_Status_Complete()
                           AND COALESCE (inMakerId, 0) <> 0
                         GROUP BY MI_Check.ObjectId
                                , Movement_Check.Id
                                , MovementLinkObject_Unit.ObjectId
                                , MIContainer.ContainerId
                         HAVING SUM (COALESCE (-1 * MIContainer.Amount, MI_Check.Amount)) <> 0
                        )
       , tmpData_1 AS (SELECT tmpMI.MovementId_Check
                              , tmpMI.UnitId
                              , COALESCE (MI_Income_find.MovementId, MI_Income.MovementId) :: Integer AS MovementId
                              , COALESCE (MI_Income_find.Id,         MI_Income.Id)         :: Integer AS MovementItemId_Income
                              , tmpMI.GoodsId
                              , (tmpMI.Amount)    AS Amount
                              , (tmpMI.SummaSale) AS SummaSale
                         FROM tmpMI
                              -- ����� ������
                              LEFT JOIN ContainerlinkObject AS ContainerLinkObject_MovementItem
                                                            ON ContainerLinkObject_MovementItem.Containerid = tmpMI.ContainerId
                                                           AND ContainerLinkObject_MovementItem.DescId = zc_ContainerLinkObject_PartionMovementItem()
                              LEFT OUTER JOIN Object AS Object_PartionMovementItem ON Object_PartionMovementItem.Id = ContainerLinkObject_MovementItem.ObjectId

                              -- ������� �������
                              LEFT JOIN MovementItem AS MI_Income ON MI_Income.Id = Object_PartionMovementItem.ObjectCode
                              -- ���� ��� ������, ������� ���� ������� ��������������� - � ���� �������� ����� "���������" ��������� ������ �� ����������
                              LEFT JOIN MovementItemFloat AS MIFloat_MovementItem
                                                          ON MIFloat_MovementItem.MovementItemId = MI_Income.Id
                                                         AND MIFloat_MovementItem.DescId = zc_MIFloat_MovementItemId()
                              -- �������� ������� �� ���������� (���� ��� ������, ������� ���� ������� ���������������)
                              LEFT JOIN MovementItem AS MI_Income_find ON MI_Income_find.Id = (MIFloat_MovementItem.ValueData :: Integer)
                        )
           -- ����� ������������ �������� �������������� ���������
       , tmpData_all AS (SELECT tmpData_1.MovementId_Check
                              , tmpData_1.UnitId
                              , tmpData_1.MovementItemId_Income
                              , tmpData_1.GoodsId
                              , tmpData_1.Amount
                              , tmpData_1.SummaSale
                              , MovementLinkObject_From_Income.ObjectId AS JuridicalId_Income
                         FROM tmpData_1
                              INNER JOIN Movement AS Movement_Income ON Movement_Income.Id = tmpData_1.MovementId
                              -- ���������, ��� �������� ������� �� ���������� (��� NULL)
                              LEFT JOIN MovementLinkObject AS MovementLinkObject_From_Income
                                                           ON MovementLinkObject_From_Income.MovementId = tmpData_1.MovementId
                                                          AND MovementLinkObject_From_Income.DescId     = zc_MovementLinkObject_From()
                                                    
                              INNER JOIN MovementDate AS MovementDate_StartPromo
                                                      ON MovementDate_StartPromo.DescId = zc_MovementDate_StartPromo()
                                                     AND MovementDate_StartPromo.ValueData <= Movement_Income.OperDate
                              INNER JOIN MovementDate AS MovementDate_EndPromo
                                                      ON MovementDate_EndPromo.DescId = zc_MovementDate_EndPromo()
                                                     AND MovementDate_EndPromo.ValueData >= Movement_Income.OperDate
                              INNER JOIN MovementLinkObject AS MovementLinkObject_Maker
                                                            ON MovementLinkObject_Maker.MovementId = MovementDate_StartPromo.MovementId
                                                           AND MovementLinkObject_Maker.DescId = zc_MovementLinkObject_Maker()
                                                           AND MovementLinkObject_Maker.ObjectId = inMakerId
                              INNER JOIN Movement AS Movement_Promo ON Movement_Promo.Id = MovementDate_StartPromo.MovementId
                                                                   AND Movement_Promo.DescId = zc_Movement_Promo()
                                                                   AND Movement_Promo.StatusId = zc_Enum_Status_Complete()
                              INNER JOIN MovementItem AS MI_Goods ON MI_Goods.MovementId = Movement_Promo.Id
                                                                 AND MI_Goods.DescId = zc_MI_Master()
                                                                 AND MI_Goods.isErased = FALSE
                                                                 --AND MI_Goods.ObjectId = tmpData_1.GoodsId
                              -- !!!
                              INNER JOIN tmpGoods ON tmpGoods.GoodsId_MI = MI_Goods.ObjectId
                                                 AND tmpGoods.GoodsId = tmpData_1.GoodsId

                              INNER JOIN MovementItem AS MI_Juridical ON MI_Juridical.MovementId = Movement_Promo.Id
                                                                     AND MI_Juridical.DescId = zc_MI_Child()
                                                                     AND MI_Juridical.isErased = FALSE
                                                                     AND MI_Juridical.ObjectId = MovementLinkObject_From_Income.ObjectId
                             ) 

           , tmpData AS (SELECT tmpData_all.MovementId_Check
                              , tmpData_all.UnitId
                              , tmpData_all.JuridicalId_Income
                              , tmpData_all.GoodsId
                              , MIString_PartionGoods.ValueData          AS PartionGoods
                              , MIDate_ExpirationDate.ValueData          AS ExpirationDate
                              --, MI_Income_View.PartnerGoodsName          AS PartnerGoodsName
                              --, MI_Income_View.MakerName                 AS MakerName
                              , SUM (tmpData_all.Amount * COALESCE (MIFloat_JuridicalPrice.ValueData, 0))  AS Summa
                              , SUM (tmpData_all.Amount * COALESCE (MIFloat_PriceWithVAT.ValueData, 0))    AS SummaWithVAT
                              , SUM (tmpData_all.Amount)    AS Amount
                              , SUM (tmpData_all.SummaSale) AS SummaSale
                         FROM tmpData_all
                              -- ���� � ������ ���, ��� �������� ������� �� ���������� (��� NULL)
                              LEFT JOIN MovementItemFloat AS MIFloat_JuridicalPrice
                                                          ON MIFloat_JuridicalPrice.MovementItemId = tmpData_all.MovementItemId_Income
                                                         AND MIFloat_JuridicalPrice.DescId = zc_MIFloat_JuridicalPrice()
                              -- ���� � ������ ���, ��� �������� ������� �� ���������� ��� % �������������  (��� NULL)
                              LEFT JOIN MovementItemFloat AS MIFloat_PriceWithVAT
                                                          ON MIFloat_PriceWithVAT.MovementItemId = tmpData_all.MovementItemId_Income
                                                         AND MIFloat_PriceWithVAT.DescId = zc_MIFloat_PriceWithVAT()
                              -- � ������ ���������
                              LEFT JOIN MovementItemString AS MIString_PartionGoods
                                                           ON MIString_PartionGoods.MovementItemId = tmpData_all.MovementItemId_Income
                                                          AND MIString_PartionGoods.DescId = zc_MIString_PartionGoods()
                              -- ���� ��������
                              LEFT JOIN MovementItemDate AS MIDate_ExpirationDate
                                                         ON MIDate_ExpirationDate.MovementItemId = tmpData_all.MovementItemId_Income
                                                        AND MIDate_ExpirationDate.DescId = zc_MIDate_PartionGoods()
                          
                             -- LEFT JOIN MovementItem_Income_View AS MI_Income_View ON MI_Income_View.Id = tmpData_all.MovementItemId_Income

                         GROUP BY tmpData_all.JuridicalId_Income
                                , tmpData_all.MovementId_Check
                                , tmpData_all.GoodsId
                                , tmpData_all.UnitId
                                , MIString_PartionGoods.ValueData
                                , MIDate_ExpirationDate.ValueData
                             --   , MI_Income_View.PartnerGoodsName
                             --   , MI_Income_View.MakerName
                        )


      SELECT Movement.Id                              AS MovementId
            ,'������� ����'               :: TVarChar AS ItemName
            ,tmpData.Amount               :: TFloat   AS Amount
            ,Object.ObjectCode                        AS Code
            ,Object.ValueData                         AS Name
       --     ,tmpData.PartnerGoodsName     :: TVarChar
       --     ,tmpData.MakerName            :: TVarChar

            ,Object_NDSKind.ValueData                 AS NDSKindName
            ,Movement.OperDate                        AS OperDate
            ,Movement.InvNumber                       AS InvNumber
            ,Object_Status.ValueData                  AS StatusName
            ,Object_Unit.ValueData                    AS UnitName
            ,Object_MainJuridical.ValueData           AS MainJuridicalName
            ,Object_From.ValueData                    AS JuridicalName
            ,Object_Retail.ValueData                  AS RetailName 
            ,CASE WHEN tmpData.Amount <> 0 THEN tmpData.Summa / tmpData.Amount ELSE 0 END        :: TFloat AS Price
            ,CASE WHEN tmpData.Amount <> 0 THEN tmpData.SummaWithVAT / tmpData.Amount ELSE 0 END :: TFloat AS PriceWithVAT

            ,CASE WHEN tmpData.Amount <> 0 THEN tmpData.SummaSale    / tmpData.Amount ELSE 0 END :: TFloat AS PriceSale

            ,MovementString_Comment.ValueData  :: TVarChar        AS Comment

            ,tmpData.PartionGoods
            ,tmpData.ExpirationDate
           
            ,MovementDate_Insert.ValueData            AS InsertDate

      FROM tmpData 
        LEFT JOIN Movement ON Movement.Id = tmpData.MovementId_Check
        LEFT JOIN Object AS Object_Status ON Object_Status.Id = Movement.StatusId 
                   
        LEFT JOIN MovementDate AS MovementDate_Insert
                               ON MovementDate_Insert.MovementId = tmpData.MovementId_Check
                              AND MovementDate_Insert.DescId = zc_MovementDate_Insert()

        LEFT JOIN Object ON Object.Id = tmpData.GoodsId

        LEFT JOIN ObjectLink AS ObjectLink_Goods_NDSKind
                             ON ObjectLink_Goods_NDSKind.ObjectId = Object.Id
                            AND ObjectLink_Goods_NDSKind.DescId = zc_ObjectLink_Goods_NDSKind()
        LEFT JOIN Object AS Object_NDSKind ON Object_NDSKind.Id = ObjectLink_Goods_NDSKind.ChildObjectId

        LEFT JOIN Object AS Object_Unit ON Object_Unit.Id = tmpData.UnitId
        LEFT JOIN ObjectLink AS ObjectLink_Unit_Juridical
                             ON ObjectLink_Unit_Juridical.ObjectId = Object_Unit.Id
                            AND ObjectLink_Unit_Juridical.DescId = zc_ObjectLink_Unit_Juridical()
        LEFT JOIN Object AS Object_MainJuridical ON Object_MainJuridical.Id = ObjectLink_Unit_Juridical.ChildObjectId

        LEFT JOIN ObjectLink AS ObjectLink_Juridical_Retail
                             ON ObjectLink_Juridical_Retail.ObjectId = Object_MainJuridical.Id
                            AND ObjectLink_Juridical_Retail.DescId = zc_ObjectLink_Juridical_Retail()
        LEFT JOIN Object AS Object_Retail ON Object_Retail.Id = ObjectLink_Juridical_Retail.ChildObjectId

        LEFT JOIN Object AS Object_From ON Object_From.Id = tmpData.JuridicalId_Income

        LEFT JOIN MovementString AS MovementString_Comment
                                 ON MovementString_Comment.DescId = zc_MovementString_Comment()
                                AND MovementString_Comment.MovementId = tmpData.MovementId_Check
     ;

END;
$BODY$
  LANGUAGE PLPGSQL VOLATILE;

/*
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.   ������ �.�.  ��������� �.�.
 08.11.16         *
*/

-- ����
--SELECT * FROM gpReport_MovementCheck_Promo (inMakerId:= 2336604  , inStartDate:= '08.11.2016', inEndDate:= '08.11.2016', inSession:= '2')
--SELECT * FROM gpReport_MovementCheck_Promo (inMakerId:= 2336604  , inStartDate:= '08.05.2016', inEndDate:= '08.05.2016', inSession:= '2')
--select * from gpReport_MovementCheck_Promo(inMakerId := 2336600 , inStartDate := ('02.11.2016')::TDateTime , inEndDate := ('02.11.2016')::TDateTime ,  inSession := '3');