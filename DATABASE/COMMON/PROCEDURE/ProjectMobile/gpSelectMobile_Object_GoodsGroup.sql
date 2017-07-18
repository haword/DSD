-- Function: gpSelectMobile_Object_GoodsGroup (TDateTime, TVarChar)

DROP FUNCTION IF EXISTS gpSelectMobile_Object_GoodsGroup (TDateTime, TVarChar);

CREATE OR REPLACE FUNCTION gpSelectMobile_Object_GoodsGroup (
    IN inSyncDateIn TDateTime, -- ����/����� ��������� ������������� - ����� "�������" ����������� �������� ���������� - ���������� �����������, ����, �����, �����, ������� � �.�
    IN inSession    TVarChar   -- ������ ������������
)
RETURNS TABLE (Id         Integer
             , ObjectCode Integer  -- ���
             , ValueData  TVarChar -- ��������
             , isErased   Boolean  -- ��������� �� �������
             , isSync     Boolean  -- ���������������� (��/���)
              )
AS 
$BODY$
   DECLARE vbUserId Integer;
   DECLARE vbPersonalId Integer;
BEGIN
      -- �������� ���� ������������ �� ����� ���������
      -- vbUserId:= lpCheckRight (inSession, zc_Enum_Process_...());
      vbUserId:= lpGetUserBySession (inSession);

      vbPersonalId:= (SELECT PersonalId FROM gpGetMobile_Object_Const (inSession));

      -- ���������
      IF vbPersonalId IS NOT NULL
      THEN
           CREATE TEMP TABLE tmpPartner ON COMMIT DROP
           AS (SELECT OP.Id AS PartnerId FROM lfSelectMobile_Object_Partner (inIsErased:= FALSE, inSession:= inSession) AS OP);

           CREATE TEMP TABLE tmpGoodsGroup ON COMMIT DROP
           AS (SELECT ObjectLink_Goods_GoodsGroup.ChildObjectId AS GoodsGroupId
                    , ObjectString_Goods_GroupNameFull.ValueData AS GoodsGroupNameFull
                    , COUNT(ObjectLink_Goods_GoodsGroup.ChildObjectId) AS GoodsGroupCount
               FROM (SELECT ObjectLink_GoodsByGoodsKind_Goods.ChildObjectId AS GoodsId
                     FROM Object AS Object_GoodsByGoodsKind
                          JOIN ObjectBoolean AS ObjectBoolean_GoodsByGoodsKind_Order
                                             ON ObjectBoolean_GoodsByGoodsKind_Order.ObjectId = Object_GoodsByGoodsKind.Id
                                            AND ObjectBoolean_GoodsByGoodsKind_Order.DescId = zc_ObjectBoolean_GoodsByGoodsKind_Order() 
                                            AND ObjectBoolean_GoodsByGoodsKind_Order.ValueData
                          JOIN ObjectLink AS ObjectLink_GoodsByGoodsKind_Goods
                                          ON ObjectLink_GoodsByGoodsKind_Goods.ObjectId = Object_GoodsByGoodsKind.Id
                                         AND ObjectLink_GoodsByGoodsKind_Goods.DescId = zc_ObjectLink_GoodsByGoodsKind_Goods()
                                         AND ObjectLink_GoodsByGoodsKind_Goods.ChildObjectId IS NOT NULL
                     WHERE Object_GoodsByGoodsKind.DescId = zc_Object_GoodsByGoodsKind()
                     UNION
                     SELECT ObjectLink_GoodsListSale_Goods.ChildObjectId AS GoodsId
                     FROM Object AS Object_GoodsListSale
                          JOIN ObjectLink AS ObjectLink_GoodsListSale_Goods 
                                          ON ObjectLink_GoodsListSale_Goods.ObjectId = Object_GoodsListSale.Id
                                         AND ObjectLink_GoodsListSale_Goods.DescId = zc_ObjectLink_GoodsListSale_Goods()
                                         AND ObjectLink_GoodsListSale_Goods.ChildObjectId IS NOT NULL
                          JOIN ObjectLink AS ObjectLink_GoodsListSale_Partner
                                          ON ObjectLink_GoodsListSale_Partner.ObjectId = Object_GoodsListSale.Id
                                         AND ObjectLink_GoodsListSale_Partner.DescId = zc_ObjectLink_GoodsListSale_Partner()
                                         AND ObjectLink_GoodsListSale_Partner.ChildObjectId IS NOT NULL
                          JOIN tmpPartner ON tmpPartner.PartnerId = ObjectLink_GoodsListSale_Partner.ChildObjectId
                     WHERE Object_GoodsListSale.DescId = zc_Object_GoodsListSale()
                    ) AS GG
                    JOIN ObjectLink AS ObjectLink_Goods_GoodsGroup 
                                    ON ObjectLink_Goods_GoodsGroup.ObjectId = GG.GoodsId
                                   AND ObjectLink_Goods_GoodsGroup.DescId = zc_ObjectLink_Goods_GoodsGroup() 
                                   AND ObjectLink_Goods_GoodsGroup.ChildObjectId IS NOT NULL
                    JOIN ObjectString AS ObjectString_Goods_GroupNameFull
                                      ON ObjectString_Goods_GroupNameFull.ObjectId = GG.GoodsId
                                     AND ObjectString_Goods_GroupNameFull.DescId = zc_ObjectString_Goods_GroupNameFull() 
               GROUP BY ObjectLink_Goods_GoodsGroup.ChildObjectId
                      , ObjectString_Goods_GroupNameFull.ValueData
              );
           
           IF inSyncDateIn > zc_DateStart()
           THEN
                RETURN QUERY
                  WITH tmpProtocol AS (SELECT ObjectProtocol.ObjectId AS GoodsGroupId, MAX(ObjectProtocol.OperDate) AS MaxOperDate
                                       FROM ObjectProtocol
                                            JOIN Object AS Object_GoodsGroup
                                                        ON Object_GoodsGroup.Id = ObjectProtocol.ObjectId
                                                       AND Object_GoodsGroup.DescId = zc_Object_GoodsGroup() 
                                       WHERE ObjectProtocol.OperDate > inSyncDateIn
                                       GROUP BY ObjectProtocol.ObjectId
                                      )
                  SELECT Object_GoodsGroup.Id
                       , Object_GoodsGroup.ObjectCode
                       , COALESCE (tmpGoodsGroup.GoodsGroupNameFull, CAST ('' AS TVarChar)) AS ValueData
                       , Object_GoodsGroup.isErased
                       , (tmpGoodsGroup.GoodsGroupId IS NOT NULL) AS isSync
                  FROM Object AS Object_GoodsGroup
                       JOIN tmpProtocol ON tmpProtocol.GoodsGroupId = Object_GoodsGroup.Id
                       LEFT JOIN tmpGoodsGroup ON tmpGoodsGroup.GoodsGroupId = Object_GoodsGroup.Id
                  WHERE Object_GoodsGroup.DescId = zc_Object_GoodsGroup();
           ELSE
                RETURN QUERY
                  SELECT Object_GoodsGroup.Id
                       , Object_GoodsGroup.ObjectCode
                       , tmpGoodsGroup.GoodsGroupNameFull AS ValueData
                       , Object_GoodsGroup.isErased
                       , CAST(true AS Boolean) AS isSync
                  FROM Object AS Object_GoodsGroup
                       JOIN tmpGoodsGroup ON tmpGoodsGroup.GoodsGroupId = Object_GoodsGroup.Id
                  WHERE Object_GoodsGroup.DescId = zc_Object_GoodsGroup();
           END IF;
      END IF;

END; 
$BODY$
  LANGUAGE plpgsql VOLATILE;

/*-------------------------------------------------------------------------------
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.   �������� �.�.
 17.02.17                                                         *
*/

-- ����
-- SELECT * FROM gpSelectMobile_Object_GoodsGroup(inSyncDateIn := zc_DateStart(), inSession := zfCalc_UserAdmin())
