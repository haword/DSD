unit AdditionalGoods;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, AncestorGuides, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter,
  cxData, cxDataStorage, cxEdit, Data.DB, cxDBData, cxButtonEdit, cxSplitter,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, Vcl.Menus,
  dsdAddOn, dxBarExtItems, dxBar, cxClasses, dsdDB, Datasnap.DBClient,
  dsdAction, Vcl.ActnList, cxPropertiesStore, cxGridLevel, cxGridCustomView,
  cxGrid, cxPC, cxPCdxBarPopupMenu, cxContainer, cxLabel, cxTextEdit, cxMaskEdit,
  dsdGuides, Vcl.DBActns;

type
  TAdditionalGoodsForm = class(TAncestorGuidesForm)
    clObjectCode: TcxGridDBColumn;
    clValueData: TcxGridDBColumn;
    cxGrid1: TcxGrid;
    cxGridDBTableView2: TcxGridDBTableView;
    clValueData1: TcxGridDBColumn;
    cxGridLevel2: TcxGridLevel;
    cxSplitter1: TcxSplitter;
    cxGrid2: TcxGrid;
    cxGridDBTableView3: TcxGridDBTableView;
    clValueData2: TcxGridDBColumn;
    cxGridLevel3: TcxGridLevel;
    cxSplitter2: TcxSplitter;
    ClientDS: TDataSource;
    spAdditionalGoods: TdsdStoredProc;
    ClientCDS: TClientDataSet;
    ClientMasterDS: TDataSource;
    spAdditioanlGoodsClient: TdsdStoredProc;
    ClientMasterCDS: TClientDataSet;
    RetailGuides: TdsdGuides;
    AdditionalGoodsDBViewAddOn: TdsdDBViewAddOn;
    AdditionalGoodsClientDBViewAddOn: TdsdDBViewAddOn;
    actGoodsChoice: TOpenChoiceForm;
    actInsertUpdateLink: TdsdUpdateDataSet;
    spInsertUpdateGoodsLink: TdsdStoredProc;
    mactInsert: TMultiAction;
    InsertRecord: TInsertRecord;
    DataSetPost: TDataSetPost;
    DataSetCancel: TDataSetCancel;
    actDeleteLink: TdsdExecStoredProc;
    mactDeleteLink: TMultiAction;
    DataSetDelete: TDataSetDelete;
    spDeleteLink: TdsdStoredProc;
    PopupMenu1: TPopupMenu;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    MenuItem5: TMenuItem;
    MenuItem6: TMenuItem;
    MenuItem7: TMenuItem;
    MenuItem8: TMenuItem;
    GridAll: TcxGrid;
    GridAllDBTableView: TcxGridDBTableView;
    colId: TcxGridDBColumn;
    GridAllLevel1: TcxGridLevel;
    cxSplitter3: TcxSplitter;
    dsdDBViewAddOn1: TdsdDBViewAddOn;
    cdsAll: TClientDataSet;
    spAll: TdsdStoredProc;
    dsAll: TDataSource;
    colGoodsMainId: TcxGridDBColumn;
    colGoodsMainCode: TcxGridDBColumn;
    colGoodsMainName: TcxGridDBColumn;
    colGoodsId: TcxGridDBColumn;
    colGoodsCode: TcxGridDBColumn;
    colGoodsName: TcxGridDBColumn;
    colGoodsGroupName: TcxGridDBColumn;
    colNDSKindName: TcxGridDBColumn;
    cxSplitter4: TcxSplitter;
    cxSplitter5: TcxSplitter;
  private
    { Private declarations }
  public
    { Public declarations }
  end;


implementation

{$R *.dfm}
initialization
  RegisterClass(TAdditionalGoodsForm);

end.
