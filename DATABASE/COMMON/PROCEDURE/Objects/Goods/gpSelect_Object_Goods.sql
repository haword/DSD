-- Function: gpSelect_Object_Goods()

DROP FUNCTION IF EXISTS gpSelect_Object_Goods (TVarChar);
DROP FUNCTION IF EXISTS gpSelect_Object_Goods (Boolean, TVarChar);

CREATE OR REPLACE FUNCTION gpSelect_Object_Goods(
    IN inShowAll     Boolean,
    IN inSession     TVarChar       -- ������ ������������
)
RETURNS TABLE (Id Integer, Code Integer, Name TVarChar, Name_RUS TVarChar
             , GoodsCode_basis Integer, GoodsName_basis TVarChar
             , GoodsCode_main Integer, GoodsName_main TVarChar
             , GoodsGroupId Integer, GoodsGroupName TVarChar, GoodsGroupNameFull TVarChar
             , GroupStatId Integer, GroupStatName TVarChar
             , GoodsGroupAnalystId Integer, GoodsGroupAnalystName TVarChar
             , AssetId Integer, AssetName TVarChar
             , MeasureId Integer, MeasureName TVarChar
             , TradeMarkName TVarChar
             , GoodsTagName TVarChar
             , GoodsPlatformName TVarChar
             , InfoMoneyCode Integer, InfoMoneyGroupName TVarChar, InfoMoneyDestinationName TVarChar, InfoMoneyName TVarChar, InfoMoneyId Integer
             , BusinessName TVarChar
             , FuelName TVarChar
             , InDate TDateTime
             , PartnerInName TVarChar
             , AmountIn TFloat, PriceIn TFloat
             , Weight TFloat, WeightTare TFloat, CountForWeight TFloat
             , isPartionCount Boolean, isPartionSumm Boolean
             , isCheck_basis Boolean, isCheck_main Boolean
             , isErased Boolean
              )
AS
$BODY$
  DECLARE vbUserId Integer;
  DECLARE vbAccessKeyRight Boolean;
BEGIN
     -- �������� ���� ������������ �� ����� ���������
     -- vbUserId := lpCheckRight (inSession, zc_Enum_Process_Select_Object_Goods());
     vbUserId:= lpGetUserBySession (inSession);
     -- ������������ - ���� �� �����������
     -- vbAccessKeyRight:= NOT zfCalc_AccessKey_GuideAll (vbUserId) AND EXISTS (SELECT AccessKeyId FROM Object_RoleAccessKey_View WHERE UserId = vbUserId);

     -- ���������
     RETURN QUERY
       WITH tmpIsErased AS (SELECT FALSE AS isErased UNION ALL SELECT inShowAll AS isErased WHERE inShowAll = TRUE)

       SELECT Object_Goods.Id             AS Id
            , Object_Goods.ObjectCode     AS Code
            , Object_Goods.ValueData      AS Name
            , COALESCE (ObjectString_Goods_RUS.ValueData, '') :: TVarChar AS Name_RUS

            , Object_Goods_basis.ObjectCode     AS GoodsCode_basis
            , Object_Goods_basis.ValueData      AS GoodsName_basis
            , Object_Goods_main.ObjectCode      AS GoodsCode_main
            , Object_Goods_main.ValueData       AS GoodsName_main

            , Object_GoodsGroup.Id        AS GoodsGroupId
            , Object_GoodsGroup.ValueData AS GoodsGroupName
            , ObjectString_Goods_GoodsGroupFull.ValueData AS GoodsGroupNameFull

            , Object_GoodsGroupStat.Id        AS GroupStatId
            , Object_GoodsGroupStat.ValueData AS GroupStatName

            , Object_GoodsGroupAnalyst.Id        AS GoodsGroupAnalystId
            , Object_GoodsGroupAnalyst.ValueData AS GoodsGroupAnalystName

            , Object_Asset.Id        AS AssetId
            , Object_Asset.ValueData AS AssetName

            , Object_Measure.Id               AS MeasureId
            , Object_Measure.ValueData        AS MeasureName

            , Object_TradeMark.ValueData      AS TradeMarkName
            , Object_GoodsTag.ValueData       AS GoodsTagName
            , Object_GoodsPlatform.ValueData  AS GoodsPlatformName

            , Object_InfoMoney_View.InfoMoneyCode
            , Object_InfoMoney_View.InfoMoneyGroupName
            , Object_InfoMoney_View.InfoMoneyDestinationName
            , Object_InfoMoney_View.InfoMoneyName
            , Object_InfoMoney_View.InfoMoneyId

            , Object_Business.ValueData   AS BusinessName
            , Object_Fuel.ValueData       AS FuelName

            , ObjectDate_In.ValueData       :: TDateTime AS InDate
            , Object_PartnerIn.ValueData    :: TVarChar  AS PartnerInName
            , ObjectFloat_Goods_AmountIn.ValueData       AS AmountIn
            , ObjectFloat_Goods_PriceIn.ValueData        AS PriceIn

            , ObjectFloat_Weight.ValueData     AS Weight
            , ObjectFloat_WeightTare.ValueData AS WeightTare
            , ObjectFloat_CountForWeight.ValueData ::TFloat AS CountForWeight
            , COALESCE (ObjectBoolean_PartionCount.ValueData, FALSE)   :: Boolean AS isPartionCount
            , COALESCE (ObjectBoolean_PartionSumm.ValueData, TRUE)     :: Boolean AS isPartionSumm

            , CASE WHEN Object_Goods_basis.Id > 0 AND Object_Goods_basis.Id <> COALESCE (Object_Goods_main.Id, 0) THEN TRUE ELSE FALSE END :: Boolean AS isCheck_basis
            , CASE WHEN Object_Goods_main.Id  > 0 AND Object_Goods_main. Id <> COALESCE (Object_Goods.Id,      0) THEN TRUE ELSE FALSE END :: Boolean AS isCheck_main

            , Object_Goods.isErased       AS isErased

       FROM (/*SELECT Object_Goods.*
             FROM (SELECT AccessKeyId FROM Object_RoleAccessKey_View WHERE UserId = vbUserId GROUP BY AccessKeyId) AS tmpRoleAccessKey
                  JOIN Object AS Object_Goods ON Object_Goods.AccessKeyId = tmpRoleAccessKey.AccessKeyId AND Object_Goods.DescId = zc_Object_Goods()
             WHERE vbAccessKeyRight = TRUE
            UNION ALL*/
             SELECT Object_Goods.*
             FROM Object AS Object_Goods
	         INNER JOIN tmpIsErased on tmpIsErased.isErased= Object_Goods.isErased
             WHERE Object_Goods.DescId = zc_Object_Goods()
             -- AND vbAccessKeyRight = FALSE
            ) AS Object_Goods
             LEFT JOIN ObjectLink AS ObjectLink_Goods_GoodsGroup
                                  ON ObjectLink_Goods_GoodsGroup.ObjectId = Object_Goods.Id
                                 AND ObjectLink_Goods_GoodsGroup.DescId = zc_ObjectLink_Goods_GoodsGroup()
             LEFT JOIN Object AS Object_GoodsGroup ON Object_GoodsGroup.Id = ObjectLink_Goods_GoodsGroup.ChildObjectId

             LEFT JOIN ObjectLink AS ObjectLink_Goods_GoodsBasis
                                  ON ObjectLink_Goods_GoodsBasis.ObjectId = Object_Goods.Id
                                 AND ObjectLink_Goods_GoodsBasis.DescId   = zc_ObjectLink_Goods_GoodsBasis()
             LEFT JOIN Object AS Object_Goods_basis ON Object_Goods_basis.Id = ObjectLink_Goods_GoodsBasis.ChildObjectId
             LEFT JOIN ObjectLink AS ObjectLink_Goods_GoodsMain
                                  ON ObjectLink_Goods_GoodsMain.ObjectId = Object_Goods.Id
                                 AND ObjectLink_Goods_GoodsMain.DescId   = zc_ObjectLink_Goods_GoodsMain()
             LEFT JOIN Object AS Object_Goods_main ON Object_Goods_main.Id = ObjectLink_Goods_GoodsMain.ChildObjectId

             LEFT JOIN ObjectLink AS ObjectLink_Goods_GoodsGroupStat
                                  ON ObjectLink_Goods_GoodsGroupStat.ObjectId = Object_Goods.Id
                                 AND ObjectLink_Goods_GoodsGroupStat.DescId = zc_ObjectLink_Goods_GoodsGroupStat()
             LEFT JOIN Object AS Object_GoodsGroupStat ON Object_GoodsGroupStat.Id = ObjectLink_Goods_GoodsGroupStat.ChildObjectId

             LEFT JOIN ObjectLink AS ObjectLink_Goods_GoodsGroupAnalyst
                                  ON ObjectLink_Goods_GoodsGroupAnalyst.ObjectId = Object_Goods.Id
                                 AND ObjectLink_Goods_GoodsGroupAnalyst.DescId = zc_ObjectLink_Goods_GoodsGroupAnalyst()
             LEFT JOIN Object AS Object_GoodsGroupAnalyst ON Object_GoodsGroupAnalyst.Id = ObjectLink_Goods_GoodsGroupAnalyst.ChildObjectId

             LEFT JOIN ObjectLink AS ObjectLink_Goods_GoodsTag
                                  ON ObjectLink_Goods_GoodsTag.ObjectId = Object_Goods.Id
                                 AND ObjectLink_Goods_GoodsTag.DescId = zc_ObjectLink_Goods_GoodsTag()
             LEFT JOIN Object AS Object_GoodsTag ON Object_GoodsTag.Id = ObjectLink_Goods_GoodsTag.ChildObjectId

             LEFT JOIN ObjectString AS ObjectString_Goods_GoodsGroupFull
                                    ON ObjectString_Goods_GoodsGroupFull.ObjectId = Object_Goods.Id
                                   AND ObjectString_Goods_GoodsGroupFull.DescId = zc_ObjectString_Goods_GroupNameFull()

             LEFT JOIN ObjectString AS ObjectString_Goods_RUS
                                    ON ObjectString_Goods_RUS.ObjectId = Object_Goods.Id
                                   AND ObjectString_Goods_RUS.DescId = zc_ObjectString_Goods_RUS()

             LEFT JOIN ObjectLink AS ObjectLink_Goods_Measure
                                  ON ObjectLink_Goods_Measure.ObjectId = Object_Goods.Id
                                 AND ObjectLink_Goods_Measure.DescId = zc_ObjectLink_Goods_Measure()
             LEFT JOIN Object AS Object_Measure ON Object_Measure.Id = ObjectLink_Goods_Measure.ChildObjectId

             LEFT JOIN ObjectLink AS ObjectLink_Goods_TradeMark
                                  ON ObjectLink_Goods_TradeMark.ObjectId = Object_Goods.Id
                                 AND ObjectLink_Goods_TradeMark.DescId = zc_ObjectLink_Goods_TradeMark()
             LEFT JOIN Object AS Object_TradeMark ON Object_TradeMark.Id = ObjectLink_Goods_TradeMark.ChildObjectId

             LEFT JOIN ObjectLink AS ObjectLink_Goods_GoodsPlatform
                                  ON ObjectLink_Goods_GoodsPlatform.ObjectId = Object_Goods.Id
                                 AND ObjectLink_Goods_GoodsPlatform.DescId = zc_ObjectLink_Goods_GoodsPlatform()
             LEFT JOIN Object AS Object_GoodsPlatform ON Object_GoodsPlatform.Id = ObjectLink_Goods_GoodsPlatform.ChildObjectId

             LEFT JOIN ObjectLink AS ObjectLink_Goods_Asset
                                  ON ObjectLink_Goods_Asset.ObjectId = Object_Goods.Id
                                 AND ObjectLink_Goods_Asset.DescId = zc_ObjectLink_Goods_Asset()
             LEFT JOIN Object AS Object_Asset ON Object_Asset.Id = ObjectLink_Goods_Asset.ChildObjectId

             LEFT JOIN ObjectFloat AS ObjectFloat_Weight
                                   ON ObjectFloat_Weight.ObjectId = Object_Goods.Id
                                  AND ObjectFloat_Weight.DescId   = zc_ObjectFloat_Goods_Weight()
             LEFT JOIN ObjectFloat AS ObjectFloat_WeightTare
                                   ON ObjectFloat_WeightTare.ObjectId = Object_Goods.Id
                                  AND ObjectFloat_WeightTare.DescId   = zc_ObjectFloat_Goods_WeightTare()
             LEFT JOIN ObjectFloat AS ObjectFloat_CountForWeight
                                   ON ObjectFloat_CountForWeight.ObjectId = Object_Goods.Id 
                                  AND ObjectFloat_CountForWeight.DescId = zc_ObjectFloat_Goods_CountForWeight()

             LEFT JOIN ObjectBoolean AS ObjectBoolean_PartionCount
                                     ON ObjectBoolean_PartionCount.ObjectId = Object_Goods.Id
                                    AND ObjectBoolean_PartionCount.DescId = zc_ObjectBoolean_Goods_PartionCount()
             LEFT JOIN ObjectBoolean AS ObjectBoolean_PartionSumm
                                     ON ObjectBoolean_PartionSumm.ObjectId = Object_Goods.Id
                                    AND ObjectBoolean_PartionSumm.DescId = zc_ObjectBoolean_Goods_PartionSumm()

             LEFT JOIN ObjectDate AS ObjectDate_In
                                  ON ObjectDate_In.ObjectId = Object_Goods.Id
                                 AND ObjectDate_In.DescId = zc_ObjectDate_Goods_In()
             LEFT JOIN ObjectFloat AS ObjectFloat_Goods_AmountIn
                                   ON ObjectFloat_Goods_AmountIn.ObjectId = Object_Goods.Id
                                  AND ObjectFloat_Goods_AmountIn.DescId   = zc_ObjectFloat_Goods_AmountIn()
             LEFT JOIN ObjectFloat AS ObjectFloat_Goods_PriceIn
                                   ON ObjectFloat_Goods_PriceIn.ObjectId = Object_Goods.Id
                                  AND ObjectFloat_Goods_PriceIn.DescId   = zc_ObjectFloat_Goods_PriceIn()

             LEFT JOIN ObjectLink AS ObjectLink_Goods_PartnerIn
                                  ON ObjectLink_Goods_PartnerIn.ObjectId = Object_Goods.Id
                                 AND ObjectLink_Goods_PartnerIn.DescId = zc_ObjectLink_Goods_PartnerIn()
             LEFT JOIN Object AS Object_PartnerIn ON Object_PartnerIn.Id = ObjectLink_Goods_PartnerIn.ChildObjectId

             LEFT JOIN ObjectLink AS ObjectLink_Goods_InfoMoney
                                  ON ObjectLink_Goods_InfoMoney.ObjectId = Object_Goods.Id
                                 AND ObjectLink_Goods_InfoMoney.DescId = zc_ObjectLink_Goods_InfoMoney()
             LEFT JOIN Object_InfoMoney_View ON Object_InfoMoney_View.InfoMoneyId = ObjectLink_Goods_InfoMoney.ChildObjectId

             LEFT JOIN ObjectLink AS ObjectLink_Goods_Business
                    ON ObjectLink_Goods_Business.ObjectId = Object_Goods.Id
                   AND ObjectLink_Goods_Business.DescId = zc_ObjectLink_Goods_Business()
             LEFT JOIN Object AS Object_Business ON Object_Business.Id = ObjectLink_Goods_Business.ChildObjectId

             LEFT JOIN ObjectLink AS ObjectLink_Goods_Fuel
                                  ON ObjectLink_Goods_Fuel.ObjectId = Object_Goods.Id
                                 AND ObjectLink_Goods_Fuel.DescId = zc_ObjectLink_Goods_Fuel()
             LEFT JOIN Object AS Object_Fuel ON Object_Fuel.Id = ObjectLink_Goods_Fuel.ChildObjectId

       WHERE Object_Goods.DescId = zc_Object_Goods()

      UNION ALL
       SELECT 0                   :: Integer  AS Id
            , 0                   :: Integer  AS Code
            -- , '�������� ��������' :: TVarChar AS Name
            , '������� ��������'  :: TVarChar AS Name
            , ''                  :: TVarChar AS Name_RUS

            , 0                   :: Integer  AS GoodsCode_basis
            , ''                  :: TVarChar AS GoodsName_basis
            , 0                   :: Integer  AS GoodsCode_main
            , ''                  :: TVarChar AS GoodsName_main

            , 0                   :: Integer  AS GoodsGroupId
            , ''                  :: TVarChar AS GoodsGroupName
            , ''                  :: TVarChar AS GoodsGroupNameFull

            , 0                   :: Integer  AS GroupStatId
            , ''                  :: TVarChar AS GroupStatName

            , 0                   :: Integer  AS GoodsGroupAnalystId
            , ''                  :: TVarChar AS GoodsGroupAnalystName

            , 0                   :: Integer  AS AssetId
            , ''                  :: TVarChar AS AssetName

            , 0                   :: Integer  AS MeasureId
            , ''                  :: TVarChar AS MeasureName

            , ''                  :: TVarChar AS TradeMarkName
            , ''                  :: TVarChar AS GoodsTagName
            , ''                  :: TVarChar AS GoodsPlatformName

            , 0                   :: Integer  AS InfoMoneyCode
            , ''                  :: TVarChar AS InfoMoneyGroupName
            , ''                  :: TVarChar AS InfoMoneyDestinationName
            , ''                  :: TVarChar AS InfoMoneyName
            , 0                   :: Integer  AS InfoMoneyId

            , ''                  :: TVarChar AS BusinessName

            , ''                  :: TVarChar AS FuelName

            , NULL                ::TDateTime AS InDate
            , ''                  :: TVarChar AS PartnerInName
            , 0                   :: TFloat   AS AmountIn
            , 0                   :: TFloat   AS PriceIn

            , 0                   :: TFloat   AS Weight
            , 0                   :: TFloat   AS WeightTare
            , 0                   :: TFloat   AS CountForWeight

            , FALSE                           AS isPartionCount
            , FALSE                           AS isPartionSumm
            , FALSE                           AS isCheck_basis
            , FALSE                           AS isCheck_main
            , FALSE                           AS isErased
      ;

END;
$BODY$
  LANGUAGE plpgsql VOLATILE;
ALTER FUNCTION gpSelect_Object_Goods (Boolean, TVarChar) OWNER TO postgres;

/*-------------------------------------------------------------------------------*/
/*
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.   ������ �.
 23.10.19         * CountForWeight
 09.10.19         * add WeightTare
 21.03.19         *
 12.12.18         *
 18.10.18         *
 15.04.15         * add GoodsPlatform
 23.02.15         * add inShowAll
 24.11.14         * add GoodsGroupAnalyst
 13.09.14                                        * add zc_ObjectLink_Goods_GoodsTag()
 04.09.14         * add zc_ObjectLink_Goods_GoodsGroupStat()
 13.01.14                                        * add GoodsGroupNameFull
 14.12.13                                        * add inAccessKeyId
 07.12.13                                        * rename UserRole_View -> ObjectLink_UserRole_View
 09.11.13                                        * add tmpUserTransport
 29.10.13                                        * add Object_InfoMoney_View
 02.10.13                                        * add GoodsGroupId
 29.09.13                                        * add zc_ObjectLink_Goods_Fuel
 01.09.13                                        * add zc_ObjectLink_Goods_Business
 12.07.13                                        * add zc_ObjectBoolean_Goods_Partion...
 04.07.13          * + TradeMark
 21.06.13          *
 11.06.13          *
*/

-- ����
-- SELECT * FROM gpSelect_Object_Goods (FALSE, inSession := zfCalc_UserAdmin())
