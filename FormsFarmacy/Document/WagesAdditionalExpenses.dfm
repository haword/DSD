inherited WagesAdditionalExpensesForm: TWagesAdditionalExpensesForm
  Caption = #1044#1086#1087#1086#1083#1085#1080#1090#1077#1083#1100#1085#1099#1077' '#1088#1072#1089#1093#1086#1076#1099
  ClientHeight = 540
  ClientWidth = 877
  AddOnFormData.AddOnFormRefresh.ParentList = 'WagesAdditionalExpenses'
  ExplicitWidth = 893
  ExplicitHeight = 579
  PixelsPerInch = 96
  TextHeight = 13
  inherited PageControl: TcxPageControl
    Top = 77
    Width = 877
    Height = 463
    ExplicitTop = 77
    ExplicitWidth = 877
    ExplicitHeight = 463
    ClientRectBottom = 463
    ClientRectRight = 877
    inherited tsMain: TcxTabSheet
      ExplicitWidth = 877
      ExplicitHeight = 439
      inherited cxGrid: TcxGrid
        Width = 877
        Height = 439
        ExplicitWidth = 877
        ExplicitHeight = 439
        inherited cxGridDBTableView: TcxGridDBTableView
          DataController.Summary.FooterSummaryItems = <
            item
              Format = ',0.00;-,0.00; ;'
              Kind = skSum
              Column = SummaCleaning
            end
            item
              Format = ',0.00;-,0.00; ;'
              Kind = skSum
              Column = SummaSP
            end
            item
              Format = ',0.00;-,0.00; ;'
              Kind = skSum
              Column = SummaOther
            end
            item
              Format = ',0.00;-,0.00; ;'
              Kind = skSum
              Column = SummaTotal
            end>
          OptionsBehavior.IncSearch = True
          Styles.Content = nil
          Styles.Inactive = nil
          Styles.Selection = nil
          Styles.Footer = nil
          Styles.Header = nil
          object UnitName: TcxGridDBColumn [0]
            Caption = #1055#1086#1076#1088#1072#1079#1076#1077#1083#1077#1085#1080#1077
            DataBinding.FieldName = 'UnitName'
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Options.Editing = False
            Width = 256
          end
          object SummaCleaning: TcxGridDBColumn [1]
            Caption = #1059#1073#1086#1088#1082#1072
            DataBinding.FieldName = 'SummaCleaning'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = ',0.00;-,0.00; ;'
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Width = 76
          end
          object SummaSP: TcxGridDBColumn [2]
            Caption = #1057#1055
            DataBinding.FieldName = 'SummaSP'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = ',0.00;-,0.00; ;'
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Width = 76
          end
          object SummaOther: TcxGridDBColumn [3]
            Caption = #1055#1088#1086#1095#1077#1077
            DataBinding.FieldName = 'SummaOther'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = ',0.00;-,0.00; ;'
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Width = 72
          end
          object SummaTotal: TcxGridDBColumn [4]
            Caption = #1048#1090#1086#1075#1086
            DataBinding.FieldName = 'SummaTotal'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = ',0.00;-,0.00; ;'
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Options.Editing = False
            Width = 73
          end
          object isIssuedBy: TcxGridDBColumn [5]
            Caption = #1042#1099#1076#1072#1085#1086
            DataBinding.FieldName = 'isIssuedBy'
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Width = 62
          end
          object Comment: TcxGridDBColumn [6]
            Caption = #1055#1088#1080#1084#1077#1095#1072#1085#1080#1077
            DataBinding.FieldName = 'Comment'
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Width = 227
          end
          inherited colIsErased: TcxGridDBColumn
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
          end
        end
      end
    end
  end
  inherited DataPanel: TPanel
    Width = 877
    Height = 51
    TabOrder = 3
    ExplicitWidth = 877
    ExplicitHeight = 51
    inherited edInvNumber: TcxTextEdit
      Top = 22
      ExplicitTop = 22
    end
    inherited cxLabel1: TcxLabel
      Top = 4
      ExplicitTop = 4
    end
    inherited edOperDate: TcxDateEdit
      Top = 22
      Properties.DisplayFormat = 'mmmm yyyy'
      Properties.ReadOnly = True
      ExplicitTop = 22
    end
    inherited cxLabel2: TcxLabel
      Top = 4
      ExplicitTop = 4
    end
    inherited cxLabel15: TcxLabel
      Top = 4
      ExplicitTop = 4
    end
    inherited ceStatus: TcxButtonEdit
      Left = 12
      Top = 22
      ExplicitLeft = 12
      ExplicitTop = 22
      ExplicitHeight = 22
    end
  end
  inherited ActionList: TActionList
    inherited actRefresh: TdsdDataSetRefresh
      StoredProcList = <
        item
          StoredProc = spGet
        end
        item
          StoredProc = spSelect
        end
        item
        end>
    end
    inherited actShowAll: TBooleanStoredProcAction
      StoredProcList = <
        item
          StoredProc = spSelect
        end
        item
        end>
    end
    inherited actPrint: TdsdPrintAction
      StoredProcList = <
        item
        end>
      DataSets = <
        item
          UserName = 'frxDBDHeader'
        end
        item
          UserName = 'frxDBDMaster'
        end>
      ReportName = #1050#1086#1084#1084#1077#1088#1095#1077#1089#1082#1086#1077' '#1087#1088#1077#1076#1083#1086#1078#1077#1085#1080#1077
      ReportNameParam.Value = #1050#1086#1084#1084#1077#1088#1095#1077#1089#1082#1086#1077' '#1087#1088#1077#1076#1083#1086#1078#1077#1085#1080#1077
    end
    inherited actUnCompleteMovement: TChangeGuidesStatus
      Enabled = False
    end
    inherited actCompleteMovement: TChangeGuidesStatus
      Enabled = False
    end
    inherited actDeleteMovement: TChangeGuidesStatus
      Enabled = False
    end
    inherited MovementItemProtocolOpenForm: TdsdOpenForm
      GuiParams = <
        item
          Name = 'Id'
          Value = Null
          Component = MasterCDS
          ComponentItem = 'Id'
          ParamType = ptInput
          MultiSelectSeparator = ','
        end>
    end
    inherited actAddMask: TdsdExecStoredProc
      StoredProc = nil
      StoredProcList = <
        item
        end
        item
          StoredProc = spInsertMaskMIMaster
        end
        item
          StoredProc = spSelect
        end>
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100' '#1089#1086#1090#1088#1091#1076#1085#1080#1082#1072
      Hint = #1044#1086#1073#1072#1074#1080#1090#1100' '#1089#1086#1090#1088#1091#1076#1085#1080#1082#1072
    end
  end
  inherited MasterDS: TDataSource
    Top = 224
  end
  inherited MasterCDS: TClientDataSet
    Top = 224
  end
  inherited spSelect: TdsdStoredProc
    StoredProcName = 'gpSelect_MovementItem_WagesAdditionalExpenses'
    Left = 64
    Top = 224
  end
  inherited BarManager: TdxBarManager
    Left = 96
    Top = 223
    DockControlHeights = (
      0
      0
      26
      0)
    inherited Bar: TdxBar
      ItemLinks = <
        item
          Visible = True
          ItemName = 'bbShowErased'
        end
        item
          Visible = True
          ItemName = 'bbShowAll'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'dxBarStatic'
        end
        item
          Visible = True
          ItemName = 'dxBarStatic'
        end
        item
          Visible = True
          ItemName = 'dxBarStatic'
        end
        item
          Visible = True
          ItemName = 'bbErased'
        end
        item
          Visible = True
          ItemName = 'bbUnErased'
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
          ItemName = 'dxBarStatic'
        end
        item
          Visible = True
          ItemName = 'bbMovementItemProtocol'
        end
        item
          Visible = True
          ItemName = 'dxBarStatic'
        end
        item
          Visible = True
          ItemName = 'dxBarStatic'
        end
        item
          Visible = True
          ItemName = 'dxBarStatic'
        end
        item
          Visible = True
          ItemName = 'dxBarStatic'
        end
        item
          Visible = True
          ItemName = 'bbGridToExcel'
        end>
    end
    inherited bbAddMask: TdxBarButton
      Action = nil
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100' '#1089#1086#1090#1088#1091#1076#1085#1080#1082#1072
      Hint = #1044#1086#1073#1072#1074#1080#1090#1100' '#1089#1086#1090#1088#1091#1076#1085#1080#1082#1072
    end
    object bbPrintCheck: TdxBarButton
      Caption = #1055#1077#1095#1072#1090#1100' '#1095#1077#1082#1072
      Category = 0
      Hint = #1055#1077#1095#1072#1090#1100' '#1095#1077#1082#1072
      Visible = ivAlways
      ImageIndex = 15
    end
    object bbGet_SP_Prior: TdxBarButton
      Caption = #1040#1042#1058#1054#1047#1040#1055#1054#1051#1053#1048#1058#1068
      Category = 0
      Visible = ivAlways
      ImageIndex = 74
    end
    object dxBarButton1: TdxBarButton
      Caption = #1055#1077#1095#1072#1090#1100' '#1089#1095#1077#1090#1072
      Category = 0
      Hint = #1055#1077#1095#1072#1090#1100' '#1089#1095#1077#1090#1072
      Visible = ivAlways
      ImageIndex = 3
      ShortCut = 49232
    end
    object dxBarButton2: TdxBarButton
      Caption = #1042#1089#1090#1072#1074#1082#1072' '#1074' '#1079#1072#1082#1072#1079
      Category = 0
      Hint = #1042#1089#1090#1072#1074#1082#1072' '#1074' '#1079#1072#1082#1072#1079
      Visible = ivAlways
      ImageIndex = 0
    end
    object dxBarButton3: TdxBarButton
      Caption = #1057#1086#1079#1076#1072#1090#1100' '#1087#1088#1086#1076#1072#1078#1091
      Category = 0
      Hint = #1057#1086#1079#1076#1072#1090#1100' '#1087#1088#1086#1076#1072#1078#1091
      Visible = ivAlways
      ImageIndex = 43
    end
    object dxBarButton4: TdxBarButton
      Caption = #1047#1072#1075#1088#1091#1079#1082#1072' '#1075#1088#1072#1092#1080#1082#1086#1074' '#1089' '#1087#1088#1077#1076#1099#1076#1091#1097#1077#1075#1086' '#1084#1077#1089#1103#1094#1072
      Category = 0
      Hint = #1047#1072#1075#1088#1091#1079#1082#1072' '#1075#1088#1072#1092#1080#1082#1086#1074' '#1089' '#1087#1088#1077#1076#1099#1076#1091#1097#1077#1075#1086' '#1084#1077#1089#1103#1094#1072
      Visible = ivAlways
      ImageIndex = 50
    end
    object dxBarButton5: TdxBarButton
      Caption = #1048#1079#1084#1077#1085#1080#1090#1100' '#1086#1089#1085#1086#1074#1085#1086#1077' '#1087#1086#1076#1088#1072#1079#1076#1077#1083#1077#1085#1080#1077
      Category = 0
      Hint = #1048#1079#1084#1077#1085#1080#1090#1100' '#1086#1089#1085#1086#1074#1085#1086#1077' '#1087#1086#1076#1088#1072#1079#1076#1077#1083#1077#1085#1080#1077
      Visible = ivAlways
      ImageIndex = 66
    end
    object dxBarButton6: TdxBarButton
      Caption = #1048#1079#1084#1077#1085#1080#1090#1100' '#1087#1086#1076#1088#1072#1079#1076#1077#1083#1077#1085#1080#1077' '#1076#1083#1103' '#1087#1086#1076#1084#1077#1085#1099
      Category = 0
      Hint = #1048#1079#1084#1077#1085#1080#1090#1100' '#1087#1086#1076#1088#1072#1079#1076#1077#1083#1077#1085#1080#1077' '#1076#1083#1103' '#1087#1086#1076#1084#1077#1085#1099
      Visible = ivAlways
      ImageIndex = 35
    end
    object dxBarButton7: TdxBarButton
      Caption = #1055#1077#1095#1072#1090#1100' '#1088#1072#1089#1095#1077#1090#1072' '#1079'.'#1087'. '#1087#1086' '#1089#1086#1090#1088#1091#1076#1085#1080#1082#1091
      Category = 0
      Hint = #1055#1077#1095#1072#1090#1100' '#1088#1072#1089#1095#1077#1090#1072' '#1079'.'#1087'. '#1087#1086' '#1089#1086#1090#1088#1091#1076#1085#1080#1082#1091
      Visible = ivAlways
      ImageIndex = 3
    end
    object dxBarButton8: TdxBarButton
      Caption = #1056#1072#1089#1095#1080#1090#1072#1090#1100' '#1079#1072#1088#1072#1073#1086#1090#1085#1091#1102' '#1087#1083#1072#1090#1091' '#1087#1086' '#1074#1089#1077#1084' '#1089#1086#1090#1088#1091#1076#1085#1080#1082#1072#1084
      Category = 0
      Hint = #1056#1072#1089#1095#1080#1090#1072#1090#1100' '#1079#1072#1088#1072#1073#1086#1090#1085#1091#1102' '#1087#1083#1072#1090#1091' '#1087#1086' '#1074#1089#1077#1084' '#1089#1086#1090#1088#1091#1076#1085#1080#1082#1072#1084
      Visible = ivAlways
      ImageIndex = 38
    end
    object dxBarButton9: TdxBarButton
      Caption = #1055#1077#1095#1072#1090#1100' '#1088#1072#1089#1095#1077#1090#1072' '#1079'.'#1087'. '#1087#1086' '#1074#1089#1077#1084' '#1089#1086#1090#1088#1091#1076#1085#1080#1082#1072#1084
      Category = 0
      Hint = #1055#1077#1095#1072#1090#1100' '#1088#1072#1089#1095#1077#1090#1072' '#1079'.'#1087'. '#1087#1086' '#1074#1089#1077#1084' '#1089#1086#1090#1088#1091#1076#1085#1080#1082#1072#1084
      Visible = ivAlways
      ImageIndex = 16
    end
    object dxBarButton10: TdxBarButton
      Caption = #1048#1079#1084#1077#1085#1077#1085#1080#1077' '#1087#1088#1080#1079#1085#1072#1082#1072' '#1074#1099#1076#1072#1085#1086
      Category = 0
      Hint = #1048#1079#1084#1077#1085#1077#1085#1080#1077' '#1087#1088#1080#1079#1085#1072#1082#1072' '#1074#1099#1076#1072#1085#1086
      Visible = ivAlways
      ImageIndex = 66
    end
  end
  inherited DBViewAddOn: TdsdDBViewAddOn
    SummaryItemList = <
      item
        Param.Value = Null
        Param.Component = FormParams
        Param.ComponentItem = 'TotalSumm'
        Param.DataType = ftString
        Param.MultiSelectSeparator = ','
        DataSummaryItemIndex = 0
      end>
    SearchAsFilter = False
    Left = 334
    Top = 241
  end
  inherited FormParams: TdsdFormParams
    Params = <
      item
        Name = 'Id'
        Value = Null
        ParamType = ptInputOutput
        MultiSelectSeparator = ','
      end
      item
        Name = 'Key'
        Value = Null
        DataType = ftString
        ParamType = ptInput
        MultiSelectSeparator = ','
      end
      item
        Name = 'ShowAll'
        Value = False
        Component = actShowAll
        DataType = ftBoolean
        ParamType = ptInputOutput
        MultiSelectSeparator = ','
      end
      item
        Name = 'TotalSumm'
        Value = Null
        DataType = ftFloat
        MultiSelectSeparator = ','
      end
      item
        Name = 'UserID'
        Value = Null
        MultiSelectSeparator = ','
      end
      item
        Name = 'UnitID'
        Value = Null
        MultiSelectSeparator = ','
      end
      item
        Name = 'PersonID'
        Value = Null
        MultiSelectSeparator = ','
      end>
    Left = 40
    Top = 312
  end
  inherited StatusGuides: TdsdGuides
    Top = 232
  end
  inherited spChangeStatus: TdsdStoredProc
    StoredProcName = 'gpUpdate_Status_WagesAdditionalExpenses'
    NeedResetData = True
    ParamKeyField = 'inMovementId'
    Top = 232
  end
  inherited spGet: TdsdStoredProc
    StoredProcName = 'gpGet_Movement_Wages'
    Params = <
      item
        Name = 'inMovementId'
        Value = Null
        Component = FormParams
        ComponentItem = 'Id'
        ParamType = ptInput
        MultiSelectSeparator = ','
      end
      item
        Name = 'inOperDate'
        Value = 0d
        Component = FormParams
        ComponentItem = 'inOperDate'
        DataType = ftDateTime
        ParamType = ptInput
        MultiSelectSeparator = ','
      end
      item
        Name = 'InvNumber'
        Value = ''
        Component = edInvNumber
        MultiSelectSeparator = ','
      end
      item
        Name = 'OperDate'
        Value = 0d
        Component = edOperDate
        MultiSelectSeparator = ','
      end
      item
        Name = 'StatusCode'
        Value = ''
        Component = StatusGuides
        ComponentItem = 'Key'
        MultiSelectSeparator = ','
      end
      item
        Name = 'StatusName'
        Value = ''
        Component = StatusGuides
        ComponentItem = 'TextValue'
        DataType = ftString
        MultiSelectSeparator = ','
      end
      item
        Name = 'TotalSumm'
        Value = Null
        DataType = ftString
        MultiSelectSeparator = ','
      end
      item
        Name = 'UnitId'
        Value = Null
        MultiSelectSeparator = ','
      end
      item
        Name = 'UnitName'
        Value = Null
        DataType = ftString
        MultiSelectSeparator = ','
      end
      item
        Name = 'ClientsByBankId'
        Value = Null
        MultiSelectSeparator = ','
      end
      item
        Name = 'ClientsByBankName'
        Value = Null
        DataType = ftString
        MultiSelectSeparator = ','
      end
      item
        Name = 'Comment'
        Value = Null
        DataType = ftString
        MultiSelectSeparator = ','
      end
      item
        Name = 'AmountAccount'
        Value = Null
        DataType = ftFloat
        MultiSelectSeparator = ','
      end
      item
        Name = 'AccountNumber'
        Value = Null
        DataType = ftString
        MultiSelectSeparator = ','
      end
      item
        Name = 'AmountPayment'
        Value = Null
        DataType = ftFloat
        MultiSelectSeparator = ','
      end
      item
        Name = 'DatePayment'
        Value = Null
        DataType = ftFloat
        MultiSelectSeparator = ','
      end>
    Left = 176
    Top = 272
  end
  inherited spInsertUpdateMovement: TdsdStoredProc
    StoredProcName = 'gpInsertUpdate_Movement_WagesAdditionalExpenses'
    Params = <
      item
        Name = 'ioId'
        Value = Null
        Component = FormParams
        ComponentItem = 'Id'
        ParamType = ptInputOutput
        MultiSelectSeparator = ','
      end
      item
        Name = 'inInvNumber'
        Value = ''
        Component = edInvNumber
        DataType = ftString
        ParamType = ptInput
        MultiSelectSeparator = ','
      end
      item
        Name = 'inOperDate'
        Value = 42132d
        Component = edOperDate
        DataType = ftDateTime
        ParamType = ptInputOutput
        MultiSelectSeparator = ','
      end>
    NeedResetData = True
    ParamKeyField = 'ioId'
    Left = 282
    Top = 272
  end
  inherited GuidesFiller: TGuidesFiller
    Left = 264
    Top = 232
  end
  inherited HeaderSaver: THeaderSaver
    ControlList = <
      item
        Control = edOperDate
      end
      item
      end
      item
      end
      item
      end
      item
      end
      item
      end
      item
      end
      item
      end>
    Left = 208
    Top = 233
  end
  inherited RefreshAddOn: TRefreshAddOn
    Left = 72
    Top = 312
  end
  inherited spErasedMIMaster: TdsdStoredProc
    Left = 678
    Top = 248
  end
  inherited spUnErasedMIMaster: TdsdStoredProc
    Left = 550
    Top = 256
  end
  inherited spInsertUpdateMIMaster: TdsdStoredProc
    StoredProcName = 'gpInsertUpdate_MovementItem_WagesAdditionalExpenses'
    Params = <
      item
        Name = 'ioId'
        Value = Null
        Component = MasterCDS
        ComponentItem = 'Id'
        ParamType = ptInputOutput
        MultiSelectSeparator = ','
      end
      item
        Name = 'inMovementId'
        Value = Null
        Component = FormParams
        ComponentItem = 'Id'
        ParamType = ptInput
        MultiSelectSeparator = ','
      end
      item
        Name = 'inUnitID'
        Value = Null
        Component = MasterCDS
        ComponentItem = 'UnitID'
        ParamType = ptInput
        MultiSelectSeparator = ','
      end
      item
        Name = 'inSummaCleaning'
        Value = Null
        Component = MasterCDS
        ComponentItem = 'SummaCleaning'
        DataType = ftFloat
        ParamType = ptInput
        MultiSelectSeparator = ','
      end
      item
        Name = 'inSummaSP'
        Value = Null
        Component = MasterCDS
        ComponentItem = 'SummaSP'
        DataType = ftFloat
        ParamType = ptInput
        MultiSelectSeparator = ','
      end
      item
        Name = 'inSummaOther'
        Value = Null
        Component = MasterCDS
        ComponentItem = 'SummaOther'
        DataType = ftFloat
        ParamType = ptInput
        MultiSelectSeparator = ','
      end
      item
        Name = 'inisIssuedBy'
        Value = Null
        Component = MasterCDS
        ComponentItem = 'isIssuedBy'
        DataType = ftBoolean
        ParamType = ptInput
        MultiSelectSeparator = ','
      end
      item
        Name = 'inComment'
        Value = Null
        Component = MasterCDS
        ComponentItem = 'Comment'
        DataType = ftString
        ParamType = ptInput
        MultiSelectSeparator = ','
      end
      item
        Name = 'outSummaTotal'
        Value = Null
        Component = MasterCDS
        ComponentItem = 'SummaTotal'
        DataType = ftFloat
        MultiSelectSeparator = ','
      end>
    NeedResetData = True
    ParamKeyField = 'inMovementId'
    Left = 408
    Top = 280
  end
  inherited spInsertMaskMIMaster: TdsdStoredProc
    Left = 352
    Top = 352
  end
  inherited spGetTotalSumm: TdsdStoredProc
    StoredProcName = 'gpGet_Movement_Wages_TotalSumm'
    Left = 188
    Top = 364
  end
  object spInsertUser: TdsdStoredProc
    StoredProcName = 'gpInsert_MovementItem_WagesAdditionalExpenses_User'
    DataSets = <>
    OutputType = otResult
    Params = <
      item
        Name = 'inMovementId'
        Value = Null
        Component = FormParams
        ComponentItem = 'Id'
        ParamType = ptInput
        MultiSelectSeparator = ','
      end
      item
        Name = 'inUserID'
        Value = Null
        Component = FormParams
        ComponentItem = 'UserID'
        ParamType = ptInput
        MultiSelectSeparator = ','
      end>
    PackSize = 1
    Left = 488
    Top = 352
  end
  object spCalculationAll: TdsdStoredProc
    StoredProcName = 'gpInsertUpdate_Movement_WagesAdditionalExpenses_CalculationAll'
    DataSets = <>
    OutputType = otResult
    Params = <
      item
        Name = 'inMovementId'
        Value = Null
        Component = FormParams
        ComponentItem = 'Id'
        ParamType = ptInput
        MultiSelectSeparator = ','
      end>
    PackSize = 1
    NeedResetData = True
    Left = 600
    Top = 360
  end
end