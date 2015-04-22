unit Report_JuridicalDefermentIncome;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, AncestorReport, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxPCdxBarPopupMenu, cxStyles,
  cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, Data.DB, cxDBData,
  cxContainer, Vcl.ComCtrls, dxCore, cxDateUtils, dsdAddOn, ChoicePeriod,
  Vcl.Menus, dxBarExtItems, dxBar, cxClasses, dsdDB, Datasnap.DBClient,
  dsdAction, Vcl.ActnList, cxPropertiesStore, cxLabel, cxTextEdit, cxMaskEdit,
  cxDropDownEdit, cxCalendar, Vcl.ExtCtrls, cxGridLevel, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid, cxPC,
  cxCurrencyEdit, dsdGuides, cxButtonEdit, dxSkinsCore, dxSkinsDefaultPainters,
  dxSkinscxPCPainter, dxSkinsdxBarPainter, frxClass, frxDBSet, cxImageComboBox;

type
  TReport_JuridicalDefermentIncomeForm = class(TAncestorReportForm)
    clJuridicalName: TcxGridDBColumn;
    colContractNumber: TcxGridDBColumn;
    colKreditRemains: TcxGridDBColumn;
    colDebetRemains: TcxGridDBColumn;
    colSaleSumm: TcxGridDBColumn;
    colDefermentPaymentRemains: TcxGridDBColumn;
    colSaleSumm1: TcxGridDBColumn;
    colSaleSumm2: TcxGridDBColumn;
    colSaleSumm3: TcxGridDBColumn;
    colSaleSumm4: TcxGridDBColumn;
    colSaleSumm5: TcxGridDBColumn;
    clAccountName: TcxGridDBColumn;
    colCondition: TcxGridDBColumn;
    edAccount: TcxButtonEdit;
    cxLabel3: TcxLabel;
    GuidesAccount: TdsdGuides;
    actPrintOneWeek: TdsdPrintAction;
    actPrintTwoWeek: TdsdPrintAction;
    actPrintThreeWeek: TdsdPrintAction;
    actPrintFourWeek: TdsdPrintAction;
    spReport: TdsdStoredProc;
    cdsReport: TClientDataSet;
    bbReportOneWeek: TdxBarButton;
    FormParams: TdsdFormParams;
    bbTwoWeek: TdxBarButton;
    bbThreeWeek: TdxBarButton;
    bbFourWeek: TdxBarButton;
    bbOther: TdxBarButton;
    actPrint: TdsdPrintAction;
    bbPribt: TdxBarButton;
    clOKPO: TcxGridDBColumn;
    colContractCode: TcxGridDBColumn;
    clInfoMoneyCode: TcxGridDBColumn;
    clInfoMoneyGroupName: TcxGridDBColumn;
    clInfoMoneyDestinationName: TcxGridDBColumn;
    clInfoMoneyName: TcxGridDBColumn;
    clPaidKindName: TcxGridDBColumn;
    clAreaName: TcxGridDBColumn;
    clStartDate: TcxGridDBColumn;
    clEndDate: TcxGridDBColumn;
    actPrintIncome: TdsdPrintAction;
    spReport_JuridicalSaleDocument: TdsdStoredProc;
    bbIncome: TdxBarButton;
    cxLabel6: TcxLabel;
    edPaidKind: TcxButtonEdit;
    GuidesPaidKind: TdsdGuides;
    clStartContractDate: TcxGridDBColumn;
    clRetailName: TcxGridDBColumn;
    cxLabel9: TcxLabel;
    edBranch: TcxButtonEdit;
    GuidesBranch: TdsdGuides;
    colBranchCode: TcxGridDBColumn;
    colBranchName: TcxGridDBColumn;
    cxLabel4: TcxLabel;
    edJuridicalGroup: TcxButtonEdit;
    GuidesJuridicalGroup: TdsdGuides;
    clRetailName_main: TcxGridDBColumn;
    clContractTagGroupName: TcxGridDBColumn;
    clPersonalTradeName: TcxGridDBColumn;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

initialization
  RegisterClass(TReport_JuridicalDefermentIncomeForm);


end.
