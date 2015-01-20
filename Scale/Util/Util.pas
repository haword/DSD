unit Util;

interface

uses
  System.SysUtils, System.Classes, dsdDB, Data.DB, Datasnap.DBClient, Vcl.Dialogs;
type

  TDBObject = record
    Id:   integer;
    Code: integer;
    Name: string;
  end;

  TListItem = record
    Number:  integer;
    Id:   integer;
    Name: string;
  end;

  TListArray =  array of TListItem;

  TSetting = record
    ScaleNum:         integer;
    UserId:           integer;

    MovementDescCode: integer;
    MovementDescCode: integer;
    MovementDescId:   integer;
    FromId:           integer;
    FromCode:         integer;
    FromName:         string;
    ToId:             integer;
    ToCode:           integer;
    ToName:           string;
    PaidKindId:       integer;
    PaidKindName:     string;
    ColorGridValue:    string;

    RouteSortingId:   integer;
    RouteSortingCode: integer;
    RouteSortingName: string;

    PriceListId:      integer;
    PriceListCode:    integer;
    PriceListName:    string;
  end;

function gpGet_ToolsWeighing_Value(inLevel1,inLevel2,inLevel3,inItemName,inDefaultValue:String):String;
function gpGetObject_byCode (Code, DescId: integer): TDBObject;

function GetListOrder_ByCode(Num:integer; List:TListArray):integer;

function isEqualFloatValues(Value1,Value2:Double):boolean;

//procedure FillCustomList(List: array of TListItem; ProcName: String);
function FillCustomList(ProcName: String): TListArray;
procedure FillAllList;


var
  CurSetting:         TSetting;
  NewSetting:         TSetting;

  PriceList:          TListArray;
  WeightTare:         TListArray;
  ChangePercent:      TListArray;
  GoodsKindWeighing:  TListArray;

//  ,ParamsKindPackage,ParamsDiscount,ParamsCountTare,ParamsCodeTareWeightEnter,ParamsBill_ScaleHistory:TParams;
//  ParamsBillKind,ParamsBillKind_UnitFrom,ParamsBillKind_UnitTo,ParamsBillKind_MoneyKind,ParamsBillKind_isProduction:TParams;

implementation

uses Main;

procedure FillAllList;
var
 i: integer;
begin
  PriceList:=         FillCustomList('gpSelect_Object_ToolsWeighing_PriceList');
  WeightTare:=        FillCustomList('gpSelect_Object_ToolsWeighing_WeightTare');
  ChangePercent:=     FillCustomList('gpSelect_Object_ToolsWeighing_ChangePercent');
  GoodsKindWeighing:= FillCustomList('gpSelect_Object_ToolsWeighing_GoodsKindWeighing');

end;

function FillCustomList(ProcName: String): TListArray;
var
 spExec : TdsdStoredProc;
 tmpDataSet: TClientDataSet;
 i: integer;
begin
  spExec:= TdsdStoredProc.Create(Nil);
  tmpDataSet:= TClientDataSet.Create(Nil);
  try
    with spExec do begin
       OutputType:=otDataSet;
       DataSet:=tmpDataSet;
       StoredProcName:=ProcName;
       Params.AddParam('inRootId', ftInteger, ptInput, CurSetting.ScaleNum);
       try
         Execute;
         SetLength(result, tmpDataSet.RecordCount);
         for I := 0 to tmpDataSet.RecordCount-1 do
         begin
          result[i].Num := tmpDataSet.FieldByName('Num').asInteger;
          result[i].Id := tmpDataSet.FieldByName('Id').asInteger;
          result[i].Name := tmpDataSet.FieldByName('Name').asString;
          tmpDataSet.Next;
         end
       except
//         ShowMessage('������ ��������� ��������');
         SetLength(result, 0);
       end;
    end;
  finally spExec.Free; tmpDataSet.Free; end;
end;


function gpGet_ToolsWeighing_Value(inLevel1,inLevel2,inLevel3,inItemName,inDefaultValue:String):String;
var
 spExec : TdsdStoredProc;
 ClientDataSet: TClientDataSet;
begin
  spExec:= TdsdStoredProc.Create(Nil);
  ClientDataSet:= TClientDataSet.Create(Nil);
  try
    with spExec do begin
       OutputType:=otDataSet;
       DataSet:=ClientDataSet;
       StoredProcName:='gpGet_ToolsWeighing_Value';
       Params.AddParam('inLevel1', ftString, ptInput, inLevel1);
       Params.AddParam('inLevel2', ftString, ptInput, inLevel2);
       Params.AddParam('inLevel3', ftString, ptInput, inLevel3);
       Params.AddParam('inItemName', ftString, ptInput, inItemName);
       Params.AddParam('inDefaultValue', ftString, ptInput, inDefaultValue);
       try
         Execute;
         result := ClientDataSet.FieldByName('Value').asString;
       except
//         ShowMessage('������ ��������� ��������');
         result := '';
       end;
    end;
  finally spExec.Free; ClientDataSet.Free; end;
end;


function GetListOrder_ByCode(Num:integer; List:TListArray):integer;
var
 i: integer;
begin
  for I := 0 to Length(List) do
    if List[i].Num = Num then Result:=I;
end;


function GetObject_byCode(Code, DescId: integer): TDBObject;
var
 spExec : TdsdStoredProc;
begin
  spExec:=TdsdStoredProc.Create(Nil);
  try
    with spExec do begin
       OutputType:=otResult;
       StoredProcName:='gpGetObject_byCode';
       Params.AddParam('inCode', ftInteger, ptInput, Code);
       Params.AddParam('inDescId', ftInteger, ptInput, DescId);
       Params.AddParam('outId', ftInteger, ptOutput, 0);
       Params.AddParam('outName', ftString, ptOutput, 'test');
       try
         Execute;
         result.Code := Code;
         result.Id   := ParamByName('outId').Value;
         result.Name := ParamByName('outName').Value;
       except
//         ShowMessage('������ ��������� �������');
         result.Code := Code;
         result.Id   := 0;
         result.Name := '';

       end;
    end;
  finally spExec.Free end;
end;

{------------------------------------------------------------------------}
function isEqualFloatValues(Value1,Value2:Double):boolean;
begin
     Result:=abs(Value1-Value2)<0.0001;
end;
{------------------------------------------------------------------------}
//  ������� � DataSet �������� �� Params ���� NameFieldID � ���� ����� �� ������ �� �������� �� Params
function UpdateDataSet(DataSet:TDataSet;NameFieldID:String;Params: TParams): boolean;
var i:integer;
begin
     result:=false;
     with DataSet do begin
          DisableControls;
          if Locate(NameFieldID,Params.ParamByName(NameFieldID).AsString,[]) then
          try
             Edit;
             for i:=0 to Params.Count-1 do if UpperCase(Params[i].Name)<>UpperCase(NameFieldID)
                 then FieldByName(Params[i].Name).Value:=Params[i].Value;
             Post;
             result:=true;
          except end;
          EnableControls;
     end;
end;
{------------------------------------------------------------------------------}
//      ������� TParam � ��������� ���� _Name � ����� _DataType � �������� _Value
//      � ��������� � TParams
procedure ParamAddValue(var Params :TParams;_Name:String;_DataType:TFieldType;_Value: variant);
begin
  if not Assigned(Params) then Params:=TParams.Create;
  ParamAdd(Params,_Name,_DataType);
  Params.Items[Params.Count-1].Value:=_Value;
end;
{------------------------------------------------------------------------------}
//      ������� TParam � ��������� ���� _Name � ����� _DataType � �������� _Value
function CreateParamValue(_Name:String;_DataType:TFieldType;_Value: variant):TParams;
begin Result:=nil;ParamAddValue(Result,_Name,_DataType,_Value);end;
{------------------------------------------------------------------------------}
function GetIndexParams(execParams:TParams;FindName:String):integer;//���������� ������ �������� ���������� FindName � TParams
var i:integer;
begin
  Result:=-1;
  if not Assigned(execParams) then exit;
  for i:=0 to execParams.Count-1 do
          if UpperCase(execParams[i].Name)=UpperCase(FindName)then begin Result:=i;break;end;
end;
{------------------------------------------------------------------------------}
function FindParamName(execParams:TParams;FindValue:String):String;
var i:integer;
begin
  Result:='';
  if not Assigned(execParams) then exit;
  for i:=0 to execParams.Count-1 do
          if UpperCase(execParams.Items[i].AsString)=UpperCase(FindValue) then begin Result:=execParams.Items[i].Name;break;end;
end;
{------------------------------------------------------------------------------}
function FindTStringList(execList:TStringList;FindItem:String):boolean;
var i:integer;
begin
  Result:=false;
  if(not Assigned(execList))or(execList.Count=0) then exit;
  for i:=0 to execList.Count-1 do
          if UpperCase(execList[i])=UpperCase(FindItem)then begin Result:=true;break;end;
end;
{------------------------------------------------------------------------------}

{------------------------------------------------------------------------}
//      ������� TParam � ��������� ���� _Name � ����� _DataType
//      � ��������� � TParams
procedure ParamAdd(var Result:TParams;_Name:String;_DataType:TFieldType);
begin
     if not Assigned(Result) then Result:=TParams.Create;
     TParam.Create(Result,ptUnknown);
     Result[Result.Count-1].Name:=_Name;
     Result[Result.Count-1].DataType:=_DataType;
end;
{------------------------------------------------------------------------}
{------------------------------------------------------------------------------}
// ����� �� �������� ����� pParams ��������� � DataSet
function EqualParams_DataSet(pParams: TParams;DataSet: TDataSet): boolean;
var i: integer;
begin
   result:=true;
   with DataSet do begin
     for i:=0 to pParams.Count-1 do begin
        result:=result and (pParams[i].asString=FieldByName(pParams[i].Name).AsString);
     end;
   end;
end;
{------------------------------------------------------------------------}


end.
