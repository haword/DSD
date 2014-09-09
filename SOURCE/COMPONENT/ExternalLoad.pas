unit ExternalLoad;

interface

uses dsdAction, dsdDb, Classes, DB, ExternalData, ADODB;

type

  TDataSetType = (dtDBF, dtXLS, dtMMO);

  TExternalLoad = class(TExternalData)
  protected
    FStartDate: TDateTime;
    FEndDate: TDateTime;
  public
    property Active: boolean read FActive;
  end;

  TFileExternalLoad = class(TExternalLoad)
  private
    FInitializeDirectory: string;
    FDataSetType: TDataSetType;
    FAdoConnection: TADOConnection;
    FFileExtension: string;
    FFileFilter: string;
    FExtendedProperties: string;
    FStartRecord: integer;
  protected
    procedure First; override;
  public
    constructor Create(DataSetType: TDataSetType = dtDBF; StartRecord: integer = 1; ExtendedProperties: string = '');
    destructor Destroy; override;
    procedure Open(FileName: string);
    procedure Activate; override;
    procedure Close;
    property InitializeDirectory: string read FInitializeDirectory write FInitializeDirectory;
  end;

  TExternalLoadAction = class(TdsdCustomAction)
  private
    FInitializeDirectory: string;
    FFileName: string;
  protected
    function GetStoredProc: TdsdStoredProc; virtual; abstract;
    function GetExternalLoad: TExternalLoad; virtual; abstract;
    procedure ProcessingOneRow(AExternalLoad: TExternalLoad; AStoredProc: TdsdStoredProc); virtual; abstract;
  public
    property FileName: string read FFileName write FFileName;
    constructor Create(Owner: TComponent); override;
    function Execute: boolean; override;
  published
    // ���������� ��������. ������� published ��� �� ��������� ������ �� ����������� �����
    property InitializeDirectory: string read FInitializeDirectory write FInitializeDirectory;
  end;

  TImportSettingsItems = class (TCollectionItem)
  public
    ItemName: string;
    Param: TdsdParam;
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
  end;

  TImportSettings = class (TCollection)
  public
    JuridicalId: Integer;
    ContractId: Integer;
    FileType: TDataSetType;
    StoredProc: TdsdStoredProc;
    StartRow: integer;
    Directory: string;
    constructor Create(ItemClass: TCollectionItemClass);
    destructor Destroy; override;
  end;

  TImportSettingsFactory = class
  private
    class function GetDefaultByFieldType(FieldType: TFieldType): OleVariant;
    class function CreateImportSettings(Id: integer): TImportSettings;
  public
    class function GetImportSettings(Id: integer): TImportSettings;
  end;

  TExecuteProcedureFromFile = class
  private
    FExternalLoad: TFileExternalLoad;
    FImportSettings: TImportSettings;
    procedure ProcessingOneRow(AExternalLoad: TExternalLoad; AImportSettings: TImportSettings);
  public
    constructor Create(FileType: TDataSetType; FileName: string; ImportSettings: TImportSettings);
    procedure Load;
  end;

  TExecuteImportSettings = class
    class procedure Execute(ImportSettings: TImportSettings);
  end;

  TExecuteImportSettingsAction = class(TdsdCustomAction)
  private
    FImportSettingsId: TdsdParam;
  protected
    function LocalExecute: boolean; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property ImportSettingsId: TdsdParam read FImportSettingsId write FImportSettingsId;
  end;

  procedure Register;

implementation

uses VCL.ActnList, SysUtils, Dialogs, SimpleGauge, VKDBFDataSet, UnilWin,
     DBClient, TypInfo, Variants, UtilConvert;

procedure Register;
begin
  RegisterActions('DSDLib', [TExecuteImportSettingsAction], TExecuteImportSettingsAction);
end;

function GetFileType(FileTypeName: string): TDataSetType;
begin
  if FileTypeName = '' then
     result := dtDBF
  else
    if FileTypeName = 'Excel' then
       result := dtXLS
    else
      if FileTypeName = '' then
         result := dtMMO
      else
        raise Exception.Create('��� ����� "' + FileTypeName + '" �� ��������� � ���������');
end;

{ TFileExternalLoad }

procedure TFileExternalLoad.Activate;
begin
  with {File}TOpenDialog.Create(nil) do
  try
    InitialDir := InitializeDirectory;
    DefaultExt := FFileExtension;
    Filter := FFileFilter;
    if Execute then begin
       InitializeDirectory := ExtractFilePath(FileName);
       Self.Open(FileName);
    end;
  finally
    Free;
  end;
end;

constructor TExternalLoadAction.Create(Owner: TComponent);
begin
  FileName := '';
  inherited;
end;

function TExternalLoadAction.Execute: boolean;
var
   FExternalLoad: TFileExternalLoad;
   FStoredProc: TdsdStoredProc;
begin
  result := false;
  FExternalLoad := TFileExternalLoad(GetExternalLoad);
  try
    FExternalLoad.InitializeDirectory := InitializeDirectory;
    if FileName <> '' then
       FExternalLoad.Open(FileName)
    else
       FExternalLoad.Activate;
    if FExternalLoad.Active then begin
       InitializeDirectory := FExternalLoad.InitializeDirectory;
       FStoredProc := GetStoredProc;
       try
         if  FExternalLoad.RecordCount > 0 then
             with TGaugeFactory.GetGauge('�������� ������', 1, FExternalLoad.RecordCount) do begin
               Start;
               try
                 while not FExternalLoad.EOF do begin
                   ProcessingOneRow(FExternalLoad, FStoredProc);
                   IncProgress;
                   FExternalLoad.Next;
                 end;
               finally
                 Finish
               end;
               result := true
             end;
       finally
         FStoredProc.Free
       end;
    end;
  finally
    FExternalLoad.Free;
  end;
end;

procedure TFileExternalLoad.Close;
begin
  FDataSet.Close;
  FAdoConnection.Connected := false;
end;

constructor TFileExternalLoad.Create(DataSetType: TDataSetType; StartRecord: integer; ExtendedProperties: string);
begin
  inherited Create;
  FOEM := true;
  FDataSetType := DataSetType;
  FExtendedProperties := ExtendedProperties;
  FStartRecord := StartRecord;
  case FDataSetType of
    dtDBF: begin
             FFileExtension := '*.dbf';
             FFileFilter := '����� DBF (*.dbf)|*.dbf|';
           end;
    dtXLS: begin
             FFileExtension := '*.xls';
             FFileFilter := '����� �������� Excel|*.xls;*.xlsx|';
           end;
  end;
end;

destructor TFileExternalLoad.Destroy;
begin
  if Assigned(FDataSet) then
     FreeAndNil(FDataSet);
  if Assigned(FAdoConnection) then
     FreeAndNil(FAdoConnection);
  inherited;
end;

procedure TFileExternalLoad.First;
begin
  inherited;
  FDataSet.First
end;

procedure TFileExternalLoad.Open(FileName: string);
var strConn :  widestring;
    List: TStringList;
    ListName: string;
begin
  case FDataSetType of
    dtDBF: begin
        FDataSet := TVKSmartDBF.Create(nil);
        TVKSmartDBF(FDataSet).DBFFileName := FileName;
        TVKSmartDBF(FDataSet).OEM := FOEM;
        try
          FDataSet.Open;
        except
          on E: Exception do begin
             if Pos('TVKSmartDBF.InternalOpen: Open error', E.Message) > -1 then
                raise Exception.Create('����' + copy (E.Message, length('TVKSmartDBF.InternalOpen: Open error') + 1, MaxInt) + ' ������ ������ ����������. �������� �� � ���������� ��� ���!')
             else
                raise Exception.Create(E.Message);
          end;
        end;
    end;
    dtXLS: begin
      strConn:='Provider=Microsoft.Jet.OLEDB.4.0;' +
               'Data Source=' + FileName + ';' +
               'Extended Properties=Excel 8.0' + FExtendedProperties + ';';
      if not Assigned(FAdoConnection) then begin
         FAdoConnection := TAdoConnection.Create(nil);
         FAdoConnection.LoginPrompt := false;
         FDataSet := TADOQuery.Create(nil);
         TADOQuery(FDataSet).Connection := FAdoConnection;
      end;
      FAdoConnection.Connected := False;
      FAdoConnection.ConnectionString := strConn;
      FAdoConnection.Open;
      List := TStringList.Create;
      try
        FAdoConnection.GetTableNames(List, True);
        TADOQuery(FDataSet).ParamCheck := false;
        ListName := List[0];
        if Copy(ListName, 1, 1) = chr(39) then
           ListName := Copy(List[0], 2, length(List[0])-2);
        TADOQuery(FDataSet).SQL.Text := 'SELECT * FROM [' + ListName + 'A' + IntToStr(FStartRecord)+ ':Z60000]';
        TADOQuery(FDataSet).Open;
      finally
        FreeAndNil(List);
      end;
    end;
  end;
  First;
  FActive := FDataSet.Active;
end;

{ TExecuteProcedureFromFile }

constructor TExecuteProcedureFromFile.Create(FileType: TDataSetType; FileName: string; ImportSettings: TImportSettings);
begin
  FImportSettings := ImportSettings;
  FExternalLoad := TFileExternalLoad.Create(FileType, ImportSettings.StartRow);
  FExternalLoad.Open(FileName);
end;

procedure TExecuteProcedureFromFile.Load;
begin
  with TGaugeFactory.GetGauge('�������� ������', 1, FExternalLoad.RecordCount) do begin
    Start;
    try
      while not FExternalLoad.EOF do begin
        ProcessingOneRow(FExternalLoad, FImportSettings);
        IncProgress;
        FExternalLoad.Next;
      end;
      FExternalLoad.Close;
    finally
     Finish
    end;
  end;
end;

procedure TExecuteProcedureFromFile.ProcessingOneRow(AExternalLoad: TExternalLoad;
  AImportSettings: TImportSettings);
var i: integer;
    D: TDateTime;
    Value: OleVariant;
    Ft: double;
begin
  with AImportSettings do begin
    for i := 0 to Count - 1 do begin
        if TImportSettingsItems(Items[i]).ItemName = '%JURIDICAL%' then
           StoredProc.Params.Items[i].Value := AImportSettings.JuridicalId
        else begin
           if TImportSettingsItems(Items[i]).ItemName <> '' then begin
              case StoredProc.Params[i].DataType of
                ftDateTime: begin
                   try
                     Value := AExternalLoad.FDataSet.FieldByName(TImportSettingsItems(Items[i]).ItemName).Value;
                     D := VarToDateTime(Value);
                     StoredProc.Params.Items[i].Value := D;
                   except
                     on E: EVariantTypeCastError do
                        StoredProc.Params.Items[i].Value := Date;
                     on E: Exception do
                        raise E;
                   end;
                end;
                ftFloat: begin
                   try
                     Value := AExternalLoad.FDataSet.FieldByName(TImportSettingsItems(Items[i]).ItemName).Value;
                     Ft := gfStrToFloat(Value);
                     StoredProc.Params.Items[i].Value := Ft;
                   except
                     on E: EVariantTypeCastError do
                        StoredProc.Params.Items[i].Value := 0;
                     on E: Exception do
                        raise E;
                   end;
                end
                else
                  StoredProc.Params.Items[i].Value := AExternalLoad.FDataSet.FieldByName(TImportSettingsItems(Items[i]).ItemName).Value;
              end;
           end;
        end;
    end;
    StoredProc.Execute;
  end;
end;

{ TExecuteImportSettings }

class procedure TExecuteImportSettings.Execute(ImportSettings: TImportSettings);
var iFilesCount: Integer;
    saFound: TStrings;
    i: integer;
begin
  saFound := TStringList.Create;
  try
    if ImportSettings.FileType = dtXLS then
       FilesInDir('*.xls', ImportSettings.Directory, iFilesCount, saFound, false);
    TStringList(saFound).Sort;
    for I := 0 to saFound.Count - 1 do
        with TExecuteProcedureFromFile.Create(ImportSettings.FileType, saFound[i], ImportSettings) do
          try
            // ���������
            Load;
            // ��������� � Archive
            ForceDirectories(ExtractFilePath(saFound[i]) + 'Archive');
            RenameFile(saFound[i], ExtractFilePath(saFound[i]) + 'Archive\' + ExtractFileName(saFound[i]));
          finally
            Free;
          end;
  finally
    saFound.Free
  end;

end;

{ TImportSettings }

constructor TImportSettings.Create(ItemClass: TCollectionItemClass);
begin
  inherited;
  StoredProc := TdsdStoredProc.Create(nil);
  StoredProc.OutputType := otResult;
end;

destructor TImportSettings.Destroy;
begin
  FreeAndNil(StoredProc);
  inherited;
end;

{ TImportSettingsFactory }

class function TImportSettingsFactory.CreateImportSettings(
  Id: integer): TImportSettings;
var
  GetStoredProc: TdsdStoredProc;
  DataSet: TDataSet;
  FieldType: TFieldType;
begin
  GetStoredProc := TdsdStoredProc.Create(nil);
  GetStoredProc.OutputType := otResult;
  GetStoredProc.StoredProcName := 'gpGet_Object_ImportSettings';
  GetStoredProc.Params.AddParam('inId', ftInteger, ptInput, Id);

  GetStoredProc.Params.AddParam('StartRow', ftInteger, ptOutput, 0);
  GetStoredProc.Params.AddParam('ContractId', ftInteger, ptOutput, 0);
  GetStoredProc.Params.AddParam('JuridicalId', ftInteger, ptOutput, 0);
  GetStoredProc.Params.AddParam('FileTypeName', ftString, ptOutput, '');
  GetStoredProc.Params.AddParam('ImportTypeName', ftString, ptOutput, '');
  GetStoredProc.Params.AddParam('Directory', ftString, ptOutput, '');
  GetStoredProc.Params.AddParam('ProcedureName', ftString, ptOutput, '');

  GetStoredProc.Execute;
  {��������� ����������� ���������}
  Result := TImportSettings.Create(TImportSettingsItems);
  Result.StartRow := GetStoredProc.Params.ParamByName('StartRow').Value;
  Result.Directory := GetStoredProc.Params.ParamByName('Directory').Value;
  Result.FileType := GetFileType(GetStoredProc.Params.ParamByName('FileTypeName').Value);
  Result.JuridicalId := GetStoredProc.Params.ParamByName('JuridicalId').Value;
  Result.ContractId := GetStoredProc.Params.ParamByName('ContractId').Value;

  Result.StoredProc := TdsdStoredProc.Create(nil);
  Result.StoredProc.StoredProcName := GetStoredProc.Params.ParamByName('ProcedureName').Value;
  Result.StoredProc.OutputType := otResult;

  GetStoredProc.Params.Clear;
  {��������� ����������� ��������� ���������}
  GetStoredProc.StoredProcName := 'gpSelect_Object_ImportSettingsItems';
  GetStoredProc.Params.AddParam('inId', ftInteger, ptInput, Id);
  GetStoredProc.OutputType := otDataSet;
  GetStoredProc.DataSet := TClientDataSet.Create(nil);
  TClientDataSet(GetStoredProc.DataSet).IndexFieldNames := 'ParamNumber';
  GetStoredProc.Execute;

  with GetStoredProc.DataSet do begin
    Filtered := true;
    Filter := 'isErased <> true';
    while not EOF do begin
      FieldType := TFieldType(GetEnumValue(TypeInfo(TFieldType), FieldByName('ParamType').asString));
      with TImportSettingsItems(Result.Add) do begin
        ItemName := FieldByName('ParamValue').asString;
        Param.Value := GetDefaultByFieldType(FieldType);
      end;
      Result.StoredProc.Params.AddParam(FieldByName('ParamName').asString, FieldType, ptInput, GetDefaultByFieldType(FieldType));
      Next;
    end;
  end;

end;

class function TImportSettingsFactory.GetDefaultByFieldType(
  FieldType: TFieldType): OleVariant;
begin
  case FieldType of
    ftString: result := '';
    ftInteger, ftFloat: result := 0;
    ftBoolean: result := true;
    ftDateTime: result := Date;
  end;
end;

class function TImportSettingsFactory.GetImportSettings(
  Id: integer): TImportSettings;
begin
  result := CreateImportSettings(Id);
end;

{ TExecuteImportSettingsAction }

constructor TExecuteImportSettingsAction.Create(AOwner: TComponent);
begin
  inherited;
  FImportSettingsId := TdsdParam.Create(nil);
end;

destructor TExecuteImportSettingsAction.Destroy;
begin
  FreeAndNil(FImportSettingsId);
  inherited;
end;

function TExecuteImportSettingsAction.LocalExecute: boolean;
begin
  TExecuteImportSettings.Execute(TImportSettingsFactory.CreateImportSettings(ImportSettingsId.Value));
end;

{ TImportSettingsItems }

constructor TImportSettingsItems.Create(Collection: TCollection);
begin
  inherited;
  Param := TdsdParam.Create(nil);
end;

destructor TImportSettingsItems.Destroy;
begin
  FreeAndNil(Param);
  inherited;
end;

end.
