inherited LoadFlagFromMedocForm: TLoadFlagFromMedocForm
  BorderStyle = bsSingle
  Caption = #1047#1072#1075#1088#1091#1079#1082#1072'  '#1080#1079' '#1052#1077#1076#1082#1072
  ClientHeight = 98
  ClientWidth = 359
  ExplicitWidth = 365
  ExplicitHeight = 123
  PixelsPerInch = 96
  TextHeight = 13
  inherited bbOk: TcxButton
    Left = 73
    Top = 54
    Action = MultiAction
    ExplicitLeft = 73
    ExplicitTop = 54
  end
  inherited bbCancel: TcxButton
    Left = 231
    Top = 54
    Action = dsdFormClose1
    ExplicitLeft = 231
    ExplicitTop = 54
  end
  object cxLabel1: TcxLabel [2]
    Left = 34
    Top = 17
    Caption = #1054#1090#1095#1077#1090#1085#1099#1081' '#1084#1077#1089#1103#1094':'
  end
  object dePeriodDate: TcxDateEdit [3]
    Left = 155
    Top = 16
    EditValue = 42005d
    Properties.AssignedValues.EditFormat = True
    Properties.DisplayFormat = 'mmmm yyyy'
    Properties.SaveTime = False
    Properties.ShowTime = False
    TabOrder = 3
    Width = 121
  end
  inherited UserSettingsStorageAddOn: TdsdUserSettingsStorageAddOn
    Top = 68
  end
  inherited cxPropertiesStore: TcxPropertiesStore
    Components = <
      item
        Component = dePeriodDate
        Properties.Strings = (
          'Date')
      end
      item
        Component = Owner
        Properties.Strings = (
          'Left'
          'Top')
      end>
    Top = 68
  end
  inherited ActionList: TActionList
    Top = 67
    object TaxJur: TMedocComAction [0]
      Category = 'TaxLib'
      MoveParams = <>
      PeriodDate.Value = 42005d
      PeriodDate.Component = dePeriodDate
      CharCode.Value = 'J1201007'
      Caption = 'TaxJur'
    end
    object TaxCorrectiveJur: TMedocComAction
      Category = 'TaxLib'
      MoveParams = <>
      PeriodDate.Value = 42005d
      PeriodDate.Component = dePeriodDate
      CharCode.Value = 'J1201207'
      Caption = 'TaxCorrectiveJur'
    end
    object TaxFiz: TMedocComAction
      Category = 'TaxLib'
      MoveParams = <>
      PeriodDate.Value = Null
      PeriodDate.Component = dePeriodDate
      CharCode.Value = 'F1201007'
      Caption = 'TaxFiz'
    end
    object TaxCorrectiveFiz: TMedocComAction
      Category = 'TaxLib'
      MoveParams = <>
      PeriodDate.Value = Null
      PeriodDate.Component = dePeriodDate
      CharCode.Value = 'F1201207'
      Caption = 'TaxCorrectiveFiz'
    end
    object MultiAction: TMultiAction
      Category = 'DSDLib'
      MoveParams = <>
      ActionList = <
        item
          Action = TaxFiz
        end
        item
          Action = TaxCorrectiveFiz
        end
        item
          Action = TaxJur
        end
        item
          Action = TaxCorrectiveJur
        end>
      QuestionBeforeExecute = #1042#1099' '#1091#1074#1077#1088#1077#1085#1099' '#1074' '#1079#1072#1075#1088#1091#1079#1082#1077' '#1089#1090#1072#1090#1091#1089#1086#1074' '#1076#1086#1082#1091#1084#1077#1085#1090#1086#1074' '#1080#1079' M.E.DOC?'
      InfoAfterExecute = #1059#1088#1072'! '#1042#1089#1077' '#1086#1073#1088#1072#1073#1086#1090#1072#1083#1080
      Caption = 'Ok'
    end
    object dsdFormClose1: TdsdFormClose
      Category = 'DSDLib'
      MoveParams = <>
      PostDataSetBeforeExecute = False
      Caption = #1054#1090#1084#1077#1085#1072
    end
  end
  inherited FormParams: TdsdFormParams
    Top = 36
  end
end
