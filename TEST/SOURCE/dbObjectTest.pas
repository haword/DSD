unit dbObjectTest;

interface
uses TestFramework, Authentication, Db, XMLIntf, dsdDB;

type

  TObjectTest = class
  private
    FspInsertUpdate: string;
    FspSelect: string;
    FspGet: string;
  protected
    FdsdStoredProc: TdsdStoredProc;
    FParams: TdsdParams;
    property spGet: string read FspGet write FspGet;
    property spSelect: string read FspSelect write FspSelect;
    property spInsertUpdate: string read FspInsertUpdate write FspInsertUpdate;
    function InsertUpdate(dsdParams: TdsdParams): Integer;
    function InsertDefault: integer; virtual; abstract;
    procedure SetDataSetParam; virtual;
  public
    function GetDefault: integer;
    function GetDataSet: TDataSet; virtual;
    function GetRecord(Id: integer): TDataSet;
    // ��������� ������ � ��� �����������
    procedure DeleteObject(Id: Integer); virtual;
    constructor Create; virtual;
    destructor Destoy;
  end;

  TdbObjectTest = class (TTestCase)
  protected
    // ��������� ���������� �������
    function GetRecordCount(ObjectTest: TObjectTest): integer;
    // �������������� ������ ��� ������������
    procedure SetUp; override;
    // ���������� ������ ��� ������������
    procedure TearDown; override;
  published
    procedure Bank_Test;
    procedure Cash_Test;
    procedure Contract_Test;
    procedure Goods_Test;
    procedure GoodsPropertyValue_Test;
    procedure JuridicalGroup_Test;
    procedure Juridical_Test;
    procedure Partner_Test;
    procedure PriceList_Test;
    procedure Route_Test;
    procedure RouteSorting_Test;
    procedure User_Test;
  end;

  TBankTest = class(TObjectTest)
  private
    function InsertDefault: integer; override;
  public
    // ��������� ������ � ��� �����������
    procedure DeleteObject(Id: Integer); override;
    function InsertUpdateBank(const Id, Code: Integer; Name: string; MFO: string; JuridicalId: integer): integer;
    constructor Create; override;
  end;

  TCashTest = class(TObjectTest)
    function InsertDefault: integer; override;
  public
    function InsertUpdateCash(const Id: integer; CashName: string; CurrencyId: Integer; BranchId: integer): integer;
    constructor Create; override;
  end;

  TContractTest = class(TObjectTest)
  private
    function InsertDefault: integer; override;
  public
    function InsertUpdateContract(const Id: integer; InvNumber, Comment: string): integer;
    constructor Create; override;
  end;

  TCurrencyTest = class(TObjectTest)
  private
    function InsertDefault: integer; override;
  public
    constructor Create; override;
  end;

  TGoodsTest = class(TObjectTest)
    function InsertDefault: integer; override;
  public
    function InsertUpdateGoods(Id, Code: Integer; Name: String;
                               GoodsGroupId, MeasureId: Integer; Weight: Double; ItemInfoMoneyId: Integer): integer;
    constructor Create; override;
  end;

  TGoodsPropertyTest = class(TObjectTest)
  private
    function InsertDefault: integer; override;
  public
    function InsertUpdateGoodsProperty(const Id, Code: Integer; Name: string): integer;
    constructor Create; override;
  end;

  TGoodsPropertyValueTest = class(TObjectTest)
  private
    function InsertDefault: integer; override;
  public
      // ��������� ������ � ��� �����������
    procedure DeleteObject(Id: Integer); override;
    function InsertUpdateGoodsPropertyValue(const Id: Integer; Name: string;
        Amount: double; BarCode, Article, BarCodeGLN, ArticleGLN: string;
        GoodsPropertyId, GoodsId, GoodsKindId: Integer): integer;
    constructor Create; override;
  end;

  TPartnerTest = class(TObjectTest)
  private
    function InsertDefault: integer; override;
  public
    // ��������� ������ � ��� �����������
    procedure DeleteObject(Id: Integer); override;
    function InsertUpdatePartner(const Id: integer; Code: Integer;
        Name, GLNCode: string; JuridicalId, RouteId, RouteSortingId: integer): integer;
    constructor Create; override;
  end;

  TJuridicalTest = class(TObjectTest)
  private
    function InsertDefault: integer; override;
  public
      // ��������� ������ � ��� �����������
   procedure DeleteObject(Id: Integer); override;
   function InsertUpdateJuridical(const Id: integer; Code: Integer;
        Name, GLNCode: string; isCorporate: boolean; JuridicalGroupId, GoodsPropertyId: integer): integer;
    constructor Create; override;
  end;

  TJuridicalGroupTest = class(TObjectTest)
  private
    function InsertDefault: integer; override;
  public
    function InsertUpdateJuridicalGroup(const Id, Code: Integer; Name: string; JuridicalGroupId: integer): integer;
    constructor Create; override;
  end;

  TPriceListTest = class(TObjectTest)
  private
    function InsertDefault: integer; override;
  public
    function InsertUpdatePriceList(const Id, Code: Integer; Name: string): integer;
    constructor Create; override;
  end;

  TRouteTest = class(TObjectTest)
  private
    function InsertDefault: integer; override;
  public
    function InsertUpdateRoute(const Id, Code: Integer; Name: string): integer;
    constructor Create; override;
  end;

  TRouteSortingTest = class(TObjectTest)
  private
    function InsertDefault: integer; override;
  public
    function InsertUpdateRouteSorting(const Id, Code: Integer; Name: string): integer;
    constructor Create; override;
  end;

  TUnitTest = class(TObjectTest)
    function InsertDefault: integer; override;
  public
    function InsertUpdateUnit(Id, Code: Integer; Name: String;
                              UnitGroupId, BranchId: integer): integer;
    constructor Create; override;
  end;

  TUserTest = class(TObjectTest)
  private
    function InsertDefault: integer; override;
  public
    function InsertUpdateUser(const Id: integer; UserName, Login, Password: string): integer;
    constructor Create; override;
  end;

implementation

uses ZDbcIntfs, SysUtils, Storage, DBClient, XMLDoc, CommonData, Forms,
     Classes, UtilConvert, ZLibEx;


{ TObjectTest }

constructor TObjectTest.Create;
begin
  FdsdStoredProc := TdsdStoredProc.Create(nil);
  FParams := TdsdParams.Create(TdsdParam);
end;

procedure TObjectTest.DeleteObject(Id: Integer);
const
   pXML =
  '<xml Session = "">' +
    '<lpDelete_Object OutputType="otResult">' +
       '<inId DataType="ftInteger" Value="%d"/>' +
    '</lpDelete_Object>' +
  '</xml>';
begin
  TStorageFactory.GetStorage.ExecuteProc(Format(pXML, [Id]))
end;

destructor TObjectTest.Destoy;
begin
  FdsdStoredProc.Free
end;

function TObjectTest.GetDataSet: TDataSet;
begin
  with FdsdStoredProc do begin
    if (DataSets.Count = 0) or not Assigned(DataSets[0].DataSet) then
       DataSets.Add.DataSet := TClientDataSet.Create(nil);
    StoredProcName := FspSelect;
    OutputType := otDataSet;
    FParams.Clear;
    SetDataSetParam;
    Params.Assign(FParams);
    Execute;
    result := DataSets[0].DataSet;
  end;
end;

function TObjectTest.GetDefault: integer;
begin
  if GetDataSet.RecordCount > 0 then
     result := GetDataSet.FieldByName('Id').AsInteger
  else
     result := InsertDefault;
end;

function TObjectTest.GetRecord(Id: integer): TDataSet;
begin
  with FdsdStoredProc do begin
    DataSets.Add.DataSet := TClientDataSet.Create(nil);
    StoredProcName := FspGet;
    OutputType := otDataSet;
    Params.Clear;
    Params.AddParam('ioId', ftInteger, ptInputOutput, Id);
    Execute;
    result := DataSets[0].DataSet;
  end;
end;

function TObjectTest.InsertUpdate(dsdParams: TdsdParams): Integer;
begin
  with FdsdStoredProc do begin
    StoredProcName := FspInsertUpdate;
    OutputType := otResult;
    Params.Assign(dsdParams);
    Execute;
    Result := StrToInt(ParamByName('ioId').Value);
  end;
end;

procedure TObjectTest.SetDataSetParam;
begin
  FdsdStoredProc.Params.Clear;
end;

{ TDataBaseObjectTest }
{------------------------------------------------------------------------------}
procedure TdbObjectTest.Cash_Test;
var Id: integer;
    RecordCount: Integer;
    ObjectTest: TCashTest;
begin
  ObjectTest := TCashTest.Create;
  // ������� ������
  RecordCount := GetRecordCount(ObjectTest);
  // ������� �����
  Id := ObjectTest.InsertDefault;
  try
    // ��������� ������ � �����
    with ObjectTest.GetRecord(Id) do
      Check((FieldByName('name').AsString = '������� �����'), '�� �������� ������ Id = ' + FieldByName('id').AsString);

    // ������� ������ ����
    Check((GetRecordCount(ObjectTest) = RecordCount + 1), '���������� ������� �� ����������');
  finally
    ObjectTest.DeleteObject(Id);
  end;
end;
{------------------------------------------------------------------------------}
function TdbObjectTest.GetRecordCount(ObjectTest: TObjectTest): integer;
begin
  Result := ObjectTest.GetDataSet.RecordCount;
end;
{------------------------------------------------------------------------------}
procedure TdbObjectTest.GoodsPropertyValue_Test;
var Id: integer;
    RecordCount: Integer;
    ObjectTest: TGoodsPropertyValueTest;
begin
  ObjectTest := TGoodsPropertyValueTest.Create;
  // ������� ������
  RecordCount := GetRecordCount(ObjectTest);
  // ������� �������
  Id := ObjectTest.InsertDefault;
  try
    // ��������� ������ � �� ����
    with ObjectTest.GetRecord(Id) do
      Check((FieldByName('Name').AsString = 'GoodsPropertyValue'), '�� �������� ������ Id = ' + FieldByName('id').AsString);

  finally
    ObjectTest.DeleteObject(Id);
  end;
end;

procedure TdbObjectTest.Goods_Test;
var Id: integer;
    RecordCount: Integer;
    ObjectTest: TGoodsTest;
begin
  ObjectTest := TGoodsTest.Create;
  // ������� ������
  RecordCount := GetRecordCount(ObjectTest);
  // ������� �������
  Id := ObjectTest.InsertDefault;
  try
    // ��������� ������ � �� ����
    with ObjectTest.GetRecord(Id) do
      Check((FieldByName('Name').AsString = '����� 1'), '�� �������� ������ Id = ' + FieldByName('id').AsString);

  finally
    ObjectTest.DeleteObject(Id);
  end;
end;
{------------------------------------------------------------------------------}
procedure TdbObjectTest.User_Test;
var Id: integer;
    RecordCount: Integer;
    ObjectTest: TUserTest;
begin
  ObjectTest := TUserTest.Create;
  // ������� ������ �������������
  RecordCount := GetRecordCount(ObjectTest);
  // ������� ������������
  Id := ObjectTest.InsertDefault;
  try
    // ��������� ������ � ������������
    with ObjectTest.GetRecord(Id) do
      Check((FieldByName('name').AsString = 'UserName'), '�� �������� ������ Id = ' + FieldByName('id').AsString);
    // �������� �� �������������
    try
      ObjectTest.InsertUpdateUser(0, 'UserName', 'Login', 'Password');
      Check(false, '��� ��������� �� ������ InsertUpdate_Object_User Id=0');
    except

    end;
    // ��������� ������������

    // ������� ������ �������������
    Check((GetRecordCount(ObjectTest) = RecordCount + 1), '���������� ������� �� ����������');
  finally
    ObjectTest.DeleteObject(Id);
  end;
end;
{------------------------------------------------------------------------------}
procedure TdbObjectTest.TearDown;
begin
  inherited;
end;
{------------------------------------------------------------------------------}
procedure TdbObjectTest.SetUp;
begin
  inherited;
  TAuthentication.CheckLogin(TStorageFactory.GetStorage, '�����', '�����', gc_User);
end;
{------------------------------------------------------------------------------}

{ TCurrencyTest }

constructor TCurrencyTest.Create;
begin
  inherited;
  spInsertUpdate := 'gpInsertUpdate_Object_Currency';
  spSelect := 'gpSelect_Object_Currency';
  spGet := 'gpGet_Object_Currency';
end;

function TCurrencyTest.InsertDefault: integer;
begin
  FParams.Clear;
  FParams.AddParam('ioId', ftInteger, ptInputOutput, 0);
  FParams.AddParam('inCurrencyCode', ftInteger, ptInput, 920);
  FParams.AddParam('inCurrencyName', ftString, ptInput, 'GRN');
  FParams.AddParam('inFullName', ftString, ptInput, '������');
  result := InsertUpdate(FParams);
end;

{ TUserTest }

constructor TUserTest.Create;
begin
  inherited Create;
  spInsertUpdate := 'gpInsertUpdate_Object_User';
  spSelect := 'gpSelect_Object_User';
  spGet := 'gpGet_Object_User';
end;

function TUserTest.InsertDefault: integer;
begin
  result := InsertUpdateUser(0, 'UserName', 'Login', 'Password');
end;

function TUserTest.InsertUpdateUser(const Id: integer; UserName, Login, Password: string): integer;
begin
  FParams.Clear;
  FParams.AddParam('ioId', ftInteger, ptInputOutput, Id);
  FParams.AddParam('inUserName', ftString, ptInput, UserName);
  FParams.AddParam('inLogin', ftString, ptInput, Login);
  FParams.AddParam('inPassword', ftString, ptInput, Password);
  result := InsertUpdate(FParams);
end;

{ TCashTest }

constructor TCashTest.Create;
begin
  inherited Create;
  spInsertUpdate := 'gpInsertUpdate_Object_Cash';
  spSelect := 'gpSelect_Object_Cash';
  spGet := 'gpGet_Object_Cash';
end;

function TCashTest.InsertDefault: integer;
var CurrencyId: Integer;
begin
  with TCurrencyTest.Create do
  try
    CurrencyId := GetDefault
  finally
    Free;
  end;
  result := InsertUpdateCash(0, '������� �����', CurrencyId, 0);
end;

function TCashTest.InsertUpdateCash(const Id: integer; CashName: string;
  CurrencyId, BranchId: Integer): integer;
begin
  FParams.Clear;
  FParams.AddParam('ioId', ftInteger, ptInputOutput, Id);
  FParams.AddParam('inCashName', ftString, ptInput, CashName);
  FParams.AddParam('inCurrencyId', ftInteger, ptInput, CurrencyId);
  FParams.AddParam('inCurrencyId', ftInteger, ptInput, BranchId);
  result := InsertUpdate(FParams);


end;


{ TJuridicalGroupTest }

constructor TJuridicalGroupTest.Create;
begin
  inherited;
  spInsertUpdate := 'gpInsertUpdate_Object_JuridicalGroup';
  spSelect := 'gpSelect_Object_JuridicalGroup';
  spGet := 'gpGet_Object_JuridicalGroup';
end;

function TJuridicalGroupTest.InsertDefault: integer;
begin
  result := InsertUpdateJuridicalGroup(0, 1, '������ �� ��� 1', 0);
end;

function TJuridicalGroupTest.InsertUpdateJuridicalGroup(const Id, Code: Integer;
  Name: string; JuridicalGroupId: integer): integer;
begin
  FParams.Clear;
  FParams.AddParam('ioId', ftInteger, ptInputOutput, Id);
  FParams.AddParam('inCode', ftInteger, ptInput, Code);
  FParams.AddParam('inName', ftString, ptInput, Name);
  FParams.AddParam('inJuridicalGroupId', ftInteger, ptInput, JuridicalGroupId);
  result := InsertUpdate(FParams);
end;

{ TGoodsPropertyTest }

constructor TGoodsPropertyTest.Create;
begin
  inherited;
  spInsertUpdate := 'gpInsertUpdate_Object_GoodsProperty';
  spSelect := 'gpSelect_Object_GoodsProperty';
  spGet := 'gpGet_Object_GoodsProperty';
end;

function TGoodsPropertyTest.InsertDefault: integer;
begin
  result := InsertUpdateGoodsProperty(0, 1, '������������� ������� �������');
end;

function TGoodsPropertyTest.InsertUpdateGoodsProperty(const Id, Code: Integer;
  Name: string): integer;
begin
  FParams.Clear;
  FParams.AddParam('ioId', ftInteger, ptInputOutput, Id);
  FParams.AddParam('inCode', ftInteger, ptInput, Code);
  FParams.AddParam('inName', ftString, ptInput, Name);
  result := InsertUpdate(FParams);
end;

  {TRouteTest }
constructor TRouteTest.Create;
begin
  inherited;
  spInsertUpdate := 'gpInsertUpdate_Object_Route';
  spSelect := 'gpSelect_Object_Route';
  spGet := 'gpGet_Object_Route';
end;

function TRouteTest.InsertDefault: integer;
begin
  result := InsertUpdateRoute(0, 1, '�������');
end;

function TRouteTest.InsertUpdateRoute(const Id, Code: Integer;
  Name: string): integer;
begin
  FParams.Clear;
  FParams.AddParam('ioId', ftInteger, ptInputOutput, Id);
  FParams.AddParam('inCode', ftInteger, ptInput, Code);
  FParams.AddParam('inName', ftString, ptInput, Name);
  result := InsertUpdate(FParams);
end;

  {TRouteSortingTest }
constructor TRouteSortingTest.Create;
begin
  inherited;
  spInsertUpdate := 'gpInsertUpdate_Object_RouteSorting';
  spSelect := 'gpSelect_Object_RouteSorting';
  spGet := 'gpGet_Object_RouteSorting';
end;

function TRouteSortingTest.InsertDefault: integer;
begin
  result := InsertUpdateRouteSorting(0, 1, '���������� ���������');
end;

function TRouteSortingTest.InsertUpdateRouteSorting(const Id, Code: Integer;
  Name: string): integer;
begin
  FParams.Clear;
  FParams.AddParam('ioId', ftInteger, ptInputOutput, Id);
  FParams.AddParam('inCode', ftInteger, ptInput, Code);
  FParams.AddParam('inName', ftString, ptInput, Name);
  result := InsertUpdate(FParams);
end;

    {TBankTest }
 constructor TBankTest.Create;
begin
  inherited;
  spInsertUpdate := 'gpInsertUpdate_Object_Bank';
  spSelect := 'gpSelect_Object_Bank';
  spGet := 'gpGet_Object_Bank';
end;

procedure TBankTest.DeleteObject(Id: Integer);
begin
  inherited;
  DeleteObject(TJuridicalTest.Create.GetDefault);
end;

function TBankTest.InsertDefault: integer;
var
  JuridicalId: Integer;
begin
  JuridicalId := TJuridicalTest.Create.GetDefault;
  result := InsertUpdateBank(0, 1, '����', '���', JuridicalId)
end;

function TBankTest.InsertUpdateBank;
begin
  FParams.Clear;
  FParams.AddParam('ioId', ftInteger, ptInputOutput, Id);
  FParams.AddParam('inCode', ftInteger, ptInput, Code);
  FParams.AddParam('inName', ftString, ptInput, Name);
  FParams.AddParam('inMFO', ftString, ptInput, MFO);
  FParams.AddParam('inJuridicalId', ftInteger, ptInput, JuridicalId);
  result := InsertUpdate(FParams);
end;

    { TPartnerTest }
 constructor TPartnerTest.Create;
begin
  inherited;
  spInsertUpdate := 'gpInsertUpdate_Object_Partner';
  spSelect := 'gpSelect_Object_Partner';
  spGet := 'gpGet_Object_Partner';
end;

procedure TPartnerTest.DeleteObject(Id: Integer);
begin
  inherited;
  DeleteObject(TJuridicalTest.Create.GetDefault);
  DeleteObject(TRouteTest.Create.GetDefault);
  DeleteObject(TRouteSortingTest.Create.GetDefault);
end;

function TPartnerTest.InsertDefault: integer;
var
  JuridicalId, RouteId, RouteSortingId: Integer;
begin
  JuridicalId := TJuridicalTest.Create.GetDefault;
  RouteId := TRouteTest.Create.GetDefault;
  RouteSortingId := TRouteSortingTest.Create.GetDefault;
  result := InsertUpdatePartner(0, 1, '�����������', 'GLNCode', JuridicalId, RouteId, RouteSortingId);
end;

function TPartnerTest.InsertUpdatePartner;
begin
  FParams.Clear;
  FParams.AddParam('ioId', ftInteger, ptInputOutput, Id);
  FParams.AddParam('inCode', ftInteger, ptInput, Code);
  FParams.AddParam('inName', ftString, ptInput, Name);
  FParams.AddParam('inGLNCode', ftString, ptInput, GLNCode);
  FParams.AddParam('inJuridicalId', ftInteger, ptInput, JuridicalId);
  FParams.AddParam('inRouteId', ftInteger, ptInput, RouteId);
  FParams.AddParam('inRouteSortingId', ftInteger, ptInput, RouteSortingId);
  result := InsertUpdate(FParams);
end;

    { TJuridicalTest }
 constructor TJuridicalTest.Create;
begin
  inherited;
  spInsertUpdate := 'gpInsertUpdate_Object_Juridical';
  spSelect := 'gpSelect_Object_Juridical';
  spGet := 'gpGet_Object_Juridical';
end;

procedure TJuridicalTest.DeleteObject(Id: Integer);
begin
  inherited;
  DeleteObject(TJuridicalGroupTest.Create.GetDefault);
  DeleteObject(TGoodsPropertyTest.Create.GetDefault);
end;

function TJuridicalTest.InsertDefault: integer;
var
  JuridicalGroupId, GoodsPropertyId: Integer;
begin
  JuridicalGroupId := TJuridicalGroupTest.Create.GetDefault;
  GoodsPropertyId := TGoodsPropertyTest.Create.GetDefault;
  result := InsertUpdateJuridical(0, 1, '��. ����', 'GLNCode', true, JuridicalGroupId, GoodsPropertyId)
end;

function TJuridicalTest.InsertUpdateJuridical;
begin
  FParams.Clear;
  FParams.AddParam('ioId', ftInteger, ptInputOutput, Id);
  FParams.AddParam('inCode', ftInteger, ptInput, Code);
  FParams.AddParam('inName', ftString, ptInput, Name);
  FParams.AddParam('inGLNCode', ftString, ptInput, GLNCode);
  FParams.AddParam('isCorporate', ftBoolean, ptInput, isCorporate);
  FParams.AddParam('inJuridicalGroupId', ftInteger, ptInput, JuridicalGroupId);
  FParams.AddParam('inGoodsPropertyId', ftInteger, ptInput, GoodsPropertyId);
  result := InsertUpdate(FParams);
end;

{ TDataBaseUsersObjectTest }

procedure TdbObjectTest.JuridicalGroup_Test;
var Id, Id2, Id3: integer;
    RecordCount: Integer;
    ObjectTest: TJuridicalGroupTest;
begin
 // ��� ���� ������ ��������� ������������ ������ � �������.
 // � ������ ������������.
  ObjectTest := TJuridicalGroupTest.Create;
  // ������� ������ ��������
  RecordCount := GetRecordCount(ObjectTest);
  // ������� �������
 // ��������� ������ 1
  Id := ObjectTest.InsertDefault;
  try
    // ������ ������ ������ �� ���� � ��������� ������
    try
      ObjectTest.InsertUpdateJuridicalGroup(Id, 1, '������ 1', Id);
      Check(false, '��� ��������� �� ������');
    except

    end;
    // ��������� ��� ������ 2
    // ������ � ������ 2 ������ �� ������ 1
    Id2 := ObjectTest.InsertUpdateJuridicalGroup(0, 2, '������ 2', Id);
    try
      // ������ ������ ������ � ������ 1 �� ������ 2 � ��������� ������
      try
        ObjectTest.InsertUpdateJuridicalGroup(Id, 1, '������ 1', Id2);
        Check(false, '��� ��������� �� ������');
      except

      end;
      // ��������� ��� ������ 3
      // ������ � ������ 3 ������ �� ������ 2
      Id3 := ObjectTest.InsertUpdateJuridicalGroup(0, 3, '������ 3', Id2);
      try
        // ������ 2 ��� ������ �� ������ 1
        // ������ � ������ 1 ������ �� ������ 3 � ��������� ������
        try
          ObjectTest.InsertUpdateJuridicalGroup(Id, 1, '������ 1', Id3);
          Check(false, '��� ��������� �� ������');
        except

        end;
        Check((GetRecordCount(ObjectTest) = RecordCount + 3), '���������� ������� �� ����������');
      finally
        ObjectTest.DeleteObject(Id3);
      end;
    finally
      ObjectTest.DeleteObject(Id2);
    end;
  finally
    ObjectTest.DeleteObject(Id);
  end;
end;

procedure TdbObjectTest.Juridical_Test;
var Id: integer;
    RecordCount: Integer;
    ObjectTest: TJuridicalTest;
begin
  ObjectTest := TJuridicalTest.Create;
  // ������� ������
  RecordCount := GetRecordCount(ObjectTest);
  // ������� �� ����
  Id := ObjectTest.InsertDefault;
  try
    // ��������� ������ � �� ����
    with ObjectTest.GetRecord(Id) do
      Check((FieldByName('GLNCode').AsString = 'GLNCode'), '�� �������� ������ Id = ' + FieldByName('id').AsString);

  finally
    ObjectTest.DeleteObject(Id);
  end;
end;

procedure TdbObjectTest.PriceList_Test;
begin

end;

procedure TdbObjectTest.Bank_Test;
var Id: integer;
    RecordCount: Integer;
    ObjectTest: TBankTest;
begin
  ObjectTest := TBankTest.Create;
  // ������� ������
  RecordCount := GetRecordCount(ObjectTest);
  // ������� �����
  Id := ObjectTest.InsertDefault;
  try
    // ��������� ������ � �����
    with ObjectTest.GetRecord(Id) do
      Check((FieldByName('Name').AsString = '����'), '�� �������� ������ Id = ' + FieldByName('id').AsString);

  finally
    ObjectTest.DeleteObject(Id);
  end;
end;

procedure TdbObjectTest.Contract_Test;
var Id: integer;
    RecordCount: Integer;
    ObjectTest: TContractTest;
begin
  ObjectTest := TContractTest.Create;
  // ������� ������
  RecordCount := GetRecordCount(ObjectTest);
  // ������� �� ����
  Id := ObjectTest.InsertDefault;
  try
    // ��������� ������ � �� ����
    with ObjectTest.GetRecord(Id) do
      Check((FieldByName('InvNumber').AsString = '123456'), '�� �������� ������ Id = ' + FieldByName('id').AsString);

  finally
    ObjectTest.DeleteObject(Id);
  end;
end;

procedure TdbObjectTest.Route_Test;
var Id: integer;
    RecordCount: Integer;
    ObjectTest: TRouteTest;
begin
  ObjectTest := TRouteTest.Create;
  // ������� ������
  RecordCount := GetRecordCount(ObjectTest);
  // ������� �� ����
  Id := ObjectTest.InsertDefault;
  try
    // ��������� ������ � ��������
    with ObjectTest.GetRecord(Id) do
      Check((FieldByName('Name').AsString = '�������'), '�� �������� ������ Id = ' + FieldByName('id').AsString);

  finally
    ObjectTest.DeleteObject(Id);
  end;
end;

procedure TdbObjectTest.RouteSorting_Test;
var Id: integer;
    RecordCount: Integer;
    ObjectTest: TRouteSortingTest;
begin
  ObjectTest := TRouteSortingTest.Create;
  // ������� ������
  RecordCount := GetRecordCount(ObjectTest);
  // ������� �� ����
  Id := ObjectTest.InsertDefault;
  try
    // ��������� ������ � ���������� ��������
    with ObjectTest.GetRecord(Id) do
      Check((FieldByName('Name').AsString = '���������� ���������'), '�� �������� ������ Id = ' + FieldByName('id').AsString);

  finally
    ObjectTest.DeleteObject(Id);
  end;
end;

procedure TdbObjectTest.Partner_Test;
var Id: integer;
    RecordCount: Integer;
    ObjectTest: TPartnerTest;
begin
  ObjectTest := TPartnerTest.Create;
  // ������� ������
  RecordCount := GetRecordCount(ObjectTest);
  // ������� �����������
  Id := ObjectTest.InsertDefault;
  try
    // ��������� ������ � �����������
    with ObjectTest.GetRecord(Id) do
      Check((FieldByName('GLNCode').AsString = 'GLNCode'), '�� �������� ������ Id = ' + FieldByName('id').AsString);

  finally
    ObjectTest.DeleteObject(Id);
  end;
end;

{ TContractTest }
 constructor TContractTest.Create;
begin
  inherited;
  spInsertUpdate := 'gpInsertUpdate_Object_Contract';
  spSelect := 'gpSelect_Object_Contract';
  spGet := 'gpGet_Object_Contract';
end;

function TContractTest.InsertDefault: integer;
begin
  result := InsertUpdateContract(0, '123456', 'comment');
end;

function TContractTest.InsertUpdateContract(const Id: integer; InvNumber,
  Comment: string): integer;
begin
  FParams.Clear;
  FParams.AddParam('ioId', ftInteger, ptInputOutput, Id);
  FParams.AddParam('inInvNumber', ftString, ptInput, InvNumber);
  FParams.AddParam('inComment', ftString, ptInput, Comment);
  result := InsertUpdate(FParams);
end;


{ TGoodsTest }

constructor TGoodsTest.Create;
begin
  inherited;
  spInsertUpdate := 'gpInsertUpdate_Object_Goods';
  spSelect := 'gpSelect_Object_Goods';
  spGet := 'gpGet_Object_Goods';
end;

function TGoodsTest.InsertDefault: integer;
begin
  result := InsertUpdateGoods(0, 1, '����� 1', 0, 0, 1.0, 0)
end;

function TGoodsTest.InsertUpdateGoods(Id, Code: Integer; Name: String;
  GoodsGroupId, MeasureId: Integer; Weight: Double; ItemInfoMoneyId: Integer): integer;
begin
  FParams.Clear;
  FParams.AddParam('ioId', ftInteger, ptInputOutput, Id);
  FParams.AddParam('inCode', ftInteger, ptInput, Code);
  FParams.AddParam('inName', ftString, ptInput, Name);
  FParams.AddParam('inGoodsGroupId', ftInteger, ptInput, GoodsGroupId);
  FParams.AddParam('inMeasureId', ftInteger, ptInput, MeasureId);
  FParams.AddParam('inWeight', ftFloat, ptInput, Weight);
  FParams.AddParam('inItemInfoMoneyId', ftInteger, ptInput, ItemInfoMoneyId);
  result := InsertUpdate(FParams);
end;

{ TGoodsPropertyValueTest }
constructor TGoodsPropertyValueTest.Create;
begin
  inherited;
  spInsertUpdate := 'gpInsertUpdate_Object_GoodsPropertyValue';
  spSelect := 'gpSelect_Object_GoodsPropertyValue';
  spGet := 'gpGet_Object_GoodsPropertyValue';
end;

procedure TGoodsPropertyValueTest.DeleteObject(Id: Integer);
begin
  inherited;
  DeleteObject(TGoodsTest.Create.GetDefault);
  DeleteObject(TGoodsPropertyTest.Create.GetDefault);
end;

function TGoodsPropertyValueTest.InsertDefault: integer;
var
  GoodsPropertyId, GoodsId, GoodsKindId: Integer;
begin
  GoodsId := TGoodsTest.Create.GetDefault;
  GoodsPropertyId := TGoodsPropertyTest.Create.GetDefault;
  GoodsKindId := 0;
  result := InsertUpdateGoodsPropertyValue(0, 'GoodsPropertyValue', 10,
         'BarCode', 'Article', 'BarCodeGLN', 'ArticleGLN',
         GoodsPropertyId, GoodsId, GoodsKindId)
end;

function TGoodsPropertyValueTest.InsertUpdateGoodsPropertyValue(
  const Id: Integer; Name: string; Amount: double; BarCode, Article, BarCodeGLN,
  ArticleGLN: string; GoodsPropertyId, GoodsId, GoodsKindId: Integer): integer;
begin
  FParams.Clear;
  FParams.AddParam('ioId', ftInteger, ptInputOutput, Id);
  FParams.AddParam('inName', ftString, ptInput, Name);
  FParams.AddParam('inAmount', ftFloat, ptInput, Amount);
  FParams.AddParam('inBarCode', ftString, ptInput, BarCode);
  FParams.AddParam('inArticle', ftString, ptInput, Article);
  FParams.AddParam('inBarCodeGLN', ftString, ptInput, BarCodeGLN);
  FParams.AddParam('inArticleGLN', ftString, ptInput, ArticleGLN);

  FParams.AddParam('inGoodsPropertyId', ftInteger, ptInput, GoodsPropertyId);
  FParams.AddParam('inGoodsId', ftInteger, ptInput, GoodsId);
  FParams.AddParam('inGoodsKindId', ftInteger, ptInput, GoodsKindId);

  result := InsertUpdate(FParams);
end;

{ TUnitTest }

constructor TUnitTest.Create;
begin
  inherited;
  spInsertUpdate := 'gpInsertUpdate_Object_Unit';
  spSelect := 'gpSelect_Object_Unit';
  spGet := 'gpGet_Object_Unit';
end;

function TUnitTest.InsertDefault: integer;
begin
  result := InsertUpdateUnit(0, 1, '', 0, 0);
end;

function TUnitTest.InsertUpdateUnit(Id, Code: Integer; Name: String;
  UnitGroupId, BranchId: integer): integer;
begin
  FParams.Clear;
  FParams.AddParam('ioId', ftInteger, ptInputOutput, Id);
  FParams.AddParam('inCode', ftInteger, ptInput, Code);
  FParams.AddParam('inName', ftString, ptInput, Name);
  FParams.AddParam('inUnitGroupId', ftInteger, ptInput, UnitGroupId);
  FParams.AddParam('inBranchId', ftInteger, ptInput, BranchId);

  result := InsertUpdate(FParams);
end;

{ TPriceListTest }

constructor TPriceListTest.Create;
begin
  inherited;
  spInsertUpdate := 'gpInsertUpdate_Object_PriceList';
  spSelect := 'gpSelect_Object_PriceList';
  spGet := 'gpGet_Object_PriceList';
end;

function TPriceListTest.InsertDefault: integer;
begin
  result := InsertUpdatePriceList(0, 1, '�����-����');
end;

function TPriceListTest.InsertUpdatePriceList(const Id, Code: Integer;
  Name: string): integer;
begin
  FParams.Clear;
  FParams.AddParam('ioId', ftInteger, ptInputOutput, Id);
  FParams.AddParam('inCode', ftInteger, ptInput, Code);
  FParams.AddParam('inName', ftString, ptInput, Name);
  result := InsertUpdate(FParams);
end;

initialization
  TestFramework.RegisterTest('�����������', TdbObjectTest.Suite);

end.
