unit Report_Wage;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, AncestorReport, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, dxSkinsCore, dxSkinsDefaultPainters,
  dxSkinscxPCPainter, cxPCdxBarPopupMenu, cxStyles, cxCustomData, cxFilter,
  cxData, cxDataStorage, cxEdit, Data.DB, cxDBData, cxContainer, Vcl.ComCtrls,
  dxCore, cxDateUtils, dxSkinsdxBarPainter, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxCheckBox, dsdGuides, cxButtonEdit,
  dsdAddOn, ChoicePeriod, Vcl.Menus, dxBarExtItems, dxBar, cxClasses, dsdDB,
  Datasnap.DBClient, dsdAction, Vcl.ActnList, cxPropertiesStore, cxLabel,
  cxTextEdit, cxMaskEdit, cxDropDownEdit, cxCalendar, Vcl.ExtCtrls, cxGridLevel,
  cxGridCustomView, cxGrid, cxPC;

type
  TReport_WageForm = class(TAncestorReportForm)
    cxLabel4: TcxLabel;
    ceUnit: TcxButtonEdit;
    UnitGuides: TdsdGuides;
    cxLabel3: TcxLabel;
    ceModelService: TcxButtonEdit;
    ModelServiceGuides: TdsdGuides;
    cxLabel5: TcxLabel;
    cePosition: TcxButtonEdit;
    cxLabel7: TcxLabel;
    ceMember: TcxButtonEdit;
    PositionGuides: TdsdGuides;
    MemberGuides: TdsdGuides;
    chkDetailDay: TcxCheckBox;
    chkDetailModelService: TcxCheckBox;
    chkDetailModelServiceItemMaster: TcxCheckBox;
    chkDetailModelServiceItemChild: TcxCheckBox;
    colUnitName: TcxGridDBColumn;
    colPositionName: TcxGridDBColumn;
    colPositionLevelName: TcxGridDBColumn;
    colPersonalCount: TcxGridDBColumn;
    colMemberName: TcxGridDBColumn;
    colSheetWorkTime_Amount: TcxGridDBColumn;
    colServiceModelName: TcxGridDBColumn;
    colPrice: TcxGridDBColumn;
    colFromName: TcxGridDBColumn;
    colToName: TcxGridDBColumn;
    colMovementDescName: TcxGridDBColumn;
    colModelServiceItemChild_FromName: TcxGridDBColumn;
    colModelServiceItemChild_ToName: TcxGridDBColumn;
    colOperDate: TcxGridDBColumn;
    colCount_MemberInDay: TcxGridDBColumn;
    Gross: TcxGridDBColumn;
    colGrossOnOneMember: TcxGridDBColumn;
    colAmount: TcxGridDBColumn;
    colAmountOnOneMember: TcxGridDBColumn;
    actPrint1: TdsdPrintAction;
    dxBarButton1: TdxBarButton;
  private
    { Private declarations }
  public
    { Public declarations }
  end;


implementation

{$R *.dfm}
initialization
  RegisterClass(TReport_WageForm);
end.
