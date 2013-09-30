﻿inherited TransportForm: TTransportForm
  Caption = #1055#1091#1090#1077#1074#1086#1081' '#1083#1080#1089#1090
  ClientHeight = 489
  ClientWidth = 996
  KeyPreview = True
  PopupMenu = PopupMenu
  ExplicitWidth = 1004
  ExplicitHeight = 516
  PixelsPerInch = 96
  TextHeight = 13
  object DataPanel: TPanel
    Left = 0
    Top = 0
    Width = 996
    Height = 84
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    object edInvNumber: TcxTextEdit
      Left = 8
      Top = 20
      Enabled = False
      TabOrder = 0
      Width = 101
    end
    object cxLabel1: TcxLabel
      Left = 8
      Top = 4
      Caption = #1053#1086#1084#1077#1088' '#1076#1086#1082#1091#1084#1077#1085#1090#1072
    end
    object edOperDate: TcxDateEdit
      Left = 8
      Top = 56
      TabOrder = 1
      Width = 101
    end
    object cxLabel2: TcxLabel
      Left = 8
      Top = 40
      Caption = #1044#1072#1090#1072' '#1076#1086#1082#1091#1084#1077#1085#1090#1072
    end
    object edUnitForwarding: TcxButtonEdit
      Left = 812
      Top = 20
      Properties.Buttons = <
        item
          Default = True
          Kind = bkEllipsis
        end>
      TabOrder = 12
      Width = 182
    end
    object edCar: TcxButtonEdit
      Left = 121
      Top = 20
      Properties.Buttons = <
        item
          Default = True
          Kind = bkEllipsis
        end>
      TabOrder = 2
      Width = 145
    end
    object cxLabel3: TcxLabel
      Left = 812
      Top = 4
      Caption = #1052#1077#1089#1090#1086' '#1086#1090#1087#1088#1072#1074#1082#1080
    end
    object cxLabel4: TcxLabel
      Left = 121
      Top = 4
      Caption = #1040#1074#1090#1086#1084#1086#1073#1080#1083#1100' '
    end
    object edPersonalDriver: TcxButtonEdit
      Left = 121
      Top = 56
      Properties.Buttons = <
        item
          Default = True
          Kind = bkEllipsis
        end>
      TabOrder = 3
      Width = 145
    end
    object cxLabel5: TcxLabel
      Left = 121
      Top = 40
      Caption = #1042#1086#1076#1080#1090#1077#1083#1100
    end
    object edPersonalDriverMore: TcxButtonEdit
      Left = 659
      Top = 56
      Properties.Buttons = <
        item
          Default = True
          Kind = bkEllipsis
        end>
      TabOrder = 11
      Width = 145
    end
    object cxLabel6: TcxLabel
      Left = 659
      Top = 40
      Caption = #1042#1086#1076#1080#1090#1077#1083#1100', '#1076#1086#1087#1086#1083#1085#1080#1090#1077#1083#1100#1085#1099#1081
    end
    object edCarTrailer: TcxButtonEdit
      Left = 659
      Top = 20
      Properties.Buttons = <
        item
          Default = True
          Kind = bkEllipsis
        end>
      TabOrder = 10
      Width = 145
    end
    object cxLabel7: TcxLabel
      Left = 659
      Top = 4
      Caption = #1055#1088#1080#1094#1077#1087
    end
    object edStartRunPlan: TcxDateEdit
      Left = 275
      Top = 20
      Properties.DateButtons = [btnClear, btnToday]
      Properties.InputKind = ikMask
      Properties.Kind = ckDateTime
      TabOrder = 4
      Width = 145
    end
    object cxLabel8: TcxLabel
      Left = 275
      Top = 4
      Caption = #1044#1072#1090#1072'/'#1042#1088'.'#1074#1099#1077#1079#1076#1072' '#1087#1083#1072#1085' '
    end
    object edEndRunPlan: TcxDateEdit
      Left = 275
      Top = 56
      Properties.Kind = ckDateTime
      TabOrder = 5
      Width = 145
    end
    object cxLabel9: TcxLabel
      Left = 275
      Top = 40
      Caption = #1044#1072#1090#1072'/'#1042#1088'.'#1074#1086#1079#1074#1088#1072#1097#1077#1085#1080#1103' '#1087#1083#1072#1085
    end
    object cxLabel10: TcxLabel
      Left = 426
      Top = 4
      Caption = #1044#1072#1090#1072'/'#1042#1088'.'#1074#1099#1077#1079#1076#1072' '#1092#1072#1082#1090
    end
    object edStartRun: TcxDateEdit
      Left = 426
      Top = 20
      Properties.InputKind = ikMask
      Properties.Kind = ckDateTime
      TabOrder = 6
      Width = 147
    end
    object cxLabel11: TcxLabel
      Left = 426
      Top = 40
      Caption = #1044#1072#1090#1072'/'#1042#1088'.'#1074#1086#1079#1074#1088#1072#1097#1077#1085#1080#1103' '#1092#1072#1082#1090
    end
    object edEndRun: TcxDateEdit
      Left = 426
      Top = 56
      Properties.Kind = ckDateTime
      TabOrder = 7
      Width = 147
    end
    object edComment: TcxTextEdit
      Left = 812
      Top = 56
      TabOrder = 13
      Width = 182
    end
    object cxLabel12: TcxLabel
      Left = 812
      Top = 40
      Caption = ' '#1055#1088#1080#1084#1077#1095#1072#1085#1080#1077' '
    end
    object edHoursWork: TcxCurrencyEdit
      Left = 580
      Top = 20
      Enabled = False
      Properties.Alignment.Horz = taRightJustify
      Properties.Alignment.Vert = taVCenter
      Properties.DecimalPlaces = 0
      Properties.DisplayFormat = ',0'
      TabOrder = 8
      Width = 71
    end
    object cxLabel13: TcxLabel
      Left = 580
      Top = 4
      Caption = #1050#1086#1083'-'#1074#1086' '#1095#1072#1089#1086#1074
    end
    object edHoursAdd: TcxCurrencyEdit
      Left = 580
      Top = 56
      Properties.Alignment.Horz = taRightJustify
      Properties.Alignment.Vert = taVCenter
      Properties.DecimalPlaces = 0
      Properties.DisplayFormat = ',0'
      TabOrder = 9
      Width = 71
    end
    object cxLabel14: TcxLabel
      Left = 580
      Top = 40
      Caption = #1044#1086#1087'. '#1095#1072#1089#1099
    end
  end
  object cxPageControl1: TcxPageControl
    Left = 0
    Top = 110
    Width = 996
    Height = 379
    Align = alClient
    TabOrder = 1
    Properties.ActivePage = cxTabSheet1
    Properties.CustomButtons.Buttons = <>
    ClientRectBottom = 379
    ClientRectRight = 996
    ClientRectTop = 24
    object cxTabSheet1: TcxTabSheet
      Caption = #1057#1090#1088#1086#1095#1085#1072#1103' '#1095#1072#1089#1090#1100
      ImageIndex = 0
      object cxGrid: TcxGrid
        Left = 0
        Top = 0
        Width = 996
        Height = 210
        Align = alClient
        TabOrder = 0
        object cxGridDBTableView: TcxGridDBTableView
          Navigator.Buttons.CustomButtons = <>
          DataController.DataSource = MasterDS
          DataController.Summary.DefaultGroupSummaryItems = <
            item
              Kind = skSum
              Position = spFooter
            end
            item
              Kind = skSum
              Position = spFooter
            end
            item
              Kind = skSum
              Position = spFooter
              Column = colWeight
            end
            item
              Kind = skSum
              Position = spFooter
              Column = colAmount
            end
            item
              Kind = skSum
              Position = spFooter
              Column = colEndOdometre
            end
            item
              Kind = skSum
              Position = spFooter
            end>
          DataController.Summary.FooterSummaryItems = <
            item
              Kind = skSum
            end
            item
              Kind = skSum
            end
            item
              Kind = skSum
              Column = colWeight
            end
            item
              Kind = skSum
              Column = colAmount
            end
            item
              Kind = skSum
              Column = colEndOdometre
            end
            item
              Kind = skSum
            end>
          DataController.Summary.SummaryGroups = <>
          OptionsView.ColumnAutoWidth = True
          OptionsView.HeaderAutoHeight = True
          OptionsView.Indicator = True
          Styles.StyleSheet = dmMain.cxGridTableViewStyleSheet
          object colRouteCode: TcxGridDBColumn
            Caption = #1050#1086#1076
            DataBinding.FieldName = 'RouteCode'
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Width = 70
          end
          object colRouteName: TcxGridDBColumn
            Caption = #1052#1072#1088#1096#1088#1091#1090
            DataBinding.FieldName = 'RouteName'
            HeaderAlignmentVert = vaCenter
            Width = 125
          end
          object colAmount: TcxGridDBColumn
            Caption = #1055#1088#1086#1073#1077#1075', '#1082#1084
            DataBinding.FieldName = 'Amount'
            HeaderAlignmentHorz = taRightJustify
            HeaderAlignmentVert = vaCenter
            Width = 136
          end
          object colStartOdometre: TcxGridDBColumn
            Caption = #1057#1087#1080#1076#1086#1084#1077#1090#1088' '#1085#1072#1095#1072#1083#1100#1085#1086#1077' '#1087#1086#1082#1072#1079#1072#1085#1080#1077', '#1082#1084
            DataBinding.FieldName = 'StartOdometre'
            HeaderAlignmentHorz = taRightJustify
            HeaderAlignmentVert = vaCenter
            Width = 176
          end
          object colEndOdometre: TcxGridDBColumn
            Caption = #1057#1087#1080#1076#1086#1084#1077#1090#1088' '#1082#1086#1085#1077#1095#1085#1086#1077' '#1087#1086#1082#1072#1079#1072#1085#1080#1077', '#1082#1084
            DataBinding.FieldName = 'EndOdometre'
            HeaderAlignmentHorz = taRightJustify
            HeaderAlignmentVert = vaCenter
            Width = 175
          end
          object colWeight: TcxGridDBColumn
            Caption = #1042#1077#1089' '#1075#1088#1091#1079#1072', '#1082#1075
            DataBinding.FieldName = 'Weight'
            HeaderAlignmentHorz = taRightJustify
            HeaderAlignmentVert = vaCenter
            Width = 97
          end
          object colFreightName: TcxGridDBColumn
            Caption = #1053#1072#1079#1074#1072#1085#1080#1077' '#1075#1088#1091#1079#1072
            DataBinding.FieldName = 'FreightName'
            HeaderAlignmentVert = vaCenter
            Width = 110
          end
          object colRouteKindName: TcxGridDBColumn
            Caption = #1058#1080#1087' '#1084#1072#1088#1096#1088#1091#1090#1072
            DataBinding.FieldName = 'RouteKindName'
            HeaderAlignmentVert = vaCenter
            Width = 107
          end
        end
        object cxGridLevel: TcxGridLevel
          GridView = cxGridDBTableView
        end
      end
      object cxGridChild: TcxGrid
        Left = 0
        Top = 215
        Width = 996
        Height = 140
        Align = alBottom
        TabOrder = 1
        object cxGridDBTableView1: TcxGridDBTableView
          Navigator.Buttons.CustomButtons = <>
          DataController.DataSource = ChildDS
          DataController.Summary.DefaultGroupSummaryItems = <
            item
              Kind = skSum
              Position = spFooter
            end
            item
              Kind = skSum
              Position = spFooter
            end
            item
              Kind = skSum
              Position = spFooter
            end
            item
              Kind = skSum
              Position = spFooter
              Column = colсhAmount
            end
            item
              Kind = skSum
              Position = spFooter
            end
            item
              Kind = skSum
              Position = spFooter
            end>
          DataController.Summary.FooterSummaryItems = <
            item
              Kind = skSum
            end
            item
              Kind = skSum
            end
            item
              Kind = skSum
            end
            item
              Kind = skSum
              Column = colсhAmount
            end
            item
              Kind = skSum
            end
            item
              Kind = skSum
            end>
          DataController.Summary.SummaryGroups = <>
          OptionsView.ColumnAutoWidth = True
          OptionsView.HeaderAutoHeight = True
          OptionsView.Indicator = True
          Styles.StyleSheet = dmMain.cxGridTableViewStyleSheet
          object colсhFuelCode: TcxGridDBColumn
            Caption = #1050#1086#1076
            DataBinding.FieldName = 'FuelCode'
            HeaderAlignmentVert = vaCenter
            Width = 56
          end
          object colсhFuelName: TcxGridDBColumn
            Caption = #1042#1080#1076' '#1090#1086#1087#1083#1080#1074#1072
            DataBinding.FieldName = 'FuelName'
            HeaderAlignmentVert = vaCenter
            Width = 144
          end
          object colсhAmount: TcxGridDBColumn
            Caption = #1050#1086#1083'-'#1074#1086' '#1087#1086' '#1092#1072#1082#1090#1091' '
            DataBinding.FieldName = 'Amount'
            HeaderAlignmentHorz = taRightJustify
            HeaderAlignmentVert = vaCenter
            Width = 88
          end
          object colсhAmount_calc: TcxGridDBColumn
            Caption = #1050#1086#1083'-'#1074#1086' '#1088#1072#1089#1095#1077#1090
            DataBinding.FieldName = 'Amount_calc'
            HeaderAlignmentHorz = taRightJustify
            HeaderAlignmentVert = vaCenter
            Width = 79
          end
          object colсhCalculated: TcxGridDBColumn
            Caption = #1055#1086' '#1085#1086#1088#1084#1077'('#1076#1072')'
            DataBinding.FieldName = 'Calculated'
            HeaderAlignmentHorz = taRightJustify
            HeaderAlignmentVert = vaCenter
            Width = 75
          end
          object colсhRateFuelKindName: TcxGridDBColumn
            Caption = #1042#1080#1076' '#1085#1086#1088#1084#1099' '#1076#1083#1103' '#1090#1086#1087#1083#1080#1074#1072
            DataBinding.FieldName = 'RateFuelKindName'
            HeaderAlignmentVert = vaCenter
            Width = 75
          end
          object colсhColdHour: TcxGridDBColumn
            Caption = #1061#1086#1083#1086#1076', '#1092#1072#1082#1090' '#1095#1072#1089#1086#1074
            DataBinding.FieldName = 'ColdHour'
            HeaderAlignmentHorz = taRightJustify
            HeaderAlignmentVert = vaCenter
            Width = 95
          end
          object colсhColdDistance: TcxGridDBColumn
            Caption = #1061#1086#1083#1086#1076', '#1092#1072#1082#1090' '#1082#1084
            DataBinding.FieldName = 'ColdDistance'
            HeaderAlignmentHorz = taRightJustify
            HeaderAlignmentVert = vaCenter
            Width = 97
          end
          object colсhAmountColdHour: TcxGridDBColumn
            Caption = #1061#1086#1083#1086#1076', '#1085#1086#1088#1084#1072' '#1074' '#1095#1072#1089
            DataBinding.FieldName = 'AmountColdHour'
            HeaderAlignmentHorz = taRightJustify
            HeaderAlignmentVert = vaCenter
            Width = 96
          end
          object colсhAmountColdDistance: TcxGridDBColumn
            Caption = #1061#1086#1083#1086#1076', '#1085#1086#1088#1084#1072' '#1085#1072' 100 '#1082#1084
            DataBinding.FieldName = 'AmountColdDistance'
            HeaderAlignmentHorz = taRightJustify
            HeaderAlignmentVert = vaCenter
            Width = 95
          end
          object colсhAmountFuel: TcxGridDBColumn
            Caption = #1056#1072#1089#1093#1086#1076', '#1085#1086#1088#1084#1072' '#1085#1072' 100 '#1082#1084
            DataBinding.FieldName = 'AmountFuel'
            HeaderAlignmentHorz = taRightJustify
            HeaderAlignmentVert = vaCenter
            Width = 96
          end
        end
        object cxGridLevel1: TcxGridLevel
          GridView = cxGridDBTableView1
        end
      end
      object cxSplitterChild: TcxSplitter
        Left = 0
        Top = 210
        Width = 996
        Height = 5
        AlignSplitter = salBottom
        Control = cxGridChild
      end
    end
    object cxTabSheet2: TcxTabSheet
      Caption = #1055#1088#1086#1074#1086#1076#1082#1080
      ImageIndex = 1
      object cxGridEntry: TcxGrid
        Left = 0
        Top = 0
        Width = 996
        Height = 355
        Align = alClient
        TabOrder = 0
        object cxGridEntryDBTableView: TcxGridDBTableView
          Navigator.Buttons.CustomButtons = <>
          DataController.DataSource = EntryDS
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <
            item
              Format = ',0.00'
              Kind = skSum
              Column = colKreditAmount
            end
            item
              Format = ',0.00'
              Kind = skSum
              Column = colDebetAmount
            end>
          DataController.Summary.SummaryGroups = <>
          OptionsView.ColumnAutoWidth = True
          OptionsView.Footer = True
          object colDebetAccountGroupCode: TcxGridDBColumn
            Caption = #1057#1095#1077#1090' '#1044' '#1043#1088#1091#1087#1087#1072' '#1082#1086#1076
            DataBinding.FieldName = 'DebetAccountGroupCode'
            Visible = False
            HeaderAlignmentHorz = taCenter
            Width = 40
          end
          object colDebetAccountGroupName: TcxGridDBColumn
            Caption = #1057#1095#1077#1090' '#1044' '#1043#1088#1091#1087#1087#1072
            DataBinding.FieldName = 'DebetAccountGroupName'
            Visible = False
            HeaderAlignmentHorz = taCenter
            Width = 90
          end
          object colDebetAccountDirectionCode: TcxGridDBColumn
            Caption = #1057#1095#1077#1090' '#1044' '#1053#1072#1087#1088#1072#1074#1083' '#1082#1086#1076
            DataBinding.FieldName = 'DebetAccountDirectionCode'
            Visible = False
            HeaderAlignmentHorz = taCenter
            Width = 40
          end
          object colDebetAccountDirectionName: TcxGridDBColumn
            Caption = #1057#1095#1077#1090' '#1044' '#1053#1072#1087#1088#1072#1074#1083
            DataBinding.FieldName = 'DebetAccountDirectionName'
            Visible = False
            HeaderAlignmentHorz = taCenter
            Width = 90
          end
          object colDebetAccountCode: TcxGridDBColumn
            Caption = #1057#1095#1077#1090' '#1044' '#1082#1086#1076
            DataBinding.FieldName = 'DebetAccountCode'
            HeaderAlignmentHorz = taCenter
            Width = 40
          end
          object colDebetAccountName: TcxGridDBColumn
            Caption = #1057#1095#1077#1090' '#1044
            DataBinding.FieldName = 'DebetAccountName'
            HeaderAlignmentHorz = taCenter
            Width = 120
          end
          object colKreditAccountGroupCode: TcxGridDBColumn
            Caption = #1057#1095#1077#1090' '#1050' '#1043#1088#1091#1087#1087#1072' '#1082#1086#1076
            DataBinding.FieldName = 'KreditAccountGroupCode'
            Visible = False
            HeaderAlignmentHorz = taCenter
            Width = 40
          end
          object colKreditAccountGroupName: TcxGridDBColumn
            Caption = #1057#1095#1077#1090' '#1050' '#1043#1088#1091#1087#1087#1072
            DataBinding.FieldName = 'KreditAccountGroupName'
            Visible = False
            HeaderAlignmentHorz = taCenter
            Width = 80
          end
          object colKreditAccountDirectionCode: TcxGridDBColumn
            Caption = #1057#1095#1077#1090' '#1050' '#1053#1072#1087#1088#1072#1074#1083' '#1082#1086#1076
            DataBinding.FieldName = 'KreditAccountDirectionCode'
            Visible = False
            HeaderAlignmentHorz = taCenter
            Width = 40
          end
          object colKreditAccountDirectionName: TcxGridDBColumn
            Caption = #1057#1095#1077#1090' '#1050' '#1053#1072#1087#1088#1072#1074#1083
            DataBinding.FieldName = 'KreditAccountDirectionName'
            Visible = False
            HeaderAlignmentHorz = taCenter
            Width = 80
          end
          object colKreditAccountCode: TcxGridDBColumn
            Caption = #1057#1095#1077#1090' '#1050' '#1082#1086#1076
            DataBinding.FieldName = 'KreditAccountCode'
            HeaderAlignmentHorz = taCenter
            Width = 40
          end
          object colKreditAccountName: TcxGridDBColumn
            Caption = #1057#1095#1077#1090' '#1050
            DataBinding.FieldName = 'KreditAccountName'
            HeaderAlignmentHorz = taCenter
            Width = 120
          end
          object colByObjectCode: TcxGridDBColumn
            Caption = #1054#1073'.'#1082#1086#1076
            DataBinding.FieldName = 'ByObjectCode'
            Visible = False
            HeaderAlignmentHorz = taCenter
            Width = 40
          end
          object colByObjectName: TcxGridDBColumn
            Caption = #1054#1073#1098#1077#1082#1090' '#1085#1072#1079#1074#1072#1085#1080#1077
            DataBinding.FieldName = 'ByObjectName'
            HeaderAlignmentHorz = taCenter
            Width = 80
          end
          object colGoodsGroupName: TcxGridDBColumn
            Caption = #1043#1088#1091#1087#1087#1072' '#1090#1086#1074#1072#1088#1072
            DataBinding.FieldName = 'GoodsGroupName'
            Visible = False
            HeaderAlignmentHorz = taCenter
            Width = 80
          end
          object colGoodsCode: TcxGridDBColumn
            Caption = #1050#1086#1076' '#1090#1086#1074'.'
            DataBinding.FieldName = 'GoodsCode'
            Width = 40
          end
          object colGoodsName: TcxGridDBColumn
            Caption = #1058#1086#1074#1072#1088
            DataBinding.FieldName = 'GoodsName'
            HeaderAlignmentHorz = taCenter
            Width = 80
          end
          object colGoodsKindName_comlete: TcxGridDBColumn
            Caption = #1042#1080#1076' '#1090#1086#1074#1072#1088#1072
            DataBinding.FieldName = 'GoodsKindName'
            HeaderAlignmentHorz = taCenter
            Width = 60
          end
          object colAccountOnComplete: TcxGridDBColumn
            Caption = '***'
            DataBinding.FieldName = 'AccountOnComplete'
            HeaderAlignmentHorz = taCenter
            Width = 25
          end
          object colDebetAmount: TcxGridDBColumn
            Caption = #1057#1091#1084#1084#1072' '#1076#1077#1073#1077#1090
            DataBinding.FieldName = 'DebetAmount'
            HeaderAlignmentHorz = taCenter
            Width = 70
          end
          object colKreditAmount: TcxGridDBColumn
            Caption = #1057#1091#1084#1084#1072' '#1082#1088#1077#1076#1080#1090
            DataBinding.FieldName = 'KreditAmount'
            HeaderAlignmentHorz = taCenter
            Width = 70
          end
          object colPrice_comlete: TcxGridDBColumn
            Caption = #1062#1077#1085#1072
            DataBinding.FieldName = 'Price'
            Width = 40
          end
          object colInfoMoneyCode: TcxGridDBColumn
            Caption = #1050#1086#1076' '#1089#1090'. '#1085#1072#1079#1085#1072#1095'.'
            DataBinding.FieldName = 'InfoMoneyCode'
            Width = 40
          end
          object colInfoMoneyName: TcxGridDBColumn
            Caption = #1057#1090#1072#1090#1100#1103' '#1085#1072#1079#1085#1072#1095#1077#1085#1080#1103
            DataBinding.FieldName = 'InfoMoneyName'
            Width = 55
          end
          object colInfoMoneyCode_Detail: TcxGridDBColumn
            Caption = #1050#1086#1076' '#1089#1090'. '#1085#1072#1079#1085#1072#1095'.'#1076#1077#1090'.'
            DataBinding.FieldName = 'InfoMoneyCode_Detail'
            Width = 40
          end
          object colInfoMoneyName_Detail: TcxGridDBColumn
            Caption = #1057#1090#1072#1090#1100#1103' '#1085#1072#1079#1085#1072#1095#1077#1085#1080#1103' '#1076#1077#1090#1072#1083#1100#1085#1086
            DataBinding.FieldName = 'InfoMoneyName_Detail'
            Width = 55
          end
          object colGoodsCode_Parent: TcxGridDBColumn
            Caption = #1050#1086#1076' '#1090#1086#1074'.'#1075#1083'.'
            DataBinding.FieldName = 'GoodsCode_Parent'
            Width = 40
          end
          object colGoodsName_Parent: TcxGridDBColumn
            Caption = #1058#1086#1074#1072#1088' '#1075#1083#1072#1074#1085#1099#1081
            DataBinding.FieldName = 'GoodsName_Parent'
            Width = 55
          end
          object colGoodsKindName_Parent: TcxGridDBColumn
            Caption = #1042#1080#1076' '#1090#1086#1074#1072#1088#1072' '#1075#1083'.'
            DataBinding.FieldName = 'GoodsKindName_Parent'
            Width = 50
          end
          object colObjectCostId: TcxGridDBColumn
            DataBinding.FieldName = 'ObjectCostId'
          end
          object colMIId_Parent: TcxGridDBColumn
            DataBinding.FieldName = 'MIId_Parent'
            Width = 40
          end
        end
        object cxGridEntryLevel: TcxGridLevel
          GridView = cxGridEntryDBTableView
        end
      end
    end
  end
  object FormParams: TdsdFormParams
    Params = <
      item
        Name = 'Id'
        DataType = ftInteger
        ParamType = ptInputOutput
        Value = '0'
      end>
    Left = 200
    Top = 80
  end
  object spSelectMovementItem: TdsdStoredProc
    StoredProcName = 'gpSelect_MI_Transport'
    DataSet = MasterCDS
    DataSets = <
      item
        DataSet = MasterCDS
      end
      item
        DataSet = ChildCDS
      end>
    OutputType = otMultiDataSet
    Params = <
      item
        Name = 'inMovementId'
        Component = FormParams
        ComponentItem = 'Id'
        DataType = ftInteger
        ParamType = ptInput
        Value = '0'
      end
      item
        Name = 'inShowAll'
        DataType = ftBoolean
        ParamType = ptInput
        Value = 'False'
      end>
    Left = 225
    Top = 191
  end
  object cxPropertiesStore: TcxPropertiesStore
    Components = <
      item
        Component = cxSplitterChild
        Properties.Strings = (
          'Top')
      end
      item
        Component = Owner
        Properties.Strings = (
          'Height'
          'Left'
          'Top'
          'Width')
      end>
    StorageName = 'cxPropertiesStore'
    Left = 377
    Top = 190
  end
  object ActionList: TActionList
    Images = dmMain.ImageList
    Left = 318
    Top = 206
    object actRefresh: TdsdDataSetRefresh
      Category = 'DSDLib'
      StoredProc = spGet
      StoredProcList = <
        item
          StoredProc = spGet
        end
        item
          StoredProc = spSelectMovementItem
        end
        item
          StoredProc = spSelectMIContainer
        end>
      Caption = #1055#1077#1088#1077#1095#1080#1090#1072#1090#1100
      Hint = #1054#1073#1085#1086#1074#1080#1090#1100' '#1076#1072#1085#1085#1099#1077
      ImageIndex = 4
      ShortCut = 116
    end
    object actUpdateDataSet: TdsdUpdateDataSet
      Category = 'DSDLib'
      StoredProc = spInsertUpdateMIMaster
      StoredProcList = <
        item
          StoredProc = spInsertUpdateMIMaster
        end>
      Caption = 'actUpdateDataSet'
      DataSource = MasterDS
    end
    object actPrint: TdsdPrintAction
      Category = 'DSDLib'
      StoredProcList = <>
      Caption = #1055#1077#1095#1072#1090#1100
      Hint = #1055#1077#1095#1072#1090#1100
      ImageIndex = 3
      ShortCut = 16464
      Params = <>
      ReportName = #1055#1088#1080#1093#1086#1076#1085#1072#1103' '#1085#1072#1082#1083#1072#1076#1085#1072#1103
    end
    object dsdGridToExcel: TdsdGridToExcel
      Category = 'DSDLib'
      Caption = #1042#1099#1075#1088#1091#1079#1082#1072' '#1074' Excel'
      Hint = #1042#1099#1075#1088#1091#1079#1082#1072' '#1074' Excel'
      ImageIndex = 6
      ShortCut = 16472
    end
    object BooleanStoredProcAction: TBooleanStoredProcAction
      Category = 'DSDLib'
      StoredProc = spSelectMovementItem
      StoredProcList = <
        item
          StoredProc = spSelectMovementItem
        end>
      Caption = #1055#1086#1082#1072#1079#1072#1090#1100' '#1074#1089#1077
      Hint = #1055#1086#1082#1072#1079#1072#1090#1100' '#1074#1089#1077
      ImageIndex = 26
      Value = False
      HintTrue = #1055#1086#1082#1072#1079#1072#1090#1100' '#1090#1086#1074#1072#1088#1099' '#1074' '#1076#1086#1082#1091#1084#1077#1085#1090#1077
      HintFalse = #1055#1086#1082#1072#1079#1072#1090#1100' '#1074#1089#1077
      CaptionTrue = #1055#1086#1082#1072#1079#1072#1090#1100' '#1090#1086#1074#1072#1088#1099' '#1074' '#1076#1086#1082#1091#1084#1077#1085#1090#1077
      CaptionFalse = #1055#1086#1082#1072#1079#1072#1090#1100' '#1074#1089#1077
      ImageIndexTrue = 25
      ImageIndexFalse = 26
    end
    object actInsertUpdateMovement: TdsdExecStoredProc
      Category = 'DSDLib'
      StoredProc = spInsertUpdateMovement
      StoredProcList = <
        item
          StoredProc = spInsertUpdateMovement
        end>
      Caption = #1057#1086#1093#1088#1072#1085#1077#1085#1080#1077' '#1076#1086#1082#1091#1084#1077#1085#1090#1072
      Hint = #1057#1086#1093#1088#1072#1085#1077#1085#1080#1077' '#1076#1086#1082#1091#1084#1077#1085#1090#1072
      ImageIndex = 14
      ShortCut = 113
    end
  end
  object MasterDS: TDataSource
    DataSet = MasterCDS
    Left = 45
    Top = 200
  end
  object MasterCDS: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 16
    Top = 200
  end
  object GuidesCar: TdsdGuides
    LookupControl = edCar
    FormName = 'TCarForm'
    PositionDataSet = 'ClientDataSet'
    Params = <
      item
        Name = 'Key'
        Component = GuidesCar
        ComponentItem = 'Key'
        DataType = ftString
        ParamType = ptInput
        Value = ''
      end
      item
        Name = 'TextValue'
        Component = GuidesCar
        ComponentItem = 'TextValue'
        DataType = ftString
        ParamType = ptInput
        Value = ''
      end
      item
        Name = 'DriverId'
        Component = GuidesPersonalDriver
        ComponentItem = 'Key'
        DataType = ftInteger
        ParamType = ptOutput
        Value = ''
      end
      item
        Name = 'DriverName'
        Component = GuidesPersonalDriver
        ComponentItem = 'TextValue'
        DataType = ftString
        ParamType = ptOutput
        Value = ''
      end>
    Left = 250
    Top = 35
  end
  object spGet: TdsdStoredProc
    StoredProcName = 'gpGet_Movement_Transport'
    DataSets = <>
    OutputType = otResult
    Params = <
      item
        Name = 'inId'
        Component = FormParams
        ComponentItem = 'Id'
        DataType = ftInteger
        ParamType = ptInput
        Value = '0'
      end
      item
        Name = 'InvNumber'
        Component = edInvNumber
        DataType = ftInteger
        ParamType = ptOutput
        Value = ''
      end
      item
        Name = 'OperDate'
        Component = edOperDate
        DataType = ftInteger
        ParamType = ptOutput
        Value = 0d
      end
      item
        Name = 'CarId'
        Component = GuidesCar
        ComponentItem = 'Key'
        DataType = ftInteger
        ParamType = ptOutput
        Value = ''
      end
      item
        Name = 'CarName'
        Component = GuidesCar
        ComponentItem = 'TextValue'
        DataType = ftInteger
        ParamType = ptOutput
        Value = ''
      end
      item
        Name = 'CarTrailerId'
        Component = GuidesCarTrailer
        ComponentItem = 'Key'
        DataType = ftInteger
        ParamType = ptOutput
        Value = ''
      end
      item
        Name = 'CarTrailerName'
        Component = GuidesCarTrailer
        ComponentItem = 'TextValue'
        DataType = ftInteger
        ParamType = ptOutput
        Value = ''
      end
      item
        Name = 'PersonalDriverId'
        Component = GuidesPersonalDriver
        ComponentItem = 'Key'
        DataType = ftInteger
        ParamType = ptOutput
        Value = ''
      end
      item
        Name = 'PersonalDriverName'
        Component = GuidesPersonalDriver
        ComponentItem = 'TextValue'
        DataType = ftInteger
        ParamType = ptOutput
        Value = ''
      end
      item
        Name = 'PersonalDriverMoreId'
        Component = GuidesPersonalDriverMore
        ComponentItem = 'Key'
        DataType = ftInteger
        ParamType = ptOutput
        Value = ''
      end
      item
        Name = 'PersonalDriverMoreName'
        Component = GuidesPersonalDriverMore
        ComponentItem = 'TextValue'
        DataType = ftInteger
        ParamType = ptOutput
        Value = ''
      end
      item
        Name = 'UnitForwardingId'
        Component = GuidesUnitForwarding
        ComponentItem = 'Key'
        DataType = ftInteger
        ParamType = ptOutput
        Value = ''
      end
      item
        Name = 'UnitForwardingName'
        Component = GuidesUnitForwarding
        ComponentItem = 'TextValue'
        DataType = ftInteger
        ParamType = ptOutput
        Value = ''
      end
      item
        Name = 'StartRunPlan'
        Component = edStartRunPlan
        DataType = ftDateTime
        ParamType = ptOutput
        Value = 0d
      end
      item
        Name = 'EndRunPlan'
        Component = edEndRunPlan
        DataType = ftDateTime
        ParamType = ptOutput
        Value = 0d
      end
      item
        Name = 'StartRun'
        Component = edStartRun
        DataType = ftDateTime
        ParamType = ptOutput
        Value = 0d
      end
      item
        Name = 'EndRun'
        Component = edEndRun
        DataType = ftDateTime
        ParamType = ptOutput
        Value = 0d
      end
      item
        Name = 'HoursWork'
        Component = edHoursWork
        DataType = ftFloat
        ParamType = ptOutput
        Value = 0.000000000000000000
      end
      item
        Name = 'HoursAdd'
        Component = edHoursAdd
        DataType = ftFloat
        ParamType = ptOutput
        Value = 0.000000000000000000
      end
      item
        Name = 'Comment'
        Component = edComment
        DataType = ftString
        ParamType = ptOutput
        Value = ''
      end>
    Left = 152
    Top = 80
  end
  object PopupMenu: TPopupMenu
    Images = dmMain.ImageList
    Left = 278
    Top = 222
    object N1: TMenuItem
      Action = actRefresh
    end
  end
  object spSelectMIContainer: TdsdStoredProc
    StoredProcName = 'gpSelect_MovementItemContainer_Movement'
    DataSet = EntryCDS
    DataSets = <
      item
        DataSet = EntryCDS
      end>
    Params = <
      item
        Name = 'inMovementId'
        Component = FormParams
        ComponentItem = 'Id'
        DataType = ftInteger
        ParamType = ptInput
        Value = '0'
      end>
    Left = 578
    Top = 216
  end
  object EntryCDS: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 505
    Top = 240
  end
  object EntryDS: TDataSource
    DataSet = EntryCDS
    Left = 525
    Top = 192
  end
  object spInsertUpdateMIMaster: TdsdStoredProc
    StoredProcName = 'gpInsertUpdate_MI_Transport_Master'
    DataSets = <>
    OutputType = otResult
    Params = <
      item
        Name = 'ioId'
        Component = MasterCDS
        ComponentItem = 'Id'
        DataType = ftInteger
        ParamType = ptInputOutput
      end
      item
        Name = 'inMovementId'
        Component = FormParams
        ComponentItem = 'Id'
        DataType = ftInteger
        ParamType = ptInput
        Value = '0'
      end
      item
        Name = 'inRouteId'
        Component = MasterCDS
        ComponentItem = 'RouteId'
        DataType = ftInteger
        ParamType = ptInput
      end
      item
        Name = 'inAmount'
        Component = MasterCDS
        ComponentItem = 'Amount'
        DataType = ftFloat
        ParamType = ptInput
      end
      item
        Name = 'inWeight'
        Component = MasterCDS
        ComponentItem = 'Weight'
        DataType = ftFloat
        ParamType = ptInput
      end
      item
        Name = 'inStartOdometre'
        Component = MasterCDS
        ComponentItem = 'StartOdometre'
        DataType = ftFloat
        ParamType = ptInput
      end
      item
        Name = 'inEndOdometre'
        Component = MasterCDS
        ComponentItem = 'EndOdometre'
        DataType = ftFloat
        ParamType = ptInput
      end
      item
        Name = 'inFreightId'
        Component = MasterCDS
        ComponentItem = 'FreightId'
        DataType = ftInteger
        ParamType = ptInput
      end
      item
        Name = 'inRouteKindId'
        Component = MasterCDS
        ComponentItem = 'RouteKindId'
        DataType = ftInteger
        ParamType = ptInput
      end>
    Left = 86
    Top = 216
  end
  object frxDBDataset: TfrxDBDataset
    UserName = 'frxDBDataset'
    CloseDataSource = False
    DataSet = MasterCDS
    BCDToCurrency = False
    Left = 233
    Top = 235
  end
  object ChildCDS: TClientDataSet
    Aggregates = <>
    IndexFieldNames = 'ParentId'
    MasterFields = 'Id'
    MasterSource = MasterDS
    PacketRecords = 0
    Params = <>
    Left = 16
    Top = 345
  end
  object ChildDS: TDataSource
    DataSet = ChildCDS
    Left = 44
    Top = 346
  end
  object spInsertUpdateMovement: TdsdStoredProc
    StoredProcName = 'gpInsertUpdate_Movement_Transport'
    DataSets = <>
    OutputType = otResult
    Params = <
      item
        Name = 'ioId'
        Component = FormParams
        ComponentItem = 'Id'
        DataType = ftInteger
        ParamType = ptInputOutput
        Value = '0'
      end
      item
        Name = 'inInvNumber'
        Component = edInvNumber
        DataType = ftString
        ParamType = ptInput
        Value = ''
      end
      item
        Name = 'inOperDate'
        Component = edOperDate
        DataType = ftDateTime
        ParamType = ptInput
        Value = 0d
      end
      item
        Name = 'inStartRunPlan'
        Component = edStartRunPlan
        DataType = ftDateTime
        ParamType = ptInput
        Value = 0d
      end
      item
        Name = 'inEndRunPlan'
        Component = edEndRunPlan
        DataType = ftDateTime
        ParamType = ptInput
        Value = 0d
      end
      item
        Name = 'inStartRun'
        Component = edStartRun
        DataType = ftDateTime
        ParamType = ptInput
        Value = 0d
      end
      item
        Name = 'inEndRun'
        Component = edEndRun
        DataType = ftDateTime
        ParamType = ptInput
        Value = 0d
      end
      item
        Name = 'inHoursAdd'
        Component = edHoursAdd
        DataType = ftFloat
        ParamType = ptInput
        Value = 0.000000000000000000
      end
      item
        Name = 'inComment'
        Component = edComment
        DataType = ftString
        ParamType = ptInput
        Value = ''
      end
      item
        Name = 'inCarId'
        Component = GuidesCar
        ComponentItem = 'Key'
        DataType = ftInteger
        ParamType = ptInput
        Value = ''
      end
      item
        Name = 'inCarTrailerId'
        Component = GuidesCarTrailer
        ComponentItem = 'Key'
        DataType = ftInteger
        ParamType = ptInput
        Value = ''
      end
      item
        Name = 'inPersonalDriverId'
        Component = GuidesPersonalDriver
        ComponentItem = 'Key'
        DataType = ftInteger
        ParamType = ptInput
        Value = ''
      end
      item
        Name = 'inPersonalDriverMoreId'
        Component = GuidesPersonalDriverMore
        ComponentItem = 'Key'
        DataType = ftInteger
        ParamType = ptInput
        Value = ''
      end
      item
        Name = 'inUnitForwardingId'
        Component = GuidesUnitForwarding
        ComponentItem = 'Key'
        DataType = ftInteger
        ParamType = ptInput
        Value = ''
      end>
    Left = 496
    Top = 80
  end
  object GuidesCarTrailer: TdsdGuides
    LookupControl = edCarTrailer
    FormName = 'TCarForm'
    PositionDataSet = 'ClientDataSet'
    Params = <
      item
        Name = 'Key'
        Component = GuidesCarTrailer
        ComponentItem = 'Key'
        DataType = ftInteger
        ParamType = ptInput
        Value = ''
      end
      item
        Name = 'TextValue'
        Component = GuidesCarTrailer
        ComponentItem = 'TextValue'
        DataType = ftString
        ParamType = ptInput
        Value = ''
      end>
    Left = 730
    Top = 3
  end
  object GuidesPersonalDriver: TdsdGuides
    LookupControl = edPersonalDriver
    FormName = 'TPersonalForm'
    PositionDataSet = 'ClientDataSet'
    Params = <
      item
        Name = 'Key'
        Component = GuidesPersonalDriver
        ComponentItem = 'Key'
        DataType = ftInteger
        ParamType = ptInput
        Value = ''
      end
      item
        Name = 'TextValue'
        Component = GuidesPersonalDriver
        ComponentItem = 'TextValue'
        DataType = ftString
        ParamType = ptInput
        Value = ''
      end>
    Left = 178
    Top = 43
  end
  object GuidesPersonalDriverMore: TdsdGuides
    LookupControl = edPersonalDriverMore
    FormName = 'TPersonalForm'
    PositionDataSet = 'ClientDataSet'
    Params = <
      item
        Name = 'Key'
        Component = GuidesPersonalDriverMore
        ComponentItem = 'Key'
        DataType = ftInteger
        ParamType = ptInput
        Value = ''
      end
      item
        Name = 'TextValue'
        Component = GuidesPersonalDriverMore
        ComponentItem = 'TextValue'
        DataType = ftString
        ParamType = ptInput
        Value = ''
      end>
    Left = 674
    Top = 59
  end
  object GuidesUnitForwarding: TdsdGuides
    LookupControl = edUnitForwarding
    FormName = 'TUnitForm'
    PositionDataSet = 'ClientDataSet'
    Params = <
      item
        Name = 'Key'
        Component = GuidesUnitForwarding
        ComponentItem = 'Key'
        DataType = ftInteger
        ParamType = ptInput
        Value = ''
      end
      item
        Name = 'TextValue'
        Component = GuidesUnitForwarding
        ComponentItem = 'TextValue'
        DataType = ftString
        ParamType = ptInput
        Value = ''
      end>
    Left = 818
    Top = 83
  end
  object spInsertUpdateMIChild: TdsdStoredProc
    StoredProcName = 'gpInsertUpdate_MI_Transport_Child'
    DataSets = <>
    OutputType = otResult
    Params = <
      item
        Name = 'ioId'
        Component = ChildCDS
        ComponentItem = 'Id'
        DataType = ftInteger
        ParamType = ptInputOutput
      end
      item
        Name = 'inMovementId'
        Component = FormParams
        ComponentItem = 'Id'
        DataType = ftInteger
        ParamType = ptInput
        Value = '0'
      end
      item
        Name = 'inParentId'
        Component = ChildCDS
        ComponentItem = 'ParentId'
        DataType = ftInteger
        ParamType = ptInput
      end
      item
        Name = 'inFuelId'
        Component = ChildCDS
        ComponentItem = 'FuelId'
        DataType = ftInteger
        ParamType = ptInput
      end
      item
        Name = 'inCalculated'
        Component = ChildCDS
        ComponentItem = 'Calculated'
        DataType = ftInteger
        ParamType = ptInput
      end
      item
        Name = 'inAmount'
        Component = ChildCDS
        ComponentItem = 'Amount'
        DataType = ftFloat
        ParamType = ptInput
      end
      item
        Name = 'inColdHour'
        Component = ChildCDS
        ComponentItem = 'ColdHour'
        DataType = ftFloat
        ParamType = ptInput
      end
      item
        Name = 'inColdDistance'
        Component = ChildCDS
        ComponentItem = 'ColdDistance'
        DataType = ftFloat
        ParamType = ptInput
      end
      item
        Name = 'inAmountColdHour'
        Component = ChildCDS
        ComponentItem = 'AmountColdHour'
        DataType = ftFloat
        ParamType = ptInput
      end
      item
        Name = 'inAmountColdDistance'
        Component = ChildCDS
        ComponentItem = 'AmountColdDistance'
        DataType = ftFloat
        ParamType = ptOutput
      end
      item
        Name = 'inAmountFuel'
        Component = ChildCDS
        ComponentItem = 'AmountFuel'
        DataType = ftFloat
        ParamType = ptOutput
      end
      item
        Name = 'inRateFuelKindId'
        Component = ChildCDS
        ComponentItem = 'RateFuelKindId'
        DataType = ftInteger
        ParamType = ptOutput
      end>
    Left = 78
    Top = 352
  end
  object GuidesFiller: TGuidesFiller
    IdParam.Component = FormParams
    IdParam.ComponentItem = 'Id'
    IdParam.DataType = ftInteger
    IdParam.ParamType = ptOutput
    IdParam.Value = '0'
    GuidesList = <
      item
        Guides = GuidesCar
      end
      item
        Guides = GuidesPersonalDriver
      end
      item
        Guides = GuidesUnitForwarding
      end>
    ActionItemList = <
      item
        Action = actInsertUpdateMovement
      end>
    Left = 288
    Top = 80
  end
  object HeaderSaver: THeaderSaver
    IdParam.Component = FormParams
    IdParam.ComponentItem = 'Id'
    IdParam.DataType = ftInteger
    IdParam.ParamType = ptOutput
    IdParam.Value = '0'
    StoredProc = spInsertUpdateMovement
    ControlList = <
      item
        Control = edCar
      end
      item
        Control = edOperDate
      end
      item
        Control = edStartRun
      end
      item
        Control = edStartRunPlan
      end
      item
        Control = edEndRun
      end
      item
        Control = edEndRunPlan
      end
      item
        Control = edPersonalDriver
      end
      item
        Control = edPersonalDriverMore
      end
      item
        Control = edUnitForwarding
      end
      item
        Control = edComment
      end
      item
        Control = edCarTrailer
      end>
    Left = 376
    Top = 104
  end
  object dxBarManager: TdxBarManager
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    Categories.Strings = (
      'Default')
    Categories.ItemsVisibles = (
      2)
    Categories.Visibles = (
      True)
    ImageOptions.Images = dmMain.ImageList
    PopupMenuLinks = <>
    ShowShortCutInHint = True
    UseSystemFont = True
    Left = 16
    Top = 144
    DockControlHeights = (
      0
      0
      26
      0)
    object dxBarManagerBar: TdxBar
      AllowClose = False
      Caption = 'Custom'
      CaptionButtons = <>
      DockedDockingStyle = dsTop
      DockedLeft = 0
      DockedTop = 0
      DockingStyle = dsTop
      FloatLeft = 671
      FloatTop = 8
      FloatClientWidth = 51
      FloatClientHeight = 71
      ItemLinks = <
        item
          Visible = True
          ItemName = 'bbBooleanAction'
        end
        item
          Visible = True
          ItemName = 'bbInsertUpdateMovement'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'bbStatic'
        end
        item
          Visible = True
          ItemName = 'bbRefresh'
        end
        item
          Visible = True
          ItemName = 'bbPrint'
        end
        item
          Visible = True
          ItemName = 'bbGridToExel'
        end
        item
          Visible = True
          ItemName = 'bbEntryToGrid'
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
    object bbPrint: TdxBarButton
      Action = actPrint
      Category = 0
    end
    object bbBooleanAction: TdxBarButton
      Action = BooleanStoredProcAction
      Category = 0
    end
    object bbStatic: TdxBarStatic
      Caption = '     '
      Category = 0
      Visible = ivAlways
    end
    object bbGridToExel: TdxBarButton
      Action = dsdGridToExcel
      Category = 0
    end
    object bbEntryToGrid: TdxBarButton
      Category = 0
      Visible = ivAlways
    end
    object bbInsertUpdateMovement: TdxBarButton
      Action = actInsertUpdateMovement
      Category = 0
    end
  end
  object RefreshAddOn: TRefreshAddOn
    FormName = 'TransportJournalForm'
    DataSet = 'ClientDataSet'
    RefreshAction = 'actRefresh'
    FormParams = 'FormParams'
    Left = 584
    Top = 88
  end
end
