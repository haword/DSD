unit dbMovementItemTest;

interface
uses TestFramework, dbObjectTest, DB, dbTest, Classes;

type

  TMovementItemTest = class (TObjectTest)
  protected
    procedure InsertUpdateInList(Id: integer); override;
    procedure DeleteRecord(Id: Integer); override;
  public
    procedure Delete(Id: Integer); override;
  end;

  TdbMovementItemTest = class (TdbTest)
  protected
    // �������������� ������ ��� ������������
    procedure SetUp; override;
    // ���������� ������ ��� ������������
    procedure TearDown; override;
  published
    procedure MovementItemIncomeTest;
    procedure MovementItemSendOnPriceTest;
    procedure MovementItemSaleTest;
    procedure MovementItemReturnOutTest;
    procedure MovementItemProductionUnionTest;
    procedure MovementItemZakazExternalTest;
    procedure MovementItemZakazInternalTest;
  end;

  TMovementItemIncomeTest = class(TMovementItemTest)
  private
    function InsertDefault: integer; override;
  protected
    procedure SetDataSetParam; override;
  public
    function InsertUpdateMovementItemIncome
      (Id, MovementId, GoodsId: Integer;
       Amount, AmountPartner, AmountPacker, Price, CountForPrice, LiveWeight, HeadCount: double;
       PartionGoods:String; GoodsKindId, AssetId: Integer): integer;
    constructor Create; override;
  end;

  TMovementItemProductionUnionMasterTest = class(TMovementItemTest)
  private
    function InsertDefault: integer; override;
  public
    function GetDataSet: TDataSet; override;
    function InsertUpdateMovementProductionUnionMaster
      (Id, MovementId, GoodsId: Integer;
       Amount: double; PartionClose: Boolean;
       Count, RealWeight, CuterCount: double;  PartionGoods, Comment: String;
       GoodsKindId, ReceiptId: Integer): integer;
    constructor Create; override;
  end;

  TMovementItemProductionUnionChildTest = class(TMovementItemTest)
  private
    MovementItem_InId: INTEGER;
    function InsertDefault: integer; override;
  protected
    procedure SetDataSetParam; override;
  public
    function GetDataSet: TDataSet; override;
    function InsertUpdateMovementProductionUnionChild
      (Id, MovementId, GoodsId: Integer;
       Amount: double; ParentId: integer;
       AmountReceipt: double;  PartionGoodsDate: TDateTime;
       PartionGoods, Comment: string; GoodsKindId: integer): integer;
    constructor Create; override;
  end;

  TMovementItemSendOnPriceTest = class(TMovementItemTest)
  private
    function InsertDefault: integer; override;
  protected
    procedure SetDataSetParam; override;
  public
    function InsertUpdateMovementItemSendOnPrice
      (Id, MovementId, GoodsId: Integer;
       Amount, AmountPartner, AmountChangePercent, ChangePercentAmount, Price,
       CountForPrice, HeadCount: double;
       PartionGoods:String; GoodsKindId: Integer): integer;
    constructor Create; override;
  end;

  TMovementItemSaleTest = class(TMovementItemTest)
  private
    function InsertDefault: integer; override;
  protected
    procedure SetDataSetParam; override;
  public
    function InsertUpdateMovementItemSale
      (Id, MovementId, GoodsId: Integer;
       Amount, AmountPartner, AmountChangePercent, ChangePercentAmount,
       Price, CountForPrice, HeadCount: double;
       PartionGoods:String; GoodsKindId, AssetId: Integer): integer;
    constructor Create; override;
  end;

  TMovementItemReturnOutTest = class(TMovementItemTest)
  private
    function InsertDefault: integer; override;
  protected
    procedure SetDataSetParam; override;
  public
    function InsertUpdateMovementItemReturnOut
      (Id, MovementId, GoodsId: Integer;
       Amount, AmountPartner, Price, CountForPrice, HeadCount: double;
       PartionGoods:String; GoodsKindId, AssetId: Integer): integer;
    constructor Create; override;
  end;

  TMovementItemZakazExternalTest = class(TMovementItemTest)
  private
    function InsertDefault: integer; override;
  protected
    procedure SetDataSetParam; override;
  public
    function InsertUpdateMovementItemZakazExternal
      (Id, MovementId, GoodsId: Integer;
       Amount, AmountSecond: double;
       GoodsKindId: Integer): integer;
    constructor Create; override;
  end;

  TMovementItemZakazInternalTest = class(TMovementItemTest)
  private
    function InsertDefault: integer; override;
  protected
    procedure SetDataSetParam; override;
  public
    function InsertUpdateMovementItemZakazInternal
      (Id, MovementId, GoodsId: Integer;
       Amount, AmountSecond: double;
       GoodsKindId: Integer): integer;
    constructor Create; override;
  end;

  var
      // ������ ����������� Id
    InsertedIdMovementItemList: TStringList;

implementation

uses Storage, SysUtils, dbMovementTest, DBClient, dsdDB, CommonData, Authentication;
{ TdbMovementItemTest }
{------------------------------------------------------------------------------}
procedure TdbMovementItemTest.TearDown;
begin
  inherited;
  if Assigned(InsertedIdMovementItemList) then
     with TMovementItemTest.Create do
       while InsertedIdMovementItemList.Count > 0 do
          Delete(StrToInt(InsertedIdMovementItemList[0]));

  if Assigned(InsertedIdMovementList) then
     with TMovementTest.Create do
       while InsertedIdMovementList.Count > 0 do
          Delete(StrToInt(InsertedIdMovementList[0]));

  if Assigned(InsertedIdObjectList) then
     with TObjectTest.Create do
       while InsertedIdObjectList.Count > 0 do
          Delete(StrToInt(InsertedIdObjectList[0]));
end;

{------------------------------------------------------------------------------}
procedure TdbMovementItemTest.MovementItemIncomeTest;
var
  MovementItemIncome: TMovementItemIncomeTest;
  Id: Integer;
begin
  MovementItemIncome := TMovementItemIncomeTest.Create;
  Id := MovementItemIncome.InsertDefault;
  // �������� ���������
  try
  // ��������������
  finally
    // ��������
    MovementItemIncome.Delete(Id);
  end;
end;

procedure TdbMovementItemTest.MovementItemSendOnPriceTest;
var
  MovementItemSendOnPrice: TMovementItemSendOnPriceTest;
  Id: Integer;
begin
  MovementItemSendOnPrice := TMovementItemSendOnPriceTest.Create;
  Id := MovementItemSendOnPrice.InsertDefault;
  // �������� ���������
  try
  // ��������������
  finally
    // ��������
    MovementItemSendOnPrice.Delete(Id);
  end;
end;

procedure TdbMovementItemTest.MovementItemSaleTest;
var
  MovementItemSale: TMovementItemSaleTest;
  Id: Integer;
begin
  MovementItemSale := TMovementItemSaleTest.Create;
  Id := MovementItemSale.InsertDefault;
  // �������� ���������
  try
  // ��������������
  finally
    // ��������
    MovementItemSale.Delete(Id);
  end;
end;

procedure TdbMovementItemTest.MovementItemReturnOutTest;
var
  MovementItemReturnOut: TMovementItemReturnOutTest;
  Id: Integer;
begin
  MovementItemReturnOut := TMovementItemReturnOutTest.Create;
  Id := MovementItemReturnOut.InsertDefault;
  // �������� ���������
  try
  // ��������������
  finally
    // ��������
    MovementItemReturnOut.Delete(Id);
  end;
end;

procedure TdbMovementItemTest.MovementItemProductionUnionTest;
var
  MovementItemProductionUnionChild: TMovementItemProductionUnionChildTest;
  Id: Integer;
begin
  MovementItemProductionUnionChild := TMovementItemProductionUnionChildTest.Create;
  Id := MovementItemProductionUnionChild.InsertDefault;
  // �������� ���������
  MovementItemProductionUnionChild.GetDataSet;
  try
  // ��������������
  finally
    // ��������
    MovementItemProductionUnionChild.Delete(Id);
    MovementItemProductionUnionChild.Delete(MovementItemProductionUnionChild.MovementItem_InId);
  end;
end;

procedure TdbMovementItemTest.MovementItemZakazExternalTest;
var
  MovementItemZakazExternal: TMovementItemZakazExternalTest;
  Id: Integer;
begin
(*  MovementItemZakazExternal := TMovementItemZakazExternalTest.Create;
  Id := MovementItemZakazExternal.InsertDefault;
  // �������� ���������
  try
  // ��������������
  finally
    // ��������
    MovementItemZakazExternal.Delete(Id);
  end;  *)
end;

procedure TdbMovementItemTest.MovementItemZakazInternalTest;
var
  MovementItemZakazInternal: TMovementItemZakazInternalTest;
  Id: Integer;
begin
(*  MovementItemZakazInternal := TMovementItemZakazInternalTest.Create;
  Id := MovementItemZakazInternal.InsertDefault;
  // �������� ���������
  try
  // ��������������
  finally
    // ��������
    MovementItemZakazInternal.Delete(Id);
  end;     *)
end;

procedure TdbMovementItemTest.SetUp;
begin
  inherited;
  TAuthentication.CheckLogin(TStorageFactory.GetStorage, '�����', '�����', gc_User);
end;
{------------------------------------------------------------------------------}
{ TMovementIncome }

constructor TMovementItemIncomeTest.Create;
begin
  inherited;
  spInsertUpdate := 'gpInsertUpdate_MovementItem_Income';
  spSelect := 'gpSelect_MovementItem_Income';
  spGet := 'gpGet_MovementItem_Income';
end;

function TMovementItemIncomeTest.InsertDefault: integer;
var Id, MovementId, GoodsId: Integer;
    Amount, AmountPartner, AmountPacker, Price, CountForPrice, LiveWeight, HeadCount: double;
    PartionGoods:String;
    GoodsKindId,AssetId: Integer;
begin
  Id:=0;
  MovementId:= TMovementIncomeTest.Create.GetDefault;
  GoodsId:=TGoodsTest.Create.GetDefault;
  Amount:=10;
  AmountPartner:=11;
  AmountPacker:=12;
  Price:=2.34;
  CountForPrice:=1;
  LiveWeight:=505.67;
  HeadCount:=5;
  PartionGoods:='';
  GoodsKindId:=0;
  AssetId:=0;
  //
  result := InsertUpdateMovementItemIncome(Id, MovementId, GoodsId,
                                           Amount, AmountPartner, AmountPacker, Price, CountForPrice, LiveWeight, HeadCount,
                                           PartionGoods,
                                           GoodsKindId,AssetId);
end;

function TMovementItemIncomeTest.InsertUpdateMovementItemIncome
  (Id, MovementId, GoodsId: Integer;
       Amount, AmountPartner, AmountPacker, Price, CountForPrice, LiveWeight, HeadCount: double;
       PartionGoods:String;GoodsKindId,AssetId: Integer): integer;
begin
  FParams.Clear;
  FParams.AddParam('ioId', ftInteger, ptInputOutput, Id);
  FParams.AddParam('inMovementId', ftInteger, ptInput, MovementId);
  FParams.AddParam('inGoodsId', ftInteger, ptInput, GoodsId);
  FParams.AddParam('inAmount', ftFloat, ptInput, Amount);
  FParams.AddParam('inAmountPartner', ftFloat, ptInput, AmountPartner);
  FParams.AddParam('inAmountPacker', ftFloat, ptInput, AmountPacker);
  FParams.AddParam('inPrice', ftFloat, ptInput, Price);
  FParams.AddParam('inCountForPrice', ftFloat, ptInput, CountForPrice);
  FParams.AddParam('inLiveWeight', ftFloat, ptInput, LiveWeight);
  FParams.AddParam('inHeadCount', ftFloat, ptInput, HeadCount);
  FParams.AddParam('inPartionGoods', ftString, ptInput, PartionGoods);
  FParams.AddParam('inGoodsKindId', ftInteger, ptInput, GoodsKindId);
  FParams.AddParam('inAssetId', ftInteger, ptInput, AssetId);
  result := InsertUpdate(FParams);
end;

procedure TMovementItemIncomeTest.SetDataSetParam;
begin
  inherited;
  FParams.AddParam('inMovementId', ftInteger, ptInput, TMovementIncomeTest.Create.GetDefault);
  FParams.AddParam('inShowAll', ftBoolean, ptInput, true);
end;

{ TMovementSSendOnPrice }
constructor TMovementItemSendOnPriceTest.Create;
begin
  inherited;
  spInsertUpdate := 'gpInsertUpdate_MovementItem_SendOnPrice';
  spSelect := 'gpSelect_MovementItem_SendOnPrice';
  spGet := 'gpGet_MovementItem_SendOnPrice';
end;

function TMovementItemSendOnPriceTest.InsertDefault: integer;
var Id, MovementId, GoodsId: Integer;
    Amount, AmountPartner, Price, CountForPrice, HeadCount,
    AmountChangePercent, ChangePercentAmount: double;
    PartionGoods:String;
    GoodsKindId: Integer;
begin
  Id := 0;
  MovementId := TMovementSendOnPriceTest.Create.GetDefault;
  GoodsId := TGoodsTest.Create.GetDefault;
  Amount := 10;
  AmountPartner := 11;
  Price := 2.34;
  CountForPrice := 1;
  HeadCount := 5;
  PartionGoods := '';
  GoodsKindId := 0;
  AmountChangePercent := 0;
  ChangePercentAmount := 0;
  //
  result := InsertUpdateMovementItemSendOnPrice(Id, MovementId, GoodsId,
                              Amount, AmountPartner, AmountChangePercent, ChangePercentAmount,
                              Price, CountForPrice, HeadCount,
                              PartionGoods, GoodsKindId);
end;

function TMovementItemSendOnPriceTest.InsertUpdateMovementItemSendOnPrice
  (Id, MovementId, GoodsId: Integer;
       Amount, AmountPartner, AmountChangePercent, ChangePercentAmount, Price,
       CountForPrice, HeadCount: double;
       PartionGoods:String;GoodsKindId: Integer): integer;
begin
  FParams.Clear;
  FParams.AddParam('ioId', ftInteger, ptInputOutput, Id);
  FParams.AddParam('inMovementId', ftInteger, ptInput, MovementId);
  FParams.AddParam('inGoodsId', ftInteger, ptInput, GoodsId);
  FParams.AddParam('inAmount', ftFloat, ptInput, Amount);
  FParams.AddParam('inAmountPartner', ftFloat, ptInput, AmountPartner);
  FParams.AddParam('inAmountChangePercent', ftFloat, ptInput, AmountChangePercent);
  FParams.AddParam('inChangePercentAmount', ftFloat, ptInput, ChangePercentAmount);
  FParams.AddParam('inPrice', ftFloat, ptInput, Price);
  FParams.AddParam('inCountForPrice', ftFloat, ptInput, CountForPrice);
  FParams.AddParam('inHeadCount', ftFloat, ptInput, HeadCount);
  FParams.AddParam('inPartionGoods', ftString, ptInput, PartionGoods);
  FParams.AddParam('inGoodsKindId', ftInteger, ptInput, GoodsKindId);
  result := InsertUpdate(FParams);
end;

procedure TMovementItemSendOnPriceTest.SetDataSetParam;
begin
  inherited;
  FParams.AddParam('inMovementId', ftInteger, ptInput, TMovementSendOnPriceTest.Create.GetDefault);
  FParams.AddParam('inShowAll', ftBoolean, ptInput, true);
end;

{ TMovementSale }
constructor TMovementItemSaleTest.Create;
begin
  inherited;
  spInsertUpdate := 'gpInsertUpdate_MovementItem_Sale';
  spSelect := 'gpSelect_MovementItem_Sale';
  spGet := 'gpGet_MovementItem_Sale';
end;

function TMovementItemSaleTest.InsertDefault: integer;
var Id, MovementId, GoodsId: Integer;
    Amount, AmountPartner, Price, CountForPrice,
    HeadCount, AmountChangePercent, ChangePercentAmount: double;
    PartionGoods:String;
    GoodsKindId, AssetId: Integer;
begin
  Id:=0;
  MovementId:= TMovementSaleTest.Create.GetDefault;
  GoodsId:=TGoodsTest.Create.GetDefault;
  Amount:=10;
  AmountPartner:=11;
  ChangePercentAmount := 10;
  Price:=2.34;
  CountForPrice:=1;
  HeadCount:=5;
  PartionGoods:='';
  GoodsKindId:=0;
  AssetId:=0;
  AmountChangePercent := 0;
  //
  result := InsertUpdateMovementItemSale(Id, MovementId, GoodsId,
                              Amount, AmountPartner, AmountChangePercent, ChangePercentAmount,
                              Price, CountForPrice, HeadCount,
                              PartionGoods, GoodsKindId, AssetId);
end;

function TMovementItemSaleTest.InsertUpdateMovementItemSale
  (Id, MovementId, GoodsId: Integer;
       Amount, AmountPartner, AmountChangePercent, ChangePercentAmount, Price,
       CountForPrice, HeadCount: double;
       PartionGoods:String; GoodsKindId, AssetId: Integer): integer;
begin
  FParams.Clear;
  FParams.AddParam('ioId', ftInteger, ptInputOutput, Id);
  FParams.AddParam('inMovementId', ftInteger, ptInput, MovementId);
  FParams.AddParam('inGoodsId', ftInteger, ptInput, GoodsId);
  FParams.AddParam('inAmount', ftFloat, ptInput, Amount);
  FParams.AddParam('inAmountPartner', ftFloat, ptInput, AmountPartner);
  FParams.AddParam('inAmountChangePercent', ftFloat, ptInput, AmountChangePercent);
  FParams.AddParam('inChangePercentAmount', ftFloat, ptInput, ChangePercentAmount);
  FParams.AddParam('inPrice', ftFloat, ptInput, Price);
  FParams.AddParam('inCountForPrice', ftFloat, ptInput, CountForPrice);
  FParams.AddParam('inHeadCount', ftFloat, ptInput, HeadCount);
  FParams.AddParam('inPartionGoods', ftString, ptInput, PartionGoods);
  FParams.AddParam('inGoodsKindId', ftInteger, ptInput, GoodsKindId);
  FParams.AddParam('inAssetId', ftInteger, ptInput, AssetId);
  result := InsertUpdate(FParams);
end;

procedure TMovementItemSaleTest.SetDataSetParam;
begin
  inherited;
  FParams.AddParam('inMovementId', ftInteger, ptInput, TMovementSaleTest.Create.GetDefault);
  FParams.AddParam('inShowAll', ftBoolean, ptInput, true);
end;

{ TMovementReturnOut }
constructor TMovementItemReturnOutTest.Create;
begin
  inherited;
  spInsertUpdate := 'gpInsertUpdate_MovementItem_ReturnOut';
  spSelect := 'gpSelect_MovementItem_ReturnOut';
  spGet := 'gpGet_MovementItem_ReturnOut';
end;

function TMovementItemReturnOutTest.InsertDefault: integer;
var Id, MovementId, GoodsId: Integer;
    Amount, AmountPartner, Price, CountForPrice, HeadCount: double;
    PartionGoods:String;
    GoodsKindId, AssetId: Integer;
begin
  Id:=0;
  MovementId:= TMovementReturnOutTest.Create.GetDefault;
  GoodsId:=TGoodsTest.Create.GetDefault;
  Amount:=10;
  AmountPartner:=11;
  Price:=2.34;
  CountForPrice:=1;
  HeadCount:=5;
  PartionGoods:='';
  GoodsKindId:=0;
  AssetId:=0;
  //
  result := InsertUpdateMovementItemReturnOut(Id, MovementId, GoodsId,
                              Amount, AmountPartner, Price, CountForPrice, HeadCount,
                              PartionGoods, GoodsKindId, AssetId);
end;

function TMovementItemReturnOutTest.InsertUpdateMovementItemReturnOut
  (Id, MovementId, GoodsId: Integer;
       Amount, AmountPartner, Price, CountForPrice, HeadCount: double;
       PartionGoods:String; GoodsKindId, AssetId: Integer): integer;
begin
  FParams.Clear;
  FParams.AddParam('ioId', ftInteger, ptInputOutput, Id);
  FParams.AddParam('inMovementId', ftInteger, ptInput, MovementId);
  FParams.AddParam('inGoodsId', ftInteger, ptInput, GoodsId);
  FParams.AddParam('inAmount', ftFloat, ptInput, Amount);
  FParams.AddParam('inAmountPartner', ftFloat, ptInput, AmountPartner);
  FParams.AddParam('inPrice', ftFloat, ptInput, Price);
  FParams.AddParam('inCountForPrice', ftFloat, ptInput, CountForPrice);
  FParams.AddParam('inHeadCount', ftFloat, ptInput, HeadCount);
  FParams.AddParam('inPartionGoods', ftString, ptInput, PartionGoods);
  FParams.AddParam('inGoodsKindId', ftInteger, ptInput, GoodsKindId);
  FParams.AddParam('inAssetId', ftInteger, ptInput, AssetId);
  result := InsertUpdate(FParams);
end;

procedure TMovementItemReturnOutTest.SetDataSetParam;
begin
  inherited;
  FParams.AddParam('inMovementId', ftInteger, ptInput, TMovementReturnOutTest.Create.GetDefault);
  FParams.AddParam('inShowAll', ftBoolean, ptInput, true);
end;


{ TMovementItemProductionUnionMasterTest }

constructor TMovementItemProductionUnionMasterTest.Create;
begin
  inherited;
  spInsertUpdate := 'gpInsertUpdate_MI_ProductionUnion_Master';
  spSelect := 'gpSelect_MI_ProductionUnion';
  spGet := '';
end;

function TMovementItemProductionUnionMasterTest.GetDataSet: TDataSet;
begin

end;

function TMovementItemProductionUnionMasterTest.InsertDefault: integer;
var MovementId, GoodsKindId, GoodsId: Integer;
begin
  MovementId := TMovementIncomeTest.Create.GetDefault;
  GoodsId := TGoodsTest.Create.GetDefault;
  GoodsKindId:= TGoodsKindTest.Create.GetDefault;

  result := InsertUpdateMovementProductionUnionMaster(0, MovementId, GoodsId,
  10, false, 2.34, 505.67, 1, '������', '������', GoodsKindId, 0);
end;

function TMovementItemProductionUnionMasterTest.InsertUpdateMovementProductionUnionMaster(
  Id, MovementId, GoodsId: Integer; Amount: double; PartionClose: Boolean;
  Count, RealWeight, CuterCount: double; PartionGoods, Comment: String;
  GoodsKindId, ReceiptId: Integer): integer;
begin
  FParams.Clear;
  FParams.AddParam('ioId', ftInteger, ptInputOutput, Id);
  FParams.AddParam('inMovementId', ftInteger, ptInput, MovementId);
  FParams.AddParam('inGoodsId', ftInteger, ptInput, GoodsId);
  FParams.AddParam('inAmount', ftFloat, ptInput, Amount);
  FParams.AddParam('inPartionClose', ftBoolean, ptInput, PartionClose);
  FParams.AddParam('inCount', ftFloat, ptInput, Count);
  FParams.AddParam('inRealWeight', ftFloat, ptInput, RealWeight);
  FParams.AddParam('inCuterCount', ftFloat, ptInput, CuterCount);
  FParams.AddParam('inPartionGoods', ftString, ptInput, PartionGoods);
  FParams.AddParam('inComment', ftString, ptInput, Comment);
  FParams.AddParam('inGoodsKindId', ftInteger, ptInput, GoodsKindId);
  FParams.AddParam('inReceiptId', ftInteger, ptInput, ReceiptId);
  result := InsertUpdate(FParams);
end;

{ TMovementItemProductionUnionChildTest }

constructor TMovementItemProductionUnionChildTest.Create;
begin
  inherited;
  spInsertUpdate := 'gpInsertUpdate_MI_ProductionUnion_Child';
  spSelect := 'gpSelect_MI_ProductionUnion';
  spGet := '';
end;

function TMovementItemProductionUnionChildTest.GetDataSet: TDataSet;
begin
  with FdsdStoredProc do begin
    if (DataSets.Count = 0) or not Assigned(DataSets[0].DataSet) then
       DataSets.Add.DataSet := TClientDataSet.Create(nil);
    if (DataSets.Count = 1) or not Assigned(DataSets[1].DataSet) then
       DataSets.Add.DataSet := TClientDataSet.Create(nil);
    StoredProcName := spSelect;
    OutputType := otMultiDataSet;
    FParams.Clear;
    SetDataSetParam;
    Params.Assign(FParams);
    Execute;
    result := DataSets[1].DataSet;
  end;
end;

function TMovementItemProductionUnionChildTest.InsertDefault: integer;
var MovementId, GoodsId, GoodsKindId : Integer;
begin
  MovementId := TMovementIncomeTest.Create.GetDefault;
  GoodsId := TGoodsTest.Create.GetDefault;
  MovementItem_InId := TMovementItemProductionUnionMasterTest.Create.GetDefault;
  GoodsKindId:= TGoodsKindTest.Create.GetDefault;

  result := InsertUpdateMovementProductionUnionChild(0, MovementId, GoodsId, 10,
  MovementItem_InId, 10, Date,'������', 'Comment', GoodsKindId);
end;

function TMovementItemProductionUnionChildTest.InsertUpdateMovementProductionUnionChild(
  Id, MovementId, GoodsId: Integer; Amount: double; ParentId: integer;
  AmountReceipt: double;  PartionGoodsDate: TDateTime; PartionGoods, Comment: string;
  GoodsKindId: Integer): integer;
begin
  FParams.Clear;
  FParams.AddParam('ioId', ftInteger, ptInputOutput, Id);
  FParams.AddParam('inMovementId', ftInteger, ptInput, MovementId);
  FParams.AddParam('inGoodsId', ftInteger, ptInput, GoodsId);
  FParams.AddParam('inAmount', ftFloat, ptInput, Amount);
  FParams.AddParam('inParentId', ftInteger, ptInput, ParentId);
  FParams.AddParam('inAmountReceipt', ftFloat, ptInput, AmountReceipt);
  FParams.AddParam('inPartionGoodsDate', ftDateTime, ptInput, PartionGoodsDate);
  FParams.AddParam('inPartionGoods', ftString, ptInput, PartionGoods);
  FParams.AddParam('inComment', ftString, ptInput, Comment);
  FParams.AddParam('inGoodsKindId', ftInteger, ptInput, GoodsKindId);
  result := InsertUpdate(FParams);
end;

procedure TMovementItemProductionUnionChildTest.SetDataSetParam;
begin
  inherited;
  FParams.AddParam('inMovementId', ftInteger, ptInput, TMovementProductionUnionTest.Create.GetDefault);
  FParams.AddParam('inShowAll', ftBoolean, ptInput, true);
end;


{ TMovementZakazExternal }
constructor TMovementItemZakazExternalTest.Create;
begin
  inherited;
  spInsertUpdate := 'gpInsertUpdate_MovementItem_ZakazExternal';
  spSelect := 'gpSelect_MovementItem_ZakazExternal';
  spGet := 'gpGet_MovementItem_ZakazExternal';
end;

function TMovementItemZakazExternalTest.InsertDefault: integer;
var Id, MovementId, GoodsId: Integer;
    Amount, AmountSecond: double;
    GoodsKindId: Integer;
begin
{  Id:=0;
  MovementId:= TMovementZakazExternalTest.Create.GetDefault;
  GoodsId:=TGoodsTest.Create.GetDefault;
  Amount:=10;
  AmountSecond:=11;
  GoodsKindId:=0;
  //
  result := InsertUpdateMovementItemZakazExternal(Id, MovementId, GoodsId,
                              Amount, AmountSecond, GoodsKindId);}
end;

function TMovementItemZakazExternalTest.InsertUpdateMovementItemZakazExternal
  (Id, MovementId, GoodsId: Integer;
       Amount, AmountSecond: double;
       GoodsKindId: Integer): integer;
begin
  FParams.Clear;
  FParams.AddParam('ioId', ftInteger, ptInputOutput, Id);
  FParams.AddParam('inMovementId', ftInteger, ptInput, MovementId);
  FParams.AddParam('inGoodsId', ftInteger, ptInput, GoodsId);
  FParams.AddParam('inAmount', ftFloat, ptInput, Amount);
  FParams.AddParam('inAmountSecond', ftFloat, ptInput, AmountSecond);
  FParams.AddParam('inGoodsKindId', ftInteger, ptInput, GoodsKindId);

  result := InsertUpdate(FParams);
end;

procedure TMovementItemZakazExternalTest.SetDataSetParam;
begin
  inherited;
//  FParams.AddParam('inMovementId', ftInteger, ptInput, TMovementZakazExternalTest.Create.GetDefault);
  FParams.AddParam('inShowAll', ftBoolean, ptInput, true);
end;

{ TMovementZakazInternal }
constructor TMovementItemZakazInternalTest.Create;
begin
  inherited;
  spInsertUpdate := 'gpInsertUpdate_MovementItem_ZakazInternal';
  spSelect := 'gpSelect_MovementItem_ZakazInternal';
  spGet := 'gpGet_MovementItem_ZakazInternal';
end;

function TMovementItemZakazInternalTest.InsertDefault: integer;
var Id, MovementId, GoodsId: Integer;
    Amount, AmountSecond: double;
    GoodsKindId: Integer;
begin
{  Id:=0;
  MovementId:= TMovementZakazInternalTest.Create.GetDefault;
  GoodsId:=TGoodsTest.Create.GetDefault;
  Amount:=10;
  AmountSecond:=11;
  GoodsKindId:=0;
  //
  result := InsertUpdateMovementItemZakazInternal(Id, MovementId, GoodsId,
                              Amount, AmountSecond, GoodsKindId);}
end;

function TMovementItemZakazInternalTest.InsertUpdateMovementItemZakazInternal
  (Id, MovementId, GoodsId: Integer;
       Amount, AmountSecond: double;
       GoodsKindId: Integer): integer;
begin
  FParams.Clear;
  FParams.AddParam('ioId', ftInteger, ptInputOutput, Id);
  FParams.AddParam('inMovementId', ftInteger, ptInput, MovementId);
  FParams.AddParam('inGoodsId', ftInteger, ptInput, GoodsId);
  FParams.AddParam('inAmount', ftFloat, ptInput, Amount);
  FParams.AddParam('inAmountSecond', ftFloat, ptInput, AmountSecond);
  FParams.AddParam('inGoodsKindId', ftInteger, ptInput, GoodsKindId);
  result := InsertUpdate(FParams);
end;

procedure TMovementItemZakazInternalTest.SetDataSetParam;
begin
  inherited;
  //FParams.AddParam('inMovementId', ftInteger, ptInput, TMovementZakazInternalTest.Create.GetDefault);
  FParams.AddParam('inShowAll', ftBoolean, ptInput, true);
end;


{ TMovementItemTest }

procedure TMovementItemTest.Delete(Id: Integer);
var Index: Integer;
begin
  if InsertedIdMovementItemList.Find(IntToStr(Id), Index) then begin
     // ����� �� ��������� ������� ������ ����������� � ������ ����� ������
     DeleteRecord(Id);
     InsertedIdMovementItemList.Delete(Index);
  end
  else
     raise Exception.Create('������� ������� ������, ����������� ��� �����!!!');
end;

procedure TMovementItemTest.DeleteRecord(Id: Integer);
const
   pXML =
  '<xml Session = "">' +
    '<lpDelete_MovementItem OutputType="otResult">' +
       '<inId DataType="ftInteger" Value="%d"/>' +
    '</lpDelete_MovementItem>' +
  '</xml>';
var i: integer;
begin
  TStorageFactory.GetStorage.ExecuteProc(Format(pXML, [Id]));
  for i := 0 to DefaultValueList.Count - 1 do
      if DefaultValueList.Values[DefaultValueList.Names[i]] = IntToStr(Id) then begin
         DefaultValueList.Values[DefaultValueList.Names[i]] := '';
         break;
      end;
end;

procedure TMovementItemTest.InsertUpdateInList(Id: integer);
begin
  InsertedIdMovementItemList.Add(IntToStr(Id));
end;

initialization
  InsertedIdMovementItemList := TStringList.Create;
  InsertedIdMovementItemList.Sorted := true;;

  TestFramework.RegisterTest('������ ����������', TdbMovementItemTest.Suite);

end.
