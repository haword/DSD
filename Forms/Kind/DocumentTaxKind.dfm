inherited DocumentTaxKindForm: TDocumentTaxKindForm
  Caption = #1057#1087#1088#1072#1074#1086#1095#1085#1080#1082' <'#1058#1080#1087#1099' '#1092#1086#1088#1084#1080#1088#1086#1074#1072#1085#1080#1103' '#1085#1072#1083#1086#1075#1086#1074#1086#1075#1086' '#1076#1086#1082#1091#1084#1077#1085#1090#1072'>'
  ClientHeight = 333
  ClientWidth = 528
  ExplicitWidth = 544
  ExplicitHeight = 371
  PixelsPerInch = 96
  TextHeight = 13
  inherited PageControl: TcxPageControl
    Width = 528
    Height = 307
    ClientRectBottom = 307
    ClientRectRight = 528
    inherited tsMain: TcxTabSheet
      ExplicitWidth = 575
      ExplicitHeight = 282
      inherited cxGrid: TcxGrid
        Width = 528
        Height = 307
        inherited cxGridDBTableView: TcxGridDBTableView
          Styles.Content = nil
          Styles.Inactive = nil
          Styles.Selection = nil
          Styles.Footer = nil
          Styles.Header = nil
          object cxGridDBTableViewColumn1: TcxGridDBColumn
            Caption = #1050#1086#1076' '#1087#1088#1080#1095#1080#1085#1099
            DataBinding.FieldName = 'KindCode'
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Width = 71
          end
          object clName: TcxGridDBColumn
            Caption = #1053#1072#1079#1074#1072#1085#1080#1077
            DataBinding.FieldName = 'Name'
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Options.Editing = False
            Width = 449
          end
        end
      end
    end
  end
  inherited UserSettingsStorageAddOn: TdsdUserSettingsStorageAddOn
    Left = 203
    Top = 144
  end
  inherited cxPropertiesStore: TcxPropertiesStore
    Left = 32
    Top = 232
  end
  inherited ActionList: TActionList
    Top = 159
    object actUpdateDataSet: TdsdUpdateDataSet
      Category = 'DSDLib'
      MoveParams = <>
      PostDataSetBeforeExecute = False
      StoredProc = spUpdate_DocumentTaxKind_Code
      StoredProcList = <
        item
          StoredProc = spUpdate_DocumentTaxKind_Code
        end>
      Caption = 'actUpdateDataSet'
    end
  end
  inherited MasterDS: TDataSource
    Left = 96
    Top = 24
  end
  inherited MasterCDS: TClientDataSet
    Left = 32
    Top = 72
  end
  inherited spSelect: TdsdStoredProc
    StoredProcName = 'gpSelect_Object_DocumentTaxKind'
    Left = 120
    Top = 72
  end
  inherited BarManager: TdxBarManager
    Left = 176
    DockControlHeights = (
      0
      0
      26
      0)
  end
  inherited DBViewAddOn: TdsdDBViewAddOn
    Left = 224
    Top = 200
  end
  inherited PopupMenu: TPopupMenu
    Left = 144
    Top = 232
  end
  object spUpdate_DocumentTaxKind_Code: TdsdStoredProc
    StoredProcName = 'gpUpdate_Object_DocumentTaxKind_Code'
    DataSets = <>
    OutputType = otResult
    Params = <
      item
        Name = 'inId'
        Value = Null
        Component = MasterCDS
        ComponentItem = 'Id'
        ParamType = ptInput
        MultiSelectSeparator = ','
      end
      item
        Name = 'inCode'
        Value = Null
        Component = MasterCDS
        ComponentItem = 'KindCode'
        DataType = ftString
        ParamType = ptInput
        MultiSelectSeparator = ','
      end>
    PackSize = 1
    Left = 392
    Top = 115
  end
end
