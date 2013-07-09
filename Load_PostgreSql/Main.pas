unit Main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, DBTables, Grids, DBGrids, StdCtrls, ExtCtrls, Gauges, ADODB,
  Mask, ZStoredProcedure, ZAbstractRODataset, ZAbstractDataset, ZDataset,
  ZAbstractConnection, ZConnection, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, Vcl.ComCtrls, dxCore, cxDateUtils,
  dxSkinsCore, dxSkinBlack, dxSkinBlue, dxSkinBlueprint, dxSkinCaramel,
  dxSkinCoffee, dxSkinDarkRoom, dxSkinDarkSide, dxSkinDevExpressDarkStyle,
  dxSkinDevExpressStyle, dxSkinFoggy, dxSkinGlassOceans, dxSkinHighContrast,
  dxSkiniMaginary, dxSkinLilian, dxSkinLiquidSky, dxSkinLondonLiquidSky,
  dxSkinMcSkin, dxSkinMoneyTwins, dxSkinOffice2007Black, dxSkinOffice2007Blue,
  dxSkinOffice2007Green, dxSkinOffice2007Pink, dxSkinOffice2007Silver,
  dxSkinOffice2010Black, dxSkinOffice2010Blue, dxSkinOffice2010Silver,
  dxSkinPumpkin, dxSkinSeven, dxSkinSevenClassic, dxSkinSharp, dxSkinSharpPlus,
  dxSkinSilver, dxSkinSpringTime, dxSkinStardust, dxSkinSummer2008,
  dxSkinTheAsphaltWorld, dxSkinsDefaultPainters, dxSkinValentine, dxSkinVS2010,
  dxSkinWhiteprint, dxSkinXmas2008Blue, cxTextEdit, cxMaskEdit, cxDropDownEdit,
  cxCalendar, dsdDB,UtilConst;

type
  TMainForm = class(TForm)
    DataSource: TDataSource;
    DBGrid: TDBGrid;
    ButtonPanel: TPanel;
    OKGuideButton: TButton;
    GuidePanel: TPanel;
    cbGoodsGroup: TCheckBox;
    cbAllGuide: TCheckBox;
    Gauge: TGauge;
    cbGoods: TCheckBox;
    fromADOConnection: TADOConnection;
    fromQuery: TADOQuery;
    fromSqlQuery: TADOQuery;
    StopButton: TButton;
    CloseButton: TButton;
    cbMeasure: TCheckBox;
    cbGoodsKind: TCheckBox;
    cbPaidKind: TCheckBox;
    cbJuridicalGroup: TCheckBox;
    cbContractKind: TCheckBox;
    cbContract: TCheckBox;
    cbJuridical: TCheckBox;
    cbPartner: TCheckBox;
    cbBusiness: TCheckBox;
    cbBranch: TCheckBox;
    cbUnitGroup: TCheckBox;
    cbUnit: TCheckBox;
    cbPriceList: TCheckBox;
    cbPriceListItems: TCheckBox;
    cbGoodsProperty: TCheckBox;
    cbGoodsPropertyValue: TCheckBox;
    cbSetNull_Id_Postgres: TCheckBox;
    cbOnlyOpen: TCheckBox;
    DocumentPanel: TPanel;
    cbAllDocument: TCheckBox;
    cbIncome: TCheckBox;
    OKDocumentButton: TButton;
    Label1: TLabel;
    Label2: TLabel;
    toZConnection: TZConnection;
    toQuery: TZQuery;
    toStoredProc_ZConnection: TZStoredProc;
    StartDateEdit: TcxDateEdit;
    EndDateEdit: TcxDateEdit;
    toStoredProc: TdsdStoredProc;
    cbInfoMoneyGroup: TCheckBox;
    cbInfoMoneyDestination: TCheckBox;
    cbInfoMoney: TCheckBox;
    cbAccountGroup: TCheckBox;
    cbAccountDirection: TCheckBox;
    cbAccount: TCheckBox;
    cbProfitLoss: TCheckBox;
    cbProfitLossDirection: TCheckBox;
    cbProfitLossGroup: TCheckBox;
    CompleteDocumentPanel: TPanel;
    Label3: TLabel;
    Label4: TLabel;
    cbAllCompleteDocument: TCheckBox;
    cbCompleteIncome: TCheckBox;
    StartDateCompleteEdit: TcxDateEdit;
    EndDateCompleteEdit: TcxDateEdit;
    cbComplete: TCheckBox;
    cbUnComplete: TCheckBox;
    OKCompleteDocumentButton: TButton;
    toStoredProc_two: TdsdStoredProc;
    cbMember_andPersonal: TCheckBox;
    cbIncomePacker: TCheckBox;
    CheckBox1: TCheckBox;
    procedure OKGuideButtonClick(Sender: TObject);
    procedure cbAllGuideClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure StopButtonClick(Sender: TObject);
    procedure CloseButtonClick(Sender: TObject);
    procedure cbAllDocumentClick(Sender: TObject);
    procedure OKDocumentButtonClick(Sender: TObject);
    procedure DocumentPanelClick(Sender: TObject);
    procedure cbAllCompleteDocumentClick(Sender: TObject);
    procedure cbCompleteClick(Sender: TObject);
    procedure cbUnCompleteClick(Sender: TObject);
    procedure cbCompleteIncomeClick(Sender: TObject);
    procedure OKCompleteDocumentButtonClick(Sender: TObject);
  private
    fStop:Boolean;
    procedure EADO_EngineErrorMsg(E:EADOError);
    procedure EDB_EngineErrorMsg(E:EDBEngineError);
    function myExecToStoredProc_ZConnection:Boolean;
    function myExecToStoredProc:Boolean;
    function myExecToStoredProc_two:Boolean;

    function FormatToVarCharServer_notNULL(_Value:string):string;
    function FormatToDateServer_notNULL(_Date:TDateTime):string;

    function fGetSession:String;
    function fExecSqFromQuery (mySql:String):Boolean;

    procedure pSetNullGuide_Id_Postgres;
    procedure pSetNullDocument_Id_Postgres;

    procedure pCompleteDocument_Income;
    procedure pLoadDocument_Income;
    procedure pLoadDocumentItem_Income;
    procedure pLoadDocument_IncomePacker;
    procedure pLoadDocumentItem_IncomePacker;

    procedure pLoadGuide_Measure;
    procedure pLoadGuide_GoodsGroup;
    procedure pLoadGuide_Goods;
    procedure pLoadGuide_Goods_toZConnection;
    procedure pLoadGuide_GoodsKind;
    procedure pLoadGuide_PaidKind;
    procedure pLoadGuide_ContractKind;
    procedure pLoadGuide_JuridicalGroup;
    procedure pLoadGuide_Juridical (isBill:Boolean);
    procedure pLoadGuide_Partner (isBill:Boolean);
    procedure pLoadGuide_Branch;
    procedure pLoadGuide_Business;
    procedure pLoadGuide_UnitGroup;
    procedure pLoadGuide_UnitOld;
    procedure pLoadGuide_Unit;
    procedure pLoadGuide_Member_andPersonal;

    procedure pLoadGuide_PriceList;
    procedure pLoadGuide_GoodsProperty;
    procedure pLoadGuide_GoodsPropertyValue;

    procedure pLoadGuide_InfoMoneyGroup;
    procedure pLoadGuide_InfoMoneyDestination;
    procedure pLoadGuide_InfoMoney;
    procedure pLoadGuide_AccountGroup;
    procedure pLoadGuide_AccountDirection;
    procedure pLoadGuide_Account;
    procedure pLoadGuide_ProfitLossGroup;
    procedure pLoadGuide_ProfitLossDirection;
    procedure pLoadGuide_ProfitLoss;

    procedure myEnabledCB (cb:TCheckBox);
    procedure myDisabledCB (cb:TCheckBox);
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation
{$R *.dfm}
//----------------------------------------------------------------------------------------------------------------------------------------------------
procedure TMainForm.StopButtonClick(Sender: TObject);
begin
     if MessageDlg('������������� ���������� ��������?',mtConfirmation,[mbYes,mbNo],0)<>mrYes then exit;
     fStop:=true;
     DBGrid.Enabled:=true;
     OKGuideButton.Enabled:=true;
     OKDocumentButton.Enabled:=true;
     OKCompleteDocumentButton.Enabled:=true;
end;
//----------------------------------------------------------------------------------------------------------------------------------------------------
procedure TMainForm.CloseButtonClick(Sender: TObject);
begin
     if not fStop then
       if MessageDlg('������������� ���������� �������� � �����?',mtConfirmation,[mbYes,mbNo],0)=mrYes then fStop:=true;
     //
     if fStop then Close;
end;
procedure TMainForm.DocumentPanelClick(Sender: TObject);
begin

end;

//----------------------------------------------------------------------------------------------------------------------------------------------------
function TMainForm.fGetSession:String;
begin Result:='1005'; end;
//----------------------------------------------------------------------------------------------------------------------------------------------------
function TMainForm.fExecSqFromQuery(mySql:String):Boolean;
begin
     with fromSqlQuery,Sql do begin
        Clear;
        Add(mySql);
        try ExecSql except ShowMessage('fExecSqFromQuery'+#10+#13+mySql);Result:=false;exit;end;
     end;
     Result:=true;
end;
//----------------------------------------------------------------------------------------------------------------------------------------------------
function TMainForm.FormatToVarCharServer_notNULL(_Value:string):string;
begin if trim(_Value)='' then Result:=chr(39)+''+chr(39) else Result:=chr(39)+trim(_Value)+chr(39);end;
//----------------------------------------------------------------------------------------------------------------------------------------------------
function TMainForm.FormatToDateServer_notNULL(_Date:TDateTime):string;
var
  Year, Month, Day: Word;
begin
     DecodeDate(_Date,Year,Month,Day);
     result:=chr(39)+IntToStr(Year)+'-'+IntToStr(Month)+'-'+IntToStr(Day)+chr(39);
end;
//----------------------------------------------------------------------------------------------------------------------------------------------------
function TMainForm.myExecToStoredProc_ZConnection:Boolean;
begin
    result:=false;
    toStoredProc_ZConnection.Prepared:=true;
     try toStoredProc_ZConnection.ExecProc;
     except
           //on E:EDBEngineError do begin EDB_EngineErrorMsg(E);exit;end;
           on E:EADOError do begin EADO_EngineErrorMsg(E);exit;end;

     end;
     result:=true;
end;
//----------------------------------------------------------------------------------------------------------------------------------------------------
function TMainForm.myExecToStoredProc:Boolean;
begin
    result:=false;
     // toStoredProc_two.Prepared:=true;
     //try
     toStoredProc.Execute;
     //except
           //on E:EDBEngineError do begin EDB_EngineErrorMsg(E);exit;end;
           //on E:EADOError do begin EADO_EngineErrorMsg(E);exit;end;
           exit;
     //end;
     result:=true;
end;
//----------------------------------------------------------------------------------------------------------------------------------------------------
function TMainForm.myExecToStoredProc_two:Boolean;
begin
    result:=false;
     // toStoredProc_two.Prepared:=true;
     // try
     toStoredProc_two.Execute;
     //except
           //on E:EDBEngineError do begin EDB_EngineErrorMsg(E);exit;end;
           //on E:EADOError do begin EADO_EngineErrorMsg(E);exit;end;
           exit;
     //end;
     result:=true;
end;
//----------------------------------------------------------------------------------------------------------------------------------------------------
procedure TMainForm.EADO_EngineErrorMsg(E:EADOError);
begin
  MessageDlg(E.Message,mtError,[mbOK],0);
end;
//----------------------------------------------------------------------------------------------------------------------------------------------------
procedure TMainForm.EDB_EngineErrorMsg(E:EDBEngineError);
var
  DBError: TDBError;
begin
  DBError:=E.Errors[1];
  MessageDlg(DBError.Message,mtError,[mbOK],0);
end;
//----------------------------------------------------------------------------------------------------------------------------------------------------
procedure TMainForm.myEnabledCB (cb:TCheckBox);
begin
     cb.Font.Style:=[fsBold];
     cb.Font.Color:=clBlue;
end;
//----------------------------------------------------------------------------------------------------------------------------------------------------
procedure TMainForm.myDisabledCB (cb:TCheckBox);
begin
     cb.Font.Style:=[];
     cb.Font.Color:=clWindowText;
end;
//----------------------------------------------------------------------------------------------------------------------------------------------------
procedure TMainForm.cbAllGuideClick(Sender: TObject);
var i:Integer;
begin
     for i:=0 to ComponentCount-1 do
        if (Components[i] is TCheckBox) then
          if Components[i].Tag=10
          then TCheckBox(Components[i]).Checked:=cbAllGuide.Checked;
end;
//----------------------------------------------------------------------------------------------------------------------------------------------------
procedure TMainForm.cbAllCompleteDocumentClick(Sender: TObject);
var i:Integer;
begin
     for i:=0 to ComponentCount-1 do
        if (Components[i] is TCheckBox) then
          if Components[i].Tag=30
          then TCheckBox(Components[i]).Checked:=cbAllCompleteDocument.Checked;
end;
//----------------------------------------------------------------------------------------------------------------------------------------------------
procedure TMainForm.cbAllDocumentClick(Sender: TObject);
var i:Integer;
begin
     for i:=0 to ComponentCount-1 do
        if (Components[i] is TCheckBox) then
          if Components[i].Tag=20
          then TCheckBox(Components[i]).Checked:=cbAllDocument.Checked;
end;
//----------------------------------------------------------------------------------------------------------------------------------------------------
procedure TMainForm.cbCompleteClick(Sender: TObject);
begin
      //cbUnComplete.Checked:=not cbComplete.Checked;
end;
//----------------------------------------------------------------------------------------------------------------------------------------------------
procedure TMainForm.cbUnCompleteClick(Sender: TObject);
begin
      //cbComplete.Checked:=not cbUnComplete.Checked;
end;
//----------------------------------------------------------------------------------------------------------------------------------------------------
procedure TMainForm.cbCompleteIncomeClick(Sender: TObject);
begin
     if (not cbComplete.Checked)and(not cbUnComplete.Checked)then cbComplete.Checked:=true;
end;
//----------------------------------------------------------------------------------------------------------------------------------------------------
procedure TMainForm.FormCreate(Sender: TObject);
var
  Present: TDateTime;
  Year, Month, Day, Hour, Min, Sec, MSec: Word;
begin
     Gauge.Visible:=false;
     Gauge.Progress:=0;
     //
     //cbAllGuide.Checked:=true;
     //
     fStop:=true;
     //
     Present:= Now;
     DecodeDate(Present, Year, Month, Day);
     StartDateEdit.Text:=DateToStr(StrToDate('01.'+IntToStr(Month)+'.'+IntToStr(Year)));
     StartDateCompleteEdit.Text:=StartDateEdit.Text;

     if Month=12 then begin Month:=1;Year:=Year+1;end else Month:=Month+1;
     EndDateEdit.Text:=DateToStr(StrToDate('01.'+IntToStr(Month)+'.'+IntToStr(Year))-1);
     EndDateCompleteEdit.Text:=EndDateEdit.Text;
end;
//----------------------------------------------------------------------------------------------------------------------------------------------------
procedure TMainForm.OKGuideButtonClick(Sender: TObject);
begin
     if MessageDlg('������������� ��������� ��������� �����������?',mtConfirmation,[mbYes,mbNo],0)<>mrYes then exit;
     fStop:=false;
     DBGrid.Enabled:=false;
     OKGuideButton.Enabled:=false;
     OKDocumentButton.Enabled:=false;
     OKCompleteDocumentButton.Enabled:=false;
     //
     Gauge.Visible:=true;
     //
     if cbSetNull_Id_Postgres.Checked then begin if MessageDlg('������������� set �����������+���������.Sybase.����.Id_Postgres = null?',mtConfirmation,[mbYes,mbNo],0)<>mrYes then exit;
                                                 pSetNullGuide_Id_Postgres;
                                                 pSetNullDocument_Id_Postgres;
                                           end;
     //
     if not fStop then pLoadGuide_Measure;
     if not fStop then pLoadGuide_GoodsGroup;
     if not fStop then pLoadGuide_Goods;
     //if not fStop then pLoadGuide_Goods_toZConnection;
     if not fStop then pLoadGuide_GoodsKind;
     if not fStop then pLoadGuide_PaidKind;
     if not fStop then pLoadGuide_ContractKind;
     if not fStop then pLoadGuide_JuridicalGroup;
     if not fStop then pLoadGuide_Juridical(false);
     if not fStop then pLoadGuide_Partner(false);

     if not fStop then pLoadGuide_Business;
     if not fStop then pLoadGuide_Branch;
     //if not fStop then pLoadGuide_UnitGroup;
     if not fStop then pLoadGuide_Unit;
     if not fStop then pLoadGuide_Member_andPersonal;

     if not fStop then pLoadGuide_PriceList;
     if not fStop then pLoadGuide_GoodsProperty;
     if not fStop then pLoadGuide_GoodsPropertyValue;

     if not fStop then pLoadGuide_InfoMoneyGroup;
     if not fStop then pLoadGuide_InfoMoneyDestination;
     if not fStop then pLoadGuide_InfoMoney;
     if not fStop then pLoadGuide_AccountGroup;
     if not fStop then pLoadGuide_AccountDirection;
     if not fStop then pLoadGuide_Account;
     if not fStop then pLoadGuide_ProfitLossGroup;
     if not fStop then pLoadGuide_ProfitLossDirection;
     if not fStop then pLoadGuide_ProfitLoss;
     //
     Gauge.Visible:=false;
     DBGrid.Enabled:=true;
     OKGuideButton.Enabled:=true;
     OKDocumentButton.Enabled:=true;
     OKCompleteDocumentButton.Enabled:=true;
     //
     toZConnection.Connected:=false;
     //fromADOConnection.Connected:=false;
     //
     if fStop then ShowMessage('����������� �� ���������.') else ShowMessage('����������� ���������.');
     //
     fStop:=true;
end;
//----------------------------------------------------------------------------------------------------------------------------------------------------
procedure TMainForm.OKDocumentButtonClick(Sender: TObject);
begin
     if MessageDlg('������������� ��������� ��������� ���������?',mtConfirmation,[mbYes,mbNo],0)<>mrYes then exit;
     fStop:=false;
     DBGrid.Enabled:=false;
     OKGuideButton.Enabled:=false;
     OKDocumentButton.Enabled:=false;
     OKCompleteDocumentButton.Enabled:=false;
     //
     Gauge.Visible:=true;
     //
     if cbSetNull_Id_Postgres.Checked then begin if MessageDlg('������������� set ���������.Sybase.����.Id_Postgres = null?',mtConfirmation,[mbYes,mbNo],0)<>mrYes then exit;
                                                 pSetNullDocument_Id_Postgres;
                                           end;
     //
     if not fStop then pLoadGuide_Juridical(true);
     if not fStop then pLoadGuide_Partner(true);
     //
     if not fStop then pLoadDocument_Income;
     if not fStop then pLoadDocumentItem_Income;

     if not fStop then pLoadDocument_IncomePacker;
     if not fStop then pLoadDocumentItem_IncomePacker;
     //
     Gauge.Visible:=false;
     DBGrid.Enabled:=true;
     OKGuideButton.Enabled:=true;
     OKDocumentButton.Enabled:=true;
     OKCompleteDocumentButton.Enabled:=true;
     //
     toZConnection.Connected:=false;
     //fromADOConnection.Connected:=false;
     //
     if fStop then ShowMessage('��������� �� ���������.') else ShowMessage('��������� ���������.');
     //
     fStop:=true;
end;
//----------------------------------------------------------------------------------------------------------------------------------------------------
procedure TMainForm.OKCompleteDocumentButtonClick(Sender: TObject);
begin
     if (cbComplete.Checked)and(cbUnComplete.Checked)
     then if MessageDlg('������������� �����������/�������� ��������� ���������?',mtConfirmation,[mbYes,mbNo],0)<>mrYes then exit else
     else
         if cbUnComplete.Checked
         then if MessageDlg('������������� ������ ����������� ��������� ���������?',mtConfirmation,[mbYes,mbNo],0)<>mrYes then exit else
         else
             if cbComplete.Checked then if MessageDlg('������������� ������ �������� ��������� ���������?',mtConfirmation,[mbYes,mbNo],0)<>mrYes then exit else
             else begin ShowMessage('������.�� ������� ����������� ��� ��������.'); end;
     //
     fStop:=false;
     DBGrid.Enabled:=false;
     OKGuideButton.Enabled:=false;
     OKDocumentButton.Enabled:=false;
     OKCompleteDocumentButton.Enabled:=false;
     //
     Gauge.Visible:=true;
     //
     //
     if not fStop then pCompleteDocument_Income;
     //
     Gauge.Visible:=false;
     DBGrid.Enabled:=true;
     OKGuideButton.Enabled:=true;
     OKDocumentButton.Enabled:=true;
     OKCompleteDocumentButton.Enabled:=true;
     //
     toZConnection.Connected:=false;
     //fromADOConnection.Connected:=false;
     //
     if fStop then ShowMessage('��������� �� ������������ �(���) �� ���������.') else ShowMessage('��������� ������������ �(���) ���������.');
     //
     fStop:=true;
end;
//----------------------------------------------------------------------------------------------------------------------------------------------------
//----------------------------------------------------------------------------------------------------------------------------------------------------
//----------------------------------------------------------------------------------------------------------------------------------------------------
procedure TMainForm.pSetNullGuide_Id_Postgres;
begin
     fExecSqFromQuery('update dba.Goods set Id_Postgres = null');
     fExecSqFromQuery('update dba.GoodsProperty set Id_Postgres = null');
     fExecSqFromQuery('update dba.Measure set Id_Postgres = null');
     fExecSqFromQuery('update dba.KindPackage set Id_Postgres = null');
     fExecSqFromQuery('update dba.MoneyKind set Id_Postgres = null');
     fExecSqFromQuery('update dba.ContractKind set Id_Postgres = null');
     fExecSqFromQuery('update dba.Unit set Id_Postgres_Business = null, PersonalId_Postgres=null, Id1_Postgres = null, Id2_Postgres = null, Id3_Postgres = null');
     fExecSqFromQuery('update dba.PriceList_byHistory set Id_Postgres = null');
     fExecSqFromQuery('update dba.GoodsProperty_Postgres set Id_Postgres = null');
     fExecSqFromQuery('update dba.GoodsProperty_Detail set Id1_Postgres = null, Id2_Postgres = null, Id3_Postgres = null, Id4_Postgres = null, Id5_Postgres = null, Id6_Postgres = null, Id7_Postgres = null'
                                                       +', Id8_Postgres = null, Id9_Postgres = null, Id10_Postgres = null, Id11_Postgres = null, Id12_Postgres = null, Id13_Postgres = null, Id14_Postgres = null');
     fExecSqFromQuery('update dba._pgInfoMoney set Id1_Postgres = null, Id2_Postgres = null, Id3_Postgres = null');
     fExecSqFromQuery('update dba._pgAccount set Id1_Postgres = null, Id2_Postgres = null, Id3_Postgres = null');
     fExecSqFromQuery('update dba._pgProfitLoss set Id1_Postgres = null, Id2_Postgres = null, Id3_Postgres = null');
     fExecSqFromQuery('update dba._pgUnit set Id_Postgres = null, Id_Postgres_Branch = null');
end;
//----------------------------------------------------------------------------------------------------------------------------------------------------
procedure TMainForm.pSetNullDocument_Id_Postgres;
begin
     fExecSqFromQuery('update dba.Bill set Id_Postgres = null where Id_Postgres is not null'); //
     fExecSqFromQuery('update dba.BillItems set Id_Postgres = null where Id_Postgres is not null');
     fExecSqFromQuery('update dba.BillItemsReceipt set Id_Postgres = null where Id_Postgres is not null');
end;
//----------------------------------------------------------------------------------------------------------------------------------------------------
procedure TMainForm.pLoadGuide_Measure;
begin
     if (not cbMeasure.Checked)or(not cbMeasure.Enabled) then exit;
     //
     myEnabledCB(cbMeasure);
     //
     with fromQuery,Sql do begin
        Close;
        Clear;
        Add('select Measure.Id as ObjectId');
        Add('     , 0 as ObjectCode');
        Add('     , Measure.MeasureName as ObjectName');
        Add('     , Measure.Id_Postgres');
        Add('from dba.Measure');
        Add('order by ObjectId');
        Open;
        //
        fStop:=cbOnlyOpen.Checked;
        if cbOnlyOpen.Checked then exit;
        //
        Gauge.Progress:=0;
        Gauge.MaxValue:=RecordCount;
        //
        toStoredProc.StoredProcName:='gpinsertupdate_object_measure';
        toStoredProc.OutputType := otResult;
        toStoredProc.Params.Clear;
        toStoredProc.Params.AddParam ('ioId',ftInteger,ptInputOutput, 0);
        toStoredProc.Params.AddParam ('inCode',ftInteger,ptInputOutput, 0);
        toStoredProc.Params.AddParam ('inName',ftString,ptInput, '');
        //
        while not EOF do
        begin
             //!!!
             if fStop then begin exit;end;
             //
             toStoredProc.Params.ParamByName('ioId').Value:=FieldByName('Id_Postgres').AsString;
             toStoredProc.Params.ParamByName('inCode').Value:=FieldByName('ObjectCode').AsString;
             toStoredProc.Params.ParamByName('inName').Value:=FieldByName('ObjectName').AsString;
             // toStoredProc.Params.ParamByName('inSession').Value:=fGetSession;
             if not myExecToStoredProc then;
             //
             if (1=0)or(FieldByName('Id_Postgres').AsInteger=0)
             then fExecSqFromQuery('update dba.Measure set Id_Postgres='+IntToStr(toStoredProc.Params.ParamByName('ioId').Value)+' where Id = '+FieldByName('ObjectId').AsString);
             //
             Next;
             Application.ProcessMessages;
             Gauge.Progress:=Gauge.Progress+1;
             Application.ProcessMessages;
        end;
     end;
     //
     myDisabledCB(cbMeasure);
end;
//----------------------------------------------------------------------------------------------------------------------------------------------------
procedure TMainForm.pLoadGuide_GoodsGroup;
begin
     if (not cbGoodsGroup.Checked)or(not cbGoodsGroup.Enabled) then exit;
     //
     myEnabledCB(cbGoodsGroup);
     //
     with fromQuery,Sql do begin
        Close;
        Clear;
        Add('select Goods.Id as ObjectId');
        Add('     , 0 as ObjectCode');
        Add('     , Goods.GoodsName as ObjectName');
        Add('     , Goods.Id_Postgres');
        Add('     , Goods_parent.Id_Postgres as ParentId_Postgres');
        Add('from dba.Goods');
        Add('     left outer join dba.Goods as Goods_parent on Goods_parent.Id = Goods.ParentId');
        Add('where Goods.HasChildren <> zc_hsLeaf()');
        Add('order by ObjectId');
        Open;
        //
        fStop:=cbOnlyOpen.Checked;
        if cbOnlyOpen.Checked then exit;
        //
        Gauge.Progress:=0;
        Gauge.MaxValue:=RecordCount;
        //
        toStoredProc.StoredProcName:='gpinsertupdate_object_goodsgroup';
        toStoredProc.OutputType := otResult;
        toStoredProc.Params.Clear;
        toStoredProc.Params.AddParam ('ioId',ftInteger,ptInputOutput, 0);
        toStoredProc.Params.AddParam ('inCode',ftInteger,ptInput, 0);
        toStoredProc.Params.AddParam ('inName',ftString,ptInput, '');
        toStoredProc.Params.AddParam ('inParentId',ftInteger,ptInput, 0);
        //
        while not EOF do
        begin
             //!!!
             if fStop then begin {EnableControls;}exit;end;
             //
             toStoredProc.Params.ParamByName('ioId').Value:=FieldByName('Id_Postgres').AsInteger;
             toStoredProc.Params.ParamByName('inCode').Value:=FieldByName('ObjectCode').AsInteger;
             toStoredProc.Params.ParamByName('inName').Value:=FieldByName('ObjectName').AsString;
             toStoredProc.Params.ParamByName('inParentId').Value:=FieldByName('ParentId_Postgres').AsInteger;
             //toStoredProc.Params.ParamByName('inSession').Value:=fGetSession;
             if not myExecToStoredProc then ;//exit;
             //
             if (1=0)or(FieldByName('Id_Postgres').AsInteger=0)
             then fExecSqFromQuery('update dba.Goods set Id_Postgres='+IntToStr(toStoredProc.Params.ParamByName('ioId').Value)+' where Id = '+FieldByName('ObjectId').AsString);
             //
             Next;
             Application.ProcessMessages;
             Gauge.Progress:=Gauge.Progress+1;
             Application.ProcessMessages;
        end;
     end;
     //
     myDisabledCB(cbGoodsGroup);
end;
//----------------------------------------------------------------------------------------------------------------------------------------------------
procedure TMainForm.pLoadGuide_Goods;
begin
//update Object set ObjectCode = null where DescId = zc_Object_Goods()
//select * from Object where DescId = zc_Object_Goods()
     if (not cbGoods.Checked)or(not cbGoods.Enabled) then exit;
     //
     myEnabledCB(cbGoods);
     //
     with fromQuery,Sql do begin
        Close;
        Clear;
        Add('select GoodsProperty.Id as ObjectId');
        Add('     , GoodsProperty.GoodsCode as ObjectCode');
        Add('     , GoodsProperty.GoodsName as ObjectName');
        Add('     , max (case when Goods.ParentId=686 then GoodsProperty.Tare_Weight else GoodsProperty_Detail.Ves_onMeasure end) as Ves_onMeasure');
        Add('     , GoodsProperty.Id_Postgres as Id_Postgres');
        Add('     , Measure.Id_Postgres as MeasureId_Postgres');
        Add('     , Goods_parent.Id_Postgres as ParentId_Postgres');
        Add('     , _pgInfoMoney.Id3_Postgres as InfoMoneyId_Postgres');
        Add('     , 0 AS TradeMarkId_PG');
        Add('from dba.GoodsProperty');
        Add('     left outer join dba.Goods on Goods.Id = GoodsProperty.GoodsId');
        Add('     left outer join dba.Goods as Goods_parent on Goods_parent.Id = Goods.ParentId');
        Add('     left outer join dba.Measure on Measure.Id = GoodsProperty.MeasureId');
        Add('     left outer join dba.GoodsProperty_Detail on GoodsProperty_Detail.GoodsPropertyId = GoodsProperty.Id');
        Add('     left outer join dba._pgInfoMoney on _pgInfoMoney.ObjectCode = case when fCheckGoodsParentID(1491,Goods.ParentId) =zc_rvYes() then 20701'); // ������������  - 20701	������������� ������	������ ������
        Add('                                                                        when fCheckGoodsParentID(5,   Goods.ParentId) =zc_rvYes()then 30101'); // ��            - 30101	������	���������	������� ���������
        Add('                                                                        when fCheckGoodsParentID(5306,Goods.ParentId) =zc_rvYes() then 30101'); // �������       - 30101	������	���������	������� ���������
        Add('                                                                        when fCheckGoodsParentID(3482,Goods.ParentId) =zc_rvYes() then 30101'); // ������������       - 30101	������	���������	������� ���������
        Add('                                                                        when fCheckGoodsParentID(5874,Goods.ParentId) =zc_rvYes() then 30102'); // �������       - 30102	������	���������	�������
        Add('                                                                        when fCheckGoodsParentID(2387,Goods.ParentId) =zc_rvYes() then 30103'); // ����          - 30103	������  ���������	����
        Add('                                                                        when fCheckGoodsParentID(2849,Goods.ParentId) =zc_rvYes() then 30301'); // �-����������� - 30301	������  �����������	�����������

        Add('                                                                        when fCheckGoodsParentID(6682,Goods.ParentId) =zc_rvYes() then 20204'); // ���������� - 20204	�������������  ������ ��� ���� ������
        Add('                                                                        when fCheckGoodsParentID(6677,Goods.ParentId) =zc_rvYes() then 20601'); // ������ - 20601	�������������  ������ ���������	������ ���������
        Add('                                                                        when fCheckGoodsParentID(2954,Goods.ParentId) =zc_rvYes() then 20203'); // ������ - 20203	�������������  ������ ��� ������ ��������, �������
        Add('                                                                        when fCheckGoodsParentID(6678,Goods.ParentId) =zc_rvYes() then 20601'); // ������ � ����� - 20601	�������������  ������ ���������	������ ���������
        Add('                                                                        when fCheckGoodsParentID(2949,Goods.ParentId) =zc_rvYes() then 20205'); // ������ - 20205	�������������  ������ ��� ������ ���
        Add('                                                                        when fCheckGoodsParentID(2641,Goods.ParentId) =zc_rvYes() then 20202'); // ���������� - 20202	�������������  ������ ��� ����������
        Add('                                                                        when fCheckGoodsParentID(6681,Goods.ParentId) =zc_rvYes() then 20601'); // �������, ������, ��. ���� - 20601	�������������  ������ ���������	������ ���������
        Add('                                                                        when fCheckGoodsParentID(6676,Goods.ParentId) =zc_rvYes() then 20601'); // ���� - 20601	�������������  ������ ���������	������ ���������
        Add('                                                                        when fCheckGoodsParentID(2787,Goods.ParentId) =zc_rvYes() then 20205'); // ��-����� - 20205	�������������  ������ ��� ������ ���

        Add('                                                                        when fCheckGoodsParentID(2642,Goods.ParentId) =zc_rvYes() then 20101'); // ��-�������� ������-� - 20101	�������������  �������� � �������	�������� � �������

        Add('                                                                        when fCheckGoodsParentID(2647,Goods.ParentId) =zc_rvYes() then 10201'); // ��-������� - 10201		�������� ����� ������ �����	������
        Add('                                                                        when Goods.Id in (6041, 7013) then 10201'); // ��-������� - 10201		�������� ����� ������ �����	������
        Add('                                                                        when Goods.ParentId in (5857) then 10203'); // ��-������� - 10203		�������� ����� ������ �����	��������

        Add('                                                                        when fCheckGoodsParentID(4213,Goods.ParentId) =zc_rvYes() then 20601'); // ��������� - 20601	�������������  ������ ���������	������ ���������
        Add('                                                                        when fCheckGoodsParentID(3521,Goods.ParentId) =zc_rvYes() then 10201'); // ��� ����������-����� ������ - 10201		�������� ����� ������ �����	������
        Add('                                                                        when fCheckGoodsParentID(3221,Goods.ParentId) =zc_rvYes() then 10201'); // ������� - 10201		�������� ����� ������ �����	������
        Add('                                                                        when fCheckGoodsParentID(2643,Goods.ParentId) =zc_rvYes() then 10201'); // ������ - 10201		�������� ����� ������ �����	������
        Add('                                                                        when fCheckGoodsParentID(2644,Goods.ParentId) =zc_rvYes() then 10201'); // ������ �������. - 10201		�������� ����� ������ �����	������
        Add('                                                                        when fCheckGoodsParentID(2645,Goods.ParentId) =zc_rvYes() then 10202'); // �������� - 10202		�������� ����� ������ �����	��������
        Add('                                                                        when fCheckGoodsParentID(2631,Goods.ParentId) =zc_rvYes() then 10203'); // !!!��-�����!!! - 10203		�������� ����� ������ �����	��������

        Add('                                                                        when fCheckGoodsParentID(2648,Goods.ParentId) =zc_rvYes() then 10204'); // ��-����� ��� - 10204		�������� ����� ������ ����� ������ �����
        Add('                                                                        when Goods.Id in (2792, 7001, 6710) then 10103'); // !!!��- ���. � ��. �\� + ���!!! - 10103		�������� ����� ������ ����� ��������
        Add('                                                                        when fCheckGoodsParentID(6435,Goods.ParentId) =zc_rvYes() then 10102'); // !!!��- ���. � ��. �\� + ���!!! - 10102		�������� ����� ������ ����� �������
        Add('                                                                        when fCheckGoodsParentID(3859,Goods.ParentId) =zc_rvYes() then 10105'); // ��-�������� - 10105		�������� ����� ������ ����� ������ ������ �����
        Add('                                                                        when fCheckGoodsParentID(5676,Goods.ParentId) =zc_rvYes() then 10105'); // ��-����� � ��. - 10105		�������� ����� ������ ����� ������ ������ �����
        Add('                                                                        when fCheckGoodsParentID(5503,Goods.ParentId) =zc_rvYes() then 10105'); // ��-����� ������ - 10105		�������� ����� ������ ����� ������ ������ �����

        Add('                                                                        when fCheckGoodsParentID(5489,Goods.ParentId) =zc_rvYes() then 10103'); // ��-���.  ���-��* - 10103		�������� ����� ������ ����� ��������
        Add('                                                                        when fCheckGoodsParentID(5491,Goods.ParentId) =zc_rvYes() then 10103'); // ��-���. ���+���.* - 10103		�������� ����� ������ ����� ��������
        Add('                                                                        when fCheckGoodsParentID(2633,Goods.ParentId) =zc_rvYes() then 10103'); // ��-�������� ��* - 10103		�������� ����� ������ ����� ��������
        Add('                                                                        when fCheckGoodsParentID(2662,Goods.ParentId) =zc_rvYes() then 10103'); // ��-����� ���� ���.* - 10103		�������� ����� ������ ����� ��������

        Add('                                                                        when fCheckGoodsParentID(2635,Goods.ParentId) =zc_rvYes() then 10104'); // ��-������* - 10104		�������� ����� ������ ����� ������

        Add('                                                                        when fCheckGoodsParentID(2632,Goods.ParentId) =zc_rvYes() then 10102'); // !!!��!!! - 10102		�������� ����� ������ ����� �������
        Add('                                                                        when fCheckGoodsParentID(2691,Goods.ParentId) =zc_rvYes() then 10103'); // ��-�������� ������� ��� - 10103		�������� ����� ������ ����� ��������
        Add('                                                                        when Goods.Id in (2800) then 10104'); // ����-�����* - 10104		�������� ����� ������ ����� ������
        Add('                                                                        when Goods.Id in (3039) then 10103'); // ����-�����* - 10103		�������� ����� ������ ����� ��������
        Add('                                                                        when fCheckGoodsParentID(3447,Goods.ParentId) =zc_rvYes() then 10102'); // !!!��-�� �������!!! - 10102		�������� ����� ������ ����� �������

        Add('                                                                        when fCheckGoodsParentID(3217,Goods.ParentId) =zc_rvYes() then 21301'); // ��-�������� - 10102		������������� ������������� ������������ ������������� ������������
        Add('                                                                        when fCheckGoodsParentID(1670,Goods.ParentId) =zc_rvYes() then 10201'); // ��� - 10201		�������� ����� ������ �����	������ �����
        Add('                                                                        when fCheckGoodsParentID(686,Goods.ParentId) =zc_rvYes() then 20501'); // ���� - 20501		������������� ��������� ����	��������� ����

        Add('                                                                   end');
        Add('where Goods.HasChildren = zc_hsLeaf()');
// Add(' and GoodsProperty.GoodsCode = 4147');
        Add('group by ObjectId');
        Add('       , ObjectName');
        Add('       , ObjectCode');
        Add('       , Id_Postgres');
        Add('       , MeasureId_Postgres');
        Add('       , ParentId_Postgres');
        Add('       , InfoMoneyId_Postgres');
        Add('order by ObjectId');
        Open;
        //
        fStop:=cbOnlyOpen.Checked;
        if cbOnlyOpen.Checked then exit;
        //
        Gauge.Progress:=0;
        Gauge.MaxValue:=RecordCount;
        //
        toStoredProc.StoredProcName:='gpinsertupdate_object_goods';
        toStoredProc.OutputType := otResult;
        toStoredProc.Params.Clear;
        toStoredProc.Params.AddParam ('ioId',ftInteger,ptInputOutput, 0);
        toStoredProc.Params.AddParam ('inCode',ftInteger,ptInput, 0);
        toStoredProc.Params.AddParam ('inName',ftString,ptInput, '');
        toStoredProc.Params.AddParam ('inGoodsGroupId',ftInteger,ptInput, 0);
        toStoredProc.Params.AddParam ('inMeasureId',ftInteger,ptInput, 0);
        toStoredProc.Params.AddParam ('inTradeMarkId',ftInteger,ptInput, 0);
        toStoredProc.Params.AddParam ('inInfoMoneyId',ftInteger,ptInput, 0);
        toStoredProc.Params.AddParam ('inWeight',ftFloat,ptInput, 0);
        //
        while not EOF do
        begin
             //!!!
             if fStop then begin exit;end;
             //
             toStoredProc.Params.ParamByName('ioId').Value:=FieldByName('Id_Postgres').AsInteger;
             toStoredProc.Params.ParamByName('inCode').Value:=FieldByName('ObjectCode').AsInteger;
             toStoredProc.Params.ParamByName('inName').Value:=FieldByName('ObjectName').AsString;
             toStoredProc.Params.ParamByName('inWeight').Value:=FieldByName('Ves_onMeasure').AsFloat;
             toStoredProc.Params.ParamByName('inGoodsGroupId').Value:=FieldByName('ParentId_Postgres').AsInteger;
             toStoredProc.Params.ParamByName('inMeasureId').Value:=FieldByName('MeasureId_Postgres').AsInteger;
             toStoredProc.Params.ParamByName('inInfoMoneyId').Value:=FieldByName('InfoMoneyId_Postgres').AsInteger;
             toStoredProc.Params.ParamByName('inTradeMarkId').Value:=FieldByName('TradeMarkId_PG').AsInteger;

             if not myExecToStoredProc then ;//exit;
             //
             if (1=0)or(FieldByName('Id_Postgres').AsInteger=0)
             then fExecSqFromQuery('update dba.GoodsProperty set Id_Postgres='+IntToStr(toStoredProc.Params.ParamByName('ioId').Value)+' where Id = '+FieldByName('ObjectId').AsString);
             //
             Next;
             Application.ProcessMessages;
             Gauge.Progress:=Gauge.Progress+1;
             Application.ProcessMessages;
        end;
     end;
     //
     myDisabledCB(cbGoods);
end;
//----------------------------------------------------------------------------------------------------------------------------------------------------
procedure TMainForm.pLoadGuide_Goods_toZConnection;
begin
     if (not cbGoods.Checked)or(not cbGoods.Enabled) then exit;
     //
     myEnabledCB(cbGoods);
     //
     with fromQuery,Sql do begin
        Close;
        Clear;
        Add('select GoodsProperty.Id as ObjectId');
        Add('     , GoodsProperty.GoodsCode as ObjectCode');
        Add('     , GoodsProperty.GoodsName as ObjectName');
        Add('     , max (case when Goods.ParentId=686 then GoodsProperty.Tare_Weight else GoodsProperty_Detail.Ves_onMeasure end) as Ves_onMeasure');
        Add('     , GoodsProperty.Id_Postgres as Id_Postgres');
        Add('     , Measure.Id_Postgres as MeasureId_Postgres');
        Add('     , Goods_parent.Id_Postgres as ParentId_Postgres');
        Add('     , _pgInfoMoney.Id3_Postgres as InfoMoneyId_Postgres');
        Add('from dba.GoodsProperty');
        Add('     left outer join dba.Goods on Goods.Id = GoodsProperty.GoodsId');
        Add('     left outer join dba.Goods as Goods_parent on Goods_parent.Id = Goods.ParentId');
        Add('     left outer join dba.Measure on Measure.Id = GoodsProperty.MeasureId');
        Add('     left outer join dba.GoodsProperty_Detail on GoodsProperty_Detail.GoodsPropertyId = GoodsProperty.Id');
        Add('     left outer join dba._pgInfoMoney on _pgInfoMoney.ObjectCode = 1');
        Add('where Goods.HasChildren = zc_hsLeaf() ');
        Add('group by ObjectId');
        Add('       , ObjectName');
        Add('       , ObjectCode');
        Add('       , Id_Postgres');
        Add('       , MeasureId_Postgres');
        Add('       , ParentId_Postgres');
        Add('       , InfoMoneyId_Postgres');
        Add('order by ObjectId');
        Open;
        //
        fStop:=cbOnlyOpen.Checked;
        if cbOnlyOpen.Checked then exit;
        //
        Gauge.Progress:=0;
        Gauge.MaxValue:=RecordCount;
        //
        toStoredProc_ZConnection.StoredProcName:='gpinsertupdate_object_goods';
        //
        while not EOF do
        begin
             //!!!
             if fStop then begin exit;end;
             //
             toStoredProc_ZConnection.Params.ParamByName('ioId').Value:=FieldByName('Id_Postgres').AsInteger;
             toStoredProc_ZConnection.Params.ParamByName('inCode').Value:=FieldByName('ObjectCode').AsInteger;
             toStoredProc_ZConnection.Params.ParamByName('inName').Value:=FieldByName('ObjectName').AsString;
             toStoredProc_ZConnection.Params.ParamByName('inGoodsGroupId').Value:=FieldByName('ParentId_Postgres').AsInteger;
             toStoredProc_ZConnection.Params.ParamByName('inMeasureId').Value:=FieldByName('MeasureId_Postgres').AsInteger;
             toStoredProc_ZConnection.Params.ParamByName('inWeight').Value:=FieldByName('MeasureId_Postgres').AsFloat;
             toStoredProc_ZConnection.Params.ParamByName('inInfoMoneyId').Value:=FieldByName('InfoMoneyId_Postgres').AsInteger;
             toStoredProc_ZConnection.Params.ParamByName('inSession').Value:=fGetSession;
             if not myExecToStoredProc_ZConnection then ;//exit;
             //
             if (1=0)or(FieldByName('Id_Postgres').AsInteger=0)
             then fExecSqFromQuery('update dba.GoodsProperty set Id_Postgres='+IntToStr(toStoredProc_ZConnection.Params.ParamByName('ioId').Value)+' where Id = '+FieldByName('ObjectId').AsString);
             //
             Next;
             Application.ProcessMessages;
             Gauge.Progress:=Gauge.Progress+1;
             Application.ProcessMessages;
        end;
     end;
     //
     myDisabledCB(cbGoods);
end;
//----------------------------------------------------------------------------------------------------------------------------------------------------
procedure TMainForm.pLoadGuide_GoodsKind;
begin
     if (not cbGoodsKind.Checked)or(not cbGoodsKind.Enabled) then exit;
     //
     myEnabledCB(cbGoodsKind);
     //
     with fromQuery,Sql do begin
        Close;
        Clear;
        Add('select KindPackage.Id as ObjectId');
        Add('     , KindPackage.KindPackageCode as ObjectCode');
        Add('     , KindPackage.KindPackageName as ObjectName');
        Add('     , KindPackage.Id_Postgres as Id_Postgres');
        Add('from dba.KindPackage');
        Add('where KindPackage.HasChildren = zc_hsLeaf()');
        Add('  and (KindPackage.ParentId not in (23,30)'
           +'     or KindPackage.Id in (24)'
           +'      )');
        Add('order by ObjectId');
        Open;
        //
        fStop:=cbOnlyOpen.Checked;
        if cbOnlyOpen.Checked then exit;
        //
        Gauge.Progress:=0;
        Gauge.MaxValue:=RecordCount;
        //
        toStoredProc.StoredProcName:='gpinsertupdate_object_goodskind';
        toStoredProc.OutputType := otResult;
        toStoredProc.Params.Clear;
        toStoredProc.Params.AddParam ('ioId',ftInteger,ptInputOutput, 0);
        toStoredProc.Params.AddParam ('inCode',ftInteger,ptInput, 0);
        toStoredProc.Params.AddParam ('inName',ftString,ptInput, '');
        //
        while not EOF do
        begin
             //!!!
             if fStop then begin exit;end;
             //
             toStoredProc.Params.ParamByName('ioId').Value:=FieldByName('Id_Postgres').AsInteger;
             toStoredProc.Params.ParamByName('inCode').Value:=FieldByName('ObjectCode').AsInteger;
             toStoredProc.Params.ParamByName('inName').Value:=FieldByName('ObjectName').AsString;
             //toStoredProc.Params.ParamByName('inSession').Value:=fGetSession;
             if not myExecToStoredProc then ;//exit;
             //
             if (1=0)or(FieldByName('Id_Postgres').AsInteger=0)
             then fExecSqFromQuery('update dba.KindPackage set Id_Postgres='+IntToStr(toStoredProc.Params.ParamByName('ioId').Value)+' where Id = '+FieldByName('ObjectId').AsString);
             //
             Next;
             Application.ProcessMessages;
             Gauge.Progress:=Gauge.Progress+1;
             Application.ProcessMessages;
        end;
     end;
     //
     myDisabledCB(cbGoodsKind);
end;
//----------------------------------------------------------------------------------------------------------------------------------------------------
procedure TMainForm.pLoadGuide_PaidKind;
begin
     if (not cbPaidKind.Checked)or(not cbPaidKind.Enabled) then exit;
     //
     myEnabledCB(cbPaidKind);
     //
     with fromQuery,Sql do begin
        Close;
        Clear;
        Add('select MoneyKind.Id as ObjectId');
        Add('     , 0 as ObjectCode');
        Add('     , MoneyKind.MoneyKindName as ObjectName');
        Add('     , case when ObjectId =zc_mkBN() then 6 when ObjectId =zc_mkNal() then 7 else MoneyKind.Id_Postgres end as Id_Postgres');
        Add('from dba.MoneyKind');
        Add('where MoneyKind.Id<=2');
        Add('order by ObjectId');
        Open;
        //
        fStop:=cbOnlyOpen.Checked;
        if cbOnlyOpen.Checked then exit;
        //
        Gauge.Progress:=0;
        Gauge.MaxValue:=RecordCount;
        //
        toStoredProc.StoredProcName:='gpinsertupdate_object_paidkind';
        toStoredProc.OutputType := otResult;
        toStoredProc.Params.Clear;
        toStoredProc.Params.AddParam ('ioId',ftInteger,ptInputOutput, 0);
        toStoredProc.Params.AddParam ('inCode',ftInteger,ptInput, 0);
        toStoredProc.Params.AddParam ('inName',ftString,ptInput, '');
        //
        while not EOF do
        begin
             //!!!
             if fStop then begin exit;end;
             //
             toStoredProc.Params.ParamByName('ioId').Value:=FieldByName('Id_Postgres').AsInteger;
             toStoredProc.Params.ParamByName('inCode').Value:=FieldByName('ObjectCode').AsInteger;
             toStoredProc.Params.ParamByName('inName').Value:=FieldByName('ObjectName').AsString;
             //toStoredProc.Params.ParamByName('inSession').Value:=fGetSession;
             if not myExecToStoredProc then ;//exit;
             //
             if (1=1)or(FieldByName('Id_Postgres').AsInteger=0)
             then fExecSqFromQuery('update dba.MoneyKind set Id_Postgres='+IntToStr(toStoredProc.Params.ParamByName('ioId').Value)+' where Id = '+FieldByName('ObjectId').AsString);
             //
             Next;
             Application.ProcessMessages;
             Gauge.Progress:=Gauge.Progress+1;
             Application.ProcessMessages;
        end;
     end;
     //
     myDisabledCB(cbPaidKind);
end;
//----------------------------------------------------------------------------------------------------------------------------------------------------
procedure TMainForm.pLoadGuide_ContractKind;
begin
     if (not cbContractKind.Checked)or(not cbContractKind.Enabled) then exit;
     //
     myEnabledCB(cbContractKind);
     //
     with fromQuery,Sql do begin
        Close;
        Clear;
        Add('select ContractKind.Id as ObjectId');
        Add('     , 0 as ObjectCode');
        Add('     , ContractKind.ContractKindName as ObjectName');
        Add('     , ContractKind.Id_Postgres as Id_Postgres');
        Add('from dba.ContractKind');
        Add('order by ObjectId');
        Open;
        //
        fStop:=cbOnlyOpen.Checked;
        if cbOnlyOpen.Checked then exit;
        //
        Gauge.Progress:=0;
        Gauge.MaxValue:=RecordCount;
        //
        toStoredProc.StoredProcName:='gpinsertupdate_object_contractkind';
        toStoredProc.OutputType := otResult;
        toStoredProc.Params.Clear;
        toStoredProc.Params.AddParam ('ioId',ftInteger,ptInputOutput, 0);
        toStoredProc.Params.AddParam ('inCode',ftInteger,ptInput, 0);
        toStoredProc.Params.AddParam ('inName',ftString,ptInput, '');
        //
        while not EOF do
        begin
             //!!!
             if fStop then begin exit;end;
             //
             toStoredProc.Params.ParamByName('ioId').Value:=FieldByName('Id_Postgres').AsInteger;
             toStoredProc.Params.ParamByName('inCode').Value:=FieldByName('ObjectCode').AsInteger;
             toStoredProc.Params.ParamByName('inName').Value:=FieldByName('ObjectName').AsString;
             //toStoredProc.Params.ParamByName('inSession').Value:=fGetSession;
             if not myExecToStoredProc then ;//exit;
             //
             if (1=0)or(FieldByName('Id_Postgres').AsInteger=0)
             then fExecSqFromQuery('update dba.ContractKind set Id_Postgres='+IntToStr(toStoredProc.Params.ParamByName('ioId').Value)+' where Id = '+FieldByName('ObjectId').AsString);
             //
             Next;
             Application.ProcessMessages;
             Gauge.Progress:=Gauge.Progress+1;
             Application.ProcessMessages;
        end;
     end;
     //
     myDisabledCB(cbContractKind);
end;
//----------------------------------------------------------------------------------------------------------------------------------------------------
procedure TMainForm.pLoadGuide_JuridicalGroup;
begin
     if (not cbJuridicalGroup.Checked)or(not cbJuridicalGroup.Enabled) then exit;
     //
     myEnabledCB(cbJuridicalGroup);
     //
     with fromQuery,Sql do begin
        Close;
        Clear;
        Add('select Unit.Id as ObjectId');
        Add('     , 0 as ObjectCode');
        Add('     , Unit.UnitName as ObjectName');
        Add('     , Unit.Id1_Postgres as Id_Postgres');
        Add('     , Unit_parent.Id1_Postgres as ParentId_Postgres');
        Add('from dba.Unit');
        Add('     left outer join dba.Unit as Unit_parent on Unit_parent.Id = Unit.ParentId');
        Add('where Unit.HasChildren <> zc_hsLeaf() and (Unit.Id in (151'  // ���
                                                                +', 5354' // FLOATER
                                                                +', 4219' // �������� ����� �2
                                                                +', 28'   // ����� �� �������
                                                                +', 3504' // ����������-���
                                                                +', 152'  // ����������-���
                                                                +', 4418' // ����������-���. ��������
                                                                +' )'
           +'                                        or Unit.ParentId in(3504' // ����������-���
                                                                     +', 152'  // ����������-���
                                                                     +' ))');
        Add('order by ObjectId');
        Open;
        //
        fStop:=cbOnlyOpen.Checked;
        if cbOnlyOpen.Checked then exit;
        //
        Gauge.Progress:=0;
        Gauge.MaxValue:=RecordCount;
        //
        toStoredProc.StoredProcName:='gpinsertupdate_object_juridicalgroup';
        toStoredProc.OutputType := otResult;
        toStoredProc.Params.Clear;
        toStoredProc.Params.AddParam ('ioId',ftInteger,ptInputOutput, 0);
        toStoredProc.Params.AddParam ('inCode',ftInteger,ptInput, 0);
        toStoredProc.Params.AddParam ('inName',ftString,ptInput, '');
        toStoredProc.Params.AddParam ('inParentId',ftInteger,ptInput, 0);
        //
        while not EOF do
        begin
             //!!!
             if fStop then begin exit;end;
             //
             toStoredProc.Params.ParamByName('ioId').Value:=FieldByName('Id_Postgres').AsInteger;
             toStoredProc.Params.ParamByName('inCode').Value:=FieldByName('ObjectCode').AsInteger;
             toStoredProc.Params.ParamByName('inName').Value:=FieldByName('ObjectName').AsString;
             toStoredProc.Params.ParamByName('inParentId').Value:=FieldByName('ParentId_Postgres').AsInteger;
             //toStoredProc.Params.ParamByName('inSession').Value:=fGetSession;
             if not myExecToStoredProc then ;//exit;
             //
             if (1=0)or(FieldByName('Id_Postgres').AsInteger=0)
             then fExecSqFromQuery('update dba.Unit set Id1_Postgres='+IntToStr(toStoredProc.Params.ParamByName('ioId').Value)+' where Id = '+FieldByName('ObjectId').AsString);
             //
             Next;
             Application.ProcessMessages;
             Gauge.Progress:=Gauge.Progress+1;
             Application.ProcessMessages;
        end;
     end;
     //
     myDisabledCB(cbJuridicalGroup);
end;
//----------------------------------------------------------------------------------------------------------------------------------------------------
procedure TMainForm.pLoadGuide_Juridical (isBill:Boolean);
begin
     if (not cbJuridical.Checked)or(not cbJuridical.Enabled) then exit;
     //
     myEnabledCB(cbJuridical);
     //
     with fromQuery,Sql do begin
        Close;
        Clear;
        if not isBill
        then begin
                  Add('select Unit.Id as ObjectId');
                  Add('     , Unit.UnitCode as ObjectCode');
                  Add('     , Unit.UnitName as ObjectName');
                  Add('     , Unit.Id2_Postgres as Id_Postgres');
                  Add('     , case when Unit_parent1.Id1_Postgres is not null then Unit_parent1.Id1_Postgres');
                  Add('            when Unit_parent2.Id1_Postgres is not null then Unit_parent2.Id1_Postgres');
                  Add('            when Unit_parent3.Id1_Postgres is not null then Unit_parent3.Id1_Postgres');
                  Add('            when Unit_parent4.Id1_Postgres is not null then Unit_parent4.Id1_Postgres');
                  Add('            when Unit_parent5.Id1_Postgres is not null then Unit_parent5.Id1_Postgres');
                  Add('            when Unit_parent6.Id1_Postgres is not null then Unit_parent6.Id1_Postgres');
                  Add('            when Unit_parent7.Id1_Postgres is not null then Unit_parent7.Id1_Postgres');
                  Add('            when Unit_parent8.Id1_Postgres is not null then Unit_parent8.Id1_Postgres');
                  Add('            when Unit_parent9.Id1_Postgres is not null then Unit_parent9.Id1_Postgres');
                  Add('            else Unit_parentAll.Id1_Postgres');
                  Add('       end as ParentId_Postgres');
                  Add('     , GoodsProperty_PG.Id_Postgres as GoodsPropertyId_PG');
                  Add('     , isnull(isnull(zf_ChangeTVarCharMediumToNull(ClientInformation.GLNMain),ClientInformation.GLN),'+FormatToVarCharServer_notNULL('')+') as GLNCode');
                  Add('     , zc_rvYes() as zc_rvYes');
                  Add('     , case when Unit.Id in (3, 165) then zc_rvYes() else zc_rvNo() end isCorporate'); // ���� + ����-1
                  Add('     , case when Unit.Id = 3 then _pgInfoMoney_Alan.Id3_Postgres when Unit.Id = 165 then _pgInfoMoney_Irna.Id3_Postgres else null end InfoMoneyId_PG'); // ���� + ����-1
                  Add('from dba.Unit as Unit_all');
                  Add('     join dba.Unit on Unit.Id = isnull(zf_ChangeIntToNull(Unit_all.DolgByUnitID), isnull(zf_ChangeIntToNull(Unit_all.InformationFromUnitID), Unit_all.Id))');
                  Add('     left outer join dba.GoodsProperty_Postgres as GoodsProperty_PG on GoodsProperty_PG.Id= case when fIsClient_ATB(Unit.Id)=zc_rvYes() then 1'
                                                                                                                 +'    when fIsClient_OK(Unit.Id)=zc_rvYes() then 2'
                                                                                                                 +'    when fIsClient_Metro(Unit.Id)=zc_rvYes() then 3'
                                                                                                                 +'    when fIsClient_Fozzi(Unit.Id)=zc_rvYes() or fIsClient_FozziM(Unit.Id)=zc_rvYes() then 5'
                                                                                                                 +'    when fIsClient_Kisheni(Unit.Id)=zc_rvYes() then 6'
                                                                                                                 +'    when fIsClient_Vivat(Unit.Id)=zc_rvYes() then 7'
                                                                                                                 +'    when fIsClient_Billa(Unit.Id)=zc_rvYes() then 8'
                                                                                                                 +'    when fIsClient_Amstor(Unit.Id)=zc_rvYes() then 9'
                                                                                                                 +'    when fIsClient_Omega(Unit.Id)=zc_rvYes() then 10'
                                                                                                                 +'    when fIsClient_Vostorg(Unit.Id)=zc_rvYes() then 11'
                                                                                                                 +'    when fIsClient_Ashan(Unit.Id)=zc_rvYes() then 12'
                                                                                                                 +'    when fIsClient_Real(Unit.Id)=zc_rvYes() then 13'
                                                                                                                 +'    when fIsClient_GD(Unit.Id)=zc_rvYes() then 14'
                                                                                                                 +'    else null'
                                                                                                                 +' end'
                      );
                  Add('     left outer join dba.Unit as Unit_parentAll on Unit_parentAll.Id = 151'); // ���
                  Add('     left outer join dba.Unit as Unit_parent1 on Unit_parent1.Id = Unit.ParentId');
                  Add('     left outer join dba.Unit as Unit_parent2 on Unit_parent2.Id = Unit_parent1.ParentId');
                  Add('     left outer join dba.Unit as Unit_parent3 on Unit_parent3.Id = Unit_parent2.ParentId');
                  Add('     left outer join dba.Unit as Unit_parent4 on Unit_parent4.Id = Unit_parent3.ParentId');
                  Add('     left outer join dba.Unit as Unit_parent5 on Unit_parent5.Id = Unit_parent4.ParentId');
                  Add('     left outer join dba.Unit as Unit_parent6 on Unit_parent6.Id = Unit_parent5.ParentId');
                  Add('     left outer join dba.Unit as Unit_parent7 on Unit_parent7.Id = Unit_parent6.ParentId');
                  Add('     left outer join dba.Unit as Unit_parent8 on Unit_parent8.Id = Unit_parent7.ParentId');
                  Add('     left outer join dba.Unit as Unit_parent9 on Unit_parent9.Id = Unit_parent8.ParentId');
                  Add('     left outer join dba.ClientInformation on ClientInformation.ClientId = isnull( zf_ChangeIntToNull( Unit_all.InformationFromUnitID), Unit_all.Id)');
                  Add('     left outer join dba._pgInfoMoney as _pgInfoMoney_Alan on _pgInfoMoney_Alan.ObjectCode = 20801'); // ������������� + ���� + ����
                  Add('     left outer join dba._pgInfoMoney as _pgInfoMoney_Irna on _pgInfoMoney_Irna.ObjectCode = 20901'); // ������������� + ���� + ����
                  Add('where (Unit.Id1_Postgres is null'
                     +'   and (isnull(Unit_all.findGoodsCard,zc_rvNo()) = zc_rvNo()'
                     +'     or fCheckUnitClientParentID(152,Unit.Id)=zc_rvYes())' // ����������-���
                     +'   and fCheckUnitClientParentID(3,Unit.Id)=zc_rvNo()'    // ����
                     +'   and fCheckUnitClientParentID(3714,Unit.Id)=zc_rvNo()' // ����-������
                     +'   and fCheckUnitClientParentID(3531,Unit.Id)=zc_rvNo()' // � ��*
                     +'   and fCheckUnitClientParentID(3349,Unit.Id)=zc_rvNo()' // ���
                     +'   and fCheckUnitClientParentID(600,Unit.Id)=zc_rvNo()'  // ��������
                     +'   and fCheckUnitClientParentID(149,Unit.Id)=zc_rvNo()'  // ������� ������������
                     +'   and Unit_all.Id not  in (4739' // 7910 ����������� ������������
                     +'                           ,5162' // 8534 �������� �. ��� ������������
                     +'                           ,4742' // 7912	��������� ������������
                     +'                           ,4920' // 8104	�������� �������.
                     +'                           ,4740' // 7911	������ ������������
                     +'                           ,5087' // 8459	���������� �������.
                     +'                           ,4695' // 7869	����� ������������
                     +'                           )'
                     +'      )'
                     +'  or Unit.Id=3'    // ����
                     );
                  Add('group by ObjectId');
                  Add('       , ObjectName');
                  Add('       , ObjectCode');
                  Add('       , Id_Postgres');
                  Add('       , ParentId_Postgres');
                  Add('       , GoodsPropertyId_PG');
                  Add('       , GLNCode');
                  Add('       , isCorporate');
                  Add('       , InfoMoneyId_PG');
                  Add('order by ObjectId')
             end
        else begin
                  ShowMessage ('!! DISABLE !!! pLoadGuide_Juridical where isBill=true');
                  exit;
                  {Add('select Unit.Id as ObjectId');
                  Add('     , Unit.UnitCode as ObjectCode');
                  Add('     , Unit.UnitName as ObjectName');
                  Add('     , Unit.Id2_Postgres as Id_Postgres');
                  Add('     , null as ParentId_Postgres');
                  Add('     , null as GoodsPropertyId_PG');
                  Add('     , isnull(zf_ChangeTVarCharMediumToNull(ClientInformation.GLNMain),ClientInformation.GLN) as GLNCode');
                  Add('     , zc_rvYes() as zc_rvYes');
                  Add('     , case when Unit.Id in (3, 165) then zc_rvYes() else zc_rvNo() end isCorporate'); // ���� + ����-1
                  Add('     , case when Unit.Id = 3 then _pgInfoMoney_Alan.Id3_Postgres when Unit.Id = 165 then _pgInfoMoney_Irna.Id3_Postgres else null end InfoMoneyId_PG'); // ���� + ����-1
                  Add('from dba.Bill');
                  Add('     join dba.Unit as Unit_all on Unit_all.Id = Bill.FromId and Unit_all.Id2_Postgres is null');
                  Add('     join dba.Unit on Unit.Id = isnull(zf_ChangeIntToNull(Unit_all.DolgByUnitID), isnull(zf_ChangeIntToNull(Unit_all.InformationFromUnitID), Unit_all.Id))');
                  Add('     left outer join dba.ClientInformation on ClientInformation.ClientId = isnull( zf_ChangeIntToNull( Unit_all.InformationFromUnitID), Unit_all.Id)');
                  Add('     left outer join dba._pgInfoMoney as _pgInfoMoney_Alan on _pgInfoMoney_Alan.ObjectCode = 30201'); // �������� + ���� �������� + ����
                  Add('     left outer join dba._pgInfoMoney as _pgInfoMoney_Irna on _pgInfoMoney_Irna.ObjectCode = 30202'); // �������� + ���� �������� + ����
                  Add('where Bill.BillDate between '+FormatToDateServer_notNULL(StrToDate(StartDateEdit.Text))+' and '+FormatToDateServer_notNULL(StrToDate(EndDateEdit.Text))
                  //Add('where Bill.BillDate between '+FormatToDateServer_notNULL(StrToDate('01.01.2011'))+' and '+FormatToDateServer_notNULL(StrToDate('01.01.2014'))
                     +'  and Bill.BillKind=zc_bkIncomeToUnit()');
                     +'  and Unit.Id not  in (4739' // 7910 ����������� ������������
                     +'                      ,5162' // 8534 �������� �. ��� ������������
                     +'                      ,4742' // 7912	��������� ������������
                     +'                      ,4920' // 8104	�������� �������.
                     +'                      ,4740' // 7911	������ ������������
                     +'                      ,5087' // 8459	���������� �������.
                     +'                      ,4695' // 7869	����� ������������
                     +'                      )'
                  Add('group by ObjectId, ObjectCode, ObjectName, Id_Postgres, GLNCode, isCorporate, InfoMoneyId_PG');
                  Add('order by ObjectId');}
             end; // if not isBill
        Open;
        //
        fStop:=cbOnlyOpen.Checked;
        if cbOnlyOpen.Checked then exit;
        //
        Gauge.Progress:=0;
        Gauge.MaxValue:=RecordCount;
        //
        toStoredProc.StoredProcName:='gpinsertupdate_object_juridical';
        toStoredProc.OutputType := otResult;
        toStoredProc.Params.Clear;
        toStoredProc.Params.AddParam ('ioId',ftInteger,ptInputOutput, 0);
        toStoredProc.Params.AddParam ('inCode',ftInteger,ptInput, 0);
        toStoredProc.Params.AddParam ('inName',ftString,ptInput, '');
        toStoredProc.Params.AddParam ('inGLNCode',ftString,ptInput, '');
        toStoredProc.Params.AddParam ('inIsCorporate',ftBoolean,ptInput, false);
        toStoredProc.Params.AddParam ('inJuridicalGroupId',ftInteger,ptInput, 0);
        toStoredProc.Params.AddParam ('inGoodsPropertyId',ftInteger,ptInput, 0);
        toStoredProc.Params.AddParam ('inInfoMoneyId',ftInteger,ptInput, 0);
        //
        while not EOF do
        begin
             //!!!
             if fStop then begin exit;end;
             //
             toStoredProc.Params.ParamByName('ioId').Value:=FieldByName('Id_Postgres').AsInteger;
             toStoredProc.Params.ParamByName('inCode').Value:=FieldByName('ObjectCode').AsInteger;
             toStoredProc.Params.ParamByName('inName').Value:=FieldByName('ObjectName').AsString;
             toStoredProc.Params.ParamByName('inGLNCode').Value:=FieldByName('GLNCode').AsString;
             if FieldByName('isCorporate').AsInteger=FieldByName('zc_rvYes').AsInteger then toStoredProc.Params.ParamByName('inIsCorporate').Value:=true else toStoredProc.Params.ParamByName('inIsCorporate').Value:=false;
             toStoredProc.Params.ParamByName('inJuridicalGroupId').Value:=FieldByName('ParentId_Postgres').AsInteger;
             toStoredProc.Params.ParamByName('inGoodsPropertyId').Value:=FieldByName('GoodsPropertyId_PG').AsInteger;
             toStoredProc.Params.ParamByName('inInfoMoneyId').Value:=FieldByName('InfoMoneyId_PG').AsInteger;

             if not myExecToStoredProc then ;//exit;
             //
             if (1=0)or(FieldByName('Id_Postgres').AsInteger=0)
             then fExecSqFromQuery('update dba.Unit set Id2_Postgres='+IntToStr(toStoredProc.Params.ParamByName('ioId').Value)+' where Id = '+FieldByName('ObjectId').AsString);
             //
             Next;
             Application.ProcessMessages;
             Gauge.Progress:=Gauge.Progress+1;
             Application.ProcessMessages;
        end;
     end;
     //
     myDisabledCB(cbJuridical);
end;
//----------------------------------------------------------------------------------------------------------------------------------------------------
procedure TMainForm.pLoadGuide_Partner (isBill:Boolean);
begin
     if (not cbPartner.Checked)or(not cbPartner.Enabled) then exit;
     //
     myEnabledCB(cbPartner);
     //
     with fromQuery,Sql do begin
        Close;
        Clear;
        if not isBill
        then begin
                  Add('select Unit.Id as ObjectId');
                  Add('     , Unit.UnitCode as ObjectCode');
                  Add('     , Unit.UnitName as ObjectName');
                  Add('     , Unit.Id3_Postgres as Id_Postgres');
                  Add('     , Unit_Juridical.Id2_Postgres as JuridicalId_Postgres');
                  Add('     , 0 as RouteId_Postgres');
                  Add('     , 0 as RouteSortingId_Postgres');
                  Add('     , ClientInformation.GLN as GLNCode');
                  Add('from dba.Unit');
                  Add('     left outer join dba.Unit as Unit_Juridical on Unit_Juridical.Id = isnull(zf_ChangeIntToNull( Unit.DolgByUnitID), isnull(zf_ChangeIntToNull( Unit.InformationFromUnitID), Unit.Id))');
                  Add('     left outer join dba.ClientInformation on ClientInformation.ClientId = Unit.Id');
                  Add('where Unit.Id1_Postgres is null'
                     +'  and (isnull(Unit.findGoodsCard,zc_rvNo()) = zc_rvNo()'
                     +'    or fCheckUnitClientParentID(152,Unit.Id)=zc_rvYes())' // ����������-���
                     +'  and fCheckUnitClientParentID(3,Unit.Id)=zc_rvNo()'    // ����
                     +'  and fCheckUnitClientParentID(3714,Unit.Id)=zc_rvNo()' // ����-������
                     +'  and fCheckUnitClientParentID(3531,Unit.Id)=zc_rvNo()' // � ��*
                     +'  and fCheckUnitClientParentID(3349,Unit.Id)=zc_rvNo()' // ���
                     +'  and fCheckUnitClientParentID(600,Unit.Id)=zc_rvNo()'  // ��������
                     +'  and fCheckUnitClientParentID(149,Unit.Id)=zc_rvNo()'  // ������� ������������
                     +'  and Unit.Id not  in (4739' // 7910 ����������� ������������
                     +'                      ,5162' // 8534 �������� �. ��� ������������
                     +'                      ,4742' // 7912	��������� ������������
                     +'                      ,4920' // 8104	�������� �������.
                     +'                      ,4740' // 7911	������ ������������
                     +'                      ,5087' // 8459	���������� �������.
                     +'                      ,4695' // 7869	����� ������������
                     +'                      )'
                     );
                  Add('order by ObjectId');
             end // if not isBill
        else begin
                  ShowMessage ('!! DISABLE !!! pLoadGuide_Juridical where isBill=true');
                  exit;
                  {Add('select Unit.Id as ObjectId');
                  Add('     , Unit.UnitCode as ObjectCode');
                  Add('     , Unit.UnitName as ObjectName');
                  Add('     , Unit.Id3_Postgres as Id_Postgres');
                  Add('     , Unit_Juridical.Id2_Postgres as JuridicalId_Postgres');
                  Add('     , 0 as RouteId_Postgres');
                  Add('     , 0 as RouteSortingId_Postgres');
                  Add('     , ClientInformation.GLN as GLNCode');
                  Add('from dba.Bill');
                  Add('     join dba.Unit on Unit.Id = Bill.FromId and Unit.Id3_Postgres is null');
                  Add('     left outer join dba.Unit as Unit_Juridical on Unit_Juridical.Id = isnull(zf_ChangeIntToNull( Unit.DolgByUnitID), isnull(zf_ChangeIntToNull( Unit.InformationFromUnitID), Unit.Id))');
                  Add('     left outer join dba.ClientInformation on ClientInformation.ClientId = Unit.Id');
                  Add('where Bill.BillDate between '+FormatToDateServer_notNULL(StrToDate(StartDateEdit.Text))+' and '+FormatToDateServer_notNULL(StrToDate(EndDateEdit.Text))
                     +'  and Bill.BillKind=zc_bkIncomeToUnit()');
                     +'  and Unit.Id not  in (4739' // 7910 ����������� ������������
                     +'                      ,5162' // 8534 �������� �. ��� ������������
                     +'                      ,4742' // 7912	��������� ������������
                     +'                      ,4920' // 8104	�������� �������.
                     +'                      ,4740' // 7911	������ ������������
                     +'                      ,5087' // 8459	���������� �������.
                     +'                      ,4695' // 7869	����� ������������
                     +'                      )'
                  Add('group by ObjectId, ObjectCode, ObjectName, Id_Postgres, JuridicalId_Postgres, GLNCode');
                  Add('order by ObjectId');}
             end; // if not isBill
        Open;
        //
        fStop:=cbOnlyOpen.Checked;
        if cbOnlyOpen.Checked then exit;
        //
        Gauge.Progress:=0;
        Gauge.MaxValue:=RecordCount;
        //
        toStoredProc.StoredProcName:='gpinsertupdate_object_partner';
        toStoredProc.OutputType := otResult;
        toStoredProc.Params.Clear;
        toStoredProc.Params.AddParam ('ioId',ftInteger,ptInputOutput, 0);
        toStoredProc.Params.AddParam ('inCode',ftInteger,ptInput, 0);
        toStoredProc.Params.AddParam ('inName',ftString,ptInput, '');
        toStoredProc.Params.AddParam ('inGLNCode',ftString,ptInput, '');
        toStoredProc.Params.AddParam ('inJuridicalId',ftInteger,ptInput, 0);
        toStoredProc.Params.AddParam ('inRouteId',ftInteger,ptInput, 0);
        toStoredProc.Params.AddParam ('inRouteSortingId',ftInteger,ptInput, 0);
        //
        while not EOF do
        begin
             //!!!
             if fStop then begin exit;end;
             //
             toStoredProc.Params.ParamByName('ioId').Value:=FieldByName('Id_Postgres').AsInteger;
             toStoredProc.Params.ParamByName('inCode').Value:=FieldByName('ObjectCode').AsInteger;
             toStoredProc.Params.ParamByName('inName').Value:=FieldByName('ObjectName').AsString;
             toStoredProc.Params.ParamByName('inGLNCode').Value:=FieldByName('GLNCode').AsString;
             toStoredProc.Params.ParamByName('inJuridicalId').Value:=FieldByName('JuridicalId_Postgres').AsInteger;
             toStoredProc.Params.ParamByName('inRouteId').Value:=FieldByName('RouteId_Postgres').AsInteger;
             toStoredProc.Params.ParamByName('inRouteSortingId').Value:=FieldByName('RouteSortingId_Postgres').AsInteger;
             if not myExecToStoredProc then ;//exit;
             //
             if (1=0)or(FieldByName('Id_Postgres').AsInteger=0)
             then fExecSqFromQuery('update dba.Unit set Id3_Postgres='+IntToStr(toStoredProc.Params.ParamByName('ioId').Value)+' where Id = '+FieldByName('ObjectId').AsString);
             //
             Next;
             Application.ProcessMessages;
             Gauge.Progress:=Gauge.Progress+1;
             Application.ProcessMessages;
        end;
        //EnableControls;
     end;
     //
     myDisabledCB(cbPartner);
end;
//----------------------------------------------------------------------------------------------------------------------------------------------------
procedure TMainForm.pLoadGuide_Business;
begin
     if (not cbBusiness.Checked)or(not cbBusiness.Enabled) then exit;
     //
     myEnabledCB(cbBusiness);
     //
     with fromQuery,Sql do begin
        Close;
        Clear;
        Add('select Unit_Alan.Id as ObjectId');
        Add('     , 0 as ObjectCode');
        Add('     , Unit_Alan.UnitName as ObjectName');
        Add('     , Unit_Alan.Id_Postgres_Business as Id_Postgres');
        Add('from dba.Unit as Unit_Alan');
        Add('where Id = 3');// ����
        Add('order by ObjectId');
        Open;
        //
        fStop:=cbOnlyOpen.Checked;
        if cbOnlyOpen.Checked then exit;
        //
        Gauge.Progress:=0;
        Gauge.MaxValue:=RecordCount;
        //
        toStoredProc.StoredProcName:='gpinsertupdate_object_business';
        toStoredProc.OutputType := otResult;
        toStoredProc.Params.Clear;
        toStoredProc.Params.AddParam ('ioId',ftInteger,ptInputOutput, 0);
        toStoredProc.Params.AddParam ('inCode',ftInteger,ptInput, 0);
        toStoredProc.Params.AddParam ('inName',ftString,ptInput, '');
        //
        while not EOF do
        begin
             //!!!
             if fStop then begin exit;end;
             //
             toStoredProc.Params.ParamByName('ioId').Value:=FieldByName('Id_Postgres').AsInteger;
             toStoredProc.Params.ParamByName('inCode').Value:=FieldByName('ObjectCode').AsInteger;
             toStoredProc.Params.ParamByName('inName').Value:=FieldByName('ObjectName').AsString;
             if not myExecToStoredProc then ;//exit;
             //
             if (1=0)or(FieldByName('Id_Postgres').AsInteger=0)
             then fExecSqFromQuery('update dba.Unit set Id_Postgres_Business='+IntToStr(toStoredProc.Params.ParamByName('ioId').Value)+' where Id = '+FieldByName('ObjectId').AsString);
             //
             Next;
             Application.ProcessMessages;
             Gauge.Progress:=Gauge.Progress+1;
             Application.ProcessMessages;
        end;
     end;
     //
     myDisabledCB(cbBusiness);
end;
//----------------------------------------------------------------------------------------------------------------------------------------------------
procedure TMainForm.pLoadGuide_Branch;
begin
     if (not cbBranch.Checked)or(not cbBranch.Enabled) then exit;
     //
     myEnabledCB(cbBranch);
     //
     with fromQuery,Sql do begin
        Close;
        Clear;
        Add('select _pgUnit.Id as ObjectId');
        Add('     , 0 as ObjectCode');
        Add('     , _pgUnit.Name3 as ObjectName');
        Add('     , _pgUnit.Id_Postgres_Branch as Id_Postgres');
//        Add('     , 0 as JuridicalId_pg');
        Add('from dba._pgUnit');
        Add('     join dba._pgUnit as _pgUnit_parent on _pgUnit_parent.Id = _pgUnit.ParentId and _pgUnit_parent.ObjectCode in (1102)');
        Add('order by ObjectId');
        Open;
        //
        fStop:=cbOnlyOpen.Checked;
        if cbOnlyOpen.Checked then exit;
        //
        Gauge.Progress:=0;
        Gauge.MaxValue:=RecordCount;
        //
        toStoredProc.StoredProcName:='gpinsertupdate_object_branch';
        toStoredProc.OutputType := otResult;
        toStoredProc.Params.Clear;
        toStoredProc.Params.AddParam ('ioId',ftInteger,ptInputOutput, 0);
        toStoredProc.Params.AddParam ('inCode',ftInteger,ptInput, 0);
        toStoredProc.Params.AddParam ('inName',ftString,ptInput, '');
//        toStoredProc.Params.AddParam ('inJuridicalId',ftInteger,ptInput, 0);
        //
        while not EOF do
        begin
             //!!!
             if fStop then begin exit;end;
             //
             toStoredProc.Params.ParamByName('ioId').Value:=FieldByName('Id_Postgres').AsInteger;
             toStoredProc.Params.ParamByName('inCode').Value:=FieldByName('ObjectCode').AsInteger;
             toStoredProc.Params.ParamByName('inName').Value:=FieldByName('ObjectName').AsString;
//             toStoredProc.Params.ParamByName('inJuridicalId').Value:=FieldByName('JuridicalId_pg').AsInteger;
             if not myExecToStoredProc then ;//exit;
             //
             if (1=0)or(FieldByName('Id_Postgres').AsInteger=0)
             then fExecSqFromQuery('update dba._pgUnit set Id_Postgres_Branch='+IntToStr(toStoredProc.Params.ParamByName('ioId').Value)+' where Id = '+FieldByName('ObjectId').AsString);
             //
             Next;
             Application.ProcessMessages;
             Gauge.Progress:=Gauge.Progress+1;
             Application.ProcessMessages;
        end;
     end;
     //
     myDisabledCB(cbBranch);
end;
//----------------------------------------------------------------------------------------------------------------------------------------------------
procedure TMainForm.pLoadGuide_UnitGroup;
begin
     ShowMessage ('!!! ERROR !!! pLoadGuide_UnitGroup');
     exit;
     //
     //
     if (not cbUnitGroup.Checked)or(not cbUnitGroup.Enabled) then exit;
     //
     myEnabledCB(cbUnitGroup);
     //
     with fromQuery,Sql do begin
        Close;
        Clear;
        Add('select Unit.Id as ObjectId');
        Add('     , 0 as ObjectCode');
        Add('     , Unit.UnitName as ObjectName');
        Add('     , Unit.Id1_Postgres as Id_Postgres');
        Add('     , case when Unit.Id in (3, 3714) then 0 else Unit_parent.Id1_Postgres end as ParentId_Postgres');
        Add('from dba.Unit');
        Add('     left outer join dba.isUnit on isUnit.UnitId = Unit.Id');
        Add('     left outer join dba.Unit as Unit_parent on Unit_parent.Id = Unit.ParentId');
        Add('where (fCheckUnitClientParentID(3,Unit.Id)=zc_rvYes()'    // ����
           +'    or fCheckUnitClientParentID(3714,Unit.Id)=zc_rvYes()' // ����-������
           +'      )');
        Add('  and isUnit.UnitId is null');
        Add('  and Unit.Id not in (4417' // ����������� ��������-�����
                               +' ,4137' // �� ����-���
                               +' ,4927' // ����� �������
                               +' ,4931' // ����� ������� �����
                               +' ,3487' // ����� �������� ����
                               +' )');
        Add('  and Unit.ParentId <> 4137'); // MO
        Add('  and Unit.Erased=zc_ErasedVis()');
        Add('  and Unit.HasChildren<>zc_hsLeaf()');

        Add('union all');

        Add('select Unit.Id as ObjectId');
        Add('     , 0 as ObjectCode');
        Add('     , '+FormatToVarCharServer_notNULL('��� ����������� � �������')+' as ObjectName');
        Add('     , Unit.Id3_Postgres as Id_Postgres');
        Add('     , 0 as ParentId_Postgres');
        Add('from dba.Unit');
        Add('where Unit.Id = 151'); // ���
        Add('order by ObjectId');
        Open;
        //
        fStop:=cbOnlyOpen.Checked;
        if cbOnlyOpen.Checked then exit;
        //
        Gauge.Progress:=0;
        Gauge.MaxValue:=RecordCount;
        //
        toStoredProc.StoredProcName:='gpinsertupdate_object_unitgroup';
        toStoredProc.OutputType := otResult;
        toStoredProc.Params.Clear;
        toStoredProc.Params.AddParam ('ioId',ftInteger,ptInputOutput, 0);
        toStoredProc.Params.AddParam ('inCode',ftInteger,ptInput, 0);
        toStoredProc.Params.AddParam ('inName',ftString,ptInput, '');
        toStoredProc.Params.AddParam ('inParentId',ftInteger,ptInput, 0);
        //
        while not EOF do
        begin
             //!!!
             if fStop then begin exit;end;
             //
             toStoredProc.Params.ParamByName('ioId').Value:=FieldByName('Id_Postgres').AsInteger;
             toStoredProc.Params.ParamByName('inCode').Value:=FieldByName('ObjectCode').AsInteger;
             toStoredProc.Params.ParamByName('inName').Value:=FieldByName('ObjectName').AsString;
             toStoredProc.Params.ParamByName('inParentId').Value:=FieldByName('ParentId_Postgres').AsInteger;
             //toStoredProc.Params.ParamByName('inSession').Value:=fGetSession;
             if not myExecToStoredProc then ;//exit;
             //
             if (1=0)or(FieldByName('Id_Postgres').AsInteger=0)
             then if FieldByName('ObjectId').AsInteger=151
                  then fExecSqFromQuery('update dba.Unit set Id3_Postgres='+IntToStr(toStoredProc.Params.ParamByName('ioId').Value)+' where Id = '+FieldByName('ObjectId').AsString)
                  else fExecSqFromQuery('update dba.Unit set Id1_Postgres='+IntToStr(toStoredProc.Params.ParamByName('ioId').Value)+' where Id = '+FieldByName('ObjectId').AsString);
             //
             Next;
             Application.ProcessMessages;
             Gauge.Progress:=Gauge.Progress+1;
             Application.ProcessMessages;
        end;
     end;
     //
     myDisabledCB(cbUnitGroup);
end;
//----------------------------------------------------------------------------------------------------------------------------------------------------
procedure TMainForm.pLoadGuide_UnitOld;
begin
     if (not cbUnit.Checked)or(not cbUnit.Enabled) then exit;
     //
     myEnabledCB(cbUnit);
     //
     with fromQuery,Sql do begin
        Close;
        Clear;
        Add('select Unit.Id as ObjectId');
        Add('     , 0 as ObjectCode');
        Add('     , Unit.UnitName as ObjectName');
        Add('     , Unit.Id3_Postgres as Id_Postgres');
        Add('     , Unit_parent.Id1_Postgres as ParentId_Postgres');
        Add('     , Unit_Branch.Id3_Postgres as BranchId_Postgres');
        Add('from dba.Unit');
        Add('     left outer join dba.isUnit on isUnit.UnitId = Unit.Id');
        Add('     left outer join dba.Unit as Unit_parent on Unit_parent.Id = Unit.ParentId');
        Add('     left outer join dba.Unit as Unit_Branch on Unit_Branch.Id = 3'); // ����
        Add('where (fCheckUnitClientParentID(3,Unit.Id)=zc_rvYes()'    // ����
           +'    or fCheckUnitClientParentID(3714,Unit.Id)=zc_rvYes()' // ����-������
           +'      )');
        Add('  and (isUnit.UnitId is not null or Unit.Id in (3487))'); // ����� �������� ����
//        Add('  and Unit.Erased=zc_ErasedVis()');

        Add('union all');

        Add('select Unit.Id as ObjectId');
        Add('     , Unit.UnitCode as ObjectCode');
        Add('     , Unit.UnitName as ObjectName');
        Add('     , Unit.Id3_Postgres as Id_Postgres');
        Add('     , Unit_parent.Id3_Postgres as ParentId_Postgres');
        Add('     , Unit_Branch.Id3_Postgres as BranchId_Postgres');
        Add('from dba.Unit');
        Add('     left outer join dba.isUnit on isUnit.UnitId = Unit.Id');
        Add('     left outer join dba.Unit as Unit_parent on Unit_parent.Id = 151'); // ���
        Add('     left outer join dba.Unit as Unit_Branch on Unit_Branch.Id = 3'); // ����
        Add('where fCheckUnitClientParentID(3,Unit.Id)=zc_rvNo()'    // ����
           +'  and fCheckUnitClientParentID(3714,Unit.Id)=zc_rvNo()' // ����-������
            );
        Add('  and isnull(Unit.findGoodsCard,zc_rvNo()) = zc_rvYes()');
        Add('  and isUnit.UnitId is null');
//        Add('  and Unit.Erased=zc_ErasedVis()');
        Add('order by ObjectId');

        Open;
        //
        fStop:=cbOnlyOpen.Checked;
        if cbOnlyOpen.Checked then exit;
        //
        Gauge.Progress:=0;
        Gauge.MaxValue:=RecordCount;
        //
        toStoredProc.StoredProcName:='gpinsertupdate_object_unit';
        toStoredProc.OutputType := otResult;
        toStoredProc.Params.Clear;
        toStoredProc.Params.AddParam ('ioId',ftInteger,ptInputOutput, 0);
        toStoredProc.Params.AddParam ('inCode',ftInteger,ptInput, 0);
        toStoredProc.Params.AddParam ('inName',ftString,ptInput, '');
        toStoredProc.Params.AddParam ('inUnitGroupId',ftInteger,ptInput, 0);
        toStoredProc.Params.AddParam ('inBranchId',ftInteger,ptInput, 0);
        //
        while not EOF do
        begin
             //!!!
             if fStop then begin exit;end;
             //
             toStoredProc.Params.ParamByName('ioId').Value:=FieldByName('Id_Postgres').AsInteger;
             toStoredProc.Params.ParamByName('inCode').Value:=FieldByName('ObjectCode').AsInteger;
             toStoredProc.Params.ParamByName('inName').Value:=FieldByName('ObjectName').AsString;
             toStoredProc.Params.ParamByName('inUnitGroupId').Value:=FieldByName('ParentId_Postgres').AsInteger;
             toStoredProc.Params.ParamByName('inBranchId').Value:=FieldByName('BranchId_Postgres').AsInteger;
             //toStoredProc.Params.ParamByName('inSession').Value:=fGetSession;
             if not myExecToStoredProc then ;//exit;
             //
             if (1=0)or(FieldByName('Id_Postgres').AsInteger=0)
             then fExecSqFromQuery('update dba.Unit set Id3_Postgres='+IntToStr(toStoredProc.Params.ParamByName('ioId').Value)+' where Id = '+FieldByName('ObjectId').AsString);
             //
             Next;
             Application.ProcessMessages;
             Gauge.Progress:=Gauge.Progress+1;
             Application.ProcessMessages;
        end;
        //EnableControls;
     end;
     //
     myDisabledCB(cbUnit);
end;
//----------------------------------------------------------------------------------------------------------------------------------------------------
procedure TMainForm.pLoadGuide_Unit;
begin
     if (not cbUnit.Checked)or(not cbUnit.Enabled) then exit;
     //
     myEnabledCB(cbUnit);
     //
     with fromQuery,Sql do begin
        Close;
        Clear;
        Add('select _pgUnit.Id as ObjectId');
        Add('     , 0 as ObjectCode');
        Add('     , _pgUnit.Name3 as ObjectName');
        Add('     , _pgUnit.Id_Postgres as Id_Postgres');
        Add('     , _pgUnit_parent.Id_Postgres as ParentId_Postgres');
        Add('     , isnull(_pgUnit_Branch_byCode.Id_Postgres_Branch, _pgUnit_Branch.Id_Postgres_Branch) as BranchId_Postgres');
        Add('     , Unit_Alan.Id_Postgres_Business as BusinessId_Postgres');
        Add('     , Unit_Alan.Id2_Postgres as JuridicalId_Postgres');
        Add('     , _pgAccount.Id2_Postgres as AccountDirectionId');
        Add('     , _pgProfitLoss.Id2_Postgres as ProfitLossDirectionId');
        Add('from dba._pgUnit');
        Add('     left outer join dba._pgUnit as _pgUnit_parent on _pgUnit_parent.Id = _pgUnit.ParentId');
        Add('     left outer join dba._pgUnit as _pgUnit_parent2 on _pgUnit_parent2.Id = _pgUnit_parent.ParentId');
        Add('     left outer join dba._pgUnit as _pgUnit_Branch on _pgUnit_Branch.Id = case when _pgUnit_parent.ObjectCode in (1102) then _pgUnit.Id when _pgUnit_parent2.ObjectCode in (1102) then _pgUnit.ParentId end');
        Add('     left outer join dba._pgUnit as _pgUnit_Branch_byCode on _pgUnit_Branch_byCode.ObjectCode = case when _pgUnit.ObjectCode in (81) then 102');
        Add('                                                                                                     WHEN _pgUnit.ObjectCode in (82) THEN 103');
        Add('                                                                                                     WHEN _pgUnit.ObjectCode in (83) THEN 104');
        Add('                                                                                                     WHEN _pgUnit.ObjectCode in (84) THEN 105');
        Add('                                                                                                     WHEN _pgUnit.ObjectCode in (85) THEN 106');
        Add('                                                                                                     WHEN _pgUnit.ObjectCode in (86) THEN 107');
        Add('                                                                                                     WHEN _pgUnit.ObjectCode in (87) THEN 108');
        Add('                                                                                                     WHEN _pgUnit.ObjectCode in (88) THEN 109');
        Add('                                                                                                     WHEN _pgUnit.ObjectCode in (89) THEN 110');
        Add('                                                                                                     WHEN _pgUnit.ObjectCode in (90) THEN 111');
        Add('                                                                                                END');
        Add('     left outer join dba.Unit as Unit_Alan on Unit_Alan.Id = 3');// ����
        Add('     left outer join dba._pgAccount on _pgAccount.ObjectCode = CASE WHEN _pgUnit_parent.ObjectCode in (1102) or _pgUnit_parent2.ObjectCode in (1102) THEN 20701'); // ������ + �� ��������
        Add('                                                                    WHEN _pgUnit.ObjectCode in (1201, 2, 1204, 1205, 21) THEN 20201'); // ������ + �� �������
        Add('                                                                    WHEN _pgUnit.ObjectCode in (22, 23, 1303, 1304, 1501) THEN 20101'); // ������ + �� ������� ��
        Add('                                                                    WHEN _pgUnit.ObjectCode in (7) THEN 20801'); // ������ + �� ��������
        Add('                                                                    WHEN _pgUnit_parent.ObjectCode in (1305) THEN 20401'); // ������ + �� ������������
        Add('                                                                END');
        Add('     left outer join dba._pgProfitLoss on _pgProfitLoss.ObjectCode = CASE WHEN _pgUnit.ObjectCode in (51) THEN 30101'); // ���������� �����
        Add('                                                                          WHEN _pgUnit.ObjectCode in (52) THEN 30201'); // ����� + ���������� ����������
        Add('                                                                          WHEN _pgUnit.ObjectCode in (1101) THEN 30301'); // ���������� ������
        Add('                                                                          WHEN _pgUnit.ObjectCode in (71) THEN 40101'); // ����  + ���������� ����������
        Add('                                                                          WHEN _pgUnit.ObjectCode in (1102) THEN 40201'); // ���������� ��������
        Add('                                                                          WHEN _pgUnit.ObjectCode in (131) THEN 40301'); // �������������
        Add('                                                                          WHEN _pgUnit.ObjectCode in (1103) THEN 20101'); // ���������� ������������
        Add('                                                                          WHEN _pgUnit.ObjectCode in (1104) THEN 20201'); // ���������� �������
        Add('                                                                          WHEN _pgUnit.ObjectCode in (31) THEN 20301'); // ������������ + ���������� ����������
        Add('                                                                          WHEN _pgUnit.ObjectCode in (33) THEN 20401'); // ���������� �����
        Add('                                                                      END');
        Add('where _pgUnit.Id<>0');
        Add('order by ObjectCode');

        Open;
        //
        fStop:=cbOnlyOpen.Checked;
        if cbOnlyOpen.Checked then exit;
        //
        Gauge.Progress:=0;
        Gauge.MaxValue:=RecordCount;
        //
        toStoredProc.StoredProcName:='gpinsertupdate_object_unit';
        toStoredProc.OutputType := otResult;
        toStoredProc.Params.Clear;
        toStoredProc.Params.AddParam ('ioId',ftInteger,ptInputOutput, 0);
        toStoredProc.Params.AddParam ('inCode',ftInteger,ptInput, 0);
        toStoredProc.Params.AddParam ('inName',ftString,ptInput, '');
        toStoredProc.Params.AddParam ('inParentId',ftInteger,ptInput, 0);
        toStoredProc.Params.AddParam ('inBranchId',ftInteger,ptInput, 0);
        toStoredProc.Params.AddParam ('inBusinessId',ftInteger,ptInput, 0);
        toStoredProc.Params.AddParam ('inJuridicalId',ftInteger,ptInput, 0);
        toStoredProc.Params.AddParam ('inAccountDirectionId',ftInteger,ptInput, 0);
        toStoredProc.Params.AddParam ('inProfitLossDirectionId',ftInteger,ptInput, 0);
        //
        while not EOF do
        begin
             //!!!
             if fStop then begin exit;end;
             //
             toStoredProc.Params.ParamByName('ioId').Value:=FieldByName('Id_Postgres').AsInteger;
             toStoredProc.Params.ParamByName('inCode').Value:=FieldByName('ObjectCode').AsInteger;
             toStoredProc.Params.ParamByName('inName').Value:=FieldByName('ObjectName').AsString;
             toStoredProc.Params.ParamByName('inParentId').Value:=FieldByName('ParentId_Postgres').AsInteger;
             toStoredProc.Params.ParamByName('inBranchId').Value:=FieldByName('BranchId_Postgres').AsInteger;
             toStoredProc.Params.ParamByName('inBusinessId').Value:=FieldByName('BusinessId_Postgres').AsInteger;
             toStoredProc.Params.ParamByName('inJuridicalId').Value:=FieldByName('JuridicalId_Postgres').AsInteger;
             toStoredProc.Params.ParamByName('inAccountDirectionId').Value:=FieldByName('AccountDirectionId').AsInteger;
             toStoredProc.Params.ParamByName('inProfitLossDirectionId').Value:=FieldByName('ProfitLossDirectionId').AsInteger;
             //toStoredProc.Params.ParamByName('inSession').Value:=fGetSession;
             if not myExecToStoredProc then ;//exit;
             //
             if (1=0)or(FieldByName('Id_Postgres').AsInteger=0)
             then fExecSqFromQuery('update dba._pgUnit set Id_Postgres='+IntToStr(toStoredProc.Params.ParamByName('ioId').Value)+' where Id = '+FieldByName('ObjectId').AsString);
             //
             Next;
             Application.ProcessMessages;
             Gauge.Progress:=Gauge.Progress+1;
             Application.ProcessMessages;
        end;
        //EnableControls;
     end;
     //
     myDisabledCB(cbUnit);
end;
//----------------------------------------------------------------------------------------------------------------------------------------------------
procedure TMainForm.pLoadGuide_Member_andPersonal;
begin
     if (not cbMember_andPersonal.Checked)or(not cbMember_andPersonal.Enabled) then exit;
     //
     myEnabledCB(cbMember_andPersonal);
     //
     with fromQuery,Sql do begin
        Close;
        Clear;
        Add('select Unit.Id as ObjectId');
        Add('     , 0 as ObjectCode');
        Add('     , Unit.UnitName as ObjectName');
        Add('     , 0 as PositionId_PG');
        Add('     , _pgUnit_Zagatov.Id_Postgres as UnitId_PG');
        Add('     , Unit_Alan.Id2_Postgres as JuridicalId_PG');
        Add('     , Unit_Alan.Id_Postgres_Business as BusinessId_PG');
        Add('     , cast (null as TVarCharMedium) as INN');
        Add('     , cast (null as date) as DateIn');
        Add('     , cast (null as date) as DateOut');

        Add('     , Unit.Id1_Postgres as Id_Postgres');
        Add('     , Unit.PersonalId_Postgres as Id_Postgres_two');
        Add('from dba.Unit');
        Add('     left outer join dba._pgUnit as _pgUnit_Zagatov on _pgUnit_Zagatov.ObjectCode = 11'); // ����� �������������
        Add('     left outer join dba.Unit as Unit_Alan on Unit_Alan.Id = 3');// ����
        Add('where Unit.Id in (4739' // 7910 ����������� ������������
           +'                 ,5162' // 8534 �������� �. ��� ������������
           +'                 ,4742' // 7912	��������� ������������
           +'                 ,4920' // 8104	�������� �������.
           +'                 ,4740' // 7911	������ ������������
           +'                 ,5087' // 8459	���������� �������.
           +'                 ,4695' // 7869	����� ������������
           +'                 )'
           );
        Add('order by ObjectId');
        Open;
        //
        fStop:=cbOnlyOpen.Checked;
        if cbOnlyOpen.Checked then exit;
        //
        Gauge.Progress:=0;
        Gauge.MaxValue:=RecordCount;
        //
        toStoredProc.StoredProcName:='gpInsertUpdate_Object_Member';
        toStoredProc.OutputType := otResult;
        toStoredProc.Params.Clear;
        toStoredProc.Params.AddParam ('ioId',ftInteger,ptInputOutput, 0);
        toStoredProc.Params.AddParam ('inCode',ftInteger,ptInput, 0);
        toStoredProc.Params.AddParam ('inName',ftString,ptInput, '');
        toStoredProc.Params.AddParam ('inINN',ftString,ptInput, '');

        toStoredProc_two.StoredProcName:='gpinsertupdate_object_personal';
        toStoredProc_two.OutputType := otResult;
        toStoredProc_two.Params.Clear;
        toStoredProc_two.Params.AddParam ('ioId',ftInteger,ptInputOutput, 0);
        toStoredProc_two.Params.AddParam ('inCode',ftInteger,ptInput, 0);
        toStoredProc_two.Params.AddParam ('inName',ftString,ptInput, '');
        toStoredProc_two.Params.AddParam ('inMemberId',ftInteger,ptInput, 0);
        toStoredProc_two.Params.AddParam ('inPositionId',ftInteger,ptInput, 0);
        toStoredProc_two.Params.AddParam ('inUnitId',ftInteger,ptInput, 0);
        toStoredProc_two.Params.AddParam ('inJuridicalId',ftInteger,ptInput, 0);
        toStoredProc_two.Params.AddParam ('inBusinessId',ftInteger,ptInput, 0);
        toStoredProc_two.Params.AddParam ('inDateIn',ftDateTime,ptInput, 0);
        toStoredProc_two.Params.AddParam ('inDateOut',ftDateTime,ptInput, 0);

        //
        while not EOF do
        begin
             //!!!
             if fStop then begin exit;end;
             // Member
             toStoredProc.Params.ParamByName('ioId').Value:=FieldByName('Id_Postgres').AsInteger;
             toStoredProc.Params.ParamByName('inCode').Value:=FieldByName('ObjectCode').AsInteger;
             toStoredProc.Params.ParamByName('inName').Value:=FieldByName('ObjectName').AsString;
             toStoredProc.Params.ParamByName('inINN').Value:=FieldByName('INN').AsString;
             if not myExecToStoredProc then ;//exit;
             //Personal
             toStoredProc_two.Params.ParamByName('ioId').Value:=FieldByName('Id_Postgres_two').AsInteger;
             toStoredProc_two.Params.ParamByName('inCode').Value:=FieldByName('ObjectCode').AsInteger;
             toStoredProc_two.Params.ParamByName('inName').Value:=FieldByName('ObjectName').AsString;
             toStoredProc_two.Params.ParamByName('inMemberId').Value:=toStoredProc.Params.ParamByName('ioId').Value;
             toStoredProc_two.Params.ParamByName('inPositionId').Value:=FieldByName('PositionId_PG').AsInteger;
             toStoredProc_two.Params.ParamByName('inUnitId').Value:=FieldByName('UnitId_PG').AsInteger;
             toStoredProc_two.Params.ParamByName('inJuridicalId').Value:=FieldByName('JuridicalId_PG').AsInteger;
             toStoredProc_two.Params.ParamByName('inBusinessId').Value:=FieldByName('BusinessId_PG').AsInteger;
             toStoredProc_two.Params.ParamByName('inDateIn').Value:='01.01.2013';
             toStoredProc_two.Params.ParamByName('inDateOut').Value:='01.01.2013';
             //toStoredProc_two.Params.ParamByName('inDateIn').Value:=FieldByName('DateIn').AsDateTime;
             //toStoredProc_two.Params.ParamByName('inDateOut').Value:=FieldByName('DateOut').AsDateTime;
             if not myExecToStoredProc_two then ;//exit;
             //
             if (1=0)or(FieldByName('Id_Postgres').AsInteger=0)or(FieldByName('Id_Postgres_two').AsInteger=0)
             then fExecSqFromQuery('update dba.Unit set Id1_Postgres='+IntToStr(toStoredProc.Params.ParamByName('ioId').Value)+', PersonalId_Postgres='+IntToStr(toStoredProc_two.Params.ParamByName('ioId').Value)+' where Id = '+FieldByName('ObjectId').AsString);
             //
             Next;
             Application.ProcessMessages;
             Gauge.Progress:=Gauge.Progress+1;
             Application.ProcessMessages;
        end;
        //EnableControls;
     end;
     //
     myDisabledCB(cbMember_andPersonal);
end;
//----------------------------------------------------------------------------------------------------------------------------------------------------
procedure TMainForm.pLoadGuide_PriceList;
begin
     if (not cbPriceList.Checked)or(not cbPriceList.Enabled) then exit;
     //
     myEnabledCB(cbPriceList);
     //
     with fromQuery,Sql do begin
        Close;
        Clear;
        Add('select PriceList_byHistory.Id as ObjectId');
        Add('     , 0 as ObjectCode');
        Add('     , PriceList_byHistory.PriceListName as ObjectName');
        Add('     , PriceList_byHistory.Id_Postgres as Id_Postgres');
        Add('from dba.PriceList_byHistory');
        Add('order by ObjectId');
        Open;
        //
        fStop:=cbOnlyOpen.Checked;
        if cbOnlyOpen.Checked then exit;
        //
        Gauge.Progress:=0;
        Gauge.MaxValue:=RecordCount;
        //
        toStoredProc.StoredProcName:='gpinsertupdate_object_pricelist';
        toStoredProc.OutputType := otResult;
        toStoredProc.Params.Clear;
        toStoredProc.Params.AddParam ('ioId',ftInteger,ptInputOutput, 0);
        toStoredProc.Params.AddParam ('inCode',ftInteger,ptInput, 0);
        toStoredProc.Params.AddParam ('inName',ftString,ptInput, '');
        //
        while not EOF do
        begin
             //!!!
             if fStop then begin exit;end;
             //
             toStoredProc.Params.ParamByName('ioId').Value:=FieldByName('Id_Postgres').AsInteger;
             toStoredProc.Params.ParamByName('inCode').Value:=FieldByName('ObjectCode').AsInteger;
             toStoredProc.Params.ParamByName('inName').Value:=FieldByName('ObjectName').AsString;
             //toStoredProc.Params.ParamByName('inSession').Value:=fGetSession;
             if not myExecToStoredProc then ;//exit;
             //
             if (1=0)or(FieldByName('Id_Postgres').AsInteger=0)
             then fExecSqFromQuery('update dba.PriceList_byHistory set Id_Postgres='+IntToStr(toStoredProc.Params.ParamByName('ioId').Value)+' where Id = '+FieldByName('ObjectId').AsString);
             //
             Next;
             Application.ProcessMessages;
             Gauge.Progress:=Gauge.Progress+1;
             Application.ProcessMessages;
        end;
        //EnableControls;
     end;
     //
     myDisabledCB(cbPriceList);
end;
//----------------------------------------------------------------------------------------------------------------------------------------------------
procedure TMainForm.pLoadGuide_GoodsProperty;
begin
     if (not cbGoodsProperty.Checked)or(not cbGoodsProperty.Enabled) then exit;
     //
     myEnabledCB(cbGoodsProperty);
     //
     with fromQuery,Sql do begin
        Close;
        Clear;
        Add('select GoodsProperty_Postgres.Id as ObjectId');
        Add('     , 0 as ObjectCode');
        Add('     , GoodsProperty_Postgres.Name_PG as ObjectName');
        Add('     , GoodsProperty_Postgres.Id_Postgres as Id_Postgres');
        Add('from dba.GoodsProperty_Postgres');
        Add('order by ObjectId');
        Open;
        //
        fStop:=cbOnlyOpen.Checked;
        if cbOnlyOpen.Checked then exit;
        //
        Gauge.Progress:=0;
        Gauge.MaxValue:=RecordCount;
        //
        toStoredProc.StoredProcName:='gpinsertupdate_object_goodsproperty';
        toStoredProc.OutputType := otResult;
        toStoredProc.Params.Clear;
        toStoredProc.Params.AddParam ('ioId',ftInteger,ptInputOutput, 0);
        toStoredProc.Params.AddParam ('inCode',ftInteger,ptInput, 0);
        toStoredProc.Params.AddParam ('inName',ftString,ptInput, '');
        //
        while not EOF do
        begin
             //!!!
             if fStop then begin exit;end;
             //
             toStoredProc.Params.ParamByName('ioId').Value:=FieldByName('Id_Postgres').AsInteger;
             toStoredProc.Params.ParamByName('inCode').Value:=FieldByName('ObjectCode').AsInteger;
             toStoredProc.Params.ParamByName('inName').Value:=FieldByName('ObjectName').AsString;
             //toStoredProc.Params.ParamByName('inSession').Value:=fGetSession;
             if not myExecToStoredProc then ;//exit;
             //
             if (1=0)or(FieldByName('Id_Postgres').AsInteger=0)
             then fExecSqFromQuery('update dba.GoodsProperty_Postgres set Id_Postgres='+IntToStr(toStoredProc.Params.ParamByName('ioId').Value)+' where Id = '+FieldByName('ObjectId').AsString);
             //
             Next;
             Application.ProcessMessages;
             Gauge.Progress:=Gauge.Progress+1;
             Application.ProcessMessages;
        end;
     end;
     //
     myDisabledCB(cbGoodsProperty);
end;
//----------------------------------------------------------------------------------------------------------------------------------------------------
procedure TMainForm.pLoadGuide_GoodsPropertyValue;
begin
     if (not cbGoodsPropertyValue.Checked)or(not cbGoodsPropertyValue.Enabled) then exit;
     //
     myEnabledCB(cbGoodsPropertyValue);
     //
     with fromQuery,Sql do begin
        Close;
        Clear;
        Add('select GoodsProperty_Detail.Id as ObjectId');
        Add('     , zc_rvYes() as zc_rvYes');
        //---------------------------1
        Add('     , case when trim (GoodsProperty_Detail.GoodsCodeScaner)<>'+FormatToVarCharServer_notNULL('')+' then zc_rvYes() else zc_rvNo() end as is1');
        Add('     , null as ObjectName1');
        Add('     , case when is1=zc_rvNo() then cast (null as TSumm) when SUBSTR(GoodsProperty_Detail.GoodsCodeScaner,1,6)='+FormatToVarCharServer_notNULL('230365')+' then SUBSTR(GoodsProperty_Detail.GoodsCodeScaner,13,2) when GoodsProperty.MeasureId = zc_measure_Sht() then SUBSTR(GoodsProperty_Detail.GoodsCodeScaner,15,2) else cast (null as TSumm) end as Amount1');
        Add('     , case when is1=zc_rvNo() then null when SUBSTR(GoodsProperty_Detail.GoodsCodeScaner,1,6)='+FormatToVarCharServer_notNULL('230365')+' then SUBSTR(GoodsProperty_Detail.GoodsCodeScaner,1,12) when GoodsProperty.MeasureId = zc_measure_Sht() then SUBSTR(GoodsProperty_Detail.GoodsCodeScaner,1,13) else SUBSTR(GoodsProperty_Detail.GoodsCodeScaner,1,6)+'+FormatToVarCharServer_notNULL('0000000')+' end as BarCode1');
        Add('     , case when is1=zc_rvNo() then null when SUBSTR(GoodsProperty_Detail.GoodsCodeScaner,1,6)='+FormatToVarCharServer_notNULL('230365')+' then SUBSTR(GoodsProperty_Detail.GoodsCodeScaner,17,5) when GoodsProperty.MeasureId = zc_measure_Sht() then SUBSTR(GoodsProperty_Detail.GoodsCodeScaner,18,5) else SUBSTR(GoodsProperty_Detail.GoodsCodeScaner,8,5) end as Article1');
        Add('     , null as BarCodeGLN1');
        Add('     , null as ArticleGLN1');
        Add('     , PG1.Id_Postgres as GoodsPropertyId1');
        Add('     , GoodsProperty.Id_Postgres as GoodsId1');
        Add('     , KindPackage.Id_Postgres as GoodsKindId1');
        Add('     , GoodsProperty_Detail.Id1_Postgres as Id_Postgres1');
        //---------------------------2
        Add('     , case when trim (GoodsProperty_Detail.GoodsCodeScaner_byKievOK)<>'+FormatToVarCharServer_notNULL('')+' then zc_rvYes() else zc_rvNo() end as is2');
        Add('     , null as ObjectName2');
        Add('     , cast (null as TSumm) as Amount2');
        Add('     , CASE WHEN LENGTH(GoodsProperty_Detail.GoodsCodeScaner_byKievOK)=6 THEN '+FormatToVarCharServer_notNULL('28')+'+GoodsProperty_Detail.GoodsCodeScaner_byKievOK ELSE '+FormatToVarCharServer_notNULL('')+' END as BarCode2');
        Add('     , CASE WHEN LENGTH(GoodsProperty_Detail.GoodsCodeScaner_byKievOK)=6 THEN '+FormatToVarCharServer_notNULL('')+' ELSE trim (GoodsProperty_Detail.GoodsCodeScaner_byKievOK) END as Article2');
        Add('     , null as BarCodeGLN2');
        Add('     , null as ArticleGLN2');
        Add('     , PG2.Id_Postgres as GoodsPropertyId2');
        Add('     , GoodsProperty.Id_Postgres as GoodsId2');
        Add('     , KindPackage.Id_Postgres as GoodsKindId2');
        Add('     , GoodsProperty_Detail.Id2_Postgres as Id_Postgres2');
        //---------------------------3
        Add('     , case when LENGTH(GoodsProperty_Detail.GoodsCodeScaner_byMetro)>3 then zc_rvYes() else zc_rvNo() end as is3');
        Add('     , null as ObjectName3');
        Add('     , case when is3=zc_rvNo() then cast (null as TSumm) when GoodsProperty.MeasureId = zc_measure_Sht() and SUBSTR(GoodsProperty_Detail.GoodsCodeScaner_byMetro,20,2) <> '+FormatToVarCharServer_notNULL('')+' then SUBSTR(GoodsProperty_Detail.GoodsCodeScaner_byMetro,20,2) else cast (null as TSumm) end as Amount3');
        Add('     , SUBSTR(GoodsProperty_Detail.GoodsCodeScaner_byMetro,6,13) as BarCode3');
        Add('     , case when is3=zc_rvNo() then null when GoodsProperty.MeasureId = zc_measure_Sht() then case when SUBSTR(GoodsProperty_Detail.GoodsCodeScaner_byMetro,23,1)='+FormatToVarCharServer_notNULL('0')+' then SUBSTR(GoodsProperty_Detail.GoodsCodeScaner_byMetro,24,5) else SUBSTR(GoodsProperty_Detail.GoodsCodeScaner_byMetro,23,6) end'
                                                                                                   +' else case when SUBSTR(GoodsProperty_Detail.GoodsCodeScaner_byMetro,20,1)='+FormatToVarCharServer_notNULL('0')+' then SUBSTR(GoodsProperty_Detail.GoodsCodeScaner_byMetro,21,5) else SUBSTR(GoodsProperty_Detail.GoodsCodeScaner_byMetro,20,6) end'
           +'       end as Article3');
        Add('     , BarCode3 as BarCodeGLN3');
        Add('     , Article3 as ArticleGLN3');
        Add('     , PG3.Id_Postgres as GoodsPropertyId3');
        Add('     , GoodsProperty.Id_Postgres as GoodsId3');
        Add('     , KindPackage.Id_Postgres as GoodsKindId3');
        Add('     , GoodsProperty_Detail.Id3_Postgres as Id_Postgres3');
        //---------------------------4
        Add('     , case when trim (GoodsProperty_Detail.GoodsCodeScaner_byMain)<>'+FormatToVarCharServer_notNULL('')
                        +' or trim(GoodsProperty_Detail.GoodsName_Client)<>'+FormatToVarCharServer_notNULL('')
                        +'  then zc_rvYes() else zc_rvNo() end as is4');
        Add('     , trim(GoodsProperty_Detail.GoodsName_Client) as ObjectName4');
        Add('     , cast (null as TSumm) as Amount4');
        Add('     , GoodsProperty_Detail.GoodsCodeScaner_byMain as BarCode4');
        Add('     , null as Article4');
        Add('     , null as BarCodeGLN4');
        Add('     , null as ArticleGLN4');
        Add('     , PG4.Id_Postgres as GoodsPropertyId4');
        Add('     , GoodsProperty.Id_Postgres as GoodsId4');
        Add('     , KindPackage.Id_Postgres as GoodsKindId4');
        Add('     , GoodsProperty_Detail.Id4_Postgres as Id_Postgres4');
        //---------------------------5
        Add('     , case when trim (GoodsProperty_Detail.GoodsCodeScaner_byFozzi)<>'+FormatToVarCharServer_notNULL('')+'  then zc_rvYes() else zc_rvNo() end as is5');
        Add('     , null as ObjectName5');
        Add('     , case when is5=zc_rvNo() then cast (null as TSumm) when GoodsProperty.MeasureId = zc_measure_Sht() then SUBSTR(GoodsProperty_Detail.GoodsCodeScaner_byFozzi,15,2) else cast (null as TSumm) end as Amount5');
        Add('     , case when is5=zc_rvNo() then null when GoodsProperty.MeasureId = zc_measure_Sht() then SUBSTR(GoodsProperty_Detail.GoodsCodeScaner_byFozzi,1,13) else SUBSTR(GoodsProperty_Detail.GoodsCodeScaner_byFozzi,1,7)+'+FormatToVarCharServer_notNULL('000000')+' end as BarCode5');
        Add('     , case when is5=zc_rvNo() then null when GoodsProperty.MeasureId = zc_measure_Sht() then SUBSTR(GoodsProperty_Detail.GoodsCodeScaner_byFozzi,18,6)'
                                                   +' when LENGTH (GoodsProperty_Detail.GoodsCodeScaner_byFozzi) = 24 then case when SUBSTR(GoodsProperty_Detail.GoodsCodeScaner_byFozzi,19,1)='+FormatToVarCharServer_notNULL('0')+' then SUBSTR(GoodsProperty_Detail.GoodsCodeScaner_byFozzi,20,5) else SUBSTR(GoodsProperty_Detail.GoodsCodeScaner_byFozzi,19,6) end'
                                                   +' when LENGTH (GoodsProperty_Detail.GoodsCodeScaner_byFozzi) = 23 then case when SUBSTR(GoodsProperty_Detail.GoodsCodeScaner_byFozzi,18,1)='+FormatToVarCharServer_notNULL('0')+' then SUBSTR(GoodsProperty_Detail.GoodsCodeScaner_byFozzi,19,5) else SUBSTR(GoodsProperty_Detail.GoodsCodeScaner_byFozzi,18,6) end'
                                                   +' when SUBSTR(GoodsProperty_Detail.GoodsCodeScaner_byFozzi,9,1)='+FormatToVarCharServer_notNULL('0')+' then SUBSTR(GoodsProperty_Detail.GoodsCodeScaner_byFozzi,10,5)'
                                                   +' else SUBSTR(GoodsProperty_Detail.GoodsCodeScaner_byFozzi,9,6) end as Article5');
        Add('     , null as BarCodeGLN5');
        Add('     , null as ArticleGLN5');
        Add('     , PG5.Id_Postgres as GoodsPropertyId5');
        Add('     , GoodsProperty.Id_Postgres as GoodsId5');
        Add('     , KindPackage.Id_Postgres as GoodsKindId5');
        Add('     , GoodsProperty_Detail.Id5_Postgres as Id_Postgres5');
        //---------------------------6
        Add('     , case when trim (GoodsProperty_Detail.GoodsCodeScaner_byKisheni)<>'+FormatToVarCharServer_notNULL('')+'  then zc_rvYes() else zc_rvNo() end as is6');
        Add('     , null as ObjectName6');
        Add('     , case when is6=zc_rvNo() then cast (null as TSumm) when GoodsProperty.MeasureId = zc_measure_Sht() then SUBSTR(GoodsProperty_Detail.GoodsCodeScaner_byKisheni,15,2) else cast (null as TSumm) end as Amount6');
        Add('     , case when is6=zc_rvNo() then null when GoodsProperty.MeasureId = zc_measure_Sht() then SUBSTR(GoodsProperty_Detail.GoodsCodeScaner_byKisheni,1,13) else SUBSTR(GoodsProperty_Detail.GoodsCodeScaner_byKisheni,1,13) end as BarCode6');
        Add('     , case when is6=zc_rvNo() then null when GoodsProperty.MeasureId = zc_measure_Sht() then SUBSTR(GoodsProperty_Detail.GoodsCodeScaner_byKisheni,18,7)'
                                                   +' when LENGTH (GoodsProperty_Detail.GoodsCodeScaner_byKisheni) = 24 then case when SUBSTR(GoodsProperty_Detail.GoodsCodeScaner_byKisheni,18,1)='+FormatToVarCharServer_notNULL('0')+' then SUBSTR(GoodsProperty_Detail.GoodsCodeScaner_byKisheni,19,6) else SUBSTR(GoodsProperty_Detail.GoodsCodeScaner_byKisheni,18,7) end'
                                                   +' when SUBSTR(GoodsProperty_Detail.GoodsCodeScaner_byKisheni,15,2)='+FormatToVarCharServer_notNULL('00')+' then SUBSTR(GoodsProperty_Detail.GoodsCodeScaner_byKisheni,17,5)'
                                                   +' when SUBSTR(GoodsProperty_Detail.GoodsCodeScaner_byKisheni,15,1)='+FormatToVarCharServer_notNULL('0')+' then SUBSTR(GoodsProperty_Detail.GoodsCodeScaner_byKisheni,16,6)'
                                                   +' else SUBSTR(GoodsProperty_Detail.GoodsCodeScaner_byKisheni,15,7) end as Article6');
        Add('     , null as BarCodeGLN6');
        Add('     , null as ArticleGLN6');
        Add('     , PG6.Id_Postgres as GoodsPropertyId6');
        Add('     , GoodsProperty.Id_Postgres as GoodsId6');
        Add('     , KindPackage.Id_Postgres as GoodsKindId6');
        Add('     , GoodsProperty_Detail.Id6_Postgres as Id_Postgres6');
        //---------------------------7
        Add('     , case when trim (GoodsProperty_Detail.GoodsCodeScaner_byVivat)<>'+FormatToVarCharServer_notNULL('')+'  then zc_rvYes() else zc_rvNo() end as is7');
        Add('     , null as ObjectName7');
        Add('     , case when is7=zc_rvNo() then cast (null as TSumm) when GoodsProperty.MeasureId = zc_measure_Sht() then SUBSTR(GoodsProperty_Detail.GoodsCodeScaner_byVivat,15,2) else cast (null as TSumm) end as Amount7');
        Add('     , case when is7=zc_rvNo() then null when GoodsProperty.MeasureId = zc_measure_Sht() then SUBSTR(GoodsProperty_Detail.GoodsCodeScaner_byVivat,1,13) else SUBSTR(GoodsProperty_Detail.GoodsCodeScaner_byVivat,1,13) end as BarCode7');
        Add('     , case when is7=zc_rvNo() then null when GoodsProperty.MeasureId = zc_measure_Sht() and SUBSTR(GoodsProperty_Detail.GoodsCodeScaner_byVivat,18,7) <> '+FormatToVarCharServer_notNULL('0000000')+' then SUBSTR(GoodsProperty_Detail.GoodsCodeScaner_byVivat,18,7)'
                                                   +' when GoodsProperty.MeasureId = zc_measure_Sht() then '+FormatToVarCharServer_notNULL('')
                                                   +' when SUBSTR(GoodsProperty_Detail.GoodsCodeScaner_byVivat,15,1)='+FormatToVarCharServer_notNULL('0')+' then SUBSTR(GoodsProperty_Detail.GoodsCodeScaner_byVivat,16,6)'
                                                   +' else SUBSTR(GoodsProperty_Detail.GoodsCodeScaner_byVivat,15,7) end as Article7');
        Add('     , null as BarCodeGLN7');
        Add('     , null as ArticleGLN7');
        Add('     , PG7.Id_Postgres as GoodsPropertyId7');
        Add('     , GoodsProperty.Id_Postgres as GoodsId7');
        Add('     , KindPackage.Id_Postgres as GoodsKindId7');
        Add('     , GoodsProperty_Detail.Id7_Postgres as Id_Postgres7');

        Add('from dba.GoodsProperty_Detail');
        Add('     left outer join dba.GoodsProperty on GoodsProperty.Id=GoodsProperty_Detail.GoodsPropertyId');
        Add('     left outer join dba.KindPackage on KindPackage.Id=GoodsProperty_Detail.KindPackageId');
        Add('     left outer join dba.GoodsProperty_Postgres as PG1 on PG1.Id=1');
        Add('     left outer join dba.GoodsProperty_Postgres as PG2 on PG2.Id=2');
        Add('     left outer join dba.GoodsProperty_Postgres as PG3 on PG3.Id=3');
        Add('     left outer join dba.GoodsProperty_Postgres as PG4 on PG4.Id=4');
        Add('     left outer join dba.GoodsProperty_Postgres as PG5 on PG5.Id=5');
        Add('     left outer join dba.GoodsProperty_Postgres as PG6 on PG6.Id=6');
        Add('     left outer join dba.GoodsProperty_Postgres as PG7 on PG7.Id=7');
        Add('     left outer join dba.GoodsProperty_Postgres as PG8 on PG8.Id=8');
        Add('     left outer join dba.GoodsProperty_Postgres as PG9 on PG9.Id=9');
        Add('     left outer join dba.GoodsProperty_Postgres as PG10 on PG10.Id=10');
        Add('     left outer join dba.GoodsProperty_Postgres as PG11 on PG11.Id=11');
        Add('     left outer join dba.GoodsProperty_Postgres as PG12 on PG12.Id=12');
        Add('     left outer join dba.GoodsProperty_Postgres as PG13 on PG13.Id=13');
        Add('     left outer join dba.GoodsProperty_Postgres as PG14 on PG14.Id=14');
        Add('where is1=zc_rvYes()'
             +' or is2=zc_rvYes()'
             +' or is3=zc_rvYes()'
             +' or is4=zc_rvYes()'
             +' or is5=zc_rvYes()'
             +' or is6=zc_rvYes()'
             +' or is7=zc_rvYes()'
           );
        Add('order by is7, BarCode7, ObjectId');
        Open;
        //
        fStop:=cbOnlyOpen.Checked;
        if cbOnlyOpen.Checked then exit;
        //
        Gauge.Progress:=0;
        Gauge.MaxValue:=RecordCount;
        //
        toStoredProc.StoredProcName:='gpinsertupdate_object_goodspropertyvalue';
        toStoredProc.OutputType := otResult;
        toStoredProc.Params.Clear;
        toStoredProc.Params.AddParam ('ioId',ftInteger,ptInputOutput, 0);
        toStoredProc.Params.AddParam ('inName',ftString,ptInput, '');
        toStoredProc.Params.AddParam ('inAmount',ftFloat,ptInput, 0);
        toStoredProc.Params.AddParam ('inBarCode',ftString,ptInput, '');
        toStoredProc.Params.AddParam ('inArticle',ftString,ptInput, '');
        toStoredProc.Params.AddParam ('inBarCodeGLN',ftString,ptInput, '');
        toStoredProc.Params.AddParam ('inArticleGLN',ftString,ptInput, '');
        toStoredProc.Params.AddParam ('inGoodsPropertyId',ftInteger,ptInput, 0);
        toStoredProc.Params.AddParam ('inGoodsId',ftInteger,ptInput, 0);
        toStoredProc.Params.AddParam ('inGoodsKindId',ftInteger,ptInput, 0);
        //
        while not EOF do
        begin
             //!!!
             if fStop then begin exit;end;
             //
             // 1
             if FieldByName('is1').AsInteger=FieldByName('zc_rvYes').AsInteger
             then begin
                       toStoredProc.Params.ParamByName('ioId').Value:=FieldByName('Id_Postgres1').AsInteger;
                       toStoredProc.Params.ParamByName('inName').Value:=FieldByName('ObjectName1').AsString;
                       toStoredProc.Params.ParamByName('inAmount').Value:=FieldByName('Amount1').AsFloat;
                       toStoredProc.Params.ParamByName('inBarCode').Value:=FieldByName('BarCode1').AsString;
                       toStoredProc.Params.ParamByName('inArticle').Value:=FieldByName('Article1').AsString;
                       toStoredProc.Params.ParamByName('inBarCodeGLN').Value:=FieldByName('BarCodeGLN1').AsString;
                       toStoredProc.Params.ParamByName('inArticleGLN').Value:=FieldByName('ArticleGLN1').AsString;
                       toStoredProc.Params.ParamByName('inGoodsPropertyId').Value:=FieldByName('GoodsPropertyId1').AsInteger;
                       toStoredProc.Params.ParamByName('inGoodsId').Value:=FieldByName('GoodsId1').AsInteger;
                       toStoredProc.Params.ParamByName('inGoodsKindId').Value:=FieldByName('GoodsKindId1').AsInteger;
                       //toStoredProc.Params.ParamByName('inSession').Value:=fGetSession;
                       if not myExecToStoredProc then ;//exit;
                       //
                       if (1=0)or(FieldByName('Id_Postgres1').AsInteger=0)
                       then fExecSqFromQuery('update dba.GoodsProperty_Detail set Id1_Postgres='+IntToStr(toStoredProc.Params.ParamByName('ioId').Value)+' where Id = '+FieldByName('ObjectId').AsString);
                  end;
             // 2
             if FieldByName('is2').AsInteger=FieldByName('zc_rvYes').AsInteger
             then begin
                       toStoredProc.Params.ParamByName('ioId').Value:=FieldByName('Id_Postgres2').AsInteger;
                       toStoredProc.Params.ParamByName('inName').Value:=FieldByName('ObjectName2').AsString;
                       toStoredProc.Params.ParamByName('inAmount').Value:=FieldByName('Amount2').AsFloat;
                       toStoredProc.Params.ParamByName('inBarCode').Value:=FieldByName('BarCode2').AsString;
                       toStoredProc.Params.ParamByName('inArticle').Value:=FieldByName('Article2').AsString;
                       toStoredProc.Params.ParamByName('inBarCodeGLN').Value:=FieldByName('BarCodeGLN2').AsString;
                       toStoredProc.Params.ParamByName('inArticleGLN').Value:=FieldByName('ArticleGLN2').AsString;
                       toStoredProc.Params.ParamByName('inGoodsPropertyId').Value:=FieldByName('GoodsPropertyId2').AsInteger;
                       toStoredProc.Params.ParamByName('inGoodsId').Value:=FieldByName('GoodsId2').AsInteger;
                       toStoredProc.Params.ParamByName('inGoodsKindId').Value:=FieldByName('GoodsKindId2').AsInteger;
                       //toStoredProc.Params.ParamByName('inSession').Value:=fGetSession;
                       if not myExecToStoredProc then ;//exit;
                       //
                       if (1=0)or(FieldByName('Id_Postgres2').AsInteger=0)
                       then fExecSqFromQuery('update dba.GoodsProperty_Detail set Id2_Postgres='+IntToStr(toStoredProc.Params.ParamByName('ioId').Value)+' where Id = '+FieldByName('ObjectId').AsString);
                  end;
             // 3
             if FieldByName('is3').AsInteger=FieldByName('zc_rvYes').AsInteger
             then begin
                       toStoredProc.Params.ParamByName('ioId').Value:=FieldByName('Id_Postgres3').AsInteger;
                       toStoredProc.Params.ParamByName('inName').Value:=FieldByName('ObjectName3').AsString;
                       toStoredProc.Params.ParamByName('inAmount').Value:=FieldByName('Amount3').AsFloat;
                       toStoredProc.Params.ParamByName('inBarCode').Value:=FieldByName('BarCode3').AsString;
                       toStoredProc.Params.ParamByName('inArticle').Value:=FieldByName('Article3').AsString;
                       toStoredProc.Params.ParamByName('inBarCodeGLN').Value:=FieldByName('BarCodeGLN3').AsString;
                       toStoredProc.Params.ParamByName('inArticleGLN').Value:=FieldByName('ArticleGLN3').AsString;
                       toStoredProc.Params.ParamByName('inGoodsPropertyId').Value:=FieldByName('GoodsPropertyId3').AsInteger;
                       toStoredProc.Params.ParamByName('inGoodsId').Value:=FieldByName('GoodsId3').AsInteger;
                       toStoredProc.Params.ParamByName('inGoodsKindId').Value:=FieldByName('GoodsKindId3').AsInteger;
                       //toStoredProc.Params.ParamByName('inSession').Value:=fGetSession;
                       if not myExecToStoredProc then ;//exit;
                       //
                       if (1=0)or(FieldByName('Id_Postgres3').AsInteger=0)
                       then fExecSqFromQuery('update dba.GoodsProperty_Detail set Id3_Postgres='+IntToStr(toStoredProc.Params.ParamByName('ioId').Value)+' where Id = '+FieldByName('ObjectId').AsString);
                  end;
             // 4
             if FieldByName('is4').AsInteger=FieldByName('zc_rvYes').AsInteger
             then begin
                       toStoredProc.Params.ParamByName('ioId').Value:=FieldByName('Id_Postgres4').AsInteger;
                       toStoredProc.Params.ParamByName('inName').Value:=FieldByName('ObjectName4').AsString;
                       toStoredProc.Params.ParamByName('inAmount').Value:=FieldByName('Amount4').AsFloat;
                       toStoredProc.Params.ParamByName('inBarCode').Value:=FieldByName('BarCode4').AsString;
                       toStoredProc.Params.ParamByName('inArticle').Value:=FieldByName('Article4').AsString;
                       toStoredProc.Params.ParamByName('inBarCodeGLN').Value:=FieldByName('BarCodeGLN4').AsString;
                       toStoredProc.Params.ParamByName('inArticleGLN').Value:=FieldByName('ArticleGLN4').AsString;
                       toStoredProc.Params.ParamByName('inGoodsPropertyId').Value:=FieldByName('GoodsPropertyId4').AsInteger;
                       toStoredProc.Params.ParamByName('inGoodsId').Value:=FieldByName('GoodsId4').AsInteger;
                       toStoredProc.Params.ParamByName('inGoodsKindId').Value:=FieldByName('GoodsKindId4').AsInteger;
                       //toStoredProc.Params.ParamByName('inSession').Value:=fGetSession;
                       if not myExecToStoredProc then ;//exit;
                       //
                       if (1=0)or(FieldByName('Id_Postgres4').AsInteger=0)
                       then fExecSqFromQuery('update dba.GoodsProperty_Detail set Id4_Postgres='+IntToStr(toStoredProc.Params.ParamByName('ioId').Value)+' where Id = '+FieldByName('ObjectId').AsString);
                  end;
             // 5
             if FieldByName('is5').AsInteger=FieldByName('zc_rvYes').AsInteger
             then begin
                       toStoredProc.Params.ParamByName('ioId').Value:=FieldByName('Id_Postgres5').AsInteger;
                       toStoredProc.Params.ParamByName('inName').Value:=FieldByName('ObjectName5').AsString;
                       toStoredProc.Params.ParamByName('inAmount').Value:=FieldByName('Amount5').AsFloat;
                       toStoredProc.Params.ParamByName('inBarCode').Value:=FieldByName('BarCode5').AsString;
                       toStoredProc.Params.ParamByName('inArticle').Value:=FieldByName('Article5').AsString;
                       toStoredProc.Params.ParamByName('inBarCodeGLN').Value:=FieldByName('BarCodeGLN5').AsString;
                       toStoredProc.Params.ParamByName('inArticleGLN').Value:=FieldByName('ArticleGLN5').AsString;
                       toStoredProc.Params.ParamByName('inGoodsPropertyId').Value:=FieldByName('GoodsPropertyId5').AsInteger;
                       toStoredProc.Params.ParamByName('inGoodsId').Value:=FieldByName('GoodsId5').AsInteger;
                       toStoredProc.Params.ParamByName('inGoodsKindId').Value:=FieldByName('GoodsKindId5').AsInteger;
                       //toStoredProc.Params.ParamByName('inSession').Value:=fGetSession;
                       if not myExecToStoredProc then ;//exit;
                       //
                       if (1=0)or(FieldByName('Id_Postgres5').AsInteger=0)
                       then fExecSqFromQuery('update dba.GoodsProperty_Detail set Id5_Postgres='+IntToStr(toStoredProc.Params.ParamByName('ioId').Value)+' where Id = '+FieldByName('ObjectId').AsString);
                  end;
             // 6
             if FieldByName('is6').AsInteger=FieldByName('zc_rvYes').AsInteger
             then begin
                       toStoredProc.Params.ParamByName('ioId').Value:=FieldByName('Id_Postgres6').AsInteger;
                       toStoredProc.Params.ParamByName('inName').Value:=FieldByName('ObjectName6').AsString;
                       toStoredProc.Params.ParamByName('inAmount').Value:=FieldByName('Amount6').AsFloat;
                       toStoredProc.Params.ParamByName('inBarCode').Value:=FieldByName('BarCode6').AsString;
                       toStoredProc.Params.ParamByName('inArticle').Value:=FieldByName('Article6').AsString;
                       toStoredProc.Params.ParamByName('inBarCodeGLN').Value:=FieldByName('BarCodeGLN6').AsString;
                       toStoredProc.Params.ParamByName('inArticleGLN').Value:=FieldByName('ArticleGLN6').AsString;
                       toStoredProc.Params.ParamByName('inGoodsPropertyId').Value:=FieldByName('GoodsPropertyId6').AsInteger;
                       toStoredProc.Params.ParamByName('inGoodsId').Value:=FieldByName('GoodsId6').AsInteger;
                       toStoredProc.Params.ParamByName('inGoodsKindId').Value:=FieldByName('GoodsKindId6').AsInteger;
                       //toStoredProc.Params.ParamByName('inSession').Value:=fGetSession;
                       if not myExecToStoredProc then ;//exit;
                       //
                       if (1=0)or(FieldByName('Id_Postgres6').AsInteger=0)
                       then fExecSqFromQuery('update dba.GoodsProperty_Detail set Id6_Postgres='+IntToStr(toStoredProc.Params.ParamByName('ioId').Value)+' where Id = '+FieldByName('ObjectId').AsString);
                  end;
             // 7
             if FieldByName('is7').AsInteger=FieldByName('zc_rvYes').AsInteger
             then begin
                       toStoredProc.Params.ParamByName('ioId').Value:=FieldByName('Id_Postgres7').AsInteger;
                       toStoredProc.Params.ParamByName('inName').Value:=FieldByName('ObjectName7').AsString;
                       toStoredProc.Params.ParamByName('inAmount').Value:=FieldByName('Amount7').AsFloat;
                       toStoredProc.Params.ParamByName('inBarCode').Value:=FieldByName('BarCode7').AsString;
                       toStoredProc.Params.ParamByName('inArticle').Value:=FieldByName('Article7').AsString;
                       toStoredProc.Params.ParamByName('inBarCodeGLN').Value:=FieldByName('BarCodeGLN7').AsString;
                       toStoredProc.Params.ParamByName('inArticleGLN').Value:=FieldByName('ArticleGLN7').AsString;
                       toStoredProc.Params.ParamByName('inGoodsPropertyId').Value:=FieldByName('GoodsPropertyId7').AsInteger;
                       toStoredProc.Params.ParamByName('inGoodsId').Value:=FieldByName('GoodsId7').AsInteger;
                       toStoredProc.Params.ParamByName('inGoodsKindId').Value:=FieldByName('GoodsKindId7').AsInteger;
                       //toStoredProc.Params.ParamByName('inSession').Value:=fGetSession;
                       if not myExecToStoredProc then ;//exit;
                       //
                       if (1=0)or(FieldByName('Id_Postgres7').AsInteger=0)
                       then fExecSqFromQuery('update dba.GoodsProperty_Detail set Id7_Postgres='+IntToStr(toStoredProc.Params.ParamByName('ioId').Value)+' where Id = '+FieldByName('ObjectId').AsString);
                  end;
             //
             Next;
             Application.ProcessMessages;
             Gauge.Progress:=Gauge.Progress+1;
             Application.ProcessMessages;
        end;
        //EnableControls;
     end;
     //
     myDisabledCB(cbGoodsPropertyValue);
end;
//----------------------------------------------------------------------------------------------------------------------------------------------------
procedure TMainForm.pLoadGuide_InfoMoneyGroup;
begin
     if (not cbInfoMoneyGroup.Checked)or(not cbInfoMoneyGroup.Enabled) then exit;
     //
     myEnabledCB(cbInfoMoneyGroup);
     //
     with fromQuery,Sql do begin
        Close;
        Clear;
        Add('select min(Id) as ObjectId');
        Add('     , min(_pgInfoMoney.ObjectCode) - 101 as ObjectCode');
        Add('     , _pgInfoMoney.Name1 as ObjectName');
        Add('     , max (isnull (_pgInfoMoney.Id1_Postgres, 0)) as Id_Postgres');
        Add('from dba._pgInfoMoney');
        Add('group by ObjectName');
        Add('order by ObjectCode');
        Open;
        //
        fStop:=cbOnlyOpen.Checked;
        if cbOnlyOpen.Checked then exit;
        //
        Gauge.Progress:=0;
        Gauge.MaxValue:=RecordCount;
        //
        toStoredProc.StoredProcName:='gpinsertupdate_object_infomoneygroup';
        toStoredProc.OutputType := otResult;
        toStoredProc.Params.Clear;
        toStoredProc.Params.AddParam ('ioId',ftInteger,ptInputOutput, 0);
        toStoredProc.Params.AddParam ('inCode',ftInteger,ptInput, 0);
        toStoredProc.Params.AddParam ('inName',ftString,ptInput, '');
        //
        while not EOF do
        begin
             //!!!
             if fStop then begin exit;end;
             //
             toStoredProc.Params.ParamByName('ioId').Value:=FieldByName('Id_Postgres').AsInteger;
             toStoredProc.Params.ParamByName('inCode').Value:=FieldByName('ObjectCode').AsInteger;
             toStoredProc.Params.ParamByName('inName').Value:=FieldByName('ObjectName').AsString;
             //toStoredProc.Params.ParamByName('inSession').Value:=fGetSession;
             if not myExecToStoredProc then ;//exit;
             //
             if (1=1)or(FieldByName('Id_Postgres').AsInteger=0)
             then fExecSqFromQuery('update dba._pgInfoMoney set Id1_Postgres='+IntToStr(toStoredProc.Params.ParamByName('ioId').Value)+' where Name1 in (select Name1 from dba._pgInfoMoney where Id = '+FieldByName('ObjectId').AsString+')');
             //
             Next;
             Application.ProcessMessages;
             Gauge.Progress:=Gauge.Progress+1;
             Application.ProcessMessages;
        end;
        //EnableControls;
     end;
     //
     myDisabledCB(cbInfoMoneyGroup);
end;
//----------------------------------------------------------------------------------------------------------------------------------------------------
procedure TMainForm.pLoadGuide_InfoMoneyDestination;
begin
     if (not cbInfoMoneyDestination.Checked)or(not cbInfoMoneyDestination.Enabled) then exit;
     //
     myEnabledCB(cbInfoMoneyDestination);
     //
     with fromQuery,Sql do begin
        Close;
        Clear;
        Add('select min(Id) as ObjectId');
        Add('     , min(_pgInfoMoney.ObjectCode) - 1 as ObjectCode');
        Add('     , _pgInfoMoney.Name2 as ObjectName');
        Add('     , max (isnull (_pgInfoMoney.Id2_Postgres, 0)) as Id_Postgres');
        Add('from dba._pgInfoMoney');
        Add('group by ObjectName, _pgInfoMoney.Name1');
        Add('order by ObjectCode');
        Open;
        //
        fStop:=cbOnlyOpen.Checked;
        if cbOnlyOpen.Checked then exit;
        //
        Gauge.Progress:=0;
        Gauge.MaxValue:=RecordCount;
        //
        toStoredProc.StoredProcName:='gpinsertupdate_object_infomoneydestination';
        toStoredProc.OutputType := otResult;
        toStoredProc.Params.Clear;
        toStoredProc.Params.AddParam ('ioId',ftInteger,ptInputOutput, 0);
        toStoredProc.Params.AddParam ('inCode',ftInteger,ptInput, 0);
        toStoredProc.Params.AddParam ('inName',ftString,ptInput, '');
        //
        while not EOF do
        begin
             //!!!
             if fStop then begin exit;end;
             //
             toStoredProc.Params.ParamByName('ioId').Value:=FieldByName('Id_Postgres').AsInteger;
             toStoredProc.Params.ParamByName('inCode').Value:=FieldByName('ObjectCode').AsInteger;
             toStoredProc.Params.ParamByName('inName').Value:=FieldByName('ObjectName').AsString;
             //toStoredProc.Params.ParamByName('inSession').Value:=fGetSession;
             if not myExecToStoredProc then ;//exit;
             //
             if (1=1)or(FieldByName('Id_Postgres').AsInteger=0)
             then fExecSqFromQuery('update dba._pgInfoMoney set Id2_Postgres='+IntToStr(toStoredProc.Params.ParamByName('ioId').Value)+' where Name1 in (select Name1 from dba._pgInfoMoney where Id = '+FieldByName('ObjectId').AsString+')'
                                                                                                                                      +'   and Name2 in (select Name2 from dba._pgInfoMoney where Id = '+FieldByName('ObjectId').AsString+')'
                                  );
             //
             Next;
             Application.ProcessMessages;
             Gauge.Progress:=Gauge.Progress+1;
             Application.ProcessMessages;
        end;
        //EnableControls;
     end;
     //
     myDisabledCB(cbInfoMoneyDestination);
end;
//----------------------------------------------------------------------------------------------------------------------------------------------------
procedure TMainForm.pLoadGuide_InfoMoney;
begin
     if (not cbInfoMoney.Checked)or(not cbInfoMoney.Enabled) then exit;
     //
     myEnabledCB(cbInfoMoney);
     //
     with fromQuery,Sql do begin
        Close;
        Clear;
        Add('select _pgInfoMoney.Id as ObjectId');
        Add('     , _pgInfoMoney.ObjectCode as ObjectCode');
        Add('     , _pgInfoMoney.Name3 as ObjectName');
        Add('     , _pgInfoMoney.Id1_Postgres as InfoMoneyGroupId_PG');
        Add('     , _pgInfoMoney.Id2_Postgres as InfoMoneyDestinationId_PG');
        Add('     , _pgInfoMoney.Id3_Postgres as Id_Postgres');
        Add('from dba._pgInfoMoney');
        Add('order by ObjectCode');
        Open;
        //
        fStop:=cbOnlyOpen.Checked;
        if cbOnlyOpen.Checked then exit;
        //
        Gauge.Progress:=0;
        Gauge.MaxValue:=RecordCount;
        //
        toStoredProc.StoredProcName:='gpinsertupdate_object_infomoney';
        toStoredProc.OutputType := otResult;
        toStoredProc.Params.Clear;
        toStoredProc.Params.AddParam ('ioId',ftInteger,ptInputOutput, 0);
        toStoredProc.Params.AddParam ('inCode',ftInteger,ptInput, 0);
        toStoredProc.Params.AddParam ('inName',ftString,ptInput, '');
        toStoredProc.Params.AddParam ('inInfoMoneyGroupId',ftInteger,ptInput, 0);
        toStoredProc.Params.AddParam ('inInfoMoneyDestinationId',ftInteger,ptInput, 0);
        //
        while not EOF do
        begin
             //!!!
             if fStop then begin exit;end;
             //
             toStoredProc.Params.ParamByName('ioId').Value:=FieldByName('Id_Postgres').AsInteger;
             toStoredProc.Params.ParamByName('inCode').Value:=FieldByName('ObjectCode').AsInteger;
             toStoredProc.Params.ParamByName('inName').Value:=FieldByName('ObjectName').AsString;
             toStoredProc.Params.ParamByName('inInfoMoneyGroupId').Value:=FieldByName('InfoMoneyGroupId_PG').AsInteger;
             toStoredProc.Params.ParamByName('inInfoMoneyDestinationId').Value:=FieldByName('InfoMoneyDestinationId_PG').AsInteger;
             //toStoredProc.Params.ParamByName('inSession').Value:=fGetSession;
             if not myExecToStoredProc then ;//exit;
             //
             if (1=0)or(FieldByName('Id_Postgres').AsInteger=0)
             then fExecSqFromQuery('update dba._pgInfoMoney set Id3_Postgres='+IntToStr(toStoredProc.Params.ParamByName('ioId').Value)+' where Id = '+FieldByName('ObjectId').AsString);
             //
             Next;
             Application.ProcessMessages;
             Gauge.Progress:=Gauge.Progress+1;
             Application.ProcessMessages;
        end;
        //EnableControls;
     end;
     //
     myDisabledCB(cbInfoMoney);
end;
//----------------------------------------------------------------------------------------------------------------------------------------------------
procedure TMainForm.pLoadGuide_AccountGroup;
begin
     if (not cbAccountGroup.Checked)or(not cbAccountGroup.Enabled) then exit;
     //
     myEnabledCB(cbAccountGroup);
     //
     with fromQuery,Sql do begin
        Close;
        Clear;
        Add('select min(Id) as ObjectId');
        Add('     , min(_pgAccount.ObjectCode) - 101 as ObjectCode');
        Add('     , _pgAccount.Name1 as ObjectName');
        Add('     , max (isnull (_pgAccount.Id1_Postgres, 0)) as Id_Postgres');
        Add('from dba._pgAccount');
        Add('group by ObjectName');
        Add('order by ObjectCode');
        Open;
        //
        fStop:=cbOnlyOpen.Checked;
        if cbOnlyOpen.Checked then exit;
        //
        Gauge.Progress:=0;
        Gauge.MaxValue:=RecordCount;
        //
        toStoredProc.StoredProcName:='gpinsertupdate_object_accountgroup';
        toStoredProc.OutputType := otResult;
        toStoredProc.Params.Clear;
        toStoredProc.Params.AddParam ('ioId',ftInteger,ptInputOutput, 0);
        toStoredProc.Params.AddParam ('inCode',ftInteger,ptInput, 0);
        toStoredProc.Params.AddParam ('inName',ftString,ptInput, '');
        //
        while not EOF do
        begin
             //!!!
             if fStop then begin exit;end;
             //
             toStoredProc.Params.ParamByName('ioId').Value:=FieldByName('Id_Postgres').AsInteger;
             toStoredProc.Params.ParamByName('inCode').Value:=FieldByName('ObjectCode').AsInteger;
             toStoredProc.Params.ParamByName('inName').Value:=FieldByName('ObjectName').AsString;
             if not myExecToStoredProc then ;//exit;
             //
             if (1=0)or(FieldByName('Id_Postgres').AsInteger=0)
             then fExecSqFromQuery('update dba._pgAccount set Id1_Postgres='+IntToStr(toStoredProc.Params.ParamByName('ioId').Value)+' where Name1 in (select Name1 from dba._pgAccount where Id = '+FieldByName('ObjectId').AsString+')');
             //
             Next;
             Application.ProcessMessages;
             Gauge.Progress:=Gauge.Progress+1;
             Application.ProcessMessages;
        end;
        //EnableControls;
     end;
     //
     myDisabledCB(cbAccountGroup);
end;
//----------------------------------------------------------------------------------------------------------------------------------------------------
procedure TMainForm.pLoadGuide_AccountDirection;
begin
     if (not cbAccountDirection.Checked)or(not cbAccountDirection.Enabled) then exit;
     //
     myEnabledCB(cbAccountDirection);
     //
     with fromQuery,Sql do begin
        Close;
        Clear;
        Add('select min(Id) as ObjectId');
        Add('     , min(_pgAccount.ObjectCode) - 1 as ObjectCode');
        Add('     , _pgAccount.Name2 as ObjectName');
        Add('     , max (isnull (_pgAccount.Id2_Postgres, 0)) as Id_Postgres');
        Add('from dba._pgAccount');
        Add('group by ObjectName, _pgAccount.Name1');
        Add('order by ObjectCode');
        Open;
        //
        fStop:=cbOnlyOpen.Checked;
        if cbOnlyOpen.Checked then exit;
        //
        Gauge.Progress:=0;
        Gauge.MaxValue:=RecordCount;
        //
        toStoredProc.StoredProcName:='gpinsertupdate_object_accountdirection';
        toStoredProc.OutputType := otResult;
        toStoredProc.Params.Clear;
        toStoredProc.Params.AddParam ('ioId',ftInteger,ptInputOutput, 0);
        toStoredProc.Params.AddParam ('inCode',ftInteger,ptInput, 0);
        toStoredProc.Params.AddParam ('inName',ftString,ptInput, '');
        //
        while not EOF do
        begin
             //!!!
             if fStop then begin exit;end;
             //
             toStoredProc.Params.ParamByName('ioId').Value:=FieldByName('Id_Postgres').AsInteger;
             toStoredProc.Params.ParamByName('inCode').Value:=FieldByName('ObjectCode').AsInteger;
             toStoredProc.Params.ParamByName('inName').Value:=FieldByName('ObjectName').AsString;
             //toStoredProc.Params.ParamByName('inSession').Value:=fGetSession;
             if not myExecToStoredProc then ;//exit;
             //
             if (1=0)or(FieldByName('Id_Postgres').AsInteger=0)
             then fExecSqFromQuery('update dba._pgAccount set Id2_Postgres='+IntToStr(toStoredProc.Params.ParamByName('ioId').Value)+' where Name1 in (select Name1 from dba._pgAccount where Id = '+FieldByName('ObjectId').AsString+')'
                                                                                                                                    +'   and Name2 in (select Name2 from dba._pgAccount where Id = '+FieldByName('ObjectId').AsString+')'
                                  );
             //
             Next;
             Application.ProcessMessages;
             Gauge.Progress:=Gauge.Progress+1;
             Application.ProcessMessages;
        end;
        //EnableControls;
     end;
     //
     myDisabledCB(cbAccountDirection);
end;
//----------------------------------------------------------------------------------------------------------------------------------------------------
procedure TMainForm.pLoadGuide_Account;
begin
     if (not cbAccount.Checked)or(not cbAccount.Enabled) then exit;
     //
     myEnabledCB(cbAccount);
     //
     with fromQuery,Sql do begin
        Close;
        Clear;
        Add('select _pgAccount.Id as ObjectId');
        Add('     , _pgAccount.ObjectCode as ObjectCode');
        Add('     , _pgAccount.Name3 as ObjectName');
        Add('     , _pgAccount.Id1_Postgres as AccountGroupId_PG');
        Add('     , _pgAccount.Id2_Postgres as AccountDirectionId_PG');
        Add('     , isnull(_pgInfoMoney_30201.Id2_Postgres, (select max (isnull (_pgInfoMoney.Id2_Postgres, 0)) from dba._pgInfoMoney where _pgInfoMoney.ObjectCode <> 30201 and _pgInfoMoney.Name2 = _pgAccount.Name3)) as InfoMoneyDestinationId_PG');
        Add('     , case when 1=1 then null when InfoMoneyDestinationId_PG is not null then null else (select max (isnull (_pgInfoMoney.Id3_Postgres, 0)) from dba._pgInfoMoney where _pgInfoMoney.Name3 = _pgAccount.Name3) end as InfoMoneyId_PG');
        Add('     , case when 1=1 then _pgAccount.Id3_Postgres else ObjectId end as Id_Postgres');
        Add('from dba._pgAccount');
        Add('     left outer join dba._pgInfoMoney as _pgInfoMoney_30201 on _pgInfoMoney_30201.ObjectCode = 30201 and _pgAccount.ObjectCode = 30101');
        Add('order by ObjectCode');
        Open;
        //
        fStop:=cbOnlyOpen.Checked;
        if cbOnlyOpen.Checked then exit;
        //
        Gauge.Progress:=0;
        Gauge.MaxValue:=RecordCount;
        //
        toStoredProc.StoredProcName:='gpinsertupdate_object_account';
        toStoredProc.OutputType := otResult;
        toStoredProc.Params.Clear;
        toStoredProc.Params.AddParam ('ioId',ftInteger,ptInputOutput, 0);
        toStoredProc.Params.AddParam ('inCode',ftInteger,ptInput, 0);
        toStoredProc.Params.AddParam ('inName',ftString,ptInput, '');
        toStoredProc.Params.AddParam ('inAccountGroupId',ftInteger,ptInput, 0);
        toStoredProc.Params.AddParam ('inAccountDirectionId',ftInteger,ptInput, 0);
        toStoredProc.Params.AddParam ('inInfoMoneyDestinationId',ftInteger,ptInput, 0);
        toStoredProc.Params.AddParam ('inInfoMoneyId',ftInteger,ptInput, 0);
        //
        while not EOF do
        begin
             //!!!
             if fStop then begin exit;end;
             //
             toStoredProc.Params.ParamByName('ioId').Value:=FieldByName('Id_Postgres').AsInteger;
             toStoredProc.Params.ParamByName('inCode').Value:=FieldByName('ObjectCode').AsInteger;
             toStoredProc.Params.ParamByName('inName').Value:=FieldByName('ObjectName').AsString;
             toStoredProc.Params.ParamByName('inAccountGroupId').Value:=FieldByName('AccountGroupId_PG').AsInteger;
             toStoredProc.Params.ParamByName('inAccountDirectionId').Value:=FieldByName('AccountDirectionId_PG').AsInteger;
             toStoredProc.Params.ParamByName('inInfoMoneyDestinationId').Value:=FieldByName('InfoMoneyDestinationId_PG').AsInteger;
             toStoredProc.Params.ParamByName('inInfoMoneyId').Value:=FieldByName('InfoMoneyId_PG').AsInteger;
             if not myExecToStoredProc then ;//exit;
             //
             if (1=0)or(FieldByName('Id_Postgres').AsInteger=0)
             then fExecSqFromQuery('update dba._pgAccount set Id3_Postgres='+IntToStr(toStoredProc.Params.ParamByName('ioId').Value)+' where Id = '+FieldByName('ObjectId').AsString);
             //
             Next;
             Application.ProcessMessages;
             Gauge.Progress:=Gauge.Progress+1;
             Application.ProcessMessages;
        end;
        //EnableControls;
     end;
     //
     myDisabledCB(cbAccount);
end;
//----------------------------------------------------------------------------------------------------------------------------------------------------
procedure TMainForm.pLoadGuide_ProfitLossGroup;
begin
     if (not cbProfitLossGroup.Checked)or(not cbProfitLossGroup.Enabled) then exit;
     //
     myEnabledCB(cbProfitLossGroup);
     //
     with fromQuery,Sql do begin
        Close;
        Clear;
        Add('select min(Id) as ObjectId');
        Add('     , min(_pgProfitLoss.ObjectCode) - 101 as ObjectCode');
        Add('     , _pgProfitLoss.Name1 as ObjectName');
        Add('     , max (isnull (_pgProfitLoss.Id1_Postgres, 0)) as Id_Postgres');
        Add('from dba._pgProfitLoss');
        Add('group by ObjectName');
        Add('order by ObjectCode');
        Open;
        //
        fStop:=cbOnlyOpen.Checked;
        if cbOnlyOpen.Checked then exit;
        //
        Gauge.Progress:=0;
        Gauge.MaxValue:=RecordCount;
        //
        toStoredProc.StoredProcName:='gpinsertupdate_object_profitlossgroup';
        toStoredProc.OutputType := otResult;
        toStoredProc.Params.Clear;
        toStoredProc.Params.AddParam ('ioId',ftInteger,ptInputOutput, 0);
        toStoredProc.Params.AddParam ('inCode',ftInteger,ptInput, 0);
        toStoredProc.Params.AddParam ('inName',ftString,ptInput, '');
        //
        while not EOF do
        begin
             //!!!
             if fStop then begin exit;end;
             //
             toStoredProc.Params.ParamByName('ioId').Value:=FieldByName('Id_Postgres').AsInteger;
             toStoredProc.Params.ParamByName('inCode').Value:=FieldByName('ObjectCode').AsInteger;
             toStoredProc.Params.ParamByName('inName').Value:=FieldByName('ObjectName').AsString;
             //toStoredProc.Params.ParamByName('inSession').Value:=fGetSession;
             if not myExecToStoredProc then ;//exit;
             //
             if (1=0)or(FieldByName('Id_Postgres').AsInteger=0)
             then fExecSqFromQuery('update dba._pgProfitLoss set Id1_Postgres='+IntToStr(toStoredProc.Params.ParamByName('ioId').Value)+' where Name1 in (select Name1 from dba._pgProfitLoss where Id = '+FieldByName('ObjectId').AsString+')');
             //
             Next;
             Application.ProcessMessages;
             Gauge.Progress:=Gauge.Progress+1;
             Application.ProcessMessages;
        end;
        //EnableControls;
     end;
     //
     myDisabledCB(cbProfitLossGroup);
end;
//----------------------------------------------------------------------------------------------------------------------------------------------------
procedure TMainForm.pLoadGuide_ProfitLossDirection;
begin
     if (not cbProfitLossDirection.Checked)or(not cbProfitLossDirection.Enabled) then exit;
     //
     myEnabledCB(cbProfitLossDirection);
     //
     with fromQuery,Sql do begin
        Close;
        Clear;
        Add('select min(Id) as ObjectId');
        Add('     , min(_pgProfitLoss.ObjectCode) - 1 as ObjectCode');
        Add('     , _pgProfitLoss.Name2 as ObjectName');
        Add('     , max (isnull (_pgProfitLoss.Id2_Postgres, 0)) as Id_Postgres');
        Add('from dba._pgProfitLoss');
        Add('group by ObjectName, _pgProfitLoss.Name1');
        Add('order by ObjectCode');
        Open;
        //
        fStop:=cbOnlyOpen.Checked;
        if cbOnlyOpen.Checked then exit;
        //
        Gauge.Progress:=0;
        Gauge.MaxValue:=RecordCount;
        //
        toStoredProc.StoredProcName:='gpinsertupdate_object_profitlossdirection';
        toStoredProc.OutputType := otResult;
        toStoredProc.Params.Clear;
        toStoredProc.Params.AddParam ('ioId',ftInteger,ptInputOutput, 0);
        toStoredProc.Params.AddParam ('inCode',ftInteger,ptInput, 0);
        toStoredProc.Params.AddParam ('inName',ftString,ptInput, '');
        //
        while not EOF do
        begin
             //!!!
             if fStop then begin exit;end;
             //
             toStoredProc.Params.ParamByName('ioId').Value:=FieldByName('Id_Postgres').AsInteger;
             toStoredProc.Params.ParamByName('inCode').Value:=FieldByName('ObjectCode').AsInteger;
             toStoredProc.Params.ParamByName('inName').Value:=FieldByName('ObjectName').AsString;
             //toStoredProc.Params.ParamByName('inSession').Value:=fGetSession;
             if not myExecToStoredProc then ;//exit;
             //
             if (1=0)or(FieldByName('Id_Postgres').AsInteger=0)
             then fExecSqFromQuery('update dba._pgProfitLoss set Id2_Postgres='+IntToStr(toStoredProc.Params.ParamByName('ioId').Value)+' where Name1 in (select Name1 from dba._pgProfitLoss where Id = '+FieldByName('ObjectId').AsString+')'
                                                                                                                                       +'   and Name2 in (select Name2 from dba._pgProfitLoss where Id = '+FieldByName('ObjectId').AsString+')'
                                  );
             //
             Next;
             Application.ProcessMessages;
             Gauge.Progress:=Gauge.Progress+1;
             Application.ProcessMessages;
        end;
        //EnableControls;
     end;
     //
     myDisabledCB(cbProfitLossDirection);
end;
//----------------------------------------------------------------------------------------------------------------------------------------------------
procedure TMainForm.pLoadGuide_ProfitLoss;
begin
     if (not cbProfitLoss.Checked)or(not cbProfitLoss.Enabled) then exit;
     //
     myEnabledCB(cbProfitLoss);
     //
     with fromQuery,Sql do begin
        Close;
        Clear;
        Add('select _pgProfitLoss.Id as ObjectId');
        Add('     , _pgProfitLoss.ObjectCode as ObjectCode');
        Add('     , _pgProfitLoss.Name3 as ObjectName');
        Add('     , _pgProfitLoss.Id1_Postgres as ProfitLossGroupId_PG');
        Add('     , _pgProfitLoss.Id2_Postgres as ProfitLossDirectionId_PG');
        Add('     , case when _pgProfitLoss.ObjectCode < 20000 then null ' + ' else isnull(_pgInfoMoney_30201.Id2_Postgres, (select max (isnull (_pgInfoMoney.Id2_Postgres, 0)) from dba._pgInfoMoney where _pgInfoMoney.ObjectCode <> 30201 and _pgInfoMoney.Name2 = _pgProfitLoss.Name3)) end as InfoMoneyDestinationId_PG');
        Add('     , case when _pgProfitLoss.ObjectCode < 20000 then null ' + ' else case when InfoMoneyDestinationId_PG is not null then null else (select max (isnull (_pgInfoMoney.Id3_Postgres, 0)) from dba._pgInfoMoney where _pgInfoMoney.Name3 = _pgProfitLoss.Name3) end end as InfoMoneyId_PG');
        Add('     , case when 1=1 then _pgProfitLoss.Id3_Postgres else ObjectId end as Id_Postgres');
        Add('from dba._pgProfitLoss');
        Add('     left outer join dba._pgInfoMoney as _pgInfoMoney_30201 on _pgInfoMoney_30201.ObjectCode = 30201 and _pgProfitLoss.ObjectCode = 70304');
        Add('order by ObjectCode');
        Open;
        //
        fStop:=cbOnlyOpen.Checked;
        if cbOnlyOpen.Checked then exit;
        //
        Gauge.Progress:=0;
        Gauge.MaxValue:=RecordCount;
        //
        toStoredProc.StoredProcName:='gpinsertupdate_object_profitloss';
        toStoredProc.OutputType := otResult;
        toStoredProc.Params.Clear;
        toStoredProc.Params.AddParam ('ioId',ftInteger,ptInputOutput, 0);
        toStoredProc.Params.AddParam ('inCode',ftInteger,ptInput, 0);
        toStoredProc.Params.AddParam ('inName',ftString,ptInput, '');
        toStoredProc.Params.AddParam ('inProfitLossGroupId',ftInteger,ptInput, 0);
        toStoredProc.Params.AddParam ('inProfitLossDirectionId',ftInteger,ptInput, 0);
        toStoredProc.Params.AddParam ('inInfoMoneyDestinationId',ftInteger,ptInput, 0);
        toStoredProc.Params.AddParam ('inInfoMoneyId',ftInteger,ptInput, 0);
        //
        while not EOF do
        begin
             //!!!
             if fStop then begin exit;end;
             //
             toStoredProc.Params.ParamByName('ioId').Value:=FieldByName('Id_Postgres').AsInteger;
             toStoredProc.Params.ParamByName('inCode').Value:=FieldByName('ObjectCode').AsInteger;
             toStoredProc.Params.ParamByName('inName').Value:=FieldByName('ObjectName').AsString;
             toStoredProc.Params.ParamByName('inProfitLossGroupId').Value:=FieldByName('ProfitLossGroupId_PG').AsInteger;
             toStoredProc.Params.ParamByName('inProfitLossDirectionId').Value:=FieldByName('ProfitLossDirectionId_PG').AsInteger;
             toStoredProc.Params.ParamByName('inInfoMoneyDestinationId').Value:=FieldByName('InfoMoneyDestinationId_PG').AsInteger;
             toStoredProc.Params.ParamByName('inInfoMoneyId').Value:=FieldByName('InfoMoneyId_PG').AsInteger;
             if not myExecToStoredProc then ;//exit;
             //
             if (1=0)or(FieldByName('Id_Postgres').AsInteger=0)
             then fExecSqFromQuery('update dba._pgProfitLoss set Id3_Postgres='+IntToStr(toStoredProc.Params.ParamByName('ioId').Value)+' where Id = '+FieldByName('ObjectId').AsString);
             //
             Next;
             Application.ProcessMessages;
             Gauge.Progress:=Gauge.Progress+1;
             Application.ProcessMessages;
        end;
        //EnableControls;
     end;
     //
     myDisabledCB(cbProfitLoss);
end;
//----------------------------------------------------------------------------------------------------------------------------------------------------
//----------------------------------------------------------------------------------------------------------------------------------------------------
//----------------------------------------------------------------------------------------------------------------------------------------------------
procedure TMainForm.pCompleteDocument_Income;
begin
     if (not cbCompleteIncome.Checked)or(not cbCompleteIncome.Enabled) then exit;
     //
     myEnabledCB(cbCompleteIncome);
     //
     with fromQuery,Sql do begin
        Close;
        Clear;
        Add('select Bill.Id as ObjectId');
        Add('     , Bill.BillNumber as InvNumber');
        Add('     , Bill.BillDate as OperDate');
        Add('     , Bill.Id_Postgres as Id_Postgres');
        Add('from dba.Bill');
        Add('where Bill.BillDate between '+FormatToDateServer_notNULL(StrToDate(StartDateCompleteEdit.Text))+' and '+FormatToDateServer_notNULL(StrToDate(EndDateCompleteEdit.Text))
           +'  and Id_Postgres is not null'
           +'  and Bill.BillKind=zc_bkIncomeToUnit()'
           );
        Add('order by ObjectId');
        Open;
        //
        fStop:=cbOnlyOpen.Checked;
        if cbOnlyOpen.Checked then exit;
        //
        Gauge.Progress:=0;
        Gauge.MaxValue:=RecordCount;
        //
        toStoredProc.StoredProcName:='gpUnComplete_Movement';
        toStoredProc.OutputType := otResult;
        toStoredProc.Params.Clear;
        toStoredProc.Params.AddParam ('inMovementId',ftInteger,ptInput, 0);
        //
        toStoredProc_two.StoredProcName:='gpComplete_Movement_Income';
        toStoredProc_two.OutputType := otResult;
        toStoredProc_two.Params.Clear;
        toStoredProc_two.Params.AddParam ('inMovementId',ftInteger,ptInput, 0);
        //
        while not EOF do
        begin
             //!!!
             if fStop then begin exit;end;
             //
             if cbUnComplete.Checked then
             begin
                  toStoredProc.Params.ParamByName('inMovementId').Value:=FieldByName('Id_Postgres').AsInteger;
                  if not myExecToStoredProc then ;//exit;
             end;
             if cbComplete.Checked then
             begin
                  toStoredProc_two.Params.ParamByName('inMovementId').Value:=FieldByName('Id_Postgres').AsInteger;
                  if not myExecToStoredProc_two then ;//exit;
             end;
             //
             Next;
             Application.ProcessMessages;
             Gauge.Progress:=Gauge.Progress+1;
             Application.ProcessMessages;
        end;
     end;
     //
     myDisabledCB(cbCompleteIncome);
end;
//----------------------------------------------------------------------------------------------------------------------------------------------------
procedure TMainForm.pLoadDocument_Income;
begin
     if (not cbIncome.Checked)or(not cbIncome.Enabled) then exit;
     //
     myEnabledCB(cbIncome);
     //
     with fromQuery,Sql do begin
        Close;
        Clear;
        Add('select Bill.Id as ObjectId');
        Add('     , Bill.BillNumber as InvNumber');
        Add('     , Bill.BillDate as OperDate');

        Add('     , OperDate as OperDatePartner');
        Add('     , null as InvNumberPartner');

        Add('     , Bill.isNds as PriceWithVAT');
        Add('     , Bill.Nds as VATPercent');
        Add('     , case when Bill.isByMinusDiscountTax=zc_rvYes() then -Bill.DiscountTax else Bill.DiscountTax end as ChangePercent');

        Add('     , UnitFrom.Id3_Postgres as FromId_Postgres');
        Add('     , _pgUnit.Id_Postgres as ToId_Postgres');
        Add('     , MoneyKind.Id_Postgres as PaidKindId_Postgres');
        Add('     , null as ContractId');
        Add('     , null as CarId');
        Add('     , null as PersonalDriverId');
        Add('     , null as PersonalPackerId');

        Add('     , Bill.Id_Postgres as Id_Postgres');
        Add('     , zc_rvYes() as zc_rvYes');
        Add('from dba.Bill');
        Add('     left outer join dba.Unit as UnitFrom on UnitFrom.Id = Bill.FromId');
        Add('     left outer join dba._pgUnit on _pgUnit.UnitId=case when Bill.ToId in(4417,zc_UnitId_CompositionZ())then zc_UnitId_Composition() else Bill.ToId end');
        Add('     left outer join dba.MoneyKind on MoneyKind.Id = Bill.MoneyKindId');
        Add('where Bill.BillDate between '+FormatToDateServer_notNULL(StrToDate(StartDateEdit.Text))+' and '+FormatToDateServer_notNULL(StrToDate(EndDateEdit.Text))
           +'  and Bill.BillKind=zc_bkIncomeToUnit()'
           +'  and UnitFrom.PersonalId_Postgres is null'
           );
        Add('order by ObjectId');
        Open;
        //
        fStop:=cbOnlyOpen.Checked;
        if cbOnlyOpen.Checked then exit;
        //
        Gauge.Progress:=0;
        Gauge.MaxValue:=RecordCount;
        //
        toStoredProc.StoredProcName:='gpinsertupdate_movement_income';
        toStoredProc.OutputType := otResult;
        toStoredProc.Params.Clear;
        toStoredProc.Params.AddParam ('ioId',ftInteger,ptInputOutput, 0);
        toStoredProc.Params.AddParam ('inInvNumber',ftString,ptInput, '');
        toStoredProc.Params.AddParam ('inOperDate',ftDateTime,ptInput, '');

        toStoredProc.Params.AddParam ('inOperDatePartner',ftDateTime,ptInput, '');
        toStoredProc.Params.AddParam ('inInvNumberPartner',ftString,ptInput, '');

        toStoredProc.Params.AddParam ('inPriceWithVAT',ftBoolean,ptInput, false);
        toStoredProc.Params.AddParam ('inVATPercent',ftFloat,ptInput, 0);
        toStoredProc.Params.AddParam ('inChangePercent',ftFloat,ptInput, 0);

        toStoredProc.Params.AddParam ('inFromId',ftInteger,ptInput, '');
        toStoredProc.Params.AddParam ('inToId',ftInteger,ptInput, '');
        toStoredProc.Params.AddParam ('inPaidKindId',ftInteger,ptInput, '');
        toStoredProc.Params.AddParam ('inContractId',ftInteger,ptInput, '');
        toStoredProc.Params.AddParam ('inCarId',ftInteger,ptInput, '');
        toStoredProc.Params.AddParam ('inPersonalDriverId',ftInteger,ptInput, '');
        toStoredProc.Params.AddParam ('inPersonalPackerId',ftInteger,ptInput, '');
        //
        while not EOF do
        begin
             //!!!
             if fStop then begin exit;end;
             // gc_isDebugMode:=true;
             //
             toStoredProc.Params.ParamByName('ioId').Value:=FieldByName('Id_Postgres').AsInteger;
             toStoredProc.Params.ParamByName('inInvNumber').Value:=FieldByName('InvNumber').AsString;
             toStoredProc.Params.ParamByName('inOperDate').Value:=FieldByName('OperDate').AsDateTime;

             toStoredProc.Params.ParamByName('inOperDatePartner').Value:=FieldByName('OperDatePartner').AsDateTime;
             toStoredProc.Params.ParamByName('inInvNumberPartner').Value:=FieldByName('InvNumberPartner').AsString;

             if FieldByName('PriceWithVAT').AsInteger=FieldByName('zc_rvYes').AsInteger then toStoredProc.Params.ParamByName('inPriceWithVAT').Value:=true else toStoredProc.Params.ParamByName('inPriceWithVAT').Value:=false;
             toStoredProc.Params.ParamByName('inVATPercent').Value:=FieldByName('VATPercent').AsFloat;
             toStoredProc.Params.ParamByName('inChangePercent').Value:=FieldByName('ChangePercent').AsFloat;

             toStoredProc.Params.ParamByName('inFromId').Value:=FieldByName('FromId_Postgres').AsInteger;
             toStoredProc.Params.ParamByName('inToId').Value:=FieldByName('ToId_Postgres').AsInteger;
             toStoredProc.Params.ParamByName('inPaidKindId').Value:=FieldByName('PaidKindId_Postgres').AsInteger;
             toStoredProc.Params.ParamByName('inContractId').Value:=FieldByName('ContractId').AsInteger;
             toStoredProc.Params.ParamByName('inCarId').Value:=FieldByName('CarId').AsInteger;
             toStoredProc.Params.ParamByName('inPersonalDriverId').Value:=FieldByName('PersonalDriverId').AsInteger;
             toStoredProc.Params.ParamByName('inPersonalPackerId').Value:=FieldByName('PersonalPackerId').AsInteger;

             if not myExecToStoredProc then ;//exit;
             //
             if (1=0)or(FieldByName('Id_Postgres').AsInteger=0)
             then fExecSqFromQuery('update dba.Bill set Id_Postgres=zf_ChangeIntToNull('+IntToStr(toStoredProc.Params.ParamByName('ioId').Value)+') where Id = '+FieldByName('ObjectId').AsString + ' and 0<>'+IntToStr(toStoredProc.Params.ParamByName('ioId').Value));
             //
             Next;
             Application.ProcessMessages;
             Gauge.Progress:=Gauge.Progress+1;
             Application.ProcessMessages;
        end;
     end;
     //
     myDisabledCB(cbIncome);
end;
//----------------------------------------------------------------------------------------------------------------------------------------------------
procedure TMainForm.pLoadDocumentItem_Income;
begin

     if (not cbIncome.Checked)or(not cbIncome.Enabled) then exit;
     //
     myEnabledCB(cbIncome);
     //
     with fromQuery,Sql do begin
        Close;
        Clear;
        Add('select BillItems.Id as ObjectId');
        Add('     , Bill.Id_Postgres as MovementId_Postgres');
        Add('     , GoodsProperty.Id_Postgres as GoodsId_Postgres');
        Add('     , BillItems.OperCount as Amount');
        Add('     , Amount as AmountPartner');
        Add('     , 0 as AmountPacker');
        Add('     , BillItems.OperPrice as Price');
        Add('     , 1 as CountForPrice');
        Add('     , BillItems.OperCount_Upakovka as LiveWeight');
        Add('     , BillItems.OperCount_sh as HeadCount');
        Add('     , BillItems.PartionStr_MB as PartionGoods');
        Add('     , KindPackage.Id_Postgres as GoodsKindId_Postgres');
        Add('     , null as AssetId_Postgres');
        Add('     , BillItems.Id_Postgres as Id_Postgres');
        Add('     , zc_rvYes() as zc_rvYes');
        Add('from dba.Bill');
        Add('     left outer join dba.Unit as UnitFrom on UnitFrom.Id = Bill.FromId');
        Add('     left outer join dba.BillItems on BillItems.BillId = Bill.Id');
        Add('     left outer join dba.GoodsProperty on GoodsProperty.Id = BillItems.GoodsPropertyId');
        Add('     left outer join dba.Goods on Goods.Id = GoodsProperty.GoodsId');
        Add('     left outer join dba.KindPackage on KindPackage.Id = BillItems.KindPackageId');
        Add('                                    and Goods.ParentId not in(686,1670,2387,2849,5874)'); // ���� + ��� + ���� + �-����������� + �������
        Add('where Bill.BillDate between '+FormatToDateServer_notNULL(StrToDate(StartDateEdit.Text))+' and '+FormatToDateServer_notNULL(StrToDate(EndDateEdit.Text))
           +'  and Bill.BillKind=zc_bkIncomeToUnit()'
           +'  and UnitFrom.PersonalId_Postgres is null'
           +'  and BillItems.Id is not null'
           );
        Add('order by ObjectId');
        Open;
        //
        fStop:=cbOnlyOpen.Checked;
        if cbOnlyOpen.Checked then exit;
        //
        Gauge.Progress:=0;
        Gauge.MaxValue:=RecordCount;
        //
        toStoredProc.StoredProcName:='gpinsertupdate_movementitem_income';
        toStoredProc.OutputType := otResult;
        toStoredProc.Params.Clear;
        toStoredProc.Params.AddParam ('ioId',ftInteger,ptInputOutput, 0);
        toStoredProc.Params.AddParam ('inMovementId',ftInteger,ptInput, '');
        toStoredProc.Params.AddParam ('inGoodsId',ftInteger,ptInput, '');
        toStoredProc.Params.AddParam ('inAmount',ftFloat,ptInput, 0);
        toStoredProc.Params.AddParam ('inAmountPartner',ftFloat,ptInput, 0);
        toStoredProc.Params.AddParam ('inAmountPacker',ftFloat,ptInput, 0);
        toStoredProc.Params.AddParam ('inPrice',ftFloat,ptInput, 0);
        toStoredProc.Params.AddParam ('inCountForPrice',ftFloat,ptInput, 0);
        toStoredProc.Params.AddParam ('inLiveWeight',ftFloat,ptInput, 0);
        toStoredProc.Params.AddParam ('inHeadCount',ftFloat,ptInput, 0);
        toStoredProc.Params.AddParam ('inPartionGoods',ftString,ptInput, '');
        toStoredProc.Params.AddParam ('inGoodsKindId',ftInteger,ptInput, 0);
        toStoredProc.Params.AddParam ('inAssetId',ftInteger,ptInput, 0);
        //
        //DisableControls;
        while not EOF do
        begin
             //!!!
             if fStop then begin {EnableControls;}exit;end;
             //
             toStoredProc.Params.ParamByName('ioId').Value:=FieldByName('Id_Postgres').AsInteger;
             toStoredProc.Params.ParamByName('inMovementId').Value:=FieldByName('MovementId_Postgres').AsString;
             toStoredProc.Params.ParamByName('inGoodsId').Value:=FieldByName('GoodsId_Postgres').AsInteger;
             toStoredProc.Params.ParamByName('inAmount').Value:=FieldByName('Amount').AsFloat;
             toStoredProc.Params.ParamByName('inAmountPartner').Value:=FieldByName('AmountPartner').AsFloat;
             toStoredProc.Params.ParamByName('inAmountPacker').Value:=FieldByName('AmountPacker').AsFloat;
             toStoredProc.Params.ParamByName('inPrice').Value:=FieldByName('Price').AsFloat;
             toStoredProc.Params.ParamByName('inCountForPrice').Value:=FieldByName('CountForPrice').AsFloat;
             toStoredProc.Params.ParamByName('inLiveWeight').Value:=FieldByName('LiveWeight').AsFloat;
             toStoredProc.Params.ParamByName('inHeadCount').Value:=FieldByName('HeadCount').AsFloat;
             toStoredProc.Params.ParamByName('inPartionGoods').Value:=FieldByName('PartionGoods').AsString;
             toStoredProc.Params.ParamByName('inGoodsKindId').Value:=FieldByName('GoodsKindId_Postgres').AsInteger;
             toStoredProc.Params.ParamByName('inAssetId').Value:=FieldByName('AssetId_Postgres').AsInteger;
             //toStoredProc.Params.ParamByName('inSession').Value:=fGetSession;
             if not myExecToStoredProc then ;//exit;
             //
             if (1=0)or(FieldByName('Id_Postgres').AsInteger=0)
             then fExecSqFromQuery('update dba.BillItems set Id_Postgres=zf_ChangeIntToNull('+IntToStr(toStoredProc.Params.ParamByName('ioId').Value)+') where Id = '+FieldByName('ObjectId').AsString);
             //
             Next;
             Application.ProcessMessages;
             Gauge.Progress:=Gauge.Progress+1;
             Application.ProcessMessages;
        end;
     end;
     //
     myDisabledCB(cbIncome);
end;
//----------------------------------------------------------------------------------------------------------------------------------------------------
procedure TMainForm.pLoadDocument_IncomePacker;
begin
     if (not cbIncomePacker.Checked)or(not cbIncomePacker.Enabled) then exit;
     //
     myEnabledCB(cbIncomePacker);
     //
     with fromQuery,Sql do begin
        Close;
        Clear;
        Add('select Bill.Id as ObjectId');
        Add('     , isnull (Bill_PartionStr_MB.BillNumber, Bill.BillNumber) as InvNumber');
        Add('     , isnull (Bill_PartionStr_MB.BillDate, Bill.BillDate) as OperDate');

        Add('     , OperDate as OperDatePartner');
        Add('     , null as InvNumberPartner');

        Add('     , Bill.isNds as PriceWithVAT');
        Add('     , Bill.Nds as VATPercent');
        Add('     , case when Bill.isByMinusDiscountTax=zc_rvYes() then -Bill.DiscountTax else Bill.DiscountTax end as ChangePercent');

        Add('     , isnull(UnitFrom_PartionStr_MB.Id3_Postgres,UnitFrom.PersonalId_Postgres) as FromId_Postgres');
        Add('     , _pgUnit.Id_Postgres as ToId_Postgres');
        Add('     , MoneyKind.Id_Postgres as PaidKindId_Postgres');
        Add('     , null as ContractId');
        Add('     , null as CarId');
        Add('     , null as PersonalDriverId');
        Add('     , case when Bill_PartionStr_MB.Id is not null then UnitFrom.PersonalId_Postgres else null end as PersonalPackerId');

        Add('     , isnull(Bill_PartionStr_MB.Id_Postgres,Bill.Id_Postgres) as Id_Postgres');
        Add('     , zc_rvYes() as zc_rvYes');
        Add('from dba.Bill');
        Add('     left outer join dba.Unit as UnitFrom on UnitFrom.Id = Bill.FromId');
        Add('     left outer join dba.Bill as Bill_PartionStr_MB on Bill_PartionStr_MB.Id = lfGet_BillId_byPartionStr_MB_isPG(Bill.Id)');
        Add('     left outer join dba.Unit as UnitFrom_PartionStr_MB on UnitFrom_PartionStr_MB.Id=Bill_PartionStr_MB.FromId');
        Add('     left outer join dba._pgUnit on _pgUnit.UnitId=case when Bill.ToId in(4417,zc_UnitId_CompositionZ())then zc_UnitId_Composition() else Bill.ToId end');
        Add('     left outer join dba.MoneyKind on MoneyKind.Id = Bill.MoneyKindId');
        Add('where Bill.BillDate between '+FormatToDateServer_notNULL(StrToDate(StartDateEdit.Text))+' and '+FormatToDateServer_notNULL(StrToDate(EndDateEdit.Text))
           +'  and Bill.BillKind=zc_bkIncomeToUnit()'
           +'  and UnitFrom.PersonalId_Postgres is not null'
           );
        Add('order by ObjectId');
        Open;
        //
        fStop:=cbOnlyOpen.Checked;
        if cbOnlyOpen.Checked then exit;
        //
        Gauge.Progress:=0;
        Gauge.MaxValue:=RecordCount;
        //
        toStoredProc.StoredProcName:='gpinsertupdate_movement_income';
        toStoredProc.OutputType := otResult;
        toStoredProc.Params.Clear;
        toStoredProc.Params.AddParam ('ioId',ftInteger,ptInputOutput, 0);
        toStoredProc.Params.AddParam ('inInvNumber',ftString,ptInput, '');
        toStoredProc.Params.AddParam ('inOperDate',ftDateTime,ptInput, '');

        toStoredProc.Params.AddParam ('inOperDatePartner',ftDateTime,ptInput, '');
        toStoredProc.Params.AddParam ('inInvNumberPartner',ftString,ptInput, '');

        toStoredProc.Params.AddParam ('inPriceWithVAT',ftBoolean,ptInput, false);
        toStoredProc.Params.AddParam ('inVATPercent',ftFloat,ptInput, 0);
        toStoredProc.Params.AddParam ('inChangePercent',ftFloat,ptInput, 0);

        toStoredProc.Params.AddParam ('inFromId',ftInteger,ptInput, '');
        toStoredProc.Params.AddParam ('inToId',ftInteger,ptInput, '');
        toStoredProc.Params.AddParam ('inPaidKindId',ftInteger,ptInput, '');
        toStoredProc.Params.AddParam ('inContractId',ftInteger,ptInput, '');
        toStoredProc.Params.AddParam ('inCarId',ftInteger,ptInput, '');
        toStoredProc.Params.AddParam ('inPersonalDriverId',ftInteger,ptInput, '');
        toStoredProc.Params.AddParam ('inPersonalPackerId',ftInteger,ptInput, '');
        //
        while not EOF do
        begin
             //!!!
             if fStop then begin exit;end;
             // gc_isDebugMode:=true;
             //
             toStoredProc.Params.ParamByName('ioId').Value:=FieldByName('Id_Postgres').AsInteger;
             toStoredProc.Params.ParamByName('inInvNumber').Value:=FieldByName('InvNumber').AsString;
             toStoredProc.Params.ParamByName('inOperDate').Value:=FieldByName('OperDate').AsDateTime;

             toStoredProc.Params.ParamByName('inOperDatePartner').Value:=FieldByName('OperDatePartner').AsDateTime;
             toStoredProc.Params.ParamByName('inInvNumberPartner').Value:=FieldByName('InvNumberPartner').AsString;

             if FieldByName('PriceWithVAT').AsInteger=FieldByName('zc_rvYes').AsInteger then toStoredProc.Params.ParamByName('inPriceWithVAT').Value:=true else toStoredProc.Params.ParamByName('inPriceWithVAT').Value:=false;
             toStoredProc.Params.ParamByName('inVATPercent').Value:=FieldByName('VATPercent').AsFloat;
             toStoredProc.Params.ParamByName('inChangePercent').Value:=FieldByName('ChangePercent').AsFloat;

             toStoredProc.Params.ParamByName('inFromId').Value:=FieldByName('FromId_Postgres').AsInteger;
             toStoredProc.Params.ParamByName('inToId').Value:=FieldByName('ToId_Postgres').AsInteger;
             toStoredProc.Params.ParamByName('inPaidKindId').Value:=FieldByName('PaidKindId_Postgres').AsInteger;
             toStoredProc.Params.ParamByName('inContractId').Value:=FieldByName('ContractId').AsInteger;
             toStoredProc.Params.ParamByName('inCarId').Value:=FieldByName('CarId').AsInteger;
             toStoredProc.Params.ParamByName('inPersonalDriverId').Value:=FieldByName('PersonalDriverId').AsInteger;
             toStoredProc.Params.ParamByName('inPersonalPackerId').Value:=FieldByName('PersonalPackerId').AsInteger;

             if not myExecToStoredProc then ;//exit;
             //
             if (1=1)or(FieldByName('Id_Postgres').AsInteger=0)
             then fExecSqFromQuery('update dba.Bill set Id_Postgres=zf_ChangeIntToNull('+IntToStr(toStoredProc.Params.ParamByName('ioId').Value)+') where Id = '+FieldByName('ObjectId').AsString + ' and isnull(Id_Postgres,0)<>'+IntToStr(toStoredProc.Params.ParamByName('ioId').Value)+' and 0<>'+IntToStr(toStoredProc.Params.ParamByName('ioId').Value));
             //
             Next;
             Application.ProcessMessages;
             Gauge.Progress:=Gauge.Progress+1;
             Application.ProcessMessages;
        end;
     end;
     //
     myDisabledCB(cbIncomePacker);
end;
//----------------------------------------------------------------------------------------------------------------------------------------------------
procedure TMainForm.pLoadDocumentItem_IncomePacker;
begin

     if (not cbIncomePacker.Checked)or(not cbIncomePacker.Enabled) then exit;
     //
     myEnabledCB(cbIncomePacker);
     //
     with fromQuery,Sql do begin
        Close;
        Clear;
        Add('select BillItems.Id as ObjectId');
        Add('     , isnull (Bill_PartionStr_MB.Id_Postgres, Bill.Id_Postgres) as MovementId_Postgres');
        Add('     , GoodsProperty.Id_Postgres as GoodsId_Postgres');
        Add('     , case when Bill_PartionStr_MB.Id is null then BillItems.OperCount else 0 end as Amount');
        Add('     , Amount as AmountPartner');
        Add('     , case when Bill_PartionStr_MB.Id is not null then BillItems.OperCount else 0 end as AmountPacker');
        Add('     , BillItems.OperPrice as Price');
        Add('     , 1 as CountForPrice');
        Add('     , BillItems.OperCount_Upakovka as LiveWeight');
        Add('     , BillItems.OperCount_sh as HeadCount');
        Add('     , BillItems.PartionStr_MB as PartionGoods');
        Add('     , KindPackage.Id_Postgres as GoodsKindId_Postgres');
        Add('     , null as AssetId_Postgres');
        Add('     , BillItems.Id_Postgres as Id_Postgres');
        Add('     , zc_rvYes() as zc_rvYes');
        Add('from dba.Bill');
        Add('     left outer join dba.Unit as UnitFrom on UnitFrom.Id = Bill.FromId');
        Add('     left outer join dba.Bill as Bill_PartionStr_MB on Bill_PartionStr_MB.Id = lfGet_BillId_byPartionStr_MB_isPG(Bill.Id)');

        Add('     left outer join dba.BillItems on BillItems.BillId = Bill.Id');
        Add('     left outer join dba.GoodsProperty on GoodsProperty.Id = BillItems.GoodsPropertyId');
        Add('     left outer join dba.Goods on Goods.Id = GoodsProperty.GoodsId');
        Add('     left outer join dba.KindPackage on KindPackage.Id = BillItems.KindPackageId');
        Add('                                    and Goods.ParentId not in(686,1670,2387,2849,5874)'); // ���� + ��� + ���� + �-����������� + �������
        Add('where Bill.BillDate between '+FormatToDateServer_notNULL(StrToDate(StartDateEdit.Text))+' and '+FormatToDateServer_notNULL(StrToDate(EndDateEdit.Text))
           +'  and Bill.BillKind=zc_bkIncomeToUnit()'
           +'  and UnitFrom.PersonalId_Postgres is not null'
           +'  and BillItems.Id is not null'
// +'  and BillItems.BillId =1164656'
           );
        Add('order by ObjectId');
        Open;
        //
        fStop:=cbOnlyOpen.Checked;
        if cbOnlyOpen.Checked then exit;
        //
        Gauge.Progress:=0;
        Gauge.MaxValue:=RecordCount;
        //
        toStoredProc.StoredProcName:='gpinsertupdate_movementitem_income';
        toStoredProc.OutputType := otResult;
        toStoredProc.Params.Clear;
        toStoredProc.Params.AddParam ('ioId',ftInteger,ptInputOutput, 0);
        toStoredProc.Params.AddParam ('inMovementId',ftInteger,ptInput, '');
        toStoredProc.Params.AddParam ('inGoodsId',ftInteger,ptInput, '');
        toStoredProc.Params.AddParam ('inAmount',ftFloat,ptInput, 0);
        toStoredProc.Params.AddParam ('inAmountPartner',ftFloat,ptInput, 0);
        toStoredProc.Params.AddParam ('inAmountPacker',ftFloat,ptInput, 0);
        toStoredProc.Params.AddParam ('inPrice',ftFloat,ptInput, 0);
        toStoredProc.Params.AddParam ('inCountForPrice',ftFloat,ptInput, 0);
        toStoredProc.Params.AddParam ('inLiveWeight',ftFloat,ptInput, 0);
        toStoredProc.Params.AddParam ('inHeadCount',ftFloat,ptInput, 0);
        toStoredProc.Params.AddParam ('inPartionGoods',ftString,ptInput, '');
        toStoredProc.Params.AddParam ('inGoodsKindId',ftInteger,ptInput, 0);
        toStoredProc.Params.AddParam ('inAssetId',ftInteger,ptInput, 0);
        //
        //DisableControls;
        while not EOF do
        begin
             //!!!
             if fStop then begin {EnableControls;}exit;end;
             //
             toStoredProc.Params.ParamByName('ioId').Value:=FieldByName('Id_Postgres').AsInteger;
             toStoredProc.Params.ParamByName('inMovementId').Value:=FieldByName('MovementId_Postgres').AsString;
             toStoredProc.Params.ParamByName('inGoodsId').Value:=FieldByName('GoodsId_Postgres').AsInteger;
             toStoredProc.Params.ParamByName('inAmount').Value:=FieldByName('Amount').AsFloat;
             toStoredProc.Params.ParamByName('inAmountPartner').Value:=FieldByName('AmountPartner').AsFloat;
             toStoredProc.Params.ParamByName('inAmountPacker').Value:=FieldByName('AmountPacker').AsFloat;
             toStoredProc.Params.ParamByName('inPrice').Value:=FieldByName('Price').AsFloat;
             toStoredProc.Params.ParamByName('inCountForPrice').Value:=FieldByName('CountForPrice').AsFloat;
             toStoredProc.Params.ParamByName('inLiveWeight').Value:=FieldByName('LiveWeight').AsFloat;
             toStoredProc.Params.ParamByName('inHeadCount').Value:=FieldByName('HeadCount').AsFloat;
             toStoredProc.Params.ParamByName('inPartionGoods').Value:=FieldByName('PartionGoods').AsString;
             toStoredProc.Params.ParamByName('inGoodsKindId').Value:=FieldByName('GoodsKindId_Postgres').AsInteger;
             toStoredProc.Params.ParamByName('inAssetId').Value:=FieldByName('AssetId_Postgres').AsInteger;
             //toStoredProc.Params.ParamByName('inSession').Value:=fGetSession;
             if not myExecToStoredProc then ;//exit;
             //
             if (1=0)or(FieldByName('Id_Postgres').AsInteger=0)
             then fExecSqFromQuery('update dba.BillItems set Id_Postgres=zf_ChangeIntToNull('+IntToStr(toStoredProc.Params.ParamByName('ioId').Value)+') where Id = '+FieldByName('ObjectId').AsString);
             //
             Next;
             Application.ProcessMessages;
             Gauge.Progress:=Gauge.Progress+1;
             Application.ProcessMessages;
        end;
     end;
     //
     myDisabledCB(cbIncomePacker);
end;
//----------------------------------------------------------------------------------------------------------------------------------------------------
end.

{
--
-- !!!! � ���� ������ ���� ������� ����� !!!
--
alter table dba.GoodsProperty_Detail add Id1_Postgres integer null;
alter table dba.GoodsProperty_Detail add Id2_Postgres integer null;
alter table dba.GoodsProperty_Detail add Id3_Postgres integer null;
alter table dba.GoodsProperty_Detail add Id4_Postgres integer null;
alter table dba.GoodsProperty_Detail add Id5_Postgres integer null;
alter table dba.GoodsProperty_Detail add Id6_Postgres integer null;
alter table dba.GoodsProperty_Detail add Id7_Postgres integer null;
alter table dba.GoodsProperty_Detail add Id8_Postgres integer null;
alter table dba.GoodsProperty_Detail add Id9_Postgres integer null;
alter table dba.GoodsProperty_Detail add Id10_Postgres integer null;
alter table dba.GoodsProperty_Detail add Id11_Postgres integer null;
alter table dba.GoodsProperty_Detail add Id12_Postgres integer null;
alter table dba.GoodsProperty_Detail add Id13_Postgres integer null;
alter table dba.GoodsProperty_Detail add Id14_Postgres integer null;

create table dba.GoodsProperty_Postgres (Id integer not null, Name_PG TVarCharMedium not null, Id_Postgres integer null);
insert into dba.GoodsProperty_Postgres (Id, Name_PG)
  select 1, '���' union all       // +fIsClient_ATB
  select 2, '���� ��' union all   // +fIsClient_OK
  select 3, '�����' union all     // +fIsClient_Metro
  select 4, '����' union all      //
  select 5, '�����' union all     // +fIsClient_Fozzi fIsClient_FozziM
  select 6, '������' union all    // +fIsClient_Kisheni
  select 7, '�����' union all     // +fIsClient_Vivat
  select 8, '�����' union all     // +fIsClient_Billa
  select 9, '������' union all    // +fIsClient_Amstor
  select 10, '�����' union all    // ***fIsClient_Omega
  select 11, '�������' union all  // ***fIsClient_Vostorg
  select 12, '����' union all     // +fIsClient_Ashan
  select 13, '����' union all     // +fIsClient_Real
  select 14, '��';                // ***fIsClient_GD
                                  // fIsClient_Furshet
                                  // fIsClient_Obgora
                                  // fIsClient_Tavriya


alter table dba.Goods add Id_Postgres integer null;
alter table dba.GoodsProperty add Id_Postgres integer null;
alter table dba.Measure add Id_Postgres integer null;
alter table dba.KindPackage add Id_Postgres integer null;

alter table dba.MoneyKind add Id_Postgres integer null;
alter table dba.ContractKind add Id_Postgres integer null;

alter table dba.Unit add Id1_Postgres integer null;
alter table dba.Unit add Id2_Postgres integer null;
alter table dba.Unit add Id3_Postgres integer null;
alter table dba.Unit add PersonalId_Postgres integer null;
alter table dba.Unit add Id_Postgres_Business integer null;
alter table dba._pgUnit add Id_Postgres_Branch integer null;

alter table dba.PriceList_byHistory add Id_Postgres integer null;

alter table dba.Bill add Id_Postgres integer null;
alter table dba.BillItems add Id_Postgres integer null;
alter table dba.BillItemsReceipt add Id_Postgres integer null;
}
