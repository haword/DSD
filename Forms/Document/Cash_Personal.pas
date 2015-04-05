unit Cash_Personal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, AncestorDocument, cxGraphics,
  cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxPCdxBarPopupMenu, cxStyles,
  cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, Data.DB, cxDBData,
  cxContainer, Vcl.ComCtrls, dxCore, cxDateUtils, dxSkinsdxBarPainter, dsdAddOn,
  dsdGuides, dsdDB, Vcl.Menus, dxBarExtItems, dxBar, cxClasses,
  Datasnap.DBClient, dsdAction, Vcl.ActnList, cxPropertiesStore, cxButtonEdit,
  cxMaskEdit, cxDropDownEdit, cxCalendar, cxLabel, cxTextEdit, Vcl.ExtCtrls,
  cxGridLevel, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxGridCustomView, cxGrid, cxPC, cxCurrencyEdit, cxCheckBox, frxClass, frxDBSet,
  dxSkinsCore, dxSkinsDefaultPainters, dxSkinscxPCPainter;

type
  TCash_PersonalForm = class(TAncestorDocumentForm)
    INN: TcxGridDBColumn;
    PersonalName: TcxGridDBColumn;
    PositionName: TcxGridDBColumn;
    UnitName: TcxGridDBColumn;
    Amount: TcxGridDBColumn;
    spSelectPrint: TdsdStoredProc;
    N2: TMenuItem;
    N3: TMenuItem;
    RefreshDispatcher: TRefreshDispatcher;
    actRefreshPrice: TdsdDataSetRefresh;
    PrintHeaderCDS: TClientDataSet;
    bbPrintTax: TdxBarButton;
    PrintItemsCDS: TClientDataSet;
    bbTax: TdxBarButton;
    bbPrintTax_Client: TdxBarButton;
    bbPrint_Bill: TdxBarButton;
    PrintItemsSverkaCDS: TClientDataSet;
    Comment: TcxGridDBColumn;
    InfoMoneyName: TcxGridDBColumn;
    deServiceDate: TcxDateEdit;
    cxLabel6: TcxLabel;
    edComment: TcxTextEdit;
    cxLabel12: TcxLabel;
    Amount_avance: TcxGridDBColumn;
    cePersonalServiceList: TcxButtonEdit;
    GuidesPersonalServiceList: TdsdGuides;
    cxLabel3: TcxLabel;
    UnitCode: TcxGridDBColumn;
    PersonalCode: TcxGridDBColumn;
    isMain: TcxGridDBColumn;
    isOfficial: TcxGridDBColumn;
    SummToPay_cash: TcxGridDBColumn;
    edDocumentPersonalService: TcxButtonEdit;
    GuidesPersonalServiceJournal: TdsdGuides;
    cxLabel4: TcxLabel;
    cxLabel5: TcxLabel;
    ceCash: TcxButtonEdit;
    GuidesCash: TdsdGuides;
    cxLabel9: TcxLabel;
    ceMember: TcxButtonEdit;
    GuidesMember: TdsdGuides;
    SummService: TcxGridDBColumn;
    SummRemains: TcxGridDBColumn;
    spUpdateAmountParam: TdsdStoredProc;
    actUpdateAmountParam: TdsdExecStoredProc;
    bbUpdateAmountParam: TdxBarButton;
    MultiAction1: TMultiAction;
    bbMultiAction1: TdxBarButton;
    SummToPay: TcxGridDBColumn;
    SummCard: TcxGridDBColumn;
    Amount_service: TcxGridDBColumn;
    InfoMoneyCode: TcxGridDBColumn;
    InfoMoneyName_all: TcxGridDBColumn;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

initialization
  RegisterClass(TCash_PersonalForm);

end.
