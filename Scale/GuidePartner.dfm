object GuidePartnerForm: TGuidePartnerForm
  Left = 578
  Top = 242
  Caption = #1057#1087#1088#1072#1074#1086#1095#1085#1080#1082' <'#1050#1086#1085#1090#1088#1072#1075#1077#1085#1090#1099'>'
  ClientHeight = 572
  ClientWidth = 962
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 14
  object GridPanel: TPanel
    Left = 0
    Top = 41
    Width = 962
    Height = 531
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 0
    object ButtonPanel: TPanel
      Left = 0
      Top = 0
      Width = 962
      Height = 33
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 0
      object bbExit: TSpeedButton
        Left = 511
        Top = 3
        Width = 31
        Height = 29
        Action = actExit
        Glyph.Data = {
          F6000000424DF600000000000000760000002800000010000000100000000100
          0400000000008000000000000000000000001000000000000000000000000000
          8000008000000080800080000000800080008080000080808000C0C0C0000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00888888888888
          8888888888808077708888888880807770880800008080777088888880008077
          7088888880088078708800808000807770888888000000777088888888008007
          7088888880008077708888888800800770888888888880000088888888888888
          8888888888884444888888888888488488888888888844448888}
        ParentShowHint = False
        ShowHint = True
      end
      object bbRefresh: TSpeedButton
        Left = 306
        Top = 3
        Width = 31
        Height = 29
        Action = actRefresh
        Glyph.Data = {
          F6000000424DF600000000000000760000002800000010000000100000000100
          0400000000008000000000000000000000001000000000000000000000000000
          80000080000000808000800000008000800080800000C0C0C000808080000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00777777000000
          00007777770FFFFFFFF000700000FF0F00F0E00BFBFB0FFFFFF0E0BFBF000FFF
          F0F0E0FBFBFBF0F00FF0E0BFBF00000B0FF0E0FBFBFBFBF0FFF0E0BF0000000F
          FFF0000BFB00B0FF00F07770000B0FFFFFF0777770B0FFFF000077770B0FF00F
          0FF07770B00FFFFF0F077709070FFFFF00777770770000000777}
        ParentShowHint = False
        ShowHint = True
      end
      object bbChoice: TSpeedButton
        Left = 67
        Top = 3
        Width = 31
        Height = 29
        Action = actChoice
        Glyph.Data = {
          F6000000424DF600000000000000760000002800000010000000100000000100
          0400000000008000000000000000000000001000000000000000000000000000
          8000008000000080800080000000800080008080000080808000C0C0C0000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00888888888888
          888888888888888888888888888888888888873333333333338887BB3B33B3B3
          B38887B3B3B13B3B3388873B3B9913B3B38887B3B399973B3388873B397B9973
          B38887B397BBB997338887FFFFFFFF91BB8888FBBBBB88891888888FFFF88888
          9188888888888888898888888888888888988888888888888888}
        ParentShowHint = False
        ShowHint = True
      end
    end
    object cxDBGrid: TcxGrid
      Left = 0
      Top = 33
      Width = 962
      Height = 498
      Align = alClient
      TabOrder = 1
      object cxDBGridDBTableView: TcxGridDBTableView
        Navigator.Buttons.CustomButtons = <>
        DataController.DataSource = DS
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        OptionsCustomize.ColumnHiding = True
        OptionsCustomize.ColumnMoving = False
        OptionsCustomize.ColumnsQuickCustomization = True
        OptionsData.Deleting = False
        OptionsData.DeletingConfirmation = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsView.ColumnAutoWidth = True
        OptionsView.GroupByBox = False
        OptionsView.HeaderAutoHeight = True
        OptionsView.Indicator = True
        Styles.StyleSheet = dmMain.cxGridTableViewStyleSheet
        object PartnerCode: TcxGridDBColumn
          Caption = #1050#1086#1076
          DataBinding.FieldName = 'PartnerCode'
          HeaderAlignmentHorz = taCenter
          HeaderAlignmentVert = vaCenter
          Width = 70
        end
        object PartnerName: TcxGridDBColumn
          Caption = #1053#1072#1079#1074#1072#1085#1080#1077
          DataBinding.FieldName = 'PartnerName'
          HeaderAlignmentHorz = taCenter
          HeaderAlignmentVert = vaCenter
          Width = 350
        end
        object PaidKindName: TcxGridDBColumn
          Caption = #1060#1086#1088#1084'. '#1086#1087#1083'.'
          DataBinding.FieldName = 'PaidKindName'
          HeaderAlignmentHorz = taCenter
          HeaderAlignmentVert = vaCenter
          Width = 55
        end
        object ContractCode: TcxGridDBColumn
          Caption = #1050#1086#1076' '#1076#1086#1075'.'
          DataBinding.FieldName = 'ContractCode'
          HeaderAlignmentHorz = taCenter
          HeaderAlignmentVert = vaCenter
          Width = 60
        end
        object ContractNumber: TcxGridDBColumn
          Caption = #8470' '#1076#1086#1075'.'
          DataBinding.FieldName = 'ContractNumber'
          HeaderAlignmentHorz = taCenter
          HeaderAlignmentVert = vaCenter
          Width = 80
        end
        object ContractTagName: TcxGridDBColumn
          Caption = #1055#1088#1080#1079#1085#1072#1082' '#1076#1086#1075'.'
          DataBinding.FieldName = 'ContractTagName'
          HeaderAlignmentHorz = taCenter
          HeaderAlignmentVert = vaCenter
          Width = 100
        end
        object ChangePercent: TcxGridDBColumn
          Caption = '% '#1089#1082'.'
          DataBinding.FieldName = 'ChangePercent'
          HeaderAlignmentHorz = taCenter
          HeaderAlignmentVert = vaCenter
          Width = 45
        end
        object ChangePercentAmount: TcxGridDBColumn
          Caption = '% '#1089#1082'. '#1074#1077#1089
          DataBinding.FieldName = 'ChangePercentAmount'
          HeaderAlignmentHorz = taCenter
          HeaderAlignmentVert = vaCenter
          Width = 45
        end
        object InfoMoneyCode: TcxGridDBColumn
          Caption = #1050#1086#1076' '#1059#1055
          DataBinding.FieldName = 'InfoMoneyCode'
          HeaderAlignmentHorz = taCenter
          HeaderAlignmentVert = vaCenter
          Width = 70
        end
        object InfoMoneyName: TcxGridDBColumn
          Caption = #1059#1055' '#1089#1090#1072#1090#1100#1103
          DataBinding.FieldName = 'InfoMoneyName'
          HeaderAlignmentHorz = taCenter
          HeaderAlignmentVert = vaCenter
          Width = 150
        end
      end
      object cxDBGridLevel: TcxGridLevel
        GridView = cxDBGridDBTableView
      end
    end
  end
  object ParamsPanel: TPanel
    Left = 0
    Top = 0
    Width = 962
    Height = 41
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 1
    object gbPartnerCode: TGroupBox
      Left = 0
      Top = 0
      Width = 137
      Height = 41
      Align = alLeft
      Caption = #1050#1086#1076
      TabOrder = 0
      object EditPartnerCode: TEdit
        Left = 5
        Top = 17
        Width = 125
        Height = 22
        TabOrder = 0
        Text = 'EditPartnerCode'
        OnChange = EditPartnerCodeChange
        OnEnter = EditPartnerCodeEnter
        OnKeyDown = EditPartnerCodeKeyDown
        OnKeyPress = EditPartnerCodeKeyPress
      end
    end
    object gbPartnerName: TGroupBox
      Left = 137
      Top = 0
      Width = 825
      Height = 41
      Align = alClient
      Caption = #1053#1072#1079#1074#1072#1085#1080#1077
      TabOrder = 1
      object EditPartnerName: TEdit
        Left = 5
        Top = 17
        Width = 332
        Height = 22
        TabOrder = 0
        Text = 'EditPartnerName'
        OnChange = EditPartnerNameChange
        OnEnter = EditPartnerNameEnter
        OnKeyDown = EditPartnerNameKeyDown
        OnKeyPress = EditPartnerNameKeyPress
      end
    end
  end
  object DataSource: TDataSource
    DataSet = CDS
    Left = 320
    Top = 336
  end
  object spSelect: TdsdStoredProc
    DataSet = CDS
    DataSets = <
      item
        DataSet = CDS
      end>
    Params = <>
    PackSize = 1
    Left = 264
    Top = 296
  end
  object CDS: TClientDataSet
    Aggregates = <>
    Params = <>
    OnFilterRecord = CDSFilterRecord
    Left = 272
    Top = 384
  end
  object DS: TDataSource
    DataSet = CDS
    Left = 192
    Top = 424
  end
  object DBViewAddOn: TdsdDBViewAddOn
    ErasedFieldName = 'isErased'
    View = cxDBGridDBTableView
    OnDblClickActionList = <
      item
        Action = actChoice
      end>
    ActionItemList = <>
    SortImages = dmMain.SortImageList
    OnlyEditingCellOnEnter = False
    ColorRuleList = <>
    ColumnAddOnList = <>
    ColumnEnterList = <>
    SummaryItemList = <>
    Left = 408
    Top = 392
  end
  object ActionList: TActionList
    Left = 384
    Top = 168
    object actRefresh: TAction
      Category = 'ScaleLib'
      Hint = #1054#1073#1085#1086#1074#1080#1090#1100' '#1076#1072#1085#1085#1099#1077
      OnExecute = actRefreshExecute
    end
    object actChoice: TAction
      Category = 'ScaleLib'
      Hint = #1042#1099#1073#1086#1088' '#1079#1085#1072#1095#1077#1085#1080#1103
      OnExecute = actChoiceExecute
    end
    object actExit: TAction
      Category = 'ScaleLib'
      Hint = #1042#1099#1093#1086#1076
      OnExecute = actExitExecute
    end
  end
end
