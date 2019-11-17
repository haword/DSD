inherited MarginCategory_AllForm: TMarginCategory_AllForm
  Caption = #1050#1072#1090#1077#1075#1086#1088#1080#1103' '#1085#1072#1094#1077#1085#1086#1082
  ClientHeight = 338
  ClientWidth = 1246
  ExplicitWidth = 1262
  ExplicitHeight = 376
  PixelsPerInch = 96
  TextHeight = 13
  inherited PageControl: TcxPageControl
    Width = 1246
    Height = 312
    ExplicitWidth = 1246
    ExplicitHeight = 312
    ClientRectBottom = 312
    ClientRectRight = 1246
    inherited tsMain: TcxTabSheet
      ExplicitWidth = 1246
      ExplicitHeight = 312
      inherited cxGrid: TcxGrid
        Width = 1246
        Height = 312
        ExplicitWidth = 1246
        ExplicitHeight = 312
        inherited cxGridDBTableView: TcxGridDBTableView
          OptionsData.Appending = True
          OptionsData.Inserting = True
          Styles.Content = nil
          Styles.Inactive = nil
          Styles.Selection = nil
          Styles.Footer = nil
          Styles.Header = nil
          object MarginCategoryName: TcxGridDBColumn
            Caption = #1050#1072#1090#1077#1075#1086#1088#1080#1103' '#1085#1072#1094#1077#1085#1082#1080
            DataBinding.FieldName = 'MarginCategoryName'
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Options.Editing = False
            Width = 213
          end
          object JuridicalName: TcxGridDBColumn
            Caption = #1070#1088'. '#1083#1080#1094#1086
            DataBinding.FieldName = 'JuridicalName'
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Options.Editing = False
            Width = 110
          end
          object ProvinceCityName: TcxGridDBColumn
            Caption = #1056#1072#1081#1086#1085
            DataBinding.FieldName = 'ProvinceCityName'
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Options.Editing = False
            Width = 70
          end
          object UnitName: TcxGridDBColumn
            Caption = #1055#1086#1076#1088#1072#1079#1076#1077#1083#1077#1085#1080#1077
            DataBinding.FieldName = 'UnitName'
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Options.Editing = False
            Width = 120
          end
          object Value_1: TcxGridDBColumn
            Caption = '0-15'
            DataBinding.FieldName = 'Value_1'
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Options.Editing = False
            Width = 74
          end
          object Value_2: TcxGridDBColumn
            Caption = '15-50'
            DataBinding.FieldName = 'Value_2'
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Options.Editing = False
            Width = 74
          end
          object Value_3: TcxGridDBColumn
            Caption = '50-100'
            DataBinding.FieldName = 'Value_3'
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Options.Editing = False
            Width = 74
          end
          object Value_4: TcxGridDBColumn
            Caption = '100-200'
            DataBinding.FieldName = 'Value_4'
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Options.Editing = False
            Width = 74
          end
          object Value_5: TcxGridDBColumn
            Caption = '200-300'
            DataBinding.FieldName = 'Value_5'
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Options.Editing = False
            Width = 74
          end
          object Value_6: TcxGridDBColumn
            Caption = '300-1000'
            DataBinding.FieldName = 'Value_6'
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Options.Editing = False
            Width = 74
          end
          object Value_7: TcxGridDBColumn
            Caption = '> 1000'
            DataBinding.FieldName = 'Value_7'
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Options.Editing = False
            Width = 74
          end
          object avgPercent: TcxGridDBColumn
            Caption = #1057#1088'. '#1085#1072#1094'. '#1087#1086' '#1090#1086#1095#1082#1077
            DataBinding.FieldName = 'avgPercent'
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            HeaderHint = #1057#1088#1077#1076#1085#1103#1103' '#1085#1072#1094#1077#1085#1082#1072' '#1087#1086' '#1090#1086#1095#1082#1077
            Options.Editing = False
            Width = 100
          end
        end
      end
    end
  end
  inherited ActionList: TActionList
    object actInsertUpdate: TdsdUpdateDataSet
      Category = 'DSDLib'
      MoveParams = <>
      PostDataSetBeforeExecute = False
      StoredProc = spInsertUpdate
      StoredProcList = <
        item
          StoredProc = spInsertUpdate
        end>
      Caption = 'actInsertUpdate'
      DataSource = MasterDS
    end
    object dsdSetErased: TdsdUpdateErased
      Category = 'DSDLib'
      MoveParams = <>
      StoredProc = spErasedUnErased
      StoredProcList = <
        item
          StoredProc = spErasedUnErased
        end>
      Caption = #1059#1076#1072#1083#1080#1090#1100
      Hint = #1059#1076#1072#1083#1080#1090#1100' '#1076#1072#1085#1085#1099#1077
      ImageIndex = 2
      ShortCut = 46
      ErasedFieldName = 'isErased'
      DataSource = MasterDS
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
      DataSource = MasterDS
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
      ImageIndex = 64
      Value = False
      HintTrue = #1055#1086#1082#1072#1079#1072#1090#1100' '#1085#1077' '#1091#1076#1072#1083#1077#1085#1085#1099#1077
      HintFalse = #1055#1086#1082#1072#1079#1072#1090#1100' '#1074#1077#1089#1100' '#1089#1087#1080#1089#1086#1082
      CaptionTrue = #1055#1086#1082#1072#1079#1072#1090#1100' '#1085#1077' '#1091#1076#1072#1083#1077#1085#1085#1099#1077
      CaptionFalse = #1055#1086#1082#1072#1079#1072#1090#1100' '#1074#1077#1089#1100' '#1089#1087#1080#1089#1086#1082
      ImageIndexTrue = 65
      ImageIndexFalse = 64
    end
    object ProtocolOpenForm7: TdsdOpenForm
      Category = 'DSDLib'
      MoveParams = <>
      Caption = #1055#1088#1086#1089#1084#1086#1090#1088' '#1087#1088#1086#1090#1086#1082#1086#1083#1072' > 1000'
      Hint = #1055#1088#1086#1089#1084#1086#1090#1088' '#1087#1088#1086#1090#1086#1082#1086#1083#1072' > 1000'
      ImageIndex = 34
      FormName = 'TProtocolForm'
      FormNameParam.Value = 'TProtocolForm'
      FormNameParam.DataType = ftString
      FormNameParam.MultiSelectSeparator = ','
      GuiParams = <
        item
          Name = 'Id'
          Value = Null
          Component = MasterCDS
          ComponentItem = 'Id_7'
          ParamType = ptInput
          MultiSelectSeparator = ','
        end
        item
          Name = 'TextValue'
          Value = '> 1000'
          DataType = ftString
          ParamType = ptInput
          MultiSelectSeparator = ','
        end>
      isShowModal = False
    end
    object ProtocolOpenForm6: TdsdOpenForm
      Category = 'DSDLib'
      MoveParams = <>
      Caption = #1055#1088#1086#1089#1084#1086#1090#1088' '#1087#1088#1086#1090#1086#1082#1086#1083#1072' 300-1000'
      Hint = #1055#1088#1086#1089#1084#1086#1090#1088' '#1087#1088#1086#1090#1086#1082#1086#1083#1072' 300-1000'
      ImageIndex = 34
      FormName = 'TProtocolForm'
      FormNameParam.Value = 'TProtocolForm'
      FormNameParam.DataType = ftString
      FormNameParam.MultiSelectSeparator = ','
      GuiParams = <
        item
          Name = 'Id'
          Value = Null
          Component = MasterCDS
          ComponentItem = 'Id_6'
          ParamType = ptInput
          MultiSelectSeparator = ','
        end
        item
          Name = 'TextValue'
          Value = '300-1000'
          DataType = ftString
          ParamType = ptInput
          MultiSelectSeparator = ','
        end>
      isShowModal = False
    end
    object ProtocolOpenForm5: TdsdOpenForm
      Category = 'DSDLib'
      MoveParams = <>
      Caption = #1055#1088#1086#1089#1084#1086#1090#1088' '#1087#1088#1086#1090#1086#1082#1086#1083#1072' 200-300'
      Hint = #1055#1088#1086#1089#1084#1086#1090#1088' '#1087#1088#1086#1090#1086#1082#1086#1083#1072' 200-300'
      ImageIndex = 34
      FormName = 'TProtocolForm'
      FormNameParam.Value = 'TProtocolForm'
      FormNameParam.DataType = ftString
      FormNameParam.MultiSelectSeparator = ','
      GuiParams = <
        item
          Name = 'Id'
          Value = Null
          Component = MasterCDS
          ComponentItem = 'Id_5'
          ParamType = ptInput
          MultiSelectSeparator = ','
        end
        item
          Name = 'TextValue'
          Value = '200-300'
          DataType = ftString
          ParamType = ptInput
          MultiSelectSeparator = ','
        end>
      isShowModal = False
    end
    object ProtocolOpenForm4: TdsdOpenForm
      Category = 'DSDLib'
      MoveParams = <>
      Caption = #1055#1088#1086#1089#1084#1086#1090#1088' '#1087#1088#1086#1090#1086#1082#1086#1083#1072' 100-200'
      Hint = #1055#1088#1086#1089#1084#1086#1090#1088' '#1087#1088#1086#1090#1086#1082#1086#1083#1072' 100-200'
      ImageIndex = 34
      FormName = 'TProtocolForm'
      FormNameParam.Value = 'TProtocolForm'
      FormNameParam.DataType = ftString
      FormNameParam.MultiSelectSeparator = ','
      GuiParams = <
        item
          Name = 'Id'
          Value = Null
          Component = MasterCDS
          ComponentItem = 'Id_4'
          ParamType = ptInput
          MultiSelectSeparator = ','
        end
        item
          Name = 'TextValue'
          Value = '100-200'
          DataType = ftString
          ParamType = ptInput
          MultiSelectSeparator = ','
        end>
      isShowModal = False
    end
    object ProtocolOpenForm3: TdsdOpenForm
      Category = 'DSDLib'
      MoveParams = <>
      Caption = #1055#1088#1086#1089#1084#1086#1090#1088' '#1087#1088#1086#1090#1086#1082#1086#1083#1072' 50-100'
      Hint = #1055#1088#1086#1089#1084#1086#1090#1088' '#1087#1088#1086#1090#1086#1082#1086#1083#1072' 50-100'
      ImageIndex = 34
      FormName = 'TProtocolForm'
      FormNameParam.Value = 'TProtocolForm'
      FormNameParam.DataType = ftString
      FormNameParam.MultiSelectSeparator = ','
      GuiParams = <
        item
          Name = 'Id'
          Value = Null
          Component = MasterCDS
          ComponentItem = 'Id_3'
          ParamType = ptInput
          MultiSelectSeparator = ','
        end
        item
          Name = 'TextValue'
          Value = '50-100'
          DataType = ftString
          ParamType = ptInput
          MultiSelectSeparator = ','
        end>
      isShowModal = False
    end
    object ProtocolOpenForm1: TdsdOpenForm
      Category = 'DSDLib'
      MoveParams = <>
      Caption = #1055#1088#1086#1089#1084#1086#1090#1088' '#1087#1088#1086#1090#1086#1082#1086#1083#1072' 0-15'
      Hint = #1055#1088#1086#1089#1084#1086#1090#1088' '#1087#1088#1086#1090#1086#1082#1086#1083#1072' 0-15'
      ImageIndex = 34
      FormName = 'TProtocolForm'
      FormNameParam.Value = 'TProtocolForm'
      FormNameParam.DataType = ftString
      FormNameParam.MultiSelectSeparator = ','
      GuiParams = <
        item
          Name = 'Id'
          Value = Null
          Component = MasterCDS
          ComponentItem = 'Id_1'
          ParamType = ptInput
          MultiSelectSeparator = ','
        end
        item
          Name = 'TextValue'
          Value = '0-15'
          DataType = ftString
          ParamType = ptInput
          MultiSelectSeparator = ','
        end>
      isShowModal = False
    end
    object ProtocolOpenForm2: TdsdOpenForm
      Category = 'DSDLib'
      MoveParams = <>
      Caption = #1055#1088#1086#1089#1084#1086#1090#1088' '#1087#1088#1086#1090#1086#1082#1086#1083#1072' 15-50'
      Hint = #1055#1088#1086#1089#1084#1086#1090#1088' '#1087#1088#1086#1090#1086#1082#1086#1083#1072' 15-50'
      ImageIndex = 34
      FormName = 'TProtocolForm'
      FormNameParam.Value = 'TProtocolForm'
      FormNameParam.DataType = ftString
      FormNameParam.MultiSelectSeparator = ','
      GuiParams = <
        item
          Name = 'Id'
          Value = Null
          Component = MasterCDS
          ComponentItem = 'Id_2'
          ParamType = ptInput
          MultiSelectSeparator = ','
        end
        item
          Name = 'TextValue'
          Value = '15-50'
          DataType = ftString
          ParamType = ptInput
          MultiSelectSeparator = ','
        end>
      isShowModal = False
    end
    object actUpdateParam: TdsdDataSetRefresh
      Category = 'DSDLib'
      MoveParams = <>
      StoredProc = spInsertUpdate
      StoredProcList = <
        item
          StoredProc = spInsertUpdate
        end>
      Caption = #1048#1079#1084#1077#1085#1080#1090#1100' %% '#1085#1072#1094#1077#1085#1086#1082
      Hint = #1048#1079#1084#1077#1085#1080#1090#1100' %% '#1085#1072#1094#1077#1085#1086#1082
      ImageIndex = 26
      ShortCut = 116
      RefreshOnTabSetChanges = True
    end
    object ExecuteDialog: TExecuteDialog
      Category = 'DSDLib'
      MoveParams = <>
      PostDataSetBeforeExecute = False
      PostDataSetAfterExecute = True
      Caption = #1048#1079#1084#1077#1085#1080#1090#1100' %% '#1085#1072#1094#1077#1085#1086#1082
      Hint = #1048#1079#1084#1077#1085#1080#1090#1100' %% '#1085#1072#1094#1077#1085#1086#1082
      ImageIndex = 26
      FormName = 'TMarginCategoryAllDialogForm'
      FormNameParam.Value = 'TMarginCategoryAllDialogForm'
      FormNameParam.DataType = ftString
      FormNameParam.MultiSelectSeparator = ','
      GuiParams = <
        item
          Name = 'isVal1'
          Value = 42261d
          Component = FormParams
          ComponentItem = 'isVal1'
          DataType = ftBoolean
          MultiSelectSeparator = ','
        end
        item
          Name = 'isVal2'
          Value = ''
          Component = FormParams
          ComponentItem = 'isVal2'
          DataType = ftBoolean
          MultiSelectSeparator = ','
        end
        item
          Name = 'isVal3'
          Value = ''
          Component = FormParams
          ComponentItem = 'isVal3'
          DataType = ftBoolean
          MultiSelectSeparator = ','
        end
        item
          Name = 'isVal4'
          Value = ''
          Component = FormParams
          ComponentItem = 'isVal4'
          DataType = ftBoolean
          MultiSelectSeparator = ','
        end
        item
          Name = 'isVal5'
          Value = ''
          Component = FormParams
          ComponentItem = 'isVal5'
          DataType = ftBoolean
          MultiSelectSeparator = ','
        end
        item
          Name = 'isVal6'
          Value = '0'
          Component = FormParams
          ComponentItem = 'isVal6'
          DataType = ftBoolean
          MultiSelectSeparator = ','
        end
        item
          Name = 'isVal7'
          Value = ''
          Component = FormParams
          ComponentItem = 'isVal7'
          DataType = ftBoolean
          MultiSelectSeparator = ','
        end
        item
          Name = 'Val1'
          Value = 42261d
          Component = FormParams
          ComponentItem = 'Val1'
          DataType = ftFloat
          MultiSelectSeparator = ','
        end
        item
          Name = 'Val2'
          Value = ''
          Component = FormParams
          ComponentItem = 'Val2'
          DataType = ftFloat
          MultiSelectSeparator = ','
        end
        item
          Name = 'Val3'
          Value = '0'
          Component = FormParams
          ComponentItem = 'Val3'
          DataType = ftFloat
          MultiSelectSeparator = ','
        end
        item
          Name = 'Val4'
          Value = ''
          Component = FormParams
          ComponentItem = 'Val4'
          DataType = ftFloat
          MultiSelectSeparator = ','
        end
        item
          Name = 'Val5'
          Value = Null
          Component = FormParams
          ComponentItem = 'Val5'
          DataType = ftFloat
          MultiSelectSeparator = ','
        end
        item
          Name = 'Val6'
          Value = Null
          Component = FormParams
          ComponentItem = 'Val6'
          DataType = ftFloat
          MultiSelectSeparator = ','
        end
        item
          Name = 'Val7'
          Value = Null
          Component = FormParams
          ComponentItem = 'Val7'
          DataType = ftFloat
          MultiSelectSeparator = ','
        end>
      isShowModal = True
      OpenBeforeShow = True
    end
    object macUpdateParam: TMultiAction
      Category = 'DSDLib'
      MoveParams = <>
      ActionList = <
        item
          Action = ExecuteDialog
        end
        item
          Action = actUpdateParam
        end>
      Caption = #1048#1079#1084#1077#1085#1080#1090#1100' %% '#1085#1072#1094#1077#1085#1086#1082
      Hint = #1048#1079#1084#1077#1085#1080#1090#1100' %% '#1085#1072#1094#1077#1085#1086#1082
      ImageIndex = 26
    end
  end
  inherited MasterDS: TDataSource
    Top = 80
  end
  inherited MasterCDS: TClientDataSet
    Top = 80
  end
  inherited spSelect: TdsdStoredProc
    StoredProcName = 'gpSelect_MarginCategory_All'
    OutputType = otMultiDataSet
    Params = <
      item
        Name = 'inShowAll'
        Value = Null
        Component = actShowAll
        DataType = ftBoolean
        ParamType = ptUnknown
        MultiSelectSeparator = ','
      end>
    Top = 80
  end
  inherited BarManager: TdxBarManager
    Left = 112
    Top = 80
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
          ItemName = 'bbChoice'
        end
        item
          Visible = True
          ItemName = 'dxBarStatic'
        end
        item
          Visible = True
          ItemName = 'bbProtocol'
        end
        item
          Visible = True
          ItemName = 'dxBarStatic'
        end
        item
          Visible = True
          ItemName = 'bbProtocolOpenForm2'
        end
        item
          Visible = True
          ItemName = 'dxBarStatic'
        end
        item
          Visible = True
          ItemName = 'bbProtocolOpenForm3'
        end
        item
          Visible = True
          ItemName = 'dxBarStatic'
        end
        item
          Visible = True
          ItemName = 'bbProtocolOpenForm4'
        end
        item
          Visible = True
          ItemName = 'dxBarStatic'
        end
        item
          Visible = True
          ItemName = 'bbProtocolOpenForm5'
        end
        item
          Visible = True
          ItemName = 'dxBarStatic'
        end
        item
          Visible = True
          ItemName = 'bbProtocolOpenForm6'
        end
        item
          Visible = True
          ItemName = 'dxBarStatic'
        end
        item
          Visible = True
          ItemName = 'bbProtocolOpenForm7'
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
    object bbSetErased: TdxBarButton
      Action = dsdSetErased
      Category = 0
    end
    object bbSetUnErased: TdxBarButton
      Action = dsdSetUnErased
      Category = 0
    end
    object bbShowAll: TdxBarButton
      Action = actShowAll
      Category = 0
    end
    object bbProtocol: TdxBarButton
      Action = ProtocolOpenForm1
      Category = 0
    end
    object bbProtocolOpenForm2: TdxBarButton
      Action = ProtocolOpenForm2
      Category = 0
    end
    object bbProtocolOpenForm3: TdxBarButton
      Action = ProtocolOpenForm3
      Category = 0
    end
    object bbProtocolOpenForm4: TdxBarButton
      Action = ProtocolOpenForm4
      Category = 0
    end
    object bbProtocolOpenForm5: TdxBarButton
      Action = ProtocolOpenForm5
      Category = 0
    end
    object bbProtocolOpenForm6: TdxBarButton
      Action = ProtocolOpenForm6
      Category = 0
    end
    object bbProtocolOpenForm7: TdxBarButton
      Action = ProtocolOpenForm7
      Category = 0
    end
  end
  object spInsertUpdate: TdsdStoredProc
    StoredProcName = 'gpInsertUpdate_Object_MarginCategoryItem_All'
    DataSets = <>
    OutputType = otResult
    Params = <
      item
        Name = 'inMarginCategoryId'
        Value = Null
        Component = MasterCDS
        ComponentItem = 'MarginCategoryId'
        MultiSelectSeparator = ','
      end
      item
        Name = 'inId_1'
        Value = Null
        Component = MasterCDS
        ComponentItem = 'Id_1'
        ParamType = ptInput
        MultiSelectSeparator = ','
      end
      item
        Name = 'inId_2'
        Value = Null
        Component = MasterCDS
        ComponentItem = 'Id_2'
        ParamType = ptInput
        MultiSelectSeparator = ','
      end
      item
        Name = 'inId_3'
        Value = Null
        Component = MasterCDS
        ComponentItem = 'Id_3'
        ParamType = ptInput
        MultiSelectSeparator = ','
      end
      item
        Name = 'inId_4'
        Value = Null
        Component = MasterCDS
        ComponentItem = 'Id_4'
        ParamType = ptInput
        MultiSelectSeparator = ','
      end
      item
        Name = 'inId_5'
        Value = Null
        Component = MasterCDS
        ComponentItem = 'Id_5'
        ParamType = ptInput
        MultiSelectSeparator = ','
      end
      item
        Name = 'inId_6'
        Value = Null
        Component = MasterCDS
        ComponentItem = 'Id_6'
        ParamType = ptInput
        MultiSelectSeparator = ','
      end
      item
        Name = 'inId_7'
        Value = Null
        Component = MasterCDS
        ComponentItem = 'Id_7'
        ParamType = ptInput
        MultiSelectSeparator = ','
      end
      item
        Name = 'inminPrice_1'
        Value = Null
        Component = MasterCDS
        ComponentItem = 'minPrice_1'
        DataType = ftFloat
        ParamType = ptInput
        MultiSelectSeparator = ','
      end
      item
        Name = 'inminPrice_2'
        Value = Null
        Component = MasterCDS
        ComponentItem = 'minPrice_2'
        DataType = ftFloat
        ParamType = ptInput
        MultiSelectSeparator = ','
      end
      item
        Name = 'inminPrice_3'
        Value = Null
        Component = MasterCDS
        ComponentItem = 'minPrice_3'
        DataType = ftFloat
        ParamType = ptInput
        MultiSelectSeparator = ','
      end
      item
        Name = 'inminPrice_4'
        Value = Null
        Component = MasterCDS
        ComponentItem = 'minPrice_4'
        DataType = ftFloat
        ParamType = ptInput
        MultiSelectSeparator = ','
      end
      item
        Name = 'inminPrice_5'
        Value = Null
        Component = MasterCDS
        ComponentItem = 'minPrice_5'
        DataType = ftFloat
        ParamType = ptInput
        MultiSelectSeparator = ','
      end
      item
        Name = 'inminPrice_6'
        Value = Null
        Component = MasterCDS
        ComponentItem = 'minPrice_6'
        DataType = ftFloat
        ParamType = ptInput
        MultiSelectSeparator = ','
      end
      item
        Name = 'inminPrice_7'
        Value = Null
        Component = MasterCDS
        ComponentItem = 'minPrice_7'
        DataType = ftFloat
        ParamType = ptInput
        MultiSelectSeparator = ','
      end
      item
        Name = 'inValue_1'
        Value = Null
        Component = MasterCDS
        ComponentItem = 'Value_1'
        DataType = ftString
        ParamType = ptInput
        MultiSelectSeparator = ','
      end
      item
        Name = 'inValue_2'
        Value = Null
        Component = MasterCDS
        ComponentItem = 'Value_2'
        DataType = ftString
        ParamType = ptInput
        MultiSelectSeparator = ','
      end
      item
        Name = 'inValue_3'
        Value = Null
        Component = MasterCDS
        ComponentItem = 'Value_3'
        DataType = ftString
        ParamType = ptInput
        MultiSelectSeparator = ','
      end
      item
        Name = 'inValue_4'
        Value = Null
        Component = MasterCDS
        ComponentItem = 'Value_4'
        DataType = ftString
        ParamType = ptInput
        MultiSelectSeparator = ','
      end
      item
        Name = 'inValue_5'
        Value = Null
        Component = MasterCDS
        ComponentItem = 'Value_5'
        DataType = ftString
        ParamType = ptInput
        MultiSelectSeparator = ','
      end
      item
        Name = 'inValue_6'
        Value = Null
        Component = MasterCDS
        ComponentItem = 'Value_6'
        DataType = ftString
        ParamType = ptInput
        MultiSelectSeparator = ','
      end
      item
        Name = 'inValue_7'
        Value = Null
        Component = MasterCDS
        ComponentItem = 'Value_7'
        DataType = ftString
        ParamType = ptInput
        MultiSelectSeparator = ','
      end
      item
        Name = 'inVal1'
        Value = Null
        Component = FormParams
        ComponentItem = 'Val1'
        DataType = ftFloat
        ParamType = ptInput
        MultiSelectSeparator = ','
      end
      item
        Name = 'inVal2'
        Value = Null
        Component = FormParams
        ComponentItem = 'Val2'
        DataType = ftFloat
        ParamType = ptInput
        MultiSelectSeparator = ','
      end
      item
        Name = 'inVal3'
        Value = Null
        Component = FormParams
        ComponentItem = 'Val3'
        DataType = ftFloat
        ParamType = ptInput
        MultiSelectSeparator = ','
      end
      item
        Name = 'inVal4'
        Value = Null
        Component = FormParams
        ComponentItem = 'Val4'
        DataType = ftFloat
        ParamType = ptInput
        MultiSelectSeparator = ','
      end
      item
        Name = 'inVal5'
        Value = Null
        Component = FormParams
        ComponentItem = 'Val5'
        DataType = ftFloat
        ParamType = ptInput
        MultiSelectSeparator = ','
      end
      item
        Name = 'inVal6'
        Value = Null
        Component = FormParams
        ComponentItem = 'Val6'
        DataType = ftFloat
        ParamType = ptInput
        MultiSelectSeparator = ','
      end
      item
        Name = 'inVal7'
        Value = Null
        Component = FormParams
        ComponentItem = 'Val7'
        DataType = ftFloat
        ParamType = ptInput
        MultiSelectSeparator = ','
      end
      item
        Name = 'inisVal1'
        Value = Null
        Component = FormParams
        ComponentItem = 'isVal1'
        DataType = ftBoolean
        ParamType = ptInput
        MultiSelectSeparator = ','
      end
      item
        Name = 'inisVal2'
        Value = Null
        Component = FormParams
        ComponentItem = 'isVal2'
        DataType = ftBoolean
        ParamType = ptInput
        MultiSelectSeparator = ','
      end
      item
        Name = 'inisVal3'
        Value = Null
        Component = FormParams
        ComponentItem = 'isVal3'
        DataType = ftBoolean
        ParamType = ptInput
        MultiSelectSeparator = ','
      end
      item
        Name = 'inisVal4'
        Value = Null
        Component = FormParams
        ComponentItem = 'isVal4'
        DataType = ftBoolean
        ParamType = ptInput
        MultiSelectSeparator = ','
      end
      item
        Name = 'inisVal5'
        Value = Null
        Component = FormParams
        ComponentItem = 'isVal5'
        DataType = ftBoolean
        ParamType = ptInput
        MultiSelectSeparator = ','
      end
      item
        Name = 'inisVal6'
        Value = Null
        Component = FormParams
        ComponentItem = 'isVal6'
        DataType = ftBoolean
        ParamType = ptInput
        MultiSelectSeparator = ','
      end
      item
        Name = 'inisVal7'
        Value = Null
        Component = FormParams
        ComponentItem = 'isVal7'
        DataType = ftBoolean
        ParamType = ptInput
        MultiSelectSeparator = ','
      end>
    PackSize = 1
    Left = 728
    Top = 240
  end
  object spErasedUnErased: TdsdStoredProc
    StoredProcName = 'gpUpdateObjectIsErased'
    DataSets = <>
    OutputType = otResult
    Params = <
      item
        Name = 'inObjectId'
        Value = Null
        Component = MasterCDS
        ComponentItem = 'Id'
        ParamType = ptInput
        MultiSelectSeparator = ','
      end>
    PackSize = 1
    Left = 456
    Top = 144
  end
  object FormParams: TdsdFormParams
    Params = <>
    Left = 344
    Top = 88
  end
end
