inherited SendOnPrice_BranchJournalForm: TSendOnPrice_BranchJournalForm
  Caption = #1046#1091#1088#1085#1072#1083' '#1076#1086#1082#1091#1084#1077#1085#1090#1086#1074' <'#1055#1077#1088#1077#1084#1077#1097#1077#1085#1080#1077' '#1087#1086' '#1094#1077#1085#1077' ('#1092#1080#1083#1080#1072#1083')'
  ClientHeight = 535
  ClientWidth = 1110
  AddOnFormData.Params = FormParams
  ExplicitWidth = 1126
  ExplicitHeight = 573
  PixelsPerInch = 96
  TextHeight = 13
  inherited PageControl: TcxPageControl
    Width = 1110
    Height = 478
    TabOrder = 3
    ExplicitWidth = 1110
    ExplicitHeight = 478
    ClientRectBottom = 478
    ClientRectRight = 1110
    inherited tsMain: TcxTabSheet
      ExplicitWidth = 1110
      ExplicitHeight = 478
      inherited cxGrid: TcxGrid
        Width = 1110
        Height = 478
        ExplicitWidth = 1110
        ExplicitHeight = 478
        inherited cxGridDBTableView: TcxGridDBTableView
          DataController.Filter.Options = [fcoCaseInsensitive, fcoShowOperatorDescription]
          DataController.Filter.TranslateBetween = True
          DataController.Filter.TranslateIn = True
          DataController.Filter.TranslateLike = True
          DataController.Summary.DefaultGroupSummaryItems = <
            item
              Format = ',0.####'
              Kind = skSum
              Column = colTotalCount
            end
            item
              Format = ',0.####'
              Kind = skSum
              Column = colTotalCountPartner
            end
            item
              Format = ',0.####'
              Kind = skSum
              Column = colTotalSumm
            end
            item
              Format = ',0.####'
              Kind = skSum
              Column = colTotalSummVAT
            end
            item
              Format = ',0.####'
              Kind = skSum
              Column = colTotalSummMVAT
            end
            item
              Format = ',0.####'
              Kind = skSum
              Column = colTotalSummPVAT
            end
            item
              Format = ',0.####'
              Kind = skSum
              Column = colTotalCountTare
            end
            item
              Format = ',0.####'
              Kind = skSum
              Column = colTotalCountSh
            end
            item
              Format = ',0.####'
              Kind = skSum
              Column = colTotalCountKg
            end>
          DataController.Summary.FooterSummaryItems = <
            item
              Format = ',0.####'
              Kind = skSum
              Column = colTotalCount
            end
            item
              Format = ',0.####'
              Kind = skSum
              Column = colTotalCountPartner
            end
            item
              Format = ',0.####'
              Kind = skSum
              Column = colTotalSumm
            end
            item
              Format = ',0.####'
              Kind = skSum
              Column = colTotalSummVAT
            end
            item
              Format = ',0.####'
              Kind = skSum
              Column = colTotalSummMVAT
            end
            item
              Format = ',0.####'
              Kind = skSum
              Column = colTotalSummPVAT
            end
            item
              Format = ',0.####'
              Kind = skSum
              Column = colTotalCountTare
            end
            item
              Format = ',0.####'
              Kind = skSum
              Column = colTotalCountSh
            end
            item
              Format = ',0.####'
              Kind = skSum
              Column = colTotalCountKg
            end>
          OptionsBehavior.GoToNextCellOnEnter = False
          OptionsBehavior.FocusCellOnCycle = False
          OptionsCustomize.DataRowSizing = False
          OptionsData.CancelOnExit = True
          OptionsData.Deleting = False
          OptionsData.DeletingConfirmation = False
          OptionsData.Editing = False
          OptionsView.GroupByBox = True
          OptionsView.HeaderHeight = 40
          Styles.Content = nil
          Styles.Inactive = nil
          Styles.Selection = nil
          Styles.Footer = nil
          Styles.Header = nil
          inherited colStatus: TcxGridDBColumn
            HeaderAlignmentHorz = taCenter
            Width = 55
          end
          inherited colOperDate: TcxGridDBColumn [1]
            Caption = #1044#1072#1090#1072' ('#1088#1072#1089#1093#1086#1076')'
            HeaderAlignmentHorz = taCenter
            Width = 50
          end
          object colOperDatePartner: TcxGridDBColumn [2]
            Caption = #1044#1072#1090#1072' ('#1087#1088#1080#1093#1086#1076')'
            DataBinding.FieldName = 'OperDatePartner'
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Width = 65
          end
          inherited colInvNumber: TcxGridDBColumn [3]
            Caption = #8470' '#1076#1086#1082'.'
            HeaderAlignmentHorz = taCenter
            Width = 55
          end
          object InvNumber_Order: TcxGridDBColumn
            Caption = #8470' '#1076#1086#1082'. '#1079#1072#1103#1074#1082#1072
            DataBinding.FieldName = 'InvNumber_Order'
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Options.Editing = False
            Width = 70
          end
          object InvNumber_Transport: TcxGridDBColumn
            Caption = #8470' '#1076#1086#1082'. '#1055'.'#1083'.'
            DataBinding.FieldName = 'InvNumber_Transport'
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Options.Editing = False
            Width = 61
          end
          object OperDate_Transport: TcxGridDBColumn
            Caption = #1044#1072#1090#1072' '#1076#1086#1082'. '#1055'.'#1083'.'
            DataBinding.FieldName = 'OperDate_Transport'
            Visible = False
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Options.Editing = False
            Width = 70
          end
          object CarModelName: TcxGridDBColumn
            Caption = #1052#1072#1088#1082'a '#1072#1074#1090#1086#1084#1086#1073#1080#1083#1103
            DataBinding.FieldName = 'CarModelName'
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Options.Editing = False
            Width = 89
          end
          object CarName: TcxGridDBColumn
            Caption = #1040#1074#1090#1086#1084#1086#1073#1080#1083#1100
            DataBinding.FieldName = 'CarName'
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Options.Editing = False
            Width = 80
          end
          object PersonalDriverName: TcxGridDBColumn
            Caption = #1042#1086#1076#1080#1090#1077#1083#1100
            DataBinding.FieldName = 'PersonalDriverName'
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Options.Editing = False
            Width = 70
          end
          object colFromName: TcxGridDBColumn
            Caption = #1054#1090' '#1082#1086#1075#1086
            DataBinding.FieldName = 'FromName'
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Width = 90
          end
          object colToName: TcxGridDBColumn
            Caption = #1050#1086#1084#1091
            DataBinding.FieldName = 'ToName'
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Width = 90
          end
          object colTotalCount: TcxGridDBColumn
            Caption = #1050#1086#1083'-'#1074#1086' ('#1088#1072#1089#1093#1086#1076')'
            DataBinding.FieldName = 'TotalCount'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DecimalPlaces = 4
            Properties.DisplayFormat = ',0.####;-,0.####; ;'
            Visible = False
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Width = 70
          end
          object colTotalCountPartner: TcxGridDBColumn
            Caption = #1050#1086#1083'-'#1074#1086' ('#1087#1088#1080#1093#1086#1076')'
            DataBinding.FieldName = 'TotalCountPartner'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DecimalPlaces = 4
            Properties.DisplayFormat = ',0.####;-,0.####; ;'
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Width = 70
          end
          object colTotalCountTare: TcxGridDBColumn
            Caption = #1050#1086#1083'-'#1074#1086' '#1090#1072#1088#1099' ('#1087#1088#1080#1093#1086#1076')'
            DataBinding.FieldName = 'TotalCountTare'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DecimalPlaces = 4
            Properties.DisplayFormat = ',0.####;-,0.####; ;'
            Visible = False
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Width = 55
          end
          object colTotalCountSh: TcxGridDBColumn
            Caption = #1050#1086#1083'-'#1074#1086' '#1096#1090'. ('#1087#1088#1080#1093#1086#1076')'
            DataBinding.FieldName = 'TotalCountSh'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DecimalPlaces = 4
            Properties.DisplayFormat = ',0.####;-,0.####; ;'
            Visible = False
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Width = 55
          end
          object colTotalCountKg: TcxGridDBColumn
            Caption = #1050#1086#1083'-'#1074#1086' '#1074#1077#1089' ('#1087#1088#1080#1093#1086#1076')'
            DataBinding.FieldName = 'TotalCountKg'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DecimalPlaces = 4
            Properties.DisplayFormat = ',0.####;-,0.####; ;'
            Visible = False
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Width = 55
          end
          object colTotalSumm: TcxGridDBColumn
            Caption = #1057#1091#1084#1084#1072' '#1089' '#1053#1044#1057' ('#1080#1090#1086#1075')'
            DataBinding.FieldName = 'TotalSumm'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DecimalPlaces = 4
            Properties.DisplayFormat = ',0.####;-,0.####; ;'
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Width = 70
          end
          object colChangePercent: TcxGridDBColumn
            Caption = '(-)% '#1089#1082'. (+)% '#1085#1072#1094
            DataBinding.FieldName = 'ChangePercent'
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Width = 65
          end
          object colPriceWithVAT: TcxGridDBColumn
            Caption = #1062#1077#1085#1099' '#1089' '#1053#1044#1057' ('#1076#1072'/'#1085#1077#1090')'
            DataBinding.FieldName = 'PriceWithVAT'
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Width = 55
          end
          object colVATPercent: TcxGridDBColumn
            Caption = '% '#1053#1044#1057
            DataBinding.FieldName = 'VATPercent'
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Width = 45
          end
          object colTotalSummVAT: TcxGridDBColumn
            Caption = #1057#1091#1084#1084#1072' '#1053#1044#1057
            DataBinding.FieldName = 'TotalSummVAT'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DecimalPlaces = 4
            Properties.DisplayFormat = ',0.####;-,0.####; ;'
            Visible = False
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Width = 60
          end
          object colTotalSummMVAT: TcxGridDBColumn
            Caption = #1057#1091#1084#1084#1072' '#1073#1077#1079' '#1053#1044#1057
            DataBinding.FieldName = 'TotalSummMVAT'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DecimalPlaces = 4
            Properties.DisplayFormat = ',0.####;-,0.####; ;'
            Visible = False
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Width = 80
          end
          object colTotalSummPVAT: TcxGridDBColumn
            Caption = #1057#1091#1084#1084#1072' '#1089' '#1053#1044#1057
            DataBinding.FieldName = 'TotalSummPVAT'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DecimalPlaces = 4
            Properties.DisplayFormat = ',0.####;-,0.####; ;'
            Visible = False
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Width = 70
          end
          object colRouteSortingName: TcxGridDBColumn
            Caption = #1057#1086#1088#1090#1080#1088#1086#1074#1082#1072' '#1084#1072#1088#1096#1088#1091#1090#1072
            DataBinding.FieldName = 'RouteSortingName'
            Visible = False
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Width = 70
          end
          object Comment: TcxGridDBColumn
            Caption = #1055#1088#1080#1084#1077#1095#1072#1085#1080#1077
            DataBinding.FieldName = 'Comment'
            HeaderAlignmentVert = vaCenter
            Options.Editing = False
            Width = 100
          end
        end
      end
    end
  end
  inherited Panel: TPanel
    Width = 1110
    ExplicitWidth = 1110
    inherited deStart: TcxDateEdit
      EditValue = 42370d
    end
    inherited deEnd: TcxDateEdit
      EditValue = 42370d
    end
    object edIsPartnerDate: TcxCheckBox
      Left = 427
      Top = 5
      Action = actRefresh
      Caption = #1055#1077#1088#1080#1086#1076' '#1076#1083#1103' <'#1044#1072#1090#1072' '#1076#1086#1082#1091#1084#1077#1085#1090#1072' '#1091' '#1087#1086#1082#1091#1087#1072#1090#1077#1083#1103'>'
      TabOrder = 4
      Width = 262
    end
  end
  inherited UserSettingsStorageAddOn: TdsdUserSettingsStorageAddOn
    Left = 179
  end
  inherited cxPropertiesStore: TcxPropertiesStore
    Left = 40
    Top = 243
  end
  inherited ActionList: TActionList
    Left = 471
    object actUpdateAmountChangePercentList: TMultiAction [0]
      Category = 'UpdateAmount'
      MoveParams = <>
      ActionList = <
        item
          Action = spUpdateAmountChangePercentList
        end
        item
          Action = actRefresh
        end>
      QuestionBeforeExecute = 
        #1042#1099' '#1091#1074#1077#1088#1077#1085#1099' '#1074' '#1087#1077#1088#1077#1085#1086#1089#1077' '#1076#1083#1103' '#1042#1057#1045#1061'  <'#1050#1086#1083'-'#1074#1086' ('#1087#1088#1080#1093#1086#1076')> '#1074' <'#1050#1086#1083'-'#1074#1086' ('#1088#1072#1089 +
        #1093#1086#1076')> '#1080' <'#1050#1086#1083'-'#1074#1086' '#1089#1086' '#1089#1082#1080#1076#1082#1086#1081' ('#1088#1072#1089#1093#1086#1076')>?'
      InfoAfterExecute = 
        #1044#1083#1103' '#1042#1057#1045#1061' <'#1050#1086#1083'-'#1074#1086' ('#1087#1088#1080#1093#1086#1076')> '#1074' <'#1050#1086#1083'-'#1074#1086' ('#1088#1072#1089#1093#1086#1076')> '#1080' <'#1050#1086#1083'-'#1074#1086' '#1089#1086' '#1089#1082#1080#1076 +
        #1082#1086#1081' ('#1088#1072#1089#1093#1086#1076')> '#1087#1077#1088#1077#1085#1077#1089#1083#1080' '#1091#1089#1087#1077#1096#1085#1086'.'
      Caption = 
        #1055#1077#1088#1077#1085#1077#1089#1090#1080' '#1076#1083#1103' '#1042#1057#1045#1061' <'#1050#1086#1083'-'#1074#1086' ('#1087#1088#1080#1093#1086#1076')> '#1074' <'#1050#1086#1083'-'#1074#1086' ('#1088#1072#1089#1093#1086#1076')> '#1080' <'#1050#1086#1083'-' +
        #1074#1086' '#1089#1086' '#1089#1082#1080#1076#1082#1086#1081' ('#1088#1072#1089#1093#1086#1076')>'
      Hint = 
        #1055#1077#1088#1077#1085#1077#1089#1090#1080' '#1076#1083#1103' '#1042#1057#1045#1061' <'#1050#1086#1083'-'#1074#1086' ('#1087#1088#1080#1093#1086#1076')> '#1074' <'#1050#1086#1083'-'#1074#1086' ('#1088#1072#1089#1093#1086#1076')> '#1080' <'#1050#1086#1083'-' +
        #1074#1086' '#1089#1086' '#1089#1082#1080#1076#1082#1086#1081' ('#1088#1072#1089#1093#1086#1076')>'
      ImageIndex = 42
    end
    object spUpdateAmountChangePercent: TdsdExecStoredProc [1]
      Category = 'UpdateAmount'
      MoveParams = <>
      PostDataSetBeforeExecute = False
      StoredProc = spUpdateMIAmountChangePercent
      StoredProcList = <
        item
          StoredProc = spUpdateMIAmountChangePercent
        end>
      Caption = 'spUpdateAmountPartner'
    end
    object spUpdateAmountChangePercentList: TMultiAction [3]
      Category = 'UpdateAmount'
      MoveParams = <>
      ActionList = <
        item
          Action = spUpdateAmountChangePercent
        end>
      View = cxGridDBTableView
      Caption = 
        #1055#1077#1088#1077#1085#1077#1089#1090#1080' '#1076#1083#1103' '#1042#1057#1045#1061' <'#1050#1086#1083'-'#1074#1086' ('#1087#1088#1080#1093#1086#1076')> '#1074' <'#1050#1086#1083'-'#1074#1086' ('#1088#1072#1089#1093#1086#1076')> '#1080' <'#1050#1086#1083'-' +
        #1074#1086' '#1089#1086' '#1089#1082#1080#1076#1082#1086#1081' ('#1088#1072#1089#1093#1086#1076')>'
      Hint = 
        #1055#1077#1088#1077#1085#1077#1089#1090#1080' '#1076#1083#1103' '#1042#1057#1045#1061' <'#1050#1086#1083'-'#1074#1086' ('#1087#1088#1080#1093#1086#1076')> '#1074' <'#1050#1086#1083'-'#1074#1086' ('#1088#1072#1089#1093#1086#1076')> '#1080' <'#1050#1086#1083'-' +
        #1074#1086' '#1089#1086' '#1089#1082#1080#1076#1082#1086#1081' ('#1088#1072#1089#1093#1086#1076')>'
    end
    inherited actInsert: TdsdInsertUpdateAction
      FormName = 'TSendOnPrice_BranchForm'
      FormNameParam.Value = 'TSendOnPrice_BranchForm'
      GuiParams = <
        item
          Name = 'Id'
          Value = Null
        end
        item
          Name = 'ShowAll'
          Value = True
          DataType = ftBoolean
        end
        item
          Name = 'inOperDate'
          Value = 41640d
          Component = deEnd
          DataType = ftDateTime
        end
        item
          Name = 'inChangePercentAmount'
          Value = Null
          Component = FormParams
          ComponentItem = 'inChangePercentAmount'
          DataType = ftFloat
        end>
    end
    inherited actUpdate: TdsdInsertUpdateAction
      FormName = 'TSendOnPrice_BranchForm'
      FormNameParam.Value = 'TSendOnPrice_BranchForm'
      GuiParams = <
        item
          Name = 'Id'
          Value = Null
          Component = MasterCDS
          ComponentItem = 'Id'
          ParamType = ptInput
        end
        item
          Name = 'ShowAll'
          Value = False
          DataType = ftBoolean
        end
        item
          Name = 'inOperDate'
          Value = 41640d
          Component = deEnd
          DataType = ftDateTime
        end
        item
          Name = 'inChangePercentAmount'
          Value = Null
          Component = FormParams
          ComponentItem = 'inChangePercentAmount'
          DataType = ftFloat
          ParamType = ptInput
        end>
    end
    object actUpdateAmountPartnerList: TMultiAction [10]
      Category = 'UpdateAmount'
      MoveParams = <>
      ActionList = <
        item
          Action = spUpdateAmountPartnerList
        end
        item
          Action = actRefresh
        end>
      QuestionBeforeExecute = 
        #1042#1099' '#1091#1074#1077#1088#1077#1085#1099' '#1074' '#1087#1077#1088#1077#1085#1086#1089#1077' '#1076#1083#1103' '#1042#1057#1045#1061' <'#1050#1086#1083'-'#1074#1086' '#1089#1086' '#1089#1082#1080#1076#1082#1086#1081' ('#1088#1072#1089#1093#1086#1076')> '#1074' <'#1050 +
        #1086#1083'-'#1074#1086' ('#1087#1088#1080#1093#1086#1076')>?'
      InfoAfterExecute = 
        #1044#1083#1103' '#1042#1057#1045#1061' <'#1050#1086#1083'-'#1074#1086' '#1089#1086' '#1089#1082#1080#1076#1082#1086#1081' ('#1088#1072#1089#1093#1086#1076')> '#1074' <'#1050#1086#1083'-'#1074#1086' ('#1087#1088#1080#1093#1086#1076')> '#1087#1077#1088#1077#1085#1077 +
        #1089#1083#1080' '#1091#1089#1087#1077#1096#1085#1086'.'
      Caption = 
        #1055#1077#1088#1077#1085#1077#1089#1090#1080' '#1076#1083#1103' '#1042#1057#1045#1061' <'#1050#1086#1083'-'#1074#1086' '#1089#1086' '#1089#1082#1080#1076#1082#1086#1081' ('#1088#1072#1089#1093#1086#1076')> '#1074' <'#1050#1086#1083'-'#1074#1086' ('#1087#1088#1080#1093#1086 +
        #1076')>'
      Hint = 
        #1055#1077#1088#1077#1085#1077#1089#1090#1080' '#1076#1083#1103' '#1042#1057#1045#1061' <'#1050#1086#1083'-'#1074#1086' '#1089#1086' '#1089#1082#1080#1076#1082#1086#1081' ('#1088#1072#1089#1093#1086#1076')> '#1074' <'#1050#1086#1083'-'#1074#1086' ('#1087#1088#1080#1093#1086 +
        #1076')>'
      ImageIndex = 41
    end
    object spUpdateAmountPartner: TdsdExecStoredProc [20]
      Category = 'UpdateAmount'
      MoveParams = <>
      PostDataSetBeforeExecute = False
      StoredProc = spUpdateMIAmountPartner
      StoredProcList = <
        item
          StoredProc = spUpdateMIAmountPartner
        end>
      Caption = 'spUpdateAmountPartner'
    end
    object spUpdateAmountPartnerList: TMultiAction [22]
      Category = 'UpdateAmount'
      MoveParams = <>
      ActionList = <
        item
          Action = spUpdateAmountPartner
        end>
      View = cxGridDBTableView
      Caption = 
        #1055#1077#1088#1077#1085#1077#1089#1090#1080' '#1076#1083#1103' '#1042#1057#1045#1061' <'#1050#1086#1083'-'#1074#1086' '#1089#1086' '#1089#1082#1080#1076#1082#1086#1081' ('#1088#1072#1089#1093#1086#1076')> '#1074' <'#1050#1086#1083'-'#1074#1086' ('#1087#1088#1080#1093#1086 +
        #1076')>'
      Hint = 
        #1055#1077#1088#1077#1085#1077#1089#1090#1080' '#1076#1083#1103' '#1042#1057#1045#1061' <'#1050#1086#1083'-'#1074#1086' '#1089#1086' '#1089#1082#1080#1076#1082#1086#1081' ('#1088#1072#1089#1093#1086#1076')> '#1074' <'#1050#1086#1083'-'#1074#1086' ('#1087#1088#1080#1093#1086 +
        #1076')>'
    end
    object actPrintDiff: TdsdPrintAction
      Category = 'DSDLib'
      MoveParams = <
        item
          FromParam.Name = 'id'
          FromParam.Value = Null
          FromParam.Component = MasterCDS
          FromParam.ComponentItem = 'id'
          ToParam.Value = Null
          ToParam.Component = FormParams
          ToParam.ComponentItem = 'Id'
          ToParam.ParamType = ptInputOutput
        end>
      StoredProc = spSelectPrintOut
      StoredProcList = <
        item
          StoredProc = spSelectPrintOut
        end>
      Caption = #1055#1077#1095#1072#1090#1100' ('#1072#1082#1090' '#1088#1072#1079#1085#1086#1075#1083#1072#1089#1080#1081')'
      Hint = #1055#1077#1095#1072#1090#1100' ('#1072#1082#1090' '#1088#1072#1079#1085#1086#1075#1083#1072#1089#1080#1081')'
      ImageIndex = 22
      ShortCut = 16464
      DataSets = <
        item
          DataSet = PrintHeaderCDS
          UserName = 'frxDBDHeader'
        end
        item
          DataSet = PrintItemsCDS
          UserName = 'frxDBDMaster'
        end>
      Params = <
        item
          Name = 'Id'
          Value = Null
          Component = FormParams
          ComponentItem = 'Id'
        end
        item
          Name = 'PrintParam'
          Value = '3'
          DataType = ftFloat
        end>
      ReportName = 'PrintMovement_SendOnPrice'
      ReportNameParam.Value = 'PrintMovement_SendOnPrice'
      ReportNameParam.DataType = ftString
      ReportNameParam.ParamType = ptInput
    end
    object actPrintOut: TdsdPrintAction
      Category = 'DSDLib'
      MoveParams = <
        item
          FromParam.Name = 'id'
          FromParam.Value = Null
          FromParam.Component = MasterCDS
          FromParam.ComponentItem = 'id'
          ToParam.Value = Null
          ToParam.Component = FormParams
          ToParam.ComponentItem = 'Id'
          ToParam.ParamType = ptInputOutput
        end>
      StoredProc = spSelectPrintOut
      StoredProcList = <
        item
          StoredProc = spSelectPrintOut
        end>
      Caption = #1055#1077#1095#1072#1090#1100' ('#1088#1072#1089#1093#1086#1076')'
      Hint = #1055#1077#1095#1072#1090#1100' ('#1088#1072#1089#1093#1086#1076')'
      ImageIndex = 19
      ShortCut = 16464
      DataSets = <
        item
          DataSet = PrintHeaderCDS
          UserName = 'frxDBDHeader'
        end
        item
          DataSet = PrintItemsCDS
          UserName = 'frxDBDMaster'
        end>
      Params = <
        item
          Name = 'Id'
          Value = Null
          Component = FormParams
          ComponentItem = 'Id'
        end
        item
          Name = 'PrintParam'
          Value = '1'
          DataType = ftFloat
        end>
      ReportName = 'PrintMovement_SendOnPrice'
      ReportNameParam.Value = 'PrintMovement_SendOnPrice'
      ReportNameParam.DataType = ftString
      ReportNameParam.ParamType = ptInput
    end
    object actPrintSaleOrder: TdsdPrintAction
      Category = 'DSDLib'
      MoveParams = <
        item
          FromParam.Name = 'id'
          FromParam.Value = Null
          FromParam.Component = MasterCDS
          FromParam.ComponentItem = 'id'
          ToParam.Value = Null
          ToParam.Component = FormParams
          ToParam.ComponentItem = 'Id'
          ToParam.ParamType = ptInputOutput
        end>
      StoredProc = spSelectPrint_SaleOrder
      StoredProcList = <
        item
          StoredProc = spSelectPrint_SaleOrder
        end>
      Caption = #1047#1072#1103#1074#1082#1072'/'#1086#1090#1075#1088#1091#1079#1082#1072
      Hint = #1047#1072#1103#1074#1082#1072'/'#1086#1090#1075#1088#1091#1079#1082#1072
      ImageIndex = 21
      ShortCut = 16464
      DataSets = <
        item
          DataSet = PrintHeaderCDS
          UserName = 'frxDBDHeader'
        end
        item
          DataSet = PrintItemsCDS
          UserName = 'frxDBDMaster'
          IndexFieldNames = 'GoodsGroupNameFull;GoodsName;GoodsKindName;PartionGoods'
        end>
      Params = <
        item
          Name = 'Id'
          Value = Null
          Component = FormParams
          ComponentItem = 'Id'
        end>
      ReportName = 'PrintMovement_Sale_Order'
      ReportNameParam.Value = 'PrintMovement_Sale_Order'
      ReportNameParam.DataType = ftString
      ReportNameParam.ParamType = ptInput
    end
    object actPrint: TdsdPrintAction
      Category = 'DSDLib'
      MoveParams = <
        item
          FromParam.Name = 'id'
          FromParam.Value = Null
          FromParam.Component = MasterCDS
          FromParam.ComponentItem = 'id'
          ToParam.Value = Null
          ToParam.Component = FormParams
          ToParam.ComponentItem = 'Id'
          ToParam.ParamType = ptInputOutput
        end>
      StoredProc = spSelectPrint
      StoredProcList = <
        item
          StoredProc = spSelectPrint
        end>
      Caption = #1055#1077#1095#1072#1090#1100' ('#1087#1088#1080#1093#1086#1076')'
      Hint = #1055#1077#1095#1072#1090#1100' ('#1087#1088#1080#1093#1086#1076')'
      ImageIndex = 3
      ShortCut = 16464
      DataSets = <
        item
          DataSet = PrintHeaderCDS
          UserName = 'frxDBDHeader'
        end
        item
          DataSet = PrintItemsCDS
          UserName = 'frxDBDMaster'
        end>
      Params = <
        item
          Name = 'Id'
          Value = Null
          Component = FormParams
          ComponentItem = 'Id'
        end
        item
          Name = 'PrintParam'
          Value = '2'
          DataType = ftFloat
        end>
      ReportName = 'PrintMovement_SendOnPrice'
      ReportNameParam.Name = #1055#1088#1080#1093#1086#1076
      ReportNameParam.Value = 'PrintMovement_SendOnPrice'
      ReportNameParam.DataType = ftString
      ReportNameParam.ParamType = ptInput
    end
  end
  inherited MasterDS: TDataSource
    Left = 64
    Top = 139
  end
  inherited MasterCDS: TClientDataSet
    Top = 139
  end
  inherited spSelect: TdsdStoredProc
    StoredProcName = 'gpSelect_Movement_SendOnPrice'
    Params = <
      item
        Name = 'instartdate'
        Value = 41640d
        Component = deStart
        DataType = ftDateTime
        ParamType = ptInput
      end
      item
        Name = 'inenddate'
        Value = 41640d
        Component = deEnd
        DataType = ftDateTime
        ParamType = ptInput
      end
      item
        Name = 'inIsPartnerDate'
        Value = 'False'
        Component = edIsPartnerDate
        DataType = ftBoolean
        ParamType = ptInput
      end
      item
        Name = 'inIsErased'
        Value = False
        Component = actShowErased
        DataType = ftBoolean
        ParamType = ptInput
      end>
    Left = 136
    Top = 163
  end
  inherited BarManager: TdxBarManager
    Left = 224
    Top = 155
    DockControlHeights = (
      0
      0
      26
      0)
    inherited Bar: TdxBar
      ItemLinks = <
        item
          Visible = True
          ItemName = 'bbInsert'
        end
        item
          Visible = True
          ItemName = 'bbEdit'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'dxBarStatic'
        end
        item
          Visible = True
          ItemName = 'bbComplete'
        end
        item
          Visible = True
          ItemName = 'bbUnComplete'
        end
        item
          Visible = True
          ItemName = 'bbDelete'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'dxBarStatic'
        end
        item
          Visible = True
          ItemName = 'bbShowErased'
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
          ItemName = 'bbMovementItemContainer'
        end
        item
          Visible = True
          ItemName = 'dxBarStatic'
        end
        item
          Visible = True
          ItemName = 'bbPrintOut'
        end
        item
          Visible = True
          ItemName = 'dxBarStatic'
        end
        item
          Visible = True
          ItemName = 'bbPrint'
        end
        item
          Visible = True
          ItemName = 'dxBarStatic'
        end
        item
          Visible = True
          ItemName = 'bbPrintDiff'
        end
        item
          Visible = True
          ItemName = 'dxBarStatic'
        end
        item
          Visible = True
          ItemName = 'bbPrintSaleOrder'
        end
        item
          Visible = True
          ItemName = 'dxBarStatic'
        end
        item
          Visible = True
          ItemName = 'bbMovementProtocol'
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
    object bbPrint: TdxBarButton
      Action = actPrint
      Category = 0
    end
    object bbPrintOut: TdxBarButton
      Action = actPrintOut
      Category = 0
    end
    object bbPrintDiff: TdxBarButton
      Action = actPrintDiff
      Category = 0
    end
    object bbPrintSaleOrder: TdxBarButton
      Action = actPrintSaleOrder
      Category = 0
    end
  end
  inherited DBViewAddOn: TdsdDBViewAddOn
    Left = 320
    Top = 224
  end
  inherited PopupMenu: TPopupMenu
    Left = 640
    Top = 152
    object N15: TMenuItem
      Caption = '-'
    end
    object N13: TMenuItem
      Action = actUpdateAmountPartnerList
    end
    object N14: TMenuItem
      Action = actUpdateAmountChangePercentList
    end
  end
  inherited PeriodChoice: TPeriodChoice
    Left = 288
    Top = 144
  end
  inherited RefreshDispatcher: TRefreshDispatcher
    ComponentList = <
      item
        Component = PeriodChoice
      end
      item
        Component = edIsPartnerDate
      end>
    Left = 408
    Top = 344
  end
  inherited spMovementComplete: TdsdStoredProc
    StoredProcName = 'gpComplete_Movement_SendOnPrice'
    Params = <
      item
        Name = 'inmovementid'
        Value = Null
        Component = MasterCDS
        ComponentItem = 'Id'
        ParamType = ptInput
      end
      item
        Name = 'inislastcomplete'
        Value = True
        DataType = ftBoolean
        ParamType = ptInput
      end>
    Left = 80
    Top = 320
  end
  inherited spMovementUnComplete: TdsdStoredProc
    StoredProcName = 'gpUnComplete_Movement_SendOnPrice'
    Params = <
      item
        Name = 'inmovementid'
        Value = Null
        Component = MasterCDS
        ComponentItem = 'Id'
        ParamType = ptInput
      end>
    Left = 80
    Top = 384
  end
  inherited spMovementSetErased: TdsdStoredProc
    StoredProcName = 'gpSetErased_Movement_SendOnPrice'
    Params = <
      item
        Name = 'inmovementid'
        Value = Null
        Component = MasterCDS
        ComponentItem = 'Id'
        ParamType = ptInput
      end>
    Left = 208
    Top = 376
  end
  inherited FormParams: TdsdFormParams
    Params = <
      item
        Name = 'Id'
        Value = Null
        ParamType = ptInputOutput
      end
      item
        Name = 'Key'
        Value = Null
        DataType = ftString
        ParamType = ptInput
      end
      item
        Name = 'ShowAll'
        Value = False
        DataType = ftBoolean
        ParamType = ptInputOutput
      end
      item
        Name = 'ReportNameSendOnPrice'
        Value = Null
        DataType = ftString
        ParamType = ptInput
      end
      item
        Name = 'ReportNameSendOnPriceTax'
        Value = Null
        DataType = ftString
        ParamType = ptInput
      end
      item
        Name = 'inChangePercentAmount'
        Value = Null
        DataType = ftFloat
        ParamType = ptInput
      end>
    Left = 400
    Top = 200
  end
  inherited spMovementReComplete: TdsdStoredProc
    StoredProcName = 'gpReComplete_Movement_SendOnPrice'
  end
  object PrintHeaderCDS: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 708
    Top = 217
  end
  object PrintItemsCDS: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 708
    Top = 270
  end
  object spSelectPrint: TdsdStoredProc
    StoredProcName = 'gpSelect_Movement_SendOnPrice_Print'
    DataSet = PrintHeaderCDS
    DataSets = <
      item
        DataSet = PrintHeaderCDS
      end
      item
        DataSet = PrintItemsCDS
      end>
    OutputType = otMultiDataSet
    Params = <
      item
        Name = 'inMovementId'
        Value = Null
        Component = FormParams
        ComponentItem = 'Id'
        ParamType = ptInput
      end
      item
        Name = 'inReportType'
        Value = '1'
        ParamType = ptUnknown
      end>
    PackSize = 1
    Left = 535
    Top = 248
  end
  object PrintItemsSverkaCDS: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 628
    Top = 294
  end
  object spSelectPrintOut: TdsdStoredProc
    StoredProcName = 'gpSelect_Movement_SendOnPrice_Print'
    DataSet = PrintHeaderCDS
    DataSets = <
      item
        DataSet = PrintHeaderCDS
      end
      item
        DataSet = PrintItemsCDS
      end>
    OutputType = otMultiDataSet
    Params = <
      item
        Name = 'inMovementId'
        Value = Null
        Component = FormParams
        ComponentItem = 'Id'
        ParamType = ptInput
      end
      item
        Name = 'inReportType'
        Value = '0'
        ParamType = ptUnknown
      end>
    PackSize = 1
    Left = 359
    Top = 440
  end
  object spSelectPrint_SaleOrder: TdsdStoredProc
    StoredProcName = 'gpSelect_Movement_Sale_Order_Print'
    DataSet = PrintHeaderCDS
    DataSets = <
      item
        DataSet = PrintHeaderCDS
      end
      item
        DataSet = PrintItemsCDS
      end>
    OutputType = otMultiDataSet
    Params = <
      item
        Name = 'inMovementId'
        Value = Null
        Component = MasterCDS
        ComponentItem = 'MovementId_Order'
        ParamType = ptInput
      end
      item
        Name = 'inMovementId_Weighing'
        Value = '0'
        ParamType = ptInput
      end
      item
        Name = 'inIsDiff'
        Value = False
        DataType = ftBoolean
        ParamType = ptInput
      end>
    PackSize = 1
    Left = 527
    Top = 152
  end
  object spUpdateMIAmountChangePercent: TdsdStoredProc
    StoredProcName = 'gpUpdate_MI_SendOnPrice_AmountChangePercent'
    DataSets = <>
    OutputType = otResult
    Params = <
      item
        Name = 'inMovementId'
        Value = Null
        Component = MasterCDS
        ComponentItem = 'Id'
        ParamType = ptInput
      end>
    PackSize = 1
    Left = 858
    Top = 264
  end
  object spUpdateMIAmountPartner: TdsdStoredProc
    StoredProcName = 'gpUpdate_MI_SendOnPrice_AmountPartner'
    DataSets = <>
    OutputType = otResult
    Params = <
      item
        Name = 'inMovementId'
        Value = Null
        Component = MasterCDS
        ComponentItem = 'Id'
        ParamType = ptInput
      end>
    PackSize = 1
    Left = 858
    Top = 216
  end
end
