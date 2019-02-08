unit Cash_IKC_E810T;

interface
uses Windows, CashInterface, DBTables, NeoFiscalPrinterDriver_TLB;
type
  TCashIKC_E810T = class(TInterfacedObject, ICash)
  private
    FAlwaysSold: boolean;
    FPrinter: IICS_EP_09;
    FisFiscal: boolean;
    FLengNoFiscalText : integer;
    procedure SetAlwaysSold(Value: boolean);
    function GetAlwaysSold: boolean;
  protected
    function SoldCode(const GoodsCode: integer; const Amount: double; const Price: double = 0.00): boolean;
    function SoldFromPC(const GoodsCode: integer; const GoodsName: string; const Amount, Price, NDS: double): boolean; //������� � ����������
    function ChangePrice(const GoodsCode: integer; const Price: double): boolean;
    function OpenReceipt(const isFiscal: boolean = true): boolean;
    function CloseReceipt: boolean;
    function CloseReceiptEx(out CheckId: String): boolean;
    function CashInputOutput(const Summa: double): boolean;
    function ProgrammingGoods(const GoodsCode: integer; const GoodsName: string; const Price, NDS: double): boolean;
    function ClosureFiscal: boolean;
    function TotalSumm(Summ, SummAdd: double; PaidType: TPaidType): boolean;
    function DiscountGoods(Summ: double): boolean;
    function DeleteArticules(const GoodsCode: integer): boolean;
    function XReport: boolean;
    function GetLastErrorCode: integer;
    function GetArticulInfo(const GoodsCode: integer; var ArticulInfo: WideString): boolean;
    function PrintNotFiscalText(const PrintText: WideString): boolean;
    function PrintFiscalText(const PrintText: WideString): boolean;
    function SubTotal(isPrint, isDisplay: WordBool; Percent, Disc: Double): boolean;
    function PrintFiscalMemoryByNum(inStart, inEnd: Integer): boolean;
    function PrintFiscalMemoryByDate(inStart, inEnd: TDateTime): boolean;
    function PrintZeroReceipt: boolean;
    function PrintReportByDate(inStart, inEnd: TDateTime): boolean;
    function PrintReportByNum(inStart, inEnd: Integer): boolean;
    function FiscalNumber:String;
    function SerialNumber:String;
    procedure ClearArticulAttachment;
    procedure SetTime;
    procedure Anulirovt;
    function InfoZReport : string;
    function JuridicalName : string;
    function ZReport : Integer;
  public
    constructor Create;
    function ShowError: boolean;
  end;



implementation
uses Forms, SysUtils, Dialogs, Math, Variants, BDE, StrUtils, IniUtils, RegularExpressions, Log;


const

  Password = 000000;

{ TCashIKC_E810T }
constructor TCashIKC_E810T.Create;
begin
  inherited Create;
  FAlwaysSold:=false;
  FLengNoFiscalText := 35;
  FPrinter := CoFiscPrn.Create;
  if FPrinter.FPInitialize = 0 then
  begin
    if not FPrinter.FPOpen(StrToInt(iniPortNumber), StrToInt(iniPortSpeed), 3, 3) then ShowError;
  end else ShowMessage(SysErrorMessage(GetLastError));
end;


function TCashIKC_E810T.ShowError: boolean;
  var S : string;
begin
  Result := False;
  S := FPrinter.prGetErrorText;
  ShowMessage(S);
end;

function TCashIKC_E810T.CloseReceipt: boolean;
begin
  result := True;
end;

function TCashIKC_E810T.CloseReceiptEx(out CheckId: String): boolean;
begin
  result := True;
end;

function TCashIKC_E810T.GetAlwaysSold: boolean;
begin
  result:= FAlwaysSold;
end;

function TCashIKC_E810T.OpenReceipt(const isFiscal: boolean = true): boolean;
begin
  FisFiscal := isFiscal;
  result := True;
end;

procedure TCashIKC_E810T.SetAlwaysSold(Value: boolean);
begin
  FAlwaysSold:= Value
end;

procedure TCashIKC_E810T.SetTime;
begin
  FPrinter.FPSetCurrentDate(Date);
  if not FPrinter.FPSetCurrentTime(Now) then ShowError;
end;

function TCashIKC_E810T.SoldCode(const GoodsCode: integer;
  const Amount: double; const Price: double = 0.00): boolean;
begin
  result := False;
  ShowMessage('������. �������� SoldCode �� ���������.');
end;

function TCashIKC_E810T.SoldFromPC(const GoodsCode: integer; const GoodsName: string; const Amount, Price, NDS: double): boolean;
var NDSType: char;
    CashCode, nNDS: integer;
    I : Integer;
    L : string;
    Res: TArray<string>;
begin
  result := true;
  if FAlwaysSold then exit;

    // ������ ������������� ����
  if not FisFiscal then
  begin

    L := '';
    Res := TRegEx.Split(GoodsName, ' ');
    for I := 0 to High(Res) do
    begin
      if L <> '' then L := L + ' ';
      L := L + Res[i];
      if (I < High(Res)) and (Length(L + Res[i]) > FLengNoFiscalText) then
      begin
        if not PrintNotFiscalText(L) then Exit;
        L := '';
      end;
      if I = High(Res) then
      begin
        if (Length(L + FormatCurr('0.000', Amount)) + 3) >= FLengNoFiscalText then
        begin
          if not PrintNotFiscalText(L) then Exit;;
          L := StringOfChar(' ' , FLengNoFiscalText - Length(FormatCurr('0.000', Amount)) - 1) + FormatCurr('0.000', Amount);
          if not PrintNotFiscalText(L) then Exit;
        end else
        begin
          L := L + StringOfChar(' ' , FLengNoFiscalText - Length(L + FormatCurr('0.000', Amount)) - 1) + FormatCurr('0.000', Amount);
          if not PrintNotFiscalText(L) then Exit;
        end;
      end;
    end;

    Exit;
  end;

  if NDS = 20 then nNDS := 1 else nNDS := 2;

  Logger.AddToLog(' SALE (GoodsCode := ' + IntToStr(GoodsCode) + ', Amount := ' + ReplaceStr(FormatFloat('0.000', Amount), FormatSettings.DecimalSeparator, '.') +
      ', Price := ' + ReplaceStr(FormatFloat('0.00', Price), FormatSettings.DecimalSeparator, '.') + ')');
  if Amount = 1 then
    result := FPrinter.FPSaleItem(Round(Amount * 1000), 3, False, True, False, Round(Price * 100), nNDS, Copy(GoodsName, 1, 75), GoodsCode)
  else result := FPrinter.FPSaleItem(Round(Amount * 1000), 3, False, False, False, Round(Price * 100), nNDS, Copy(GoodsName, 1, 75), GoodsCode);

  if not result then ShowError;
end;

function TCashIKC_E810T.ProgrammingGoods(const GoodsCode: integer;
  const GoodsName: string; const Price, NDS: double): boolean;
begin
  result := False;
  ShowMessage('������. �������� SoldCode �� ���������.');
end;

procedure TCashIKC_E810T.Anulirovt;
begin
  if not FPrinter.FPAnnulReceipt then ShowError;
end;

function TCashIKC_E810T.CashInputOutput(const Summa: double): boolean;
begin
  if Summa > 0 then
    result := FPrinter.FPCashIn(Round(Summa * 100))
  else result := FPrinter.FPCashOut(Round(Abs(Summa) * 100));
  if not result then ShowError;
end;

function TCashIKC_E810T.TotalSumm(Summ, SummAdd: double; PaidType: TPaidType): boolean;
begin
  result := True;

  if FisFiscal then
  begin

    if (PaidType=ptCardAdd) and (SummAdd <> 0) then
    begin
      result := FPrinter.FPPayment(4, Round(SummAdd * 100), False, True, '');
    end;

    if result then
    begin
      if PaidType=ptMoney then
      begin
        result := FPrinter.FPPayment(4, Round(Summ * 100), True, True, '');
      end else result := FPrinter.FPPayment(1, Round(Summ * 100), True, True, '');
    end;

   if not result then ShowError;
   if not result then FPrinter.FPAnnulReceipt;

  end else FPrinter.FPCloseServiceReport;

end;

function TCashIKC_E810T.DiscountGoods(Summ: double): boolean;
begin
  if FisFiscal then
  begin
    if Summ > 0 then
      result := FPrinter.FPMakeMarkup(False, True, Round(Summ * 100), '')
    else result := FPrinter.FPMakeDiscount(False, True, Round(Abs(Summ) * 100), '');
    if not result then ShowError;
  end else result := True;
end;

function TCashIKC_E810T.ClosureFiscal: boolean;
begin
  result := FPrinter.FPMakeZReport(Password);
  if not result then ShowError;
end;

function TCashIKC_E810T.DeleteArticules(const GoodsCode: integer): boolean;
begin
end;

function TCashIKC_E810T.FiscalNumber: String;
begin
  if FPrinter.FPGetCurrentStatus then
    Result := FPrinter.prFiscalNumber
  else ShowError;
end;

function TCashIKC_E810T.SerialNumber:String;
begin
  if FPrinter.FPGetCurrentStatus then
    Result := FPrinter.prSerialNumber
  else ShowError;
end;

function TCashIKC_E810T.XReport: boolean;
begin
  result := FPrinter.FPMakeXReport(Password);
  if not result then ShowError;
end;

function TCashIKC_E810T.ChangePrice(const GoodsCode: integer;
  const Price: double): boolean;
begin
end;

function TCashIKC_E810T.GetLastErrorCode: integer;
begin
  //result:= status
end;

function TCashIKC_E810T.GetArticulInfo(const GoodsCode: integer;
  var ArticulInfo: WideString): boolean;
var i: integer;
begin
end;

function TCashIKC_E810T.PrintNotFiscalText(
  const PrintText: WideString): boolean;
begin
  result := FPrinter.FPPrintServiceReportByLine(PrintText);
  if not result then ShowError
end;

function TCashIKC_E810T.PrintFiscalText(
  const PrintText: WideString): boolean;
var APrintText: String;
begin

end;

function TCashIKC_E810T.SubTotal(isPrint, isDisplay: WordBool; Percent,
  Disc: Double): boolean;
begin
  result := True;
end;


function TCashIKC_E810T.PrintFiscalMemoryByDate(inStart,
  inEnd: TDateTime): boolean;
var StartStr, EndStr: string;
begin

end;

function TCashIKC_E810T.PrintFiscalMemoryByNum(inStart,
  inEnd: Integer): boolean;
begin

end;

function TCashIKC_E810T.PrintReportByDate(inStart,
  inEnd: TDateTime): boolean;
begin

end;

function TCashIKC_E810T.PrintReportByNum(inStart, inEnd: Integer): boolean;
begin

end;

function TCashIKC_E810T.PrintZeroReceipt: boolean;
begin
  result := FPrinter.FPPrintZeroReceipt;
  if not result then ShowError
end;


procedure TCashIKC_E810T.ClearArticulAttachment;
begin
end;

function TCashIKC_E810T.InfoZReport : string;
  var I : integer; S : String;

  function Centr(AStr : string) : String;
  begin
    if Length(AStr) > 40 then
      Result := Copy(AStr, 1, 40) + #13#10 + Centr(Copy(AStr, 41, Length(AStr)))
    else if Length(AStr) = 40 then Result := AStr
    else Result := StringOfChar(' ', (40 - Length(AStr)) div 2) + AStr;
  end;

  function Str(ACur : Currency; AL : integer) : String;
  begin
    Result := FormatCurr('0.00', ACur);
    if AL > Length(Result) then Result := StringOfChar(' ', AL - Length(Result)) + Result;
    Result := StringReplace(Result, FormatSettings.DecimalSeparator, '.', [rfReplaceAll])
  end;

begin
  Result := '';

  FPrinter.FPGetCurrentStatus;

  if FPrinter.prHeadLine1 <> '' then  Result := Result + Centr(FPrinter.prHeadLine1) + #13#10;
  if FPrinter.prHeadLine2 <> '' then  Result := Result + Centr(FPrinter.prHeadLine2) + #13#10;
  if FPrinter.prHeadLine3 <> '' then  Result := Result + Centr(FPrinter.prHeadLine3) + #13#10;

  S := '�� ' + FPrinter.prSerialNumber;
  S := S + '  �� ' + FPrinter.prFiscalNumber + #13#10;
  Result := Result + Centr(S) + #13#10;


  FPrinter.FPGetDayReportProperties;

  S := '           Z-��� N ' + IntToStr(FPrinter.prCurrentZReport);
  Result := Result + S + #13#10;

  Result := Result + '              �������' + #13#10;
  Result := Result + '  ------      ����������    ������' + #13#10;

  FPrinter.FPGetDayReportData;
  FPrinter.FPGetDaySumOfAddTaxes;
  FPrinter.FPGetCashDrawerSum;

  Result := Result + '  ������  ' + Str(FPrinter.prDayRefundSumOnPayForm4 / 100, 13) + Str(FPrinter.prDaySaleSumOnPayForm4 / 100, 13) + #13#10;
  Result := Result + '  ������   ' + Str(FPrinter.prDayRefundSumOnPayForm1 / 100, 13) + Str(FPrinter.prDaySaleSumOnPayForm1 / 100, 13) + #13#10;
  Result := Result + '  ������   ' + Str(FPrinter.prDayRefundSumOnPayForm10 / 100, 13) + Str(FPrinter.prDaySaleSumOnPayForm10 / 100, 13) + #13#10;


  Result := Result + '  ------         ������     ������'#13#10;
  Result := Result + '  ������  ' + Str(FPrinter.prDayCashOutSum / 100, 13) + Str(FPrinter.prDayCashInSum / 100, 13) + #13#10;
  Result := Result + '  ������ � ���        ' + Str(FPrinter.prCashDrawerSum / 100, 13) + #13#10;

  Result := Result + '  ------        �������       ���' + #13#10;
  Result := Result + '  ���. �   ' + Str(FPrinter.prDaySumAddTaxOfSale1 / 100, 13) + Str(FPrinter.prDaySaleSumOnTax1 / 100, 13) + #13#10;
  Result := Result + '  ���. �   ' + Str(FPrinter.prDaySumAddTaxOfSale2 / 100, 13) + Str(FPrinter.prDaySaleSumOnTax2 / 100, 13) + #13#10;
  Result := Result + '  ���� ������� ' + IntToStr(FPrinter.prDaySaleReceiptsCount) + #13#10;

  Result := Result + '  ²�. A   ' + Str(FPrinter.prDaySumAddTaxOfRefund1 / 100, 13) + Str(FPrinter.prDayRefundSumOnTax1 / 100, 13) + #13#10;
  Result := Result + '  ²�. �   ' + Str(FPrinter.prDaySumAddTaxOfRefund2 / 100, 13) + Str(FPrinter.prDayRefundSumOnTax2 / 100, 13) + #13#10;
  Result := Result + '  ���� ���������� ' + IntToStr(FPrinter.prDayRefundReceiptsCount) + #13#10;

  {
  S := FPrinter.READTAXRATE[0, 2, Password];
  if not ShowError then Exit;
  if not TryStrToCurr(Trim(StringReplace(S, '.', FormatSettings.DecimalSeparator, [rfReplaceAll])), nSum[0]) then nSum[0] := 0;

  S := FPrinter.READTAXRATE[1, 2, Password];
  if not ShowError then Exit;
  if not TryStrToCurr(Trim(StringReplace(S, '.', FormatSettings.DecimalSeparator, [rfReplaceAll])), nSum[1]) then nSum[1] := 0;

  Result := Result + '  �������     ��        10.10.2017' + #13#10;
  Result := Result + '            ���_A (���) A =    ' + Str(nSum[0], 6) + '%' + #13#10;
  Result := Result + '            ���_� (���) � =    ' + Str(nSum[1], 6) + '%' + #13#10;

  S := FPrinter.RETDT[1, Password];
  if not ShowError then Exit;
  S := S + '  ' + FPrinter.RETDT[0, Password];
  if not ShowError then Exit;
  S := COPY(S, 1, 2) + '.' + COPY(S, 3, 2) +  '.20' + COPY(S, 5, 6) +  ':' + COPY(S, 11, 2);
  }
  Result := Result + '                    ' + S  + #13#10;
  Result := Result + '         Բ�������� ���' + #13#10;
  Result := Result + '  --------------------------------------' + #13#10;
  Result := Result + '  --------------------------------------' + #13#10;

end;

function TCashIKC_E810T.JuridicalName : string;
begin
  if FPrinter.FPGetCurrentStatus then
    Result := FPrinter.prHeadLine1
  else ShowError;
end;

function TCashIKC_E810T.ZReport : Integer;
begin
  Result := 0;
  if FPrinter.FPGetDayReportProperties then Result := FPrinter.prCurrentZReport
  else ShowError;
end;

end.

// FPGetCurrentReceiptData
