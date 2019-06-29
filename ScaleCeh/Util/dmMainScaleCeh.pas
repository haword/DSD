unit dmMainScaleCeh;

interface

uses
  System.SysUtils, System.Classes, dsdDB, Data.DB, Datasnap.DBClient, Vcl.Dialogs,UtilScale;

type
  TDMMainScaleCehForm = class(TDataModule)
    ClientDataSet: TClientDataSet;
    spSelect: TdsdStoredProc;
    procedure DataModuleCreate(Sender: TObject);
  private
  public
    // Scale + ScaleCeh
    function gpSelect_ToolsWeighing_onLevelChild(inBranchCode:Integer;inLevelChild: String): TArrayList;
    function gpGet_ToolsWeighing_Value(inLevel1,inLevel2,inLevel3,inItemName,inDefaultValue:String):String;
    function gpGet_Scale_User:String;
    function gpGet_Scale_OperDate(var execParams:TParams):TDateTime;
    // Scale + ScaleCeh
    function gpSelect_Scale_GoodsKindWeighing: TArrayList;
    function gpGet_Scale_Goods(var execParams:TParams;inBarCode:String): Boolean;
    // Scale + ScaleCeh
    function gpUpdate_Scale_MI_Erased(MovementItemId:Integer;NewValue: Boolean): Boolean;
    function gpUpdate_Scale_MIFloat(execParams:TParams): Boolean;
    function gpUpdate_Scale_MIString(execParams:TParams): Boolean;
    function gpUpdate_Scale_MIDate(execParams:TParams): Boolean;
    function gpUpdate_Scale_MILinkObject(execParams:TParams): Boolean;

    // Scale + ScaleCeh
    function gpGet_Scale_Movement_checkId(var execParamsMovement:TParams): Boolean;
    function lpGet_BranchName(inBranchCode:Integer): String;
    // ScaleCeh
    function lpGet_UnitName(inUnitId:Integer): String;
    //
    // +++ScaleCeh+++
    function gpGet_ScaleCeh_Movement(var execParamsMovement:TParams;isLast,isNext:Boolean): Boolean;
    function gpGet_ScaleCeh_GoodsSeparate(inOperDate: TDateTime; inMovementId, inGoodsId : Integer; inPartionGoods : String;
                                      var TotalCount_in, TotalCount_null, TotalCount_MO, TotalCount_OB, TotalCount_PR, TotalCount_P : Double;
                                      var HeadCount_in, HeadCount_null, HeadCount_MO, HeadCount_OB, HeadCount_PR, HeadCount_P : Double;
                                      var PartionGoods_null, PartionGoods_MO, PartionGoods_OB, PartionGoods_PR, PartionGoods_P : String
                                         ):Boolean;
    function gpInsert_ScaleCeh_GoodsSeparate(retMovementId_begin, retMovementId : Integer;
                                             execParamsMovement:TParams;
                                             inOperDate: TDateTime; inGoodsId : Integer; inPartionGoods : String;
                                             inAmount, inHeadCount : Double
                                            ):Boolean;
    // +++ScaleCeh+++
    function gpInsertUpdate_ScaleCeh_Movement(var execParamsMovement:TParams): Boolean;
    function gpInsert_ScaleCeh_MI(var execParamsMovement:TParams;var execParamsMI:TParams): Boolean;
    function gpInsert_MovementCeh_all(var execParamsMovement:TParams): Boolean;
    function gpUpdate_ScaleCeh_Movement_ArticleLoss(execParams:TParams): Boolean;
    //
    //ScaleCeh
    function gpGet_ScaleCeh_Movement_checkPartion(var ValueStep_obv : Integer; MovementId,GoodsId:Integer;PartionGoods:String;OperCount:Double): Boolean;
    //ScaleCeh
    function gpGet_ScaleCeh_Movement_checkStorageLine(MovementId : Integer): String;
    //ScaleCeh - Light
    function gpGet_ScaleLight_Goods(var execParamsLight : TParams; inGoodsId, inGoodsKindId : Integer): Boolean;
    function gpGet_ScaleLight_BarCodeBox (num : Integer; execParamsLight : TParams):Boolean;

  end;

  function gpInitialize_Const: Boolean;//Scale + ScaleCeh
  function gpInitialize_Ini: Boolean;  //ScaleCeh
  function gpInitialize_SettingMain_Default: Boolean;//Scale + ScaleCeh

var
  DMMainScaleCehForm: TDMMainScaleCehForm;

implementation
uses Inifiles,TypInfo,DialogMovementDesc,UtilConst;
{$R *.dfm}
{------------------------------------------------------------------------}
procedure TDMMainScaleCehForm.DataModuleCreate(Sender: TObject);
begin
    //  gpInitialize_ParamsMovement;
    //
//!    Create_ParamsMovement(ParamsMovement);
    //
//!    gpGet_Scale_OperDate(ParamsMovement);
    //
    ///////Result:=
//!    DMMainScaleCehForm.gpGet_ScaleCeh_Movement(ParamsMovement,TRUE,FALSE);//isLast=TRUE,isNext=FALSE
end;
{------------------------------------------------------------------------}
{function gpInitialize_ParamsMovement: Boolean;
begin
    Result:=false;
    //
    Create_ParamsMovement(ParamsMovement);
    //
    gpGet_Scale_OperDate(ParamsMovement);
    //
    Result:=DMMainScaleCehForm.gpGet_ScaleCeh_Movement(ParamsMovement,TRUE,FALSE);//isLast=TRUE,isNext=FALSE
end;}
{------------------------------------------------------------------------}
function TDMMainScaleCehForm.gpGet_ScaleCeh_Movement(var execParamsMovement:TParams;isLast,isNext:Boolean): Boolean;
begin
    Result:=false;

    if (SettingMain.isModeSorting = TRUE) // and (1=0)
    then
      with spSelect do begin
         StoredProcName:='gpGet_ScaleLight_Movement';
         OutputType:=otDataSet;
         Params.Clear;

         if (isNext = TRUE)or(isLast = FALSE)//��� ������, �.�. ��� isLast = FALSE ���� ���������� MovementId
         then Params.AddParam('inMovementId', ftInteger, ptInput, execParamsMovement.ParamByName('MovementId').AsInteger)
         else Params.AddParam('inMovementId', ftInteger, ptInput, 0);
         Params.AddParam('inPlaceNumber', ftInteger, ptInput, SettingMain.PlaceNumber);
         Params.AddParam('inOperDate', ftDateTime, ptInput, execParamsMovement.ParamByName('OperDate').AsDateTime);
         Params.AddParam('inIsNext', ftBoolean, ptInput, isNext);

         //try
           Execute;

         //!!!�����, ���� �������������� ��� ������ ������ � ����� �����!!!
         if DataSet.RecordCount<>1 then begin Result:=false;exit;end;

         with execParamsMovement do
         begin
           ParamByName('MovementId_begin').AsInteger:= 0;

           ParamByName('MovementId').AsInteger:= DataSet.FieldByName('MovementId').asInteger;
           ParamByName('InvNumber').asString:= DataSet.FieldByName('InvNumber').asString;
           ParamByName('OperDate_Movement').asDateTime:= DataSet.FieldByName('OperDate').asDateTime;

           ParamByName('MovementDescNumber').AsInteger:= DataSet.FieldByName('MovementDescNumber').asInteger;

           ParamByName('MovementDescId').AsInteger:= DataSet.FieldByName('MovementDescId').asInteger;
           ParamByName('FromId').AsInteger:= DataSet.FieldByName('FromId').asInteger;
           ParamByName('FromCode').AsInteger:= DataSet.FieldByName('FromCode').asInteger;
           ParamByName('FromName').asString:= DataSet.FieldByName('FromName').asString;
           ParamByName('ToId').AsInteger:= DataSet.FieldByName('ToId').asInteger;
           ParamByName('ToCode').AsInteger:= DataSet.FieldByName('ToCode').asInteger;
           ParamByName('ToName').asString:= DataSet.FieldByName('ToName').asString;
           // !!!ParamsLight!!!
           ParamsLight.ParamByName('GoodsId').AsInteger  := DataSet.FieldByName('GoodsId').asInteger;
           ParamsLight.ParamByName('GoodsCode').AsInteger:= DataSet.FieldByName('GoodsCode').asInteger;
           ParamsLight.ParamByName('GoodsName').asString := DataSet.FieldByName('GoodsName').asString;
           ParamsLight.ParamByName('GoodsKindId').AsInteger  := DataSet.FieldByName('GoodsKindId').AsInteger;
           ParamsLight.ParamByName('GoodsKindCode').AsInteger:= DataSet.FieldByName('GoodsKindCode').asInteger;
           ParamsLight.ParamByName('GoodsKindName').asString := DataSet.FieldByName('GoodsKindName').asString;
           ParamsLight.ParamByName('MeasureId').AsInteger  := DataSet.FieldByName('MeasureId').AsInteger;
           ParamsLight.ParamByName('MeasureCode').AsInteger:= DataSet.FieldByName('MeasureCode').asInteger;
           ParamsLight.ParamByName('MeasureName').asString := DataSet.FieldByName('MeasureName').asString;
           // ������� ��������� - ������� ������
           ParamsLight.ParamByName('Count_box').AsInteger:= DataSet.FieldByName('Count_box').AsInteger;
           // Id - ���� �� ��.
           ParamsLight.ParamByName('GoodsTypeKindId_Sh').AsInteger := DataSet.FieldByName('GoodsTypeKindId_Sh').AsInteger;
           // Id - ���� �� ���.
           ParamsLight.ParamByName('GoodsTypeKindId_Nom').AsInteger:= DataSet.FieldByName('GoodsTypeKindId_Nom').AsInteger;
           // Id - ���� �� ���
           ParamsLight.ParamByName('GoodsTypeKindId_Ves').AsInteger:= DataSet.FieldByName('GoodsTypeKindId_Ves').AsInteger;
           // ��� ���
           ParamsLight.ParamByName('WmsCode_Sh').asString := DataSet.FieldByName('WmsCode_Sh').asString;
           ParamsLight.ParamByName('WmsCode_Nom').asString:= DataSet.FieldByName('WmsCode_Nom').asString;
           ParamsLight.ParamByName('WmsCode_Ves').asString:= DataSet.FieldByName('WmsCode_Ves').asString;
           // ����������� ��� 1��.
           ParamsLight.ParamByName('WeightMin').AsFloat:= DataSet.FieldByName('WeightMin').AsFloat;
           // ������������ ��� 1��.
           ParamsLight.ParamByName('WeightMax').AsFloat:= DataSet.FieldByName('WeightMax').AsFloat;

           //1-�� ����� - ������ ���� ����
           ParamsLight.ParamByName('GoodsTypeKindId_1').AsInteger := DataSet.FieldByName('GoodsTypeKindId_1').AsInteger;
           ParamsLight.ParamByName('BarCodeBoxId_1').AsInteger    := DataSet.FieldByName('BarCodeBoxId_1').AsInteger;
           ParamsLight.ParamByName('BoxCode_1').AsInteger         := DataSet.FieldByName('BoxCode_1').AsInteger;
           ParamsLight.ParamByName('BoxBarCode_1').AsString       := DataSet.FieldByName('BoxBarCode_1').AsString;
        // ParamsLight.ParamByName('WeightOnBoxTotal_1').asFloat  := 0; // ��� ����� ������������� (� ���������� �����) - ��� ���������� ����� �����
        // ParamsLight.ParamByName('CountOnBoxTotal_1').asFloat   := 0; // �� ����� ������������ (� ���������� �����) - ������������?
        // ParamsLight.ParamByName('WeightTotal_1').asFloat       := 0; // ��� ����� ������������� (� �������� ������) - ������������
        // ParamsLight.ParamByName('CountTotal_1').asFloat        := 0; // �� ����� ������������� (� �������� ������) - ������������
        // ParamsLight.ParamByName('BoxTotal_1').asFloat          := 0; // ������ ����� (��������) - ������������

           ParamsLight.ParamByName('BoxId_1').AsInteger           := DataSet.FieldByName('BoxId_1').AsInteger;
           ParamsLight.ParamByName('BoxName_1').asString          := DataSet.FieldByName('BoxName_1').asString;
           ParamsLight.ParamByName('BoxWeight_1').asFloat         := DataSet.FieldByName('BoxWeight_1').asFloat;   // ��� ������ �����
           ParamsLight.ParamByName('WeightOnBox_1').asFloat       := DataSet.FieldByName('WeightOnBox_1').asFloat; // ����������� - ���
           ParamsLight.ParamByName('CountOnBox_1').asFloat        := DataSet.FieldByName('CountOnBox_1').asFloat;  // ����������� - �� (������������?)
           ParamsLight.ParamByName('isFull_1').AsBoolean          := FALSE;

           //2-�� ����� - ������ ���� ����
           ParamsLight.ParamByName('GoodsTypeKindId_2').AsInteger := DataSet.FieldByName('GoodsTypeKindId_2').AsInteger;
           ParamsLight.ParamByName('BarCodeBoxId_2').AsInteger    := DataSet.FieldByName('BarCodeBoxId_2').AsInteger;
           ParamsLight.ParamByName('BoxCode_2').AsInteger         := DataSet.FieldByName('BoxCode_2').AsInteger;
           ParamsLight.ParamByName('BoxBarCode_2').AsString       := DataSet.FieldByName('BoxBarCode_2').AsString;
        // ParamsLight.ParamByName('WeightOnBoxTotal_2').asFloat  := 0; // ��� ����� ������������� (� ���������� �����) - ��� ���������� ����� �����
        // ParamsLight.ParamByName('CountOnBoxTotal_2').asFloat   := 0; // �� ����� ������������ (� ���������� �����) - ������������?
        // ParamsLight.ParamByName('WeightTotal_2').asFloat       := 0; // ��� ����� ������������� (� �������� ������) - ������������
        // ParamsLight.ParamByName('CountTotal_2').asFloat        := 0; // �� ����� ������������� (� �������� ������) - ������������
        // ParamsLight.ParamByName('BoxTotal_2').asFloat          := 0; // ������ ����� (��������) - ������������
           ParamsLight.ParamByName('isFull_2').AsBoolean          := FALSE;

           ParamsLight.ParamByName('BoxId_2').AsInteger           := DataSet.FieldByName('BoxId_2').AsInteger;
           ParamsLight.ParamByName('BoxName_2').asString          := DataSet.FieldByName('BoxName_2').asString;
           ParamsLight.ParamByName('BoxWeight_2').asFloat         := DataSet.FieldByName('BoxWeight_2').asFloat;   // ��� ������ �����
           ParamsLight.ParamByName('WeightOnBox_2').asFloat       := DataSet.FieldByName('WeightOnBox_2').asFloat; // ����������� - ���
           ParamsLight.ParamByName('CountOnBox_2').asFloat        := DataSet.FieldByName('CountOnBox_2').asFloat;  // ����������� - �� (������������?)

            //3-�� ����� - ������ ���� ����
           ParamsLight.ParamByName('GoodsTypeKindId_3').AsInteger := DataSet.FieldByName('GoodsTypeKindId_3').AsInteger;
           ParamsLight.ParamByName('BarCodeBoxId_3').AsInteger    := DataSet.FieldByName('BarCodeBoxId_3').AsInteger;
           ParamsLight.ParamByName('BoxCode_3').AsInteger         := DataSet.FieldByName('BoxCode_3').AsInteger;
           ParamsLight.ParamByName('BoxBarCode_3').AsString       := DataSet.FieldByName('BoxBarCode_3').AsString;
        // ParamsLight.ParamByName('WeightOnBoxTotal_3').asFloat  := 0; // ��� ����� ������������� (� ���������� �����) - ��� ���������� ����� �����
        // ParamsLight.ParamByName('CountOnBoxTotal_3').asFloat   := 0; // �� ����� ������������ (� ���������� �����) - ������������?
        // ParamsLight.ParamByName('WeightTotal_3').asFloat       := 0; // ��� ����� ������������� (� �������� ������) - ������������
        // ParamsLight.ParamByName('CountTotal_3').asFloat        := 0; // �� ����� ������������� (� �������� ������) - ������������
        // ParamsLight.ParamByName('BoxTotal_3').asFloat          := 0; // ������ ����� (��������) - ������������
           ParamsLight.ParamByName('isFull_3').AsBoolean          := FALSE;

           ParamsLight.ParamByName('BoxId_3').AsInteger           := DataSet.FieldByName('BoxId_3').AsInteger;
           ParamsLight.ParamByName('BoxName_3').asString          := DataSet.FieldByName('BoxName_3').asString;
           ParamsLight.ParamByName('BoxWeight_3').asFloat         := DataSet.FieldByName('BoxWeight_3').asFloat;   // ��� ������ �����
           ParamsLight.ParamByName('WeightOnBox_3').asFloat       := DataSet.FieldByName('WeightOnBox_3').asFloat; // ����������� - ���
           ParamsLight.ParamByName('CountOnBox_3').asFloat        := DataSet.FieldByName('CountOnBox_3').asFloat;  // ����������� - �� (������������?)

         end;
      end
    else
      with spSelect do
      begin
         StoredProcName:='gpGet_ScaleCeh_Movement';
         OutputType:=otDataSet;
         Params.Clear;

         if (isNext = TRUE)or(isLast = FALSE)//��� ������, �.�. ��� isLast = FALSE ���� ���������� MovementId
         then Params.AddParam('inMovementId', ftInteger, ptInput, execParamsMovement.ParamByName('MovementId').AsInteger)
         else Params.AddParam('inMovementId', ftInteger, ptInput, 0);
         Params.AddParam('inOperDate', ftDateTime, ptInput, execParamsMovement.ParamByName('OperDate').AsDateTime);
         Params.AddParam('inIsNext', ftBoolean, ptInput, isNext);

         //try
           Execute;

         //!!!�����, ���� �������������� ��� ������ ������ � ����� �����!!!
         if DataSet.RecordCount<>1 then begin Result:=false;exit;end;


         with execParamsMovement do
         begin
           ParamByName('MovementId_begin').AsInteger:= 0;

           ParamByName('MovementId').AsInteger:= DataSet.FieldByName('MovementId').asInteger;
           ParamByName('InvNumber').asString:= DataSet.FieldByName('InvNumber').asString;
           ParamByName('OperDate_Movement').asDateTime:= DataSet.FieldByName('OperDate').asDateTime;

           ParamByName('MovementDescNumber').AsInteger:= DataSet.FieldByName('MovementDescNumber').asInteger;

           ParamByName('MovementDescId').AsInteger:= DataSet.FieldByName('MovementDescId').asInteger;
           ParamByName('FromId').AsInteger:= DataSet.FieldByName('FromId').asInteger;
           ParamByName('FromCode').AsInteger:= DataSet.FieldByName('FromCode').asInteger;
           ParamByName('FromName').asString:= DataSet.FieldByName('FromName').asString;
           ParamByName('ToId').AsInteger:= DataSet.FieldByName('ToId').asInteger;
           ParamByName('ToCode').AsInteger:= DataSet.FieldByName('ToCode').asInteger;
           ParamByName('ToName').asString:= DataSet.FieldByName('ToName').asString;

         end;

         {except
           result.Code := Code;
           result.Id   := 0;
           result.Name := '';
           ShowMessage('������ ��������� - gpMovementDesc');
         end;}
      end;

    Result:=true;
end;
{------------------------------------------------------------------------}
function TDMMainScaleCehForm.gpGet_Scale_Movement_checkId(var execParamsMovement:TParams): Boolean;
begin
    Result:=false;
    if execParamsMovement.ParamByName('MovementId').AsInteger<>0 then
    with spSelect do begin
       StoredProcName:='gpGet_Scale_Movement_checkId';
       OutputType:=otDataSet;
       Params.Clear;
       Params.AddParam('inMovementId', ftInteger, ptInput, execParamsMovement.ParamByName('MovementId').AsInteger);
       //try
         Execute;
         Result:=DataSet.FieldByName('isOk').asBoolean;
         execParamsMovement.ParamByName('isMovementId_check').asBoolean:=DataSet.FieldByName('isOk').asBoolean
       {except
         Result := '';
         ShowMessage('������ ��������� - gpGet_Scale_Movement_checkId');
       end;}
    end;
end;
{------------------------------------------------------------------------}
function TDMMainScaleCehForm.gpGet_ScaleCeh_Movement_checkStorageLine(MovementId : Integer): String;
begin
    with spSelect do begin
       StoredProcName:='gpGet_ScaleCeh_Movement_checkStorageLine';
       OutputType:=otDataSet;
       Params.Clear;
       Params.AddParam('inMovementId', ftInteger, ptInput, MovementId);
       //try
       Execute;
       if DataSet.FieldByName('isStorageLine_empty').asBoolean = TRUE
       then Result:= ''
       else Result:= DataSet.FieldByName('MessageStr').asString
    end;
end;
{------------------------------------------------------------------------}
function TDMMainScaleCehForm.gpGet_ScaleCeh_Movement_checkPartion(var ValueStep_obv : Integer; MovementId,GoodsId:Integer;PartionGoods:String;OperCount:Double): Boolean;
begin
    Result:=false;
    with spSelect do begin
       StoredProcName:='gpGet_ScaleCeh_Movement_checkPartion';
       OutputType:=otDataSet;
       Params.Clear;
       Params.AddParam('inMovementId', ftInteger, ptInput, MovementId);
       Params.AddParam('inGoodsId', ftInteger, ptInput, GoodsId);
       Params.AddParam('inPartionGoods', ftString, ptInput, PartionGoods);
       Params.AddParam('inOperCount', ftFloat, ptInput, OperCount);
       Params.AddParam('inValueStep', ftInteger, ptInput, ValueStep_obv);
       //try
         Execute;
         Result:=(DataSet.FieldByName('Code').asInteger = 0) or (DataSet.FieldByName('ValueStep').asInteger > 2);
         if DataSet.FieldByName('ValueStep').asInteger > 0 then ValueStep_obv:= DataSet.FieldByName('ValueStep').asInteger;
         //execParamsMovement.ParamByName('MessageCode').AsInteger:= DataSet.FieldByName('Code').AsInteger;
         //execParamsMovement.ParamByName('MessageStr').AsString:= DataSet.FieldByName('MessageStr').AsString;
       {except
         Result := '';
         ShowMessage('������ ��������� - gpGet_ScaleCeh_Movement_checkPartion');
       end;}
    end;

    if not Result
    then
        if spSelect.DataSet.FieldByName('Code').asInteger = 1
        then if ValueStep_obv > 0
             then ShowMessage('('+IntToStr(ValueStep_obv)+') ' + spSelect.DataSet.FieldByName('MessageStr').AsString)
             else ShowMessage(spSelect.DataSet.FieldByName('MessageStr').AsString)
        else Result:=MessageDlg(spSelect.DataSet.FieldByName('MessageStr').AsString,mtConfirmation,mbYesNoCancel,0) = 6;
end;
{------------------------------------------------------------------------}
function TDMMainScaleCehForm.gpUpdate_Scale_MIFloat(execParams:TParams): Boolean;
begin
    Result:=false;

    with spSelect do begin
       StoredProcName:= 'gpUpdate_Scale_MIFloat';
       OutputType:=otResult;
       Params.Clear;
       Params.AddParam('inMovementItemId', ftInteger, ptInput, execParams.ParamByName('inMovementItemId').AsInteger);
       Params.AddParam('inDescCode', ftString, ptInput, execParams.ParamByName('inDescCode').AsString);
       Params.AddParam('inValueData', ftFloat, ptInput, execParams.ParamByName('inValueData').AsFloat);
       //try
         Execute;
       {except
         Result := '';
         ShowMessage('������ ��������� - gpUpdate_Scale_MIFloat');
       end;}
    end;
    Result:=true;
end;
{------------------------------------------------------------------------}
function TDMMainScaleCehForm.gpUpdate_Scale_MIString(execParams:TParams): Boolean;
begin
    Result:=false;

    with spSelect do begin
       StoredProcName:= 'gpUpdate_Scale_MIString';
       OutputType:=otResult;
       Params.Clear;
       Params.AddParam('inMovementItemId', ftInteger, ptInput, execParams.ParamByName('inMovementItemId').AsInteger);
       Params.AddParam('inDescCode', ftString, ptInput, execParams.ParamByName('inDescCode').AsString);
       Params.AddParam('inValueData', ftString, ptInput, execParams.ParamByName('inValueData').AsString);
       //try
         Execute;
       {except
         Result := '';
         ShowMessage('������ ��������� - gpUpdate_Scale_MIString');
       end;}
    end;
    Result:=true;
end;
{------------------------------------------------------------------------}
function TDMMainScaleCehForm.gpUpdate_Scale_MIDate(execParams:TParams): Boolean;
begin
    Result:=false;

    with spSelect do begin
       StoredProcName:= 'gpUpdate_Scale_MIDate';
       OutputType:=otResult;
       Params.Clear;
       Params.AddParam('inMovementItemId', ftInteger, ptInput, execParams.ParamByName('inMovementItemId').AsInteger);
       Params.AddParam('inDescCode', ftString, ptInput, execParams.ParamByName('inDescCode').AsString);
       Params.AddParam('inValueData', ftDateTime, ptInput, execParams.ParamByName('inValueData').AsDateTime);
       //try
         Execute;
       {except
         Result := '';
         ShowMessage('������ ��������� - gpUpdate_Scale_MIDate');
       end;}
    end;
    Result:=true;
end;
{------------------------------------------------------------------------}
function TDMMainScaleCehForm.gpUpdate_Scale_MILinkObject(execParams:TParams): Boolean;
begin
    Result:=false;

    with spSelect do begin
       StoredProcName:= 'gpUpdate_Scale_MILinkObject';
       OutputType:=otResult;
       Params.Clear;
       Params.AddParam('inMovementItemId', ftInteger, ptInput, execParams.ParamByName('inMovementItemId').AsInteger);
       Params.AddParam('inDescCode', ftString, ptInput, execParams.ParamByName('inDescCode').AsString);
       Params.AddParam('inObjectId', ftInteger, ptInput, execParams.ParamByName('inObjectId').AsInteger);
       //try
         Execute;
       {except
         Result := '';
         ShowMessage('������ ��������� - gpUpdate_Scale_MILinkObject');
       end;}
    end;
    Result:=true;
end;
{------------------------------------------------------------------------}
function TDMMainScaleCehForm.gpUpdate_ScaleCeh_Movement_ArticleLoss(execParams:TParams): Boolean;
begin
    Result:=false;
    with spSelect do begin
       StoredProcName:='gpUpdate_ScaleCeh_Movement_ArticleLoss';
       OutputType:=otResult;
       Params.Clear;
       Params.AddParam('inMovementId', ftInteger, ptInput, execParams.ParamByName('MovementId').AsInteger);
       Params.AddParam('inArticleLossId', ftInteger, ptInput, execParams.ParamByName('ArticleLossId').AsInteger);
       //try
         Execute;
       {except
         Result := '';
         ShowMessage('������ ��������� - gpUpdate_ScaleCeh_Movement_ArticleLoss');
       end;}
    end;
    Result:=true;
end;
{------------------------------------------------------------------------}
function TDMMainScaleCehForm.gpInsert_MovementCeh_all(var execParamsMovement:TParams): Boolean;
begin
    Result:=false;
    with spSelect do begin
       StoredProcName:='gpInsert_ScaleCeh_Movement_all';
       OutputType:=otDataSet;
       Params.Clear;
       Params.AddParam('inBranchCode', ftInteger, ptInput, SettingMain.BranchCode);
       Params.AddParam('inMovementId', ftInteger, ptInput, execParamsMovement.ParamByName('MovementId').AsInteger);
       Params.AddParam('inOperDate', ftDateTime, ptInput, execParamsMovement.ParamByName('OperDate').AsDateTime);
       //try
         Execute;
         execParamsMovement.ParamByName('MovementId_begin').AsInteger:=DataSet.FieldByName('MovementId_begin').asInteger;
       {except
         Result := '';
         ShowMessage('������ ��������� - gpInsert_ScaleCeh_Movement_all');
       end;}
    end;
    Result:=true;
end;
{------------------------------------------------------------------------}
function TDMMainScaleCehForm.gpInsertUpdate_ScaleCeh_Movement(var execParamsMovement:TParams): Boolean;
begin
    Result:=false;
    if SettingMain.isModeSorting = TRUE
    then
      with spSelect do begin
         StoredProcName:='gpInsertUpdate_ScaleLight_Movement';
         OutputType:=otDataSet;
         Params.Clear;
         Params.AddParam('inId', ftInteger, ptInputOutput, execParamsMovement.ParamByName('MovementId').AsInteger);
         Params.AddParam('inOperDate', ftDateTime, ptInput, execParamsMovement.ParamByName('OperDate').AsDateTime);
         Params.AddParam('inMovementDescId', ftInteger, ptInput, execParamsMovement.ParamByName('MovementDescId').AsInteger);
         Params.AddParam('inMovementDescNumber', ftInteger, ptInput, execParamsMovement.ParamByName('MovementDescNumber').AsInteger);
         Params.AddParam('inFromId', ftInteger, ptInput, execParamsMovement.ParamByName('FromId').AsInteger);
         Params.AddParam('inToId', ftInteger, ptInput, execParamsMovement.ParamByName('ToId').AsInteger);
         Params.AddParam('inGoodsTypeKindId_1', ftInteger, ptInput, ParamsLight.ParamByName('GoodsTypeKindId_1').AsInteger);
         Params.AddParam('inGoodsTypeKindId_2', ftInteger, ptInput, ParamsLight.ParamByName('GoodsTypeKindId_2').AsInteger);
         Params.AddParam('inGoodsTypeKindId_3', ftInteger, ptInput, ParamsLight.ParamByName('GoodsTypeKindId_3').AsInteger);
         Params.AddParam('inBarCodeBoxId_1', ftInteger, ptInput, ParamsLight.ParamByName('BarCodeBoxId_1').AsInteger);
         Params.AddParam('inBarCodeBoxId_2', ftInteger, ptInput, ParamsLight.ParamByName('BarCodeBoxId_2').AsInteger);
         Params.AddParam('inBarCodeBoxId_3', ftInteger, ptInput, ParamsLight.ParamByName('BarCodeBoxId_3').AsInteger);
         Params.AddParam('inGoodsId', ftInteger, ptInput, ParamsLight.ParamByName('GoodsId').AsInteger);
         Params.AddParam('inGoodsKindId', ftInteger, ptInput, ParamsLight.ParamByName('GoodsKindId').AsInteger);
         Params.AddParam('inBranchCode', ftInteger, ptInput, SettingMain.BranchCode);
         Params.AddParam('inPlaceNumber', ftInteger, ptInput, SettingMain.PlaceNumber);
         //try
           Execute;
           execParamsMovement.ParamByName('MovementId').AsInteger:=DataSet.FieldByName('Id').asInteger;
           execParamsMovement.ParamByName('InvNumber').AsString:=DataSet.FieldByName('InvNumber').AsString;
           execParamsMovement.ParamByName('OperDate_Movement').AsString:=DataSet.FieldByName('OperDate').AsString;
         {except
           Result := '';
           ShowMessage('������ ��������� - gpInsertUpdate_ScaleCeh_Movement');
         end;}
      end
    else
      with spSelect do begin
         StoredProcName:='gpInsertUpdate_ScaleCeh_Movement';
         OutputType:=otDataSet;
         Params.Clear;
         Params.AddParam('inId', ftInteger, ptInputOutput, execParamsMovement.ParamByName('MovementId').AsInteger);
         Params.AddParam('inOperDate', ftDateTime, ptInput, execParamsMovement.ParamByName('OperDate').AsDateTime);
         Params.AddParam('inMovementDescId', ftInteger, ptInput, execParamsMovement.ParamByName('MovementDescId').AsInteger);
         Params.AddParam('inMovementDescNumber', ftInteger, ptInput, execParamsMovement.ParamByName('MovementDescNumber').AsInteger);
         Params.AddParam('inFromId', ftInteger, ptInput, execParamsMovement.ParamByName('FromId').AsInteger);
         Params.AddParam('inToId', ftInteger, ptInput, execParamsMovement.ParamByName('ToId').AsInteger);
         Params.AddParam('inIsProductionIn', ftBoolean, ptInput, execParamsMovement.ParamByName('isSendOnPriceIn').AsBoolean);
         Params.AddParam('inBranchCode', ftInteger, ptInput, SettingMain.BranchCode);
         //try
           Execute;
           execParamsMovement.ParamByName('MovementId').AsInteger:=DataSet.FieldByName('Id').asInteger;
           execParamsMovement.ParamByName('InvNumber').AsString:=DataSet.FieldByName('InvNumber').AsString;
           execParamsMovement.ParamByName('OperDate_Movement').AsString:=DataSet.FieldByName('OperDate').AsString;
         {except
           Result := '';
           ShowMessage('������ ��������� - gpInsertUpdate_ScaleCeh_Movement');
         end;}
      end;
    Result:=true;
end;
{------------------------------------------------------------------------}
function TDMMainScaleCehForm.gpInsert_ScaleCeh_MI(var execParamsMovement:TParams;var execParamsMI:TParams): Boolean;
begin
    if execParamsMovement.ParamByName('MovementId').AsInteger = 0
    then Result:= gpInsertUpdate_ScaleCeh_Movement(execParamsMovement)
    else Result:= true;
    //
    if Result
    then
      if SettingMain.isModeSorting = TRUE
      then
        with spSelect do begin
           StoredProcName:='gpInsert_ScaleLight_MI';
           OutputType:=otDataSet;
           Params.Clear;
           Params.AddParam('inId', ftInteger, ptInput, 0);
           Params.AddParam('inMovementId', ftInteger, ptInput, execParamsMovement.ParamByName('MovementId').AsInteger);
           Params.AddParam('inGoodsId', ftInteger, ptInput, ParamsLight.ParamByName('GoodsId').AsInteger);
           Params.AddParam('inGoodsKindId', ftInteger, ptInput, ParamsLight.ParamByName('GoodsKindId').AsInteger);
           Params.AddParam('inMeasureId', ftInteger, ptInput, ParamsLight.ParamByName('MeasureId').AsInteger);

           Params.AddParam('inWmsCode_Sh',  ftString, ptInput, ParamsLight.ParamByName('WmsCode_Sh').AsString);
           Params.AddParam('inWmsCode_Nom', ftString, ptInput, ParamsLight.ParamByName('WmsCode_Nom').AsString);
           Params.AddParam('inWmsCode_Ves', ftString, ptInput, ParamsLight.ParamByName('WmsCode_Ves').AsString);
           // Id - ���� �� ��.
           Params.AddParam('inGoodsTypeKindId_Sh', ftInteger, ptInput, ParamsLight.ParamByName('GoodsTypeKindId_Sh').AsInteger);
           // Id - ���� �� ���.
           Params.AddParam('inGoodsTypeKindId_Nom', ftInteger, ptInput, ParamsLight.ParamByName('GoodsTypeKindId_Nom').AsInteger);
           // Id - ���� �� ���
           Params.AddParam('inGoodsTypeKindId_Ves', ftInteger, ptInput, ParamsLight.ParamByName('GoodsTypeKindId_Ves').AsInteger);

           //1-�� ����� - ������ ���� ����
           Params.AddParam('inGoodsTypeKindId_1', ftInteger, ptInput, ParamsLight.ParamByName('GoodsTypeKindId_1').AsInteger);
           Params.AddParam('inBarCodeBoxId_1', ftInteger, ptInput, ParamsLight.ParamByName('BarCodeBoxId_1').AsInteger);
           if SettingMain.isLightLEFT_321 = TRUE
           then Params.AddParam('inLineCode_1', ftInteger, ptInput, 1)
           else Params.AddParam('inLineCode_1', ftInteger, ptInput, 3);
           // ����������� - ���
           Params.AddParam('inWeightOnBox_1', ftFloat, ptInput, ParamsLight.ParamByName('WeightOnBox_1').asFloat);
           // ����������� - �� (������������?)
           Params.AddParam('inCountOnBox_1', ftFloat, ptInput, ParamsLight.ParamByName('CountOnBox_1').asFloat);

           //2-�� ����� - ������ ���� ����
           Params.AddParam('inGoodsTypeKindId_2', ftInteger, ptInput, ParamsLight.ParamByName('GoodsTypeKindId_2').AsInteger);
           Params.AddParam('inBarCodeBoxId_2', ftInteger, ptInput, ParamsLight.ParamByName('BarCodeBoxId_2').AsInteger);
           Params.AddParam('inLineCode_2', ftInteger, ptInput, 2);
           // ����������� - ���
           Params.AddParam('inWeightOnBox_2', ftFloat, ptInput, ParamsLight.ParamByName('WeightOnBox_2').asFloat);
           // ����������� - �� (������������?)
           Params.AddParam('inCountOnBox_2', ftFloat, ptInput, ParamsLight.ParamByName('CountOnBox_2').asFloat);

            //3-�� ����� - ������ ���� ����
           Params.AddParam('inGoodsTypeKindId_3', ftInteger, ptInput, ParamsLight.ParamByName('GoodsTypeKindId_3').AsInteger);
           Params.AddParam('inBarCodeBoxId_3', ftInteger, ptInput, ParamsLight.ParamByName('BarCodeBoxId_3').AsInteger);
           if SettingMain.isLightLEFT_321 = TRUE
           then Params.AddParam('inLineCode_3', ftInteger, ptInput, 3)
           else Params.AddParam('inLineCode_3', ftInteger, ptInput, 1);
           // ����������� - ���
           Params.AddParam('inWeightOnBox_3', ftFloat, ptInput, ParamsLight.ParamByName('WeightOnBox_3').asFloat);
           // ����������� - �� (������������?)
           Params.AddParam('inCountOnBox_3', ftFloat, ptInput, ParamsLight.ParamByName('CountOnBox_3').asFloat);

           // ����������� ��� 1��.
           Params.AddParam('inWeightMin', ftFloat, ptInput, ParamsLight.ParamByName('WeightMin').AsFloat);
           // ������������ ��� 1��.
           Params.AddParam('inWeightMax', ftFloat, ptInput, ParamsLight.ParamByName('WeightMin').AsFloat);

           Params.AddParam('inAmount', ftFloat, ptInput, 1);
           Params.AddParam('inRealWeight', ftFloat, ptInput, execParamsMI.ParamByName('RealWeight').AsFloat);
           Params.AddParam('inBranchCode', ftInteger, ptInput, SettingMain.BranchCode);
           //try
             Result:= false;
             Execute;
             Result:= true;
           {except
             Result := '';
             ShowMessage('������ ��������� - gpInsert_ScaleCeh_MI');
           end;}
           //
           // ������� ����� ��������
           ParamsLight.ParamByName('isFull_1').asBoolean:= DataSet.FieldByName('isFull_1').asBoolean;
           ParamsLight.ParamByName('isFull_2').asBoolean:= DataSet.FieldByName('isFull_2').asBoolean;
           ParamsLight.ParamByName('isFull_3').asBoolean:= DataSet.FieldByName('isFull_3').asBoolean;
           // ������� � �����, ��� � ����������
           if (SettingMain.isLightLEFT_321 = false) and (DataSet.FieldByName('LineCode').asInteger = 3)
           then ParamsLight.ParamByName('LineCode_begin').asInteger:= 1
           else if (SettingMain.isLightLEFT_321 = false) and (DataSet.FieldByName('LineCode').asInteger = 1)
           then ParamsLight.ParamByName('LineCode_begin').asInteger:= 3
           else ParamsLight.ParamByName('LineCode_begin').asInteger:=DataSet.FieldByName('LineCode').asInteger;
           //
           // ���� ���������� ����_1, ���� ����� �������� ��� ���� �����
           if ParamsLight.ParamByName('isFull_1').asBoolean = TRUE then
           begin
             ParamsLight.ParamByName('BarCodeBoxId_1').AsInteger    := 0;
             ParamsLight.ParamByName('BoxCode_1').AsInteger         := 0;
             ParamsLight.ParamByName('BoxBarCode_1').AsString       := '';
             // ��� ����� ������������� (� ���������� �����) - ��� ���������� ����� �����
             ParamsLight.ParamByName('WeightOnBoxTotal_1').AsFloat:= DataSet.FieldByName('WeightOnBox').AsFloat;
             // �� ����� ������������ (� ���������� �����) - ������������?
             ParamsLight.ParamByName('CountOnBoxTotal_1').AsFloat := DataSet.FieldByName('CountOnBox').AsFloat;
           end;
           // ���� ���������� ����_2, ���� ����� �������� ��� ���� �����
           if ParamsLight.ParamByName('isFull_2').asBoolean = TRUE then
           begin
             ParamsLight.ParamByName('BarCodeBoxId_2').AsInteger    := 0;
             ParamsLight.ParamByName('BoxCode_2').AsInteger         := 0;
             ParamsLight.ParamByName('BoxBarCode_2').AsString       := '';
             // ��� ����� ������������� (� ���������� �����) - ��� ���������� ����� �����
             ParamsLight.ParamByName('WeightOnBoxTotal_2').AsFloat:= DataSet.FieldByName('WeightOnBox').AsFloat;
             // �� ����� ������������ (� ���������� �����) - ������������?
             ParamsLight.ParamByName('CountOnBoxTotal_2').AsFloat := DataSet.FieldByName('CountOnBox').AsFloat;
           end;
           // ���� ���������� ����_3, ���� ����� �������� ��� ���� �����
           if ParamsLight.ParamByName('isFull_3').asBoolean = TRUE then
           begin
             ParamsLight.ParamByName('BarCodeBoxId_3').AsInteger    := 0;
             ParamsLight.ParamByName('BoxCode_3').AsInteger         := 0;
             ParamsLight.ParamByName('BoxBarCode_3').AsString       := '';
             // ��� ����� ������������� (� ���������� �����) - ��� ���������� ����� �����
             ParamsLight.ParamByName('WeightOnBoxTotal_3').AsFloat:= DataSet.FieldByName('WeightOnBox').AsFloat;
             // �� ����� ������������ (� ���������� �����) - ������������?
             ParamsLight.ParamByName('CountOnBoxTotal_3').AsFloat := DataSet.FieldByName('CountOnBox').AsFloat;
           end;

        end
      else
        with spSelect do begin
           StoredProcName:='gpInsert_ScaleCeh_MI';
           OutputType:=otDataSet;
           Params.Clear;
           Params.AddParam('inId', ftInteger, ptInput, 0);
           Params.AddParam('inMovementId', ftInteger, ptInput, execParamsMovement.ParamByName('MovementId').AsInteger);
           Params.AddParam('inGoodsId', ftInteger, ptInput, execParamsMI.ParamByName('GoodsId').AsInteger);
           Params.AddParam('inGoodsKindId', ftInteger, ptInput, execParamsMI.ParamByName('GoodsKindId').AsInteger);
           Params.AddParam('inStorageLineId', ftInteger, ptInput, execParamsMI.ParamByName('StorageLineId').AsInteger);
           Params.AddParam('inIsStartWeighing', ftBoolean, ptInput, execParamsMI.ParamByName('isStartWeighing').AsBoolean);
           Params.AddParam('inIsPartionGoodsDate', ftBoolean, ptInput, execParamsMovement.ParamByName('isPartionGoodsDate').AsBoolean);
           Params.AddParam('inOperCount', ftFloat, ptInput, execParamsMI.ParamByName('OperCount').AsFloat);
           Params.AddParam('inRealWeight', ftFloat, ptInput, execParamsMI.ParamByName('RealWeight').AsFloat);
           Params.AddParam('inWeightTare', ftFloat, ptInput, execParamsMI.ParamByName('WeightTare').AsFloat);
           Params.AddParam('inLiveWeight', ftFloat, ptInput, execParamsMI.ParamByName('LiveWeight').AsFloat);
           Params.AddParam('inHeadCount', ftFloat, ptInput, execParamsMI.ParamByName('HeadCount').AsFloat);
           Params.AddParam('inCount', ftFloat, ptInput, execParamsMI.ParamByName('Count').AsFloat);
           Params.AddParam('inCountPack', ftFloat, ptInput, execParamsMI.ParamByName('CountPack').AsFloat);
           Params.AddParam('inCountSkewer1', ftFloat, ptInput, execParamsMI.ParamByName('CountSkewer1').AsFloat);
           Params.AddParam('inWeightSkewer1', ftFloat, ptInput, SettingMain.WeightSkewer1);
           Params.AddParam('inCountSkewer2', ftFloat, ptInput, execParamsMI.ParamByName('CountSkewer2').AsFloat);
           Params.AddParam('inWeightSkewer2', ftFloat, ptInput, SettingMain.WeightSkewer2);
           Params.AddParam('inWeightOther', ftFloat, ptInput, execParamsMI.ParamByName('WeightOther').AsFloat);
           Params.AddParam('inPartionGoodsDate', ftDateTime, ptInput, execParamsMI.ParamByName('PartionGoodsDate').AsDateTime);
           Params.AddParam('inPartionGoods', ftString, ptInput, execParamsMI.ParamByName('PartionGoods').AsString);
           Params.AddParam('inBranchCode', ftInteger, ptInput, SettingMain.BranchCode);
           //try
             Execute;
           {except
             Result := '';
             ShowMessage('������ ��������� - gpInsert_ScaleCeh_MI');
           end;}
        end;

end;
{------------------------------------------------------------------------}
function TDMMainScaleCehForm.gpUpdate_Scale_MI_Erased(MovementItemId:Integer;NewValue: Boolean): Boolean;
begin
    Result:= false;
    //
    with spSelect do begin
       StoredProcName:='gpUpdate_Scale_MI_Erased';
       OutputType:=otDataSet;
       Params.Clear;
       Params.AddParam('inMovementItemId', ftInteger, ptInput, MovementItemId);
       Params.AddParam('inIsErased', ftBoolean, ptInput, NewValue);
       //try
         Execute;
         ParamsMovement.ParamByName('TotalSumm').AsFloat:=DataSet.FieldByName('TotalSumm').AsFloat;
       {except
         Result := '';
         ShowMessage('������ ��������� - gpUpdate_ScaleCeh_MI_Erased');
       end;}
    end;

end;
{------------------------------------------------------------------------}
function TDMMainScaleCehForm.gpSelect_ToolsWeighing_onLevelChild(inBranchCode:Integer;inLevelChild: String): TArrayList;
var i: integer;
begin
    with spSelect do
    begin
       StoredProcName:='gpSelect_Object_ToolsWeighing_onLevelChild';
       OutputType:=otDataSet;
       Params.Clear;
       Params.AddParam('inIsCeh', ftBoolean, ptInput, SettingMain.isCeh);
       Params.AddParam('inBranchCode', ftInteger, ptInput, inBranchCode);
       Params.AddParam('inLevelChild', ftString, ptInput, inLevelChild);
       //try
         Execute;
         DataSet.First;
         SetLength(Result, DataSet.RecordCount);
         for i:= 0 to DataSet.RecordCount-1 do
         begin
          Result[i].Number := DataSet.FieldByName('Number').asInteger;
          Result[i].Id     := DataSet.FieldByName('Id').asInteger;
          Result[i].Code   := DataSet.FieldByName('Code').asInteger;
          Result[i].Name   := DataSet.FieldByName('Name').asString;
          Result[i].Value  := DataSet.FieldByName('Value').asString;
          DataSet.Next;
         end;
       {except
         SetLength(Result, 0);
         ShowMessage('������ ��������� - gpSelect_ToolsWeighing_onLevelChild');
       end;}
    end;
    //
end;
{------------------------------------------------------------------------}
function TDMMainScaleCehForm.gpGet_Scale_User:String;
begin
    with spSelect do begin
       StoredProcName:='gpGet_Scale_User';
       OutputType:=otDataSet;
       Params.Clear;
       //try
         Execute;
         Result := DataSet.FieldByName('UserName').asString;
         //
         UserId_begin := DataSet.FieldByName('UserId').asInteger;
         UserName_begin := DataSet.FieldByName('UserName').asString;

       {except
         Result := '';
         ShowMessage('������ ��������� - gpGet_Scale_User');
       end;}
    end;
end;
{------------------------------------------------------------------------}
function TDMMainScaleCehForm.gpGet_ToolsWeighing_Value(inLevel1,inLevel2,inLevel3,inItemName,inDefaultValue:String):String;
begin
    with spSelect do begin
       StoredProcName:='gpGet_ToolsWeighing_Value';
       OutputType:=otDataSet;
       Params.Clear;
       Params.AddParam('inLevel1', ftString, ptInput, inLevel1);
       Params.AddParam('inLevel2', ftString, ptInput, inLevel2);
       Params.AddParam('inLevel3', ftString, ptInput, inLevel3);
       Params.AddParam('inItemName', ftString, ptInput, inItemName);
       Params.AddParam('inDefaultValue', ftString, ptInput, inDefaultValue);
       //try
         Execute;
         Result := DataSet.FieldByName('Value').asString;
       {except
         Result := '';
         ShowMessage('������ ��������� - gpGet_ToolsWeighing_Value');
       end;}
    end;
end;
{------------------------------------------------------------------------}
function TDMMainScaleCehForm.gpSelect_Scale_GoodsKindWeighing: TArrayList;
var i: integer;
begin
    with spSelect do
    begin
       StoredProcName:='gpSelect_Scale_GoodsKindWeighing';
       OutputType:=otDataSet;
       Params.Clear;
       //try
         Execute;
         DataSet.First;
         SetLength(Result, DataSet.RecordCount);
         for i:= 0 to DataSet.RecordCount-1 do
         begin
          Result[i].Number := DataSet.FieldByName('GroupId').asInteger;
          Result[i].Id     := DataSet.FieldByName('GoodsKindId').asInteger;
          Result[i].Code   := DataSet.FieldByName('GoodsKindCode').asInteger;
          Result[i].Name   := DataSet.FieldByName('GoodsKindName').asString;
          Result[i].Value  := '';
          DataSet.Next;
         end;
       {except
         SetLength(Result, 0);
         ShowMessage('������ ��������� - gpSelect_Scale_GoodsKindWeighing');
       end;}
    end;
end;
{------------------------------------------------------------------------}
function TDMMainScaleCehForm.gpGet_Scale_Goods(var execParams:TParams;inBarCode:String): Boolean;
begin
    if (trim (inBarCode) = '') or (trim (inBarCode) = '0') then
    begin
         Result:=false;
         exit;
    end;
    //
    with spSelect do
    begin
       //� �� - Id ������ ��� Id �����+��� ������ ��� ��� isCeh ��� GoodsCode
       StoredProcName:='gpGet_Scale_Goods';
       OutputType:=otDataSet;
       Params.Clear;
       Params.AddParam('inIsGoodsComplete', ftBoolean, ptInput, SettingMain.isGoodsComplete);
       Params.AddParam('inBarCode', ftString, ptInput, inBarCode);
       //try
         Execute;
         //
         Result:=DataSet.RecordCount<>0;
       with execParams do
       begin
         ParamByName('GoodsId').AsInteger  := DataSet.FieldByName('GoodsId').AsInteger;
         ParamByName('GoodsCode').AsInteger:= DataSet.FieldByName('GoodsCode').AsInteger;
         ParamByName('GoodsName').asString := DataSet.FieldByName('GoodsName').asString;

         if SettingMain.isCeh = FALSE then
         begin
              // ������ ��� ��������� Scale
              ParamByName('GoodsKindId').AsInteger  := DataSet.FieldByName('GoodsKindId').asInteger;
              ParamByName('GoodsKindCode').AsInteger:= DataSet.FieldByName('GoodsKindCode').AsInteger;
              ParamByName('GoodsKindName').asString := DataSet.FieldByName('GoodsKindName').asString;
         end
         else
         begin
              // ������ ��� ��������� ScaleCeh
              ParamByName('MeasureId').AsInteger  := DataSet.FieldByName('MeasureId').asInteger;
              ParamByName('MeasureCode').AsInteger:= DataSet.FieldByName('MeasureCode').AsInteger;
              ParamByName('MeasureName').asString := DataSet.FieldByName('MeasureName').asString;

              // ������ ��� ��������� ScaleCeh
              ParamByName('GoodsKindId_list').asString   := DataSet.FieldByName('GoodsKindId_list').asString;
              ParamByName('GoodsKindName_List').asString := DataSet.FieldByName('GoodsKindName_List').asString;

              ParamByName('GoodsKindId_max').AsInteger  := DataSet.FieldByName('GoodsKindId_max').asInteger;
              ParamByName('GoodsKindCode_max').AsInteger:= DataSet.FieldByName('GoodsKindCode_max').AsInteger;
              ParamByName('GoodsKindName_max').asString := DataSet.FieldByName('GoodsKindName_max').asString;
         end;

       end;

       {except
         result.Code := Code;
         result.Id   := 0;
         result.Name := '';
         ShowMessage('������ ��������� - gpGet_Scale_Goods');
       end;}
    end;
end;
{------------------------------------------------------------------------}
function TDMMainScaleCehForm.gpGet_ScaleLight_BarCodeBox (num : Integer; execParamsLight : TParams):Boolean;
begin
    with spSelect do begin
       StoredProcName:='gpGet_ScaleLight_BarCodeBox';
       OutputType:=otDataSet;
       Params.Clear;
       Params.AddParam('inGoodsId', ftInteger, ptInput, execParamsLight.ParamByName('GoodsId').AsInteger);
       Params.AddParam('inGoodsKindId', ftInteger, ptInput, execParamsLight.ParamByName('GoodsKindId').AsInteger);
       if num = 1 then
       begin
           Params.AddParam('inBoxId',      ftInteger, ptInput, execParamsLight.ParamByName('BoxId_1').AsInteger);
           Params.AddParam('inBoxBarCode', ftString,  ptInput, execParamsLight.ParamByName('BoxBarCode_1').AsString);
       end
       else
         if num = 2 then
         begin
             Params.AddParam('inBoxId',      ftInteger, ptInput, execParamsLight.ParamByName('BoxId_2').AsInteger);
             Params.AddParam('inBoxBarCode', ftString,  ptInput, execParamsLight.ParamByName('BoxBarCode_2').AsString);
         end
         else
           if num = 3 then
           begin
               Params.AddParam('inBoxId',      ftInteger, ptInput, execParamsLight.ParamByName('BoxId_3').AsInteger);
               Params.AddParam('inBoxBarCode', ftString,  ptInput, execParamsLight.ParamByName('BoxBarCode_3').AsString);
           end;
       //
       try
         Result:= false;
         Execute;
         Result:= true;
       except
           on E: Exception do
             if pos('context', AnsilowerCase(E.Message)) = 0 then
               ShowMessage(E.Message)
             else
               // ����������� ��� ��� ����� Context
               ShowMessage(Copy(E.Message, 1, pos('context', AnsilowerCase(E.Message)) - 1));
       end;
       //
       if Result then
         if num = 1 then
         begin
             execParamsLight.ParamByName('BarCodeBoxId_1').AsInteger:= DataSet.FieldByName('BarCodeBoxId').AsInteger;
             execParamsLight.ParamByName('BoxCode_1').AsInteger     := DataSet.FieldByName('BoxCode').AsInteger;
             execParamsLight.ParamByName('BoxBarCode_1').AsString   := DataSet.FieldByName('BoxBarCode').AsString;
             execParamsLight.ParamByName('isFull_1').asBoolean      := FALSE;
         end
         else
           if num = 2 then
           begin
               execParamsLight.ParamByName('BarCodeBoxId_2').AsInteger:= DataSet.FieldByName('BarCodeBoxId').AsInteger;
               execParamsLight.ParamByName('BoxCode_2').AsInteger     := DataSet.FieldByName('BoxCode').AsInteger;
               execParamsLight.ParamByName('BoxBarCode_2').AsString   := DataSet.FieldByName('BoxBarCode').AsString;
               execParamsLight.ParamByName('isFull_2').asBoolean      := FALSE;
           end
           else
             if num = 3 then
             begin
                 execParamsLight.ParamByName('BarCodeBoxId_3').AsInteger:= DataSet.FieldByName('BarCodeBoxId').AsInteger;
                 execParamsLight.ParamByName('BoxCode_3').AsInteger     := DataSet.FieldByName('BoxCode').AsInteger;
                 execParamsLight.ParamByName('BoxBarCode_3').AsString   := DataSet.FieldByName('BoxBarCode').AsString;
                 execParamsLight.ParamByName('isFull_3').asBoolean      := FALSE;
             end;

    end;
end;
{------------------------------------------------------------------------}
function TDMMainScaleCehForm.gpInsert_ScaleCeh_GoodsSeparate(retMovementId_begin, retMovementId : Integer;
                                                             execParamsMovement:TParams;
                                                             inOperDate: TDateTime; inGoodsId : Integer; inPartionGoods : String;
                                                             inAmount, inHeadCount : Double
                                                            ):Boolean;
begin
    Result:=false;
    //
    with spSelect do
    begin
       //
       StoredProcName:='gpInsert_ScaleCeh_GoodsSeparate';
       OutputType:=otDataSet;
       Params.Clear;

       Params.AddParam('inId', ftInteger, ptInputOutput, execParamsMovement.ParamByName('MovementId').AsInteger);
       Params.AddParam('inOperDate', ftDateTime, ptInput, inOperDate);
       Params.AddParam('inMovementDescId', ftInteger, ptInput, execParamsMovement.ParamByName('MovementDescId').AsInteger);
       Params.AddParam('inMovementDescNumber', ftInteger, ptInput, execParamsMovement.ParamByName('MovementDescNumber').AsInteger);
       Params.AddParam('inFromId', ftInteger, ptInput, execParamsMovement.ParamByName('FromId').AsInteger);
       Params.AddParam('inToId', ftInteger, ptInput, execParamsMovement.ParamByName('ToId').AsInteger);
       Params.AddParam('inIsProductionIn', ftBoolean, ptInput, execParamsMovement.ParamByName('isSendOnPriceIn').AsBoolean);
       Params.AddParam('inBranchCode', ftInteger, ptInput, SettingMain.BranchCode);
       Params.AddParam('inGoodsId', ftInteger,  ptInput, inGoodsId);
       Params.AddParam('inPartionGoods',ftString,   ptInput, inPartionGoods);
       Params.AddParam('inAmount', ftFloat, ptInput, inAmount);
       Params.AddParam('inHeadCount', ftFloat, ptInput, inHeadCount);
       //try
         Execute;
         //
         retMovementId_begin:= DataSet.FieldByName('MovementId_begin').asInteger;
         retMovementId      := DataSet.FieldByName('MovementId').asInteger;
    end;
    //
    Result:=true;
end;
{------------------------------------------------------------------------}
function TDMMainScaleCehForm.gpGet_ScaleCeh_GoodsSeparate(inOperDate: TDateTime; inMovementId, inGoodsId : Integer; inPartionGoods : String;
                                                      var TotalCount_in, TotalCount_null, TotalCount_MO, TotalCount_OB, TotalCount_PR, TotalCount_P : Double;
                                                      var HeadCount_in, HeadCount_null, HeadCount_MO, HeadCount_OB, HeadCount_PR, HeadCount_P : Double;
                                                      var PartionGoods_null, PartionGoods_MO, PartionGoods_OB, PartionGoods_PR, PartionGoods_P : String
                                                         ):Boolean;
begin
    with spSelect do
    begin
       //
       StoredProcName:='gpGet_ScaleCeh_GoodsSeparate';
       OutputType:=otDataSet;
       Params.Clear;
       Params.AddParam('inOperDate',    ftDateTime, ptInput, inOperDate);
       Params.AddParam('inMovementId',  ftInteger,  ptInput, inMovementId);
       Params.AddParam('inGoodsId',     ftInteger,  ptInput, inGoodsId);
       Params.AddParam('inPartionGoods',ftString,   ptInput, inPartionGoods);
       //try
         Execute;
         //
         Result:=DataSet.RecordCount<>0;
       //
       if Result then
         with DataSet do
         begin
           First;
           TotalCount_in  := 0;
           TotalCount_null:= 0;
           TotalCount_MO  := 0;
           TotalCount_OB  := 0;
           TotalCount_PR  := 0;
           TotalCount_P   := 0;
           //
           HeadCount_in  := 0;
           HeadCount_null:= 0;
           HeadCount_MO  := 0;
           HeadCount_OB  := 0;
           HeadCount_PR  := 0;
           HeadCount_P   := 0;
           //
           PartionGoods_null:= DataSet.FieldByName('PartionGoods_null').asString;
           PartionGoods_MO  := DataSet.FieldByName('PartionGoods_MO').asString;
           PartionGoods_OB  := DataSet.FieldByName('PartionGoods_OB').asString;
           PartionGoods_PR  := DataSet.FieldByName('PartionGoods_PR').asString;
           PartionGoods_P   := DataSet.FieldByName('PartionGoods_P').asString;
           while not EOF do
           begin
             TotalCount_in  := TotalCount_in   + DataSet.FieldByName('TotalCount_in').asFloat;
             TotalCount_null:= TotalCount_null + DataSet.FieldByName('TotalCount_null').asFloat;
             TotalCount_MO  := TotalCount_MO   + DataSet.FieldByName('TotalCount_MO').asFloat;
             TotalCount_OB  := TotalCount_OB   + DataSet.FieldByName('TotalCount_OB').asFloat;
             TotalCount_PR  := TotalCount_PR   + DataSet.FieldByName('TotalCount_PR').asFloat;
             TotalCount_P   := TotalCount_P    + DataSet.FieldByName('TotalCount_P').asFloat;
             //
             HeadCount_in  := HeadCount_in   + DataSet.FieldByName('HeadCount_in').asFloat;
             HeadCount_null:= HeadCount_null + DataSet.FieldByName('HeadCount_null').asFloat;
             HeadCount_MO  := HeadCount_MO   + DataSet.FieldByName('HeadCount_MO').asFloat;
             HeadCount_OB  := HeadCount_OB   + DataSet.FieldByName('HeadCount_OB').asFloat;
             HeadCount_PR  := HeadCount_PR   + DataSet.FieldByName('HeadCount_PR').asFloat;
             HeadCount_P   := HeadCount_P    + DataSet.FieldByName('HeadCount_P').asFloat;
             Next;
           end;
         end;
    end;
end;
{------------------------------------------------------------------------}
function TDMMainScaleCehForm.gpGet_ScaleLight_Goods(var execParamsLight:TParams; inGoodsId, inGoodsKindId : Integer): Boolean;
begin
    //
    //!!!ModeSorting!!!
    //
    if (SettingMain.isModeSorting = TRUE) then
    with spSelect do
    begin
       //
       StoredProcName:='gpGet_ScaleLight_Goods';
       OutputType:=otDataSet;
       Params.Clear;
       Params.AddParam('inGoodsId', ftInteger, ptInput, inGoodsId);
       Params.AddParam('inGoodsKindId', ftInteger, ptInput, inGoodsKindId);
       //try
         Execute;
         //
         Result:=DataSet.RecordCount<>0;

       with execParamsLight do
       begin
         ParamByName('GoodsId').AsInteger  := DataSet.FieldByName('GoodsId').AsInteger;
         ParamByName('GoodsCode').AsInteger:= DataSet.FieldByName('GoodsCode').asInteger;
         ParamByName('GoodsName').asString := DataSet.FieldByName('GoodsName').asString;
         ParamByName('GoodsKindId').AsInteger  := DataSet.FieldByName('GoodsKindId').AsInteger;
         ParamByName('GoodsKindCode').AsInteger:= DataSet.FieldByName('GoodsKindCode').asInteger;
         ParamByName('GoodsKindName').asString := DataSet.FieldByName('GoodsKindName').asString;
         ParamByName('MeasureId').AsInteger  := DataSet.FieldByName('MeasureId').AsInteger;
         ParamByName('MeasureCode').AsInteger:= DataSet.FieldByName('MeasureCode').asInteger;
         ParamByName('MeasureName').asString := DataSet.FieldByName('MeasureName').asString;
         // ������� ��������� - ������� ������
         ParamByName('Count_box').AsInteger          := DataSet.FieldByName('Count_box').AsInteger;
         // Id - ���� �� ��.
         ParamByName('GoodsTypeKindId_Sh').AsInteger := DataSet.FieldByName('GoodsTypeKindId_Sh').AsInteger;
         // Id - ���� �� ���.
         ParamByName('GoodsTypeKindId_Nom').AsInteger:= DataSet.FieldByName('GoodsTypeKindId_Nom').AsInteger;
         // Id - ���� �� ���
         ParamByName('GoodsTypeKindId_Ves').AsInteger:= DataSet.FieldByName('GoodsTypeKindId_Ves').AsInteger;
         // ��� ���
         ParamByName('WmsCode_Sh').asString := DataSet.FieldByName('WmsCode_Sh').asString;
         ParamByName('WmsCode_Nom').asString:= DataSet.FieldByName('WmsCode_Nom').asString;
         ParamByName('WmsCode_Ves').asString:= DataSet.FieldByName('WmsCode_Ves').asString;
         // ����������� ��� 1��.
         ParamByName('WeightMin').AsFloat:= DataSet.FieldByName('WeightMin').AsFloat;
         // ������������ ��� 1��.
         ParamByName('WeightMax').AsFloat:= DataSet.FieldByName('WeightMin').AsFloat;

         //1-�� ����� - ������ ���� ����
         ParamByName('GoodsTypeKindId_1').AsInteger := DataSet.FieldByName('GoodsTypeKindId_1').AsInteger;
         ParamByName('BarCodeBoxId_1').AsInteger    := 0;
         ParamByName('BoxCode_1').AsInteger         := 0;
         ParamByName('BoxBarCode_1').AsString       := '';
      // ParamByName('WeightOnBoxTotal_1').asFloat  := 0; // ��� ����� ������������� (� ���������� �����) - ��� ���������� ����� �����
      // ParamByName('CountOnBoxTotal_1').asFloat   := 0; // �� ����� ������������ (� ���������� �����) - ������������?
      // ParamByName('WeightTotal_1').asFloat       := 0; // ��� ����� ������������� (� �������� ������) - ������������
      // ParamByName('CountTotal_1').asFloat        := 0; // �� ����� ������������� (� �������� ������) - ������������
      // ParamByName('BoxTotal_1').asFloat          := 0; // ������ ����� (��������) - ������������
         ParamByName('isFull_1').AsBoolean          := FALSE;

         ParamByName('BoxId_1').AsInteger           := DataSet.FieldByName('BoxId_1').AsInteger;
         ParamByName('BoxName_1').asString          := DataSet.FieldByName('BoxName_1').asString;
         ParamByName('BoxWeight_1').asFloat         := DataSet.FieldByName('BoxWeight_1').asFloat;   // ��� ������ �����
         ParamByName('WeightOnBox_1').asFloat       := DataSet.FieldByName('WeightOnBox_1').asFloat; // ����������� - ���
         ParamByName('CountOnBox_1').asFloat        := DataSet.FieldByName('CountOnBox_1').asFloat;  // ����������� - �� (������������?)

         //2-�� ����� - ������ ���� ����
         ParamByName('GoodsTypeKindId_2').AsInteger := DataSet.FieldByName('GoodsTypeKindId_2').AsInteger;
         ParamByName('BarCodeBoxId_2').AsInteger    := 0;
         ParamByName('BoxCode_2').AsInteger         := 0;
         ParamByName('BoxBarCode_2').AsString       := '';
      // ParamByName('WeightOnBoxTotal_2').asFloat  := 0; // ��� ����� ������������� (� ���������� �����) - ��� ���������� ����� �����
      // ParamByName('CountOnBoxTotal_2').asFloat   := 0; // �� ����� ������������ (� ���������� �����) - ������������?
      // ParamByName('WeightTotal_2').asFloat       := 0; // ��� ����� ������������� (� �������� ������) - ������������
      // ParamByName('CountTotal_2').asFloat        := 0; // �� ����� ������������� (� �������� ������) - ������������
      // ParamByName('BoxTotal_2').asFloat          := 0; // ������ ����� (��������) - ������������
         ParamByName('isFull_2').AsBoolean          := FALSE;

         ParamByName('BoxId_2').AsInteger           := DataSet.FieldByName('BoxId_2').AsInteger;
         ParamByName('BoxName_2').asString          := DataSet.FieldByName('BoxName_2').asString;
         ParamByName('BoxWeight_2').asFloat         := DataSet.FieldByName('BoxWeight_2').asFloat;   // ��� ������ �����
         ParamByName('WeightOnBox_2').asFloat       := DataSet.FieldByName('WeightOnBox_2').asFloat; // ����������� - ���
         ParamByName('CountOnBox_2').asFloat        := DataSet.FieldByName('CountOnBox_2').asFloat;  // ����������� - �� (������������?)

          //3-�� ����� - ������ ���� ����
         ParamByName('GoodsTypeKindId_3').AsInteger := DataSet.FieldByName('GoodsTypeKindId_3').AsInteger;
         ParamByName('BarCodeBoxId_3').AsInteger    := 0;
         ParamByName('BoxCode_3').AsInteger         := 0;
         ParamByName('BoxBarCode_3').AsString       := '';
      // ParamByName('WeightOnBoxTotal_3').asFloat  := 0; // ��� ����� ������������� (� ���������� �����) - ��� ���������� ����� �����
      // ParamByName('CountOnBoxTotal_3').asFloat   := 0; // �� ����� ������������ (� ���������� �����) - ������������?
      // ParamByName('WeightTotal_3').asFloat       := 0; // ��� ����� ������������� (� �������� ������) - ������������
      // ParamByName('CountTotal_3').asFloat        := 0; // �� ����� ������������� (� �������� ������) - ������������
      // ParamByName('BoxTotal_3').asFloat          := 0; // ������ ����� (��������) - ������������
         ParamByName('isFull_3').AsBoolean          := FALSE;

         ParamByName('BoxId_3').AsInteger           := DataSet.FieldByName('BoxId_3').AsInteger;
         ParamByName('BoxName_3').asString          := DataSet.FieldByName('BoxName_3').asString;
         ParamByName('BoxWeight_3').asFloat         := DataSet.FieldByName('BoxWeight_3').asFloat;   // ��� ������ �����
         ParamByName('WeightOnBox_3').asFloat       := DataSet.FieldByName('WeightOnBox_3').asFloat; // ����������� - ���
         ParamByName('CountOnBox_3').asFloat        := DataSet.FieldByName('CountOnBox_3').asFloat;  // ����������� - �� (������������?)

       end;

    end;
end;
{------------------------------------------------------------------------}
function TDMMainScaleCehForm.gpGet_Scale_OperDate(var execParams:TParams):TDateTime;
begin
    with  DMMainScaleCehForm.spSelect do
    begin
       StoredProcName:='gpGet_Scale_OperDate';
       OutputType:=otDataSet;
       Params.Clear;
       //try
         Params.AddParam('inIsCeh', ftBoolean, ptInput, SettingMain.isCeh);
         Params.AddParam('inBranchCode', ftInteger, ptInput, SettingMain.BranchCode);
         Execute;
         //
         Result:=DataSet.FieldByName('OperDate').asDateTime;
         execParams.ParamByName('OperDate').AsDateTime:=DataSet.FieldByName('OperDate').asDateTime;

       {except
         result.Code := Code;
         result.Id   := 0;
         result.Name := '';
         ShowMessage('������ ��������� - gpGet_Scale_OperDate');
       end;}
    end;
end;
{------------------------------------------------------------------------}
function TDMMainScaleCehForm.lpGet_UnitName(inUnitId:Integer): String;
begin
    with spSelect do
    if inUnitId > 0 then
    begin
       StoredProcName:='gpExecSql_Value';
       OutputType:=otDataSet;
       Params.Clear;
       Params.AddParam('inSqlText', ftString, ptInput, 'SELECT Object.ValueData FROM Object WHERE Object.Id = '+ IntToStr(inUnitId) + ' AND Object.DescId = zc_Object_Unit()');
       Execute;
       Result:=DataSet.FieldByName('Value').asString;
    end
    else Result:='';
end;
{------------------------------------------------------------------------}
{------------------------------------------------------------------------}
function TDMMainScaleCehForm.lpGet_BranchName(inBranchCode:Integer): String;
begin
    with spSelect do
    begin
       StoredProcName:='gpExecSql_Value';
       OutputType:=otDataSet;
       Params.Clear;
       Params.AddParam('inSqlText', ftString, ptInput, 'SELECT Object.ValueData FROM Object WHERE Object.Id = COALESCE((SELECT Object_Branch.Id FROM Object AS Object_Branch WHERE Object_Branch.ObjectCode = '+ IntToStr(inBranchCode) + ' AND Object_Branch.DescId = zc_Object_Branch()), zc_Branch_Basis())' );
       Execute;
       if inBranchCode > 100
       then Result:='('+IntToStr(inBranchCode)+')'+DataSet.FieldByName('Value').asString
       else Result:='('+IntToStr(inBranchCode)+')'+DataSet.FieldByName('Value').asString;
    end;
end;
{------------------------------------------------------------------------}
function gpInitialize_Const: Boolean;
begin
    Result:=false;

    with  DMMainScaleCehForm.spSelect do
    begin
       StoredProcName:='gpExecSql_Value';
       OutputType:=otDataSet;
       Params.Clear;
       Params.AddParam('inSqlText', ftString, ptInput, '');

       //try

         //MovementDesc
         Params.ParamByName('inSqlText').Value:='SELECT zc_Movement_Income() :: TVarChar';
         Execute;
         zc_Movement_Income:=DataSet.FieldByName('Value').asInteger;

         Params.ParamByName('inSqlText').Value:='SELECT zc_Movement_ReturnOut() :: TVarChar';
         Execute;
         zc_Movement_ReturnOut:=DataSet.FieldByName('Value').asInteger;

         Params.ParamByName('inSqlText').Value:='SELECT zc_Movement_Sale() :: TVarChar';
         Execute;
         zc_Movement_Sale:=DataSet.FieldByName('Value').asInteger;

         Params.ParamByName('inSqlText').Value:='SELECT zc_Movement_ReturnIn() :: TVarChar';
         Execute;
         zc_Movement_ReturnIn:=DataSet.FieldByName('Value').asInteger;

         Params.ParamByName('inSqlText').Value:='SELECT zc_Movement_Send() :: TVarChar';
         Execute;
         zc_Movement_Send:=DataSet.FieldByName('Value').asInteger;

         Params.ParamByName('inSqlText').Value:='SELECT zc_Movement_SendOnPrice() :: TVarChar';
         Execute;
         zc_Movement_SendOnPrice:=DataSet.FieldByName('Value').asInteger;

         Params.ParamByName('inSqlText').Value:='SELECT zc_Movement_Loss() :: TVarChar';
         Execute;
         zc_Movement_Loss:=DataSet.FieldByName('Value').asInteger;

         Params.ParamByName('inSqlText').Value:='SELECT zc_Movement_Inventory() :: TVarChar';
         Execute;
         zc_Movement_Inventory:=DataSet.FieldByName('Value').asInteger;

         Params.ParamByName('inSqlText').Value:='SELECT zc_Movement_ProductionUnion() :: TVarChar';
         Execute;
         zc_Movement_ProductionUnion:=DataSet.FieldByName('Value').asInteger;

         Params.ParamByName('inSqlText').Value:='SELECT zc_Movement_ProductionSeparate() :: TVarChar';
         Execute;
         zc_Movement_ProductionSeparate:=DataSet.FieldByName('Value').asInteger;

         Params.ParamByName('inSqlText').Value:='SELECT zc_Movement_OrderExternal() :: TVarChar';
         Execute;
         zc_Movement_OrderExternal:=DataSet.FieldByName('Value').asInteger;

         //Measure
         //Params.ParamByName('inSqlText').Value:='SELECT zc_Measure_Sh() :: TVarChar';
         //Execute;
         //zc_Measure_Sh:=DataSet.FieldByName('Value').asInteger;

         Params.ParamByName('inSqlText').Value:='SELECT zc_Measure_Kg() :: TVarChar';
         Execute;
         zc_Measure_Kg:=DataSet.FieldByName('Value').asInteger;

         //BarCodePref
         Params.ParamByName('inSqlText').Value:='SELECT zc_BarCodePref_Object() :: TVarChar';
         Execute;
         zc_BarCodePref_Object:=DataSet.FieldByName('Value').asString;

         Params.ParamByName('inSqlText').Value:='SELECT zc_BarCodePref_Movement() :: TVarChar';
         Execute;
         zc_BarCodePref_Movement:=DataSet.FieldByName('Value').asString;

         Params.ParamByName('inSqlText').Value:='SELECT zc_BarCodePref_MI() :: TVarChar';
         Execute;
         zc_BarCodePref_MI:=DataSet.FieldByName('Value').asString;

         // DocumentKind
         // ����������� �/� ���� �������
         Params.ParamByName('inSqlText').Value:='SELECT zc_Enum_DocumentKind_CuterWeight() :: TVarChar';
         Execute;
         zc_Enum_DocumentKind_CuterWeight:=DataSet.FieldByName('Value').asInteger;
         // DocumentKind - ����������� �/� ���� �����
         Params.ParamByName('inSqlText').Value:='SELECT zc_Enum_DocumentKind_RealWeight() :: TVarChar';
         Execute;
         zc_Enum_DocumentKind_RealWeight:=DataSet.FieldByName('Value').asInteger;

         // InfoMoney
         // 30201 ������ + ������ ����� + ������ �����
         Params.ParamByName('inSqlText').Value:='SELECT zc_Enum_InfoMoney_30201() :: TVarChar';
         Execute;
         zc_Enum_InfoMoney_30201:=DataSet.FieldByName('Value').asInteger;

         //ObjectDesc
         Params.ParamByName('inSqlText').Value:='SELECT zc_Object_Partner() :: TVarChar';
         Execute;
         zc_Object_Partner:=DataSet.FieldByName('Value').asInteger;

         Params.ParamByName('inSqlText').Value:='SELECT zc_Object_ArticleLoss() :: TVarChar';
         Execute;
         zc_Object_ArticleLoss:=DataSet.FieldByName('Value').asInteger;

         Params.ParamByName('inSqlText').Value:='SELECT zc_Object_Unit() :: TVarChar';
         Execute;
         zc_Object_Unit:=DataSet.FieldByName('Value').asInteger;

         //ModeSorting
         // ���� - �������
         Params.ParamByName('inSqlText').Value:='SELECT ValueData FROM Object WHERE Id = zc_Enum_GoodsTypeKind_Sh()';
         Execute;
         SettingMain.Name_Sh:=DataSet.FieldByName('Value').asString;
         // ���� - �����������
         Params.ParamByName('inSqlText').Value:='SELECT ValueData FROM Object WHERE Id = zc_Enum_GoodsTypeKind_Nom()';
         Execute;
         SettingMain.Name_Nom:=DataSet.FieldByName('Value').asString;
         // ���� - �������������
         Params.ParamByName('inSqlText').Value:='SELECT ValueData FROM Object WHERE Id = zc_Enum_GoodsTypeKind_Ves()';
         Execute;
         SettingMain.Name_Ves:=DataSet.FieldByName('Value').asString;
         // ���� - �������
         Params.ParamByName('inSqlText').Value:='SELECT COALESCE ((SELECT ValueData FROM ObjectString WHERE ObjectId = zc_Enum_GoodsTypeKind_Sh() AND DescId = zc_ObjectString_GoodsTypeKind_ShortName() AND ValueData <> '+chr(39)+''+chr(39)+'), '+chr(39)+'��.'+chr(39)+' :: TVarChar)';
         Execute;
         SettingMain.ShName_Sh:=DataSet.FieldByName('Value').asString;
         // ���� - �����������
         Params.ParamByName('inSqlText').Value:='SELECT COALESCE ((SELECT ValueData FROM ObjectString WHERE ObjectId = zc_Enum_GoodsTypeKind_Nom() AND DescId = zc_ObjectString_GoodsTypeKind_ShortName() AND ValueData <> '+chr(39)+''+chr(39)+'), '+chr(39)+'���.'+chr(39)+' :: TVarChar)';
         Execute;
         SettingMain.ShName_Nom:=DataSet.FieldByName('Value').asString;
         // ���� - �������������
         Params.ParamByName('inSqlText').Value:='SELECT COALESCE ((SELECT ValueData FROM ObjectString WHERE ObjectId = zc_Enum_GoodsTypeKind_Ves() AND DescId = zc_ObjectString_GoodsTypeKind_ShortName() AND ValueData <> '+chr(39)+''+chr(39)+'), '+chr(39)+'���.'+chr(39)+' :: TVarChar)';
         Execute;
         SettingMain.ShName_Ves:=DataSet.FieldByName('Value').asString;



       {except
         result.Code := Code;
         result.Id   := 0;
         result.Name := '';
         ShowMessage('������ ��������� - gpMovementDesc');
       end;}
    end;

    Result:=true;
end;
{------------------------------------------------------------------------}
function gpInitialize_Ini: Boolean;
var
  Ini: TInifile;
  ScaleList : TStringList;
  i:Integer;
  tmpValue:String;
begin
  Result:=false;

  //!!!������������ �.�. ��� ��������� ScaleCeh!!!
  SettingMain.isCeh:=TRUE;//AnsiUpperCase(ExtractFileName(ParamStr(0))) <> AnsiUpperCase('Scale.exe');

  if System.Pos(AnsiUpperCase('ini'),AnsiUpperCase(ParamStr(1)))>0
  then Ini:=TIniFile.Create(ExtractFilePath(ParamStr(0)) + ParamStr(1))
  else if System.Pos(AnsiUpperCase('ini'),AnsiUpperCase(ParamStr(2)))>0
       then Ini:=TIniFile.Create(ExtractFilePath(ParamStr(0)) + ParamStr(2))
       else if System.Pos(AnsiUpperCase('ini'),AnsiUpperCase(ParamStr(3)))>0
            then Ini:=TIniFile.Create(ExtractFilePath(ParamStr(0)) + ParamStr(3))
            else Ini:=TIniFile.Create(ExtractFilePath(ParamStr(0)) + 'scale.ini');

  //!!!�������� ��� �������!!!
  gc_isDebugMode:=AnsiUpperCase(Ini.ReadString('Main','isDebugMode','FALSE')) = AnsiUpperCase('TRUE');

  //!!!��������!!!
  SettingMain.BranchCode:=Ini.ReadInteger('Main','BrancCode',1);
  if SettingMain.BranchCode<>1 then Ini.WriteInteger('Main','BranchCode',SettingMain.BranchCode);
  //
  SettingMain.BranchCode:=Ini.ReadInteger('Main','BranchCode',1);
  if SettingMain.BranchCode=1 then Ini.WriteInteger('Main','BranchCode',1);
  //PlaceNumber
  SettingMain.PlaceNumber:=Ini.ReadInteger('Main','PlaceNumber',0);
  if SettingMain.PlaceNumber=0 then begin SettingMain.PlaceNumber:= 1; Ini.WriteInteger('Main','PlaceNumber',1);end;

  SettingMain.DefaultCOMPort:=Ini.ReadInteger('Main','DefaultCehCOMPort',1);
  if SettingMain.DefaultCOMPort=1 then Ini.WriteInteger('Main','DefaultCehCOMPort',1);

  SettingMain.LightCOMPort:=Ini.ReadInteger('Main','DefaultLightCOMPort',0);
  if SettingMain.LightCOMPort=0 then Ini.WriteInteger('Main','DefaultLightCOMPort',4);

  //isLightLEFT_321
  tmpValue:=Ini.ReadString('Main','isLightLEFT_321','');
  if tmpValue='' then Ini.WriteString('Main','isLightLEFT_321', 'TRUE');
  SettingMain.isLightLEFT_321:= AnsiUpperCase(tmpValue) = AnsiUpperCase('TRUE');

  SettingMain.ScaleCount:=Ini.ReadInteger('Main','ScaleCehCount',1);
  if SettingMain.ScaleCount=1 then Ini.WriteInteger('Main','ScaleCehCount',1);

  ScaleList:=TStringList.Create;
  Ini.ReadSectionValues('TypeCeh_CommPort_Name',ScaleList);
  if ScaleList.Count=0 then
  begin
       for i:=1 to SettingMain.ScaleCount do
          Ini.WriteString('TypeCeh_CommPort_Name','Item'+IntToStr(i-1),' stDB : '  + IntToStr(i) + ' : ' + 'DB');
       Ini.ReadSectionValues('TypeCeh_CommPort_Name',ScaleList);
  end;

  SetLength(Scale_Array,SettingMain.ScaleCount);
  for i:= 0 to SettingMain.ScaleCount-1 do
  begin
       tmpValue:=ScaleList[i];

       Scale_Array[i].Number := i;
       Delete(tmpValue,1,Pos('=',tmpValue));
       Scale_Array[i].ScaleType := TScaleType(GetEnumValue(TypeInfo(TScaleType), trim(Copy(tmpValue,1,Pos(':',tmpValue)-1))));
       Delete(tmpValue,1,Pos(':',tmpValue));
       try Scale_Array[i].ComPort := StrToInt(trim(Copy(tmpValue,1,Pos(':',tmpValue)-1))) except Scale_Array[i].ComPort:=-1;end;
       Delete(tmpValue,1,Pos(':',tmpValue));
       Scale_Array[i].ScaleName := trim(tmpValue);
   end;

  Ini.Free;
  ScaleList.Free;

  Result:=true;
end;
{------------------------------------------------------------------------}
function gpInitialize_SettingMain_Default: Boolean;
begin
  SettingMain.isGoodsComplete:=GetArrayList_Value_byName(Default_Array,'isGoodsComplete') = AnsiUpperCase('TRUE');
  //
  if SettingMain.isCeh = TRUE then
  begin
       SettingMain.isModeSorting:=GetArrayList_Value_byName(Default_Array,'isModeSorting') = AnsiUpperCase('TRUE');

       SettingMain.WeightSkewer1:=myStrToFloat(GetArrayList_Value_byName(Default_Array,'WeightSkewer1'));
       SettingMain.WeightSkewer2:=myStrToFloat(GetArrayList_Value_byName(Default_Array,'WeightSkewer2'));

       try SettingMain.UnitId1:= StrToInt(GetArrayList_Value_byName(Default_Array,'UnitId1')); except SettingMain.UnitId1:= 0; end;
       try SettingMain.UnitId2:= StrToInt(GetArrayList_Value_byName(Default_Array,'UnitId2')); except SettingMain.UnitId2:= 0; end;
       try SettingMain.UnitId3:= StrToInt(GetArrayList_Value_byName(Default_Array,'UnitId3')); except SettingMain.UnitId3:= 0; end;
       try SettingMain.UnitId4:= StrToInt(GetArrayList_Value_byName(Default_Array,'UnitId4')); except SettingMain.UnitId4:= 0; end;
       try SettingMain.UnitId5:= StrToInt(GetArrayList_Value_byName(Default_Array,'UnitId5')); except SettingMain.UnitId5:= 0; end;

       SettingMain.UnitName1:= DMMainScaleCehForm.lpGet_UnitName(SettingMain.UnitId1);
       SettingMain.UnitName2:= DMMainScaleCehForm.lpGet_UnitName(SettingMain.UnitId2);
       SettingMain.UnitName3:= DMMainScaleCehForm.lpGet_UnitName(SettingMain.UnitId3);
       SettingMain.UnitName4:= DMMainScaleCehForm.lpGet_UnitName(SettingMain.UnitId4);
       SettingMain.UnitName5:= DMMainScaleCehForm.lpGet_UnitName(SettingMain.UnitId5);

       //ModeSorting - Color
       try SettingMain.LightColor_1:= StrToInt(GetArrayList_Value_byName(Default_Array,'LightColor_1')); except SettingMain.LightColor_1:= 0; end;
       try SettingMain.LightColor_2:= StrToInt(GetArrayList_Value_byName(Default_Array,'LightColor_2')); except SettingMain.LightColor_1:= 0; end;
       try SettingMain.LightColor_3:= StrToInt(GetArrayList_Value_byName(Default_Array,'LightColor_3')); except SettingMain.LightColor_1:= 0; end;

  end;
  //
  Result:=true;
end;
{------------------------------------------------------------------------}
end.
