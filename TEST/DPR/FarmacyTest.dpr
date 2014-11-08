program FarmacyTest;

uses
  Forms,
  DUnitTestRunner,
  dbCreateStructureTest in '..\SOURCE\STRUCTURE\dbCreateStructureTest.pas',
  dbMetadataTest in '..\SOURCE\METADATA\dbMetadataTest.pas',
  zLibUtil in '..\SOURCE\zLibUtil.pas',
  CommonFunctionTest in '..\SOURCE\Function\CommonFunctionTest.pas',
  dbCreateViewTest in '..\SOURCE\View\dbCreateViewTest.pas',
  dbFarmacyProcedureTest in '..\SOURCE\dbFarmacyProcedureTest.pas',
  UtilConst in '..\..\SOURCE\UtilConst.pas',
  dbEnumTest in '..\SOURCE\dbEnumTest.pas',
  ProcessTest in '..\SOURCE\Process\ProcessTest.pas',
  DefaultsTest in '..\SOURCE\Defaults\DefaultsTest.pas',
  LoadFarmacyFormTest in '..\SOURCE\LoadFarmacyFormTest.pas',
  PriceListGoodsItem in '..\..\Forms\Guides\PriceListGoodsItem.pas' {PriceListGoodsItemForm},
  CommonData in '..\..\SOURCE\CommonData.pas',
  Authentication in '..\..\SOURCE\Authentication.pas',
  FormStorage in '..\..\SOURCE\FormStorage.pas',
  ParentForm in '..\..\SOURCE\ParentForm.pas' {ParentForm},
  Storage in '..\..\SOURCE\Storage.pas',
  UtilConvert in '..\..\SOURCE\UtilConvert.pas',
  dsdAction in '..\..\SOURCE\COMPONENT\dsdAction.pas',
  dsdAddOn in '..\..\SOURCE\COMPONENT\dsdAddOn.pas',
  dsdDB in '..\..\SOURCE\COMPONENT\dsdDB.pas',
  dsdGuides in '..\..\SOURCE\COMPONENT\dsdGuides.pas',
  DataModul in '..\..\SOURCE\DataModul.pas' {dmMain: TDataModule},
  GoodsPartnerCodeMaster in '..\..\FormsFarmacy\Guides\GoodsPartnerCodeMaster.pas' {GoodsPartnerCodeMasterForm},
  GoodsMainEdit in '..\..\FormsFarmacy\Guides\GoodsMainEdit.pas' {GoodsMainEditForm},
  dbTest in '..\SOURCE\dbTest.pas',
  ChoicePeriod in '..\..\SOURCE\COMPONENT\ChoicePeriod.pas' {PeriodChoiceForm},
  Defaults in '..\..\SOURCE\COMPONENT\Defaults.pas',
  UnilWin in '..\..\SOURCE\UnilWin.pas',
  MessagesUnit in '..\..\SOURCE\MessagesUnit.pas' {MessagesForm},
  SimpleGauge in '..\..\SOURCE\SimpleGauge.pas' {SimpleGaugeForm},
  ClientBankLoad in '..\..\SOURCE\COMPONENT\ClientBankLoad.pas',
  Document in '..\..\SOURCE\COMPONENT\Document.pas',
  ExternalLoad in '..\..\SOURCE\COMPONENT\ExternalLoad.pas',
  Log in '..\..\SOURCE\Log.pas',
  ExternalData in '..\..\SOURCE\COMPONENT\ExternalData.pas',
  ExternalSave in '..\..\SOURCE\COMPONENT\ExternalSave.pas',
  VKDBFDataSet in '..\..\SOURCE\DBF\VKDBFDataSet.pas',
  VKDBFPrx in '..\..\SOURCE\DBF\VKDBFPrx.pas',
  VKDBFUtil in '..\..\SOURCE\DBF\VKDBFUtil.pas',
  VKDBFMemMgr in '..\..\SOURCE\DBF\VKDBFMemMgr.pas',
  VKDBFCrypt in '..\..\SOURCE\DBF\VKDBFCrypt.pas',
  VKDBFGostCrypt in '..\..\SOURCE\DBF\VKDBFGostCrypt.pas',
  VKDBFCDX in '..\..\SOURCE\DBF\VKDBFCDX.pas',
  VKDBFIndex in '..\..\SOURCE\DBF\VKDBFIndex.pas',
  VKDBFSorters in '..\..\SOURCE\DBF\VKDBFSorters.pas',
  VKDBFCollate in '..\..\SOURCE\DBF\VKDBFCollate.pas',
  VKDBFParser in '..\..\SOURCE\DBF\VKDBFParser.pas',
  VKDBFNTX in '..\..\SOURCE\DBF\VKDBFNTX.pas',
  VKDBFSortedList in '..\..\SOURCE\DBF\VKDBFSortedList.pas',
  ObjectTest in '..\SOURCE\Objects\ObjectTest.pas',
  cxGridAddOn in '..\..\SOURCE\DevAddOn\cxGridAddOn.pas',
  MeDOC in '..\..\SOURCE\MeDOC\MeDOC.pas',
  MeDocXML in '..\..\SOURCE\MeDOC\MeDocXML.pas',
  ComDocXML in '..\..\SOURCE\EDI\ComDocXML.pas',
  DeclarXML in '..\..\SOURCE\EDI\DeclarXML.pas',
  DesadvXML in '..\..\SOURCE\EDI\DesadvXML.pas',
  EDI in '..\..\SOURCE\EDI\EDI.pas',
  OrderXML in '..\..\SOURCE\EDI\OrderXML.pas',
  GoodsGroup in '..\..\Forms\Guides\GoodsGroup.pas' {GoodsGroupForm: TParentForm},
  GoodsGroupEdit in '..\..\Forms\Guides\GoodsGroupEdit.pas' {GoodsGroupEditForm: TParentForm},
  Measure in '..\..\Forms\Measure.pas' {MeasureForm: TParentForm},
  MeasureEdit in '..\..\Forms\MeasureEdit.pas' {MeasureEditForm: TParentForm},
  Box in '..\..\Forms\Box.pas' {BoxForm: TParentForm},
  BoxEdit in '..\..\Forms\BoxEdit.pas' {BoxEditForm: TParentForm},
  NDSKind in '..\..\Forms\Kind\NDSKind.pas' {NDSKindForm: TParentForm},
  UnitEdit in '..\..\FormsFarmacy\Guides\UnitEdit.pas' {UnitEditForm: TParentForm},
  AncestorBase in '..\..\Forms\Ancestor\AncestorBase.pas' {AncestorBaseForm: TParentForm},
  AncestorData in '..\..\Forms\Ancestor\AncestorData.pas' {AncestorDataForm: TParentForm},
  AncestorDBGrid in '..\..\Forms\Ancestor\AncestorDBGrid.pas' {AncestorDBGridForm: TParentForm},
  AncestorDialog in '..\..\Forms\Ancestor\AncestorDialog.pas' {AncestorDialogForm: TParentForm},
  AncestorDocument in '..\..\Forms\Ancestor\AncestorDocument.pas' {AncestorDocumentForm: TParentForm},
  AncestorDocumentMC in '..\..\Forms\Ancestor\AncestorDocumentMC.pas' {AncestorDocumentMCForm: TParentForm},
  AncestorEditDialog in '..\..\Forms\Ancestor\AncestorEditDialog.pas' {AncestorEditDialogForm: TParentForm},
  AncestorEnum in '..\..\Forms\Ancestor\AncestorEnum.pas' {AncestorEnumForm: TParentForm},
  AncestorGuides in '..\..\Forms\Ancestor\AncestorGuides.pas' {AncestorGuidesForm: TParentForm},
  AncestorJournal in '..\..\Forms\Ancestor\AncestorJournal.pas' {AncestorJournalForm: TParentForm},
  AncestorMain in '..\..\Forms\Ancestor\AncestorMain.pas' {AncestorMainForm},
  AncestorReport in '..\..\Forms\Ancestor\AncestorReport.pas' {AncestorReportForm: TParentForm},
  AboutBoxUnit in '..\..\SOURCE\AboutBoxUnit.pas' {AboutBox},
  dbLoadTest in '..\SOURCE\Load\dbLoadTest.pas',
  Maker in '..\..\Forms\Guides\Maker.pas' {MakerForm: TParentForm},
  MakerEdit in '..\..\Forms\Guides\MakerEdit.pas' {MakerEditForm: TParentForm},
  Country in '..\..\Forms\Guides\Country.pas' {CountryForm: TParentForm},
  CountryEdit in '..\..\Forms\Guides\CountryEdit.pas' {CountryEditForm: TParentForm},
  MovementLoad in '..\..\FormsFarmacy\Load\MovementLoad.pas' {MovementLoadForm: TParentForm},
  UpdaterTest in '..\SOURCE\Component\UpdaterTest.pas',
  dbObjectTest in '..\SOURCE\dbObjectTest.pas',
  Retail in '..\..\Forms\Guides\Retail.pas' {RetailForm: TParentForm},
  RetailEdit in '..\..\Forms\Guides\RetailEdit.pas' {RetailEditForm: TParentForm},
  Juridical in '..\..\FormsFarmacy\Guides\Juridical.pas' {JuridicalForm: TParentForm},
  JuridicalEdit in '..\..\FormsFarmacy\Guides\JuridicalEdit.pas' {JuridicalEditForm: TParentForm},
  MainForm in '..\..\FormsFarmacy\MainForm.pas' {MainForm},
  Income in '..\..\FormsFarmacy\Document\Income.pas' {IncomeForm: TParentForm},
  IncomeJournal in '..\..\FormsFarmacy\Document\IncomeJournal.pas' {IncomeJournalForm: TParentForm},
  PriceList in '..\..\FormsFarmacy\Document\PriceList.pas' {PriceListForm: TParentForm},
  PriceListJournal in '..\..\FormsFarmacy\Document\PriceListJournal.pas' {PriceListJournalForm: TParentForm},
  OrderExternal in '..\..\FormsFarmacy\Document\OrderExternal.pas' {OrderExternalForm: TParentForm},
  OrderExternalJournal in '..\..\FormsFarmacy\Document\OrderExternalJournal.pas' {OrderExternalJournalForm: TParentForm},
  OrderInternal in '..\..\FormsFarmacy\Document\OrderInternal.pas' {OrderInternalForm: TParentForm},
  OrderInternalJournal in '..\..\FormsFarmacy\Document\OrderInternalJournal.pas' {OrderInternalJournalForm: TParentForm},
  User in '..\..\Forms\User.pas' {UserForm: TParentForm},
  UserEdit in '..\..\Forms\UserEdit.pas' {UserEditForm: TParentForm},
  Role in '..\..\Forms\Role.pas' {RoleForm: TParentForm},
  RoleEdit in '..\..\Forms\RoleEdit.pas' {RoleEditForm: TParentForm},
  RoleTest in '..\SOURCE\Objects\All\RoleTest.pas',
  ImportType in '..\..\FormsFarmacy\Load\ImportType.pas' {ImportTypeForm: TParentForm},
  JuridicalTest in '..\SOURCE\Objects\All\Farmacy\JuridicalTest.pas',
  CommonObjectHistoryProcedureTest in '..\SOURCE\ObjectHistory\CommonObjectHistoryProcedureTest.pas',
  MovementItemsLoad in '..\..\FormsFarmacy\Load\MovementItemsLoad.pas' {MovementItemsLoadForm: TParentForm},
  ImportGroup in '..\..\FormsFarmacy\Load\ImportGroup.pas' {ImportGroupForm: TParentForm},
  FileTypeKind in '..\..\Forms\Kind\FileTypeKind.pas' {FileTypeKindForm: TParentForm},
  PriceListItemsLoad in '..\..\FormsFarmacy\Load\PriceListItemsLoad.pas' {PriceListItemsLoadForm: TParentForm},
  PriceListLoad in '..\..\FormsFarmacy\Load\PriceListLoad.pas' {PriceListLoadForm: TParentForm},
  AdditionalGoods in '..\..\FormsFarmacy\Guides\AdditionalGoods.pas' {AdditionalGoodsForm: TParentForm},
  LinkGoodsTest in '..\SOURCE\Objects\All\LinkGoodsTest.pas',
  GoodsTest in '..\SOURCE\Objects\All\Farmacy\GoodsTest.pas',
  GoodsGroupTest in '..\SOURCE\Objects\All\Farmacy\GoodsGroupTest.pas',
  ImportTypeTest in '..\SOURCE\Objects\All\ImportTypeTest.pas',
  ImportTypeItemsTest in '..\SOURCE\Objects\All\ImportTypeItemsTest.pas',
  MeasureTest in '..\SOURCE\Objects\All\MeasureTest.pas',
  PaidKindTest in '..\SOURCE\Objects\All\PaidKindTest.pas',
  PriceListTest in '..\SOURCE\Objects\All\PriceListTest.pas',
  RetailTest in '..\SOURCE\Objects\All\RetailTest.pas',
  UserTest in '..\SOURCE\Objects\All\UserTest.pas',
  ParentFormTest in '..\SOURCE\Form\ParentFormTest.pas' {TestForm: TParentForm},
  GoodsMainLite in '..\..\FormsFarmacy\Guides\GoodsMainLite.pas' {GoodsMainLiteForm: TParentForm},
  DefaultsKey in '..\..\Forms\System\DefaultsKey.pas' {DefaultsKeyForm: TParentForm},
  Objects in '..\..\Forms\System\Objects.pas' {ObjectForm: TParentForm},
  SetUserDefaults in '..\..\Forms\System\SetUserDefaults.pas' {SetUserDefaultsForm: TParentForm},
  ObjectDesc in '..\..\Forms\System\ObjectDesc.pas' {ObjectDescForm: TParentForm},
  FormsUnit in '..\..\Forms\System\FormsUnit.pas' {FormsForm: TParentForm},
  UnionDesc in '..\..\Forms\System\UnionDesc.pas' {UnionDescForm: TParentForm},
  CommonObjectDescProcedureTest in '..\SOURCE\ObjectDesc\CommonObjectDescProcedureTest.pas',
  UserKey in '..\..\Forms\Guides\UserKey.pas' {UserKeyForm: TParentForm},
  CommonObjectProcedureTest in '..\SOURCE\Objects\CommonObjectProcedureTest.pas',
  Goods in '..\..\FormsFarmacy\Guides\Goods.pas' {GoodsForm: TParentForm},
  UnitsTest in '..\SOURCE\Objects\All\Farmacy\UnitsTest.pas',
  UnitTree in '..\..\FormsFarmacy\Guides\UnitTree.pas' {UnitTreeForm: TParentForm},
  Bank in '..\..\Forms\Bank.pas' {BankForm: TParentForm},
  BankEdit in '..\..\Forms\BankEdit.pas' {BankEditForm: TParentForm},
  GoodsEdit in '..\..\FormsFarmacy\Guides\GoodsEdit.pas' {GoodsEditForm: TParentForm},
  GoodsMain in '..\..\FormsFarmacy\Guides\GoodsMain.pas' {GoodsMainForm: TParentForm},
  GoodsPartnerCode in '..\..\FormsFarmacy\Guides\GoodsPartnerCode.pas' {GoodsPartnerCodeForm: TParentForm},
  ImportSettingsTest in '..\SOURCE\Objects\All\ImportSettingsTest.pas',
  ExternalDocumentLoad in '..\..\SOURCE\COMPONENT\ExternalDocumentLoad.pas',
  ExternalLoadTest in '..\SOURCE\Component\ExternalLoadTest.pas',
  LoadObjectUnit in '..\..\FormsFarmacy\Guides\LoadObjectUnit.pas' {LoadObjectForm: TParentForm},
  OrderExternalTest in '..\SOURCE\Movement\All\OrderExternalTest.pas',
  dbMovementTest in '..\SOURCE\Movement\dbMovementTest.pas',
  CommonMovementProcedureTest in '..\SOURCE\Movement\CommonMovementProcedureTest.pas',
  PriceListMovementTest in '..\SOURCE\Movement\All\PriceListMovementTest.pas',
  OrderInternalTest in '..\SOURCE\Movement\All\OrderInternalTest.pas',
  ContractKindTest in '..\SOURCE\Objects\All\ContractKindTest.pas',
  ContractTest in '..\SOURCE\Objects\All\Farmacy\ContractTest.pas',
  Contract in '..\..\FormsFarmacy\Guides\Contract.pas' {ContractForm: TParentForm},
  ContractEdit in '..\..\FormsFarmacy\Guides\ContractEdit.pas' {ContractEditForm: TParentForm},
  PriceGroupSettingsTest in '..\SOURCE\Objects\All\Farmacy\PriceGroupSettingsTest.pas',
  PriceGroupSettingsUnit in '..\..\FormsFarmacy\Guides\PriceGroupSettingsUnit.pas' {PriceGroupSettingsForm: TParentForm},
  JuridicalSettingsTest in '..\SOURCE\Objects\All\JuridicalSettingsTest.pas',
  JuridicalSettingsPriceList in '..\..\FormsFarmacy\Guides\JuridicalSettingsPriceList.pas' {JuridicalSettingsPriceListForm: TParentForm},
  CommonProtocolProcedureTest in '..\SOURCE\Protocol\CommonProtocolProcedureTest.pas',
  ActionTest in '..\SOURCE\Objects\All\ActionTest.pas',
  Action in '..\..\Forms\Action.pas' {ActionForm: TParentForm},
  UserProtocol in '..\..\Forms\System\UserProtocol.pas' {UserProtocolForm: TParentForm},
  ImportGroupTest in '..\SOURCE\Objects\All\ImportGroupTest.pas',
  ImportGroupItemsTest in '..\SOURCE\Objects\All\ImportGroupItemsTest.pas',
  ImportSettings in '..\..\FormsFarmacy\Load\ImportSettings.pas' {ImportSettingsForm: TParentForm},
  CommonMovementItemProcedureTest in '..\SOURCE\MovementItem\CommonMovementItemProcedureTest.pas',
  UploadUnloadData in '..\..\FormsFarmacy\ConnectWithOld\UploadUnloadData.pas' {dmUnloadUploadData: TDataModule},
  Unit_Object in '..\..\Forms\Guides\Unit_Object.pas' {Unit_ObjectForm},
  ContactPersonKind in '..\..\Forms\Kind\ContactPersonKind.pas' {ContactPersonKindForm: TParentForm},
  ContactPerson in '..\..\Forms\Guides\ContactPerson.pas' {ContactPersonForm: TParentForm},
  ContactPersonEdit in '..\..\Forms\Guides\ContactPersonEdit.pas' {ContactPersonEditForm: TParentForm},
  ContactPersonTest in '..\SOURCE\Objects\All\ContactPersonTest.pas',
  JuridicalSettings in '..\..\FormsFarmacy\Guides\JuridicalSettings.pas' {JuridicalSettingsForm: TParentForm},
  PartnerCode in '..\..\FormsFarmacy\Guides\PartnerCode.pas' {PartnerCodeForm: TParentForm},
  GoodsLite in '..\..\FormsFarmacy\Guides\GoodsLite.pas' {GoodsLiteForm: TParentForm},
  ChoiceGoodsFromPriceList in '..\..\FormsFarmacy\System\ChoiceGoodsFromPriceList.pas' {ChoiceGoodsFromPriceListForm: TParentForm},
  LookAndFillSettings in '..\..\SOURCE\LookAndFillSettings.pas' {LookAndFillSettingsForm};

{$R *.res}
{$R DevExpressRus.res}

begin
  ConnectionPath := '..\INIT\farmacy_init.php';
  CreateStructurePath := '..\DATABASE\FARMACY\STRUCTURE\';
  LocalViewPath := '..\DATABASE\FARMACY\View\';
  LocalProcedurePath := '..\DATABASE\FARMACY\PROCEDURE\';
  ProcessPath := '..\DATABASE\FARMACY\PROCESS\';

  gc_AdminPassword := '�����';
  gc_ProgramName := 'Farmacy.exe';

  Application.Initialize;
  gc_isSetDefault := true;
  Application.CreateForm(TdmMain, dmMain);
  Application.Run;

  DUnitTestRunner.RunRegisteredTests;
end.
