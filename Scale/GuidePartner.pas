unit GuidePartner;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, DBTables, StdCtrls, ExtCtrls, Grids, DBGrids, Buttons,
  Datasnap.DBClient, dsdDB, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, dxSkinsCore,
  dxSkinsDefaultPainters, cxTextEdit, cxCurrencyEdit, cxStyles,
  dxSkinscxPCPainter, cxCustomData, cxFilter, cxData, cxDataStorage, cxDBData,
  cxGridLevel, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxClasses, cxGridCustomView, cxGrid,dsdAddOn, Vcl.ActnList,
  dsdAction
 ,UtilScale,DataModul;

type
  TGuidePartnerForm = class(TForm)
    GridPanel: TPanel;
    ParamsPanel: TPanel;
    DataSource: TDataSource;
    ButtonPanel: TPanel;
    bbExit: TSpeedButton;
    bbRefresh: TSpeedButton;
    bbChoice: TSpeedButton;
    spSelect: TdsdStoredProc;
    CDS: TClientDataSet;
    gbPartnerCode: TGroupBox;
    EditPartnerCode: TEdit;
    gbPartnerName: TGroupBox;
    EditPartnerName: TEdit;
    DS: TDataSource;
    cxDBGrid: TcxGrid;
    cxDBGridDBTableView: TcxGridDBTableView;
    cxDBGridLevel: TcxGridLevel;
    PartnerCode: TcxGridDBColumn;
    PartnerName: TcxGridDBColumn;
    PaidKindName: TcxGridDBColumn;
    ContractCode: TcxGridDBColumn;
    ContractNumber: TcxGridDBColumn;
    ContractTagName: TcxGridDBColumn;
    ChangePercent: TcxGridDBColumn;
    ChangePercentAmount: TcxGridDBColumn;
    InfoMoneyCode: TcxGridDBColumn;
    InfoMoneyName: TcxGridDBColumn;
    DBViewAddOn: TdsdDBViewAddOn;
    ActionList: TActionList;
    actRefresh: TAction;
    actChoice: TAction;
    actExit: TAction;
    procedure FormCreate(Sender: TObject);
    procedure EditPartnerNameEnter(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure EditPartnerCodeKeyPress(Sender: TObject; var Key: Char);
    procedure EditPartnerCodeKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure EditPartnerNameKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure EditPartnerCodeChange(Sender: TObject);
    procedure EditPartnerNameChange(Sender: TObject);
    procedure EditPartnerCodeEnter(Sender: TObject);
    procedure CDSFilterRecord(DataSet: TDataSet; var Accept: Boolean);
    procedure EditPartnerNameKeyPress(Sender: TObject; var Key: Char);
    procedure FormDestroy(Sender: TObject);
    procedure actRefreshExecute(Sender: TObject);
    procedure actChoiceExecute(Sender: TObject);
    procedure actExitExecute(Sender: TObject);
  private
    fEnterPartnerCode:Boolean;
    fEnterPartnerName:Boolean;

    ParamsMovement_local: TParams;

    function Checked: boolean;
  public
    function Execute(var execParamsMovement:TParams): boolean;
  end;

var
  GuidePartnerForm: TGuidePartnerForm;

implementation

{$R *.dfm}

 uses dmMainScale;
{------------------------------------------------------------------------------}
function TGuidePartnerForm.Execute(var execParamsMovement:TParams): boolean;
begin
     CopyValuesParamsFrom(execParamsMovement,ParamsMovement_local);

     EditPartnerCode.Text:='';
     EditPartnerName.Text:='';

     CDS.Filter:='InfoMoneyId='+ParamsMovement_local.ParamByName('InfoMoneyId').AsString;
     CDS.Filtered:=false;
     CDS.Filtered:=true;

     if ParamsMovement_local.ParamByName('calcPartnerId').AsInteger<>0
     then CDS.Locate('PartnerId',ParamsMovement_local.ParamByName('calcPartnerId').AsString,[]);

     fEnterPartnerCode:=false;
     fEnterPartnerName:=false;
     ActiveControl:=EditPartnerName;

     Application.ProcessMessages;
     Application.ProcessMessages;
     Application.ProcessMessages;

     result:=ShowModal=mrOk;
     if result then CopyValuesParamsFrom(ParamsMovement_local,execParamsMovement);
end;
{------------------------------------------------------------------------------}
procedure TGuidePartnerForm.FormKeyDown(Sender: TObject; var Key: Word;Shift: TShiftState);
begin
    if Key=13
    then
        if (ActiveControl=cxDBGrid)and(CDS.RecordCount>0)
        then actChoiceExecute(Self)
        else begin
                  if (CDS.RecordCount=1)
                  then actChoiceExecute(Self)
                  else if (ActiveControl=EditPartnerCode)
                       then ActiveControl:=EditPartnerName
                       else if (ActiveControl=EditPartnerName)
                            then ActiveControl:=EditPartnerCode;
        end;

    if Key=27 then actExitExecute(Self);
end;
{------------------------------------------------------------------------------}
procedure TGuidePartnerForm.CDSFilterRecord(DataSet: TDataSet;var Accept: Boolean);
begin
     //
     if (fEnterPartnerCode)and(trim(EditPartnerCode.Text)<>'')
     then
       if  (EditPartnerCode.Text=DataSet.FieldByName('PartnerCode').AsString)
       then Accept:=true else Accept:=false;
     //
     //
     if (fEnterPartnerName)and(trim(EditPartnerName.Text)<>'')
     then
       if  (pos(AnsiUpperCase(EditPartnerName.Text),AnsiUpperCase(DataSet.FieldByName('PartnerName').AsString))>0)
       then Accept:=true else Accept:=false;

end;
{------------------------------------------------------------------------------}
function TGuidePartnerForm.Checked: boolean; //�������� ����������� ����� � Edit
begin
     Result:=(CDS.RecordCount>0);
     //
     if not Result
     then ActiveControl:=EditPartnerName
     else with ParamsMovement_local do
          begin
               ParamByName('calcPartnerId').AsInteger:= CDS.FieldByName('PartnerId').AsInteger;
               ParamByName('calcPartnerCode').AsInteger:= CDS.FieldByName('PartnerCode').AsInteger;
               ParamByName('calcPartnerName').asString:= CDS.FieldByName('PartnerName').asString;
               ParamByName('ChangePercent').asFloat:= CDS.FieldByName('ChangePercent').asFloat;
               ParamByName('ChangePercentAmount').asFloat:= CDS.FieldByName('ChangePercentAmount').asFloat;
               ParamByName('isEdiOrdspr').asBoolean:= CDS.FieldByName('isEdiOrdspr').asBoolean;
               ParamByName('isEdiInvoice').asBoolean:= CDS.FieldByName('isEdiInvoice').asBoolean;
               ParamByName('isEdiDesadv').asBoolean:= CDS.FieldByName('isEdiDesadv').asBoolean;

               ParamByName('PaidKindId').AsInteger:= CDS.FieldByName('PaidKindId').asInteger;
               ParamByName('PaidKindName').asString:= CDS.FieldByName('PaidKindName').asString;

               ParamByName('ContractId').AsInteger    := CDS.FieldByName('ContractId').asInteger;
               ParamByName('ContractCode').AsInteger  := CDS.FieldByName('ContractCode').asInteger;
               ParamByName('ContractNumber').asString := CDS.FieldByName('ContractNumber').asString;
               ParamByName('ContractTagName').asString:= CDS.FieldByName('ContractTagName').asString;

               // �������������� ��������� ���������
               Result:=DMMainScaleForm.gpGet_Scale_PartnerParams(ParamsMovement_local);
          end;
end;
{------------------------------------------------------------------------------}
procedure TGuidePartnerForm.EditPartnerCodeChange(Sender: TObject);
begin
     if fEnterPartnerCode then
       with CDS do begin
           //***Filtered:=false;
           //***if trim(EditPartnerCode.Text)<>'' then begin Filtered:=false;Filtered:=true;end;
           Filtered:=false;
           Filtered:=true;
       end;
end;
{------------------------------------------------------------------------------}
procedure TGuidePartnerForm.EditPartnerCodeEnter(Sender: TObject);
begin TEdit(Sender).SelectAll;
      EditPartnerName.Text:='';
      //if CDS.Filtered then CDS.Filtered:=false;
end;
{------------------------------------------------------------------------------}
procedure TGuidePartnerForm.EditPartnerCodeKeyDown(Sender: TObject;var Key: Word; Shift: TShiftState);
begin
     if(Key<>32)and(Key<>27)and(Key<>13)then
     begin
          fEnterPartnerCode:=true;
          fEnterPartnerName:=false;
          EditPartnerName.Text:='';
     end
end;
{------------------------------------------------------------------------------}
procedure TGuidePartnerForm.EditPartnerCodeKeyPress(Sender: TObject;var Key: Char);
begin if(Key=' ')or(Key='+')then Key:=#0;end;
{------------------------------------------------------------------------------}
procedure TGuidePartnerForm.EditPartnerNameChange(Sender: TObject);
begin
     if fEnterPartnerName then
       with CDS do begin
           //***Filtered:=false;
           //***if trim(EditPartnerName.Text)<>'' then begin Filtered:=false;Filtered:=true;end;
           Filtered:=false;
           Filtered:=true;
       end;
end;
{------------------------------------------------------------------------------}
procedure TGuidePartnerForm.EditPartnerNameEnter(Sender: TObject);
begin
  TEdit(Sender).SelectAll;
  EditPartnerCode.Text:='';
  //if CDS.Filtered then CDS.Filtered:=false;
end;
{------------------------------------------------------------------------------}
procedure TGuidePartnerForm.EditPartnerNameKeyDown(Sender: TObject;var Key: Word; Shift: TShiftState);
begin
     if(Key<>27)and(Key<>13)then
     begin
          fEnterPartnerCode:=false;
          fEnterPartnerName:=true;
          EditPartnerCode.Text:='';
     end
end;
{------------------------------------------------------------------------------}
procedure TGuidePartnerForm.EditPartnerNameKeyPress(Sender: TObject; var Key: Char);
begin if(Key='+')then Key:=#0;end;
{------------------------------------------------------------------------------}
procedure TGuidePartnerForm.actRefreshExecute(Sender: TObject);
var PartnerId:String;
begin
    with spSelect do begin
        PartnerId:= DataSet.FieldByName('PartnerId').AsString;
        Execute;
        if PartnerId <> '' then
          DataSet.Locate('PartnerId',PartnerId,[loCaseInsensitive]);
    end;
end;
{------------------------------------------------------------------------------}
procedure TGuidePartnerForm.actChoiceExecute(Sender: TObject);
begin
     if Checked then ModalResult:=mrOK;
end;
{------------------------------------------------------------------------------}
procedure TGuidePartnerForm.actExitExecute(Sender: TObject);
begin
     Close;
end;
{------------------------------------------------------------------------------}
procedure TGuidePartnerForm.FormCreate(Sender: TObject);
begin
  Create_ParamsMovement(ParamsMovement_local);

  with spSelect do
  begin
       StoredProcName:='gpSelect_Scale_Partner';
       Params.AddParam('inInfoMoneyId_income', ftInteger, ptInput, StrToInt(GetArrayList_Value_byName(Default_Array,'InfoMoneyId_income')));
       Params.AddParam('inInfoMoneyId_sale', ftInteger, ptInput, StrToInt(GetArrayList_Value_byName(Default_Array,'InfoMoneyId_sale')));
       OutputType:=otDataSet;
       Execute;
  end;

end;
{------------------------------------------------------------------------------}
procedure TGuidePartnerForm.FormDestroy(Sender: TObject);
begin
  ParamsMovement_local.Free;
end;
{------------------------------------------------------------------------------}
end.
