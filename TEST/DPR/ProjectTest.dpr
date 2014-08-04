program ProjectTest;
{

  Delphi DUnit Test Project
  -------------------------
  This project contains the DUnit test framework and the GUI/Console test runners.
  Add "CONSOLE_TESTRUNNER" to the conditional defines entry in the project options
  to use the console test runner.  Otherwise the GUI test runner will be used by
  default.

}

{$IFDEF CONSOLE_TESTRUNNER}
{$APPTYPE CONSOLE}
{$ENDIF}

uses
  DUnitTestRunner,
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
  dbCreateStructureTest in '..\SOURCE\STRUCTURE\dbCreateStructureTest.pas',
  dbMetadataTest in '..\SOURCE\Metadata\dbMetadataTest.pas',
  ProcessTest in '..\SOURCE\Process\ProcessTest.pas',
  dbCreateViewTest in '..\SOURCE\View\dbCreateViewTest.pas',
  dbProcedureTest in '..\SOURCE\dbProcedureTest.pas',
  dbEnumTest in '..\SOURCE\dbEnumTest.pas',
  AuthenticationTest in '..\SOURCE\AuthenticationTest.pas',
  CommonObjectProcedureTest in '..\SOURCE\Objects\CommonObjectProcedureTest.pas',
  dbObjectTest in '..\SOURCE\dbObjectTest.pas',
  UnitsTest in '..\SOURCE\Objects\All\UnitsTest.pas',
  CommonMovementProcedureTest in '..\SOURCE\Movement\CommonMovementProcedureTest.pas',
  dbMovementTest in '..\SOURCE\Movement\dbMovementTest.pas',
  LoadFormTest in '..\SOURCE\LoadFormTest.pas',
  Forms,
  CommonContainerProcedureTest in '..\SOURCE\Container\CommonContainerProcedureTest.pas',
  CommonMovementItemProcedureTest in '..\SOURCE\MovementItem\CommonMovementItemProcedureTest.pas',
  CommonMovementItemContainerProcedureTest in '..\SOURCE\MovementItemContainer\CommonMovementItemContainerProcedureTest.pas',
  CommonObjectHistoryProcedureTest in '..\SOURCE\ObjectHistory\CommonObjectHistoryProcedureTest.pas',
  CommonProtocolProcedureTest in '..\SOURCE\Protocol\CommonProtocolProcedureTest.pas',
  CommonFunctionTest in '..\SOURCE\Function\CommonFunctionTest.pas',
  CommonReportsProcedureTest in '..\SOURCE\Reports\CommonReportsProcedureTest.pas',
  DataModul in '..\..\SOURCE\DataModul.pas' {dmMain: TDataModule},
  Authentication in '..\..\SOURCE\Authentication.pas',
  Storage in '..\..\SOURCE\Storage.pas',
  zLibUtil in '..\SOURCE\zLibUtil.pas',
  UtilConst in '..\..\SOURCE\UtilConst.pas',
  UtilConvert in '..\..\SOURCE\UtilConvert.pas',
  CommonData in '..\..\SOURCE\CommonData.pas',
  dsdGuides in '..\..\SOURCE\COMPONENT\dsdGuides.pas',
  FormStorage in '..\..\SOURCE\FormStorage.pas',
  GoodsKindEdit in '..\..\Forms\Guides\GoodsKindEdit.pas' {GoodsKindEditForm},
  GoodsPropertyEdit in '..\..\Forms\GoodsPropertyEdit.pas' {GoodsPropertyEditForm},
  GoodsProperty in '..\..\Forms\GoodsProperty.pas' {GoodsPropertyForm},
  CurrencyEdit in '..\..\Forms\CurrencyEdit.pas' {CurencyEditForm},
  GoodsGroupEdit in '..\..\Forms\Guides\GoodsGroupEdit.pas' {GoodsGroupEditForm},
  PriceListEdit in '..\..\Forms\Guides\PriceListEdit.pas' {PriceListEditForm},
  PriceList_Object in '..\..\Forms\Guides\PriceList_Object.pas' {PriceList_ObjectForm},
  ParentForm in '..\..\SOURCE\ParentForm.pas' {ParentForm},
  dsdAction in '..\..\SOURCE\COMPONENT\dsdAction.pas',
  GoodsKind_Object in '..\..\Forms\Guides\GoodsKind_Object.pas' {GoodsKind_ObjectForm},
  Bank in '..\..\Forms\Bank.pas' {CurrencyForm},
  GoodsGroup_Object in '..\..\Forms\Guides\GoodsGroup_Object.pas' {GoodsGroup_ObjectForm},
  GoodsKindWeighingTree in '..\..\Forms\Guides\GoodsKindWeighingTree.pas' {GoodsKindWeighingTreeForm},
  ToolsWeighingEdit in '..\..\Forms\Guides\ToolsWeighingEdit.pas' {ToolsWeighingEditForm},
  MeasureEdit in '..\..\Forms\MeasureEdit.pas' {MeasureEditForm},
  Status in '..\..\Forms\Status.pas' {StatusForm},
  Currency in '..\..\Forms\Currency.pas' {CurrencyForm},
  BankEdit in '..\..\Forms\BankEdit.pas' {BankEditForm},
  PriceListGoodsItem in '..\..\Forms\Guides\PriceListGoodsItem.pas' {PriceListGoodsItemForm},
  ContractKindEdit in '..\..\Forms\Guides\ContractKindEdit.pas' {ContractKindEditForm},
  ContractKind in '..\..\Forms\Guides\ContractKind.pas' {ContractKindForm},
  GoodsPropertyValueEdit in '..\..\Forms\Guides\GoodsPropertyValueEdit.pas' {GoodsPropertyValueEditForm},
  BankAccountContract in '..\..\Forms\Guides\BankAccountContract.pas' {BankAccountContractForm},
  BankAccountContractEdit in '..\..\Forms\Guides\BankAccountContractEdit.pas' {BankAccountContractEditForm},
  BusinessEdit in '..\..\Forms\Guides\BusinessEdit.pas' {BusinessEditForm},
  Business_Object in '..\..\Forms\Guides\Business_Object.pas' {Business_ObjectForm},
  Juridical_Object in '..\..\Forms\Guides\Juridical_Object.pas' {Juridical_ObjectForm},
  dsdDB in '..\..\SOURCE\COMPONENT\dsdDB.pas',
  ToolsWeighingTree in '..\..\Forms\Guides\ToolsWeighingTree.pas' {ToolsWeighingTreeForm},
  dbMovementItemTest in '..\SOURCE\dbMovementItemTest.pas',
  Income in '..\..\Forms\Document\Income.pas' {IncomeForm},
  IncomeJournal in '..\..\Forms\Document\IncomeJournal.pas' {ParentForm2},
  dsdAddOn in '..\..\SOURCE\COMPONENT\dsdAddOn.pas',
  dbMovementCompleteTest in '..\SOURCE\dbMovementCompleteTest.pas',
  Report_Balance in '..\..\Forms\Report\Report_Balance.pas' {Report_BalanceForm},
  LoadReportTest in '..\SOURCE\LoadReportTest.pas',
  PriceListItemTest in '..\SOURCE\ObjectHistory\All\PriceListItemTest.pas',
  InfoMoneyGroup_Object in '..\..\Forms\Guides\InfoMoneyGroup_Object.pas' {InfoMoneyGroup_ObjectForm},
  InfoMoneyGroupEdit in '..\..\Forms\Guides\InfoMoneyGroupEdit.pas' {InfoMoneyGroupEditForm},
  InfoMoneyDestination_Object in '..\..\Forms\Guides\InfoMoneyDestination_Object.pas' {InfoMoneyDestination_ObjectForm},
  InfoMoneyDestinationEdit in '..\..\Forms\Guides\InfoMoneyDestinationEdit.pas' {InfoMoneyDestinationEditForm},
  InfoMoney_Object in '..\..\Forms\Guides\InfoMoney_Object.pas' {InfoMoney_ObjectForm},
  InfoMoneyEdit in '..\..\Forms\Guides\InfoMoneyEdit.pas' {InfoMoneyEditForm},
  AccountGroup_Object in '..\..\Forms\Guides\AccountGroup_Object.pas' {AccountGroup_ObjectForm},
  AccountGroupEdit in '..\..\Forms\Guides\AccountGroupEdit.pas' {AccountGroupEditForm},
  AccountDirection_Object in '..\..\Forms\Guides\AccountDirection_Object.pas' {AccountDirection_ObjectForm},
  AccountDirectionEdit in '..\..\Forms\Guides\AccountDirectionEdit.pas' {AccountDirectionEditForm},
  ProfitLossGroup_Object in '..\..\Forms\Guides\ProfitLossGroup_Object.pas' {ProfitLossGroup_ObjectForm},
  ProfitLossGroupEdit in '..\..\Forms\Guides\ProfitLossGroupEdit.pas' {ProfitLossGroupEditForm},
  Account_Object in '..\..\Forms\Guides\Account_Object.pas' {Account_ObjectForm},
  AccountEdit in '..\..\Forms\Guides\AccountEdit.pas' {AccountEditForm},
  ProfitLoss_Object in '..\..\Forms\Guides\ProfitLoss_Object.pas' {ProfitLoss_ObjectForm},
  ProfitLossDirection_Object in '..\..\Forms\Guides\ProfitLossDirection_Object.pas' {ProfitLossDirection_ObjectForm},
  ProfitLossDirectionEdit in '..\..\Forms\Guides\ProfitLossDirectionEdit.pas' {ProfitLossDirectionEditForm},
  ProfitLossEdit in '..\..\Forms\Guides\ProfitLossEdit.pas' {ProfitLossEditForm},
  dbTest in '..\SOURCE\dbTest.pas',
  TradeMark in '..\..\Forms\TradeMark.pas' {TradeMarkForm},
  TradeMarkEdit in '..\..\Forms\TradeMarkEdit.pas' {TradeMarkEditForm},
  Route in '..\..\Forms\Guides\Route.pas' {RouteForm},
  RouteEdit in '..\..\Forms\Guides\RouteEdit.pas' {RouteEditForm},
  RouteSorting in '..\..\Forms\Guides\RouteSorting.pas' {RouteSortingForm},
  RouteSortingEdit in '..\..\Forms\Guides\RouteSortingEdit.pas' {RouteSortingEditForm},
  Member in '..\..\Forms\Member.pas' {MemberForm},
  MemberEdit in '..\..\Forms\MemberEdit.pas' {MemberEditForm},
  CarModel in '..\..\Forms\CarModel.pas' {CarModelForm},
  CarModelEdit in '..\..\Forms\CarModelEdit.pas' {CarModelEditForm},
  Car in '..\..\Forms\Car.pas' {CarForm},
  CarEdit in '..\..\Forms\CarEdit.pas' {CarEditForm},
  Position in '..\..\Forms\Guides\Position.pas' {PositionForm},
  PositionEdit in '..\..\Forms\Guides\PositionEdit.pas' {PositionEditForm},
  AssetGroupEdit in '..\..\Forms\Guides\AssetGroupEdit.pas' {AssetGroupEditForm: TParentForm},
  Personal in '..\..\Forms\Guides\Personal.pas' {PersonalForm},
  PersonalEdit in '..\..\Forms\Guides\PersonalEdit.pas' {PersonalEditForm},
  ProductionSeparateJournal in '..\..\Forms\Document\ProductionSeparateJournal.pas' {ProductionSeparateJournalForm},
  JuridicalTest in '..\SOURCE\Objects\All\JuridicalTest.pas',
  SendOnPriceJournal in '..\..\Forms\Document\SendOnPriceJournal.pas' {SendOnPriceJournalForm},
  SendOnPrice in '..\..\Forms\Document\SendOnPrice.pas' {SendOnPriceForm},
  LossJournal in '..\..\Forms\Document\LossJournal.pas' {LossJournalForm},
  Loss in '..\..\Forms\Document\Loss.pas' {LossForm},
  ProductionUnionJournal in '..\..\Forms\Document\ProductionUnionJournal.pas' {ProductionUnionJournalForm},
  Report_ProfitLoss in '..\..\Forms\Report\Report_ProfitLoss.pas' {Report_ProfitLossForm},
  Report_HistoryCost in '..\..\Forms\Report\Report_HistoryCost.pas' {Report_HistoryCostForm},
  ProductionUnion in '..\..\Forms\Document\ProductionUnion.pas' {ProductionUnionForm},
  ContractConditionValue in '..\..\Forms\Guides\ContractConditionValue.pas' {ContractConditionValueForm},
  ContractEdit in '..\..\Forms\Guides\ContractEdit.pas' {ContractEditForm},
  Measure in '..\..\Forms\Measure.pas' {MeasureForm},
  PriceListItem in '..\..\Forms\Guides\PriceListItem.pas' {PriceListItemForm},
  ComponentActionTest in '..\SOURCE\Component\ComponentActionTest.pas',
  ComponentDBTest in '..\SOURCE\Component\ComponentDBTest.pas',
  CashOperationTest in '..\SOURCE\Movement\All\CashOperationTest.pas',
  ZakazExternalJournal in '..\..\Forms\Document\ZakazExternalJournal.pas' {ZakazExternalJournalForm},
  ZakazExternal in '..\..\Forms\Document\ZakazExternal.pas' {ZakazExternalForm},
  ZakazInternalJournal in '..\..\Forms\Document\ZakazInternalJournal.pas' {ZakazInternalJournalForm},
  ZakazInternal in '..\..\Forms\Document\ZakazInternal.pas' {ZakazInternalForm},
  CommonObjectCostProcedureTest in '..\SOURCE\ObjectCost\CommonObjectCostProcedureTest.pas',
  BankStatementTest in '..\SOURCE\Movement\All\BankStatementTest.pas',
  BankAccountMovementTest in '..\SOURCE\Movement\All\BankAccountMovementTest.pas',
  ProfitLossServiceTest in '..\SOURCE\Movement\All\ProfitLossServiceTest.pas',
  PersonalServiceTest in '..\SOURCE\Movement\All\PersonalServiceTest.pas',
  PersonalReportTest in '..\SOURCE\Movement\All\PersonalReportTest.pas',
  BankStatementItemTest in '..\SOURCE\Movement\All\BankStatementItemTest.pas',
  AccountTest in '..\SOURCE\Objects\All\AccountTest.pas',
  CashTest in '..\SOURCE\Objects\All\CashTest.pas',
  InfoMoneyTest in '..\SOURCE\Objects\All\InfoMoneyTest.pas',
  TransportServiceTest in '..\SOURCE\Movement\All\TransportServiceTest.pas',
  Goods_Object in '..\..\Forms\Guides\Goods_Object.pas' {Goods_ObjectForm},
  Unit_Object in '..\..\Forms\Guides\Unit_Object.pas' {Unit_ObjectForm},
  JuridicalTree in '..\..\Forms\Guides\JuridicalTree.pas' {JuridicalTreeForm},
  BankAccountTest in '..\SOURCE\Objects\All\BankAccountTest.pas',
  BusinessTest in '..\SOURCE\Objects\All\BusinessTest.pas',
  CommonMovementItemReportProcedureTest in '..\SOURCE\MovementItemReport\CommonMovementItemReportProcedureTest.pas',
  TradeMarkTest in '..\SOURCE\Objects\All\TradeMarkTest.pas',
  ChoicePeriod in '..\..\SOURCE\COMPONENT\ChoicePeriod.pas' {PeriodChoiceForm},
  Report_MotionGoodsDialog in '..\..\Forms\Report\Report_MotionGoodsDialog.pas' {Report_MotionGoodsDialogForm},
  Report_MotionGoods in '..\..\Forms\Report\Report_MotionGoods.pas' {Report_MotionGoodsForm},
  ActionTest in '..\SOURCE\Objects\All\ActionTest.pas',
  Role in '..\..\Forms\Role.pas' {RoleForm},
  RoleEdit in '..\..\Forms\RoleEdit.pas' {RoleEditForm},
  Action in '..\..\Forms\Action.pas' {ActionForm},
  User in '..\..\Forms\User.pas' {UserForm},
  UserEdit in '..\..\Forms\UserEdit.pas' {UserEditForm},
  Process in '..\..\Forms\Enum\Process.pas' {ProcessForm},
  ComponentAddOnTest in '..\SOURCE\Component\ComponentAddOnTest.pas',
  DefaultsTest in '..\SOURCE\Defaults\DefaultsTest.pas',
  Transport in '..\..\Forms\Document\Transport.pas' {TransportForm},
  TransportJournal in '..\..\Forms\Document\TransportJournal.pas' {TransportJournalForm},
  FuelEdit in '..\..\Forms\FuelEdit.pas' {FuelEditForm},
  RateFuelKindEdit in '..\..\Forms\RateFuelKindEdit.pas' {RateFuelKindEditForm},
  RateFuelKind in '..\..\Forms\RateFuelKind.pas' {RateFuelKindForm},
  Fuel in '..\..\Forms\Fuel.pas' {FuelForm},
  RoleTest in '..\SOURCE\Objects\All\RoleTest.pas',
  Defaults in '..\..\SOURCE\COMPONENT\Defaults.pas',
  IncomeFuel in '..\..\Forms\Document\IncomeFuel.pas' {IncomeFuelForm},
  IncomeFuelJournal in '..\..\Forms\Document\IncomeFuelJournal.pas' {IncomeFuelJournalForm},
  Freight in '..\..\Forms\Freight.pas' {FreightForm},
  FreightEdit in '..\..\Forms\FreightEdit.pas' {FreightEditForm},
  RouteKind in '..\..\Forms\Guides\RouteKind.pas' {RouteKindForm},
  RouteKindEdit in '..\..\Forms\Guides\RouteKindEdit.pas' {RouteKindEditForm},
  RateFuel in '..\..\Forms\RateFuel.pas' {RateFuelForm},
  PersonalGroup in '..\..\Forms\Guides\PersonalGroup.pas' {PersonalGroupForm},
  PersonalGroupEdit in '..\..\Forms\Guides\PersonalGroupEdit.pas' {PersonalGroupEditForm},
  PersonalSendCash in '..\..\Forms\Document\PersonalSendCash.pas' {PersonalSendCashForm},
  PersonalSendCashJournal in '..\..\Forms\Document\PersonalSendCashJournal.pas' {PersonalSendCashJournalForm},
  SendDebtTest in '..\SOURCE\Movement\All\SendDebtTest.pas' {$R *.RES},
  SheetWorkTimeTest in '..\SOURCE\Movement\All\SheetWorkTimeTest.pas',
  Report_Fuel in '..\..\Forms\Report\Report_Fuel.pas' {Report_FuelForm},
  Report_Transport in '..\..\Forms\Report\Report_Transport.pas' {Report_TransportForm},
  CrossAddOnViewTestForm in '..\SOURCE\Component\CrossAddOnViewTestForm.pas' {CrossAddOnViewTest},
  Report_Account in '..\..\Forms\Report\Report_Account.pas' {Report_AccountForm},
  MessagesUnit in '..\..\SOURCE\MessagesUnit.pas' {MessagesForm},
  SourceFuel_Object in '..\..\Forms\Guides\SourceFuel_Object.pas' {SourceFuel_ObjectForm: TParentForm},
  CardFuel in '..\..\Forms\CardFuel.pas' {CardFuelForm},
  TicketFuel in '..\..\Forms\TicketFuel.pas' {TicketFuelForm},
  TicketFuelEdit in '..\..\Forms\TicketFuelEdit.pas' {TicketFuelEditForm},
  CardFuelEdit in '..\..\Forms\CardFuelEdit.pas' {CardFuelEditForm},
  SheetWorkTime in '..\..\Forms\Document\SheetWorkTime.pas' {SheetWorkTimeForm},
  SheetWorkTimeJournal in '..\..\Forms\Document\SheetWorkTimeJournal.pas' {SheetWorkTimeJournalForm},
  PositionLevel in '..\..\Forms\Guides\PositionLevel.pas' {PositionLevelForm},
  PositionLevelEdit in '..\..\Forms\Guides\PositionLevelEdit.pas' {PositionLevelEditForm},
  StaffListData in '..\..\Forms\StaffListData.pas' {StaffListDataForm},
  StaffListEdit in '..\..\Forms\StaffListEdit.pas' {StaffListEditForm},
  PersonalTest in '..\SOURCE\Objects\All\PersonalTest.pas',
  TaxCorrectiveMovementItemTest in '..\SOURCE\MovementItem\All\TaxCorrectiveMovementItemTest.pas',
  ModelService in '..\..\Forms\ModelService.pas' {ModelServiceForm},
  ModelServiceKind in '..\..\Forms\Enum\ModelServiceKind.pas' {NDSKindForm},
  UpdaterTest in '..\SOURCE\Component\UpdaterTest.pas',
  AboutBoxUnit in '..\..\SOURCE\AboutBoxUnit.pas' {AboutBox},
  UnilWin in '..\..\SOURCE\UnilWin.pas',
  ModelServiceEdit in '..\..\Forms\ModelServiceEdit.pas' {ModelServiceEditForm: TParentForm},
  StoragePlace_Object in '..\..\Forms\Guides\StoragePlace_Object.pas' {StoragePlace_ObjectForm: TParentForm},
  Report_TransportHoursWork in '..\..\Forms\Report\Report_TransportHoursWork.pas' {Report_TransportHoursWorkForm: TParentForm},
  StaffListChoice in '..\..\Forms\StaffListChoice.pas' {StaffListChoiceForm: TParentForm},
  StaffList in '..\..\Forms\StaffList.pas' {StaffListForm: TParentForm},
  StaffListSummKind in '..\..\Forms\Enum\StaffListSummKind.pas' {StaffListSummKindForm: TParentForm},
  DocumentTaxKind in '..\..\Forms\Kind\DocumentTaxKind.pas' {DocumentTaxKindForm: TParentForm},
  AncestorDialog in '..\..\Forms\Ancestor\AncestorDialog.pas' {AncestorDialogForm: TParentForm},
  AncestorEditDialog in '..\..\Forms\Ancestor\AncestorEditDialog.pas' {AncestorEditDialogForm: TParentForm},
  AncestorData in '..\..\Forms\Ancestor\AncestorData.pas' {AncestorDataForm: TParentForm},
  AncestorReport in '..\..\Forms\Ancestor\AncestorReport.pas' {AncestorReportForm: TParentForm},
  AncestorDBGrid in '..\..\Forms\Ancestor\AncestorDBGrid.pas' {AncestorDBGridForm: TParentForm},
  AncestorJournal in '..\..\Forms\Ancestor\AncestorJournal.pas' {AncestorJournalForm: TParentForm},
  ObjectDesc in '..\..\Forms\System\ObjectDesc.pas' {ObjectDescForm: TParentForm},
  CommonObjectDescProcedureTest in '..\SOURCE\ObjectDesc\CommonObjectDescProcedureTest.pas',
  AncestorEnum in '..\..\Forms\Ancestor\AncestorEnum.pas' {AncestorEnumForm: TParentForm},
  Objects in '..\..\Forms\System\Objects.pas' {ObjectForm: TParentForm},
  AncestorDocumentMC in '..\..\Forms\Ancestor\AncestorDocumentMC.pas' {AncestorDocumentMCForm: TParentForm},
  CashJournal in '..\..\Forms\Document\CashJournal.pas' {CashJournalForm: TParentForm},
  Report_GoodsMI_SaleReturnIn in '..\..\Forms\Report\Report_GoodsMI_SaleReturnIn.pas' {Report_GoodsMI_SaleReturnInForm: TParentForm},
  CashOperation in '..\..\Forms\Document\CashOperation.pas' {CashOperationForm: TParentForm},
  SendTicketFuel in '..\..\Forms\Document\SendTicketFuel.pas' {SendTicketFuelForm: TParentForm},
  SendTicketFuelJournal in '..\..\Forms\Document\SendTicketFuelJournal.pas' {SendTicketFuelJournalForm: TParentForm},
  Units in '..\..\Forms\Guides\Units.pas' {UnitForm: TParentForm},
  Goods in '..\..\Forms\Guides\Goods.pas' {GoodsForm: TParentForm},
  BankAccountJournal in '..\..\Forms\Document\BankAccountJournal.pas' {BankAccountJournalForm: TParentForm},
  ClientBankLoad in '..\..\SOURCE\COMPONENT\ClientBankLoad.pas',
  SimpleGauge in '..\..\SOURCE\SimpleGauge.pas' {SimpleGaugeForm},
  ContractStateKind in '..\..\Forms\Enum\ContractStateKind.pas' {ContractStateKindForm: TParentForm},
  ContractArticleEdit in '..\..\Forms\Guides\ContractArticleEdit.pas' {ContractArticleEditForm: TParentForm},
  ContractArticle in '..\..\Forms\Guides\ContractArticle.pas' {ContractArticleForm: TParentForm},
  ContractTag in '..\..\Forms\Guides\ContractTag.pas' {ContractTagForm: TParentForm},
  ContractTagEdit in '..\..\Forms\Guides\ContractTagEdit.pas' {ContractTagEditForm: TParentForm},
  BankStatement in '..\..\Forms\Document\BankStatement.pas' {BankStatementForm: TParentForm},
  ContractChoicePartner in '..\..\Forms\Guides\ContractChoicePartner.pas' {ContractChoicePartnerForm: TParentForm},
  ContractConditionByContract in '..\..\Forms\Guides\ContractConditionByContract.pas' {ContractConditionByContractForm: TParentForm},
  MoneyPlace_Object in '..\..\Forms\Guides\MoneyPlace_Object.pas' {MoneyPlace_ObjectForm: TParentForm},
  ProfitLossService in '..\..\Forms\Document\ProfitLossService.pas' {ProfitLossServiceForm: TParentForm},
  AncestorGuides in '..\..\Forms\Ancestor\AncestorGuides.pas' {AncestorGuidesForm: TParentForm},
  Personal_Object in '..\..\Forms\Guides\Personal_Object.pas' {Personal_ObjectForm: TParentForm},
  WorkTimeKind in '..\..\Forms\Enum\WorkTimeKind.pas' {WorkTimeKindForm: TParentForm},
  MovementDesc in '..\..\Forms\Kind\MovementDesc.pas' {MovementDescForm: TParentForm},
  JuridicalEdit in '..\..\Forms\Guides\JuridicalEdit.pas' {JuridicalEditForm: TParentForm},
  JuridicalDetailsTest in '..\SOURCE\ObjectHistory\All\JuridicalDetailsTest.pas',
  WorkTimeKind_Object in '..\..\Forms\Enum\WorkTimeKind_Object.pas' {WorkTimeKind_ObjectForm: TParentForm},
  Calendar in '..\..\Forms\Guides\Calendar.pas' {CalendarForm: TParentForm},
  GoodsTree_Object in '..\..\Forms\Guides\GoodsTree_Object.pas' {GoodsTree_ObjectForm: TParentForm},
  BankStatementJournal in '..\..\Forms\Document\BankStatementJournal.pas' {BankStatementJournalForm: TParentForm},
  BankAccountMovement in '..\..\Forms\Document\BankAccountMovement.pas' {BankAccountMovementForm: TParentForm},
  Document in '..\..\SOURCE\COMPONENT\Document.pas',
  SetUserDefaults in '..\..\Forms\System\SetUserDefaults.pas' {SetUserDefaultsForm: TParentForm},
  DefaultsKey in '..\..\Forms\System\DefaultsKey.pas' {DefaultsKeyForm: TParentForm},
  FormsUnit in '..\..\Forms\System\FormsUnit.pas' {FormsForm: TParentForm},
  UnionDesc in '..\..\Forms\System\UnionDesc.pas' {UnionDescForm: TParentForm},
  SendDebtJournal in '..\..\Forms\Document\SendDebtJournal.pas' {SendDebtJournalForm: TParentForm},
  BranchEdit in '..\..\Forms\Guides\BranchEdit.pas' {BranchEditForm: TParentForm},
  Branch in '..\..\Forms\Guides\Branch.pas' {BranchForm: TParentForm},
  Branch_Object in '..\..\Forms\Guides\Branch_Object.pas' {Branch_ObjectForm: TParentForm},
  Cash in '..\..\Forms\Guides\Cash.pas' {CashForm: TParentForm},
  CashEdit in '..\..\Forms\Guides\CashEdit.pas' {CashEditForm: TParentForm},
  Cash_Object in '..\..\Forms\Guides\Cash_Object.pas' {Cash_ObjectForm: TParentForm},
  SendDebt in '..\..\Forms\Document\SendDebt.pas' {SendDebtForm: TParentForm},
  TransportServiceJournal in '..\..\Forms\Document\TransportServiceJournal.pas' {TransportServiceJournalForm: TParentForm},
  UserKey in '..\..\Forms\Guides\UserKey.pas' {UserKeyForm: TParentForm},
  MovementCheck in '..\..\Forms\System\MovementCheck.pas' {MovementCheckForm: TParentForm},
  InfoMoney in '..\..\Forms\Guides\InfoMoney.pas' {InfoMoneyForm: TParentForm},
  SalaryCalculation in '..\SOURCE\Calculation\SalaryCalculation.pas',
  Juridical in '..\..\Forms\Guides\Juridical.pas' {JuridicalForm: TParentForm},
  TransportTest in '..\SOURCE\Movement\All\TransportTest.pas',
  SheetWorkTimeAddRecord in '..\..\Forms\Document\SheetWorkTimeAddRecord.pas' {SheetWorkTimeAddRecordForm: TParentForm},
  PartnerJuridicalEdit in '..\..\Forms\Guides\PartnerJuridicalEdit.pas' {PartnerJuridicalEditForm: TParentForm},
  PartnerEdit in '..\..\Forms\Guides\PartnerEdit.pas' {PartnerEditForm: TParentForm},
  PersonalAccountTest in '..\SOURCE\Movement\All\PersonalAccountTest.pas',
  PersonalAccount in '..\..\Forms\Document\PersonalAccount.pas' {PersonalAccountForm: TParentForm},
  PersonalAccountJournal in '..\..\Forms\Document\PersonalAccountJournal.pas' {PersonalAccountJournalForm: TParentForm},
  GoodsKindWeighingGroup in '..\..\Forms\Guides\GoodsKindWeighingGroup.pas' {GoodsKindWeighingGroupForm: TParentForm},
  GoodsKindWeighingEdit in '..\..\Forms\Guides\GoodsKindWeighingEdit.pas' {GoodsKindWeighingEditForm: TParentForm},
  GoodsKindWeighingGroupEdit in '..\..\Forms\Guides\GoodsKindWeighingGroupEdit.pas' {GoodsKindWeighingGroupEditForm: TParentForm},
  GoodsPropertyValue in '..\..\Forms\Guides\GoodsPropertyValue.pas' {GoodsPropertyValueForm: TParentForm},
  ContractChoice in '..\..\Forms\Guides\ContractChoice.pas' {ContractChoiceForm: TParentForm},
  ReturnInJournal in '..\..\Forms\Document\ReturnInJournal.pas' {ReturnInJournalForm: TParentForm},
  ReturnIn in '..\..\Forms\Document\ReturnIn.pas' {ReturnInForm: TParentForm},
  Report_JuridicalCollation in '..\..\Forms\Report\Report_JuridicalCollation.pas' {Report_JuridicalCollationForm: TParentForm},
  Report_JuridicalSold in '..\..\Forms\Report\Report_JuridicalSold.pas' {Report_JuridicalSoldForm: TParentForm},
  MovementDescForms in '..\..\Forms\System\MovementDescForms.pas' {MovementDescDataForm: TParentForm},
  Report_CheckTaxCorrective in '..\..\Forms\Report\Report_CheckTaxCorrective.pas' {Report_CheckTaxCorrectiveForm: TParentForm},
  LossDebtJournal in '..\..\Forms\Document\LossDebtJournal.pas' {LossDebtJournalForm: TParentForm},
  LossDebt in '..\..\Forms\Document\LossDebt.pas' {LossDebtForm: TParentForm},
  TransportService in '..\..\Forms\Document\TransportService.pas' {TransportServiceForm: TParentForm},
  TaxCorrectiveJournal in '..\..\Forms\Document\TaxCorrectiveJournal.pas' {TaxCorrectiveJournalForm: TParentForm},
  TaxCorrective in '..\..\Forms\Document\TaxCorrective.pas' {TaxCorrectiveForm: TParentForm},
  Partner1CLink in '..\..\Forms\LOAD1C\Partner1CLink.pas' {Partner1CLinkForm: TParentForm},
  GoodsByGoodsKind1CLink in '..\..\Forms\LOAD1C\GoodsByGoodsKind1CLink.pas' {GoodsByGoodsKind1CLinkForm: TParentForm},
  LossDebtTest in '..\SOURCE\Movement\All\LossDebtTest.pas',
  dbMeatTest in '..\SOURCE\dbMeatTest.pas',
  LoadSaleFrom1C in '..\..\Forms\LOAD1C\LoadSaleFrom1C.pas' {LoadSaleFrom1CForm: TParentForm},
  ExternalDocumentLoad in '..\..\SOURCE\COMPONENT\ExternalDocumentLoad.pas',
  ExternalLoad in '..\..\SOURCE\COMPONENT\ExternalLoad.pas',
  ExternalLoadTest in '..\SOURCE\Component\ExternalLoadTest.pas',
  PersonalSendCashTest in '..\SOURCE\Movement\All\PersonalSendCashTest.pas',
  SheetWorkTimeMovementItemTest in '..\SOURCE\MovementItem\All\SheetWorkTimeMovementItemTest.pas',
  Report_GoodsMI_IncomeByPartner in '..\..\Forms\Report\Report_GoodsMI_IncomeByPartner.pas' {Report_GoodsMI_IncomeByPartnerForm: TParentForm},
  Report_GoodsMI_Income in '..\..\Forms\Report\Report_GoodsMI_Income.pas' {Report_GoodsMI_IncomeForm: TParentForm},
  Account in '..\..\Forms\Guides\Account.pas' {AccountForm: TParentForm},
  Log in '..\..\SOURCE\Log.pas',
  Report_GoodsMI_TransferDebt in '..\..\Forms\Report\Report_GoodsMI_TransferDebt.pas' {Report_GoodsMI_TransferDebtForm: TParentForm},
  Report_JuridicalDefermentPayment in '..\..\Forms\Report\Report_JuridicalDefermentPayment.pas' {TReport_JuridicalDefermentPayment: TParentForm},
  PaidKind in '..\..\Forms\Kind\PaidKind.pas' {PaidKindForm: TParentForm},
  Tax in '..\..\Forms\Document\Tax.pas' {TaxForm: TParentForm},
  TaxJournalSelect in '..\..\Forms\Document\TaxJournalSelect.pas' {TaxJournalSelectForm: TParentForm},
  GoodsFuel_Object in '..\..\Forms\Guides\GoodsFuel_Object.pas' {GoodsFuel_ObjectForm: TParentForm},
  JuridicalGroupEdit in '..\..\Forms\Guides\JuridicalGroupEdit.pas' {JuridicalGroupEditForm: TParentForm},
  AssetGroup in '..\..\Forms\Guides\AssetGroup.pas' {AssetGroupForm: TParentForm},
  BonusKind in '..\..\Forms\Kind\BonusKind.pas' {BonusKindForm: TParentForm},
  BonusKindEdit in '..\..\Forms\Kind\BonusKindEdit.pas' {BonusKindEditForm: TParentForm},
  JuridicalGroup in '..\..\Forms\Guides\JuridicalGroup.pas' {JuridicalGroupForm: TParentForm},
  SelectKind in '..\..\Forms\Kind\SelectKind.pas' {SelectKindForm: TParentForm},
  DocumentTaxKindTest in '..\SOURCE\Objects\All\DocumentTaxKindTest.pas',
  SaleTest in '..\SOURCE\Movement\All\SaleTest.pas',
  TaxCorrectiveTest in '..\SOURCE\Movement\All\TaxCorrectiveTest.pas',
  TaxTest in '..\SOURCE\Movement\All\TaxTest.pas',
  ReturnInTest in '..\SOURCE\Movement\All\ReturnInTest.pas',
  AssetEdit in '..\..\Forms\Guides\AssetEdit.pas' {AssetEditForm: TParentForm},
  Asset in '..\..\Forms\Guides\Asset.pas' {AssetForm: TParentForm},
  Maker in '..\..\Forms\Guides\Maker.pas' {MakerForm: TParentForm},
  MakerEdit in '..\..\Forms\Guides\MakerEdit.pas' {MakerEditForm: TParentForm},
  SaleMovementItemTest in '..\SOURCE\MovementItem\All\SaleMovementItemTest.pas',
  ReturnInMovementItemTest in '..\SOURCE\MovementItem\All\ReturnInMovementItemTest.pas',
  TaxMovementItemTest in '..\SOURCE\MovementItem\All\TaxMovementItemTest.pas',
  UserProtocol in '..\..\Forms\System\UserProtocol.pas' {UserProtocolForm: TParentForm},
  MovementProtocol in '..\..\Forms\System\MovementProtocol.pas' {MovementProtocolForm: TParentForm},
  Protocol in '..\..\Forms\System\Protocol.pas' {ProtocolForm: TParentForm},
  MovementItemProtocol in '..\..\Forms\System\MovementItemProtocol.pas' {MovementItemProtocolForm: TParentForm},
  Report_GoodsTax in '..\..\Forms\Report\Report_GoodsTax.pas' {Report_GoodsTaxForm: TParentForm},
  Sale_Partner in '..\..\Forms\Document\Sale_Partner.pas' {Sale_PartnerForm: TParentForm},
  Sale_PartnerJournal in '..\..\Forms\Document\Sale_PartnerJournal.pas' {Sale_PartnerJournalForm: TParentForm},
  ReturnOutTest in '..\SOURCE\Movement\All\ReturnOutTest.pas',
  ReturnOutMovementItemTest in '..\SOURCE\MovementItem\All\ReturnOutMovementItemTest.pas',
  ReturnOutJournal in '..\..\Forms\Document\ReturnOutJournal.pas' {ReturnOutJournalForm: TParentForm},
  ReturnOut in '..\..\Forms\Document\ReturnOut.pas' {ReturnOutForm: TParentForm},
  Report_CheckBonus in '..\..\Forms\Report\Report_CheckBonus.pas' {Report_CheckBonusForm: TParentForm},
  ServiceJournal in '..\..\Forms\Document\ServiceJournal.pas' {ServiceJournalForm: TParentForm},
  ProfitLossServiceJournal in '..\..\Forms\Document\ProfitLossServiceJournal.pas' {ProfitLossServiceJournalForm: TParentForm},
  Service in '..\..\Forms\Document\Service.pas' {ServiceForm: TParentForm},
  ServiceTest in '..\SOURCE\Movement\All\ServiceTest.pas',
  CityKind in '..\..\Forms\Guides\CityKind.pas' {CityKindForm: TParentForm},
  CityKindEdit in '..\..\Forms\Guides\CityKindEdit.pas' {CityKindEditForm: TParentForm},
  ContractConditionKind in '..\..\Forms\Enum\ContractConditionKind.pas' {ContractConditionKindForm: TParentForm},
  PeriodClose in '..\..\Forms\System\PeriodClose.pas' {PeriodCloseForm: TParentForm},
  Contract in '..\..\Forms\Guides\Contract.pas' {ContractForm: TParentForm},
  SaveDocumentTo1C in '..\..\Forms\Export\SaveDocumentTo1C.pas' {SaveDocumentTo1CForm: TParentForm},
  ExternalSave in '..\..\SOURCE\COMPONENT\ExternalSave.pas',
  PersonalService in '..\..\Forms\Document\PersonalService.pas' {PersonalServiceForm: TParentForm},
  PersonalServiceEdit in '..\..\Forms\Document\PersonalServiceEdit.pas' {PersonalServiceEditForm: TParentForm},
  Movement_Journal in '..\..\Forms\Report\Movement_Journal.pas' {MovementJournalForm: TParentForm},
  UnitTree in '..\..\Forms\Guides\UnitTree.pas' {UnitTreeForm: TParentForm},
  UnitEdit in '..\..\Forms\Guides\UnitEdit.pas' {UnitEditForm: TParentForm},
  ExternalData in '..\..\SOURCE\COMPONENT\ExternalData.pas',
  Partner_Object in '..\..\Forms\Guides\Partner_Object.pas' {Partner_ObjectForm: TParentForm},
  WeighingProductionJournal in '..\..\Forms\Document\WeighingProductionJournal.pas' {WeighingProductionJournalForm: TParentForm},
  WeighingProduction in '..\..\Forms\Document\WeighingProduction.pas' {WeighingProductionForm: TParentForm},
  WeighingPartner in '..\..\Forms\Document\WeighingPartner.pas' {WeighingPartnerForm: TParentForm},
  WeighingPartnerJournal in '..\..\Forms\Document\WeighingPartnerJournal.pas' {WeighingPartnerJournalForm: TParentForm},
  Report_CheckTax in '..\..\Forms\Report\Report_CheckTax.pas' {Report_CheckTaxForm: TParentForm},
  AccountGroup in '..\..\Forms\Guides\AccountGroup.pas' {AccountGroupForm: TParentForm},
  AccountDirection in '..\..\Forms\Guides\AccountDirection.pas' {AccountDirectionForm: TParentForm},
  ProfitLoss in '..\..\Forms\Guides\ProfitLoss.pas' {ProfitLossForm: TParentForm},
  ProfitLossDirection in '..\..\Forms\Guides\ProfitLossDirection.pas' {ProfitLossDirectionForm: TParentForm},
  ProfitLossGroup in '..\..\Forms\Guides\ProfitLossGroup.pas' {ProfitLossGroupForm: TParentForm},
  InfoMoneyDestination in '..\..\Forms\Guides\InfoMoneyDestination.pas' {InfoMoneyDestinationForm: TParentForm},
  InfoMoneyGroup in '..\..\Forms\Guides\InfoMoneyGroup.pas' {InfoMoneyGroupForm: TParentForm},
  Business in '..\..\Forms\Guides\Business.pas' {BusinessForm: TParentForm},
  GoodsTree in '..\..\Forms\Guides\GoodsTree.pas' {GoodsTreeForm: TParentForm},
  GoodsEdit in '..\..\Forms\Guides\GoodsEdit.pas' {GoodsEditForm: TParentForm},
  MovementTaxChoice in '..\..\Forms\Guides\MovementTaxChoice.pas' {MovementTaxChoiceForm: TParentForm},
  CityEdit in '..\..\Forms\Guides\CityEdit.pas' {CityEditForm: TParentForm},
  ProvinceCity in '..\..\Forms\Guides\ProvinceCity.pas' {ProvinceCityForm: TParentForm},
  TaxJournal in '..\..\Forms\Document\TaxJournal.pas' {TaxJournalForm: TParentForm},
  Report_CheckContractInMovement in '..\..\Forms\Report\Report_CheckContractInMovement.pas' {Report_CheckContractInMovementForm: TParentForm},
  Area in '..\..\Forms\Guides\Area.pas' {AreaForm: TParentForm},
  AreaEdit in '..\..\Forms\Guides\AreaEdit.pas' {AreaEditForm: TParentForm},
  SaleJournal in '..\..\Forms\Document\SaleJournal.pas' {SaleJournalForm: TParentForm},
  Sale in '..\..\Forms\Document\Sale.pas' {SaleForm: TParentForm},
  BankAccount in '..\..\Forms\Guides\BankAccount.pas' {BankAccountForm: TParentForm},
  BankAccountEdit in '..\..\Forms\Guides\BankAccountEdit.pas' {BankAccountEditForm: TParentForm},
  Partner in '..\..\Forms\Guides\Partner.pas' {PartnerForm: TParentForm},
  TransferDebtIn in '..\..\Forms\Document\TransferDebtIn.pas' {TransferDebtInForm: TParentForm},
  TransferDebtInJournal in '..\..\Forms\Document\TransferDebtInJournal.pas' {TransferDebtInJournalForm: TParentForm},
  TransferDebtOut in '..\..\Forms\Document\TransferDebtOut.pas' {TransferDebtOutForm: TParentForm},
  TransferDebtOutJournal in '..\..\Forms\Document\TransferDebtOutJournal.pas' {TransferDebtOutJournalForm: TParentForm},
  EdiTest in '..\SOURCE\EDI\EdiTest.pas',
  ComDocXML in '..\..\SOURCE\EDI\ComDocXML.pas',
  DeclarXML in '..\..\SOURCE\EDI\DeclarXML.pas',
  EDI in '..\..\SOURCE\EDI\EDI.pas',
  MeDocXML in '..\..\SOURCE\MeDOC\MeDocXML.pas',
  MeDOC in '..\..\SOURCE\MeDOC\MeDOC.pas',
  DesadvXML in '..\..\SOURCE\EDI\DesadvXML.pas',
  ObjectTest in '..\SOURCE\Objects\ObjectTest.pas',
  OrderXML in '..\..\SOURCE\EDI\OrderXML.pas',
  MovementItemContainer in '..\..\Forms\System\MovementItemContainer.pas' {MovementItemContainerForm: TParentForm},
  EDIMovementTest in '..\SOURCE\Movement\All\EDIMovementTest.pas',
  EDIJournal in '..\..\Forms\EDI\EDIJournal.pas' {EDIJournalForm: TParentForm},
  cxGridAddOn in '..\..\SOURCE\DevAddOn\cxGridAddOn.pas',
  Report_GoodsMI_byMovement in '..\..\Forms\Report\Report_GoodsMI_byMovement.pas' {Report_GoodsMI_byMovementForm: TParentForm},
  SaveTaxDocument in '..\..\Forms\Export\SaveTaxDocument.pas' {SaveTaxDocumentForm: TParentForm},
  Report_GoodsMI in '..\..\Forms\Report\Report_GoodsMI.pas' {Report_GoodsMIForm: TParentForm},
  Report_GoodsMI_byPriceDif in '..\..\Forms\Report\Report_GoodsMI_byPriceDif.pas' {Report_GoodsMI_byPriceDifForm: TParentForm},
  Report_GoodsMI_byMovementDif in '..\..\Forms\Report\Report_GoodsMI_byMovementDif.pas' {Report_GoodsMI_byMovementDifForm: TParentForm},
  Report_Goods in '..\..\Forms\Report\Report_Goods.pas' {Report_GoodsForm: TParentForm},
  PriceList in '..\..\Forms\Guides\PriceList.pas' {PriceListForm: TParentForm},
  Retail in '..\..\Forms\Guides\Retail.pas' {RetailForm: TParentForm},
  RetailEdit in '..\..\Forms\Guides\RetailEdit.pas' {RetailEditForm: TParentForm},
  OrderExternalJournal in '..\..\Forms\Document\OrderExternalJournal.pas' {OrderExternalJournalForm: TParentForm},
  OrderExternal in '..\..\Forms\Document\OrderExternal.pas' {OrderExternalForm: TParentForm},
  AncestorDocument in '..\..\Forms\Ancestor\AncestorDocument.pas' {AncestorDocumentForm: TParentForm},
  ProductionSeparate in '..\..\Forms\Document\ProductionSeparate.pas' {ProductionSeparateForm: TParentForm},
  PriceCorrectiveJournal in '..\..\Forms\Document\PriceCorrectiveJournal.pas' {PriceCorrectiveJournalForm: TParentForm},
  PriceCorrective in '..\..\Forms\Document\PriceCorrective.pas' {PriceCorrectiveForm: TParentForm},
  GoodsGroup in '..\..\Forms\Guides\GoodsGroup.pas' {GoodsGroupForm: TParentForm},
  GoodsKind in '..\..\Forms\Guides\GoodsKind.pas' {GoodsKindForm: TParentForm},
  Province in '..\..\Forms\Guides\Province.pas' {ProvinceForm: TParentForm},
  ProvinceCityEdit in '..\..\Forms\Guides\ProvinceCityEdit.pas' {ProvinceCityEditForm: TParentForm},
  Country in '..\..\Forms\Guides\Country.pas' {CountryForm: TParentForm},
  CountryEdit in '..\..\Forms\Guides\CountryEdit.pas' {CountryEditForm: TParentForm},
  Street in '..\..\Forms\Guides\Street.pas' {StreetForm: TParentForm},
  StreetEdit in '..\..\Forms\Guides\StreetEdit.pas' {StreetEditForm: TParentForm},
  StreetKind in '..\..\Forms\Guides\StreetKind.pas' {StreetKindForm: TParentForm},
  StreetKindEdit in '..\..\Forms\Guides\StreetKindEdit.pas' {StreetKindEditForm: TParentForm},
  Region in '..\..\Forms\Guides\Region.pas' {RegionForm: TParentForm},
  RegionEdit in '..\..\Forms\Guides\RegionEdit.pas' {RegionEditForm: TParentForm},
  City in '..\..\Forms\Guides\City.pas' {CityForm: TParentForm},
  ProvinceEdit in '..\..\Forms\Guides\ProvinceEdit.pas' {ProvinceEditForm: TParentForm},
  Inventory in '..\..\Forms\Document\Inventory.pas' {InventoryForm: TParentForm},
  InventoryJournal in '..\..\Forms\Document\InventoryJournal.pas' {InventoryJournalForm: TParentForm},
  OrderInternalJournal in '..\..\Forms\Document\OrderInternalJournal.pas' {OrderInternalJournalForm: TParentForm},
  OrderInternal in '..\..\Forms\Document\OrderInternal.pas' {OrderInternalForm: TParentForm},
  ContactPerson in '..\..\Forms\Guides\ContactPerson.pas' {ContactPersonForm: TParentForm},
  ContactPersonEdit in '..\..\Forms\Guides\ContactPersonEdit.pas' {ContactPersonEditForm: TParentForm},
  ContactPersonKind in '..\..\Forms\Guides\ContactPersonKind.pas' {ContactPersonKindForm: TParentForm},
  ContactPersonKindEdit in '..\..\Forms\Guides\ContactPersonKindEdit.pas' {ContactPersonKindEditForm: TParentForm},
  PartnerAddress in '..\..\Forms\Guides\PartnerAddress.pas' {PartnerAddressForm: TParentForm},
  dbObjectMeatTest in '..\SOURCE\dbObjectMeatTest.pas',
  MainForm in '..\..\FormsMeat\MainForm.pas' {MainForm},
  AncestorMain in '..\..\Forms\Ancestor\AncestorMain.pas' {AncestorMainForm},
  AncestorBase in '..\..\Forms\Ancestor\AncestorBase.pas' {AncestorBaseForm: TParentForm},
  Currency_Object in '..\..\Forms\Guides\Currency_Object.pas' {Currency_ObjectForm: TParentForm},
  MeasureTest in '..\SOURCE\Objects\All\MeasureTest.pas',
  BankTest in '..\SOURCE\Objects\All\BankTest.pas',
  Storage_Object in '..\..\Forms\Guides\Storage_Object.pas' {Storage_ObjectForm: TParentForm},
  Storage_ObjectEdit in '..\..\Forms\Guides\Storage_ObjectEdit.pas' {Storage_ObjectEditForm: TParentForm},
  CurrencyMovement in '..\..\Forms\Document\CurrencyMovement.pas' {CurrencyMovementForm: TParentForm},
  CurrencyJournal in '..\..\Forms\Document\CurrencyJournal.pas' {CurrencyJournalForm: TParentForm},
  Report_ContractEndDate in '..\..\Forms\Report\Report_ContractEndDate.pas' {Report_ContractEndDateForm: TParentForm},
  SendJournal in '..\..\Forms\Document\SendJournal.pas' {SendJournalForm: TParentForm},
  Send in '..\..\Forms\Document\Send.pas' {SendForm: TParentForm},
  BranchTest in '..\SOURCE\Objects\All\BranchTest.pas',
  JuridicalGroupTest in '..\SOURCE\Objects\All\JuridicalGroupTest.pas',
  GoodsPropertyTest in '..\SOURCE\Objects\All\GoodsPropertyTest.pas',
  GoodsTest in '..\SOURCE\Objects\All\GoodsTest.pas',
  GoodsKindTest in '..\SOURCE\Objects\All\GoodsKindTest.pas',
  PartnerTest in '..\SOURCE\Objects\All\PartnerTest.pas',
  RouteSortingTest in '..\SOURCE\Objects\All\RouteSortingTest.pas',
  RouteTest in '..\SOURCE\Objects\All\RouteTest.pas',
  ContractTest in '..\SOURCE\Objects\All\ContractTest.pas',
  AccountDirectionTest in '..\SOURCE\Objects\All\AccountDirectionTest.pas',
  AccountGroupTest in '..\SOURCE\Objects\All\AccountGroupTest.pas',
  CarTest in '..\SOURCE\Objects\All\CarTest.pas',
  CarModelTest in '..\SOURCE\Objects\All\CarModelTest.pas',
  PaidKindTest in '..\SOURCE\Objects\All\PaidKindTest.pas';

{$R *.RES}
{$R DevExpressRus.res}

begin
  Application.Initialize;
  Application.CreateForm(TdmMain, dmMain);
  Application.Run;
  DUnitTestRunner.RunRegisteredTests;
end.

