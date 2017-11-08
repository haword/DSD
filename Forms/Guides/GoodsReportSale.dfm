object GoodsReportSaleForm: TGoodsReportSaleForm
  Left = 0
  Top = 0
  Caption = #1057#1090#1072#1090#1080#1089#1090#1080#1082#1072' '#1087#1088#1086#1076#1072#1078' '#1087#1086' '#1076#1085#1103#1084' '#1085#1077#1076#1077#1083#1080
  ClientHeight = 425
  ClientWidth = 1042
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  AddOnFormData.RefreshAction = actRefresh
  AddOnFormData.ChoiceAction = dsdChoiceGuides
  AddOnFormData.Params = FormParams
  PixelsPerInch = 96
  TextHeight = 13
  object cxGrid: TcxGrid
    Left = 0
    Top = 83
    Width = 1042
    Height = 342
    Align = alClient
    TabOrder = 0
    LookAndFeel.Kind = lfStandard
    LookAndFeel.NativeStyle = False
    LookAndFeel.SkinName = ''
    object cxGridDBTableView: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      DataController.DataSource = DataSource
      DataController.Filter.Options = [fcoCaseInsensitive]
      DataController.Filter.Active = True
      DataController.Summary.DefaultGroupSummaryItems = <
        item
          Format = ',0.####'
          Kind = skSum
          Column = Amount1
        end
        item
          Format = ',0.####'
          Kind = skSum
          Column = Amount2
        end
        item
          Format = ',0.####'
          Kind = skSum
          Column = Amount3
        end
        item
          Format = ',0.####'
          Kind = skSum
          Column = Amount4
        end
        item
          Format = ',0.####'
          Kind = skSum
          Column = Amount5
        end
        item
          Format = ',0.####'
          Kind = skSum
          Column = Amount6
        end
        item
          Format = ',0.####'
          Kind = skSum
          Column = Amount7
        end
        item
          Format = ',0.####'
          Kind = skSum
          Column = Promo1
        end
        item
          Format = ',0.####'
          Kind = skSum
          Column = Promo2
        end
        item
          Format = ',0.####'
          Kind = skSum
          Column = Promo3
        end
        item
          Format = ',0.####'
          Kind = skSum
          Column = Promo4
        end
        item
          Format = ',0.####'
          Kind = skSum
          Column = Promo5
        end
        item
          Format = ',0.####'
          Kind = skSum
          Column = Promo6
        end
        item
          Format = ',0.####'
          Kind = skSum
          Column = Promo7
        end
        item
          Format = ',0.####'
          Kind = skSum
          Column = Branch1
        end
        item
          Format = ',0.####'
          Kind = skSum
          Column = Branch2
        end
        item
          Format = ',0.####'
          Kind = skSum
          Column = Branch3
        end
        item
          Format = ',0.####'
          Kind = skSum
          Column = Branch4
        end
        item
          Format = ',0.####'
          Kind = skSum
          Column = Branch5
        end
        item
          Format = ',0.####'
          Kind = skSum
          Column = Branch6
        end
        item
          Format = ',0.####'
          Kind = skSum
          Column = Branch7
        end
        item
          Format = ',0.####'
          Kind = skSum
          Column = Order1
        end
        item
          Format = ',0.####'
          Kind = skSum
          Column = Order2
        end
        item
          Format = ',0.####'
          Kind = skSum
          Column = Order3
        end
        item
          Format = ',0.####'
          Kind = skSum
          Column = Order4
        end
        item
          Format = ',0.####'
          Kind = skSum
          Column = Order5
        end
        item
          Format = ',0.####'
          Kind = skSum
          Column = Order6
        end
        item
          Format = ',0.####'
          Kind = skSum
          Column = Order7
        end
        item
          Format = ',0.####'
          Kind = skSum
          Column = OrderPromo1
        end
        item
          Format = ',0.####'
          Kind = skSum
          Column = OrderPromo2
        end
        item
          Format = ',0.####'
          Kind = skSum
          Column = OrderPromo3
        end
        item
          Format = ',0.####'
          Kind = skSum
          Column = OrderPromo4
        end
        item
          Format = ',0.####'
          Kind = skSum
          Column = OrderPromo5
        end
        item
          Format = ',0.####'
          Kind = skSum
          Column = OrderPromo6
        end
        item
          Format = ',0.####'
          Kind = skSum
          Column = OrderPromo7
        end
        item
          Format = ',0.####'
          Kind = skSum
          Column = OrderBranch1
        end
        item
          Format = ',0.####'
          Kind = skSum
          Column = OrderBranch2
        end
        item
          Format = ',0.####'
          Kind = skSum
          Column = OrderBranch3
        end
        item
          Format = ',0.####'
          Kind = skSum
          Column = OrderBranch4
        end
        item
          Format = ',0.####'
          Kind = skSum
          Column = OrderBranch5
        end
        item
          Format = ',0.####'
          Kind = skSum
          Column = OrderBranch6
        end
        item
          Format = ',0.####'
          Kind = skSum
          Column = OrderBranch7
        end
        item
          Format = ',0.####'
          Kind = skSum
          Column = TotalAmount
        end
        item
          Format = ',0.####'
          Kind = skSum
          Column = TotalPromo
        end
        item
          Format = ',0.####'
          Kind = skSum
          Column = TotalBranch
        end
        item
          Format = ',0.####'
          Kind = skSum
          Column = TotalOrder
        end
        item
          Format = ',0.####'
          Kind = skSum
          Column = TotalOrderPromo
        end
        item
          Format = ',0.####'
          Kind = skSum
          Column = TotalOrderBranch
        end
        item
          Format = ',0.####'
          Kind = skSum
          Column = TotalAmountWithPromo
        end
        item
          Format = ',0.####'
          Kind = skSum
          Column = TotalOrderWithPromo
        end
        item
          Format = ',0.####'
          Kind = skSum
          Column = AmountPromoBranch1
        end
        item
          Format = ',0.####'
          Kind = skSum
          Column = AmountPromoBranch2
        end
        item
          Format = ',0.####'
          Kind = skSum
          Column = AmountPromoBranch3
        end
        item
          Format = ',0.####'
          Kind = skSum
          Column = AmountPromoBranch4
        end
        item
          Format = ',0.####'
          Kind = skSum
          Column = AmountPromoBranch5
        end
        item
          Format = ',0.####'
          Kind = skSum
          Column = AmountPromoBranch6
        end
        item
          Format = ',0.####'
          Kind = skSum
          Column = AmountPromoBranch7
        end
        item
          Format = ',0.####'
          Kind = skSum
          Column = TotalAmountPromoBranch
        end
        item
          Format = ',0.####'
          Kind = skSum
          Column = OrderPromoBranch1
        end
        item
          Format = ',0.####'
          Kind = skSum
          Column = OrderPromoBranch2
        end
        item
          Format = ',0.####'
          Kind = skSum
          Column = OrderPromoBranch3
        end
        item
          Format = ',0.####'
          Kind = skSum
          Column = OrderPromoBranch4
        end
        item
          Format = ',0.####'
          Kind = skSum
          Column = OrderPromoBranch5
        end
        item
          Format = ',0.####'
          Kind = skSum
          Column = OrderPromoBranch6
        end
        item
          Format = ',0.####'
          Kind = skSum
          Column = OrderPromoBranch7
        end
        item
          Format = ',0.####'
          Kind = skSum
          Column = TotalOrderPromoBranch
        end
        item
          Format = ',0.####'
          Kind = skSum
          Column = AnalysisAmount1
        end
        item
          Format = ',0.####'
          Kind = skSum
          Column = AnalysisAmount2
        end
        item
          Format = ',0.####'
          Kind = skSum
          Column = AnalysisAmount3
        end
        item
          Format = ',0.####'
          Kind = skSum
          Column = AnalysisAmount4
        end
        item
          Format = ',0.####'
          Kind = skSum
          Column = AnalysisAmount5
        end
        item
          Format = ',0.####'
          Kind = skSum
          Column = AnalysisAmount6
        end
        item
          Format = ',0.####'
          Kind = skSum
          Column = AnalysisAmount7
        end
        item
          Format = ',0.####'
          Kind = skSum
          Column = TotalAnalysisAmount
        end
        item
          Format = ',0.####'
          Kind = skSum
          Column = AnalysisOrder1
        end
        item
          Format = ',0.####'
          Kind = skSum
          Column = AnalysisOrder2
        end
        item
          Format = ',0.####'
          Kind = skSum
          Column = AnalysisOrder3
        end
        item
          Format = ',0.####'
          Kind = skSum
          Column = AnalysisOrder4
        end
        item
          Format = ',0.####'
          Kind = skSum
          Column = AnalysisOrder5
        end
        item
          Format = ',0.####'
          Kind = skSum
          Column = AnalysisOrder6
        end
        item
          Format = ',0.####'
          Kind = skSum
          Column = AnalysisOrder7
        end
        item
          Format = ',0.####'
          Kind = skSum
          Column = TotalAnalysisOrder
        end>
      DataController.Summary.FooterSummaryItems = <
        item
          Format = ',0.####'
          Kind = skSum
          Column = Amount1
        end
        item
          Format = ',0.####'
          Kind = skSum
          Column = Amount2
        end
        item
          Format = ',0.####'
          Kind = skSum
          Column = Amount3
        end
        item
          Format = ',0.####'
          Kind = skSum
          Column = Amount4
        end
        item
          Format = ',0.####'
          Kind = skSum
          Column = Amount5
        end
        item
          Format = ',0.####'
          Kind = skSum
          Column = Amount6
        end
        item
          Format = ',0.####'
          Kind = skSum
          Column = Amount7
        end
        item
          Format = ',0.####'
          Kind = skSum
          Column = Promo1
        end
        item
          Format = ',0.####'
          Kind = skSum
          Column = Promo2
        end
        item
          Format = ',0.####'
          Kind = skSum
          Column = Promo3
        end
        item
          Format = ',0.####'
          Kind = skSum
          Column = Promo4
        end
        item
          Format = ',0.####'
          Kind = skSum
          Column = Promo5
        end
        item
          Format = ',0.####'
          Kind = skSum
          Column = Promo6
        end
        item
          Format = ',0.####'
          Kind = skSum
          Column = Promo7
        end
        item
          Format = ',0.####'
          Kind = skSum
          Column = Branch1
        end
        item
          Format = ',0.####'
          Kind = skSum
          Column = Branch2
        end
        item
          Format = ',0.####'
          Kind = skSum
          Column = Branch3
        end
        item
          Format = ',0.####'
          Kind = skSum
          Column = Branch4
        end
        item
          Format = ',0.####'
          Kind = skSum
          Column = Branch5
        end
        item
          Format = ',0.####'
          Kind = skSum
          Column = Branch6
        end
        item
          Format = ',0.####'
          Kind = skSum
          Column = Branch7
        end
        item
          Format = ',0.####'
          Kind = skSum
          Column = Order1
        end
        item
          Format = ',0.####'
          Kind = skSum
          Column = Order2
        end
        item
          Format = ',0.####'
          Kind = skSum
          Column = Order3
        end
        item
          Format = ',0.####'
          Kind = skSum
          Column = Order4
        end
        item
          Format = ',0.####'
          Kind = skSum
          Column = Order5
        end
        item
          Format = ',0.####'
          Kind = skSum
          Column = Order6
        end
        item
          Format = ',0.####'
          Kind = skSum
          Column = Order7
        end
        item
          Format = ',0.####'
          Kind = skSum
          Column = OrderPromo1
        end
        item
          Format = ',0.####'
          Kind = skSum
          Column = OrderPromo2
        end
        item
          Format = ',0.####'
          Kind = skSum
          Column = OrderPromo3
        end
        item
          Format = ',0.####'
          Kind = skSum
          Column = OrderPromo4
        end
        item
          Format = ',0.####'
          Kind = skSum
          Column = OrderPromo5
        end
        item
          Format = ',0.####'
          Kind = skSum
          Column = OrderPromo6
        end
        item
          Format = ',0.####'
          Kind = skSum
          Column = OrderPromo7
        end
        item
          Format = ',0.####'
          Kind = skSum
          Column = OrderBranch1
        end
        item
          Format = ',0.####'
          Kind = skSum
          Column = OrderBranch2
        end
        item
          Format = ',0.####'
          Kind = skSum
          Column = OrderBranch3
        end
        item
          Format = ',0.####'
          Kind = skSum
          Column = OrderBranch4
        end
        item
          Format = ',0.####'
          Kind = skSum
          Column = OrderBranch5
        end
        item
          Format = ',0.####'
          Kind = skSum
          Column = OrderBranch6
        end
        item
          Format = ',0.####'
          Kind = skSum
          Column = OrderBranch7
        end
        item
          Format = #1057#1090#1088#1086#1082': ,0'
          Kind = skCount
          Column = GoodsName
        end
        item
          Format = ',0.####'
          Kind = skSum
          Column = TotalAmount
        end
        item
          Format = ',0.####'
          Kind = skSum
          Column = TotalPromo
        end
        item
          Format = ',0.####'
          Kind = skSum
          Column = TotalBranch
        end
        item
          Format = ',0.####'
          Kind = skSum
          Column = TotalOrder
        end
        item
          Format = ',0.####'
          Kind = skSum
          Column = TotalOrderPromo
        end
        item
          Format = ',0.####'
          Kind = skSum
          Column = TotalOrderBranch
        end
        item
          Format = ',0.####'
          Kind = skSum
          Column = TotalAmountWithPromo
        end
        item
          Format = ',0.####'
          Kind = skSum
          Column = TotalOrderWithPromo
        end
        item
          Format = ',0.####'
          Kind = skSum
          Column = AmountPromoBranch1
        end
        item
          Format = ',0.####'
          Kind = skSum
          Column = AmountPromoBranch2
        end
        item
          Format = ',0.####'
          Kind = skSum
          Column = AmountPromoBranch3
        end
        item
          Format = ',0.####'
          Kind = skSum
          Column = AmountPromoBranch4
        end
        item
          Format = ',0.####'
          Kind = skSum
          Column = AmountPromoBranch5
        end
        item
          Format = ',0.####'
          Kind = skSum
          Column = AmountPromoBranch6
        end
        item
          Format = ',0.####'
          Kind = skSum
          Column = AmountPromoBranch7
        end
        item
          Format = ',0.####'
          Kind = skSum
          Column = TotalAmountPromoBranch
        end
        item
          Format = ',0.####'
          Kind = skSum
          Column = OrderPromoBranch1
        end
        item
          Format = ',0.####'
          Kind = skSum
          Column = OrderPromoBranch2
        end
        item
          Format = ',0.####'
          Kind = skSum
          Column = OrderPromoBranch3
        end
        item
          Format = ',0.####'
          Kind = skSum
          Column = OrderPromoBranch4
        end
        item
          Format = ',0.####'
          Kind = skSum
          Column = OrderPromoBranch5
        end
        item
          Format = ',0.####'
          Kind = skSum
          Column = OrderPromoBranch6
        end
        item
          Format = ',0.####'
          Kind = skSum
          Column = OrderPromoBranch7
        end
        item
          Format = ',0.####'
          Kind = skSum
          Column = TotalOrderPromoBranch
        end
        item
          Format = ',0.####'
          Kind = skSum
          Column = AnalysisAmount1
        end
        item
          Format = ',0.####'
          Kind = skSum
          Column = AnalysisAmount2
        end
        item
          Format = ',0.####'
          Kind = skSum
          Column = AnalysisAmount3
        end
        item
          Format = ',0.####'
          Kind = skSum
          Column = AnalysisAmount4
        end
        item
          Format = ',0.####'
          Kind = skSum
          Column = AnalysisAmount5
        end
        item
          Format = ',0.####'
          Kind = skSum
          Column = AnalysisAmount6
        end
        item
          Format = ',0.####'
          Kind = skSum
          Column = AnalysisAmount7
        end
        item
          Format = ',0.####'
          Kind = skSum
          Column = TotalAnalysisAmount
        end
        item
          Format = ',0.####'
          Kind = skSum
          Column = AnalysisOrder1
        end
        item
          Format = ',0.####'
          Kind = skSum
          Column = AnalysisOrder2
        end
        item
          Format = ',0.####'
          Kind = skSum
          Column = AnalysisOrder3
        end
        item
          Format = ',0.####'
          Kind = skSum
          Column = AnalysisOrder4
        end
        item
          Format = ',0.####'
          Kind = skSum
          Column = AnalysisOrder5
        end
        item
          Format = ',0.####'
          Kind = skSum
          Column = AnalysisOrder6
        end
        item
          Format = ',0.####'
          Kind = skSum
          Column = AnalysisOrder7
        end
        item
          Format = ',0.####'
          Kind = skSum
          Column = TotalAnalysisOrder
        end>
      DataController.Summary.SummaryGroups = <>
      Images = dmMain.SortImageList
      OptionsBehavior.IncSearch = True
      OptionsBehavior.IncSearchItem = GoodsName
      OptionsCustomize.ColumnHiding = True
      OptionsCustomize.ColumnsQuickCustomization = True
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsView.Footer = True
      OptionsView.GroupSummaryLayout = gslAlignWithColumns
      OptionsView.HeaderAutoHeight = True
      OptionsView.Indicator = True
      Styles.StyleSheet = dmMain.cxGridTableViewStyleSheet
      object UnitName: TcxGridDBColumn
        Caption = #1055#1086#1076#1088#1072#1079#1076#1077#1083#1077#1085#1080#1077
        DataBinding.FieldName = 'UnitName'
        HeaderAlignmentHorz = taCenter
        HeaderAlignmentVert = vaCenter
        Options.Editing = False
        Width = 118
      end
      object GoodsPlatformName: TcxGridDBColumn
        Caption = #1055#1088#1086#1080#1079#1074#1086#1076#1089#1090#1074#1077#1085#1085#1072#1103' '#1087#1083#1086#1097#1072#1076#1082#1072
        DataBinding.FieldName = 'GoodsPlatformName'
        HeaderAlignmentHorz = taCenter
        HeaderAlignmentVert = vaCenter
        Width = 120
      end
      object TradeMarkName: TcxGridDBColumn
        Caption = #1058#1086#1088#1075#1086#1074#1072#1103' '#1084#1072#1088#1082#1072
        DataBinding.FieldName = 'TradeMarkName'
        HeaderAlignmentHorz = taCenter
        HeaderAlignmentVert = vaCenter
        Width = 100
      end
      object GoodsGroupAnalystName: TcxGridDBColumn
        Caption = #1043#1088#1091#1087#1087#1072' '#1072#1085#1072#1083#1080#1090#1080#1082#1080
        DataBinding.FieldName = 'GoodsGroupAnalystName'
        HeaderAlignmentHorz = taCenter
        HeaderAlignmentVert = vaCenter
        Width = 100
      end
      object GoodsTagName: TcxGridDBColumn
        Caption = #1055#1088#1080#1079#1085#1072#1082' '#1090#1086#1074#1072#1088#1072
        DataBinding.FieldName = 'GoodsTagName'
        HeaderAlignmentHorz = taCenter
        HeaderAlignmentVert = vaCenter
        Width = 80
      end
      object GoodsGroupNameFull: TcxGridDBColumn
        Caption = #1043#1088#1091#1087#1087#1072' ('#1074#1089#1077')'
        DataBinding.FieldName = 'GoodsGroupNameFull'
        HeaderAlignmentHorz = taCenter
        HeaderAlignmentVert = vaCenter
        Width = 150
      end
      object GoodsGroupName: TcxGridDBColumn
        Caption = #1043#1088#1091#1087#1087#1072
        DataBinding.FieldName = 'GoodsGroupName'
        Visible = False
        HeaderAlignmentHorz = taCenter
        HeaderAlignmentVert = vaCenter
        Width = 172
      end
      object InfoMoneyCode: TcxGridDBColumn
        Caption = #1050#1086#1076' '#1059#1055
        DataBinding.FieldName = 'InfoMoneyCode'
        HeaderAlignmentHorz = taCenter
        HeaderAlignmentVert = vaCenter
        Width = 55
      end
      object InfoMoneyName: TcxGridDBColumn
        Caption = #1059#1055' '#1089#1090#1072#1090#1100#1103' '#1085#1072#1079#1085#1072#1095#1077#1085#1080#1103
        DataBinding.FieldName = 'InfoMoneyName'
        HeaderAlignmentHorz = taCenter
        HeaderAlignmentVert = vaCenter
        Width = 100
      end
      object GoodsCode: TcxGridDBColumn
        Caption = #1050#1086#1076
        DataBinding.FieldName = 'GoodsCode'
        HeaderAlignmentVert = vaCenter
        HeaderHint = #1050#1086#1076' '#1090#1086#1074#1072#1088#1072
        Options.Editing = False
        Width = 52
      end
      object GoodsName: TcxGridDBColumn
        Caption = #1058#1086#1074#1072#1088
        DataBinding.FieldName = 'GoodsName'
        HeaderAlignmentHorz = taCenter
        HeaderAlignmentVert = vaCenter
        Options.Editing = False
        Width = 86
      end
      object GoodsKindName: TcxGridDBColumn
        Caption = #1042#1080#1076' '#1090#1086#1074#1072#1088#1072
        DataBinding.FieldName = 'GoodsKindName'
        HeaderAlignmentHorz = taCenter
        HeaderAlignmentVert = vaCenter
        Options.Editing = False
        Width = 84
      end
      object MeasureName: TcxGridDBColumn
        Caption = #1045#1076'. '#1080#1079#1084'.'
        DataBinding.FieldName = 'MeasureName'
        HeaderAlignmentHorz = taCenter
        HeaderAlignmentVert = vaCenter
        Options.Editing = False
        Width = 50
      end
      object Weight: TcxGridDBColumn
        Caption = #1042#1077#1089
        DataBinding.FieldName = 'Weight'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = ',0.###;-,0.###; ;'
        Visible = False
        HeaderAlignmentHorz = taCenter
        HeaderAlignmentVert = vaCenter
        Options.Editing = False
        Width = 45
      end
      object TotalAmountWithPromo: TcxGridDBColumn
        Caption = #1048#1058#1054#1043#1054' '#1050#1086#1083'-'#1074#1086' '#1088#1077#1072#1083#1080#1079'. + '#1040#1082#1094#1080#1080
        DataBinding.FieldName = 'TotalAmountWithPromo'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = ',0.00##;-,0.00##; ;'
        HeaderAlignmentHorz = taCenter
        HeaderAlignmentVert = vaCenter
        Options.Editing = False
        Width = 95
      end
      object TotalAmount: TcxGridDBColumn
        Caption = #1048#1058#1054#1043#1054' '#1050#1086#1083'-'#1074#1086' '#1088#1077#1072#1083#1080#1079'.'
        DataBinding.FieldName = 'TotalAmount'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = ',0.00##;-,0.00##; ;'
        HeaderAlignmentHorz = taCenter
        HeaderAlignmentVert = vaCenter
        HeaderHint = #1073#1077#1079' '#1040#1082#1094#1080#1081
        Options.Editing = False
        Width = 95
      end
      object TotalPromo: TcxGridDBColumn
        Caption = #1048#1058#1054#1043#1054' '#1050#1086#1083'-'#1074#1086' '#1088#1077#1072#1083#1080#1079'. '#1040#1082#1094#1080#1080
        DataBinding.FieldName = 'TotalPromo'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = ',0.00##;-,0.00##; ;'
        HeaderAlignmentHorz = taCenter
        HeaderAlignmentVert = vaCenter
        HeaderHint = #1058#1086#1083#1100#1082#1086' '#1040#1082#1094#1080#1080
        Options.Editing = False
        Width = 95
      end
      object TotalBranch: TcxGridDBColumn
        Caption = #1048#1058#1054#1043#1054' '#1050#1086#1083'-'#1074#1086' '#1088#1072#1089#1093'. '#1085#1072' '#1092#1080#1083#1080#1072#1083
        DataBinding.FieldName = 'TotalBranch'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = ',0.00##;-,0.00##; ;'
        HeaderAlignmentHorz = taCenter
        HeaderAlignmentVert = vaCenter
        Options.Editing = False
        Width = 95
      end
      object TotalOrderBranch: TcxGridDBColumn
        Caption = #1048#1058#1054#1043#1054' '#1050#1086#1083'-'#1074#1086' '#1079#1072#1103#1074#1086#1082' '#1060#1080#1083#1080#1072#1083
        DataBinding.FieldName = 'TotalOrderBranch'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = ',0.00##;-,0.00##; ;'
        HeaderAlignmentHorz = taCenter
        HeaderAlignmentVert = vaCenter
        Options.Editing = False
        Width = 95
      end
      object TotalOrderWithPromo: TcxGridDBColumn
        Caption = #1048#1058#1054#1043#1054' '#1050#1086#1083'-'#1074#1086' '#1079#1072#1103#1074#1086#1082' + '#1040#1082#1094#1080#1080
        DataBinding.FieldName = 'TotalOrderWithPromo'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = ',0.00##;-,0.00##; ;'
        HeaderAlignmentHorz = taCenter
        HeaderAlignmentVert = vaCenter
        Options.Editing = False
        Width = 95
      end
      object TotalOrder: TcxGridDBColumn
        Caption = #1048#1058#1054#1043#1054' '#1050#1086#1083'-'#1074#1086' '#1079#1072#1103#1074#1086#1082
        DataBinding.FieldName = 'TotalOrder'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = ',0.00##;-,0.00##; ;'
        HeaderAlignmentHorz = taCenter
        HeaderAlignmentVert = vaCenter
        HeaderHint = #1073#1077#1079' '#1040#1082#1094#1080#1081
        Options.Editing = False
        Width = 95
      end
      object TotalOrderPromo: TcxGridDBColumn
        Caption = #1048#1058#1054#1043#1054' '#1050#1086#1083'-'#1074#1086' '#1079#1072#1103#1074#1086#1082' '#1040#1082#1094#1080#1103
        DataBinding.FieldName = 'TotalOrderPromo'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = ',0.00##;-,0.00##; ;'
        HeaderAlignmentHorz = taCenter
        HeaderAlignmentVert = vaCenter
        HeaderHint = #1058#1086#1083#1100#1082#1086' '#1040#1082#1094#1080#1080
        Options.Editing = False
        Width = 95
      end
      object TotalAmountPromoBranch: TcxGridDBColumn
        Caption = #1048#1058#1054#1043#1054' '#1050#1086#1083'-'#1074#1086' '#1088#1077#1072#1083#1080#1079' . + '#1072#1082#1094#1080#1080' + '#1088#1072#1089#1093'. '#1085#1072' '#1092#1080#1083#1080#1072#1083
        DataBinding.FieldName = 'TotalAmountPromoBranch'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = ',0.00##;-,0.00##; ;'
        HeaderAlignmentHorz = taCenter
        HeaderAlignmentVert = vaCenter
        HeaderHint = #1048#1090#1086#1075#1086' '#1088#1077#1072#1083#1080#1079' + '#1072#1082#1094#1080#1080' + '#1085#1072' '#1092#1080#1083#1080#1072#1083
        Options.Editing = False
        Width = 95
      end
      object TotalOrderPromoBranch: TcxGridDBColumn
        Caption = #1048#1058#1054#1043#1054' '#1050#1086#1083'-'#1074#1086' '#1079#1072#1103#1074#1082#1080' + '#1072#1082#1094#1080#1080' + '#1079#1072#1103#1074#1082#1080' '#1092#1080#1083#1080#1072#1083
        DataBinding.FieldName = 'TotalOrderPromoBranch'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = ',0.00##;-,0.00##; ;'
        HeaderAlignmentHorz = taCenter
        HeaderAlignmentVert = vaCenter
        HeaderHint = #1048#1090#1086#1075#1086' '#1079#1072#1103#1074#1082#1080' + '#1072#1082#1094#1080#1080' + '#1092#1080#1083#1080#1072#1083
        Options.Editing = False
        Width = 95
      end
      object TotalAnalysisAmount: TcxGridDBColumn
        Caption = #1048#1058#1054#1043#1054' '#1050#1086#1083'-'#1074#1086' '#1088#1077#1072#1083#1080#1079' + '#1088#1072#1089#1093'. '#1085#1072' '#1092#1080#1083#1080#1072#1083
        DataBinding.FieldName = 'TotalAnalysisAmount'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = ',0.00##;-,0.00##; ;'
        HeaderAlignmentHorz = taCenter
        HeaderAlignmentVert = vaCenter
        HeaderHint = #1048#1090#1086#1075#1086' '#1088#1077#1072#1083#1080#1079' + '#1085#1072' '#1092#1080#1083#1080#1072#1083
        Options.Editing = False
        Width = 95
      end
      object TotalAnalysisOrder: TcxGridDBColumn
        Caption = #1048#1058#1054#1043#1054' '#1050#1086#1083'-'#1074#1086'  '#1079#1072#1103#1074#1082#1080' + '#1079#1072#1103#1074#1082#1080' '#1092#1080#1083#1080#1072#1083
        DataBinding.FieldName = 'TotalAnalysisOrder'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = ',0.00##;-,0.00##; ;'
        HeaderAlignmentHorz = taCenter
        HeaderAlignmentVert = vaCenter
        HeaderHint = #1048#1090#1086#1075#1086' '#1079#1072#1103#1074#1082#1080' + '#1092#1080#1083#1080#1072#1083
        Options.Editing = False
        Width = 95
      end
      object Amount1: TcxGridDBColumn
        Caption = #1050#1086#1083'-'#1074#1086' '#1088#1077#1072#1083#1080#1079'. '#1079#1072' 1'
        DataBinding.FieldName = 'Amount1'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = ',0.00##;-,0.00##; ;'
        HeaderAlignmentHorz = taCenter
        HeaderAlignmentVert = vaCenter
        HeaderHint = #1073#1077#1079' '#1040#1082#1094#1080#1081
        Options.Editing = False
        Width = 95
      end
      object Amount2: TcxGridDBColumn
        Caption = #1050#1086#1083'-'#1074#1086' '#1088#1077#1072#1083#1080#1079'. '#1079#1072' 2'
        DataBinding.FieldName = 'Amount2'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = ',0.00##;-,0.00##; ;'
        HeaderAlignmentHorz = taCenter
        HeaderAlignmentVert = vaCenter
        HeaderHint = #1073#1077#1079' '#1040#1082#1094#1080#1081
        Options.Editing = False
        Width = 95
      end
      object Amount3: TcxGridDBColumn
        Caption = #1050#1086#1083'-'#1074#1086' '#1088#1077#1072#1083#1080#1079'. '#1079#1072' 3'
        DataBinding.FieldName = 'Amount3'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = ',0.00##;-,0.00##; ;'
        HeaderAlignmentHorz = taCenter
        HeaderAlignmentVert = vaCenter
        HeaderHint = #1073#1077#1079' '#1040#1082#1094#1080#1081
        Options.Editing = False
        Width = 95
      end
      object Amount4: TcxGridDBColumn
        Caption = #1050#1086#1083'-'#1074#1086' '#1088#1077#1072#1083#1080#1079'. '#1079#1072' 4'
        DataBinding.FieldName = 'Amount4'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = ',0.00##;-,0.00##; ;'
        HeaderAlignmentHorz = taCenter
        HeaderAlignmentVert = vaCenter
        HeaderHint = #1073#1077#1079' '#1040#1082#1094#1080#1081
        Options.Editing = False
        Width = 95
      end
      object Amount5: TcxGridDBColumn
        Caption = #1050#1086#1083'-'#1074#1086' '#1088#1077#1072#1083#1080#1079'. '#1079#1072' 5'
        DataBinding.FieldName = 'Amount5'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = ',0.00##;-,0.00##; ;'
        HeaderAlignmentHorz = taCenter
        HeaderAlignmentVert = vaCenter
        HeaderHint = #1073#1077#1079' '#1040#1082#1094#1080#1081
        Options.Editing = False
        Width = 95
      end
      object Amount6: TcxGridDBColumn
        Caption = #1050#1086#1083'-'#1074#1086' '#1088#1077#1072#1083#1080#1079'. '#1079#1072' 6'
        DataBinding.FieldName = 'Amount6'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = ',0.00##;-,0.00##; ;'
        HeaderAlignmentHorz = taCenter
        HeaderAlignmentVert = vaCenter
        HeaderHint = #1073#1077#1079' '#1040#1082#1094#1080#1081
        Options.Editing = False
        Width = 95
      end
      object Amount7: TcxGridDBColumn
        Caption = #1050#1086#1083'-'#1074#1086' '#1088#1077#1072#1083#1080#1079'. '#1079#1072' 7'
        DataBinding.FieldName = 'Amount7'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = ',0.00##;-,0.00##; ;'
        HeaderAlignmentHorz = taCenter
        HeaderAlignmentVert = vaCenter
        HeaderHint = #1073#1077#1079' '#1040#1082#1094#1080#1081
        Options.Editing = False
        Width = 95
      end
      object Promo1: TcxGridDBColumn
        Caption = #1050#1086#1083'-'#1074#1086' '#1088#1077#1072#1083#1080#1079'. '#1040#1082#1094#1080#1080' '#1079#1072' 1'
        DataBinding.FieldName = 'Promo1'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = ',0.00##;-,0.00##; ;'
        HeaderAlignmentHorz = taCenter
        HeaderAlignmentVert = vaCenter
        HeaderHint = #1058#1086#1083#1100#1082#1086' '#1040#1082#1094#1080#1080
        Options.Editing = False
        Width = 95
      end
      object Promo2: TcxGridDBColumn
        Caption = #1050#1086#1083'-'#1074#1086' '#1088#1077#1072#1083#1080#1079'. '#1040#1082#1094#1080#1080' '#1079#1072' 2'
        DataBinding.FieldName = 'Promo2'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = ',0.00##;-,0.00##; ;'
        HeaderAlignmentHorz = taCenter
        HeaderAlignmentVert = vaCenter
        HeaderHint = #1058#1086#1083#1100#1082#1086' '#1040#1082#1094#1080#1080
        Options.Editing = False
        Width = 95
      end
      object Promo3: TcxGridDBColumn
        Caption = #1050#1086#1083'-'#1074#1086' '#1088#1077#1072#1083#1080#1079'. '#1040#1082#1094#1080#1080' '#1079#1072' 3'
        DataBinding.FieldName = 'Promo3'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = ',0.00##;-,0.00##; ;'
        HeaderAlignmentHorz = taCenter
        HeaderAlignmentVert = vaCenter
        HeaderHint = #1058#1086#1083#1100#1082#1086' '#1040#1082#1094#1080#1080
        Options.Editing = False
        Width = 95
      end
      object Promo4: TcxGridDBColumn
        Caption = #1050#1086#1083'-'#1074#1086' '#1088#1077#1072#1083#1080#1079'. '#1040#1082#1094#1080#1080' '#1079#1072' 4'
        DataBinding.FieldName = 'Promo4'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = ',0.00##;-,0.00##; ;'
        HeaderAlignmentHorz = taCenter
        HeaderAlignmentVert = vaCenter
        HeaderHint = #1058#1086#1083#1100#1082#1086' '#1040#1082#1094#1080#1080
        Options.Editing = False
        Width = 95
      end
      object Promo5: TcxGridDBColumn
        Caption = #1050#1086#1083'-'#1074#1086' '#1088#1077#1072#1083#1080#1079'. '#1040#1082#1094#1080#1080' '#1079#1072' 5'
        DataBinding.FieldName = 'Promo5'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = ',0.00##;-,0.00##; ;'
        HeaderAlignmentHorz = taCenter
        HeaderAlignmentVert = vaCenter
        HeaderHint = #1058#1086#1083#1100#1082#1086' '#1040#1082#1094#1080#1080
        Options.Editing = False
        Width = 95
      end
      object Promo6: TcxGridDBColumn
        Caption = #1050#1086#1083'-'#1074#1086' '#1088#1077#1072#1083#1080#1079'. '#1040#1082#1094#1080#1080' '#1079#1072' 6'
        DataBinding.FieldName = 'Promo6'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = ',0.00##;-,0.00##; ;'
        HeaderAlignmentHorz = taCenter
        HeaderAlignmentVert = vaCenter
        HeaderHint = #1058#1086#1083#1100#1082#1086' '#1040#1082#1094#1080#1080
        Options.Editing = False
        Width = 95
      end
      object Promo7: TcxGridDBColumn
        Caption = #1050#1086#1083'-'#1074#1086' '#1088#1077#1072#1083#1080#1079'. '#1040#1082#1094#1080#1080' '#1079#1072' 7'
        DataBinding.FieldName = 'Promo7'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = ',0.00##;-,0.00##; ;'
        HeaderAlignmentHorz = taCenter
        HeaderAlignmentVert = vaCenter
        HeaderHint = #1058#1086#1083#1100#1082#1086' '#1040#1082#1094#1080#1080
        Options.Editing = False
        Width = 95
      end
      object Branch1: TcxGridDBColumn
        Caption = #1050#1086#1083'-'#1074#1086' '#1088#1072#1089#1093'. '#1085#1072' '#1092#1080#1083#1080#1072#1083' '#1079#1072' 1'
        DataBinding.FieldName = 'Branch1'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = ',0.00##;-,0.00##; ;'
        HeaderAlignmentHorz = taCenter
        HeaderAlignmentVert = vaCenter
        Options.Editing = False
        Width = 95
      end
      object Branch2: TcxGridDBColumn
        Caption = #1050#1086#1083'-'#1074#1086' '#1088#1072#1089#1093'. '#1085#1072' '#1092#1080#1083#1080#1072#1083' '#1079#1072' 2'
        DataBinding.FieldName = 'Branch2'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = ',0.00##;-,0.00##; ;'
        HeaderAlignmentHorz = taCenter
        HeaderAlignmentVert = vaCenter
        Options.Editing = False
        Width = 95
      end
      object Branch3: TcxGridDBColumn
        Caption = #1050#1086#1083'-'#1074#1086' '#1088#1072#1089#1093'. '#1085#1072' '#1092#1080#1083#1080#1072#1083' '#1079#1072' 3'
        DataBinding.FieldName = 'Branch3'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = ',0.00##;-,0.00##; ;'
        HeaderAlignmentHorz = taCenter
        HeaderAlignmentVert = vaCenter
        Options.Editing = False
        Width = 95
      end
      object Branch4: TcxGridDBColumn
        Caption = #1050#1086#1083'-'#1074#1086' '#1088#1072#1089#1093'. '#1085#1072' '#1092#1080#1083#1080#1072#1083' '#1079#1072' 4'
        DataBinding.FieldName = 'Branch4'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = ',0.00##;-,0.00##; ;'
        HeaderAlignmentHorz = taCenter
        HeaderAlignmentVert = vaCenter
        Options.Editing = False
        Width = 95
      end
      object Branch5: TcxGridDBColumn
        Caption = #1050#1086#1083'-'#1074#1086' '#1088#1072#1089#1093'. '#1085#1072' '#1092#1080#1083#1080#1072#1083' '#1079#1072' 5'
        DataBinding.FieldName = 'Branch5'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = ',0.00##;-,0.00##; ;'
        HeaderAlignmentHorz = taCenter
        HeaderAlignmentVert = vaCenter
        Options.Editing = False
        Width = 95
      end
      object Branch6: TcxGridDBColumn
        Caption = #1050#1086#1083'-'#1074#1086' '#1088#1072#1089#1093'. '#1085#1072' '#1092#1080#1083#1080#1072#1083' '#1079#1072' 6.'
        DataBinding.FieldName = 'Branch6'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = ',0.00##;-,0.00##; ;'
        HeaderAlignmentHorz = taCenter
        HeaderAlignmentVert = vaCenter
        Options.Editing = False
        Width = 95
      end
      object Branch7: TcxGridDBColumn
        Caption = #1050#1086#1083'-'#1074#1086' '#1088#1072#1089#1093'. '#1085#1072' '#1092#1080#1083#1080#1072#1083' '#1079#1072' 7'
        DataBinding.FieldName = 'Branch7'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = ',0.00##;-,0.00##; ;'
        HeaderAlignmentHorz = taCenter
        HeaderAlignmentVert = vaCenter
        Options.Editing = False
        Width = 95
      end
      object Order1: TcxGridDBColumn
        Caption = #1050#1086#1083'-'#1074#1086' '#1079#1072#1103#1074#1086#1082' '#1079#1072' 1'
        DataBinding.FieldName = 'Order1'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = ',0.00##;-,0.00##; ;'
        HeaderAlignmentHorz = taCenter
        HeaderAlignmentVert = vaCenter
        HeaderHint = #1073#1077#1079' '#1040#1082#1094#1080#1081
        Options.Editing = False
        Width = 95
      end
      object Order2: TcxGridDBColumn
        Caption = #1050#1086#1083'-'#1074#1086' '#1079#1072#1103#1074#1086#1082' '#1079#1072' 2'
        DataBinding.FieldName = 'Order2'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = ',0.00##;-,0.00##; ;'
        HeaderAlignmentHorz = taCenter
        HeaderAlignmentVert = vaCenter
        HeaderHint = #1073#1077#1079' '#1040#1082#1094#1080#1081
        Options.Editing = False
        Width = 95
      end
      object Order3: TcxGridDBColumn
        Caption = #1050#1086#1083'-'#1074#1086' '#1079#1072#1103#1074#1086#1082' '#1079#1072' 3'
        DataBinding.FieldName = 'Order3'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = ',0.00##;-,0.00##; ;'
        HeaderAlignmentHorz = taCenter
        HeaderAlignmentVert = vaCenter
        HeaderHint = #1073#1077#1079' '#1040#1082#1094#1080#1081
        Options.Editing = False
        Width = 95
      end
      object Order4: TcxGridDBColumn
        Caption = #1050#1086#1083'-'#1074#1086' '#1079#1072#1103#1074#1086#1082' '#1079#1072' 4'
        DataBinding.FieldName = 'Order4'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = ',0.00##;-,0.00##; ;'
        HeaderAlignmentHorz = taCenter
        HeaderAlignmentVert = vaCenter
        HeaderHint = #1073#1077#1079' '#1040#1082#1094#1080#1081
        Options.Editing = False
        Width = 95
      end
      object Order5: TcxGridDBColumn
        Caption = #1050#1086#1083'-'#1074#1086' '#1079#1072#1103#1074#1086#1082' '#1079#1072' 5'
        DataBinding.FieldName = 'Order5'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = ',0.00##;-,0.00##; ;'
        HeaderAlignmentHorz = taCenter
        HeaderAlignmentVert = vaCenter
        HeaderHint = #1073#1077#1079' '#1040#1082#1094#1080#1081
        Options.Editing = False
        Width = 95
      end
      object Order6: TcxGridDBColumn
        Caption = #1050#1086#1083'-'#1074#1086' '#1079#1072#1103#1074#1086#1082' '#1079#1072' 6'
        DataBinding.FieldName = 'Order6'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = ',0.00##;-,0.00##; ;'
        HeaderAlignmentHorz = taCenter
        HeaderAlignmentVert = vaCenter
        HeaderHint = #1073#1077#1079' '#1040#1082#1094#1080#1081
        Options.Editing = False
        Width = 95
      end
      object Order7: TcxGridDBColumn
        Caption = #1050#1086#1083'-'#1074#1086' '#1079#1072#1103#1074#1086#1082' '#1079#1072' 7'
        DataBinding.FieldName = 'Order7'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = ',0.00##;-,0.00##; ;'
        HeaderAlignmentHorz = taCenter
        HeaderAlignmentVert = vaCenter
        HeaderHint = #1073#1077#1079' '#1040#1082#1094#1080#1081
        Options.Editing = False
        Width = 95
      end
      object OrderPromo1: TcxGridDBColumn
        Caption = #1050#1086#1083'-'#1074#1086' '#1079#1072#1103#1074#1086#1082' '#1040#1082#1094#1080#1103' '#1079#1072' 1'
        DataBinding.FieldName = 'OrderPromo1'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = ',0.00##;-,0.00##; ;'
        HeaderAlignmentHorz = taCenter
        HeaderAlignmentVert = vaCenter
        HeaderHint = #1058#1086#1083#1100#1082#1086' '#1040#1082#1094#1080#1080
        Options.Editing = False
        Width = 95
      end
      object OrderPromo2: TcxGridDBColumn
        Caption = #1050#1086#1083'-'#1074#1086' '#1079#1072#1103#1074#1086#1082' '#1040#1082#1094#1080#1103' '#1079#1072' 2'
        DataBinding.FieldName = 'OrderPromo2'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = ',0.00##;-,0.00##; ;'
        HeaderAlignmentHorz = taCenter
        HeaderAlignmentVert = vaCenter
        HeaderHint = #1058#1086#1083#1100#1082#1086' '#1040#1082#1094#1080#1080
        Options.Editing = False
        Width = 95
      end
      object OrderPromo3: TcxGridDBColumn
        Caption = #1050#1086#1083'-'#1074#1086' '#1079#1072#1103#1074#1086#1082' '#1040#1082#1094#1080#1103' '#1079#1072' 3'
        DataBinding.FieldName = 'OrderPromo3'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = ',0.00##;-,0.00##; ;'
        HeaderAlignmentHorz = taCenter
        HeaderAlignmentVert = vaCenter
        HeaderHint = #1058#1086#1083#1100#1082#1086' '#1040#1082#1094#1080#1080
        Options.Editing = False
        Width = 95
      end
      object OrderPromo4: TcxGridDBColumn
        Caption = #1050#1086#1083'-'#1074#1086' '#1079#1072#1103#1074#1086#1082' '#1040#1082#1094#1080#1103' '#1079#1072' 4'
        DataBinding.FieldName = 'OrderPromo4'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = ',0.00##;-,0.00##; ;'
        HeaderAlignmentHorz = taCenter
        HeaderAlignmentVert = vaCenter
        HeaderHint = #1058#1086#1083#1100#1082#1086' '#1040#1082#1094#1080#1080
        Options.Editing = False
        Width = 95
      end
      object OrderPromo5: TcxGridDBColumn
        Caption = #1050#1086#1083'-'#1074#1086' '#1079#1072#1103#1074#1086#1082' '#1040#1082#1094#1080#1103' '#1079#1072' 5'
        DataBinding.FieldName = 'OrderPromo5'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = ',0.00##;-,0.00##; ;'
        HeaderAlignmentHorz = taCenter
        HeaderAlignmentVert = vaCenter
        HeaderHint = #1058#1086#1083#1100#1082#1086' '#1040#1082#1094#1080#1080
        Options.Editing = False
        Width = 95
      end
      object OrderPromo6: TcxGridDBColumn
        Caption = #1050#1086#1083'-'#1074#1086' '#1079#1072#1103#1074#1086#1082' '#1040#1082#1094#1080#1103' '#1079#1072' 6'
        DataBinding.FieldName = 'OrderPromo6'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = ',0.00##;-,0.00##; ;'
        HeaderAlignmentHorz = taCenter
        HeaderAlignmentVert = vaCenter
        HeaderHint = #1058#1086#1083#1100#1082#1086' '#1040#1082#1094#1080#1080
        Options.Editing = False
        Width = 95
      end
      object OrderPromo7: TcxGridDBColumn
        Caption = #1050#1086#1083'-'#1074#1086' '#1079#1072#1103#1074#1086#1082' '#1040#1082#1094#1080#1103' '#1079#1072' 7'
        DataBinding.FieldName = 'OrderPromo7'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = ',0.00##;-,0.00##; ;'
        HeaderAlignmentHorz = taCenter
        HeaderAlignmentVert = vaCenter
        HeaderHint = #1058#1086#1083#1100#1082#1086' '#1040#1082#1094#1080#1080
        Options.Editing = False
        Width = 95
      end
      object OrderBranch1: TcxGridDBColumn
        Caption = #1050#1086#1083'-'#1074#1086' '#1079#1072#1103#1074#1086#1082' '#1060#1080#1083#1080#1072#1083' '#1079#1072' 1'
        DataBinding.FieldName = 'OrderBranch1'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = ',0.00##;-,0.00##; ;'
        HeaderAlignmentHorz = taCenter
        HeaderAlignmentVert = vaCenter
        Options.Editing = False
        Width = 95
      end
      object OrderBranch2: TcxGridDBColumn
        Caption = #1050#1086#1083'-'#1074#1086' '#1079#1072#1103#1074#1086#1082' '#1060#1080#1083#1080#1072#1083' '#1079#1072' 2'
        DataBinding.FieldName = 'OrderBranch2'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = ',0.00##;-,0.00##; ;'
        HeaderAlignmentHorz = taCenter
        HeaderAlignmentVert = vaCenter
        Options.Editing = False
        Width = 95
      end
      object OrderBranch3: TcxGridDBColumn
        Caption = #1050#1086#1083'-'#1074#1086' '#1079#1072#1103#1074#1086#1082' '#1060#1080#1083#1080#1072#1083' '#1079#1072' 3'
        DataBinding.FieldName = 'OrderBranch3'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = ',0.00##;-,0.00##; ;'
        HeaderAlignmentHorz = taCenter
        HeaderAlignmentVert = vaCenter
        Options.Editing = False
        Width = 95
      end
      object OrderBranch4: TcxGridDBColumn
        Caption = #1050#1086#1083'-'#1074#1086' '#1079#1072#1103#1074#1086#1082' '#1060#1080#1083#1080#1072#1083' '#1079#1072' 4'
        DataBinding.FieldName = 'OrderBranch4'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = ',0.00##;-,0.00##; ;'
        HeaderAlignmentHorz = taCenter
        HeaderAlignmentVert = vaCenter
        Options.Editing = False
        Width = 95
      end
      object OrderBranch5: TcxGridDBColumn
        Caption = #1050#1086#1083'-'#1074#1086' '#1079#1072#1103#1074#1086#1082' '#1060#1080#1083#1080#1072#1083' '#1079#1072' 5'
        DataBinding.FieldName = 'OrderBranch5'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = ',0.00##;-,0.00##; ;'
        HeaderAlignmentHorz = taCenter
        HeaderAlignmentVert = vaCenter
        Options.Editing = False
        Width = 95
      end
      object OrderBranch6: TcxGridDBColumn
        Caption = #1050#1086#1083'-'#1074#1086' '#1079#1072#1103#1074#1086#1082' '#1060#1080#1083#1080#1072#1083' '#1079#1072' 6'
        DataBinding.FieldName = 'OrderBranch6'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = ',0.00##;-,0.00##; ;'
        HeaderAlignmentHorz = taCenter
        HeaderAlignmentVert = vaCenter
        Options.Editing = False
        Width = 95
      end
      object OrderBranch7: TcxGridDBColumn
        Caption = #1050#1086#1083'-'#1074#1086' '#1079#1072#1103#1074#1086#1082' '#1060#1080#1083#1080#1072#1083' '#1079#1072' 7'
        DataBinding.FieldName = 'OrderBranch7'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = ',0.00##;-,0.00##; ;'
        HeaderAlignmentHorz = taCenter
        HeaderAlignmentVert = vaCenter
        Options.Editing = False
        Width = 95
      end
      object AmountPromoBranch1: TcxGridDBColumn
        Caption = #1050#1086#1083'-'#1074#1086' '#1088#1072#1089#1093'. '#1079#1072' 1'
        DataBinding.FieldName = 'AmountPromoBranch1'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = ',0.00##;-,0.00##; ;'
        HeaderAlignmentHorz = taCenter
        HeaderAlignmentVert = vaCenter
        Options.Editing = False
        Width = 95
      end
      object AmountPromoBranch2: TcxGridDBColumn
        Caption = #1050#1086#1083'-'#1074#1086' '#1088#1072#1089#1093'. '#1079#1072' 2'
        DataBinding.FieldName = 'AmountPromoBranch2'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = ',0.00##;-,0.00##; ;'
        HeaderAlignmentHorz = taCenter
        HeaderAlignmentVert = vaCenter
        Options.Editing = False
        Width = 95
      end
      object AmountPromoBranch3: TcxGridDBColumn
        Caption = #1050#1086#1083'-'#1074#1086' '#1088#1072#1089#1093'. '#1079#1072' 3'
        DataBinding.FieldName = 'AmountPromoBranch3'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = ',0.00##;-,0.00##; ;'
        HeaderAlignmentHorz = taCenter
        HeaderAlignmentVert = vaCenter
        Options.Editing = False
        Width = 95
      end
      object AmountPromoBranch4: TcxGridDBColumn
        Caption = #1050#1086#1083'-'#1074#1086' '#1088#1072#1089#1093'. '#1079#1072' 4'
        DataBinding.FieldName = 'AmountPromoBranch4'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = ',0.00##;-,0.00##; ;'
        HeaderAlignmentHorz = taCenter
        HeaderAlignmentVert = vaCenter
        Options.Editing = False
        Width = 95
      end
      object AmountPromoBranch5: TcxGridDBColumn
        Caption = #1050#1086#1083'-'#1074#1086' '#1088#1072#1089#1093'. '#1079#1072' 5'
        DataBinding.FieldName = 'AmountPromoBranch5'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = ',0.00##;-,0.00##; ;'
        HeaderAlignmentHorz = taCenter
        HeaderAlignmentVert = vaCenter
        Options.Editing = False
        Width = 95
      end
      object AmountPromoBranch6: TcxGridDBColumn
        Caption = #1050#1086#1083'-'#1074#1086' '#1088#1072#1089#1093'. '#1079#1072' 6'
        DataBinding.FieldName = 'AmountPromoBranch6'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = ',0.00##;-,0.00##; ;'
        HeaderAlignmentHorz = taCenter
        HeaderAlignmentVert = vaCenter
        Options.Editing = False
        Width = 95
      end
      object AmountPromoBranch7: TcxGridDBColumn
        Caption = #1050#1086#1083'-'#1074#1086' '#1088#1072#1089#1093'. '#1079#1072' 7'
        DataBinding.FieldName = 'AmountPromoBranch7'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = ',0.00##;-,0.00##; ;'
        HeaderAlignmentHorz = taCenter
        HeaderAlignmentVert = vaCenter
        Options.Editing = False
        Width = 95
      end
      object OrderPromoBranch1: TcxGridDBColumn
        Caption = #1050#1086#1083'-'#1074#1086' '#1079#1072#1103#1074#1082#1080' ('#1074#1089#1077') '#1079#1072' 1'
        DataBinding.FieldName = 'OrderPromoBranch1'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = ',0.00##;-,0.00##; ;'
        HeaderAlignmentHorz = taCenter
        HeaderAlignmentVert = vaCenter
        Options.Editing = False
        Width = 95
      end
      object OrderPromoBranch2: TcxGridDBColumn
        Caption = #1050#1086#1083'-'#1074#1086' '#1079#1072#1103#1074#1082#1080' ('#1074#1089#1077') '#1079#1072' 2'
        DataBinding.FieldName = 'OrderPromoBranch2'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = ',0.00##;-,0.00##; ;'
        HeaderAlignmentHorz = taCenter
        HeaderAlignmentVert = vaCenter
        Options.Editing = False
        Width = 95
      end
      object OrderPromoBranch3: TcxGridDBColumn
        Caption = #1050#1086#1083'-'#1074#1086' '#1079#1072#1103#1074#1082#1080' ('#1074#1089#1077') '#1079#1072' 3'
        DataBinding.FieldName = 'OrderPromoBranch3'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = ',0.00##;-,0.00##; ;'
        HeaderAlignmentHorz = taCenter
        HeaderAlignmentVert = vaCenter
        Options.Editing = False
        Width = 95
      end
      object OrderPromoBranch4: TcxGridDBColumn
        Caption = #1050#1086#1083'-'#1074#1086' '#1079#1072#1103#1074#1082#1080' ('#1074#1089#1077') '#1079#1072' 4'
        DataBinding.FieldName = 'OrderPromoBranch4'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = ',0.00##;-,0.00##; ;'
        HeaderAlignmentHorz = taCenter
        HeaderAlignmentVert = vaCenter
        Options.Editing = False
        Width = 95
      end
      object OrderPromoBranch5: TcxGridDBColumn
        Caption = #1050#1086#1083'-'#1074#1086' '#1079#1072#1103#1074#1082#1080' ('#1074#1089#1077') '#1079#1072' 5'
        DataBinding.FieldName = 'OrderPromoBranch5'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = ',0.00##;-,0.00##; ;'
        HeaderAlignmentHorz = taCenter
        HeaderAlignmentVert = vaCenter
        Options.Editing = False
        Width = 95
      end
      object OrderPromoBranch6: TcxGridDBColumn
        Caption = #1050#1086#1083'-'#1074#1086' '#1079#1072#1103#1074#1082#1080' ('#1074#1089#1077') '#1079#1072' 6'
        DataBinding.FieldName = 'OrderPromoBranch6'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = ',0.00##;-,0.00##; ;'
        HeaderAlignmentHorz = taCenter
        HeaderAlignmentVert = vaCenter
        Options.Editing = False
        Width = 95
      end
      object OrderPromoBranch7: TcxGridDBColumn
        Caption = #1050#1086#1083'-'#1074#1086' '#1079#1072#1103#1074#1082#1080' ('#1074#1089#1077') '#1079#1072' 7'
        DataBinding.FieldName = 'OrderPromoBranch7'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = ',0.00##;-,0.00##; ;'
        HeaderAlignmentHorz = taCenter
        HeaderAlignmentVert = vaCenter
        Options.Editing = False
        Width = 95
      end
      object AnalysisAmount1: TcxGridDBColumn
        Caption = #1050#1086#1083'-'#1074#1086' '#1072#1085#1072#1083#1080#1079' '#1088#1072#1089#1093'. '#1079#1072' 1'
        DataBinding.FieldName = 'AnalysisAmount1'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = ',0.00##;-,0.00##; ;'
        HeaderAlignmentHorz = taCenter
        HeaderAlignmentVert = vaCenter
        HeaderHint = #1073#1077#1079' '#1040#1082#1094#1080#1081
        Options.Editing = False
        Width = 95
      end
      object AnalysisAmount2: TcxGridDBColumn
        Caption = #1050#1086#1083'-'#1074#1086' '#1072#1085#1072#1083#1080#1079' '#1088#1072#1089#1093'. '#1079#1072' 2'
        DataBinding.FieldName = 'AnalysisAmount2'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = ',0.00##;-,0.00##; ;'
        HeaderAlignmentHorz = taCenter
        HeaderAlignmentVert = vaCenter
        HeaderHint = #1073#1077#1079' '#1040#1082#1094#1080#1081
        Options.Editing = False
        Width = 95
      end
      object AnalysisAmount3: TcxGridDBColumn
        Caption = #1050#1086#1083'-'#1074#1086' '#1072#1085#1072#1083#1080#1079' '#1088#1072#1089#1093'. '#1079#1072' 3'
        DataBinding.FieldName = 'AnalysisAmount3'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = ',0.00##;-,0.00##; ;'
        HeaderAlignmentHorz = taCenter
        HeaderAlignmentVert = vaCenter
        HeaderHint = #1073#1077#1079' '#1040#1082#1094#1080#1081
        Options.Editing = False
        Width = 95
      end
      object AnalysisAmount4: TcxGridDBColumn
        Caption = #1050#1086#1083'-'#1074#1086' '#1072#1085#1072#1083#1080#1079' '#1088#1072#1089#1093'. '#1079#1072' 4'
        DataBinding.FieldName = 'AnalysisAmount4'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = ',0.00##;-,0.00##; ;'
        HeaderAlignmentHorz = taCenter
        HeaderAlignmentVert = vaCenter
        HeaderHint = #1073#1077#1079' '#1040#1082#1094#1080#1081
        Options.Editing = False
        Width = 95
      end
      object AnalysisAmount5: TcxGridDBColumn
        Caption = #1050#1086#1083'-'#1074#1086' '#1072#1085#1072#1083#1080#1079' '#1088#1072#1089#1093'. '#1079#1072' 5'
        DataBinding.FieldName = 'AnalysisAmount5'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = ',0.00##;-,0.00##; ;'
        HeaderAlignmentHorz = taCenter
        HeaderAlignmentVert = vaCenter
        HeaderHint = #1073#1077#1079' '#1040#1082#1094#1080#1081
        Options.Editing = False
        Width = 95
      end
      object AnalysisAmount6: TcxGridDBColumn
        Caption = #1050#1086#1083'-'#1074#1086' '#1072#1085#1072#1083#1080#1079' '#1088#1072#1089#1093'. '#1079#1072' 6'
        DataBinding.FieldName = 'AnalysisAmount6'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = ',0.00##;-,0.00##; ;'
        HeaderAlignmentHorz = taCenter
        HeaderAlignmentVert = vaCenter
        HeaderHint = #1073#1077#1079' '#1040#1082#1094#1080#1081
        Options.Editing = False
        Width = 95
      end
      object AnalysisAmount7: TcxGridDBColumn
        Caption = #1050#1086#1083'-'#1074#1086' '#1072#1085#1072#1083#1080#1079' '#1088#1072#1089#1093'. '#1079#1072' 7'
        DataBinding.FieldName = 'AnalysisAmount7'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = ',0.00##;-,0.00##; ;'
        HeaderAlignmentHorz = taCenter
        HeaderAlignmentVert = vaCenter
        HeaderHint = #1073#1077#1079' '#1040#1082#1094#1080#1081
        Options.Editing = False
        Width = 95
      end
      object AnalysisOrder1: TcxGridDBColumn
        Caption = #1050#1086#1083'-'#1074#1086' '#1072#1085#1072#1083#1080#1079' '#1079#1072#1103#1074#1082#1080' '#1079#1072' 1'
        DataBinding.FieldName = 'AnalysisOrder1'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = ',0.00##;-,0.00##; ;'
        HeaderAlignmentHorz = taCenter
        HeaderAlignmentVert = vaCenter
        HeaderHint = #1073#1077#1079' '#1040#1082#1094#1080#1081
        Options.Editing = False
        Width = 95
      end
      object AnalysisOrder2: TcxGridDBColumn
        Caption = #1050#1086#1083'-'#1074#1086' '#1072#1085#1072#1083#1080#1079' '#1079#1072#1103#1074#1082#1080' '#1079#1072' 2'
        DataBinding.FieldName = 'AnalysisOrder2'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = ',0.00##;-,0.00##; ;'
        HeaderAlignmentHorz = taCenter
        HeaderAlignmentVert = vaCenter
        HeaderHint = #1073#1077#1079' '#1040#1082#1094#1080#1081
        Options.Editing = False
        Width = 95
      end
      object AnalysisOrder3: TcxGridDBColumn
        Caption = #1050#1086#1083'-'#1074#1086' '#1072#1085#1072#1083#1080#1079' '#1079#1072#1103#1074#1082#1080' '#1079#1072' 3'
        DataBinding.FieldName = 'AnalysisOrder3'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = ',0.00##;-,0.00##; ;'
        HeaderAlignmentHorz = taCenter
        HeaderAlignmentVert = vaCenter
        HeaderHint = #1073#1077#1079' '#1040#1082#1094#1080#1081
        Options.Editing = False
        Width = 95
      end
      object AnalysisOrder4: TcxGridDBColumn
        Caption = #1050#1086#1083'-'#1074#1086' '#1072#1085#1072#1083#1080#1079' '#1079#1072#1103#1074#1082#1080' '#1079#1072' 4'
        DataBinding.FieldName = 'AnalysisOrder4'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = ',0.00##;-,0.00##; ;'
        HeaderAlignmentHorz = taCenter
        HeaderAlignmentVert = vaCenter
        HeaderHint = #1073#1077#1079' '#1040#1082#1094#1080#1081
        Options.Editing = False
        Width = 95
      end
      object AnalysisOrder5: TcxGridDBColumn
        Caption = #1050#1086#1083'-'#1074#1086' '#1072#1085#1072#1083#1080#1079' '#1079#1072#1103#1074#1082#1080' '#1079#1072' 5'
        DataBinding.FieldName = 'AnalysisOrder5'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = ',0.00##;-,0.00##; ;'
        HeaderAlignmentHorz = taCenter
        HeaderAlignmentVert = vaCenter
        HeaderHint = #1073#1077#1079' '#1040#1082#1094#1080#1081
        Options.Editing = False
        Width = 95
      end
      object AnalysisOrder6: TcxGridDBColumn
        Caption = #1050#1086#1083'-'#1074#1086' '#1072#1085#1072#1083#1080#1079' '#1079#1072#1103#1074#1082#1080' '#1079#1072' 6'
        DataBinding.FieldName = 'AnalysisOrder6'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = ',0.00##;-,0.00##; ;'
        HeaderAlignmentHorz = taCenter
        HeaderAlignmentVert = vaCenter
        HeaderHint = #1073#1077#1079' '#1040#1082#1094#1080#1081
        Options.Editing = False
        Width = 95
      end
      object AnalysisOrder7: TcxGridDBColumn
        Caption = #1050#1086#1083'-'#1074#1086' '#1072#1085#1072#1083#1080#1079' '#1079#1072#1103#1074#1082#1080' '#1079#1072' 7'
        DataBinding.FieldName = 'AnalysisOrder7'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = ',0.00##;-,0.00##; ;'
        HeaderAlignmentHorz = taCenter
        HeaderAlignmentVert = vaCenter
        HeaderHint = #1073#1077#1079' '#1040#1082#1094#1080#1081
        Options.Editing = False
        Width = 95
      end
    end
    object cxGridLevel: TcxGridLevel
      GridView = cxGridDBTableView
    end
  end
  object Panel: TPanel
    Left = 0
    Top = 0
    Width = 1042
    Height = 57
    Align = alTop
    TabOrder = 2
    object cxLabel1: TcxLabel
      Left = 5
      Top = 6
      Caption = #1053#1072#1095#1072#1083#1100#1085#1072#1103' '#1076#1072#1090#1072
    end
    object deStart: TcxDateEdit
      Left = 5
      Top = 23
      EditValue = 43040d
      Properties.ReadOnly = True
      Properties.SaveTime = False
      Properties.ShowTime = False
      TabOrder = 1
      Width = 86
    end
    object cxLabel2: TcxLabel
      Left = 102
      Top = 6
      Caption = #1050#1086#1085#1077#1095#1085#1072#1103' '#1076#1072#1090#1072
    end
    object deEnd: TcxDateEdit
      Left = 102
      Top = 23
      EditValue = 43040d
      Properties.ReadOnly = True
      Properties.SaveTime = False
      Properties.ShowTime = False
      TabOrder = 3
      Width = 84
    end
    object cxLabel3: TcxLabel
      Left = 195
      Top = 6
      Caption = #1044#1072#1090#1072' '#1082#1086#1088#1088#1077#1082#1090'.'
    end
    object deUpdate: TcxDateEdit
      Left = 195
      Top = 23
      EditValue = 43040d
      Properties.Kind = ckDateTime
      Properties.ReadOnly = True
      TabOrder = 5
      Width = 130
    end
    object cxLabel9: TcxLabel
      Left = 334
      Top = 6
      Caption = #1050#1086#1083'-'#1074#1086' '#1085#1077#1076'. '#1074' c'#1090#1072#1090'.'
    end
    object ceWeek: TcxCurrencyEdit
      Left = 334
      Top = 23
      Properties.DecimalPlaces = 2
      Properties.DisplayFormat = ',0.##'
      Properties.ReadOnly = True
      TabOrder = 7
      Width = 104
    end
  end
  object cxLabel4: TcxLabel
    Left = 447
    Top = 6
    Caption = #1055#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1100' ('#1082#1086#1088#1088#1077#1082#1090#1080#1088#1086#1074#1082#1072')'
  end
  object edUpdateName: TcxButtonEdit
    Left = 447
    Top = 23
    Properties.Buttons = <
      item
        Default = True
        Enabled = False
        Kind = bkEllipsis
      end>
    Properties.ReadOnly = True
    TabOrder = 7
    Width = 270
  end
  object DataSource: TDataSource
    DataSet = ClientDataSet
    Left = 24
    Top = 216
  end
  object ClientDataSet: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 48
    Top = 160
  end
  object cxPropertiesStore: TcxPropertiesStore
    Components = <
      item
        Component = Owner
        Properties.Strings = (
          'Height'
          'Left'
          'Top'
          'Width')
      end>
    StorageName = 'cxPropertiesStore'
    StorageType = stStream
    Left = 288
    Top = 104
  end
  object dxBarManager: TdxBarManager
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    Categories.Strings = (
      'Default')
    Categories.ItemsVisibles = (
      2)
    Categories.Visibles = (
      True)
    ImageOptions.Images = dmMain.ImageList
    NotDocking = [dsNone, dsLeft, dsTop, dsRight, dsBottom]
    PopupMenuLinks = <>
    ShowShortCutInHint = True
    UseSystemFont = True
    Left = 168
    Top = 104
    DockControlHeights = (
      0
      0
      26
      0)
    object dxBarManagerBar1: TdxBar
      Caption = 'Custom'
      CaptionButtons = <>
      DockedDockingStyle = dsTop
      DockedLeft = 0
      DockedTop = 0
      DockingStyle = dsTop
      FloatLeft = 671
      FloatTop = 8
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          Visible = True
          ItemName = 'dxBarStatic'
        end
        item
          Visible = True
          ItemName = 'bbRefresh'
        end
        item
          Visible = True
          ItemName = 'dxBarStatic'
        end
        item
          Visible = True
          ItemName = 'bbInsertUpdate'
        end
        item
          Visible = True
          ItemName = 'dxBarStatic'
        end
        item
          Visible = True
          ItemName = 'bbGridToExcel'
        end
        item
          Visible = True
          ItemName = 'dxBarStatic'
        end>
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object bbRefresh: TdxBarButton
      Action = actRefresh
      Category = 0
    end
    object bbInsert: TdxBarButton
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100
      Category = 0
      Visible = ivAlways
      ImageIndex = 0
      ShortCut = 45
    end
    object bbEdit: TdxBarButton
      Caption = #1048#1079#1084#1077#1085#1080#1090#1100
      Category = 0
      Visible = ivAlways
      ImageIndex = 1
      ShortCut = 115
    end
    object bbErased: TdxBarButton
      Caption = #1059#1076#1072#1083#1080#1090#1100
      Category = 0
      Hint = #1059#1076#1072#1083#1080#1090#1100' '#1076#1072#1085#1085#1099#1077
      Visible = ivAlways
      ImageIndex = 2
      ShortCut = 46
    end
    object bbUnErased: TdxBarButton
      Action = dsdSetUnErased
      Category = 0
    end
    object bbGridToExcel: TdxBarButton
      Action = dsdGridToExcel
      Category = 0
    end
    object dxBarStatic: TdxBarStatic
      Caption = '     '
      Category = 0
      Hint = '     '
      Visible = ivAlways
    end
    object bbChoiceGuides: TdxBarButton
      Action = dsdChoiceGuides
      Category = 0
    end
    object bbShowAll: TdxBarButton
      Action = actShowAll
      Category = 0
    end
    object bbUpdateIsOfficial: TdxBarButton
      Caption = #1048#1079#1084#1077#1085#1080#1090#1100' "'#1054#1092#1080#1094#1080#1072#1083#1100#1085#1086' '#1044#1072'/'#1053#1077#1090'"'
      Category = 0
      Hint = #1048#1079#1084#1077#1085#1080#1090#1100' "'#1054#1092#1080#1094#1080#1072#1083#1100#1085#1086' '#1044#1072'/'#1053#1077#1090'"'
      Visible = ivAlways
      ImageIndex = 52
    end
    object bbProtocolOpenForm: TdxBarButton
      Action = ProtocolOpenForm
      Category = 0
    end
    object bbUpdateParams: TdxBarButton
      Caption = #1059#1089#1090#1072#1085#1086#1074#1080#1090#1100' '#1087#1072#1088#1072#1084#1077#1090#1088#1099' '#1085#1086#1088#1084' '#1072#1074#1090#1086
      Category = 0
      Hint = #1059#1089#1090#1072#1085#1086#1074#1080#1090#1100' '#1087#1072#1088#1072#1084#1077#1090#1088#1099' '#1085#1086#1088#1084' '#1072#1074#1090#1086
      Visible = ivAlways
      ImageIndex = 41
    end
    object bbInsertUpdate: TdxBarButton
      Action = macInsertUpdate
      Category = 0
    end
  end
  object ActionList: TActionList
    Images = dmMain.ImageList
    Left = 288
    Top = 160
    object actRefresh: TdsdDataSetRefresh
      Category = 'DSDLib'
      MoveParams = <>
      StoredProc = spGet_GoodsReportSaleInf
      StoredProcList = <
        item
          StoredProc = spGet_GoodsReportSaleInf
        end
        item
          StoredProc = spSelect
        end>
      Caption = #1055#1077#1088#1077#1095#1080#1090#1072#1090#1100
      Hint = #1054#1073#1085#1086#1074#1080#1090#1100' '#1076#1072#1085#1085#1099#1077
      ImageIndex = 4
      ShortCut = 116
      RefreshOnTabSetChanges = False
    end
    object ProtocolOpenForm: TdsdOpenForm
      Category = 'DSDLib'
      MoveParams = <>
      Caption = #1055#1088#1086#1089#1084#1086#1090#1088' '#1087#1088#1086#1090#1086#1082#1086#1083#1072
      Hint = #1055#1088#1086#1089#1084#1086#1090#1088' '#1087#1088#1086#1090#1086#1082#1086#1083#1072
      ImageIndex = 34
      FormName = 'TProtocolForm'
      FormNameParam.Value = 'TProtocolForm'
      FormNameParam.DataType = ftString
      FormNameParam.MultiSelectSeparator = ','
      GuiParams = <
        item
          Name = 'Id'
          Value = Null
          Component = ClientDataSet
          ComponentItem = 'Id'
          ParamType = ptInput
          MultiSelectSeparator = ','
        end
        item
          Name = 'TextValue'
          Value = Null
          Component = ClientDataSet
          ComponentItem = 'Name'
          DataType = ftString
          ParamType = ptInput
          MultiSelectSeparator = ','
        end>
      isShowModal = False
    end
    object dsdSetUnErased: TdsdUpdateErased
      Category = 'DSDLib'
      MoveParams = <>
      StoredProc = spErasedUnErased
      StoredProcList = <
        item
          StoredProc = spErasedUnErased
        end>
      Caption = #1042#1086#1089#1089#1090#1072#1085#1086#1074#1080#1090#1100
      Hint = #1042#1086#1089#1089#1090#1072#1085#1086#1074#1080#1090#1100' '#1076#1072#1085#1085#1099#1077
      ImageIndex = 8
      ShortCut = 32776
      ErasedFieldName = 'isErased'
      isSetErased = False
      DataSource = DataSource
    end
    object dsdChoiceGuides: TdsdChoiceGuides
      Category = 'DSDLib'
      MoveParams = <>
      Params = <
        item
          Name = 'Key'
          Value = Null
          Component = ClientDataSet
          ComponentItem = 'Id'
          DataType = ftString
          MultiSelectSeparator = ','
        end
        item
          Name = 'TextValue'
          Value = Null
          Component = ClientDataSet
          ComponentItem = 'Name'
          DataType = ftString
          MultiSelectSeparator = ','
        end
        item
          Name = 'Code'
          Value = Null
          Component = ClientDataSet
          ComponentItem = 'Code'
          MultiSelectSeparator = ','
        end
        item
          Name = 'AmountFuel'
          Value = Null
          Component = ClientDataSet
          ComponentItem = 'AmountFuel'
          DataType = ftFloat
          MultiSelectSeparator = ','
        end
        item
          Name = 'Reparation'
          Value = Null
          Component = ClientDataSet
          ComponentItem = 'Reparation'
          DataType = ftFloat
          MultiSelectSeparator = ','
        end
        item
          Name = 'LimitMoney'
          Value = Null
          Component = ClientDataSet
          ComponentItem = 'LimitMoney'
          DataType = ftFloat
          MultiSelectSeparator = ','
        end
        item
          Name = 'LimitDistance'
          Value = Null
          Component = ClientDataSet
          ComponentItem = 'LimitDistance'
          DataType = ftFloat
          MultiSelectSeparator = ','
        end>
      Caption = #1042#1099#1073#1086#1088' '#1080#1079' '#1089#1087#1088#1072#1074#1086#1095#1085#1080#1082#1072
      Hint = #1042#1099#1073#1086#1088' '#1080#1079' '#1089#1087#1088#1072#1074#1086#1095#1085#1080#1082#1072
      ImageIndex = 7
      DataSource = DataSource
    end
    object dsdGridToExcel: TdsdGridToExcel
      Category = 'DSDLib'
      MoveParams = <>
      Grid = cxGrid
      Caption = #1042#1099#1075#1088#1091#1079#1082#1072' '#1074' Excel'
      Hint = #1042#1099#1075#1088#1091#1079#1082#1072' '#1074' Excel'
      ImageIndex = 6
      ShortCut = 16472
    end
    object actUpdateDataSet: TdsdUpdateDataSet
      Category = 'DSDLib'
      MoveParams = <>
      PostDataSetBeforeExecute = False
      StoredProcList = <
        item
        end>
      Caption = 'actUpdateDataSet'
      DataSource = DataSource
    end
    object actShowAll: TBooleanStoredProcAction
      Category = 'DSDLib'
      MoveParams = <>
      StoredProc = spSelect
      StoredProcList = <
        item
          StoredProc = spSelect
        end>
      Caption = #1055#1086#1082#1072#1079#1072#1090#1100' '#1074#1077#1089#1100' '#1089#1087#1080#1089#1086#1082
      Hint = #1055#1086#1082#1072#1079#1072#1090#1100' '#1074#1077#1089#1100' '#1089#1087#1080#1089#1086#1082
      ImageIndex = 63
      Value = False
      HintTrue = #1055#1086#1082#1072#1079#1072#1090#1100' '#1085#1077' '#1091#1076#1072#1083#1077#1085#1085#1099#1077
      HintFalse = #1055#1086#1082#1072#1079#1072#1090#1100' '#1074#1077#1089#1100' '#1089#1087#1080#1089#1086#1082
      CaptionTrue = #1055#1086#1082#1072#1079#1072#1090#1100' '#1085#1077' '#1091#1076#1072#1083#1077#1085#1085#1099#1077
      CaptionFalse = #1055#1086#1082#1072#1079#1072#1090#1100' '#1074#1077#1089#1100' '#1089#1087#1080#1089#1086#1082
      ImageIndexTrue = 62
      ImageIndexFalse = 63
    end
    object actInsertUpdate: TdsdExecStoredProc
      Category = 'DSDLib'
      MoveParams = <>
      PostDataSetBeforeExecute = False
      StoredProc = spInsertUpdate
      StoredProcList = <
        item
          StoredProc = spInsertUpdate
        end>
      Caption = 'actInsertUpdate'
      ImageIndex = 27
    end
    object macInsertUpdate: TMultiAction
      Category = 'DSDLib'
      MoveParams = <>
      ActionList = <
        item
          Action = actInsertUpdate
        end
        item
          Action = actRefresh
        end>
      Caption = #1057#1092#1086#1088#1084#1080#1088#1086#1074#1072#1090#1100' '#1076#1072#1085#1085#1099#1077
      Hint = #1057#1092#1086#1088#1084#1080#1088#1086#1074#1072#1090#1100' '#1076#1072#1085#1085#1099#1077
      ImageIndex = 27
    end
  end
  object spSelect: TdsdStoredProc
    StoredProcName = 'gpSelect_Object_GoodsReportSale'
    DataSet = ClientDataSet
    DataSets = <
      item
        DataSet = ClientDataSet
      end>
    Params = <>
    PackSize = 1
    Left = 512
    Top = 272
  end
  object dsdUserSettingsStorageAddOn: TdsdUserSettingsStorageAddOn
    Left = 168
    Top = 160
  end
  object spErasedUnErased: TdsdStoredProc
    StoredProcName = 'gpUpdateObjectIsErased'
    DataSets = <>
    OutputType = otResult
    Params = <
      item
        Name = 'inObjectId'
        Value = Null
        Component = ClientDataSet
        ComponentItem = 'Id'
        ParamType = ptInput
        MultiSelectSeparator = ','
      end>
    PackSize = 1
    Left = 288
    Top = 208
  end
  object dsdDBViewAddOn: TdsdDBViewAddOn
    ErasedFieldName = 'isErased'
    View = cxGridDBTableView
    OnDblClickActionList = <
      item
        Action = dsdChoiceGuides
      end
      item
      end>
    ActionItemList = <
      item
        Action = dsdChoiceGuides
        ShortCut = 13
      end
      item
        ShortCut = 13
      end>
    SortImages = dmMain.SortImageList
    OnlyEditingCellOnEnter = False
    ColorRuleList = <>
    ColumnAddOnList = <>
    ColumnEnterList = <>
    SummaryItemList = <>
    Left = 264
    Top = 272
  end
  object FormParams: TdsdFormParams
    Params = <
      item
        Name = 'Id'
        Value = Null
        Component = ClientDataSet
        ComponentItem = 'id'
        ParamType = ptInputOutput
        MultiSelectSeparator = ','
      end
      item
        Name = 'inOperDate'
        Value = 42370d
        DataType = ftDateTime
        ParamType = ptInput
        MultiSelectSeparator = ','
      end>
    Left = 128
    Top = 224
  end
  object GuidesUpdate: TdsdGuides
    KeyField = 'Id'
    LookupControl = edUpdateName
    Key = '0'
    FormNameParam.Value = 'TMemberPosition_ObjectForm'
    FormNameParam.DataType = ftString
    FormNameParam.MultiSelectSeparator = ','
    FormName = 'TMemberPosition_ObjectForm'
    PositionDataSet = 'ClientDataSet'
    Params = <
      item
        Name = 'Key'
        Value = '0'
        Component = GuidesUpdate
        ComponentItem = 'Key'
        ParamType = ptInput
        MultiSelectSeparator = ','
      end
      item
        Name = 'TextValue'
        Value = ''
        Component = GuidesUpdate
        ComponentItem = 'TextValue'
        DataType = ftString
        ParamType = ptInput
        MultiSelectSeparator = ','
      end
      item
        Name = 'MasterPositionId'
        Value = 81178
        MultiSelectSeparator = ','
      end>
    Left = 506
    Top = 65534
  end
  object spGet_GoodsReportSaleInf: TdsdStoredProc
    StoredProcName = 'gpGet_Object_GoodsReportSaleInf'
    DataSets = <>
    OutputType = otResult
    Params = <
      item
        Name = 'StartDate'
        Value = 43040d
        Component = deStart
        DataType = ftDateTime
        MultiSelectSeparator = ','
      end
      item
        Name = 'EndDate'
        Value = 43040d
        Component = deEnd
        DataType = ftDateTime
        MultiSelectSeparator = ','
      end
      item
        Name = 'UpdateDate'
        Value = 43040d
        Component = deUpdate
        DataType = ftDateTime
        MultiSelectSeparator = ','
      end
      item
        Name = 'Week'
        Value = 0.000000000000000000
        Component = ceWeek
        DataType = ftFloat
        MultiSelectSeparator = ','
      end
      item
        Name = 'UpdateId'
        Value = '0'
        Component = GuidesUpdate
        ComponentItem = 'Key'
        MultiSelectSeparator = ','
      end
      item
        Name = 'UpdateName'
        Value = ''
        Component = GuidesUpdate
        ComponentItem = 'TextValue'
        DataType = ftString
        MultiSelectSeparator = ','
      end>
    PackSize = 1
    Left = 520
    Top = 184
  end
  object spInsertUpdate: TdsdStoredProc
    StoredProcName = 'gpInsertUpdate_Object_GoodsReportSale'
    DataSet = ClientDataSet
    DataSets = <
      item
        DataSet = ClientDataSet
      end>
    OutputType = otResult
    Params = <>
    PackSize = 1
    Left = 656
    Top = 264
  end
end
