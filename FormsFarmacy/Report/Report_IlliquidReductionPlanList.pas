unit Report_IlliquidReductionPlanList;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  AncestorReport, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  cxPCdxBarPopupMenu, cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage,
  cxEdit, Data.DB, cxDBData, Vcl.Menus, dsdAddOn, dxBarExtItems, dxBar,
  cxClasses, dsdDB, Datasnap.DBClient, dsdAction, Vcl.ActnList,
  cxPropertiesStore, cxGridLevel, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGrid, cxPC, cxContainer, cxTextEdit,
  cxLabel, cxCurrencyEdit, cxButtonEdit, Vcl.DBActns, cxMaskEdit, Vcl.ExtCtrls,
  Vcl.ComCtrls, dxCore, cxDateUtils, ChoicePeriod, cxDropDownEdit, cxCalendar,
  dsdGuides, dxBarBuiltInMenu, cxNavigator, dxSkinsCore, dxSkinsDefaultPainters,
  dxSkinscxPCPainter, dxSkinsdxBarPainter;

type
  TReport_IlliquidReductionPlanListForm = class(TAncestorReportForm)
    GoodsCode: TcxGridDBColumn;
    GoodsName: TcxGridDBColumn;
    actRefreshSearch: TdsdExecStoredProc;
    ExecuteDialog: TExecuteDialog;
    bbExecuteDialog: TdxBarButton;
    AmountStart: TcxGridDBColumn;
    AmountSale: TcxGridDBColumn;
    Color_calc: TcxGridDBColumn;
    FormParams: TdsdFormParams;
    dxBarButton1: TdxBarButton;
    edUserName: TcxTextEdit;
    edUserCode: TcxTextEdit;
    cxLabel3: TcxLabel;
    cxGridDetals: TcxGrid;
    cxGridDBTableView1: TcxGridDBTableView;
    D_AmountStart: TcxGridDBColumn;
    D_ProcSale: TcxGridDBColumn;
    D_Color_calc: TcxGridDBColumn;
    cxGridLevel1: TcxGridLevel;
    DetalsDS: TDataSource;
    DetalsCDS: TClientDataSet;
    DBViewAddOnDetals: TdsdDBViewAddOn;
    D_AmountSale: TcxGridDBColumn;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

initialization
  RegisterClass(TReport_IlliquidReductionPlanListForm);

end.