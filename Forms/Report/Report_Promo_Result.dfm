inherited Report_Promo_ResultForm: TReport_Promo_ResultForm
  Caption = #1054#1090#1095#1077#1090' <'#1056#1077#1079#1091#1083#1100#1090#1072#1090#1099' '#1094#1077#1085#1086#1074#1099#1093' '#1072#1082#1094#1080#1081'>'
  ClientHeight = 434
  ClientWidth = 833
  AddOnFormData.Params = FormParams
  ExplicitWidth = 849
  ExplicitHeight = 472
  PixelsPerInch = 96
  TextHeight = 13
  inherited PageControl: TcxPageControl
    Width = 833
    Height = 377
    TabOrder = 3
    ExplicitWidth = 833
    ExplicitHeight = 377
    ClientRectBottom = 377
    ClientRectRight = 833
    inherited tsMain: TcxTabSheet
      ExplicitWidth = 833
      ExplicitHeight = 377
      inherited cxGrid: TcxGrid
        Width = 833
        Height = 377
        ExplicitWidth = 833
        ExplicitHeight = 377
        inherited cxGridDBTableView: TcxGridDBTableView
          DataController.Summary.FooterSummaryItems = <
            item
              Format = ',0.###'
              Kind = skSum
              Column = AmountPlanMinWeight
            end
            item
              Format = ',0.###'
              Kind = skSum
              Column = AmountPlanMaxWeight
            end
            item
              Format = ',0.###'
              Kind = skSum
              Column = AmountRealWeight
            end
            item
              Format = ',0.###'
              Kind = skSum
            end
            item
              Format = ',0.###'
              Kind = skSum
              Column = AmountOutWeight
            end
            item
              Format = ',0.###'
              Kind = skSum
              Column = AmountInWeight
            end>
          OptionsData.Deleting = False
          OptionsData.DeletingConfirmation = False
          OptionsData.Editing = False
          Styles.Content = nil
          Styles.Inactive = nil
          Styles.Selection = nil
          Styles.Footer = nil
          Styles.Header = nil
          object MonthPromo: TcxGridDBColumn
            Caption = #1052#1077#1089#1103#1094' '#1072#1082#1094#1080#1080
            DataBinding.FieldName = 'MonthPromo'
            PropertiesClassName = 'TcxDateEditProperties'
            Properties.DisplayFormat = 'mmmm yyyy'
            Properties.ReadOnly = False
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Options.Editing = False
            Width = 60
          end
          object PersonalName: TcxGridDBColumn
            Caption = #1052#1072#1088#1082#1077#1090'. '#1086#1090#1076#1077#1083
            DataBinding.FieldName = 'PersonalName'
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Width = 79
          end
          object PersonalTradeName: TcxGridDBColumn
            Caption = #1050#1086#1084'. '#1086#1090#1076#1077#1083
            DataBinding.FieldName = 'PersonalTradeName'
            Visible = False
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Width = 79
          end
          object InvNumber: TcxGridDBColumn
            Caption = #8470' '#1076#1086#1082#1091#1084#1077#1085#1090#1072
            DataBinding.FieldName = 'InvNumber'
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Width = 41
          end
          object UnitName: TcxGridDBColumn
            Caption = #1057#1082#1083#1072#1076
            DataBinding.FieldName = 'UnitName'
            Visible = False
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Width = 95
          end
          object RetailName: TcxGridDBColumn
            Caption = #1057#1077#1090#1100', '#1074' '#1082#1086#1090#1086#1088#1086#1081' '#1087#1088#1086#1093#1086#1076#1080#1090' '#1072#1082#1094#1080#1103
            DataBinding.FieldName = 'RetailName'
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Width = 114
          end
          object AreaName: TcxGridDBColumn
            Caption = #1056#1077#1075#1080#1086#1085
            DataBinding.FieldName = 'AreaName'
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Width = 89
          end
          object GoodsCode: TcxGridDBColumn
            Caption = #1050#1086#1076' '#1087#1086#1079#1080#1094#1080#1080
            DataBinding.FieldName = 'GoodsCode'
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Width = 66
          end
          object GoodsName: TcxGridDBColumn
            Caption = #1055#1086#1079#1080#1094#1080#1103
            DataBinding.FieldName = 'GoodsName'
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Width = 123
          end
          object TradeMarkName: TcxGridDBColumn
            Caption = #1058#1086#1088#1075#1086#1074#1072#1103' '#1084#1072#1088#1082#1072
            DataBinding.FieldName = 'TradeMarkName'
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Width = 80
          end
          object MeasureName: TcxGridDBColumn
            Caption = #1045#1076'. '#1080#1079#1084'.'
            DataBinding.FieldName = 'MeasureName'
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Width = 42
          end
          object GoodsWeight: TcxGridDBColumn
            Caption = #1042#1077#1089
            DataBinding.FieldName = 'GoodsWeight'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DecimalPlaces = 4
            Properties.DisplayFormat = ',0.####;-,0.####; ;'
            Visible = False
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Width = 43
          end
          object Discount: TcxGridDBColumn
            Caption = #1057#1082#1080#1076#1082#1072', %'
            DataBinding.FieldName = 'Discount'
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Width = 59
          end
          object MainDiscount: TcxGridDBColumn
            Caption = #1054#1073#1097#1072#1103' '#1089#1082#1080#1076#1082#1072' '#1076#1083#1103' '#1087#1086#1082#1091#1087#1072#1090#1077#1083#1103', %'
            DataBinding.FieldName = 'MainDiscount'
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Width = 80
          end
          object CostPromo: TcxGridDBColumn
            Caption = #1057#1090#1086#1080#1084#1086#1089#1090#1100' '#1091#1095#1072#1089#1090#1080#1103
            DataBinding.FieldName = 'CostPromo'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DecimalPlaces = 4
            Properties.DisplayFormat = ',0.####;-,0.####; ;'
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Width = 71
          end
          object AmountPlanMin: TcxGridDBColumn
            Caption = #1052#1080#1085#1080#1084#1091#1084' '#1087#1083#1072#1085#1080#1088#1091#1077#1084#1086#1075#1086' '#1086#1073#1098#1077#1084#1072' '#1087#1088#1086#1076#1072#1078' '#1074' '#1072#1082#1094#1080#1086#1085#1085#1099#1081' '#1087#1077#1088#1080#1086#1076', '#1082#1075','#1096#1090
            DataBinding.FieldName = 'AmountPlanMin'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DecimalPlaces = 4
            Properties.DisplayFormat = ',0.####;-,0.####; ;'
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Width = 117
          end
          object AmountPlanMinWeight: TcxGridDBColumn
            Caption = #1052#1080#1085#1080#1084#1091#1084' '#1087#1083#1072#1085#1080#1088#1091#1077#1084#1086#1075#1086' '#1086#1073#1098#1077#1084#1072' '#1087#1088#1086#1076#1072#1078' '#1074' '#1072#1082#1094#1080#1086#1085#1085#1099#1081' '#1087#1077#1088#1080#1086#1076', ('#1074#1077#1089')'
            DataBinding.FieldName = 'AmountPlanMinWeight'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DecimalPlaces = 4
            Properties.DisplayFormat = ',0.####;-,0.####; ;'
            Visible = False
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Width = 111
          end
          object AmountPlanMax: TcxGridDBColumn
            Caption = #1052#1072#1082#1089#1080#1084#1091#1084' '#1087#1083#1072#1085#1080#1088#1091#1077#1084#1086#1075#1086' '#1086#1073#1098#1077#1084#1072' '#1087#1088#1086#1076#1072#1078' '#1074' '#1072#1082#1094#1080#1086#1085#1085#1099#1081' '#1087#1077#1088#1080#1086#1076', '#1082#1075','#1096#1090
            DataBinding.FieldName = 'AmountPlanMax'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DecimalPlaces = 4
            Properties.DisplayFormat = ',0.####;-,0.####; ;'
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Width = 99
          end
          object AmountPlanMaxWeight: TcxGridDBColumn
            Caption = #1052#1072#1082#1089#1080#1084#1091#1084' '#1087#1083#1072#1085#1080#1088#1091#1077#1084#1086#1075#1086' '#1086#1073#1098#1077#1084#1072' '#1087#1088#1086#1076#1072#1078' '#1074' '#1072#1082#1094#1080#1086#1085#1085#1099#1081' '#1087#1077#1088#1080#1086#1076', ('#1074#1077#1089')'
            DataBinding.FieldName = 'AmountPlanMaxWeight'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DecimalPlaces = 4
            Properties.DisplayFormat = ',0.####;-,0.####; ;'
            Visible = False
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Width = 104
          end
          object AmountReal: TcxGridDBColumn
            Caption = #1055#1088#1086#1076'. '#1072#1085#1072#1083#1086#1075'. '#1087#1077#1088#1080#1086#1076
            DataBinding.FieldName = 'AmountReal'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DecimalPlaces = 4
            Properties.DisplayFormat = ',0.####;-,0.####; ;'
            Visible = False
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Width = 71
          end
          object AmountRealWeight: TcxGridDBColumn
            Caption = #1055#1088#1086#1076#1072#1078#1080' '#1074' '#1076#1086' '#1072#1082#1094#1080#1086#1085#1085#1099#1081' '#1087#1077#1088#1080#1086#1076', '#1082#1075
            DataBinding.FieldName = 'AmountRealWeight'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DecimalPlaces = 4
            Properties.DisplayFormat = ',0.####;-,0.####; ;'
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Width = 79
          end
          object AmountOut: TcxGridDBColumn
            Caption = #1050#1086#1083'-'#1074#1086' '#1088#1077#1072#1083#1080#1079#1072#1094#1080#1103' ('#1092#1072#1082#1090')'
            DataBinding.FieldName = 'AmountOut'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DecimalPlaces = 4
            Properties.DisplayFormat = ',0.####;-,0.####; ;'
            Visible = False
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Width = 67
          end
          object AmountOutWeight: TcxGridDBColumn
            Caption = #1050#1086#1083'-'#1074#1086' '#1088#1077#1072#1083#1080#1079#1072#1094#1080#1103' ('#1092#1072#1082#1090') '#1042#1077#1089
            DataBinding.FieldName = 'AmountOutWeight'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DecimalPlaces = 4
            Properties.DisplayFormat = ',0.####;-,0.####; ;'
            Visible = False
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Width = 66
          end
          object AmountIn: TcxGridDBColumn
            Caption = #1050#1086#1083'-'#1074#1086' '#1074#1086#1079#1074#1088#1072#1090' ('#1092#1072#1082#1090')'
            DataBinding.FieldName = 'AmountIn'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DecimalPlaces = 4
            Properties.DisplayFormat = ',0.####;-,0.####; ;'
            Visible = False
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Width = 62
          end
          object AmountInWeight: TcxGridDBColumn
            Caption = #1050#1086#1083'-'#1074#1086' '#1074#1086#1079#1074#1088#1072#1090' ('#1092#1072#1082#1090') '#1042#1077#1089
            DataBinding.FieldName = 'AmountInWeight'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DecimalPlaces = 4
            Properties.DisplayFormat = ',0.####;-,0.####; ;'
            Visible = False
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Width = 63
          end
          object AmountSaleWeight: TcxGridDBColumn
            Caption = #1055#1088#1086#1076#1072#1078#1080' '#1074' '#1072#1082#1094#1080#1086#1085#1085#1099#1081' '#1087#1077#1088#1080#1086#1076', '#1082#1075
            DataBinding.FieldName = 'AmountSaleWeight'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DecimalPlaces = 4
            Properties.DisplayFormat = ',0.####;-,0.####; ;'
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            HeaderHint = #1055#1088#1086#1076#1072#1078#1080' '#1074' '#1072#1082#1094#1080#1086#1085#1085#1099#1081' '#1087#1077#1088#1080#1086#1076', '#1082#1075
            Width = 76
          end
          object PersentResult: TcxGridDBColumn
            Caption = #1056#1077#1079#1091#1083#1100#1090#1072#1090', %'
            DataBinding.FieldName = 'PersentResult'
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Width = 73
          end
          object DateStartSale: TcxGridDBColumn
            Caption = #1044#1072#1090#1072' '#1085#1072#1095#1072#1083#1072' '#1086#1090#1075#1088#1091#1079#1082#1080
            DataBinding.FieldName = 'DateStartSale'
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Width = 70
          end
          object DeteFinalSale: TcxGridDBColumn
            Caption = #1044#1072#1090#1072' '#1086#1082#1086#1085#1095#1072#1085#1080#1103' '#1086#1090#1075#1088#1091#1079#1082#1080
            DataBinding.FieldName = 'DeteFinalSale'
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Width = 70
          end
          object DateStartPromo: TcxGridDBColumn
            Caption = #1044#1072#1090#1072' '#1085#1072#1095#1072#1083#1072' '#1072#1082#1094#1080#1080
            DataBinding.FieldName = 'DateStartPromo'
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Width = 73
          end
          object DateFinalPromo: TcxGridDBColumn
            Caption = #1044#1072#1090#1072' '#1086#1082#1086#1085#1095#1072#1085#1080#1103' '#1072#1082#1094#1080#1080
            DataBinding.FieldName = 'DateFinalPromo'
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Width = 76
          end
          object Price: TcxGridDBColumn
            Caption = #1062#1077#1085#1072' '#1089#1087#1077#1094#1080#1092#1080#1082#1072#1094#1080#1080' '#1089' '#1053#1044#1057', '#1075#1088#1085
            DataBinding.FieldName = 'Price'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DecimalPlaces = 4
            Properties.DisplayFormat = ',0.####;-,0.####; ;'
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Width = 76
          end
          object PriceWithVAT: TcxGridDBColumn
            Caption = #1054#1090#1075#1088#1091#1079#1086#1095#1085#1072#1103' '#1072#1082#1094#1080#1086#1085#1085#1072#1103' '#1094#1077#1085#1072' '#1089' '#1091#1095#1077#1090#1086#1084' '#1053#1044#1057', '#1075#1088#1085
            DataBinding.FieldName = 'PriceWithVAT'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DecimalPlaces = 4
            Properties.DisplayFormat = ',0.####;-,0.####; ;'
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Width = 98
          end
          object PriceSale: TcxGridDBColumn
            Caption = #1062#1077#1085#1072' '#1085#1072' '#1087#1086#1083#1082#1077'/'#1089#1082#1080#1076#1082#1072' '#1076#1083#1103' '#1087#1086#1082#1091#1087#1072#1090#1077#1083#1103
            DataBinding.FieldName = 'PriceSale'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DecimalPlaces = 4
            Properties.DisplayFormat = ',0.####;-,0.####; ;'
            Visible = False
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Width = 88
          end
          object Profit_Virt: TcxGridDBColumn
            Caption = #1042#1080#1088#1090#1091#1072#1083#1100#1085#1072#1103' '#1085#1077#1076#1086#1087#1086#1083#1091#1095#1077#1085#1085#1072#1103' '#1074#1099#1088#1091#1095#1082#1072' '#1087#1086' '#1072#1082#1094#1080#1086#1085#1085#1086#1084#1091' '#1086#1073#1098#1077#1084#1091
            DataBinding.FieldName = 'Profit_Virt'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DecimalPlaces = 4
            Properties.DisplayFormat = ',0.####;-,0.####; ;'
            Visible = False
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Width = 90
          end
          object SummReal: TcxGridDBColumn
            Caption = #1058#1054' ('#1075#1088#1085') '#1076#1086' '#1072#1082#1094#1080#1086#1085#1085#1099#1081' '#1087#1077#1088#1080#1086#1076' '#1087#1086' '#1094#1077#1085#1077' '#1089#1087#1077#1094#1080#1092#1080#1082#1072#1094#1080#1080
            DataBinding.FieldName = 'SummReal'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DecimalPlaces = 4
            Properties.DisplayFormat = ',0.####;-,0.####; ;'
            Visible = False
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Width = 71
          end
          object SummPromo: TcxGridDBColumn
            Caption = #1058#1054' ('#1075#1088#1085') '#1072#1082#1094#1080#1086#1085#1085#1099#1081' '#1087#1077#1088#1080#1086#1076' '#1087#1086' '#1072#1082#1094#1080#1086#1085#1085#1099#1084' '#1094#1077#1085#1072#1084
            DataBinding.FieldName = 'SummPromo'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DecimalPlaces = 4
            Properties.DisplayFormat = ',0.####;-,0.####; ;'
            Visible = False
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Width = 71
          end
          object PriceIn1: TcxGridDBColumn
            Caption = 'C'#1077#1073#1077#1089#1090#1086#1080#1084#1086#1089#1090#1100' '#1092#1072#1082#1090',  '#1079#1072' '#1082#1075
            DataBinding.FieldName = 'PriceIn1'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = ',0.####;-,0.####; ;'
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Width = 50
          end
          object ContractCondition: TcxGridDBColumn
            Caption = #1041#1086#1085#1091#1089' '#1089#1077#1090#1080
            DataBinding.FieldName = 'ContractCondition'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DecimalPlaces = 4
            Properties.DisplayFormat = ',0.####;-,0.####; ;'
            Visible = False
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Width = 71
          end
          object Profit: TcxGridDBColumn
            Caption = #1055#1088#1080#1073#1099#1083#1100', '#1075#1088#1085' '
            DataBinding.FieldName = 'Profit'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DecimalPlaces = 4
            Properties.DisplayFormat = ',0.####;-,0.####; ;'
            Visible = False
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Width = 71
          end
          object Comment: TcxGridDBColumn
            Caption = #1055#1088#1080#1084#1077#1095#1072#1085#1080#1077
            DataBinding.FieldName = 'Comment'
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Width = 164
          end
        end
      end
    end
  end
  inherited Panel: TPanel
    Width = 833
    Visible = False
    ExplicitWidth = 833
    inherited deStart: TcxDateEdit
      Left = 109
      EditValue = 42309d
      Visible = False
      ExplicitLeft = 109
    end
    inherited deEnd: TcxDateEdit
      EditValue = 42309d
      Visible = False
    end
    inherited cxLabel1: TcxLabel
      Visible = False
    end
    inherited cxLabel2: TcxLabel
      Visible = False
    end
    object cxLabel17: TcxLabel
      Left = 417
      Top = 6
      Caption = #1055#1086#1076#1088#1072#1079#1076#1077#1083#1077#1085#1080#1077
      Visible = False
    end
    object edUnit: TcxButtonEdit
      Left = 507
      Top = 5
      Properties.Buttons = <
        item
          Default = True
          Kind = bkEllipsis
        end>
      Properties.ReadOnly = True
      TabOrder = 5
      Visible = False
      Width = 286
    end
  end
  inherited ActionList: TActionList
    object actPrint: TdsdPrintAction
      Category = 'DSDLib'
      MoveParams = <>
      StoredProcList = <>
      Caption = #1055#1077#1095#1072#1090#1100
      ImageIndex = 3
      ShortCut = 16464
      DataSets = <
        item
          UserName = 'frxMasterDS'
          GridView = cxGridDBTableView
        end>
      Params = <
        item
          Name = 'DateStart'
          Value = 'NULL'
          Component = deStart
          DataType = ftDateTime
          MultiSelectSeparator = ','
        end
        item
          Name = 'DateEnd'
          Value = 'NULL'
          Component = deEnd
          DataType = ftDateTime
          MultiSelectSeparator = ','
        end>
      ReportName = #1054#1090#1095#1077#1090' '#1056#1077#1079#1091#1083#1100#1090#1072#1090#1099' '#1094#1077#1085#1086#1074#1099#1093' '#1072#1082#1094#1080#1081
      ReportNameParam.Value = #1054#1090#1095#1077#1090' '#1056#1077#1079#1091#1083#1100#1090#1072#1090#1099' '#1094#1077#1085#1086#1074#1099#1093' '#1072#1082#1094#1080#1081
      ReportNameParam.DataType = ftString
      ReportNameParam.MultiSelectSeparator = ','
    end
    object actReport_PromoDialog: TExecuteDialog
      Category = 'DSDLib'
      MoveParams = <>
      Caption = #1048#1079#1084#1077#1085#1080#1090#1100' '#1087#1072#1088#1072#1084#1077#1090#1088#1099' '#1086#1090#1095#1077#1090#1072
      Hint = #1048#1079#1084#1077#1085#1080#1090#1100' '#1087#1072#1088#1072#1084#1077#1090#1088#1099' '#1086#1090#1095#1077#1090#1072
      ImageIndex = 35
      FormName = 'TReport_PromoDialogForm'
      FormNameParam.Value = 'TReport_PromoDialogForm'
      FormNameParam.DataType = ftString
      FormNameParam.MultiSelectSeparator = ','
      GuiParams = <
        item
          Name = 'StartDate'
          Value = 'NULL'
          Component = deStart
          DataType = ftDateTime
          ParamType = ptInput
          MultiSelectSeparator = ','
        end
        item
          Name = 'EndDate'
          Value = 'NULL'
          Component = deEnd
          DataType = ftDateTime
          ParamType = ptInput
          MultiSelectSeparator = ','
        end
        item
          Name = 'UnitId'
          Value = Null
          Component = UnitGuides
          ComponentItem = 'Key'
          ParamType = ptInput
          MultiSelectSeparator = ','
        end
        item
          Name = 'UnitName'
          Value = Null
          Component = UnitGuides
          ComponentItem = 'TextValue'
          DataType = ftString
          ParamType = ptInput
          MultiSelectSeparator = ','
        end>
      isShowModal = True
      RefreshDispatcher = RefreshDispatcher
      OpenBeforeShow = True
    end
    object actOpenPromo: TdsdOpenForm
      Category = 'DSDLib'
      MoveParams = <>
      Caption = #1054#1090#1082#1088#1099#1090#1100' '#1076#1086#1082#1091#1084#1077#1085#1090' <'#1040#1082#1094#1080#1103'>'
      Hint = #1054#1090#1082#1088#1099#1090#1100' '#1076#1086#1082#1091#1084#1077#1085#1090' <'#1040#1082#1094#1080#1103'>'
      ImageIndex = 1
      FormName = 'TPromoForm'
      FormNameParam.Value = 'TPromoForm'
      FormNameParam.DataType = ftString
      FormNameParam.MultiSelectSeparator = ','
      GuiParams = <
        item
          Name = 'Id'
          Value = Null
          Component = MasterCDS
          ComponentItem = 'MovementId'
          MultiSelectSeparator = ','
        end
        item
          Name = 'ShowAll'
          Value = 'False'
          DataType = ftBoolean
          MultiSelectSeparator = ','
        end
        item
          Name = 'inOperDate'
          Value = 'NULL'
          Component = MasterCDS
          ComponentItem = 'OperDate'
          DataType = ftDateTime
          MultiSelectSeparator = ','
        end>
      isShowModal = False
    end
  end
  inherited MasterDS: TDataSource
    Top = 144
  end
  inherited MasterCDS: TClientDataSet
    Top = 144
  end
  inherited spSelect: TdsdStoredProc
    StoredProcName = 'gpSelect_Report_Promo_Result'
    Params = <
      item
        Name = 'inMovementId'
        Value = Null
        Component = FormParams
        ComponentItem = 'inMovementId'
        ParamType = ptInput
        MultiSelectSeparator = ','
      end>
    Top = 144
  end
  inherited BarManager: TdxBarManager
    Top = 144
    DockControlHeights = (
      0
      0
      26
      0)
    inherited Bar: TdxBar
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
          ItemName = 'dxBarButton1'
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
    end
    object dxBarButton1: TdxBarButton
      Action = actPrint
      Category = 0
    end
    object dxBarButton2: TdxBarButton
      Action = actReport_PromoDialog
      Category = 0
    end
    object dxBarButton3: TdxBarButton
      Action = actOpenPromo
      Category = 0
    end
  end
  inherited DBViewAddOn: TdsdDBViewAddOn
    OnDblClickActionList = <
      item
        Action = actOpenPromo
      end>
    ActionItemList = <
      item
        Action = actOpenPromo
        ShortCut = 13
      end>
  end
  inherited PeriodChoice: TPeriodChoice
    Left = 176
    Top = 184
  end
  inherited RefreshDispatcher: TRefreshDispatcher
    ComponentList = <
      item
        Component = PeriodChoice
      end
      item
        Component = UnitGuides
      end>
    Top = 184
  end
  object UnitGuides: TdsdGuides
    KeyField = 'Id'
    LookupControl = edUnit
    FormNameParam.Value = 'TUnit_ObjectForm'
    FormNameParam.DataType = ftString
    FormNameParam.MultiSelectSeparator = ','
    FormName = 'TUnit_ObjectForm'
    PositionDataSet = 'MasterCDS'
    Params = <
      item
        Name = 'Key'
        Value = ''
        Component = UnitGuides
        ComponentItem = 'Key'
        DataType = ftString
        ParamType = ptInput
        MultiSelectSeparator = ','
      end
      item
        Name = 'TextValue'
        Value = ''
        Component = UnitGuides
        ComponentItem = 'TextValue'
        DataType = ftString
        ParamType = ptInput
        MultiSelectSeparator = ','
      end>
    Left = 700
  end
  object FormParams: TdsdFormParams
    Params = <
      item
        Name = 'inMovementId'
        Value = Null
        ParamType = ptInputOutput
        MultiSelectSeparator = ','
      end>
    Left = 344
    Top = 152
  end
end
