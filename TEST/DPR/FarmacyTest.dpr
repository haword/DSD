program FarmacyTest;

uses
  Forms,
  DUnitTestRunner,
  dbCreateStructureTest in '..\SOURCE\STRUCTURE\dbCreateStructureTest.pas',
  dbMetadataTest in '..\SOURCE\METADATA\dbMetadataTest.pas',
  zLibUtil in '..\SOURCE\zLibUtil.pas',
  dbCreateViewTest in '..\SOURCE\View\dbCreateViewTest.pas',
  dbFarmacyProcedureTest in '..\SOURCE\dbFarmacyProcedureTest.pas',
  UtilConst in '..\..\SOURCE\UtilConst.pas',
  dbEnumTest in '..\SOURCE\dbEnumTest.pas',
  LoadFarmacyFormTest in '..\SOURCE\LoadFarmacyFormTest.pas',
  PriceListGoodsItem in '..\..\Forms\Guides\PriceListGoodsItem.pas' {PriceListGoodsItemForm},
  CommonData in '..\..\SOURCE\CommonData.pas',
  Authentication in '..\..\SOURCE\Authentication.pas',
  FormStorage in '..\..\SOURCE\FormStorage.pas',
  ParentForm in '..\..\SOURCE\ParentForm.pas' {ParentForm},
  ProcessTest in '..\SOURCE\Process\ProcessTest.pas',
  Storage in '..\..\SOURCE\Storage.pas',
  UtilConvert in '..\..\SOURCE\UtilConvert.pas',
  dsdAction in '..\..\SOURCE\COMPONENT\dsdAction.pas',
  dsdAddOn in '..\..\SOURCE\COMPONENT\dsdAddOn.pas',
  dsdDB in '..\..\SOURCE\COMPONENT\dsdDB.pas',
  dsdGuides in '..\..\SOURCE\COMPONENT\dsdGuides.pas',
  DataModul in '..\..\SOURCE\DataModul.pas' {dmMain: TDataModule},
  Goods in '..\..\FormsFarmacy\Guides\Goods.pas' {GoodsForm},
  GoodsEdit in '..\..\FormsFarmacy\Guides\GoodsEdit.pas' {GoodsEditForm},
  Units in '..\..\FormsFarmacy\Guides\Units.pas' {UnitForm},
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
  Maker in '..\..\Forms\Guides\Maker.pas' {MakerForm: TParentForm},
  MakerEdit in '..\..\Forms\Guides\MakerEdit.pas' {MakerEditForm: TParentForm},
  Country in '..\..\Forms\Guides\Country.pas' {CountryForm: TParentForm},
  CountryEdit in '..\..\Forms\Guides\CountryEdit.pas' {CountryEditForm: TParentForm},
  NDSKind in '..\..\Forms\Enum\NDSKind.pas' {NDSKindForm: TParentForm},
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
  MovementLoad in '..\..\FormsFarmacy\Load\MovementLoad.pas' {MovementLoadForm: TParentForm},
  UpdaterTest in '..\SOURCE\Component\UpdaterTest.pas',
  dbObjectTest in '..\SOURCE\dbObjectTest.pas',
  Retail in '..\..\Forms\Guides\Retail.pas' {RetailForm: TParentForm},
  RetailEdit in '..\..\Forms\Guides\RetailEdit.pas' {RetailEditForm: TParentForm},
  Juridical in '..\..\FormsFarmacy\Guides\Juridical.pas' {JuridicalForm: TParentForm},
  JuridicalEdit in '..\..\FormsFarmacy\Guides\JuridicalEdit.pas' {JuridicalEditForm: TParentForm},
  ActionTest in '..\SOURCE\Objects\All\ActionTest.pas',
  MainForm in '..\..\FormsFarmacy\MainForm.pas' {MainForm},
  Contract in '..\..\FormsFarmacy\Guides\Contract.pas' {ContractForm: TParentForm},
  ContractEdit in '..\..\FormsFarmacy\Guides\ContractEdit.pas' {ContractEditForm: TParentForm},
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
  ImportTypeTest in '..\SOURCE\Objects\All\ImportTypeTest.pas',
  ImportTypeItemsTest in '..\SOURCE\Objects\All\ImportTypeItemsTest.pas',
  ExternalLoadTest in '..\SOURCE\Component\ExternalLoadTest.pas',
  Unit_Object in '..\..\FormsFarmacy\Guides\Unit_Object.pas' {Unit_ObjectForm: TParentForm},
  ImportType in '..\..\FormsFarmacy\Load\ImportType.pas' {ImportTypeForm: TParentForm},
  JuridicalTest in '..\SOURCE\Objects\All\Farmacy\JuridicalTest.pas',
  CommonObjectHistoryProcedureTest in '..\SOURCE\ObjectHistory\CommonObjectHistoryProcedureTest.pas',
  MovementItemsLoad in '..\..\FormsFarmacy\Load\MovementItemsLoad.pas' {MovementItemsLoadForm: TParentForm},
  ImportSettings in '..\..\FormsFarmacy\Load\ImportSettings.pas' {ImportSettingsForm: TParentForm},
  FileTypeKind in '..\..\Forms\Enum\FileTypeKind.pas' {FileTypeKindForm: TParentForm},
  PriceListItemsLoad in '..\..\FormsFarmacy\Load\PriceListItemsLoad.pas' {PriceListItemsLoadForm: TParentForm},
  PriceListLoad in '..\..\FormsFarmacy\Load\PriceListLoad.pas' {PriceListLoadForm: TParentForm},
  AlternativeGoodsCode in '..\..\FormsFarmacy\Guides\AlternativeGoodsCode.pas' {AlternativeGoodsCodeForm: TParentForm},
  MeasureTest in '..\SOURCE\Objects\All\MeasureTest.pas',
  BankTest in '..\SOURCE\Objects\All\BankTest.pas',
  GoodsTest in '..\SOURCE\Objects\All\Farmacy\GoodsTest.pas',
  BranchTest in '..\SOURCE\Objects\All\BranchTest.pas',
  CarModelTest in '..\SOURCE\Objects\All\CarModelTest.pas',
  CarTest in '..\SOURCE\Objects\All\CarTest.pas',
  ContractTest in '..\SOURCE\Objects\All\ContractTest.pas',
  ContractKindTest in '..\SOURCE\Objects\All\ContractKindTest.pas',
  GoodsGroupTest in '..\SOURCE\Objects\All\GoodsGroupTest.pas',
  GoodsKindTest in '..\SOURCE\Objects\All\GoodsKindTest.pas',
  GoodsPropertyTest in '..\SOURCE\Objects\All\GoodsPropertyTest.pas',
  JuridicalGroupTest in '..\SOURCE\Objects\All\JuridicalGroupTest.pas',
  PaidKindTest in '..\SOURCE\Objects\All\PaidKindTest.pas',
  PartnerTest in '..\SOURCE\Objects\All\PartnerTest.pas',
  RouteTest in '..\SOURCE\Objects\All\RouteTest.pas',
  RouteSortingTest in '..\SOURCE\Objects\All\RouteSortingTest.pas',
  UserTest in '..\SOURCE\Objects\All\UserTest.pas',
  AccountGroupTest in '..\SOURCE\Objects\All\AccountGroupTest.pas',
  AccountDirectionTest in '..\SOURCE\Objects\All\AccountDirectionTest.pas',
  ProfitLossGroupTest in '..\SOURCE\Objects\All\ProfitLossGroupTest.pas',
  ProfitLossDirectionTest in '..\SOURCE\Objects\All\ProfitLossDirectionTest.pas',
  ProfitLossTest in '..\SOURCE\Objects\All\ProfitLossTest.pas',
  InfoMoneyGroupTest in '..\SOURCE\Objects\All\InfoMoneyGroupTest.pas',
  InfoMoneyDestinationTest in '..\SOURCE\Objects\All\InfoMoneyDestinationTest.pas',
  InfoMoneyTest in '..\SOURCE\Objects\All\InfoMoneyTest.pas',
  MemberTest in '..\SOURCE\Objects\All\MemberTest.pas',
  PositionTest in '..\SOURCE\Objects\All\PositionTest.pas',
  PriceListTest in '..\SOURCE\Objects\All\PriceListTest.pas',
  AssetGroupTest in '..\SOURCE\Objects\All\AssetGroupTest.pas',
  AssetTest in '..\SOURCE\Objects\All\AssetTest.pas',
  ReceiptCostTest in '..\SOURCE\Objects\All\ReceiptCostTest.pas',
  CurrencyTest in '..\SOURCE\Objects\All\CurrencyTest.pas',
  RetailTest in '..\SOURCE\Objects\All\RetailTest.pas',
  ParentFormTest in '..\SOURCE\Form\ParentFormTest.pas' {TestForm: TParentForm};

{$R *.res}
{$R DevExpressRus.res}

begin
  ConnectionPath := '..\INIT\farmacy_init.php';
  CreateStructurePath := '..\DATABASE\FARMACY\STRUCTURE\';
  LocalViewPath := '..\DATABASE\FARMACY\View\';
  LocalProcedurePath := '..\DATABASE\FARMACY\PROCEDURE\';
  gc_ProgramName := 'Farmacy.exe';

  Application.Initialize;
  Application.CreateForm(TdmMain, dmMain);
  Application.Run;

  DUnitTestRunner.RunRegisteredTests;
end.
