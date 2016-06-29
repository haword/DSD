unit Sale;

interface

uses
  DataModul, Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, AncestorDocument, cxGraphics,
  cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxPCdxBarPopupMenu, cxStyles,
  cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, Data.DB, cxDBData,
  cxContainer, Vcl.ComCtrls, dxCore, cxDateUtils, dxSkinsdxBarPainter, dsdAddOn,
  dsdGuides, dsdDB, Vcl.Menus, dxBarExtItems, dxBar, cxClasses,
  Datasnap.DBClient, dsdAction, Vcl.ActnList, cxPropertiesStore, cxButtonEdit,
  cxMaskEdit, cxDropDownEdit, cxCalendar, cxLabel, cxTextEdit, Vcl.ExtCtrls,
  cxGridLevel, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxGridCustomView, cxGrid, cxPC, cxCurrencyEdit, cxCheckBox, frxClass, frxDBSet,
  dxSkinsCore, dxSkinsDefaultPainters, dxSkinscxPCPainter, EDI, dxSkinBlack,
  dxSkinBlue, dxSkinBlueprint, dxSkinCaramel, dxSkinCoffee, dxSkinDarkRoom,
  dxSkinDarkSide, dxSkinDevExpressDarkStyle, dxSkinDevExpressStyle, dxSkinFoggy,
  dxSkinGlassOceans, dxSkinHighContrast, dxSkiniMaginary, dxSkinLilian,
  dxSkinLiquidSky, dxSkinLondonLiquidSky, dxSkinMcSkin, dxSkinMoneyTwins,
  dxSkinOffice2007Black, dxSkinOffice2007Blue, dxSkinOffice2007Green,
  dxSkinOffice2007Pink, dxSkinOffice2007Silver, dxSkinOffice2010Black,
  dxSkinOffice2010Blue, dxSkinOffice2010Silver, dxSkinPumpkin, dxSkinSeven,
  dxSkinSevenClassic, dxSkinSharp, dxSkinSharpPlus, dxSkinSilver,
  dxSkinSpringTime, dxSkinStardust, dxSkinSummer2008, dxSkinTheAsphaltWorld,
  dxSkinValentine, dxSkinVS2010, dxSkinWhiteprint, dxSkinXmas2008Blue;

type
  TSaleForm = class(TAncestorDocumentForm)
    cxLabel3: TcxLabel;
    edFrom: TcxButtonEdit;
    edTo: TcxButtonEdit;
    cxLabel4: TcxLabel;
    edContract: TcxButtonEdit;
    cxLabel9: TcxLabel;
    cxLabel6: TcxLabel;
    edPaidKind: TcxButtonEdit;
    cxLabel5: TcxLabel;
    edPriceWithVAT: TcxCheckBox;
    edVATPercent: TcxCurrencyEdit;
    cxLabel7: TcxLabel;
    edChangePercent: TcxCurrencyEdit;
    cxLabel8: TcxLabel;
    cxLabel13: TcxLabel;
    edRouteSorting: TcxButtonEdit;
    GuidesRouteSorting: TdsdGuides;
    GuidesFrom: TdsdGuides;
    GuidesTo: TdsdGuides;
    PaidKindGuides: TdsdGuides;
    ContractGuides: TdsdGuides;
    edOperDatePartner: TcxDateEdit;
    cxLabel10: TcxLabel;
    edIsChecked: TcxCheckBox;
    colCode: TcxGridDBColumn;
    colName: TcxGridDBColumn;
    colGoodsKindName: TcxGridDBColumn;
    colPartionGoods: TcxGridDBColumn;
    colAmount: TcxGridDBColumn;
    colAmountChangePercent: TcxGridDBColumn;
    colAmountPartner: TcxGridDBColumn;
    colChangePercentAmount: TcxGridDBColumn;
    colPrice: TcxGridDBColumn;
    colCountForPrice: TcxGridDBColumn;
    colAmountSumm: TcxGridDBColumn;
    colHeadCount: TcxGridDBColumn;
    colAssetName: TcxGridDBColumn;
    actGoodsKindChoice: TOpenChoiceForm;
    cxLabel11: TcxLabel;
    edPriceList: TcxButtonEdit;
    PriceListGuides: TdsdGuides;
    cxLabel12: TcxLabel;
    edInvNumberPartner: TcxTextEdit;
    spSelectPrint: TdsdStoredProc;
    N2: TMenuItem;
    N3: TMenuItem;
    mactPrint_Sale: TMultiAction;
    actUpdatePrice: TdsdExecStoredProc;
    spGetReportName: TdsdStoredProc;
    RefreshDispatcher: TRefreshDispatcher;
    actRefreshPrice: TdsdDataSetRefresh;
    PrintHeaderCDS: TClientDataSet;
    mactPrint_Tax_Us: TMultiAction;
    actPrintTax_Us: TdsdPrintAction;
    spGetReporNameTax: TdsdStoredProc;
    bbPrintTax: TdxBarButton;
    actPrint_Tax_ReportName: TdsdExecStoredProc;
    PrintItemsCDS: TClientDataSet;
    edDocumentTaxKind: TcxButtonEdit;
    cxLabel14: TcxLabel;
    DocumentTaxKindGuides: TdsdGuides;
    cxLabel16: TcxLabel;
    edTax: TcxTextEdit;
    actTax: TdsdExecStoredProc;
    spTax: TdsdStoredProc;
    bbTax: TdxBarButton;
    mactPrint_Tax_Client: TMultiAction;
    actPrintTax_Client: TdsdPrintAction;
    spSelectTax_Client: TdsdStoredProc;
    bbPrintTax_Client: TdxBarButton;
    spSelectTax_Us: TdsdStoredProc;
    spGetReporNameBill: TdsdStoredProc;
    mactPrint_Account: TMultiAction;
    actPrint_Account_ReportName: TdsdExecStoredProc;
    actPrint_Account: TdsdPrintAction;
    bbPrint_Bill: TdxBarButton;
    colMeasureName: TcxGridDBColumn;
    PrintItemsSverkaCDS: TClientDataSet;
    mactDECLAR: TMultiAction;
    bbDECLAR: TdxBarButton;
    actExecPrintStoredProc: TdsdExecStoredProc;
    spEDIConnect: TdsdExecStoredProc;
    spConnectWithEDI: TdsdStoredProc;
    bbConnectWithComdoc: TdxBarButton;
    cbCOMDOC: TcxCheckBox;
    mactCOMDOC: TMultiAction;
    EDIDeclar: TEDIAction;
    EDIComdoc: TEDIAction;
    bbEDIComDoc: TdxBarButton;
    EDI: TEDI;
    spGetDefaultEDI: TdsdStoredProc;
    actSetDefaults: TdsdExecStoredProc;
    cxLabel17: TcxLabel;
    edCurrencyDocument: TcxButtonEdit;
    CurrencyDocumentGuides: TdsdGuides;
    cxLabel18: TcxLabel;
    edCurrencyPartnerValue: TcxCurrencyEdit;
    cxLabel19: TcxLabel;
    edCurrencyPartner: TcxButtonEdit;
    CurrencyPartnerGuides: TdsdGuides;
    actPrint_ExpInvoice: TdsdPrintAction;
    bbPrint_Invoice: TdxBarButton;
    actPrint_ExpPack: TdsdPrintAction;
    bbPrint_Pack: TdxBarButton;
    BoxName: TcxGridDBColumn;
    BoxCount: TcxGridDBColumn;
    actGoodsBoxChoice: TOpenChoiceForm;
    edContractTag: TcxButtonEdit;
    cxLabel20: TcxLabel;
    ContractTagGuides: TdsdGuides;
    edInvNumberOrder: TcxButtonEdit;
    GuidesInvNumberOrder: TdsdGuides;
    spSelectPrint_ExpPack: TdsdStoredProc;
    cbCalcAmountPartner: TcxCheckBox;
    edChangePercentAmount: TcxCurrencyEdit;
    bbIsCalcAmountPartner: TdxBarControlContainerItem;
    bbChangePercentAmount: TdxBarControlContainerItem;
    spSelectPrint_Spec: TdsdStoredProc;
    spSelectPrint_Pack: TdsdStoredProc;
    actPrint_Spec: TdsdPrintAction;
    actPrint_Pack: TdsdPrintAction;
    bbPrint_Pack21: TdxBarButton;
    bbPrint_Pack22: TdxBarButton;
    spSelectPrint_ExpInvoice: TdsdStoredProc;
    edParPartnerValue: TcxCurrencyEdit;
    cxLabel21: TcxLabel;
    actPrint_ExpSpec: TdsdPrintAction;
    bbPrint_Spec: TdxBarButton;
    spUpdatePriceCurrency: TdsdStoredProc;
    actUpdatePriceCurrency: TdsdExecStoredProc;
    bbUpdatePriceCurrency: TdxBarButton;
    spSelectPrint_TTN: TdsdStoredProc;
    actPrint_TTN: TdsdPrintAction;
    bbPrint_TTN: TdxBarButton;
    colLineNum: TcxGridDBColumn;
    bbPrint_Quality: TdxBarButton;
    spSelectPrint_Quality: TdsdStoredProc;
    actPrint_QualityDoc: TdsdPrintAction;
    mactPrint_TTN: TMultiAction;
    actDialog_TTN: TdsdOpenForm;
    clGoodsGroupNameFull: TcxGridDBColumn;
    actGoodsChoiceForm: TOpenChoiceForm;
    cxLabel22: TcxLabel;
    ceComment: TcxTextEdit;
    spSelectPrint_SaleOrder: TdsdStoredProc;
    actPrintSaleOrder: TdsdPrintAction;
    ��: TdxBarButton;
    PriceCost: TcxGridDBColumn;
    SumCost: TcxGridDBColumn;
    spUpdate_MI_Sale_Price: TdsdStoredProc;
    bbUpdatePrice: TdxBarButton;
    cxLabel23: TcxLabel;
    edCurrencyValue: TcxCurrencyEdit;
    cxLabel24: TcxLabel;
    edParValue: TcxCurrencyEdit;
    Price_Pricelist: TcxGridDBColumn;
    actSPPrintSaleProcName: TdsdExecStoredProc;
    spInsertUpdateMovement_Params: TdsdStoredProc;
    cxLabel25: TcxLabel;
    edInvNumberTransport: TcxButtonEdit;
    TransportChoiceGuides: TdsdGuides;
    HeaderSaver2: THeaderSaver;
    spSelectPrintReturnInDay: TdsdStoredProc;
    actPrintReturnInDay: TdsdPrintAction;
    bbPrintReturnInDay: TdxBarButton;
    isBarCode: TcxGridDBColumn;
    CountPack: TcxGridDBColumn;
    WeightTotal: TcxGridDBColumn;
    WeightPack: TcxGridDBColumn;
    colTotalPercentAmount: TcxGridDBColumn;
    cbPromo: TcxCheckBox;
    MovementPromo: TcxGridDBColumn;
    PricePromo: TcxGridDBColumn;
    cbPrinted: TcxCheckBox;
    spSavePrintState: TdsdStoredProc;
    actSPSavePrintState: TdsdExecStoredProc;
    colChangePercent: TcxGridDBColumn;
    Price_Pricelist_vat: TcxGridDBColumn;
    spGetReportNameTransport: TdsdStoredProc;
    bbPrint_Transport: TdxBarButton;
    mactPrint_Transport: TMultiAction;
    actPrint_Transport: TdsdPrintAction;
    actPrint_Transport_ReportName: TdsdExecStoredProc;
    actShowMessage: TShowMessageAction;
    actOpenReportForm: TdsdOpenForm;
    bbOpenReportForm: TdxBarButton;
    cxLabel26: TcxLabel;
    edReestrKind: TcxButtonEdit;
    ReestrKindGuides: TdsdGuides;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

initialization
  RegisterClass(TSaleForm);

end.
