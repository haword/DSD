﻿object BankAccountEditForm: TBankAccountEditForm
  Left = 0
  Top = 0
  Caption = #1056#1072#1089#1095#1077#1090#1085#1099#1081' '#1089#1095#1077#1090
  ClientHeight = 343
  ClientWidth = 666
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  AddOnFormData.RefreshAction = dsdDataSetRefresh
  AddOnFormData.Params = dsdFormParams
  PixelsPerInch = 96
  TextHeight = 13
  object edName: TcxTextEdit
    Left = 40
    Top = 71
    TabOrder = 0
    Width = 273
  end
  object cxLabel1: TcxLabel
    Left = 40
    Top = 48
    Cursor = crDrag
    Caption = #1056#1072#1089#1095#1077#1090#1085#1099#1081' '#1089#1095#1077#1090
  end
  object cxButton1: TcxButton
    Left = 200
    Top = 298
    Width = 75
    Height = 25
    Action = dsdExecStoredProc
    Default = True
    ModalResult = 8
    TabOrder = 2
  end
  object cxButton2: TcxButton
    Left = 344
    Top = 298
    Width = 75
    Height = 25
    Action = dsdFormClose
    Cancel = True
    Caption = #1054#1090#1084#1077#1085#1072
    ModalResult = 8
    TabOrder = 3
  end
  object Код: TcxLabel
    Left = 40
    Top = 3
    Caption = #1050#1086#1076
  end
  object ceCode: TcxCurrencyEdit
    Left = 40
    Top = 26
    Properties.DecimalPlaces = 0
    Properties.DisplayFormat = '0'
    TabOrder = 5
    Width = 273
  end
  object cxLabel3: TcxLabel
    Left = 40
    Top = 103
    Caption = #1070#1088#1080#1076#1080#1095#1077#1089#1082#1086#1077' '#1083#1080#1094#1086
  end
  object cxLabel2: TcxLabel
    Left = 40
    Top = 159
    Caption = #1041#1072#1085#1082#1080
  end
  object cxLabel4: TcxLabel
    Left = 40
    Top = 215
    Caption = #1042#1072#1083#1102#1090#1099
  end
  object edJuridical: TcxButtonEdit
    Left = 40
    Top = 128
    Properties.Buttons = <
      item
        Default = True
        Kind = bkEllipsis
      end>
    TabOrder = 9
    Width = 273
  end
  object edBank: TcxButtonEdit
    Left = 40
    Top = 182
    Properties.Buttons = <
      item
        Default = True
        Kind = bkEllipsis
      end>
    TabOrder = 10
    Width = 273
  end
  object edCurrency: TcxButtonEdit
    Left = 40
    Top = 238
    Properties.Buttons = <
      item
        Default = True
        Kind = bkEllipsis
      end>
    TabOrder = 11
    Width = 273
  end
  object edCorrespondentAccount: TcxTextEdit
    Left = 344
    Top = 238
    TabOrder = 12
    Width = 273
  end
  object cxLabel5: TcxLabel
    Left = 344
    Top = 215
    Cursor = crDrag
    Caption = #1057#1095#1077#1090' '#1074' '#1073#1072#1085#1082#1077' - '#1082#1086#1088#1088#1077#1089#1087#1086#1085#1076#1077#1085#1090#1077
  end
  object cxLabel6: TcxLabel
    Left = 344
    Top = 48
    Cursor = crDrag
    Caption = #1057#1095#1077#1090' '#1073#1072#1085#1082#1072' '#1073#1077#1085#1077#1092#1080#1094#1080#1072#1088#1072
  end
  object edBeneficiarysBankAccount: TcxTextEdit
    Left = 344
    Top = 71
    TabOrder = 15
    Width = 273
  end
  object cxLabel7: TcxLabel
    Left = 344
    Top = 105
    Cursor = crDrag
    Caption = #1057#1095#1077#1090' '#1073#1077#1085#1077#1092#1080#1094#1080#1072#1088#1072
  end
  object edBeneficiarysAccount: TcxTextEdit
    Left = 344
    Top = 128
    TabOrder = 17
    Width = 273
  end
  object cxLabel8: TcxLabel
    Left = 344
    Top = 159
    Caption = #1041#1072#1085#1082' '#1082#1086#1088#1088#1077#1089#1087#1086#1085#1076#1077#1085#1090' '#1076#1083#1103' '#1089#1095#1077#1090#1072
  end
  object edCorrespondentBank: TcxButtonEdit
    Left = 344
    Top = 182
    Properties.Buttons = <
      item
        Default = True
        Kind = bkEllipsis
      end>
    TabOrder = 19
    Width = 273
  end
  object cxLabel9: TcxLabel
    Left = 344
    Top = 3
    Caption = #1041#1072#1085#1082' '#1073#1077#1085#1077#1092#1080#1094#1080#1072#1088#1072
  end
  object edBeneficiarysBank: TcxButtonEdit
    Left = 344
    Top = 26
    Properties.Buttons = <
      item
        Default = True
        Kind = bkEllipsis
      end>
    TabOrder = 21
    Width = 273
  end
  object ActionList: TActionList
    Left = 296
    Top = 72
    object dsdDataSetRefresh: TdsdDataSetRefresh
      Category = 'DSDLib'
      MoveParams = <>
      StoredProc = spGet
      StoredProcList = <
        item
          StoredProc = spGet
        end
        item
        end>
      Caption = #1055#1077#1088#1077#1095#1080#1090#1072#1090#1100
      Hint = #1054#1073#1085#1086#1074#1080#1090#1100' '#1076#1072#1085#1085#1099#1077
      ShortCut = 116
      RefreshOnTabSetChanges = False
    end
    object dsdExecStoredProc: TdsdInsertUpdateGuides
      Category = 'DSDLib'
      MoveParams = <>
      StoredProc = spInsertUpdate
      StoredProcList = <
        item
          StoredProc = spInsertUpdate
        end>
      Caption = 'Ok'
    end
    object dsdFormClose: TdsdFormClose
      MoveParams = <>
    end
  end
  object spInsertUpdate: TdsdStoredProc
    StoredProcName = 'gpInsertUpdate_Object_BankAccount'
    DataSets = <>
    OutputType = otResult
    Params = <
      item
        Name = 'ioId'
        Value = Null
        Component = dsdFormParams
        ComponentItem = 'Id'
        ParamType = ptInputOutput
      end
      item
        Name = 'inCode'
        Value = 0.000000000000000000
        Component = ceCode
        ParamType = ptInput
      end
      item
        Name = 'inName'
        Value = ''
        Component = edName
        DataType = ftString
        ParamType = ptInput
      end
      item
        Name = 'inJuridicalId'
        Value = ''
        Component = dsdJuridicalGuides
        ParamType = ptInput
      end
      item
        Name = 'inBankId'
        Value = ''
        Component = dsdBankGuides
        ParamType = ptInput
      end
      item
        Name = 'inCurrencyId'
        Value = ''
        Component = dsdCurrencyGuides
        ParamType = ptInput
      end
      item
        Name = 'inCorrespondentBankId'
        Value = Null
        Component = dsdCorrBankGuides
        ComponentItem = 'Key'
        ParamType = ptInput
      end
      item
        Name = 'inBeneficiarysBankId'
        Value = Null
        Component = dsdBeneficiarysBankGuides
        ComponentItem = 'Key'
        ParamType = ptInput
      end
      item
        Name = 'inCorrespondentAccount'
        Value = Null
        Component = edCorrespondentAccount
        DataType = ftString
        ParamType = ptInput
      end
      item
        Name = 'inBeneficiarysBankAccount'
        Value = Null
        Component = edBeneficiarysBankAccount
        DataType = ftString
        ParamType = ptInput
      end
      item
        Name = 'inBeneficiarysAccount'
        Value = Null
        Component = edBeneficiarysAccount
        DataType = ftString
        ParamType = ptInput
      end>
    PackSize = 1
    Left = 240
    Top = 48
  end
  object dsdFormParams: TdsdFormParams
    Params = <
      item
        Name = 'Id'
        Value = Null
        ParamType = ptInputOutput
      end>
    Left = 232
    Top = 8
  end
  object spGet: TdsdStoredProc
    StoredProcName = 'gpGet_Object_BankAccount'
    DataSets = <>
    OutputType = otResult
    Params = <
      item
        Name = 'Id'
        Value = Null
        Component = dsdFormParams
        ComponentItem = 'Id'
        ParamType = ptInput
      end
      item
        Name = 'Name'
        Value = ''
        Component = edName
        DataType = ftString
      end
      item
        Name = 'Code'
        Value = 0.000000000000000000
        Component = ceCode
      end
      item
        Name = 'JuridicalId'
        Value = ''
        Component = dsdJuridicalGuides
        ComponentItem = 'Key'
      end
      item
        Name = 'JuridicalName'
        Value = ''
        Component = dsdJuridicalGuides
        ComponentItem = 'TextValue'
        DataType = ftString
      end
      item
        Name = 'BankId'
        Value = ''
        Component = dsdBankGuides
        ComponentItem = 'Key'
      end
      item
        Name = 'BankName'
        Value = ''
        Component = dsdBankGuides
        ComponentItem = 'TextValue'
        DataType = ftString
      end
      item
        Name = 'CurrencyId'
        Value = ''
        Component = dsdCurrencyGuides
        ComponentItem = 'Key'
      end
      item
        Name = 'CurrencyName'
        Value = ''
        Component = dsdCurrencyGuides
        ComponentItem = 'TextValue'
        DataType = ftString
      end
      item
        Name = 'CorrespondentBankId'
        Value = Null
        Component = dsdCorrBankGuides
        ComponentItem = 'Key'
      end
      item
        Name = 'CorrespondentBankName'
        Value = Null
        Component = dsdCorrBankGuides
        ComponentItem = 'TextValue'
        DataType = ftString
      end
      item
        Name = 'BeneficiarysBankId'
        Value = Null
        Component = dsdBeneficiarysBankGuides
        ComponentItem = 'Key'
      end
      item
        Name = 'BeneficiarysBankName'
        Value = Null
        Component = dsdBankGuides
        ComponentItem = 'TextValue'
        DataType = ftString
      end
      item
        Name = 'CorrespondentAccount'
        Value = Null
        Component = edCorrespondentAccount
        DataType = ftString
      end
      item
        Name = 'BeneficiarysBankAccount'
        Value = Null
        Component = edBeneficiarysBankAccount
        DataType = ftString
      end
      item
        Name = 'BeneficiarysAccount'
        Value = Null
        Component = edBeneficiarysAccount
        DataType = ftString
      end>
    PackSize = 1
    Left = 176
    Top = 88
  end
  object dsdJuridicalGuides: TdsdGuides
    KeyField = 'Id'
    LookupControl = edJuridical
    FormNameParam.Value = 'TJuridicalForm'
    FormNameParam.DataType = ftString
    FormName = 'TJuridicalForm'
    PositionDataSet = 'ClientDataSet'
    Params = <
      item
        Name = 'Key'
        Value = ''
        Component = dsdJuridicalGuides
        ComponentItem = 'Key'
      end
      item
        Name = 'TextValue'
        Value = ''
        Component = dsdJuridicalGuides
        ComponentItem = 'TextValue'
        DataType = ftString
      end>
    Left = 288
    Top = 125
  end
  object dsdBankGuides: TdsdGuides
    KeyField = 'Id'
    LookupControl = edBank
    FormNameParam.Value = 'TBankForm'
    FormNameParam.DataType = ftString
    FormName = 'TBankForm'
    PositionDataSet = 'ClientDataSet'
    Params = <
      item
        Name = 'Key'
        Value = ''
        Component = dsdBankGuides
        ComponentItem = 'Key'
      end
      item
        Name = 'TextValue'
        Value = ''
        Component = dsdBankGuides
        ComponentItem = 'TextValue'
        DataType = ftString
      end>
    Left = 312
    Top = 173
  end
  object dsdCurrencyGuides: TdsdGuides
    KeyField = 'Id'
    LookupControl = edCurrency
    FormNameParam.Value = 'TCurrencyForm'
    FormNameParam.DataType = ftString
    FormName = 'TCurrencyForm'
    PositionDataSet = 'ClientDataSet'
    Params = <
      item
        Name = 'Key'
        Value = ''
        Component = dsdCurrencyGuides
        ComponentItem = 'Key'
      end
      item
        Name = 'TextValue'
        Value = ''
        Component = dsdCurrencyGuides
        ComponentItem = 'TextValue'
        DataType = ftString
      end>
    Left = 312
    Top = 229
  end
  object dsdUserSettingsStorageAddOn: TdsdUserSettingsStorageAddOn
    Left = 24
    Top = 32
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
    Left = 248
    Top = 88
  end
  object dsdCorrBankGuides: TdsdGuides
    KeyField = 'Id'
    LookupControl = edCorrespondentBank
    FormNameParam.Value = 'TBankForm'
    FormNameParam.DataType = ftString
    FormName = 'TBankForm'
    PositionDataSet = 'ClientDataSet'
    Params = <
      item
        Name = 'Key'
        Value = ''
        Component = dsdCorrBankGuides
        ComponentItem = 'Key'
      end
      item
        Name = 'TextValue'
        Value = ''
        Component = dsdCorrBankGuides
        ComponentItem = 'TextValue'
        DataType = ftString
      end>
    Left = 616
    Top = 165
  end
  object dsdBeneficiarysBankGuides: TdsdGuides
    KeyField = 'Id'
    LookupControl = edBeneficiarysBank
    FormNameParam.Value = 'TBankForm'
    FormNameParam.DataType = ftString
    FormName = 'TBankForm'
    PositionDataSet = 'ClientDataSet'
    Params = <
      item
        Name = 'Key'
        Value = ''
        Component = dsdBeneficiarysBankGuides
        ComponentItem = 'Key'
      end
      item
        Name = 'TextValue'
        Value = ''
        Component = dsdBeneficiarysBankGuides
        ComponentItem = 'TextValue'
        DataType = ftString
      end>
    Left = 616
    Top = 25
  end
end
