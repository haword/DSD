object Report_MotionOLAPDialogForm: TReport_MotionOLAPDialogForm
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = #1055#1072#1088#1072#1084#1077#1090#1088#1099' '#1086#1090#1095#1077#1090#1072' <'#1055#1086' '#1076#1074#1080#1078#1077#1085#1080#1102' ('#1054#1051#1040#1055')>'
  ClientHeight = 409
  ClientWidth = 400
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  AddOnFormData.isSingle = False
  AddOnFormData.Params = FormParams
  PixelsPerInch = 96
  TextHeight = 13
  object cxButton1: TcxButton
    Left = 110
    Top = 365
    Width = 75
    Height = 24
    Caption = 'Ok'
    Default = True
    ModalResult = 1
    TabOrder = 0
  end
  object cxButton2: TcxButton
    Left = 239
    Top = 365
    Width = 75
    Height = 24
    Caption = #1054#1090#1084#1077#1085#1072
    ModalResult = 2
    TabOrder = 1
  end
  object deEnd: TcxDateEdit
    Left = 125
    Top = 30
    EditValue = 43101d
    Properties.ShowTime = False
    TabOrder = 2
    Width = 85
  end
  object deStart: TcxDateEdit
    Left = 25
    Top = 30
    EditValue = 43101d
    Properties.ShowTime = False
    TabOrder = 3
    Width = 85
  end
  object cxLabel6: TcxLabel
    Left = 25
    Top = 10
    Caption = #1055#1077#1088#1080#1086#1076' '#1089' ...'
  end
  object cxLabel7: TcxLabel
    Left = 125
    Top = 10
    Caption = #1055#1077#1088#1080#1086#1076' '#1087#1086' ...'
  end
  object cxLabel4: TcxLabel
    Left = 25
    Top = 131
    Caption = #1055#1086#1089#1090#1072#1074#1097#1080#1082':'
  end
  object edPartner: TcxButtonEdit
    Left = 25
    Top = 151
    Properties.Buttons = <
      item
        Default = True
        Kind = bkEllipsis
      end>
    Properties.Nullstring = '<'#1042#1099#1073#1077#1088#1080#1090#1077' '#1087#1086#1076#1088#1072#1079#1076#1077#1083#1077#1085#1080#1077'>'
    Properties.ReadOnly = True
    Properties.UseNullString = True
    TabOrder = 7
    Text = '<'#1042#1099#1073#1077#1088#1080#1090#1077' '#1087#1086#1089#1090#1072#1074#1097#1080#1082#1072'>'
    Width = 350
  end
  object cxLabel1: TcxLabel
    Left = 25
    Top = 178
    Caption = #1058#1086#1088#1075#1086#1074#1072#1103' '#1084#1072#1088#1082#1072':'
  end
  object edBrand: TcxButtonEdit
    Left = 25
    Top = 196
    Properties.Buttons = <
      item
        Default = True
        Kind = bkEllipsis
      end>
    Properties.ReadOnly = True
    TabOrder = 9
    Text = '<'#1042#1099#1073#1077#1088#1080#1090#1077' '#1090#1086#1088#1075#1086#1074#1091#1102' '#1084#1072#1088#1082#1091'>'
    Width = 350
  end
  object cxLabel2: TcxLabel
    Left = 25
    Top = 223
    Caption = #1057#1077#1079#1086#1085' :'
  end
  object edPeriod: TcxButtonEdit
    Left = 25
    Top = 243
    Properties.Buttons = <
      item
        Default = True
        Kind = bkEllipsis
      end>
    Properties.ReadOnly = True
    TabOrder = 11
    Text = '<'#1042#1099#1073#1077#1088#1080#1090#1077' '#1089#1077#1079#1086#1085'>'
    Width = 185
  end
  object cxLabel5: TcxLabel
    Left = 230
    Top = 10
    Caption = #1043#1086#1076' '#1089' ...'
  end
  object cxLabel8: TcxLabel
    Left = 306
    Top = 10
    Caption = #1043#1086#1076' '#1087#1086' ...'
  end
  object cbSize: TcxCheckBox
    Left = 25
    Top = 325
    Hint = #1087#1086#1082#1072#1079#1072#1090#1100' '#1056#1072#1079#1084#1077#1088#1099' ('#1044#1072'/'#1053#1077#1090')'
    Caption = #1056#1072#1079#1084#1077#1088#1099
    ParentShowHint = False
    ShowHint = True
    TabOrder = 14
    Width = 85
  end
  object cbGoods: TcxCheckBox
    Left = 25
    Top = 300
    Hint = #1087#1086#1082#1072#1079#1072#1090#1100' '#1058#1086#1074#1072#1088#1099' ('#1044#1072'/'#1053#1077#1090')'
    Caption = #1058#1086#1074#1072#1088#1099
    ParentShowHint = False
    ShowHint = True
    TabOrder = 15
    Width = 85
  end
  object cbPeriodAll: TcxCheckBox
    Left = 64
    Top = 55
    Hint = #1086#1075#1088#1072#1085#1080#1095#1077#1085#1080#1077' '#1079#1072' '#1042#1077#1089#1100' '#1087#1077#1088#1080#1086#1076' ('#1044#1072'/'#1053#1077#1090')'
    Caption = #1079#1072' '#1042#1077#1089#1100' '#1087#1077#1088#1080#1086#1076
    ParentShowHint = False
    Properties.ReadOnly = False
    ShowHint = True
    TabOrder = 16
    Width = 105
  end
  object cbYear: TcxCheckBox
    Left = 239
    Top = 55
    Hint = #1086#1075#1088#1072#1085#1080#1095#1077#1085#1080#1077' '#1043#1086#1076' '#1058#1052' ('#1044#1072'/'#1053#1077#1090')'
    Caption = #1086#1075#1088#1072#1085#1080#1095#1077#1085#1080#1077' '#1043#1086#1076' '#1058#1052
    ParentShowHint = False
    ShowHint = True
    TabOrder = 17
    Width = 130
  end
  object cxLabel3: TcxLabel
    Left = 25
    Top = 83
    Caption = #1055#1086#1076#1088#1072#1079#1076#1077#1083#1077#1085#1080#1077' / '#1043#1088#1091#1087#1087#1072':'
  end
  object edUnit: TcxButtonEdit
    Left = 25
    Top = 103
    Properties.Buttons = <
      item
        Default = True
        Kind = bkEllipsis
      end>
    Properties.Nullstring = '<'#1042#1099#1073#1077#1088#1080#1090#1077' '#1087#1086#1076#1088#1072#1079#1076#1077#1083#1077#1085#1080#1077'>'
    Properties.ReadOnly = True
    Properties.UseNullString = True
    TabOrder = 19
    Text = '<'#1042#1099#1073#1077#1088#1080#1090#1077' '#1087#1086#1076#1088#1072#1079#1076#1077#1083#1077#1085#1080#1077'>'
    Width = 350
  end
  object cbClient_doc: TcxCheckBox
    Left = 140
    Top = 300
    Hint = #1087#1086#1082#1072#1079#1072#1090#1100' '#1055#1086#1082#1091#1087#1072#1090#1077#1083#1103' ('#1044#1072'/'#1053#1077#1090')'
    Caption = #1055#1086#1082#1091#1087#1072#1090#1077#1083#1100
    ParentShowHint = False
    ShowHint = True
    TabOrder = 20
    Width = 100
  end
  object cbOperPrice: TcxCheckBox
    Left = 140
    Top = 325
    Hint = #1087#1086#1082#1072#1079#1072#1090#1100' '#1062#1077#1085#1072' '#1074#1093'. '#1074' '#1074#1072#1083'. ('#1044#1072'/'#1053#1077#1090')'
    Caption = #1062#1077#1085#1072' '#1074#1093'.'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 21
    Width = 100
  end
  object cbOperDate_doc: TcxCheckBox
    Left = 270
    Top = 300
    Hint = #1087#1086#1082#1072#1079#1072#1090#1100' '#1043#1086#1076' / '#1052#1077#1089#1103#1094' '#1055#1088#1086#1076#1072#1078#1080' ('#1044#1072'/'#1053#1077#1090')'
    Caption = #1043#1086#1076' / '#1052#1077#1089#1103#1094
    ParentShowHint = False
    ShowHint = True
    TabOrder = 22
    Width = 100
  end
  object cbDay_doc: TcxCheckBox
    Left = 270
    Top = 325
    Hint = #1087#1086#1082#1072#1079#1072#1090#1100' '#1044#1077#1085#1100' '#1085#1077#1076#1077#1083#1080' '#1055#1088#1086#1076#1072#1078#1080' ('#1044#1072'/'#1053#1077#1090')'
    Caption = #1044#1077#1085#1100' '#1085#1077#1076#1077#1083#1080
    ParentShowHint = False
    ShowHint = True
    TabOrder = 23
    Width = 100
  end
  object cbDiscount: TcxCheckBox
    Left = 25
    Top = 275
    Hint = #1087#1086#1082#1072#1079#1072#1090#1100' % '#1089#1082#1080#1076#1082#1080' ('#1044#1072'/'#1053#1077#1090')'
    Caption = '% '#1057#1082#1080#1076#1082#1080
    ParentShowHint = False
    ShowHint = True
    TabOrder = 24
    Width = 75
  end
  object edStartYear: TcxButtonEdit
    Left = 231
    Top = 28
    Properties.Buttons = <
      item
        Default = True
        Kind = bkEllipsis
      end>
    Properties.ReadOnly = True
    TabOrder = 25
    Width = 69
  end
  object edEndYear: TcxButtonEdit
    Left = 306
    Top = 30
    Properties.Buttons = <
      item
        Default = True
        Kind = bkEllipsis
      end>
    Properties.ReadOnly = True
    TabOrder = 26
    Width = 69
  end
  object cbMark: TcxCheckBox
    Left = 140
    Top = 275
    Hint = #1087#1086#1082#1072#1079#1072#1090#1100' '#1058#1054#1051#1068#1050#1054' '#1076#1083#1103' '#1057#1055#1048#1057#1050#1040' '#1055#1072#1088#1090#1080#1081'/'#1058#1086#1074#1072#1088#1086#1074
    Caption = #1057#1087#1080#1089#1086#1082' '#1055'/'#1058
    ParentShowHint = False
    ShowHint = True
    TabOrder = 27
    Width = 89
  end
  object cxLabel9: TcxLabel
    Left = 236
    Top = 223
    Caption = #1050#1086#1076' '#1090#1086#1074#1072#1088#1072':'
  end
  object edGoodsCode: TcxButtonEdit
    Left = 231
    Top = 243
    Properties.Buttons = <
      item
        Default = True
        Kind = bkEllipsis
      end>
    TabOrder = 29
    Width = 144
  end
  object PeriodChoice: TPeriodChoice
    DateStart = deStart
    DateEnd = deEnd
    Left = 161
    Top = 49
  end
  object UserSettingsStorageAddOn: TdsdUserSettingsStorageAddOn
    Left = 319
    Top = 94
  end
  object cxPropertiesStore: TcxPropertiesStore
    Components = <
      item
        Component = Owner
        Properties.Strings = (
          'Left'
          'Top')
      end>
    StorageName = 'cxPropertiesStore'
    StorageType = stStream
    Left = 329
    Top = 358
  end
  object FormParams: TdsdFormParams
    Params = <
      item
        Name = 'StartDate'
        Value = 41579d
        Component = deStart
        DataType = ftDateTime
        ParamType = ptInput
        MultiSelectSeparator = ','
      end
      item
        Name = 'EndDate'
        Value = 41608d
        Component = deEnd
        DataType = ftDateTime
        ParamType = ptInput
        MultiSelectSeparator = ','
      end
      item
        Name = 'UnitId'
        Value = Null
        Component = GuidesUnit
        ComponentItem = 'Key'
        MultiSelectSeparator = ','
      end
      item
        Name = 'UnitName'
        Value = Null
        Component = GuidesUnit
        ComponentItem = 'TextValue'
        DataType = ftString
        MultiSelectSeparator = ','
      end
      item
        Name = 'PartnerId'
        Value = Null
        Component = GuidesPartner
        ComponentItem = 'Key'
        ParamType = ptInput
        MultiSelectSeparator = ','
      end
      item
        Name = 'PartnerName'
        Value = Null
        Component = GuidesPartner
        ComponentItem = 'TextValue'
        DataType = ftString
        ParamType = ptInput
        MultiSelectSeparator = ','
      end
      item
        Name = 'BrandId'
        Value = Null
        Component = GuidesBrand
        ComponentItem = 'Key'
        ParamType = ptInput
        MultiSelectSeparator = ','
      end
      item
        Name = 'BrandName'
        Value = Null
        Component = GuidesBrand
        ComponentItem = 'TextValue'
        DataType = ftString
        ParamType = ptInput
        MultiSelectSeparator = ','
      end
      item
        Name = 'PeriodId'
        Value = Null
        Component = GuidesPeriod
        ComponentItem = 'Key'
        ParamType = ptInput
        MultiSelectSeparator = ','
      end
      item
        Name = 'PeriodName'
        Value = Null
        Component = GuidesPeriod
        ComponentItem = 'TextValue'
        DataType = ftString
        ParamType = ptInput
        MultiSelectSeparator = ','
      end
      item
        Name = 'StartYear'
        Value = Null
        Component = GuidesStartYear
        ComponentItem = 'Key'
        ParamType = ptInput
        MultiSelectSeparator = ','
      end
      item
        Name = 'StartYearText'
        Value = Null
        Component = GuidesStartYear
        ComponentItem = 'TextValue'
        DataType = ftString
        ParamType = ptInput
        MultiSelectSeparator = ','
      end
      item
        Name = 'EndYear'
        Value = Null
        Component = GuidesEndYear
        ComponentItem = 'Key'
        ParamType = ptInput
        MultiSelectSeparator = ','
      end
      item
        Name = 'EndYearText'
        Value = Null
        Component = GuidesEndYear
        ComponentItem = 'TextValue'
        DataType = ftString
        ParamType = ptInput
        MultiSelectSeparator = ','
      end
      item
        Name = 'isYear'
        Value = Null
        Component = cbYear
        DataType = ftBoolean
        MultiSelectSeparator = ','
      end
      item
        Name = 'isPeriodAll'
        Value = Null
        Component = cbPeriodAll
        DataType = ftBoolean
        MultiSelectSeparator = ','
      end
      item
        Name = 'isGoods'
        Value = Null
        Component = cbGoods
        DataType = ftBoolean
        ParamType = ptInput
        MultiSelectSeparator = ','
      end
      item
        Name = 'isSize'
        Value = Null
        Component = cbSize
        DataType = ftBoolean
        ParamType = ptInput
        MultiSelectSeparator = ','
      end
      item
        Name = 'isClient_doc'
        Value = Null
        Component = cbClient_doc
        DataType = ftBoolean
        MultiSelectSeparator = ','
      end
      item
        Name = 'isOperDate_doc'
        Value = Null
        Component = cbOperDate_doc
        DataType = ftBoolean
        MultiSelectSeparator = ','
      end
      item
        Name = 'isDay_doc'
        Value = Null
        Component = cbDay_doc
        DataType = ftBoolean
        MultiSelectSeparator = ','
      end
      item
        Name = 'isOperPrice'
        Value = Null
        Component = cbOperPrice
        DataType = ftBoolean
        MultiSelectSeparator = ','
      end
      item
        Name = 'isDiscount'
        Value = Null
        Component = cbDiscount
        DataType = ftBoolean
        MultiSelectSeparator = ','
      end
      item
        Name = 'isMark'
        Value = Null
        Component = cbMark
        DataType = ftBoolean
        ParamType = ptInput
        MultiSelectSeparator = ','
      end
      item
        Name = 'GoodsCode'
        Value = Null
        Component = edGoodsCode
        ParamType = ptInput
        MultiSelectSeparator = ','
      end>
    Left = 47
    Top = 352
  end
  object GuidesPartner: TdsdGuides
    KeyField = 'Id'
    LookupControl = edPartner
    FormNameParam.Value = 'TPartnerForm'
    FormNameParam.DataType = ftString
    FormNameParam.MultiSelectSeparator = ','
    FormName = 'TPartnerForm'
    PositionDataSet = 'MasterCDS'
    Params = <
      item
        Name = 'Key'
        Value = ''
        Component = GuidesPartner
        ComponentItem = 'Key'
        ParamType = ptInput
        MultiSelectSeparator = ','
      end
      item
        Name = 'TextValue'
        Value = ''
        Component = GuidesPartner
        ComponentItem = 'TextValue'
        DataType = ftString
        ParamType = ptInput
        MultiSelectSeparator = ','
      end
      item
        Name = 'MasterUnitId'
        Value = ''
        ComponentItem = 'Key'
        ParamType = ptInput
        MultiSelectSeparator = ','
      end
      item
        Name = 'MasterUnitName'
        Value = ''
        ComponentItem = 'TextValue'
        DataType = ftString
        ParamType = ptInput
        MultiSelectSeparator = ','
      end>
    Left = 241
    Top = 169
  end
  object GuidesBrand: TdsdGuides
    KeyField = 'Id'
    LookupControl = edBrand
    Key = '0'
    FormNameParam.Value = 'TBrandForm'
    FormNameParam.DataType = ftString
    FormNameParam.MultiSelectSeparator = ','
    FormName = 'TBrandForm'
    PositionDataSet = 'MasterCDS'
    Params = <
      item
        Name = 'Key'
        Value = '0'
        Component = GuidesBrand
        ComponentItem = 'Key'
        DataType = ftString
        ParamType = ptInput
        MultiSelectSeparator = ','
      end
      item
        Name = 'TextValue'
        Value = ''
        Component = GuidesBrand
        ComponentItem = 'TextValue'
        DataType = ftString
        ParamType = ptInput
        MultiSelectSeparator = ','
      end>
    Left = 223
    Top = 95
  end
  object GuidesPeriod: TdsdGuides
    KeyField = 'Id'
    LookupControl = edPeriod
    Key = '0'
    FormNameParam.Value = 'TPeriodForm'
    FormNameParam.DataType = ftString
    FormNameParam.MultiSelectSeparator = ','
    FormName = 'TPeriodForm'
    PositionDataSet = 'MasterCDS'
    Params = <
      item
        Name = 'Key'
        Value = '0'
        Component = GuidesPeriod
        ComponentItem = 'Key'
        DataType = ftString
        ParamType = ptInput
        MultiSelectSeparator = ','
      end
      item
        Name = 'TextValue'
        Value = ''
        Component = GuidesPeriod
        ComponentItem = 'TextValue'
        DataType = ftString
        ParamType = ptInput
        MultiSelectSeparator = ','
      end>
    Left = 183
    Top = 139
  end
  object GuidesUnit: TdsdGuides
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
        Component = GuidesUnit
        ComponentItem = 'Key'
        ParamType = ptInput
        MultiSelectSeparator = ','
      end
      item
        Name = 'TextValue'
        Value = ''
        Component = GuidesUnit
        ComponentItem = 'TextValue'
        DataType = ftString
        ParamType = ptInput
        MultiSelectSeparator = ','
      end
      item
        Name = 'MasterUnitId'
        Value = ''
        ComponentItem = 'Key'
        ParamType = ptInput
        MultiSelectSeparator = ','
      end
      item
        Name = 'MasterUnitName'
        Value = ''
        ComponentItem = 'TextValue'
        DataType = ftString
        ParamType = ptInput
        MultiSelectSeparator = ','
      end>
    Left = 153
    Top = 217
  end
  object GuidesStartYear: TdsdGuides
    KeyField = 'Id'
    LookupControl = edStartYear
    Key = '0'
    FormNameParam.Value = 'TPeriodYear_ChoiceForm'
    FormNameParam.DataType = ftString
    FormNameParam.MultiSelectSeparator = ','
    FormName = 'TPeriodYear_ChoiceForm'
    PositionDataSet = 'MasterCDS'
    Params = <
      item
        Name = 'Key'
        Value = '0'
        Component = GuidesStartYear
        ComponentItem = 'Key'
        ParamType = ptInput
        MultiSelectSeparator = ','
      end
      item
        Name = 'TextValue'
        Value = ''
        Component = GuidesStartYear
        ComponentItem = 'TextValue'
        DataType = ftString
        ParamType = ptInput
        MultiSelectSeparator = ','
      end>
    Left = 266
    Top = 3
  end
  object GuidesEndYear: TdsdGuides
    KeyField = 'Id'
    LookupControl = edEndYear
    Key = '0'
    FormNameParam.Value = 'TPeriodYear_ChoiceForm'
    FormNameParam.DataType = ftString
    FormNameParam.MultiSelectSeparator = ','
    FormName = 'TPeriodYear_ChoiceForm'
    PositionDataSet = 'MasterCDS'
    Params = <
      item
        Name = 'Key'
        Value = '0'
        Component = GuidesEndYear
        ComponentItem = 'Key'
        ParamType = ptInput
        MultiSelectSeparator = ','
      end
      item
        Name = 'TextValue'
        Value = ''
        Component = GuidesEndYear
        ComponentItem = 'TextValue'
        DataType = ftString
        ParamType = ptInput
        MultiSelectSeparator = ','
      end>
    Left = 357
    Top = 5
  end
  object GuidesPartionGoods: TdsdGuides
    KeyField = 'Id'
    LookupControl = edGoodsCode
    FormNameParam.Value = 'TPartionGoodsChoiceForm'
    FormNameParam.DataType = ftString
    FormNameParam.MultiSelectSeparator = ','
    FormName = 'TPartionGoodsChoiceForm'
    PositionDataSet = 'MasterCDS'
    Params = <
      item
        Name = 'Code'
        Value = ''
        Component = edGoodsCode
        ParamType = ptInput
        MultiSelectSeparator = ','
      end
      item
        Name = 'MasterUnitId'
        Value = ''
        Component = GuidesUnit
        ComponentItem = 'Key'
        MultiSelectSeparator = ','
      end
      item
        Name = 'MasterUnitName'
        Value = ''
        Component = GuidesUnit
        ComponentItem = 'TextValue'
        DataType = ftString
        MultiSelectSeparator = ','
      end
      item
        Name = 'PartionId'
        Value = Null
        Component = FormParams
        ComponentItem = 'PartionId'
        ParamType = ptInput
        MultiSelectSeparator = ','
      end
      item
        Name = 'MovementId'
        Value = Null
        ParamType = ptInput
        MultiSelectSeparator = ','
      end
      item
        Name = 'InvNumberAll'
        Value = Null
        DataType = ftString
        ParamType = ptInput
        MultiSelectSeparator = ','
      end
      item
        Name = 'GoodsSizeId'
        Value = ''
        ComponentItem = 'Key'
        ParamType = ptInput
        MultiSelectSeparator = ','
      end
      item
        Name = 'GoodsSizeName'
        Value = ''
        ComponentItem = 'TextValue'
        DataType = ftString
        ParamType = ptInput
        MultiSelectSeparator = ','
      end>
    Left = 292
    Top = 239
  end
end
