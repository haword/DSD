INSERT INTO ObjectBooleanDesc (DescId, Code, ItemName)
  SELECT zc_Object_Juridical(), 'zc_ObjectBoolean_Juridical_isCorporate', '������� ���� �� ������������� ��� ����������� ����' WHERE NOT EXISTS (SELECT * FROM ObjectBooleanDesc WHERE Code = 'zc_ObjectBoolean_Juridical_isCorporate');  
INSERT INTO ObjectBooleanDesc (DescId, Code, ItemName)
  SELECT zc_Object_ProfitLoss(), 'zc_ObjectBoolean_ProfitLoss_onComplete', '������� ������ ��� ����������' WHERE NOT EXISTS (SELECT * FROM ObjectBooleanDesc WHERE Code = 'zc_ObjectBoolean_ProfitLoss_onComplete');  
INSERT INTO ObjectBooleanDesc (DescId, Code, ItemName)
  SELECT zc_Object_Account(), 'zc_ObjectBoolean_Account_onComplete', '������� ������ ��� ����������' WHERE NOT EXISTS (SELECT * FROM ObjectBooleanDesc WHERE Code = 'zc_ObjectBoolean_Account_onComplete');  
INSERT INTO ObjectBooleanDesc (DescId, Code, ItemName)
  SELECT NULL, 'zc_ObjectBoolean_isLeaf', '������� ���� �� ������� � ������' WHERE NOT EXISTS (SELECT * FROM ObjectBooleanDesc WHERE Code = 'zc_ObjectBoolean_isLeaf');  

/*-------------------------------------------------------------------------------
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.
 28.06.13                                        * ����� �����
 08.07.13                         *  zc_ObjectBoolean_isLeaf
*/
