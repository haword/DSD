program FarmacyTest;

uses
  Forms,
  DUnitTestRunner,
  dbCreateStructureTest in '..\SOURCE\STRUCTURE\dbCreateStructureTest.pas',
  dbMetadataTest in '..\SOURCE\METADATA\dbMetadataTest.pas',
  zLibUtil in '..\SOURCE\zLibUtil.pas',
  CommonFunctionTest in '..\SOURCE\Function\CommonFunctionTest.pas',
  dbFarmacyProcedureTest in '..\SOURCE\dbFarmacyProcedureTest.pas',
  UtilConst in '..\..\SOURCE\UtilConst.pas',
  ProcessTest in '..\SOURCE\Process\ProcessTest.pas',
  dbEnumTest in '..\SOURCE\dbEnumTest.pas',
  dbCreateViewTest in '..\SOURCE\View\dbCreateViewTest.pas',
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
  GoodsGroup in '..\..\Forms\Guides\GoodsGroup.pas' {GoodsGroupForm: TParentForm},
  GoodsGroupEdit in '..\..\Forms\Guides\GoodsGroupEdit.pas' {GoodsGroupEditForm: TParentForm},
  Measure in '..\..\Forms\Measure.pas' {MeasureForm: TParentForm},
  MeasureEdit in '..\..\Forms\MeasureEdit.pas' {MeasureEditForm: TParentForm},
  Box in '..\..\Forms\Box.pas' {BoxForm: TParentForm},
  BoxEdit in '..\..\Forms\BoxEdit.pas' {BoxEditForm: TParentForm},
  ImportExportLinkType in '..\..\Forms\Kind\ImportExportLinkType.pas' {ImportExportLinkTypeForm: TParentForm},
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
  OrderInternalLite in '..\..\FormsFarmacy\Document\OrderInternalLite.pas' {OrderInternalLiteForm: TParentForm},
  OrderInternalJournal in '..\..\FormsFarmacy\Document\OrderInternalJournal.pas' {OrderInternalJournalForm: TParentForm},
  User in '..\..\Forms\User.pas' {UserForm: TParentForm},
  UserEdit in '..\..\Forms\UserEdit.pas' {UserEditForm: TParentForm},
  Role in '..\..\Forms\Role.pas' {RoleForm: TParentForm},
  RoleEdit in '..\..\Forms\RoleEdit.pas' {RoleEditForm: TParentForm},
  RoleTest in '..\SOURCE\Objects\All\RoleTest.pas',
  ImportType in '..\..\Forms\Import\ImportType.pas' {ImportTypeForm: TParentForm},
  JuridicalTest in '..\SOURCE\Objects\All\Farmacy\JuridicalTest.pas',
  CommonObjectHistoryProcedureTest in '..\SOURCE\ObjectHistory\CommonObjectHistoryProcedureTest.pas',
  MovementItemsLoad in '..\..\FormsFarmacy\Load\MovementItemsLoad.pas' {MovementItemsLoadForm: TParentForm},
  ImportGroup in '..\..\Forms\Import\ImportGroup.pas' {ImportGroupForm: TParentForm},
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
  ImportExportLink in '..\..\Forms\System\ImportExportLink.pas' {ImportExportLinkForm: TParentForm},
  ObjectDesc in '..\..\Forms\System\ObjectDesc.pas' {ObjectDescForm: TParentForm},
  FormsUnit in '..\..\Forms\System\FormsUnit.pas' {FormsForm: TParentForm},
  UnionDesc in '..\..\Forms\System\UnionDesc.pas' {UnionDescForm: TParentForm},
  CommonObjectDescProcedureTest in '..\SOURCE\ObjectDesc\CommonObjectDescProcedureTest.pas',
  UserKey in '..\..\Forms\Guides\UserKey.pas' {UserKeyForm: TParentForm},
  CommonObjectProcedureTest in '..\SOURCE\Objects\CommonObjectProcedureTest.pas',
  Goods in '..\..\FormsFarmacy\Guides\Goods.pas' {GoodsForm: TParentForm},
  UnitsTest in '..\SOURCE\Objects\All\Farmacy\UnitsTest.pas',
  UnitTree in '..\..\FormsFarmacy\Guides\UnitTree.pas' {UnitTreeForm: TParentForm},
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
  JuridicalSettings in '..\..\FormsFarmacy\Guides\JuridicalSettings.pas' {JuridicalSettingsForm: TParentForm},
  CommonProtocolProcedureTest in '..\SOURCE\Protocol\CommonProtocolProcedureTest.pas',
  ActionTest in '..\SOURCE\Objects\All\ActionTest.pas',
  Action in '..\..\Forms\Action.pas' {ActionForm: TParentForm},
  UserProtocol in '..\..\Forms\System\UserProtocol.pas' {UserProtocolForm: TParentForm},
  ImportGroupTest in '..\SOURCE\Objects\All\ImportGroupTest.pas',
  ImportGroupItemsTest in '..\SOURCE\Objects\All\ImportGroupItemsTest.pas',
  ImportSettings in '..\..\Forms\Import\ImportSettings.pas' {ImportSettingsForm: TParentForm},
  CommonMovementItemProcedureTest in '..\SOURCE\MovementItem\CommonMovementItemProcedureTest.pas',
  UploadUnloadData in '..\..\FormsFarmacy\ConnectWithOld\UploadUnloadData.pas' {dmUnloadUploadData: TDataModule},
  Unit_Object in '..\..\Forms\Guides\Unit_Object.pas' {Unit_ObjectForm},
  ContactPersonKind in '..\..\Forms\Kind\ContactPersonKind.pas' {ContactPersonKindForm: TParentForm},
  OrderKind in '..\..\Forms\Kind\OrderKind.pas' {OrderKindForm: TParentForm},
  ContactPersonEdit in '..\..\Forms\Guides\ContactPersonEdit.pas' {ContactPersonEditForm: TParentForm},
  ContactPersonTest in '..\SOURCE\Objects\All\ContactPersonTest.pas',
  PartnerCode in '..\..\FormsFarmacy\Guides\PartnerCode.pas' {PartnerCodeForm: TParentForm},
  GoodsLite in '..\..\FormsFarmacy\Guides\GoodsLite.pas' {GoodsLiteForm: TParentForm},
  ReportOrderGoods in '..\..\FormsFarmacy\Report\ReportOrderGoods.pas' {ReportOrderGoodsForm: TParentForm},
  LookAndFillSettings in '..\..\SOURCE\LookAndFillSettings.pas' {LookAndFillSettingsForm},
  ComDocXML in '..\..\SOURCE\EDI\ComDocXML.pas',
  DeclarXML in '..\..\SOURCE\EDI\DeclarXML.pas',
  DesadvXML in '..\..\SOURCE\EDI\DesadvXML.pas',
  EDI in '..\..\SOURCE\EDI\EDI.pas',
  InvoiceXML in '..\..\SOURCE\EDI\InvoiceXML.pas',
  OrderXML in '..\..\SOURCE\EDI\OrderXML.pas',
  OrdrspXML in '..\..\SOURCE\EDI\OrdrspXML.pas',
  dsdInternetAction in '..\..\SOURCE\COMPONENT\dsdInternetAction.pas',
  Member in '..\..\Forms\Guides\Member.pas' {MemberForm: TParentForm},
  Member_Object in '..\..\Forms\Guides\Member_Object.pas' {Member_ObjectForm: TParentForm},
  MemberEdit in '..\..\Forms\Guides\MemberEdit.pas' {MemberEditForm: TParentForm},
  MemberTest in '..\SOURCE\Objects\All\MemberTest.pas',
  Process in '..\..\Forms\Kind\Process.pas' {ProcessForm: TParentForm},
  NDSKindTest in '..\SOURCE\Objects\All\NDSKindTest.pas',
  AncestorMain in '..\..\Forms\Ancestor\AncestorMain.pas' {AncestorMainForm},
  IncomeTest in '..\SOURCE\Movement\All\Farmacy\IncomeTest.pas',
  IncomeMovementItemTest in '..\SOURCE\MovementItem\All\Farmacy\IncomeMovementItemTest.pas',
  ChoiceGoodsFromPriceList in '..\..\FormsFarmacy\System\ChoiceGoodsFromPriceList.pas' {ChoiceGoodsFromPriceListForm: TParentForm},
  OrderInternal in '..\..\FormsFarmacy\Document\OrderInternal.pas' {OrderInternalForm: TParentForm},
  OrderKindTest in '..\SOURCE\Objects\All\OrderKindTest.pas',
  ContactPerson in '..\..\Forms\Guides\ContactPerson.pas' {ContactPersonForm: TParentForm},
  OrderKindEdit in '..\..\Forms\Kind\OrderKindEdit.pas' {OrderKindEditForm: TParentForm},
  ImportExportLinkTest in '..\SOURCE\Objects\All\ImportExportLinkTest.pas',
  SetUserDefaults in '..\..\Forms\System\SetUserDefaults.pas' {SetUserDefaultsForm: TParentForm},
  Protocol in '..\..\Forms\System\Protocol.pas' {ProtocolForm: TParentForm},
  MovementProtocol in '..\..\Forms\System\MovementProtocol.pas' {MovementProtocolForm: TParentForm},
  ImportExportLinkTypeTest in '..\SOURCE\Objects\All\ImportExportLinkTypeTest.pas',
  NDSKind in '..\..\Forms\Kind\NDSKind.pas' {NDSKindForm: TParentForm},
  ComponentDBTest in '..\SOURCE\Component\ComponentDBTest.pas',
  BankAccount in '..\..\Forms\Guides\BankAccount.pas' {BankAccountForm: TParentForm},
  BankAccountEdit in '..\..\Forms\Guides\BankAccountEdit.pas' {BankAccountEditForm: TParentForm},
  Bank in '..\..\Forms\Bank.pas' {BankForm: TParentForm},
  BankAccountTest in '..\SOURCE\Objects\All\BankAccountTest.pas',
  BankTest in '..\SOURCE\Objects\All\BankTest.pas',
  CurrencyTest in '..\SOURCE\Objects\All\CurrencyTest.pas',
  dsdDataSetDataLink in '..\..\SOURCE\COMPONENT\dsdDataSetDataLink.pas',
  dsdXMLTransform in '..\..\SOURCE\COMPONENT\dsdXMLTransform.pas',
  BankAccount_Object in '..\..\Forms\Guides\BankAccount_Object.pas' {BankAccount_ObjectForm: TParentForm},
  BankEdit in '..\..\Forms\BankEdit.pas' {BankEditForm: TParentForm},
  Juridical_Object in '..\..\FormsFarmacy\Guides\Juridical_Object.pas' {Juridical_ObjectForm: TParentForm},
  Currency in '..\..\Forms\Guides\Currency.pas' {CurrencyForm: TParentForm},
  Currency_Object in '..\..\Forms\Guides\Currency_Object.pas' {Currency_ObjectForm: TParentForm},
  CurrencyEdit in '..\..\Forms\Guides\CurrencyEdit.pas' {CurrencyEditForm: TParentForm},
  CurrencyValue_Object in '..\..\Forms\Guides\CurrencyValue_Object.pas' {CurrencyValue_ObjectForm: TParentForm},
  Account in '..\..\Forms\Guides\Account.pas' {AccountForm: TParentForm},
  Account_Object in '..\..\Forms\Guides\Account_Object.pas' {Account_ObjectForm: TParentForm},
  AccountDirection in '..\..\Forms\Guides\AccountDirection.pas' {AccountDirectionForm: TParentForm},
  AccountDirection_Object in '..\..\Forms\Guides\AccountDirection_Object.pas' {AccountDirection_ObjectForm: TParentForm},
  AccountDirectionEdit in '..\..\Forms\Guides\AccountDirectionEdit.pas' {AccountDirectionEditForm: TParentForm},
  AccountEdit in '..\..\Forms\Guides\AccountEdit.pas' {AccountEditForm: TParentForm},
  AccountGroup in '..\..\Forms\Guides\AccountGroup.pas' {AccountGroupForm: TParentForm},
  AccountGroup_Object in '..\..\Forms\Guides\AccountGroup_Object.pas' {AccountGroup_ObjectForm: TParentForm},
  AccountGroupEdit in '..\..\Forms\Guides\AccountGroupEdit.pas' {AccountGroupEditForm: TParentForm},
  AccountDirectionTest in '..\SOURCE\Objects\All\AccountDirectionTest.pas',
  AccountGroupTest in '..\SOURCE\Objects\All\AccountGroupTest.pas',
  AccountTest in '..\SOURCE\Objects\All\AccountTest.pas',
  InfoMoneyDestinationTest in '..\SOURCE\Objects\All\InfoMoneyDestinationTest.pas',
  InfoMoneyGroupTest in '..\SOURCE\Objects\All\InfoMoneyGroupTest.pas',
  InfoMoneyTest in '..\SOURCE\Objects\All\InfoMoneyTest.pas',
  InfoMoney in '..\..\Forms\Guides\InfoMoney.pas' {InfoMoneyForm: TParentForm},
  InfoMoneyDestination in '..\..\Forms\Guides\InfoMoneyDestination.pas' {InfoMoneyDestinationForm: TParentForm},
  InfoMoneyDestination_Object in '..\..\Forms\Guides\InfoMoneyDestination_Object.pas' {InfoMoneyDestination_ObjectForm: TParentForm},
  InfoMoneyDestinationEdit in '..\..\Forms\Guides\InfoMoneyDestinationEdit.pas' {InfoMoneyDestinationEditForm: TParentForm},
  InfoMoneyEdit in '..\..\Forms\Guides\InfoMoneyEdit.pas' {InfoMoneyEditForm: TParentForm},
  InfoMoneyGroup in '..\..\Forms\Guides\InfoMoneyGroup.pas' {InfoMoneyGroupForm: TParentForm},
  InfoMoneyGroup_Object in '..\..\Forms\Guides\InfoMoneyGroup_Object.pas' {InfoMoneyGroup_ObjectForm: TParentForm},
  InfoMoneyGroupEdit in '..\..\Forms\Guides\InfoMoneyGroupEdit.pas' {InfoMoneyGroupEditForm: TParentForm},
  ProfitLossDirectionTest in '..\SOURCE\Objects\All\ProfitLossDirectionTest.pas',
  ProfitLossGroupTest in '..\SOURCE\Objects\All\ProfitLossGroupTest.pas',
  ProfitLossTest in '..\SOURCE\Objects\All\ProfitLossTest.pas',
  ProfitLoss in '..\..\Forms\Guides\ProfitLoss.pas' {ProfitLossForm: TParentForm},
  ProfitLoss_Object in '..\..\Forms\Guides\ProfitLoss_Object.pas' {ProfitLoss_ObjectForm: TParentForm},
  ProfitLossDirection in '..\..\Forms\Guides\ProfitLossDirection.pas' {ProfitLossDirectionForm: TParentForm},
  ProfitLossDirection_Object in '..\..\Forms\Guides\ProfitLossDirection_Object.pas' {ProfitLossDirection_ObjectForm: TParentForm},
  ProfitLossDirectionEdit in '..\..\Forms\Guides\ProfitLossDirectionEdit.pas' {ProfitLossDirectionEditForm: TParentForm},
  ProfitLossEdit in '..\..\Forms\Guides\ProfitLossEdit.pas' {ProfitLossEditForm: TParentForm},
  ProfitLossGroup in '..\..\Forms\Guides\ProfitLossGroup.pas' {ProfitLossGroupForm: TParentForm},
  ProfitLossGroup_Object in '..\..\Forms\Guides\ProfitLossGroup_Object.pas' {ProfitLossGroup_ObjectForm: TParentForm},
  ProfitLossGroupEdit in '..\..\Forms\Guides\ProfitLossGroupEdit.pas' {ProfitLossGroupEditForm: TParentForm},
  ReturnTypeTest in '..\SOURCE\Objects\All\ReturnTypeTest.pas',
  ReturnType in '..\..\Forms\Kind\ReturnType.pas' {ReturnTypeForm: TParentForm},
  ReturnTypeEdit in '..\..\Forms\Kind\ReturnTypeEdit.pas' {ReturnTypeEditForm: TParentForm},
  LossDebtTest in '..\SOURCE\Movement\All\Farmacy\LossDebtTest.pas',
  LossDebtMovementItemTest in '..\SOURCE\MovementItem\All\Farmacy\LossDebtMovementItemTest.pas',
  LossDebt in '..\..\FormsFarmacy\Document\LossDebt.pas' {LossDebtForm: TParentForm},
  LossDebtJournal in '..\..\FormsFarmacy\Document\LossDebtJournal.pas' {LossDebtJournalForm: TParentForm},
  MovementItemContainer in '..\..\Forms\System\MovementItemContainer.pas' {MovementItemContainerForm: TParentForm},
  Report_Balance in '..\..\Forms\Report\Report_Balance.pas' {Report_BalanceForm: TParentForm},
  ReturnOut in '..\..\FormsFarmacy\Document\ReturnOut.pas' {ReturnOutForm: TParentForm},
  ReturnOutJournal in '..\..\FormsFarmacy\Document\ReturnOutJournal.pas' {ReturnOutJournalForm: TParentForm},
  ReturnOutTest in '..\SOURCE\Movement\All\Farmacy\ReturnOutTest.pas',
  IncomeJournalChoice in '..\..\FormsFarmacy\Document\IncomeJournalChoice.pas' {IncomeJournalChoiceForm: TParentForm},
  BankAccountJournal in '..\..\Forms\Document\BankAccountJournal.pas' {BankAccountJournalForm: TParentForm},
  BankAccountMovement in '..\..\Forms\Document\BankAccountMovement.pas' {BankAccountMovementForm: TParentForm},
  BankAccountJournalFarmacy in '..\..\FormsFarmacy\Document\BankAccountJournalFarmacy.pas' {BankAccountJournalFarmacyForm},
  BankAccountMovementFarmacy in '..\..\FormsFarmacy\Document\BankAccountMovementFarmacy.pas' {BankAccountMovementFarmacyForm: TParentForm},
  BankAccountMovementTest in '..\SOURCE\Movement\All\Farmacy\BankAccountMovementTest.pas',
  InfoMoney_Object in '..\..\Forms\Guides\InfoMoney_Object.pas' {InfoMoney_ObjectForm: TParentForm},
  MoneyPlace_Object in '..\..\FormsFarmacy\Guides\MoneyPlace_Object.pas' {MoneyPlace_ObjectForm: TParentForm},
  BankStatement in '..\..\FormsFarmacy\Document\BankStatement.pas' {BankStatementForm: TParentForm},
  BankStatementJournal in '..\..\FormsFarmacy\Document\BankStatementJournal.pas' {BankStatementJournalForm: TParentForm},
  BankStatementTest in '..\SOURCE\Movement\All\BankStatementTest.pas',
  BankStatementItemTest in '..\SOURCE\Movement\All\BankStatementItemTest.pas',
  Report_JuridicalCollation in '..\..\FormsFarmacy\Report\Report_JuridicalCollation.pas' {Report_JuridicalCollationForm: TParentForm},
  Report_JuridicalSold in '..\..\FormsFarmacy\Report\Report_JuridicalSold.pas' {Report_JuridicalSoldForm: TParentForm},
  StatusXML in '..\..\SOURCE\EDI\StatusXML.pas',
  SendOnPrice in '..\..\FormsFarmacy\Document\SendOnPrice.pas' {SendOnPriceForm: TParentForm},
  SendOnPriceJournal in '..\..\FormsFarmacy\Document\SendOnPriceJournal.pas' {SendOnPriceJournalForm: TParentForm},
  MarginCategory in '..\..\Forms\Guides\MarginCategory.pas' {MarginCategoryForm: TParentForm},
  MarginCategoryItem in '..\..\Forms\Guides\MarginCategoryItem.pas' {MarginCategoryItemForm: TParentForm},
  MarginCategoryLink in '..\..\Forms\Guides\MarginCategoryLink.pas' {MarginCategoryLinkForm: TParentForm},
  dsdException in '..\..\SOURCE\dsdException.pas',
  MovementDescForms in '..\..\Forms\System\MovementDescForms.pas' {MovementDescDataForm: TParentForm},
  IncomePharmacy in '..\..\FormsFarmacy\Document\IncomePharmacy.pas' {IncomePharmacyForm: TParentForm},
  IncomePharmacyJournal in '..\..\FormsFarmacy\Document\IncomePharmacyJournal.pas' {IncomePharmacyJournalForm: TParentForm},
  LoadFarmacyReportTest in '..\SOURCE\LoadFarmacyReportTest.pas',
  CheckJournal in '..\..\Forms\Document\CheckJournal.pas' {CheckJournalForm: TParentForm},
  Check in '..\..\Forms\Document\Check.pas' {CheckForm: TParentForm},
  CashRegisterKind in '..\..\Forms\Kind\CashRegisterKind.pas' {CashRegisterKindForm: TParentForm},
  CashRegister in '..\..\Forms\Guides\CashRegister.pas' {CashRegisterForm: TParentForm},
  CashRegisterEdit in '..\..\Forms\Guides\CashRegisterEdit.pas' {CashRegisterEditForm: TParentForm},
  AncestorReport in '..\..\Forms\Ancestor\AncestorReport.pas' {AncestorReportForm: TParentForm},
  Report_RemainGoods in '..\..\FormsFarmacy\Report\Report_RemainGoods.pas' {Report_GoodsRemainsForm: TParentForm},
  Report_GoodsPartionMove in '..\..\FormsFarmacy\Report\Report_GoodsPartionMove.pas' {Report_GoodsPartionMoveForm: TParentForm},
  Price in '..\..\Forms\Guides\Price.pas' {PriceForm: TParentForm},
  PriceTest in '..\SOURCE\Objects\All\Farmacy\PriceTest.pas',
  AlternativeGroupTest in '..\SOURCE\Objects\All\Farmacy\AlternativeGroupTest.pas',
  AlternativeGroup in '..\..\FormsFarmacy\Guides\AlternativeGroup.pas' {AlternativeGroupForm: TParentForm},
  RepriceUnit in '..\..\FormsFarmacy\ConnectWithOld\RepriceUnit.pas' {RepriceUnitForm},
  CheckVIP in '..\..\FormsFarmacy\Document\CheckVIP.pas' {CheckVIPForm: TParentForm},
  CheckDeferred in '..\..\FormsFarmacy\Document\CheckDeferred.pas' {CheckDeferredForm: TParentForm},
  PaidType in '..\..\Forms\Guides\PaidType.pas' {PaidTypeForm: TParentForm},
  PaidTypeTest in '..\SOURCE\Objects\All\Farmacy\PaidTypeTest.pas',
  CashRegisterTest in '..\SOURCE\Objects\All\Farmacy\CashRegisterTest.pas',
  InventoryTest in '..\SOURCE\Movement\All\Farmacy\InventoryTest.pas',
  Inventory in '..\..\FormsFarmacy\Document\Inventory.pas' {InventoryForm: TParentForm},
  InventoryJournal in '..\..\FormsFarmacy\Document\InventoryJournal.pas' {InventoryJournalForm: TParentForm},
  InventoryMovementItemTest in '..\SOURCE\MovementItem\All\Farmacy\InventoryMovementItemTest.pas',
  LossTest in '..\SOURCE\Movement\All\Farmacy\LossTest.pas',
  LossMovementItemTest in '..\SOURCE\MovementItem\All\Farmacy\LossMovementItemTest.pas',
  ArticleLossTest in '..\SOURCE\Objects\All\Farmacy\ArticleLossTest.pas',
  Loss in '..\..\FormsFarmacy\Document\Loss.pas' {LossForm: TParentForm},
  LossJournal in '..\..\FormsFarmacy\Document\LossJournal.pas' {LossJournalForm: TParentForm},
  ArticleLoss in '..\..\Forms\Guides\ArticleLoss.pas' {ArticleLossForm: TParentForm},
  ArticleLossEdit in '..\..\Forms\Guides\ArticleLossEdit.pas' {ArticleLossEditForm: TParentForm},
  Send in '..\..\FormsFarmacy\Document\Send.pas' {SendForm: TParentForm},
  SendJournal in '..\..\FormsFarmacy\Document\SendJournal.pas' {SendJournalForm: TParentForm},
  SendTest in '..\SOURCE\Movement\All\Farmacy\SendTest.pas',
  SendMovementItemTest in '..\SOURCE\MovementItem\All\Farmacy\SendMovementItemTest.pas';

{$R *.res}
{$R DevExpressRus.res}

begin
  ConnectionPath := '..\INIT\farmacy_init.php';
  EnumPath := '..\DATABASE\FARMACY\METADATA\Enum\';
  CreateStructurePath := '..\DATABASE\FARMACY\STRUCTURE\';
  LocalViewPath := '..\DATABASE\FARMACY\View\';
  LocalProcedurePath := '..\DATABASE\FARMACY\PROCEDURE\';
  LocalProcessPath := '..\DATABASE\COMMON\PROCESS\';

  gc_AdminPassword := '�����1234';
  gc_ProgramName := 'Farmacy.exe';

  Application.Initialize;
  gc_isSetDefault := true;
  Application.CreateForm(TdmMain, dmMain);
  Application.Run;

  DUnitTestRunner.RunRegisteredTests;
end.
