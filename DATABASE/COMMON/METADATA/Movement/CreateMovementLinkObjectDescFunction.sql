--------------------------- !!!!!!!!!!!!!!!!!!!
--------------------------- !!! ����� ����� !!!
--------------------------- !!!!!!!!!!!!!!!!!!!

CREATE OR REPLACE FUNCTION zc_MovementLinkObject_From() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT Id FROM MovementLinkObjectDesc WHERE Code = 'zc_MovementLinkObject_From'); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
INSERT INTO MovementLinkObjectDesc (Code, ItemName)
  SELECT 'zc_MovementLinkObject_From', '�� ���� (� ���������)' WHERE NOT EXISTS (SELECT * FROM MovementLinkObjectDesc WHERE Code = 'zc_MovementLinkObject_From');

CREATE OR REPLACE FUNCTION zc_MovementLinkObject_To() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT Id FROM MovementLinkObjectDesc WHERE Code = 'zc_MovementLinkObject_To'); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
INSERT INTO MovementLinkObjectDesc (Code, ItemName)
  SELECT 'zc_MovementLinkObject_To', '���� (� ���������)' WHERE NOT EXISTS (SELECT * FROM MovementLinkObjectDesc WHERE Code = 'zc_MovementLinkObject_To');

CREATE OR REPLACE FUNCTION zc_MovementLinkObject_Partner() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT Id FROM MovementLinkObjectDesc WHERE Code = 'zc_MovementLinkObject_Partner'); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
INSERT INTO MovementLinkObjectDesc (Code, ItemName)
  SELECT 'zc_MovementLinkObject_Partner', '����������' WHERE NOT EXISTS (SELECT * FROM MovementLinkObjectDesc WHERE Code = 'zc_MovementLinkObject_Partner');

-- CREATE OR REPLACE FUNCTION zc_MovementLinkObject_DocumentKind() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT Id FROM MovementLinkObjectDesc WHERE Code = 'zc_MovementLinkObject_DocumentKind'); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
-- INSERT INTO MovementLinkObjectDesc (Code, ItemName)
--  SELECT 'zc_MovementLinkObject_DocumentKind', '���� ������������� ��������' WHERE NOT EXISTS (SELECT * FROM MovementLinkObjectDesc WHERE Code = 'zc_MovementLinkObject_DocumentKind');

CREATE OR REPLACE FUNCTION zc_MovementLinkObject_PaidKind() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT Id FROM MovementLinkObjectDesc WHERE Code = 'zc_MovementLinkObject_PaidKind'); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
INSERT INTO MovementLinkObjectDesc (Code, ItemName)
  SELECT 'zc_MovementLinkObject_PaidKind', '���� ���� ������' WHERE NOT EXISTS (SELECT * FROM MovementLinkObjectDesc WHERE Code = 'zc_MovementLinkObject_PaidKind');

CREATE OR REPLACE FUNCTION zc_MovementLinkObject_Contract() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT Id FROM MovementLinkObjectDesc WHERE Code = 'zc_MovementLinkObject_Contract'); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
INSERT INTO MovementLinkObjectDesc (Code, ItemName)
  SELECT 'zc_MovementLinkObject_Contract', '��������' WHERE NOT EXISTS (SELECT * FROM MovementLinkObjectDesc WHERE Code = 'zc_MovementLinkObject_Contract');

CREATE OR REPLACE FUNCTION zc_MovementLinkObject_Car() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT Id FROM MovementLinkObjectDesc WHERE Code = 'zc_MovementLinkObject_Car'); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
INSERT INTO MovementLinkObjectDesc (Code, ItemName)
  SELECT 'zc_MovementLinkObject_Car', '����������' WHERE NOT EXISTS (SELECT * FROM MovementLinkObjectDesc WHERE Code = 'zc_MovementLinkObject_Car');

CREATE OR REPLACE FUNCTION zc_MovementLinkObject_CarTrailer() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT Id FROM MovementLinkObjectDesc WHERE Code = 'zc_MovementLinkObject_CarTrailer'); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
INSERT INTO MovementLinkObjectDesc (Code, ItemName)
  SELECT 'zc_MovementLinkObject_CarTrailer', '���������� (������)' WHERE NOT EXISTS (SELECT * FROM MovementLinkObjectDesc WHERE Code = 'zc_MovementLinkObject_CarTrailer');

CREATE OR REPLACE FUNCTION zc_MovementLinkObject_PersonalDriver() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT Id FROM MovementLinkObjectDesc WHERE Code = 'zc_MovementLinkObject_PersonalDriver'); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
INSERT INTO MovementLinkObjectDesc (Code, ItemName)
  SELECT 'zc_MovementLinkObject_PersonalDriver', '��������� (��������)' WHERE NOT EXISTS (SELECT * FROM MovementLinkObjectDesc WHERE Code = 'zc_MovementLinkObject_PersonalDriver');

CREATE OR REPLACE FUNCTION zc_MovementLinkObject_PersonalDriverMore() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT Id FROM MovementLinkObjectDesc WHERE Code = 'zc_MovementLinkObject_PersonalDriverMore'); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
INSERT INTO MovementLinkObjectDesc (Code, ItemName)
  SELECT 'zc_MovementLinkObject_PersonalDriverMore', '��������� (��������)' WHERE NOT EXISTS (SELECT * FROM MovementLinkObjectDesc WHERE Code = 'zc_MovementLinkObject_PersonalDriverMore');

CREATE OR REPLACE FUNCTION zc_MovementLinkObject_PersonalPacker() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT Id FROM MovementLinkObjectDesc WHERE Code = 'zc_MovementLinkObject_PersonalPacker'); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
INSERT INTO MovementLinkObjectDesc (Code, ItemName)
  SELECT 'zc_MovementLinkObject_PersonalPacker', '��������� (������������)' WHERE NOT EXISTS (SELECT * FROM MovementLinkObjectDesc WHERE Code = 'zc_MovementLinkObject_PersonalPacker');

CREATE OR REPLACE FUNCTION zc_MovementLinkObject_Route() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT Id FROM MovementLinkObjectDesc WHERE Code = 'zc_MovementLinkObject_Route'); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
INSERT INTO MovementLinkObjectDesc (Code, ItemName)
  SELECT 'zc_MovementLinkObject_Route', '�������' WHERE NOT EXISTS (SELECT * FROM MovementLinkObjectDesc WHERE Code = 'zc_MovementLinkObject_Route');

CREATE OR REPLACE FUNCTION zc_MovementLinkObject_RouteSorting() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT Id FROM MovementLinkObjectDesc WHERE Code = 'zc_MovementLinkObject_RouteSorting'); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
INSERT INTO MovementLinkObjectDesc (Code, ItemName)
  SELECT 'zc_MovementLinkObject_RouteSorting', '���������� ���������' WHERE NOT EXISTS (SELECT * FROM MovementLinkObjectDesc WHERE Code = 'zc_MovementLinkObject_RouteSorting');

CREATE OR REPLACE FUNCTION zc_MovementLinkObject_Personal() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT Id FROM MovementLinkObjectDesc WHERE Code = 'zc_MovementLinkObject_Personal'); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
INSERT INTO MovementLinkObjectDesc (Code, ItemName)
  SELECT 'zc_MovementLinkObject_Personal', '��������� (����������)' WHERE NOT EXISTS (SELECT * FROM MovementLinkObjectDesc WHERE Code = 'zc_MovementLinkObject_Personal');

CREATE OR REPLACE FUNCTION zc_MovementLinkObject_Unit() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT Id FROM MovementLinkObjectDesc WHERE Code = 'zc_MovementLinkObject_Unit'); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
INSERT INTO MovementLinkObjectDesc (Code, ItemName)
  SELECT 'zc_MovementLinkObject_Unit', '�������������' WHERE NOT EXISTS (SELECT * FROM MovementLinkObjectDesc WHERE Code = 'zc_MovementLinkObject_Unit');

CREATE OR REPLACE FUNCTION zc_MovementLinkObject_UnitForwarding() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT Id FROM MovementLinkObjectDesc WHERE Code = 'zc_MovementLinkObject_UnitForwarding'); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
INSERT INTO MovementLinkObjectDesc (Code, ItemName)
  SELECT 'zc_MovementLinkObject_UnitForwarding', '������������� (����� ��������)' WHERE NOT EXISTS (SELECT * FROM MovementLinkObjectDesc WHERE Code = 'zc_MovementLinkObject_UnitForwarding');

CREATE OR REPLACE FUNCTION zc_MovementLinkObject_InfoMoney() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT Id FROM MovementLinkObjectDesc WHERE Code = 'zc_MovementLinkObject_InfoMoney'); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
INSERT INTO MovementLinkObjectDesc (Code, ItemName)
  SELECT 'zc_MovementLinkObject_InfoMoney', '�������������� ������' WHERE NOT EXISTS (SELECT * FROM MovementLinkObjectDesc WHERE Code = 'zc_MovementLinkObject_InfoMoney');

CREATE OR REPLACE FUNCTION zc_MovementLinkObject_Position() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT Id FROM MovementLinkObjectDesc WHERE Code = 'zc_MovementLinkObject_Position'); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
INSERT INTO MovementLinkObjectDesc (Code, ItemName)
  SELECT 'zc_MovementLinkObject_Position', '���������' WHERE NOT EXISTS (SELECT * FROM MovementLinkObjectDesc WHERE Code = 'zc_MovementLinkObject_Position');

CREATE OR REPLACE FUNCTION zc_MovementLinkObject_PositionLevel() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT Id FROM MovementLinkObjectDesc WHERE Code = 'zc_MovementLinkObject_PositionLevel'); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
INSERT INTO MovementLinkObjectDesc (Code, ItemName)
  SELECT 'zc_MovementLinkObject_PositionLevel', '������' WHERE NOT EXISTS (SELECT * FROM MovementLinkObjectDesc WHERE Code = 'zc_MovementLinkObject_PositionLevel');

CREATE OR REPLACE FUNCTION zc_MovementLinkObject_BankAccount() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT Id FROM MovementLinkObjectDesc WHERE Code = 'zc_MovementLinkObject_BankAccount'); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
INSERT INTO MovementLinkObjectDesc (Code, ItemName)
  SELECT 'zc_MovementLinkObject_BankAccount', '��������� ����' WHERE NOT EXISTS (SELECT * FROM MovementLinkObjectDesc WHERE Code = 'zc_MovementLinkObject_BankAccount');

CREATE OR REPLACE FUNCTION zc_MovementLinkObject_Juridical() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT Id FROM MovementLinkObjectDesc WHERE Code = 'zc_MovementLinkObject_Juridical'); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
INSERT INTO MovementLinkObjectDesc (Code, ItemName)
  SELECT 'zc_MovementLinkObject_Juridical', '��. ����' WHERE NOT EXISTS (SELECT * FROM MovementLinkObjectDesc WHERE Code = 'zc_MovementLinkObject_Juridical');

CREATE OR REPLACE FUNCTION zc_MovementLinkObject_JuridicalBasis() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT Id FROM MovementLinkObjectDesc WHERE Code = 'zc_MovementLinkObject_JuridicalBasis'); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
INSERT INTO MovementLinkObjectDesc (Code, ItemName)
  SELECT 'zc_MovementLinkObject_JuridicalBasis', '������� ��. ����' WHERE NOT EXISTS (SELECT * FROM MovementLinkObjectDesc WHERE Code = 'zc_MovementLinkObject_JuridicalBasis');

CREATE OR REPLACE FUNCTION zc_MovementLinkObject_Business() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT Id FROM MovementLinkObjectDesc WHERE Code = 'zc_MovementLinkObject_Business'); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
INSERT INTO MovementLinkObjectDesc (Code, ItemName)
  SELECT 'zc_MovementLinkObject_Business', '������' WHERE NOT EXISTS (SELECT * FROM MovementLinkObjectDesc WHERE Code = 'zc_MovementLinkObject_Business');

CREATE OR REPLACE FUNCTION zc_MovementLinkObject_Currency() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT Id FROM MovementLinkObjectDesc WHERE Code = 'zc_MovementLinkObject_Currency'); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
INSERT INTO MovementLinkObjectDesc (Code, ItemName)
  SELECT 'zc_MovementLinkObject_Currency', '������' WHERE NOT EXISTS (SELECT * FROM MovementLinkObjectDesc WHERE Code = 'zc_MovementLinkObject_Currency');

CREATE OR REPLACE FUNCTION zc_MovementLinkObject_ContractConditionKind() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT Id FROM MovementLinkObjectDesc WHERE Code = 'zc_MovementLinkObject_ContractConditionKind'); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
INSERT INTO MovementLinkObjectDesc (Code, ItemName)
  SELECT 'zc_MovementLinkObject_ContractConditionKind', '������' WHERE NOT EXISTS (SELECT * FROM MovementLinkObjectDesc WHERE Code = 'zc_MovementLinkObject_ContractConditionKind');

CREATE OR REPLACE FUNCTION zc_MovementLinkObject_Cash() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT Id FROM MovementLinkObjectDesc WHERE Code = 'zc_MovementLinkObject_Cash'); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
INSERT INTO MovementLinkObjectDesc (Code, ItemName)
  SELECT 'zc_MovementLinkObject_Cash', '�����' WHERE NOT EXISTS (SELECT * FROM MovementLinkObjectDesc WHERE Code = 'zc_MovementLinkObject_Cash');

CREATE OR REPLACE FUNCTION zc_MovementLinkObject_Object() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT Id FROM MovementLinkObjectDesc WHERE Code = 'zc_MovementLinkObject_Object'); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
INSERT INTO MovementLinkObjectDesc (Code, ItemName)
  SELECT 'zc_MovementLinkObject_Object', '������' WHERE NOT EXISTS (SELECT * FROM MovementLinkObjectDesc WHERE Code = 'zc_MovementLinkObject_Object');

CREATE OR REPLACE FUNCTION zc_MovementLinkObject_PriceList() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT Id FROM MovementLinkObjectDesc WHERE Code = 'zc_MovementLinkObject_PriceList'); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
INSERT INTO MovementLinkObjectDesc (Code, ItemName)
  SELECT 'zc_MovementLinkObject_PriceList', '����� ����' WHERE NOT EXISTS (SELECT * FROM MovementLinkObjectDesc WHERE Code = 'zc_MovementLinkObject_PriceList');

CREATE OR REPLACE FUNCTION zc_MovementLinkObject_DocumentTaxKind() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT Id FROM MovementLinkObjectDesc WHERE Code = 'zc_MovementLinkObject_DocumentTaxKind'); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
INSERT INTO MovementLinkObjectDesc (Code, ItemName)
  SELECT 'zc_MovementLinkObject_DocumentTaxKind', '��� ������������ ���������� ���������' WHERE NOT EXISTS (SELECT * FROM MovementLinkObjectDesc WHERE Code = 'zc_MovementLinkObject_DocumentTaxKind');

CREATE OR REPLACE FUNCTION zc_MovementLinkObject_Account() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT Id FROM MovementLinkObjectDesc WHERE Code = 'zc_MovementLinkObject_Account'); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
INSERT INTO MovementLinkObjectDesc (Code, ItemName)
  SELECT 'zc_MovementLinkObject_Account', '�����' WHERE NOT EXISTS (SELECT * FROM MovementLinkObjectDesc WHERE Code = 'zc_MovementLinkObject_Account');

CREATE OR REPLACE FUNCTION zc_MovementLinkObject_User() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT Id FROM MovementLinkObjectDesc WHERE Code = 'zc_MovementLinkObject_User'); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
INSERT INTO MovementLinkObjectDesc (Code, ItemName)
  SELECT 'zc_MovementLinkObject_User', '������������' WHERE NOT EXISTS (SELECT * FROM MovementLinkObjectDesc WHERE Code = 'zc_MovementLinkObject_User');

CREATE OR REPLACE FUNCTION zc_MovementLinkObject_ContractFrom() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT Id FROM MovementLinkObjectDesc WHERE Code = 'zc_MovementLinkObject_ContractFrom'); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
INSERT INTO MovementLinkObjectDesc (Code, ItemName)
  SELECT 'zc_MovementLinkObject_ContractFrom', '������� (�� ����)' WHERE NOT EXISTS (SELECT * FROM MovementLinkObjectDesc WHERE Code = 'zc_MovementLinkObject_ContractFrom');

CREATE OR REPLACE FUNCTION zc_MovementLinkObject_ContractTo() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT Id FROM MovementLinkObjectDesc WHERE Code = 'zc_MovementLinkObject_ContractTo'); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
INSERT INTO MovementLinkObjectDesc (Code, ItemName)
  SELECT 'zc_MovementLinkObject_ContractTo', '������� (����)' WHERE NOT EXISTS (SELECT * FROM MovementLinkObjectDesc WHERE Code = 'zc_MovementLinkObject_ContractTo');

CREATE OR REPLACE FUNCTION zc_MovementLinkObject_PaidKindFrom() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT Id FROM MovementLinkObjectDesc WHERE Code = 'zc_MovementLinkObject_PaidKindFrom'); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
INSERT INTO MovementLinkObjectDesc (Code, ItemName)
  SELECT 'zc_MovementLinkObject_PaidKindFrom', '���� ���� ������ (�� ����)' WHERE NOT EXISTS (SELECT * FROM MovementLinkObjectDesc WHERE Code = 'zc_MovementLinkObject_PaidKindFrom');

CREATE OR REPLACE FUNCTION zc_MovementLinkObject_PaidKindTo() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT Id FROM MovementLinkObjectDesc WHERE Code = 'zc_MovementLinkObject_PaidKindTo'); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
INSERT INTO MovementLinkObjectDesc (Code, ItemName)
  SELECT 'zc_MovementLinkObject_PaidKindTo', '���� ���� ������ (����)' WHERE NOT EXISTS (SELECT * FROM MovementLinkObjectDesc WHERE Code = 'zc_MovementLinkObject_PaidKindTo');

CREATE OR REPLACE FUNCTION zc_MovementLinkObject_NDSKind() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT Id FROM MovementLinkObjectDesc WHERE Code = 'zc_MovementLinkObject_NDSKind'); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
INSERT INTO MovementLinkObjectDesc (Code, ItemName)
  SELECT 'zc_MovementLinkObject_NDSKind', '���� ���' WHERE NOT EXISTS (SELECT * FROM MovementLinkObjectDesc WHERE Code = 'zc_MovementLinkObject_NDSKind');

CREATE OR REPLACE FUNCTION zc_MovementLinkObject_GoodsProperty() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT Id FROM MovementLinkObjectDesc WHERE Code = 'zc_MovementLinkObject_GoodsProperty'); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
INSERT INTO MovementLinkObjectDesc (Code, ItemName)
  SELECT 'zc_MovementLinkObject_GoodsProperty', '�������������� ������� �������' WHERE NOT EXISTS (SELECT * FROM MovementLinkObjectDesc WHERE Code = 'zc_MovementLinkObject_GoodsProperty');

CREATE OR REPLACE FUNCTION zc_MovementLinkObject_CurrencyDocument() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT Id FROM MovementLinkObjectDesc WHERE Code = 'zc_MovementLinkObject_CurrencyDocument'); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
INSERT INTO MovementLinkObjectDesc (Code, ItemName)
  SELECT 'zc_MovementLinkObject_CurrencyDocument', '������ (���������)' WHERE NOT EXISTS (SELECT * FROM MovementLinkObjectDesc WHERE Code = 'zc_MovementLinkObject_CurrencyDocument');

CREATE OR REPLACE FUNCTION zc_MovementLinkObject_CurrencyPartner() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT Id FROM MovementLinkObjectDesc WHERE Code = 'zc_MovementLinkObject_CurrencyPartner'); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
INSERT INTO MovementLinkObjectDesc (Code, ItemName)
  SELECT 'zc_MovementLinkObject_CurrencyPartner', '������ (�����������)' WHERE NOT EXISTS (SELECT * FROM MovementLinkObjectDesc WHERE Code = 'zc_MovementLinkObject_CurrencyPartner');




--CREATE OR REPLACE FUNCTION zc_MovementLinkObject_DocumentMaster() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT Id FROM MovementLinkObjectDesc WHERE Code = 'zc_MovementLinkObject_DocumentMaster'); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
--INSERT INTO MovementLinkObjectDesc (Code, ItemName)
--  SELECT 'zc_MovementLinkObject_DocumentMaster', '��������' WHERE NOT EXISTS (SELECT * FROM MovementLinkObjectDesc WHERE Code = 'zc_MovementLinkObject_DocumentMaster');

--CREATE OR REPLACE FUNCTION zc_MovementLinkObject_DocumentChild() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT Id FROM MovementLinkObjectDesc WHERE Code = 'zc_MovementLinkObject_DocumentChild'); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
--INSERT INTO MovementLinkObjectDesc (Code, ItemName)
--  SELECT 'zc_MovementLinkObject_DocumentChild', '��������' WHERE NOT EXISTS (SELECT * FROM MovementLinkObjectDesc WHERE Code = 'zc_MovementLinkObject_DocumentChild');

/*-------------------------------------------------------------------------------
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.   ������ �.�.
 23.07.17         * add zc_MovementLinkObject_CurrencyDocument
                        zc_MovementLinkObject_CurrencyPartner
 19.07.14                      	                 * add zc_MovementLinkObject_GoodsProperty
 04.07.14                      	                 		        * + zc_MovementLinkObject_NDSKind
 11.02.14                      	                 * add zc_MovementLinkObject_Partner
 11.02.14                      	                 * del 10.02.14 :)
 10.02.14                                                       * add zc_MovementLinkObject_DocumentMaster, zc_MovementLinkObject_DocumentChild
 09.02.14                                                       * add zc_MovementLinkObject_DocumentTaxKind
 31.01.14                                                       * add zc_MovementLinkObject_PriceList
 22.12.13         * add zc_MovementLinkObject_ContractConditionKind
 03.10.13                                         * rename to JuridicalBasis
 25.09.13         * del zc_MovementLinkObject_Member; add UnitForwarding, CarTrailer
 20.08.13         * add zc_MovementLinkObject_Member
 12.08.13         * add zc_MovementLinkObject_BankAccount, Juridical, JuridicalBasis
 29.07.13         * ����� ����� 2, add zc_MovementLinkObject_Personal
 30.06.13                                        * ����� �����
*/
