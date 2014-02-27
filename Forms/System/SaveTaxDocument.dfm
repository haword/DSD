inherited SaveTaxDocumentForm: TSaveTaxDocumentForm
  Caption = #1042#1099#1075#1088#1091#1079#1082#1072' '#1085#1072#1083#1086#1075#1086#1074#1099#1093' '#1085#1072#1082#1083#1072#1076#1085#1099#1093' '#1074' '#1052#1077#1076#1086#1082
  ClientHeight = 108
  ClientWidth = 494
  AddOnFormData.RefreshAction = nil
  AddOnFormData.isSingle = False
  ExplicitWidth = 500
  ExplicitHeight = 133
  PixelsPerInch = 96
  TextHeight = 13
  inherited bbOk: TcxButton
    Left = 148
    Top = 56
    Action = MultiAction
    ExplicitLeft = 148
    ExplicitTop = 56
  end
  inherited bbCancel: TcxButton
    Left = 292
    Top = 56
    Action = actClose
    ExplicitLeft = 292
    ExplicitTop = 56
  end
  object cxDateEdit1: TcxDateEdit [2]
    Left = 131
    Top = 16
    TabOrder = 2
    Width = 121
  end
  object cxDateEdit2: TcxDateEdit [3]
    Left = 371
    Top = 16
    TabOrder = 3
    Width = 121
  end
  inherited UserSettingsStorageAddOn: TdsdUserSettingsStorageAddOn
    Left = 59
    Top = 48
  end
  inherited cxPropertiesStore: TcxPropertiesStore
    Components = <
      item
        Component = cxDateEdit1
        Properties.Strings = (
          'Date')
      end
      item
        Component = cxDateEdit2
        Properties.Strings = (
          'Date')
      end
      item
        Component = Owner
        Properties.Strings = (
          'Height'
          'Left'
          'Top'
          'Width')
      end>
    Left = 32
    Top = 48
  end
  inherited ActionList: TActionList
    Left = 87
    Top = 47
    inherited actRefresh: TdsdDataSetRefresh
      StoredProc = spTaxBillList
      StoredProcList = <
        item
          StoredProc = spTaxBillList
        end>
    end
    object MultiAction: TMultiAction
      Category = 'DSDLib'
      ActionList = <
        item
          Action = actRefresh
        end
        item
          Action = ExternalSaveAction
        end
        item
        end>
      InfoAfterExecute = #1044#1072#1085#1085#1099#1077' '#1076#1083#1103' '#1087#1088#1086#1075#1088#1072#1084#1084#1099' '#1052#1045#1044#1054#1050' '#1091#1089#1087#1077#1096#1085#1086' '#1074#1099#1075#1088#1091#1078#1077#1085#1099
      Caption = #1042#1099#1075#1088#1091#1079#1080#1090#1100
    end
    object ExternalSaveAction: TExternalSaveAction
      Category = 'DSDLib'
      FieldDefs = <
        item
          Name = 'NPP'
          DataType = ftString
          Size = 15
        end
        item
          Name = 'DATEV'
          DataType = ftDate
        end
        item
          Name = 'NUM'
          DataType = ftString
          Size = 50
        end
        item
          Name = 'NAZP'
          DataType = ftString
          Size = 200
        end
        item
          Name = 'IPN'
          DataType = ftString
          Size = 20
        end
        item
          Name = 'ZAGSUM'
          DataType = ftBCD
          Precision = 2
          Size = 16
        end
        item
          Name = 'BAZOP20'
          DataType = ftBCD
          Precision = 2
          Size = 16
        end
        item
          Name = 'SUMPDV'
          DataType = ftBCD
          Precision = 2
          Size = 16
        end
        item
          Name = 'ZVILN'
          DataType = ftBCD
          Precision = 2
          Size = 16
        end
        item
          Name = 'EXPORT'
          DataType = ftBCD
          Precision = 2
          Size = 16
        end
        item
          Name = 'PZOB'
          DataType = ftBCD
          Size = 3
        end
        item
          Name = 'NREZ'
          DataType = ftBCD
          Size = 2
        end
        item
          Name = 'KOR'
          DataType = ftBCD
          Size = 2
        end
        item
          Name = 'WMDTYPE'
          DataType = ftBCD
          Size = 2
        end
        item
          Name = 'WMDTYPESTR'
          DataType = ftString
          Size = 4
        end>
      DataSet = TaxBillList
    end
    object actClose: TdsdFormClose
      Category = 'DSDLib'
      Caption = #1054#1090#1084#1077#1085#1072
      Hint = #1054#1090#1084#1077#1085#1072
    end
  end
  inherited FormParams: TdsdFormParams
    Left = 32
    Top = 16
  end
  object spTaxBillList: TdsdStoredProc
    StoredProcName = 'gpSelect_Movement_Tax_Load'
    DataSet = TaxBillList
    DataSets = <
      item
        DataSet = TaxBillList
      end>
    Params = <
      item
        Name = 'inStartDate'
        Value = 0d
        Component = cxDateEdit1
        DataType = ftDateTime
        ParamType = ptInput
      end
      item
        Name = 'inEndDate'
        Value = 0d
        Component = cxDateEdit2
        DataType = ftDateTime
        ParamType = ptInput
      end>
    Left = 280
    Top = 24
  end
  object TaxBillList: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 256
    Top = 8
  end
end
