unit uExportToXLS;

interface

uses Data.DB, System.Classes, System.SysUtils, System.Win.ComObj, Vcl.Graphics,
     Vcl.ActnList, dsdAction;

type

  TdsdOrientationType = (orPortrait, orLandscape);
  TdsdCalcColumnType = (ccNone, ccSumma, ccMultiplication, ccDivision, ccPercent, ccMulDiv);
  TdsdKindType = (skNone, skSumma, skMax, skMin, skAverage, skText);

  TdsdExportToXLSAction = class;

  TdsdCalcColumnList = class (TCollectionItem)
  private
    FFieldName: String;
    FColumnPos: Integer;
  protected
    function GetDisplayName: string; override;
  public
    procedure Assign(Source: TPersistent); override;
  published
    property FieldName: String read FFieldName write FFieldName;
  end;

  TdsdCalcColumnLists = class (TOwnedCollection)
  private
    function GetItem(Index: Integer): TdsdCalcColumnList;
    procedure SetItem(Index: Integer; const Value: TdsdCalcColumnList);
  public
    function Add: TdsdCalcColumnList;
    property Items[Index: Integer]: TdsdCalcColumnList read GetItem write SetItem; default;
  end;

  TdsdColumnParam = class (TCollectionItem)
  private
    FCaption: String;
    FFieldName: String;
    FDataType: TFieldType;
    FDecimalPlace : Integer;
    FFont: TFont;
    FWidth : Integer;
    FWrapText : Boolean;
    FCalcColumn : TdsdCalcColumnType;
    FCalcColumnLists : TdsdCalcColumnLists;
    FRound : boolean;
    FKind : TdsdKindType;
    FKindText: String;
    FExportToXLSAction : TdsdExportToXLSAction;
    FFieldExists : boolean;
  protected
    procedure SetFont(Value: TFont);
    function GetDisplayName: string; override;
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    function GetFormula: string;
  published
    property Caption: String read FCaption write FCaption;
    property FieldName: String read FFieldName write FFieldName;
    property DataType: TFieldType read FDataType write FDataType default ftString;
    property DecimalPlace : Integer read FDecimalPlace write FDecimalPlace;
    property Font: TFont read FFont write SetFont;
    property Width : Integer read FWidth write FWidth default 10;
    property WrapText : Boolean read FWrapText write FWrapText default False;
    property CalcColumn : TdsdCalcColumnType read FCalcColumn write FCalcColumn default ccNone;
    property CalcColumnLists : TdsdCalcColumnLists read FCalcColumnLists write FCalcColumnLists;
    property Round : boolean read FRound write FRound default True;
    property Kind : TdsdKindType read FKind write FKind default skNone;
    property KindText: String read FKindText write FKindText;
    property ExportToXLSAction : TdsdExportToXLSAction read FExportToXLSAction;
  end;

  TdsdColumnParams = class (TOwnedCollection)
  private
    function GetItem(Index: Integer): TdsdColumnParam;
    procedure SetItem(Index: Integer; const Value: TdsdColumnParam);
  public
    function Add: TdsdColumnParam;
    property Items[Index: Integer]: TdsdColumnParam read GetItem write SetItem; default;
  end;

  TdsdExportToXLSAction = class(TdsdCustomAction)
  private
    FTitleDataSet: TDataSet;
    FItemsDataSet: TDataSet;
    FOrientation : TdsdOrientationType;
    FTitle: String;
    FFileName: String;
    FTitleHeight : Currency;
    FTitleFont: TFont;
    FHeaderFont: TFont;
    FFooter : boolean;
    FColumnParams : TdsdColumnParams;
    procedure SetTitleFont(Value: TFont);
    procedure SetHeaderFont(Value: TFont);
    procedure SetItemsDataSet(const Value: TDataSet);
    procedure SetTitleDataSet(const Value: TDataSet);
  protected
    function LocalExecute: Boolean; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function ColumnNumber(AFieldName : string) : integer;
    function ExistsColumn(AFieldName : string) : Boolean;
  published
    property ItemsDataSet: TDataSet read FItemsDataSet write SetItemsDataSet;
    property TitleDataSet: TDataSet read FTitleDataSet write SetTitleDataSet;
    property Title: String read FTitle write FTitle;
    property FileName: String read FFileName write FFileName;
    property TitleHeight : Currency read FTitleHeight write FTitleHeight;
    property Orientation : TdsdOrientationType read FOrientation write FOrientation default orPortrait;
    property TitleFont: TFont read FTitleFont write SetTitleFont;
    property HeaderFont: TFont read FHeaderFont write SetHeaderFont;
    property Footer : boolean  read FFooter write FFooter default True;
    property ColumnParams : TdsdColumnParams read FColumnParams write FColumnParams;
    property Caption;
    property Hint;
    property ImageIndex;
    property ShortCut;
    property SecondaryShortCuts;
  end;


implementation

  { TdsdCalcColumnList }

procedure TdsdCalcColumnList.Assign(Source: TPersistent);
begin
  if Source is TdsdCalcColumnList then
  begin
     Self.FFieldName := TdsdCalcColumnList(Source).FieldName;
  end else
    inherited; //raises an exception
end;

function TdsdCalcColumnList.GetDisplayName: string;
begin
  if FFieldName <> '' then
     Result := FieldName
  else
     Result := inherited;
end;

  { TdsdCalcColumnLists }

function TdsdCalcColumnLists.Add: TdsdCalcColumnList;
begin
  result := TdsdCalcColumnList(inherited Add);
end;

function TdsdCalcColumnLists.GetItem(Index: Integer): TdsdCalcColumnList;
begin
  Result := TdsdCalcColumnList(inherited GetItem(Index));
end;

procedure TdsdCalcColumnLists.SetItem(Index: Integer; const Value: TdsdCalcColumnList);
begin
  inherited SetItem(Index, Value);
end;


  { TdsdColumnParam }

constructor TdsdColumnParam.Create(Collection: TCollection);
begin
  inherited;
  FFont := TFont.Create;
  FCalcColumnLists := TdsdCalcColumnLists.Create(Self, TdsdCalcColumnList);
  FWidth := 10;
  FWrapText := False;
  FFieldExists := True;
  FRound := True;
  if Collection.Owner is TdsdExportToXLSAction then
    FExportToXLSAction := TdsdExportToXLSAction(Collection.Owner);
end;

destructor TdsdColumnParam.Destroy;
begin
  FFont.Free;
  FCalcColumnLists.Free;
  inherited;
end;

procedure TdsdColumnParam.Assign(Source: TPersistent);
begin
  if Source is TdsdColumnParam then
  begin
     Self.FCaption := TdsdColumnParam(Source).Caption;
     Self.FFieldName := TdsdColumnParam(Source).FieldName;
     Self.FDataType := TdsdColumnParam(Source).DataType;
  end else
    inherited; //raises an exception
end;

function TdsdColumnParam.GetDisplayName: string;
  var I, J : integer;
begin
  if FCalcColumn <> ccNone then
  begin
    Result := '='; J := 0;

    for I := 0 to FCalcColumnLists.Count - 1 do
    begin
      if FCalcColumnLists.Items[I].DisplayName <> '' then
      begin
        if J = 0 then Result := Result + FCalcColumnLists.Items[I].DisplayName
        else case FCalcColumn of
          ccSumma : Result := Result + ' + ' + FCalcColumnLists.Items[I].DisplayName;
          ccMultiplication : Result := Result + ' * ' + FCalcColumnLists.Items[I].DisplayName;
          ccDivision : Result := Result + ' / ' + FCalcColumnLists.Items[I].DisplayName;
          ccPercent : begin
                        Result := Result + ' + ' + FCalcColumnLists.Items[I].DisplayName + ' * 100';
                        Break;
                      end;
          ccMulDiv : begin
                       case J of
                         1 : Result := Result + ' * ' + FCalcColumnLists.Items[I].DisplayName;
                         2 : Result := Result + ' / ' + FCalcColumnLists.Items[I].DisplayName;
                         else Break;
                       end;
                     end;
        end;
        Inc(J);
      end;
    end;
  end;
  if FFieldName <> '' then
     Result := FieldName
  else
     Result := inherited;
end;

procedure TdsdColumnParam.SetFont(Value: TFont);
begin
  FFont.Assign(Value);
end;

function TdsdColumnParam.GetFormula: string;
  var I, J, C : integer; S, P : string;
begin
  Result := ''; S := ''; J := 0;
  if not Assigned(FExportToXLSAction) then Exit;

  for I := 0 to FCalcColumnLists.Count - 1 do
  begin
    if (FCalcColumnLists.Items[I].DisplayName <> '') and
      FExportToXLSAction.ExistsColumn(FCalcColumnLists.Items[I].DisplayName) then
    begin
      C := FExportToXLSAction.ColumnNumber(FCalcColumnLists.Items[I].DisplayName);
      if C = Index then Continue;

      P := IntToStr(C - Index);

      if FCalcColumn = ccSumma then P := 'IF(ISNUMBER(RC[' + P + ']),RC[' + P + '],0)'
      else P := 'IF(ISNUMBER(RC[' + P + ']),RC[' + P + '],1)';

      if J = 0 then S := S + P
      else case FCalcColumn of
        ccSumma : S := S + ' + ' + P;
        ccMultiplication : S := S + ' * ' + P;
        ccDivision : S := S + ' / ' + P;
        ccPercent : begin
                      S := S + ' / ' + P + ' * 100';
                      Break;
                    end;
        ccMulDiv : begin
                     case J of
                       1 : S := S + ' * ' + P;
                       2 : S := S + ' / ' + P;
                       else Break;
                     end;
                   end;
      end;
      Inc(J);
    end;
  end;

  if S <> '' then
  begin
    if FRound then
      Result := '=ROUND(' + S + ',' + IntToStr(FDecimalPlace) + ')'
    else Result := '=' + S;
  end;
end;

  { TdsdColumnParams }

function TdsdColumnParams.Add: TdsdColumnParam;
begin
  result := TdsdColumnParam(inherited Add);
end;

function TdsdColumnParams.GetItem(Index: Integer): TdsdColumnParam;
begin
  Result := TdsdColumnParam(inherited GetItem(Index));
end;

procedure TdsdColumnParams.SetItem(Index: Integer; const Value: TdsdColumnParam);
begin
  inherited SetItem(Index, Value);
end;

  {TdsdExportToXLSAction}

constructor TdsdExportToXLSAction.Create(AOwner: TComponent);
begin
  inherited;
  FColumnParams := TdsdColumnParams.Create(Self, TdsdColumnParam);
  FTitleFont := TFont.Create;
  FHeaderFont := TFont.Create;
  FTitleHeight := 1;
  FFooter := True;
end;

destructor TdsdExportToXLSAction.Destroy;
begin
  FTitleFont.Free;
  FHeaderFont.Free;
  FColumnParams.Free;
  inherited;
end;

procedure TdsdExportToXLSAction.SetItemsDataSet(const Value: TDataSet);
begin
  FItemsDataSet := Value;
end;

procedure TdsdExportToXLSAction.SetTitleDataSet(const Value: TDataSet);
begin
  FTitleDataSet := Value;
end;

procedure TdsdExportToXLSAction.SetTitleFont(Value: TFont);
begin
  FTitleFont.Assign(Value);
end;

procedure TdsdExportToXLSAction.SetHeaderFont(Value: TFont);
begin
  FHeaderFont.Assign(Value);
end;

function TdsdExportToXLSAction.ColumnNumber(AFieldName : string) : integer;
  var I : integer;
begin
  Result := -1;

  for I := 0 to FColumnParams.Count - 1 do
    if LowerCase(FColumnParams.Items[I].DisplayName) = LowerCase(AFieldName) then
  begin
    Result := I;
    Break;
  end;
end;

function TdsdExportToXLSAction.ExistsColumn(AFieldName : string) : Boolean;
  var I : integer;
begin
  Result := False;

  for I := 0 to FColumnParams.Count - 1 do
    if LowerCase(FColumnParams.Items[I].DisplayName) = LowerCase(AFieldName) then
  begin
    Result := True;
    Break;
  end;
end;

function TdsdExportToXLSAction.LocalExecute: Boolean;
 var xlApp, xlBook, xlSheet, xlRange: OLEVariant;
     nTitleCount,  // ����� ��������� ������
     nHeadGrid,    // ������ ����� �����
     nDataStart,   // ������ ������
     nDataCount,   // ���������� ����� ������
     nColumnCount, // ���������� �������
     I, J : Integer;

 const xlLeft = - 4131;
       xlRight = -4152;
       xlCenter = -4108;
       xlTop = -4160;
       xlBottom = -4107;
       xlEdgeLeft = 7;
       xlEdgeTop = 8;
       xlEdgeBottom = 9;
       xlEdgeRight = 10;
       xlInsideVertical = 11;
       xlInsideHorizontal = 12;
       xlThin = 2;
       xlMedium = -4138;
       xlLandscape = 2;
       xlPortrait = 1;

  function GetThousandSeparator : string;
  begin
    if FormatSettings.ThousandSeparator = #160 then Result :=  ' '
    else Result := FormatSettings.ThousandSeparator;
  end;

  function CharReplay(AChar : Char; ACount : Integer) : string;
    var I : integer;
  begin
    Result := '';
    for I := 1 to ACount do Result := Result + AChar;
  end;

begin
  inherited;
  Result := False;

  if FItemsDataSet = Nil then
  begin
    raise Exception.Create('�� ��������� ItemsDataSet..');
    Exit;
  end;

  if not FItemsDataSet.Active then
  begin
    raise Exception.Create('ItemsDataSet �� ������..');
    Exit;
  end;

  try
    xlApp := GetActiveOleObject('Excel.Application');
  except
    try
      xlApp:=CreateOleObject('Excel.Application');
    except
      raise Exception.Create('������ ����������� � Excel.Application! ���������, ��� �� ���������� ���������� Excel..');
      Exit;
    end;
  end;

  try
    xlApp.Application.ScreenUpdating := false;
    xlApp.DisplayAlerts := false;
    xlBook := xlApp.WorkBooks.Add;
    xlSheet := xlBook.ActiveSheet;

    case FOrientation of
      orPortrait : xlSheet.PageSetup.Orientation := xlPortrait;
      orLandscape : xlSheet.PageSetup.Orientation := xlLandscape;
    end;

{    xlApp.ActiveWindow.SplitColumn := 2;
    xlApp.ActiveWindow.SplitRow := 1;
    xlApp.ActiveWindow.FreezePanes := true;}

    nTitleCount := 0;
    nHeadGrid := 1;
    nDataStart := 1;
    nDataCount := 0;

    if FColumnParams.Count > 0 then
      nColumnCount := FColumnParams.Count
    else nColumnCount := FItemsDataSet.FieldCount;

      // ��������� ������
    if Assigned(FTitleDataSet) and FTitleDataSet.Active and (FTitleDataSet.RecordCount > 0) then
    begin
      FTitleDataSet.First;
      while not FTitleDataSet.Eof do
      begin
        Inc(nTitleCount);
        Inc(nHeadGrid);
        Inc(nDataStart);

        xlSheet.Rows[nTitleCount].RowHeight := xlSheet.Rows[nTitleCount].RowHeight * FTitleHeight;
        xlRange := xlSheet.Range[xlSheet.Cells[nTitleCount, 1], xlSheet.Cells[nTitleCount, nColumnCount]];
        xlRange.Merge;
        xlRange := xlSheet.Cells[nTitleCount, 1];
        xlRange.Value := FTitleDataSet.Fields.Fields[0].AsString;
        xlRange.HorizontalAlignment := xlCenter;
        xlRange.VerticalAlignment := xlCenter;
        xlRange.WrapText:=true;
        xlRange.Font.Name := FTitleFont.Name;
        xlRange.Font.Size := FTitleFont.Size;
        xlRange.Font.Color := FTitleFont.Color;
        xlRange.Font.Bold := fsBold in FTitleFont.Style;
        xlRange.Font.Italic := fsItalic in FTitleFont.Style;
        xlRange.Font.Underline := fsUnderline in FTitleFont.Style;

        FTitleDataSet.Next;
      end;
    end else If Trim(FTitle) <> '' then
    begin
      Inc(nTitleCount);
      Inc(nHeadGrid);
      Inc(nDataStart);

      xlSheet.Rows[nTitleCount].RowHeight := xlSheet.Rows[nTitleCount].RowHeight * FTitleHeight;
      xlRange := xlSheet.Range[xlSheet.Cells[nTitleCount, 1], xlSheet.Cells[nTitleCount, nColumnCount]];
      xlRange.Merge;
      xlRange := xlSheet.Cells[nTitleCount, 1];
      xlRange.Value := FTitle;
      xlRange.HorizontalAlignment := xlCenter;
      xlRange.VerticalAlignment := xlCenter;
      xlRange.WrapText:=true;
      xlRange.Font.Name := FTitleFont.Name;
      xlRange.Font.Size := FTitleFont.Size;
      xlRange.Font.Color := FTitleFont.Color;
      xlRange.Font.Bold := fsBold in FTitleFont.Style;
      xlRange.Font.Italic := fsItalic in FTitleFont.Style;
      xlRange.Font.Underline := fsUnderline in FTitleFont.Style;
    end;

      // ��������� ��������
    if FColumnParams.Count > 0 then
    begin
      for I := 0 to nColumnCount - 1 do
      begin
        xlSheet.Columns[I + 1].ColumnWidth := FColumnParams.Items[I].Width;

        xlRange := xlSheet.Cells[nDataStart, I + 1];
        xlRange.Value := FColumnParams.Items[I].Caption;
        xlRange.HorizontalAlignment := xlCenter;
        xlRange.VerticalAlignment := xlCenter;
        xlRange.WrapText:=true;
        xlRange.Font.Name := FHeaderFont.Name;
        xlRange.Font.Size := FHeaderFont.Size;
        xlRange.Font.Color := FHeaderFont.Color;
        xlRange.Font.Bold := fsBold in FHeaderFont.Style;
        xlRange.Font.Italic := fsItalic in FHeaderFont.Style;
        xlRange.Font.Underline := fsUnderline in FHeaderFont.Style;

        if FColumnParams.Items[I].FieldName <> '' then
          FColumnParams.Items[I].FFieldExists := Assigned(FItemsDataSet.FindField(FColumnParams.Items[I].FieldName))
        else FColumnParams.Items[I].FFieldExists := False;
      end;
    end else
    begin
      for I := 0 to nColumnCount - 1 do
      begin
        xlRange := xlSheet.Cells[nDataStart, I + 1];
        xlRange.Value := FItemsDataSet.Fields.Fields[I].DisplayName;
        xlRange.HorizontalAlignment := xlCenter;
        xlRange.VerticalAlignment := xlCenter;
        xlRange.WrapText:=true;
      end;
    end;
    Inc(nDataStart);

      // ������
    FItemsDataSet.First;
    while not FItemsDataSet.Eof do
    begin

      if FColumnParams.Count > 0 then
      begin
        for I := 0 to nColumnCount - 1 do
        begin
          xlRange := xlSheet.Cells[nDataStart + nDataCount, I + 1];
          if (FColumnParams.Items[I].FCalcColumn = ccNone) and FColumnParams.Items[I].FFieldExists then
          begin
            if not FItemsDataSet.Fields.Fields[I].IsNull then
              case FColumnParams.Items[I].DataType of
                ftSmallint, ftInteger, ftWord, ftAutoInc, ftLargeint, ftBytes : xlRange.Value := FItemsDataSet.FieldByName(FColumnParams.Items[I].FieldName).AsLargeInt;
                ftDate, ftTime, ftDateTime : xlRange.Value := FItemsDataSet.FieldByName(FColumnParams.Items[I].FieldName).AsDateTime;
                ftFloat, ftCurrency, ftBCD : xlRange.Value := FItemsDataSet.FieldByName(FColumnParams.Items[I].FieldName).AsExtended;
                ftBoolean : xlRange.Value := FItemsDataSet.FieldByName(FColumnParams.Items[I].FieldName).AsBoolean;
                else xlRange.Value := FItemsDataSet.FieldByName(FColumnParams.Items[I].FieldName).AsString;
              end;
          end;
        end;
      end else
      begin
        for I := 0 to nColumnCount - 1 do
        begin
          xlRange := xlSheet.Cells[nDataStart + nDataCount, I + 1];
          if not FItemsDataSet.Fields.Fields[I].IsNull then
            case FItemsDataSet.Fields.Fields[I].DataType of
              ftSmallint, ftInteger, ftWord, ftAutoInc, ftLargeint, ftBytes : xlRange.Value := FItemsDataSet.Fields.Fields[I].AsLargeInt;
              ftDate, ftTime, ftDateTime : xlRange.Value := FItemsDataSet.Fields.Fields[I].AsDateTime;
              ftFloat, ftCurrency, ftBCD : xlRange.Value := FItemsDataSet.Fields.Fields[I].AsExtended;
              ftBoolean : xlRange.Value := FItemsDataSet.Fields.Fields[I].AsBoolean;
              else xlRange.Value := FItemsDataSet.Fields.Fields[I].AsString;
            end;
        end;
      end;

      Inc(nDataCount);
      FItemsDataSet.Next;
    end;

      // ������ ����� ������ �����
    xlRange := xlSheet.Range[xlSheet.Cells[nHeadGrid, 1], xlSheet.Cells[nHeadGrid, nColumnCount]];
    xlRange.Borders[xlEdgeLeft].Weight := xlMedium;
    xlRange.Borders[xlEdgeTop].Weight := xlMedium;
    xlRange.Borders[xlEdgeRight].Weight := xlMedium;
    xlRange.Borders[xlEdgeBottom].Weight := xlMedium;
    xlRange.Borders[xlInsideVertical].Weight := xlThin;
    xlRange.Borders[xlInsideHorizontal].Weight := xlThin;

      // ������ ����� ������ ������
    xlRange := xlSheet.Range[xlSheet.Cells[nDataStart, 1], xlSheet.Cells[nDataStart + nDataCount - 1, nColumnCount]];
    xlRange.Borders[xlEdgeLeft].Weight := xlMedium;
    xlRange.Borders[xlEdgeTop].Weight := xlMedium;
    xlRange.Borders[xlEdgeRight].Weight := xlMedium;
    xlRange.Borders[xlEdgeBottom].Weight := xlMedium;
    xlRange.Borders[xlInsideVertical].Weight := xlThin;
    xlRange.Borders[xlInsideHorizontal].Weight := xlThin;


      // ����������� ������
    if FColumnParams.Count > 0 then
    begin
      J := 1;
      for I := 0 to nColumnCount - 1 do
      begin
        xlRange := xlSheet.Range[xlSheet.Cells[nDataStart, I + 1], xlSheet.Cells[nDataStart + nDataCount - 1, I + 1]];

        case FColumnParams.Items[I].DataType of
//          ftDate, ftTime, ftDateTime : xlRange.Value := '';
          ftFloat, ftCurrency, ftBCD : xlRange.NumberFormat := '#' + GetThousandSeparator + '##0' + FormatSettings.DecimalSeparator +
                                                               CharReplay('0', FColumnParams.Items[I].DecimalPlace);
        end;

        if FColumnParams.Items[I].CalcColumn <> ccNone then
          xlRange.FormulaR1C1 := FColumnParams.Items[I].GetFormula;

        if FColumnParams.Items[I].WrapText then xlRange.WrapText:=true;
        xlRange.VerticalAlignment := xlCenter;
        xlRange.HorizontalAlignment := xlRight;

        xlRange.Font.Name := FColumnParams.Items[I].Font.Name;
        xlRange.Font.Size := FColumnParams.Items[I].Font.Size;
        xlRange.Font.Color := FColumnParams.Items[I].Font.Color;
        xlRange.Font.Bold := fsBold in FColumnParams.Items[I].Font.Style;
        xlRange.Font.Italic := fsItalic in FColumnParams.Items[I].Font.Style;
        xlRange.Font.Underline := fsUnderline in FColumnParams.Items[I].Font.Style;

        if FFooter and (FColumnParams.Items[I].FKind <> skNone) then
        begin
          xlRange := xlSheet.Range[xlSheet.Cells[nDataStart + nDataCount, J], xlSheet.Cells[nDataStart + nDataCount, I + 1]];
          xlRange.Merge;
          xlRange.VerticalAlignment := xlCenter;
          xlRange.HorizontalAlignment := xlRight;
          if FColumnParams.Items[I].DataType in [ftFloat, ftCurrency, ftBCD] then
            xlRange.NumberFormat := '#' + GetThousandSeparator + '##0' + FormatSettings.DecimalSeparator +
                                    CharReplay('0', FColumnParams.Items[I].DecimalPlace);
          case FColumnParams.Items[I].Kind of
            skSumma : xlRange.FormulaR1C1 := '=SUM(R[-' + IntToStr(nDataCount) + ']C[' + IntToStr(I - J + 1) + ']:R[-1]C[' + IntToStr(I - J + 1) + '])';
            skMax : xlRange.FormulaR1C1 := '=MAX(R[-' + IntToStr(nDataCount) + ']C[' + IntToStr(I - J + 1) + ']:R[-1]C[' + IntToStr(I - J + 1) + '])';
            skMin : xlRange.FormulaR1C1 := '=MIN(R[-' + IntToStr(nDataCount) + ']C[' + IntToStr(I - J + 1) + ']:R[-1]C[' + IntToStr(I - J + 1) + '])';
            skAverage : xlRange.FormulaR1C1 := '=AVERAGE(R[-' + IntToStr(nDataCount) + ']C[' + IntToStr(I - J + 1) + ']:R[-1]C[' + IntToStr(I - J + 1) + '])';
            skText : xlRange.Value := FColumnParams.Items[I].KindText;
          end;
          xlRange.Font.Name := FColumnParams.Items[I].Font.Name;
          xlRange.Font.Size := FColumnParams.Items[I].Font.Size;
          xlRange.Font.Color := FColumnParams.Items[I].Font.Color;
          xlRange.Font.Bold := True;
          xlRange.Font.Italic := fsItalic in FColumnParams.Items[I].Font.Style;
          xlRange.Font.Underline := fsUnderline in FColumnParams.Items[I].Font.Style;
          J := I + 2;
        end;
      end;
    end;

      // ������ ����� ������ ������
    if FFooter then
    begin
      xlRange := xlSheet.Range[xlSheet.Cells[nDataStart + nDataCount, 1], xlSheet.Cells[nDataStart + nDataCount, nColumnCount]];
      xlRange.Borders[xlEdgeLeft].Weight := xlMedium;
      xlRange.Borders[xlEdgeTop].Weight := xlMedium;
      xlRange.Borders[xlEdgeRight].Weight := xlMedium;
      xlRange.Borders[xlEdgeBottom].Weight := xlMedium;
      xlRange.Borders[xlInsideVertical].Weight := xlThin;
      xlRange.Borders[xlInsideHorizontal].Weight := xlThin;
    end;

    if FFileName <> '' then
      xlBook.SaveAs(ExtractFilePath(ParamStr(0)) + FFileName)
    else xlBook.SaveAs(ExtractFilePath(ParamStr(0)) + 'ExportToXLS');
    xlApp.Application.ScreenUpdating := true;
    xlApp.Visible := True;
  finally

  end;
end;

end.