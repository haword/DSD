unit Report_PercentageOverdueSUN;

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
  cxButtonEdit, dsdGuides, dxBarBuiltInMenu, cxNavigator, dxSkinsCore,
  dxSkinsDefaultPainters, dxSkinscxPCPainter, dxSkinsdxBarPainter,
  cxCurrencyEdit;

type
  TReport_PercentageOverdueSUNForm = class(TAncestorReportForm)
    Id: TcxGridDBColumn;
    CountOverdue: TcxGridDBColumn;
    FormParams: TdsdFormParams;
    UnitName: TcxGridDBColumn;
    ExecuteDialog: TExecuteDialog;
    bbExecuteDialog: TdxBarButton;
    CountAll: TcxGridDBColumn;
    Procent: TcxGridDBColumn;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}
initialization

  RegisterClass(TReport_PercentageOverdueSUNForm);

end.
