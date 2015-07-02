unit DialogPrint;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, AncestorDialogScale, StdCtrls, Mask, Buttons,
  ExtCtrls, cxGraphics, cxLookAndFeels, cxLookAndFeelPainters, Vcl.Menus,
  dxSkinsCore, dxSkinsDefaultPainters, cxControls, cxContainer, cxEdit,
  cxTextEdit, cxCurrencyEdit, dsdDB, Vcl.ActnList, dsdAction, cxPropertiesStore,
  dsdAddOn, cxButtons;

type
  TDialogPrintForm = class(TAncestorDialogScaleForm)
    PrintPanel: TPanel;
    PrintCountEdit: TcxCurrencyEdit;
    PrintCountLabel: TLabel;
    PrintIsValuePanel: TPanel;
    cbPrintMovement: TCheckBox;
    cbPrintAccount: TCheckBox;
    cbPrintTransport: TCheckBox;
    cbPrintQuality: TCheckBox;
    cbPrintPack: TCheckBox;
    cbPrintSpec: TCheckBox;
    cbPrintTax: TCheckBox;
    cbPrintPreview: TCheckBox;
    procedure cbPrintTransportClick(Sender: TObject);
    procedure cbPrintQualityClick(Sender: TObject);
    procedure cbPrintTaxClick(Sender: TObject);
    procedure cbPrintAccountClick(Sender: TObject);
    procedure cbPrintPackClick(Sender: TObject);
    procedure cbPrintSpecClick(Sender: TObject);
  private
    function Checked: boolean; override;//�������� ����������� ����� � Edit
  public
    function Execute(MovementDescId:Integer;isMovement, isAccount, isTransport, isQuality, isPack, isSpec, isTax : Boolean): Boolean; virtual;
  end;

var
   DialogPrintForm: TDialogPrintForm;

implementation
{$R *.dfm}
uses UtilScale;
{------------------------------------------------------------------------------}
function TDialogPrintForm.Execute(MovementDescId:Integer;isMovement, isAccount, isTransport, isQuality, isPack, isSpec, isTax : Boolean): Boolean; //�������� ����������� ����� � Edit
begin
     // ��� ScaleCeh ������ ���� ������
     if (SettingMain.isCeh = TRUE)or((MovementDescId<>zc_Movement_Sale)and(MovementDescId<>zc_Movement_SendOnPrice))
     then cbPrintMovement.Checked:= TRUE
     else cbPrintMovement.Checked:= isMovement;
     //
     cbPrintAccount.Enabled:=(SettingMain.isCeh = FALSE);//or(MovementDescId=zc_Movement_Sale)or(MovementDescId<>zc_Movement_SendOnPrice);
     cbPrintTransport.Enabled:=SettingMain.isCeh = cbPrintAccount.Enabled;
     cbPrintQuality.Enabled:=SettingMain.isCeh = cbPrintAccount.Enabled;
     cbPrintPack.Enabled:=SettingMain.isCeh = cbPrintAccount.Enabled;
     cbPrintSpec.Enabled:=SettingMain.isCeh = cbPrintAccount.Enabled;
     cbPrintTax.Enabled:=SettingMain.isCeh = cbPrintAccount.Enabled;
     //
     cbPrintAccount.Checked:=(isAccount) and (cbPrintAccount.Enabled);
     cbPrintTransport.Checked:=(isTransport) and (cbPrintTransport.Enabled);
     cbPrintQuality.Checked:=(isQuality) and (cbPrintQuality.Enabled);
     cbPrintPack.Checked:=(isPack) and (cbPrintPack.Enabled);
     cbPrintSpec.Checked:=(isSpec) and (cbPrintSpec.Enabled);
     cbPrintTax.Checked:=(isTax) and (cbPrintTax.Enabled);
     //
     cbPrintPreview.Checked:=GetArrayList_Value_byName(Default_Array,'isPrintPreview') = AnsiUpperCase('TRUE');
     PrintCountEdit.Text:=GetArrayList_Value_byName(Default_Array,'PrintCount');
     //
     ActiveControl:=PrintCountEdit;
     //
     Result:=(ShowModal=mrOk);
end;
{------------------------------------------------------------------------------}
function TDialogPrintForm.Checked: boolean; //�������� ����������� ����� � Edit
begin
     try Result:=(StrToInt(PrintCountEdit.Text)>0) and (StrToInt(PrintCountEdit.Text)<11);
     except Result:=false;
     end;
     //
     if not Result then ShowMessage('������.�������� <���-�� �����> �� �������� � �������� �� <1> �� <10>.')
end;
{------------------------------------------------------------------------------}
procedure TDialogPrintForm.cbPrintTransportClick(Sender: TObject);
begin
     if cbPrintTransport.Checked
     then
         if  (ParamsMovement.ParamByName('MovementDescId').AsInteger<>zc_Movement_Sale)
          and(ParamsMovement.ParamByName('MovementDescId').AsInteger<>zc_Movement_SendOnPrice)
         then cbPrintTransport.Checked:=false;
end;
{------------------------------------------------------------------------------}
procedure TDialogPrintForm.cbPrintQualityClick(Sender: TObject);
begin
     if cbPrintQuality.Checked
     then
         if  (ParamsMovement.ParamByName('MovementDescId').AsInteger<>zc_Movement_Sale)
          and(ParamsMovement.ParamByName('MovementDescId').AsInteger<>zc_Movement_SendOnPrice)
          and(ParamsMovement.ParamByName('MovementDescId').AsInteger<>zc_Movement_Loss)
         then cbPrintQuality.Checked:=false;
end;
{------------------------------------------------------------------------------}
procedure TDialogPrintForm.cbPrintTaxClick(Sender: TObject);
begin
     if cbPrintTax.Checked
     then
         if  (ParamsMovement.ParamByName('MovementDescId').AsInteger<>zc_Movement_Sale)
          or (GetArrayList_Value_byName(Default_Array,'isTax') <> AnsiUpperCase('TRUE'))
         then cbPrintTax.Checked:=false;
end;
{------------------------------------------------------------------------------}
procedure TDialogPrintForm.cbPrintAccountClick(Sender: TObject);
begin
     if cbPrintAccount.Checked
     then
         if  (ParamsMovement.ParamByName('MovementDescId').AsInteger<>zc_Movement_Sale)
         then cbPrintAccount.Checked:=false;
end;
{------------------------------------------------------------------------------}
procedure TDialogPrintForm.cbPrintPackClick(Sender: TObject);
begin
     if cbPrintPack.Checked
     then
         if  (ParamsMovement.ParamByName('MovementDescId').AsInteger<>zc_Movement_Sale)
         then cbPrintPack.Checked:=false;
end;
{------------------------------------------------------------------------------}
procedure TDialogPrintForm.cbPrintSpecClick(Sender: TObject);
begin
     if cbPrintSpec.Checked
     then
         if  (ParamsMovement.ParamByName('MovementDescId').AsInteger<>zc_Movement_Sale)
         then cbPrintSpec.Checked:=false;
end;
{------------------------------------------------------------------------------}
end.
