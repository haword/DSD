unit MobileTariff2;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, ParentForm, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxStyles, 
  dxSkinscxPCPainter, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, Data.DB, cxDBData, cxCheckBox, dxSkinsdxBarPainter,
  dsdAddOn, dsdDB, dsdAction, Vcl.ActnList, dxBarExtItems, dxBar, cxClasses,
  cxPropertiesStore, Datasnap.DBClient, cxGridLevel, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGridCustomView, cxGrid, cxSpinEdit,
  Vcl.Menus, dxSkinsCore, dxSkinsDefaultPainters;

type
  TMobileTariff2Form = class(TParentForm)
    cxGrid: TcxGrid;
    cxGridDBTableView: TcxGridDBTableView;
    colInetCost: TcxGridDBColumn;
    colSMSCost: TcxGridDBColumn;
    colMonthly: TcxGridDBColumn;
    cxGridLevel: TcxGridLevel;
    DataSource: TDataSource;
    ClientDataSet: TClientDataSet;
    cxPropertiesStore: TcxPropertiesStore;
    dxBarManager: TdxBarManager;
    dxBarManagerBar1: TdxBar;
    bbRefresh: TdxBarButton;
    bbInsert: TdxBarButton;
    bbEdit: TdxBarButton;
    bbSetErased: TdxBarButton;
    bbSetUnErased: TdxBarButton;
    bbGridToExcel: TdxBarButton;
    dxBarStatic1: TdxBarStatic;
    bbChoiceGuides: TdxBarButton;
    ActionList: TActionList;
    actRefresh: TdsdDataSetRefresh;
    dsdSetErased: TdsdUpdateErased;
    dsdSetUnErased: TdsdUpdateErased;
    dsdChoiceGuides: TdsdChoiceGuides;
    dsdGridToExcel1: TdsdGridToExcel;
    dsdStoredProc: TdsdStoredProc;
    dsdUserSettingsStorageAddOn: TdsdUserSettingsStorageAddOn;
    spErasedUnErased: TdsdStoredProc;
    dsdDBViewAddOn: TdsdDBViewAddOn;
    colMinuteCost: TcxGridDBColumn;
    colID: TcxGridDBColumn;
    colPocketInet: TcxGridDBColumn;
    colPocketSMS: TcxGridDBColumn;
    colPocketMinutes: TcxGridDBColumn;
    actShowAll: TBooleanStoredProcAction;
    bbShowAll: TdxBarButton;
    ProtocolOpenForm: TdsdOpenForm;
    bbProtocolOpenForm: TdxBarButton;
    colTariffName: TcxGridDBColumn;
    actInsert: TdsdInsertUpdateAction;
    actUpdate: TdsdInsertUpdateAction;
    colErased: TcxGridDBColumn;
    colComms: TcxGridDBColumn;
    pmGrid: TPopupMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation
{$R *.dfm}
initialization
  RegisterClass(TMobileTariff2Form);
end.