inherited Report_Goods_byMovementForm: TReport_Goods_byMovementForm
  Caption = #1054#1090#1095#1077#1090' <'#1055#1086' '#1086#1090#1075#1088#1091#1079#1082#1072#1084'>'
  ClientHeight = 402
  ClientWidth = 800
  AddOnFormData.isSingle = False
  AddOnFormData.ExecuteDialogAction = ExecuteDialog
  AddOnFormData.Params = FormParams
  ExplicitWidth = 816
  ExplicitHeight = 440
  PixelsPerInch = 96
  TextHeight = 13
  inherited PageControl: TcxPageControl
    Top = 80
    Width = 800
    Height = 322
    TabOrder = 3
    ExplicitTop = 80
    ExplicitWidth = 800
    ExplicitHeight = 322
    ClientRectBottom = 322
    ClientRectRight = 800
    ClientRectTop = 24
    inherited tsMain: TcxTabSheet
      Caption = #1043#1086#1090#1086#1074#1072#1103' '#1087#1088#1086#1076#1091#1082#1094#1080#1103
      TabVisible = True
      ExplicitTop = 24
      ExplicitWidth = 800
      ExplicitHeight = 298
      inherited cxGrid: TcxGrid
        Width = 800
        Height = 298
        ExplicitWidth = 800
        ExplicitHeight = 298
        inherited cxGridDBTableView: TcxGridDBTableView
          DataController.Summary.DefaultGroupSummaryItems = <
            item
              Format = ',0.00;-,0.00'
              Kind = skSum
              Position = spFooter
            end
            item
              Format = ',0.00;-,0.00'
              Kind = skSum
              Position = spFooter
            end
            item
              Format = ',0.00;-,0.00'
              Kind = skSum
              Position = spFooter
              Column = SaleAmountPartner
            end
            item
              Format = ',0.00;-,0.00;0.00;'
              Kind = skSum
            end
            item
              Format = ',0.00;-,0.00;0.00;'
              Kind = skSum
            end
            item
              Format = ',0.00;-,0.00;0.00;'
              Kind = skSum
            end
            item
              Format = ',0.####'
              Kind = skSum
              Column = SaleAmountPartner
            end
            item
              Format = ',0.####'
              Kind = skSum
              Column = SaleAmount
            end
            item
              Format = ',0.00;-,0.00;0.00;'
              Kind = skSum
            end
            item
              Format = ',0.00;-,0.00;0.00;'
              Kind = skSum
            end
            item
              Format = ',0.00;-,0.00;0.00;'
              Kind = skSum
            end
            item
              Format = ',0.00;-,0.00;0.00;'
              Kind = skSum
            end
            item
              Format = ',0.00;-,0.00;0.00;'
              Kind = skSum
            end
            item
              Format = ',0.00;-,0.00;0.00;'
              Kind = skSum
            end
            item
              Format = ',0.00;-,0.00;0.00;'
              Kind = skSum
            end
            item
              Format = ',0.00;-,0.00;0.00;'
              Kind = skSum
            end
            item
              Format = ',0.00;-,0.00;0.00;'
              Kind = skSum
            end
            item
              Format = ',0.####'
              Kind = skSum
              Column = ReturnAmount
            end
            item
              Format = ',0.####'
              Kind = skSum
              Column = Amount
            end
            item
              Format = ',0.####'
              Kind = skSum
              Column = ReturnAmountPartner
            end
            item
              Format = ',0.####'
              Kind = skSum
              Column = AmountPartner
            end>
          DataController.Summary.FooterSummaryItems = <
            item
              Format = ',0.00;-,0.00'
              Kind = skSum
            end
            item
              Format = ',0.00;-,0.00'
              Kind = skSum
            end
            item
              Format = ',0.####'
              Kind = skSum
              Column = SaleAmountPartner
            end
            item
              Format = ',0.00;-,0.00;0.00;'
              Kind = skSum
            end
            item
              Format = ',0.00;-,0.00;0.00;'
              Kind = skSum
            end
            item
              Format = ',0.####'
              Kind = skSum
              Column = SaleAmount
            end
            item
              Format = ',0.00;-,0.00;0.00;'
              Kind = skSum
            end
            item
              Format = ',0.00;-,0.00;0.00;'
              Kind = skSum
            end
            item
              Format = ',0.00;-,0.00;0.00;'
              Kind = skSum
            end
            item
              Format = ',0.00;-,0.00;0.00;'
              Kind = skSum
            end
            item
              Format = ',0.00;-,0.00;0.00;'
              Kind = skSum
            end
            item
              Format = ',0.00;-,0.00;0.00;'
              Kind = skSum
            end
            item
              Format = ',0.00;-,0.00;0.00;'
              Kind = skSum
            end
            item
              Format = ',0.00;-,0.00;0.00;'
              Kind = skSum
            end
            item
              Format = ',0.00;-,0.00;0.00;'
              Kind = skSum
            end
            item
              Format = ',0.####'
              Kind = skSum
              Column = ReturnAmount
            end
            item
              Format = ',0.####'
              Kind = skSum
              Column = Amount
            end
            item
              Format = ',0.####'
              Kind = skSum
              Column = ReturnAmountPartner
            end
            item
              Format = ',0.####'
              Kind = skSum
              Column = AmountPartner
            end>
          OptionsData.Deleting = False
          OptionsData.DeletingConfirmation = False
          OptionsData.Editing = False
          Styles.Content = nil
          Styles.Inactive = nil
          Styles.Selection = nil
          Styles.Footer = nil
          Styles.Header = nil
          object colGroupName: TcxGridDBColumn
            Caption = #1043#1088#1091#1087#1087#1072
            DataBinding.FieldName = 'GroupName'
            GroupSummaryAlignment = taCenter
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Width = 192
          end
          object SaleAmount: TcxGridDBColumn
            Caption = #1055#1088#1086#1076#1072#1078#1072', '#1082#1075
            DataBinding.FieldName = 'SaleAmount'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = ',0.00;-,0.00; ;'
            GroupSummaryAlignment = taCenter
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Width = 90
          end
          object ReturnAmount: TcxGridDBColumn
            Caption = #1042#1086#1079#1074#1088#1072#1090', '#1082#1075
            DataBinding.FieldName = 'ReturnAmount'
            GroupSummaryAlignment = taCenter
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Width = 90
          end
          object Amount: TcxGridDBColumn
            Caption = #1063#1080#1089#1090#1072#1103' '#1087#1088#1086#1076#1072#1078#1072', '#1082#1075
            DataBinding.FieldName = 'Amount'
            GroupSummaryAlignment = taCenter
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Width = 80
          end
          object ReturnAmountPartner: TcxGridDBColumn
            Caption = #1042#1086#1079#1074#1088#1072#1090', '#1082#1075' ('#1080#1085#1092'.)'
            DataBinding.FieldName = 'ReturnAmountPartner'
            GroupSummaryAlignment = taCenter
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Width = 90
          end
          object SaleAmountPartner: TcxGridDBColumn
            Caption = #1055#1088#1086#1076#1072#1078#1072', '#1082#1075' ('#1080#1085#1092'.)'
            DataBinding.FieldName = 'SaleAmountPartner'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = ',0.00;-,0.00; ;'
            GroupSummaryAlignment = taCenter
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Width = 90
          end
          object AmountPartner: TcxGridDBColumn
            Caption = #1063#1080#1089#1090#1072#1103' '#1087#1088#1086#1076#1072#1078#1072', '#1082#1075' ('#1080#1085#1092'.)'
            DataBinding.FieldName = 'AmountPartner'
            GroupSummaryAlignment = taCenter
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Width = 80
          end
        end
      end
    end
    object tsPivot: TcxTabSheet
      Caption = #1058#1091#1096#1077#1085#1082#1072
      ImageIndex = 1
      object cxGrid1: TcxGrid
        Left = 0
        Top = 0
        Width = 800
        Height = 298
        Align = alClient
        PopupMenu = PopupMenu
        TabOrder = 0
        object cxGridDBTableView1: TcxGridDBTableView
          Navigator.Buttons.CustomButtons = <>
          DataController.DataSource = MasterDS
          DataController.Filter.Options = [fcoCaseInsensitive]
          DataController.Summary.DefaultGroupSummaryItems = <
            item
              Format = ',0.00;-,0.00'
              Kind = skSum
              Position = spFooter
            end
            item
              Format = ',0.00;-,0.00'
              Kind = skSum
              Position = spFooter
            end
            item
              Format = ',0.00;-,0.00'
              Kind = skSum
              Position = spFooter
            end
            item
              Format = ',0.00;-,0.00;0.00;'
              Kind = skSum
            end
            item
              Format = ',0.00;-,0.00;0.00;'
              Kind = skSum
            end
            item
              Format = ',0.00;-,0.00;0.00;'
              Kind = skSum
            end
            item
              Format = ',0.00;-,0.00;0.00;'
              Kind = skSum
            end
            item
              Format = ',0.00;-,0.00;0.00;'
              Kind = skSum
            end
            item
              Format = ',0.00;-,0.00;0.00;'
              Kind = skSum
            end
            item
              Format = ',0.00;-,0.00;0.00;'
              Kind = skSum
            end
            item
              Format = ',0.00;-,0.00;0.00;'
              Kind = skSum
            end
            item
              Format = ',0.00;-,0.00;0.00;'
              Kind = skSum
            end
            item
              Format = ',0.00;-,0.00;0.00;'
              Kind = skSum
            end
            item
              Format = ',0.00;-,0.00;0.00;'
              Kind = skSum
            end
            item
              Format = ',0.00;-,0.00;0.00;'
              Kind = skSum
            end
            item
              Format = ',0.00;-,0.00;0.00;'
              Kind = skSum
            end
            item
              Format = ',0.00;-,0.00;0.00;'
              Kind = skSum
            end>
          DataController.Summary.FooterSummaryItems = <
            item
              Format = ',0.00;-,0.00'
              Kind = skSum
            end
            item
              Format = ',0.00;-,0.00'
              Kind = skSum
            end
            item
              Format = ',0.00;-,0.00;0.00;'
              Kind = skSum
            end
            item
              Format = ',0.00;-,0.00;0.00;'
              Kind = skSum
            end
            item
              Format = ',0.00;-,0.00;0.00;'
              Kind = skSum
            end
            item
              Format = ',0.00;-,0.00;0.00;'
              Kind = skSum
            end
            item
              Format = ',0.00;-,0.00;0.00;'
              Kind = skSum
            end
            item
              Format = ',0.00;-,0.00;0.00;'
              Kind = skSum
            end
            item
              Format = ',0.00;-,0.00;0.00;'
              Kind = skSum
            end
            item
              Format = ',0.00;-,0.00;0.00;'
              Kind = skSum
            end
            item
              Format = ',0.00;-,0.00;0.00;'
              Kind = skSum
            end
            item
              Format = ',0.00;-,0.00;0.00;'
              Kind = skSum
            end
            item
              Format = ',0.00;-,0.00;0.00;'
              Kind = skSum
            end
            item
              Format = ',0.00;-,0.00;0.00;'
              Kind = skSum
            end
            item
              Format = ',0.00;-,0.00;0.00;'
              Kind = skSum
            end>
          DataController.Summary.SummaryGroups = <>
          Images = dmMain.SortImageList
          OptionsBehavior.GoToNextCellOnEnter = True
          OptionsBehavior.FocusCellOnCycle = True
          OptionsCustomize.ColumnHiding = True
          OptionsCustomize.ColumnsQuickCustomization = True
          OptionsCustomize.DataRowSizing = True
          OptionsData.CancelOnExit = False
          OptionsData.Deleting = False
          OptionsData.DeletingConfirmation = False
          OptionsData.Editing = False
          OptionsData.Inserting = False
          OptionsView.Footer = True
          OptionsView.GroupByBox = False
          OptionsView.GroupSummaryLayout = gslAlignWithColumns
          OptionsView.HeaderAutoHeight = True
          OptionsView.Indicator = True
          Styles.StyleSheet = dmMain.cxGridTableViewStyleSheet
          object cxGridDBColumn1: TcxGridDBColumn
            Caption = #1044#1072#1090#1072
            DataBinding.FieldName = 'OperDate'
            PropertiesClassName = 'TcxDateEditProperties'
            Properties.DisplayFormat = 'DD.MM.YYYY (DDD)'
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Width = 61
          end
          object cxGridDBColumn2: TcxGridDBColumn
            Caption = #1055#1086#1076#1088#1072#1079#1076#1077#1083#1077#1085#1080#1077
            DataBinding.FieldName = 'UnitName'
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Width = 154
          end
        end
        object cxGridLevel1: TcxGridLevel
          GridView = cxGridDBTableView1
        end
      end
    end
  end
  inherited Panel: TPanel
    Width = 800
    Height = 54
    ExplicitWidth = 800
    ExplicitHeight = 54
    inherited deStart: TcxDateEdit
      Left = 59
      EditValue = 42705d
      Properties.SaveTime = False
      ExplicitLeft = 59
    end
    inherited deEnd: TcxDateEdit
      Left = 59
      Top = 30
      EditValue = 42705d
      Properties.SaveTime = False
      ExplicitLeft = 59
      ExplicitTop = 30
    end
    inherited cxLabel1: TcxLabel
      Left = 12
      Caption = #1044#1072#1090#1072' '#1089' :'
      ExplicitLeft = 12
      ExplicitWidth = 45
    end
    inherited cxLabel2: TcxLabel
      Left = 5
      Top = 31
      Caption = #1044#1072#1090#1072' '#1087#1086' :'
      ExplicitLeft = 5
      ExplicitTop = 31
      ExplicitWidth = 52
    end
    object cxLabel4: TcxLabel
      Left = 489
      Top = 31
      Caption = #1043#1088'. '#1090#1086#1074'. '#1058#1091#1096#1077#1085#1082#1072':'
    end
    object edGoodsGroup: TcxButtonEdit
      Left = 591
      Top = 30
      Properties.Buttons = <
        item
          Default = True
          Kind = bkEllipsis
        end>
      Properties.ReadOnly = True
      TabOrder = 5
      Width = 196
    end
    object cxLabel3: TcxLabel
      Left = 164
      Top = 6
      Caption = #1055#1086#1076#1088#1072#1079#1076#1077#1083#1077#1085#1080#1077':'
    end
    object edUnit: TcxButtonEdit
      Left = 254
      Top = 5
      Properties.Buttons = <
        item
          Default = True
          Kind = bkEllipsis
        end>
      Properties.ReadOnly = True
      TabOrder = 7
      Width = 226
    end
    object cxLabel5: TcxLabel
      Left = 164
      Top = 31
      Caption = #1043#1088'. '#1087#1086#1076#1088#1072#1079#1076'. '#1042#1086#1079#1074#1088#1072#1090':'
    end
    object edUnitGroup: TcxButtonEdit
      Left = 280
      Top = 30
      Properties.Buttons = <
        item
          Default = True
          Kind = bkEllipsis
        end>
      Properties.ReadOnly = True
      TabOrder = 9
      Width = 200
    end
    object cxLabel8: TcxLabel
      Left = 486
      Top = 6
      Caption = #1043#1088#1091#1087#1087#1072' '#1090#1086#1074#1072#1088#1086#1074' '#1043#1055':'
    end
    object edGoodsGroupGP: TcxButtonEdit
      Left = 591
      Top = 5
      Properties.Buttons = <
        item
          Default = True
          Kind = bkEllipsis
        end>
      Properties.ReadOnly = True
      TabOrder = 11
      Width = 196
    end
  end
  inherited cxPropertiesStore: TcxPropertiesStore
    Components = <
      item
        Component = deEnd
        Properties.Strings = (
          'Date')
      end
      item
        Component = deStart
        Properties.Strings = (
          'Date')
      end
      item
        Component = GoodsGroupGuides
        Properties.Strings = (
          'Key'
          'TextValue')
      end
      item
        Component = UnitGuides
        Properties.Strings = (
          'Key'
          'TextValue')
      end>
  end
  inherited ActionList: TActionList
    object ExecuteDialog: TExecuteDialog
      Category = 'DSDLib'
      MoveParams = <>
      Caption = #1048#1079#1084#1077#1085#1080#1090#1100' '#1087#1072#1088#1072#1084#1077#1090#1088#1099' '#1086#1090#1095#1077#1090#1072
      Hint = #1048#1079#1084#1077#1085#1080#1090#1100' '#1087#1072#1088#1072#1084#1077#1090#1088#1099' '#1086#1090#1095#1077#1090#1072
      ImageIndex = 35
      FormName = 'TReport_Goods_byMovementDialogForm'
      FormNameParam.Value = 'TReport_Goods_byMovementDialogForm'
      FormNameParam.DataType = ftString
      FormNameParam.MultiSelectSeparator = ','
      GuiParams = <
        item
          Name = 'StartDate'
          Value = 41640d
          Component = deStart
          DataType = ftDateTime
          ParamType = ptInput
          MultiSelectSeparator = ','
        end
        item
          Name = 'EndDate'
          Value = 41640d
          Component = deEnd
          DataType = ftDateTime
          ParamType = ptInput
          MultiSelectSeparator = ','
        end
        item
          Name = 'UnitId'
          Value = ''
          Component = UnitGuides
          ComponentItem = 'Key'
          ParamType = ptInput
          MultiSelectSeparator = ','
        end
        item
          Name = 'UnitName'
          Value = ''
          Component = UnitGuides
          ComponentItem = 'TextValue'
          DataType = ftString
          ParamType = ptInput
          MultiSelectSeparator = ','
        end
        item
          Name = 'UnitGroupId'
          Value = ''
          Component = UnitGroupGuides
          ComponentItem = 'Key'
          ParamType = ptInput
          MultiSelectSeparator = ','
        end
        item
          Name = 'UnitGroupName'
          Value = ''
          Component = UnitGroupGuides
          ComponentItem = 'TextValue'
          DataType = ftString
          ParamType = ptInput
          MultiSelectSeparator = ','
        end
        item
          Name = 'GoodsGroupGPId'
          Value = ''
          Component = GoodsGroupGPGuides
          ComponentItem = 'Key'
          ParamType = ptInput
          MultiSelectSeparator = ','
        end
        item
          Name = 'GoodsGroupGPName'
          Value = ''
          Component = GoodsGroupGPGuides
          ComponentItem = 'TextValue'
          DataType = ftString
          ParamType = ptInput
          MultiSelectSeparator = ','
        end
        item
          Name = 'GoodsGroupId'
          Value = ''
          Component = GoodsGroupGuides
          ComponentItem = 'Key'
          ParamType = ptInput
          MultiSelectSeparator = ','
        end
        item
          Name = 'GoodsGroupName'
          Value = ''
          Component = GoodsGroupGuides
          ComponentItem = 'TextValue'
          DataType = ftString
          ParamType = ptInput
          MultiSelectSeparator = ','
        end>
      isShowModal = True
      RefreshDispatcher = RefreshDispatcher
      OpenBeforeShow = True
    end
  end
  inherited MasterDS: TDataSource
    Left = 72
    Top = 208
  end
  inherited MasterCDS: TClientDataSet
    Left = 40
    Top = 208
  end
  inherited spSelect: TdsdStoredProc
    StoredProcName = 'gpReport_Goods_byMovement'
    Params = <
      item
        Name = 'inStartDate'
        Value = 41640d
        Component = deStart
        DataType = ftDateTime
        ParamType = ptInput
        MultiSelectSeparator = ','
      end
      item
        Name = 'inEndDate'
        Value = 41640d
        Component = deEnd
        DataType = ftDateTime
        ParamType = ptInput
        MultiSelectSeparator = ','
      end
      item
        Name = 'inUnitId'
        Value = ''
        Component = UnitGuides
        ComponentItem = 'Key'
        ParamType = ptInput
        MultiSelectSeparator = ','
      end
      item
        Name = 'inUnitGroupId'
        Value = ''
        Component = UnitGroupGuides
        ComponentItem = 'Key'
        ParamType = ptInput
        MultiSelectSeparator = ','
      end
      item
        Name = 'inGoodsGroupGPId'
        Value = ''
        Component = GoodsGroupGPGuides
        ComponentItem = 'Key'
        ParamType = ptInput
        MultiSelectSeparator = ','
      end
      item
        Name = 'inGoodsGroupId'
        Value = ''
        Component = GoodsGroupGuides
        ComponentItem = 'Key'
        ParamType = ptInput
        MultiSelectSeparator = ','
      end>
    Left = 256
    Top = 280
  end
  inherited BarManager: TdxBarManager
    Left = 160
    Top = 240
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
          ItemName = 'bbExecuteDialog'
        end
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
          ItemName = 'bbGridToExcel'
        end
        item
          Visible = True
          ItemName = 'dxBarStatic'
        end>
    end
    object bbExecuteDialog: TdxBarButton
      Action = ExecuteDialog
      Category = 0
    end
  end
  inherited DBViewAddOn: TdsdDBViewAddOn
    Left = 320
    Top = 232
  end
  inherited PeriodChoice: TPeriodChoice
    Left = 104
    Top = 160
  end
  inherited RefreshDispatcher: TRefreshDispatcher
    ComponentList = <
      item
        Component = PeriodChoice
      end
      item
        Component = UnitGuides
      end
      item
      end
      item
        Component = GoodsGroupGuides
      end
      item
      end
      item
      end
      item
      end>
    Left = 208
    Top = 168
  end
  object GoodsGroupGuides: TdsdGuides
    KeyField = 'Id'
    LookupControl = edGoodsGroup
    FormNameParam.Value = 'TGoodsGroup_ObjectForm'
    FormNameParam.DataType = ftString
    FormNameParam.MultiSelectSeparator = ','
    FormName = 'TGoodsGroup_ObjectForm'
    PositionDataSet = 'ClientDataSet'
    Params = <
      item
        Name = 'Key'
        Value = ''
        Component = GoodsGroupGuides
        ComponentItem = 'Key'
        DataType = ftString
        ParamType = ptInput
        MultiSelectSeparator = ','
      end
      item
        Name = 'TextValue'
        Value = ''
        Component = GoodsGroupGuides
        ComponentItem = 'TextValue'
        DataType = ftString
        ParamType = ptInput
        MultiSelectSeparator = ','
      end>
    Left = 656
    Top = 16
  end
  object FormParams: TdsdFormParams
    Params = <>
    Left = 328
    Top = 170
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
    Left = 360
  end
  object GoodsGroupGPGuides: TdsdGuides
    KeyField = 'Id'
    LookupControl = edGoodsGroupGP
    FormNameParam.Value = 'TGoodsGroupForm'
    FormNameParam.DataType = ftString
    FormNameParam.MultiSelectSeparator = ','
    FormName = 'TGoodsGroupForm'
    PositionDataSet = 'ClientDataSet'
    Params = <
      item
        Name = 'Key'
        Value = ''
        Component = GoodsGroupGPGuides
        ComponentItem = 'Key'
        DataType = ftString
        ParamType = ptInput
        MultiSelectSeparator = ','
      end
      item
        Name = 'TextValue'
        Value = ''
        Component = GoodsGroupGPGuides
        ComponentItem = 'TextValue'
        DataType = ftString
        ParamType = ptInput
        MultiSelectSeparator = ','
      end>
    Left = 721
    Top = 3
  end
  object UnitGroupGuides: TdsdGuides
    KeyField = 'Id'
    LookupControl = edUnitGroup
    FormNameParam.Value = 'TUnitTreeForm'
    FormNameParam.DataType = ftString
    FormNameParam.MultiSelectSeparator = ','
    FormName = 'TUnitTreeForm'
    PositionDataSet = 'ClientDataSet'
    ParentDataSet = 'TreeDataSet'
    Params = <
      item
        Name = 'Key'
        Value = ''
        Component = UnitGroupGuides
        ComponentItem = 'Key'
        DataType = ftString
        ParamType = ptInput
        MultiSelectSeparator = ','
      end
      item
        Name = 'TextValue'
        Value = ''
        Component = UnitGroupGuides
        ComponentItem = 'TextValue'
        DataType = ftString
        ParamType = ptInput
        MultiSelectSeparator = ','
      end>
    Left = 400
    Top = 16
  end
end
