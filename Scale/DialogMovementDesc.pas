unit DialogMovementDesc;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  AncestorDialogScale, dsdDB, Data.DB, Datasnap.DBClient, Vcl.Grids, Vcl.DBGrids,
  Data.Bind.EngExt, Vcl.Bind.DBEngExt, System.Rtti, System.Bindings.Outputs,
  Vcl.Bind.Editors, Data.Bind.Components, dsdAddOn, Data.FMTBcd,
  Data.SqlExpr, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  cxContainer, cxEdit, dxSkinsCore, dxSkinsDefaultPainters, cxTextEdit,
  cxMaskEdit, cxButtonEdit
, UtilScale, Vcl.Buttons;

type
  TDialogMovementDescForm = class(TAncestorDialogScaleForm)
    CDS: TClientDataSet;
    DataSource: TDataSource;
    spSelect: TdsdStoredProc;
    InfoPanel: TPanel;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Label2: TLabel;
    Panel4: TPanel;
    Label3: TLabel;
    PanelPartnerName: TPanel;
    Panel5: TPanel;
    ScaleLabel: TLabel;
    EditBarCode: TEdit;
    Panel6: TPanel;
    DBGrid: TDBGrid;
    EditPartnerCode: TcxButtonEdit;
    MessagePanel: TPanel;
    procedure FormCreate(Sender: TObject);
    procedure EditPartnerCodeExit(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure DBGridDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure DBGridCellClick(Column: TColumn);
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure EditBarCodeExit(Sender: TObject);
    procedure EditBarCodeChange(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure EditPartnerCodeKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure EditBarCodeEnter(Sender: TObject);
    procedure EditPartnerCodeEnter(Sender: TObject);
    procedure EditPartnerCodePropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);

  private
    ChoiceNumber:Integer;

    isEditPartnerCodeExit: Boolean;
    isOrderExternal: Boolean;
    isBarCodeMaster: Boolean;
    ParamsMovement_local: TParams;

    function Checked: boolean; override;//�������� ����������� ����� � Edit
  public
    function Execute(BarCode: String): boolean; virtual;
  end;

var
  DialogMovementDescForm: TDialogMovementDescForm;

implementation
{$R *.dfm}
uses DMMainScale,GuidePartner;
{------------------------------------------------------------------------}
function TDialogMovementDescForm.Execute(BarCode: String): Boolean; //�������� ����������� ����� � Edit
begin
     CopyValuesParamsFrom(ParamsMovement,ParamsMovement_local);

     isEditPartnerCodeExit:= true;

     if ParamsMovement_local.ParamByName('MovementId').AsInteger<>0
     then begin
               MessagePanel.Font.Style:=[fsBold];
               MessagePanel.Caption:='������� ����������� �� �������.����� ������� <�����> �����������.';
               //
               ParamsMovement_local.ParamByName('MovementDescId').AsInteger:=0;
               ParamsMovement_local.ParamByName('MovementDescNumber').AsString:=GetArrayList_Value_byName(Default_Array,'MovementNumber');
               ParamsMovement_local.ParamByName('OrderExternal_BarCode').AsString:='';
               ParamsMovement_local.ParamByName('OrderExternal_InvNumber').AsString:='';
               ParamsMovement_local.ParamByName('calcPartnerId').AsInteger:=0;
               ParamsMovement_local.ParamByName('calcPartnerCode').AsInteger:=0;
               ParamsMovement_local.ParamByName('calcPartnerName').AsString:='';
          end
     else begin MessagePanel.Font.Style:=[];MessagePanel.Caption:='����� �����������';end;

     if BarCode<>'' then ParamsMovement_local.ParamByName('OrderExternal_BarCode').AsString:=BarCode;

     IsBarCodeMaster:=BarCode<>'';
     IsOrderExternal:=false;

     CDS.Filtered:=false;

     ChoiceNumber:=0;
     with ParamsMovement_local do
     begin
          CDS.Locate('Number',ParamByName('MovementDescNumber').AsString,[]);
          if ParamByName('OrderExternal_BarCode').AsString<>''
          then EditBarCode.Text:=ParamByName('OrderExternal_BarCode').AsString
          else EditBarCode.Text:=ParamByName('OrderExternal_InvNumber').AsString;

          EditPartnerCode.Text:= IntToStr(ParamByName('calcPartnerCode').AsInteger);
          PanelPartnerName.Caption:= ParamByName('calcPartnerName').AsString;
     end;

     ActiveControl:=EditBarCode;

     if BarCode<>'' then begin EditBarCodeExit(EditBarCode);Result:=true;end
     else Result:=(ShowModal=mrOk);
end;
{------------------------------------------------------------------------}
function TDialogMovementDescForm.Checked: boolean; //�������� ����������� ����� � Edit
begin
     ChoiceNumber:=0;
     //
     Result:=(IsOrderExternal=true)and(CDS.FieldByName('MovementDescId').AsInteger>0)and(ActiveControl=DBGrid);
     if not Result then exit;

     // �������� ��� �����������
     if ((CDS.FieldByName('MovementDescId').asInteger=zc_Movement_Income)
       or(CDS.FieldByName('MovementDescId').asInteger=zc_Movement_ReturnOut)
       or(CDS.FieldByName('MovementDescId').asInteger=zc_Movement_Sale)
       or(CDS.FieldByName('MovementDescId').asInteger=zc_Movement_ReturnIn)
        )
       and(ParamsMovement_local.ParamByName('calcPartnerId').AsInteger=0)
     then begin
               ShowMessage('������.�������� <��� �����������> �� �������.');
               ActiveControl:=EditPartnerCode;
               Result:=false;
               exit;
     end;
     // �������� ��� ����� ������
     if ((CDS.FieldByName('MovementDescId').asInteger=zc_Movement_Income)
       or(CDS.FieldByName('MovementDescId').asInteger=zc_Movement_ReturnOut)
       or(CDS.FieldByName('MovementDescId').asInteger=zc_Movement_Sale)
       or(CDS.FieldByName('MovementDescId').asInteger=zc_Movement_ReturnIn)
        )
       and(ParamsMovement_local.ParamByName('PaidKindId').AsInteger<>CDS.FieldByName('PaidKindId').asInteger)
       and(ParamsMovement_local.ParamByName('PaidKindId').AsInteger>0)
     then begin
               ShowMessage('������.�������� �������� <����� ������> = <'+ParamsMovement_local.ParamByName('PaidKindName').asString+'>.');
               if(Length(trim(EditBarCode.Text))=1)or(Length(trim(EditBarCode.Text))=2)
               then ActiveControl:=EditBarCode
               else ActiveControl:=DBGrid;
               Result:=false;
               exit;
     end;

     //
     with ParamsMovement_local do
     begin
          //
          //if ParamByName('MovementId').AsInteger<>0
          //then ShowMessage('����� ���������� <������> ����������� ������� � �������� ����� ���������� �������������.');
          ParamByName('MovementId').AsInteger:=0;
          //
          ParamByName('ColorGridValue').AsInteger:=CDS.FieldByName('ColorGridValue').asInteger;
          ParamByName('MovementDescNumber').AsInteger:= CDS.FieldByName('Number').asInteger;
          ParamByName('MovementDescId').AsInteger:= CDS.FieldByName('MovementDescId').asInteger;
          ParamByName('MovementDescName_master').asString:= CDS.FieldByName('MovementDescName_master').asString;
          ParamByName('GoodsKindWeighingGroupId').asInteger:= CDS.FieldByName('GoodsKindWeighingGroupId').asInteger;

          if  (CDS.FieldByName('MovementDescId').asInteger = zc_Movement_ReturnIn)
            or(CDS.FieldByName('MovementDescId').asInteger = zc_Movement_Income)
          then begin
                    ParamByName('FromId').AsInteger:= ParamByName('calcPartnerId').asInteger;
                    ParamByName('FromCode').AsInteger:= ParamByName('calcPartnerCode').asInteger;
                    ParamByName('FromName').asString:= ParamByName('calcPartnerName').asString;
                    ParamByName('ToId').AsInteger:= CDS.FieldByName('ToId').asInteger;
                    ParamByName('ToCode').AsInteger:= CDS.FieldByName('ToCode').asInteger;
                    ParamByName('ToName').asString:= CDS.FieldByName('ToName').asString;
                    ParamByName('PaidKindId').AsInteger:= CDS.FieldByName('PaidKindId').asInteger;
                    ParamByName('PaidKindName').asString:= CDS.FieldByName('PaidKindName').asString;
                    ParamByName('InfoMoneyId').AsInteger  := CDS.FieldByName('InfoMoneyId').asInteger;
                    ParamByName('InfoMoneyCode').AsInteger:= CDS.FieldByName('InfoMoneyCode').asInteger;
                    ParamByName('InfoMoneyName').asString := CDS.FieldByName('InfoMoneyName').asString;
                    ParamByName('ChangePercentAmount').asFloat:= 0;
          end
          else
          if  (CDS.FieldByName('MovementDescId').asInteger = zc_Movement_Sale)
            or(CDS.FieldByName('MovementDescId').asInteger = zc_Movement_ReturnOut)
          then begin
                    ParamByName('FromId').AsInteger:= CDS.FieldByName('FromId').asInteger;
                    ParamByName('FromCode').asString:= CDS.FieldByName('FromCode').asString;
                    ParamByName('FromName').asString:= CDS.FieldByName('FromName').asString;
                    ParamByName('ToId').AsInteger:= ParamByName('calcPartnerId').asInteger;
                    ParamByName('ToCode').AsInteger:= ParamByName('calcPartnerCode').asInteger;
                    ParamByName('ToName').asString:= ParamByName('calcPartnerName').asString;
                    ParamByName('PaidKindId').AsInteger:= CDS.FieldByName('PaidKindId').asInteger;
                    ParamByName('PaidKindName').asString:= CDS.FieldByName('PaidKindName').asString;
                    ParamByName('InfoMoneyId').AsInteger  := CDS.FieldByName('InfoMoneyId').asInteger;
                    ParamByName('InfoMoneyCode').AsInteger:= CDS.FieldByName('InfoMoneyCode').asInteger;
                    ParamByName('InfoMoneyName').asString := CDS.FieldByName('InfoMoneyName').asString;
                    if (CDS.FieldByName('MovementDescId').asInteger <> zc_Movement_Sale)
                    then ParamByName('ChangePercentAmount').asFloat:= 0;
          end
          else begin
                    ParamByName('FromId').AsInteger:= CDS.FieldByName('FromId').asInteger;
                    ParamByName('FromCode').asString:= CDS.FieldByName('FromCode').asString;
                    ParamByName('FromName').asString:= CDS.FieldByName('FromName').asString;
                    ParamByName('ToId').AsInteger:= CDS.FieldByName('ToId').asInteger;
                    ParamByName('ToCode').AsInteger:= CDS.FieldByName('ToCode').asInteger;
                    ParamByName('ToName').asString:= CDS.FieldByName('ToName').asString;
                    ParamByName('PriceListId').AsInteger   := CDS.FieldByName('PriceListId').asInteger;
                    ParamByName('PriceListCode').AsInteger := CDS.FieldByName('PriceListCode').asInteger;
                    ParamByName('PriceListName').asString  := CDS.FieldByName('PriceListName').asString;
                    ParamByName('calcPartnerId').asInteger:=0;
                    ParamByName('calcPartnerCode').asInteger:=0;
                    ParamByName('calcPartnerName').asString:='';
                    ParamByName('ChangePercent').asFloat:= 0;
                    ParamByName('ChangePercentAmount').asFloat:= 0;
                    ParamByName('isEdiOrdspr').asBoolean:= FALSE;
                    ParamByName('isEdiInvoice').asBoolean:= FALSE;
                    ParamByName('isEdiDesadv').asBoolean:= FALSE;
                    ParamByName('ContractId').AsInteger    := 0;
                    ParamByName('ContractCode').AsInteger    := 0;
                    ParamByName('ContractNumber').asString := '';
                    ParamByName('ContractTagName').asString := '';
                    ParamByName('PaidKindId').AsInteger:= 0;
                    ParamByName('PaidKindName').asString:= '';

                    ParamByName('InfoMoneyId').AsInteger  := CDS.FieldByName('InfoMoneyId').asInteger;
                    ParamByName('InfoMoneyCode').AsInteger:= CDS.FieldByName('InfoMoneyCode').asInteger;
                    ParamByName('InfoMoneyName').asString := CDS.FieldByName('InfoMoneyName').asString;
                    ParamByName('GoodsPropertyId').AsInteger  := 0;
                    ParamByName('GoodsPropertyCode').AsInteger:= 0;
                    ParamByName('GoodsPropertyName').asString := '';

               end;

    end;

    if(Length(trim(EditBarCode.Text))<=2)
    then EditBarCode.Text:=CDS.FieldByName('Number').asString;

    CopyValuesParamsFrom(ParamsMovement_local,ParamsMovement);

    MyDelay(400);
end;
{------------------------------------------------------------------------}
procedure TDialogMovementDescForm.EditBarCodeEnter(Sender: TObject);
begin
    if CDS.Filtered then CDS.Filtered:=false;
    CDS.Locate('Number',ParamsMovement_local.ParamByName('MovementDescNumber').AsString,[]);
end;
{------------------------------------------------------------------------}
procedure TDialogMovementDescForm.EditBarCodeExit(Sender: TObject);
var Number:Integer;
    fOK:Boolean;
begin
    if CDS.Filtered then CDS.Filtered:=false;
    //
    if Length(trim(EditBarCode.Text))>2
    then begin
               //�������� <����������� �����>
               if (Length(trim(EditBarCode.Text))>=13)and(CheckBarCode(trim(EditBarCode.Text)) = FALSE)
               then begin
                  EditBarCode.Text:='';
                  ActiveControl:=EditBarCode;
                  exit;
               end;
              //����� �� ������ ��� �-�
              isOrderExternal:=DMMainScaleForm.gpGet_Scale_OrderExternal(ParamsMovement_local,EditBarCode.Text);
              if isOrderExternal=false then
              begin
                   ShowMessage('������.�������� <����� ���/����� ������> �� �������.');
                   ActiveControl:=EditBarCode;
                   exit;
              end
              else begin
                        EditPartnerCode.Text:= IntToStr(ParamsMovement_local.ParamByName('calcPartnerCode').AsInteger);
                        PanelPartnerName.Caption:= ParamsMovement_local.ParamByName('calcPartnerName').asString;
                   end;
    end
    else begin //���������
               isOrderExternal:=true;
               ParamsMovement_local.ParamByName('OrderExternalId').AsInteger:=0;
               ParamsMovement_local.ParamByName('OrderExternal_BarCode').asString :='';
               ParamsMovement_local.ParamByName('OrderExternal_InvNumber').asString :='';
               //
               try Number:=StrToInt(trim(EditBarCode.Text)) except Number:=0;end;
               // ���� ��� ��� ��������
               if Number>0 then
               begin
                    CDS.Locate('Number',IntToStr(Number),[]);
                    fOK:=CDS.FieldByName('Number').asInteger=Number;
                    CDS.Filter:='Number='+IntToStr(Number)+' or MovementDescId='+IntToStr(-1*CDS.FieldByName('MovementDescId').asInteger);
                    CDS.Filtered:=true;
                    CDS.Locate('Number',IntToStr(Number),[]);
                    if not fOK then
                    begin
                         if not IsBarCodeMaster then ShowMessage('������.�������� <��� ���������> �� ����������.');
                         ActiveControl:=EditBarCode;
                         exit;
                    end;
                    //
                    ParamsMovement_local.ParamByName('MovementDescNumber').AsInteger:= CDS.FieldByName('Number').asInteger;
                    ParamsMovement_local.ParamByName('InfoMoneyId').AsInteger  := CDS.FieldByName('InfoMoneyId').asInteger;
                    ParamsMovement_local.ParamByName('InfoMoneyCode').AsInteger:= CDS.FieldByName('InfoMoneyCode').asInteger;
                    ParamsMovement_local.ParamByName('InfoMoneyName').asString := CDS.FieldByName('InfoMoneyName').asString;

                    ChoiceNumber:=CDS.FieldByName('Number').asInteger;
                    // ����������
                    if   (CDS.FieldByName('MovementDescId').asInteger<>zc_Movement_Income)
                      and(CDS.FieldByName('MovementDescId').asInteger<>zc_Movement_ReturnOut)
                      and(CDS.FieldByName('MovementDescId').asInteger<>zc_Movement_Sale)
                      and(CDS.FieldByName('MovementDescId').asInteger<>zc_Movement_ReturnIn)
                    then begin ActiveControl:=DBGrid;DBGridCellClick(DBGrid.Columns[0]);end;
               end;
          end;
    //
    if ParamsMovement_local.ParamByName('OrderExternal_BarCode').asString<>''
    then begin
              CDS.Filter:='(MovementDescId='+IntToStr(ParamsMovement_local.ParamByName('MovementDescId').asInteger)
                    +'  and PaidKindId='+IntToStr(ParamsMovement_local.ParamByName('PaidKindId').asInteger)
                    //+'  and FromId='+IntToStr(ParamsMovement_local.ParamByName('FromId').asInteger)
                    +'     )'
                    +'  or MovementDescId='+IntToStr(-1*ParamsMovement_local.ParamByName('MovementDescId').asInteger)
                    ;
              CDS.Filtered:=true;
              CDS.Locate('MovementDescId',ParamsMovement_local.ParamByName('MovementDescId').asString,[]);
              if CDS.RecordCount<>2 then
              begin
                   ShowMessage('������.�������� <��� ���������> �� ����������.');
                   ActiveControl:=EditBarCode;
                   isOrderExternal:=false;
                   exit;
              end;
              // ����������
              ActiveControl:=DBGrid;
              DBGridCellClick(DBGrid.Columns[0]);
         end;
end;
{------------------------------------------------------------------------}
procedure TDialogMovementDescForm.EditBarCodeChange(Sender: TObject);
begin
    if (Length(trim(EditBarCode.Text))>=13)and(not IsBarCodeMaster) then EditBarCodeExit(Self);
end;
{------------------------------------------------------------------------}
procedure TDialogMovementDescForm.EditPartnerCodeEnter(Sender: TObject);
begin
  TEdit(Sender).SelectAll;
end;
{------------------------------------------------------------------------}
procedure TDialogMovementDescForm.EditPartnerCodeExit(Sender: TObject);
var PartnerCode_int:Integer;
begin
     //!!!exit!!!
     if isEditPartnerCodeExit = false then exit;

    //if CDS.Filtered then CDS.Filtered:=false;
    //
    try PartnerCode_int:= StrToInt(EditPartnerCode.Text);
    except
      PartnerCode_int:= 0;
    end;

    if (ParamsMovement_local.ParamByName('OrderExternalId').AsInteger<>0)
    then exit;//!!!����� � ���� ������!!!
    if (PartnerCode_int=0)
    then exit;//!!!����� � ���� ������!!!

     //���������������� PaidKindId, �.�. �� ������������ � Get
     if CDS.RecordCount = 2
     then ParamsMovement_local.ParamByName('PaidKindId').AsInteger:=CDS.FieldByName('PaidKindId').asInteger
     else ParamsMovement_local.ParamByName('PaidKindId').AsInteger:=0;
     //����������� ���������
     if DMMainScaleForm.gpGet_Scale_Partner(ParamsMovement_local,PartnerCode_int) = true then
     begin
          EditPartnerCode.Text:= IntToStr(ParamsMovement_local.ParamByName('calcPartnerCode').AsInteger);
          PanelPartnerName.Caption:= ParamsMovement_local.ParamByName('calcPartnerName').asString;
     end;

     if ParamsMovement_local.ParamByName('calcPartnerId').AsInteger=0
     then begin
               ShowMessage('������.�������� <��� �����������> �� �������.');
               ActiveControl:=EditPartnerCode;
               exit;
     end;
     //
     if ParamsMovement_local.ParamByName('ContractId').AsInteger=0
     then begin
               ShowMessage('������.� ����������� �� ���������� �������� <�������>.');
               ActiveControl:=EditPartnerCode;
               exit;
     end;
     if ParamsMovement_local.ParamByName('PriceListId').AsInteger=0
     then begin
               ShowMessage('������.� ����������� �� ���������� �������� <�����-����>.');
               ActiveControl:=EditPartnerCode;
               exit;
     end;
     if ParamsMovement_local.ParamByName('PaidKindId').AsInteger=0
     then begin
               ShowMessage('������.� ����������� �� ���������� �������� <����� ������>.');
               ActiveControl:=EditPartnerCode;
               exit;
     end;
end;
{------------------------------------------------------------------------}
procedure TDialogMovementDescForm.EditPartnerCodeKeyDown(Sender: TObject;var Key: Word; Shift: TShiftState);
begin
     if Key = VK_RETURN
     then if CDS.RecordCount=2
          then begin ActiveControl:=DBGrid;DBGridCellClick(DBGrid.Columns[0]);end
          else ActiveControl:=EditBarCode;
end;
{------------------------------------------------------------------------}
procedure TDialogMovementDescForm.EditPartnerCodePropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
var Key:Word;
begin
    if ParamsMovement_local.ParamByName('MovementDescNumber').AsInteger<>0
    then begin
              EditBarCode.Text:=ParamsMovement_local.ParamByName('MovementDescNumber').AsString;
              EditBarCodeExit(Self);
    end;

    if GuidePartnerForm.Execute(ParamsMovement_local)
    then begin
              EditPartnerCode.Text:=IntToStr(ParamsMovement_local.ParamByName('calcPartnerCode').AsInteger);
              PanelPartnerName.Caption:= ParamsMovement_local.ParamByName('calcPartnerName').AsString;
              Key:=VK_RETURN;
              isEditPartnerCodeExit:= false;
              EditPartnerCodeKeyDown(Sender,Key,[]);
              isEditPartnerCodeExit:= true;
    end;
end;

{------------------------------------------------------------------------}
procedure TDialogMovementDescForm.DBGridCellClick(Column: TColumn);
begin
     if (CDS.FieldByName('MovementDescId').AsInteger<=0)
     then CDS.Next
     else begin
               ChoiceNumber:=CDS.FieldByName('Number').AsInteger;
               DBGrid.Repaint;
               bbOkClick(Self);
     end;
end;
{------------------------------------------------------------------------}
procedure TDialogMovementDescForm.DBGridDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
     if (gdSelected in State)and(ChoiceNumber=0) then exit;

     //if ChoiceNumber <> 0 then ShowMessage (CDS.FieldByName('Number').AsString);

     with (Sender as TDBGrid).Canvas do
     if CDS.FieldByName('MovementDescId').AsInteger<=0 then
     begin
          Font.Color:=clNavy;
          Font.Size:=11;
          Font.Style:=[fsBold];
          FillRect(Rect);
          //TextOut(Rect.Left + 30, Rect.Top + 0, Column.Field.Text);
          if (Column.Alignment=taLeftJustify)or(Rect.Left>=Rect.Right - LengTh(Column.Field.Text))
          then TextOut(Rect.Left+32, Rect.Top+2, Column.Field.Text)
          else TextOut(Rect.Right - TextWidth(Column.Field.Text) - 2, Rect.Top+2 , Column.Field.Text);
     end
     else
     if CDS.FieldByName('Number').AsInteger=ChoiceNumber then
     begin
          Font.Color:=clBlue;
          Font.Size:=10;
          Font.Style:=[];
          FillRect(Rect);
          //TextOut(Rect.Left + 2, Rect.Top + 2, Column.Field.Text);
          if (Column.Alignment=taLeftJustify)or(Rect.Left>=Rect.Right - LengTh(Column.Field.Text))
          then TextOut(Rect.Left+2, Rect.Top+2, Column.Field.Text)
          else TextOut(Rect.Right - TextWidth(Column.Field.Text) - 2, Rect.Top+2 , Column.Field.Text);
     end
     else
     begin
          Font.Color:=clBlack;
          Font.Size:=10;
          Font.Style:=[];
          FillRect(Rect);
          //TextOut(Rect.Left + 5, Rect.Top + 0, Column.Field.Text);
          if (Column.Alignment=taLeftJustify)or(Rect.Left>=Rect.Right - LengTh(Column.Field.Text))
          then TextOut(Rect.Left+2, Rect.Top+2, Column.Field.Text)
          else TextOut(Rect.Right - TextWidth(Column.Field.Text) - 2, Rect.Top+2 , Column.Field.Text);
     end;
end;
{------------------------------------------------------------------------}
procedure TDialogMovementDescForm.FormCreate(Sender: TObject);
begin
  inherited;
  with spSelect do
  begin
       StoredProcName:='gpSelect_Object_ToolsWeighing_MovementDesc';
       OutputType:=otDataSet;
       Params.AddParam('inBrancCode', ftInteger, ptInput, SettingMain.BrancCode);
       Execute;
  end;
  //
  Create_ParamsMovement(ParamsMovement_local);
  //global Initialize
  gpInitialize_MovementDesc;
  //
  bbOk.Visible := false;
end;
{------------------------------------------------------------------------}
procedure TDialogMovementDescForm.FormDestroy(Sender: TObject);
begin
  ParamsMovement_local.Free;
  ParamsMovement.Free;
end;
{------------------------------------------------------------------------}
procedure TDialogMovementDescForm.FormKeyDown(Sender: TObject; var Key: Word;  Shift: TShiftState);
begin
     if Key = VK_RETURN
     then if (ActiveControl=EditBarCode)
          then ActiveControl:=EditPartnerCode
          else if (ActiveControl=EditPartnerCode)
               then ActiveControl:=DBGrid
               else if (ActiveControl=DBGrid)
                    then DBGridCellClick(DBGrid.Columns[0]);
end;
{------------------------------------------------------------------------}
procedure TDialogMovementDescForm.FormKeyUp(Sender: TObject; var Key: Word;Shift: TShiftState);
begin
     if (Key = VK_UP)or(Key = VK_DOWN)or(Key = VK_HOME)or(Key = VK_END)or(Key = VK_PRIOR)or(Key = VK_NEXT)
     then if (CDS.FieldByName('MovementDescId').AsInteger<=0)
          then CDS.Next;
end;
{------------------------------------------------------------------------}
end.
