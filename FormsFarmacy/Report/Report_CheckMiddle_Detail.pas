unit Report_CheckMiddle_Detail;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, AncestorReport, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, dxBarBuiltInMenu, cxStyles,
  cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator, Data.DB,
  cxDBData, cxContainer, Vcl.ComCtrls, dxCore, cxDateUtils, dsdAddOn,
  ChoicePeriod, Vcl.Menus, dxBarExtItems, dxBar, cxClasses, dsdDB,
  Datasnap.DBClient, dsdAction, Vcl.ActnList, cxPropertiesStore, cxLabel,
  cxTextEdit, cxMaskEdit, cxDropDownEdit, cxCalendar, Vcl.ExtCtrls, cxGridLevel,
  cxGridCustomView, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxGrid, cxPC, dsdGuides, cxButtonEdit, cxCurrencyEdit, dxSkinsCore,
  dxSkinsDefaultPainters, dxSkinscxPCPainter, cxPCdxBarPopupMenu,
  dxSkinsdxBarPainter, cxCheckBox, cxSplitter, cxGridChartView,
  cxGridDBChartView, dxSkinBlack, dxSkinBlue, dxSkinBlueprint, dxSkinCaramel,
  dxSkinCoffee, dxSkinDarkRoom, dxSkinDarkSide, dxSkinDevExpressDarkStyle,
  dxSkinDevExpressStyle, dxSkinFoggy, dxSkinGlassOceans, dxSkinHighContrast,
  dxSkiniMaginary, dxSkinLilian, dxSkinLiquidSky, dxSkinLondonLiquidSky,
  dxSkinMcSkin, dxSkinMoneyTwins, dxSkinOffice2007Black, dxSkinOffice2007Blue,
  dxSkinOffice2007Green, dxSkinOffice2007Pink, dxSkinOffice2007Silver,
  dxSkinOffice2010Black, dxSkinOffice2010Blue, dxSkinOffice2010Silver,
  dxSkinPumpkin, dxSkinSeven, dxSkinSevenClassic, dxSkinSharp, dxSkinSharpPlus,
  dxSkinSilver, dxSkinSpringTime, dxSkinStardust, dxSkinSummer2008,
  dxSkinTheAsphaltWorld, dxSkinValentine, dxSkinVS2010, dxSkinWhiteprint,
  dxSkinXmas2008Blue;

type
  TReport_CheckMiddle_DetailForm = class(TAncestorReportForm)
    cxLabel3: TcxLabel;
    ceUnit: TcxButtonEdit;
    rdUnit: TRefreshDispatcher;
    UnitGuides: TdsdGuides;
    dxBarButton1: TdxBarButton;
    spGet_UserUnit: TdsdStoredProc;
    actGet_UserUnit: TdsdExecStoredProc;
    actRefreshStart: TdsdDataSetRefresh;
    ExecuteDialog: TExecuteDialog;
    bbExecuteDialog: TdxBarButton;
    bbPrint: TdxBarButton;
    cbisMonth: TcxCheckBox;
    actRefreshOnDay: TdsdDataSetRefresh;
    cxSplitter1: TcxSplitter;
    cxSplitter2: TcxSplitter;
    ChildCDS: TClientDataSet;
    ChildDS: TDataSource;
    dsdDBViewAddOn1: TdsdDBViewAddOn;
    actGridToExcel1: TdsdGridToExcel;
    bb: TdxBarButton;
    grChart2: TcxGrid;
    cxGridDBChartView1: TcxGridDBChartView;
    cxGridDBChartDataGroup2: TcxGridDBChartDataGroup;
    cxGridLevel2: TcxGridLevel;
    cbisDay: TcxCheckBox;
    actRefreshOnMonth: TdsdDataSetRefresh;
    UnitName: TcxGridDBColumn;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Report_CheckMiddle_DetailForm: TReport_CheckMiddle_DetailForm;

implementation

{$R *.dfm}

initialization

  RegisterClass(TReport_CheckMiddle_DetailForm)
end.
