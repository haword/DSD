﻿inherited PartnerEditForm: TPartnerEditForm
  Caption = #1044#1086#1073#1072#1074#1080#1090#1100'/'#1048#1079#1084#1077#1085#1080#1090#1100' <'#1050#1086#1085#1090#1088#1072#1075#1077#1085#1090#1072'>'
  ClientHeight = 446
  ClientWidth = 727
  ExplicitWidth = 733
  ExplicitHeight = 478
  PixelsPerInch = 96
  TextHeight = 13
  inherited bbOk: TcxButton
    Left = 445
    Top = 409
    TabOrder = 2
    ExplicitLeft = 445
    ExplicitTop = 409
  end
  inherited bbCancel: TcxButton
    Left = 594
    Top = 409
    ExplicitLeft = 594
    ExplicitTop = 409
  end
  object edAddress: TcxTextEdit [2]
    Left = 85
    Top = 82
    TabOrder = 0
    Width = 269
  end
  object cxLabel1: TcxLabel [3]
    Left = 16
    Top = 84
    Caption = #1040#1076#1088#1077#1089
  end
  object Код: TcxLabel [4]
    Left = 16
    Top = 3
    Caption = #1050#1086#1076
  end
  object ceCode: TcxCurrencyEdit [5]
    Left = 16
    Top = 21
    Properties.DecimalPlaces = 0
    Properties.DisplayFormat = '0'
    TabOrder = 3
    Width = 102
  end
  object cxLabel2: TcxLabel [6]
    Left = 136
    Top = 3
    Caption = #1050#1086#1076' GLN'
  end
  object edGLNCode: TcxTextEdit [7]
    Left = 136
    Top = 21
    TabOrder = 5
    Width = 218
  end
  object cxLabel3: TcxLabel [8]
    Left = 16
    Top = 53
    Caption = #1070#1088'. '#1083#1080#1094#1086
  end
  object edJuridical: TcxButtonEdit [9]
    Left = 85
    Top = 51
    Properties.Buttons = <
      item
        Default = True
        Kind = bkEllipsis
      end>
    Properties.ReadOnly = True
    TabOrder = 7
    Width = 269
  end
  object cxLabel4: TcxLabel [10]
    Left = 16
    Top = 214
    Caption = #1047#1072' '#1089#1082#1086#1083#1100#1082#1086' '#1076#1085#1077#1081' '#1087#1088#1080#1085#1080#1084#1072#1077#1090#1089#1103' '#1079#1072#1082#1072#1079
  end
  object cxLabel5: TcxLabel [11]
    Left = 381
    Top = 214
    Caption = #1063#1077#1088#1077#1079' '#1089#1082#1086#1083#1100#1082#1086' '#1076#1085#1077#1081' '#1086#1092#1086#1088#1084#1083#1103#1077#1090#1089#1103' '#1076#1086#1082'-'#1085#1086
  end
  object cxLabel6: TcxLabel [12]
    Left = 16
    Top = 244
    Caption = #1052#1072#1088#1096#1088#1091#1090
  end
  object ceRoute: TcxButtonEdit [13]
    Left = 128
    Top = 242
    Properties.Buttons = <
      item
        Default = True
        Kind = bkEllipsis
      end>
    Properties.ReadOnly = True
    TabOrder = 11
    Width = 226
  end
  object cxLabel7: TcxLabel [14]
    Left = 381
    Top = 244
    Caption = #1057#1086#1088#1090#1080#1088#1086#1074#1082#1072' '#1084#1072#1088#1096#1088#1091#1090#1072
  end
  object ceRouteSorting: TcxButtonEdit [15]
    Left = 525
    Top = 242
    Properties.Buttons = <
      item
        Default = True
        Kind = bkEllipsis
      end>
    Properties.ReadOnly = True
    TabOrder = 13
    Width = 194
  end
  object cxLabel8: TcxLabel [16]
    Left = 16
    Top = 276
    Caption = #1060#1080#1079'. '#1083#1080#1094#1086' ('#1101#1082#1089#1087#1077#1076#1080#1090#1086#1088')'
  end
  object ceMemberTake: TcxButtonEdit [17]
    Left = 160
    Top = 274
    Properties.Buttons = <
      item
        Default = True
        Kind = bkEllipsis
      end>
    Properties.ReadOnly = True
    TabOrder = 15
    Width = 194
  end
  object cePrepareDayCount: TcxCurrencyEdit [18]
    Left = 254
    Top = 212
    Properties.Alignment.Horz = taRightJustify
    Properties.Alignment.Vert = taVCenter
    Properties.DecimalPlaces = 0
    Properties.DisplayFormat = '0'
    Properties.EditFormat = '0'
    TabOrder = 16
    Width = 100
  end
  object ceDocumentDayCount: TcxCurrencyEdit [19]
    Left = 619
    Top = 212
    Properties.Alignment.Horz = taRightJustify
    Properties.Alignment.Vert = taVCenter
    Properties.DecimalPlaces = 0
    Properties.DisplayFormat = '0'
    Properties.EditFormat = '0'
    TabOrder = 17
    Width = 100
  end
  object cxLabel9: TcxLabel [20]
    Left = 16
    Top = 371
    Caption = #1055#1088#1072#1081#1089'-'#1083#1080#1089#1090
  end
  object cxLabel10: TcxLabel [21]
    Left = 381
    Top = 371
    Caption = #1055#1088#1072#1081#1089'-'#1083#1080#1089#1090' ('#1040#1082#1094#1080#1086#1085#1085#1099#1081')'
  end
  object cePriceList: TcxButtonEdit [22]
    Left = 160
    Top = 369
    Properties.Buttons = <
      item
        Default = True
        Kind = bkEllipsis
      end>
    Properties.ReadOnly = True
    TabOrder = 22
    Width = 194
  end
  object cePriceListPromo: TcxButtonEdit [23]
    Left = 525
    Top = 369
    Properties.Buttons = <
      item
        Default = True
        Kind = bkEllipsis
      end>
    Properties.ReadOnly = True
    TabOrder = 23
    Width = 194
  end
  object cxLabel11: TcxLabel [24]
    Left = 54
    Top = 393
    Caption = #1044#1072#1090#1072' '#1085#1072#1095#1072#1083#1072' '#1072#1082#1094#1080#1080
  end
  object cxLabel12: TcxLabel [25]
    Left = 198
    Top = 393
    Caption = #1044#1072#1090#1072' '#1086#1082#1086#1085#1095#1072#1085#1080#1103' '#1072#1082#1094#1080#1080
  end
  object edStartPromo: TcxDateEdit [26]
    Left = 56
    Top = 411
    EditValue = 0d
    Properties.SaveTime = False
    Properties.ShowTime = False
    Properties.ValidateOnEnter = False
    TabOrder = 26
    Width = 100
  end
  object edEndPromo: TcxDateEdit [27]
    Left = 198
    Top = 411
    EditValue = 0d
    Properties.SaveTime = False
    Properties.ShowTime = False
    Properties.ValidateOnEnter = False
    TabOrder = 27
    Width = 100
  end
  object cxLabel13: TcxLabel [28]
    Left = 16
    Top = 113
    Caption = #1055#1088#1080#1084#1077#1095#1072#1085#1080#1077
  end
  object edShortName: TcxTextEdit [29]
    Left = 85
    Top = 111
    Enabled = False
    TabOrder = 29
    Width = 269
  end
  object cxLabel14: TcxLabel [30]
    Left = 16
    Top = 142
    Caption = #1059#1083#1080#1094#1072
  end
  object cxLabel15: TcxLabel [31]
    Left = 16
    Top = 165
    Caption = #1044#1086#1084
  end
  object cxLabel16: TcxLabel [32]
    Left = 140
    Top = 165
    Caption = #1050#1086#1088#1087#1091#1089
  end
  object cxLabel17: TcxLabel [33]
    Left = 254
    Top = 165
    Caption = #1050#1074#1072#1088#1090#1080#1088#1072
  end
  object ceStreet: TcxButtonEdit [34]
    Left = 85
    Top = 140
    Enabled = False
    Properties.Buttons = <
      item
        Default = True
        Kind = bkEllipsis
      end>
    Properties.ReadOnly = True
    TabOrder = 34
    Width = 269
  end
  object edHouseNumber: TcxTextEdit [35]
    Left = 16
    Top = 182
    Enabled = False
    TabOrder = 35
    Width = 100
  end
  object edCaseNumber: TcxTextEdit [36]
    Left = 140
    Top = 182
    Enabled = False
    TabOrder = 36
    Width = 100
  end
  object edRoomNumber: TcxTextEdit [37]
    Left = 254
    Top = 182
    Enabled = False
    TabOrder = 37
    Width = 100
  end
  object cxLabel18: TcxLabel [38]
    Left = 381
    Top = 275
    Caption = #1060#1080#1079'. '#1083#1080#1094#1086' ('#1086#1090#1074#1077#1090#1089#1090#1074#1077#1085#1085#1099#1081')'
  end
  object ceMember: TcxButtonEdit [39]
    Left = 525
    Top = 274
    Properties.Buttons = <
      item
        Default = True
        Kind = bkEllipsis
      end>
    Properties.ReadOnly = True
    TabOrder = 39
    Width = 194
  end
  object cxLabel19: TcxLabel [40]
    Left = 16
    Top = 306
    Caption = #1060#1080#1079'. '#1083#1080#1094#1086' ('#1090#1086#1088#1075#1086#1074#1099#1081')'
  end
  object ceMemberTrade: TcxButtonEdit [41]
    Left = 160
    Top = 305
    Properties.Buttons = <
      item
        Default = True
        Kind = bkEllipsis
      end>
    Properties.ReadOnly = True
    TabOrder = 41
    Width = 194
  end
  object cxLabel20: TcxLabel [42]
    Left = 16
    Top = 338
    Caption = #1056#1077#1075#1080#1086#1085
  end
  object ceArea: TcxButtonEdit [43]
    Left = 160
    Top = 337
    Properties.Buttons = <
      item
        Default = True
        Kind = bkEllipsis
      end>
    Properties.ReadOnly = True
    TabOrder = 43
    Width = 194
  end
  object cxLabel21: TcxLabel [44]
    Left = 381
    Top = 338
    Caption = #1055#1088#1080#1079#1085#1072#1082' '#1090#1086#1088#1075#1086#1074#1086#1081' '#1090#1086#1095#1082#1080
  end
  object cePartnerTag: TcxButtonEdit [45]
    Left = 525
    Top = 337
    Properties.Buttons = <
      item
        Default = True
        Kind = bkEllipsis
      end>
    Properties.ReadOnly = True
    TabOrder = 45
    Width = 194
  end
  inherited UserSettingsStorageAddOn: TdsdUserSettingsStorageAddOn
    Left = 99
    Top = 65531
  end
  inherited cxPropertiesStore: TcxPropertiesStore
    Left = 384
    Top = 398
  end
  inherited ActionList: TActionList
    Left = 79
    Top = 130
  end
  inherited FormParams: TdsdFormParams
    Params = <
      item
        Name = 'Id'
        Value = '0'
        ParamType = ptInput
      end
      item
        Name = 'JuridicalId'
        Value = ''
        ParamType = ptInput
      end
      item
        Name = 'Key'
        Value = '0'
        Component = FormParams
        ComponentItem = 'Id'
      end
      item
        Name = 'TextValue'
        Value = ''
        Component = edAddress
        DataType = ftString
      end
      item
        Name = 'PartnerName'
        Value = Null
        DataType = ftString
      end>
    Left = 256
    Top = 72
  end
  inherited spInsertUpdate: TdsdStoredProc
    StoredProcName = 'gpInsertUpdate_Object_Partner'
    Params = <
      item
        Name = 'ioId'
        Value = '0'
        Component = FormParams
        ComponentItem = 'Id'
        ParamType = ptInputOutput
      end
      item
        Name = 'inAddress'
        Value = ''
        Component = edAddress
        DataType = ftString
        ParamType = ptInput
      end
      item
        Name = 'outPartnerName'
        Value = Null
        Component = FormParams
        ComponentItem = 'PartnerName'
        DataType = ftString
      end
      item
        Name = 'inCode'
        Value = 0.000000000000000000
        Component = ceCode
        ParamType = ptInput
      end
      item
        Name = 'inShortName'
        Value = ''
        Component = edShortName
        DataType = ftString
        ParamType = ptInput
      end
      item
        Name = 'inGLNCode'
        Value = ''
        Component = edGLNCode
        DataType = ftString
        ParamType = ptInput
      end
      item
        Name = 'inHouseNumber'
        Value = ''
        Component = edHouseNumber
        DataType = ftString
        ParamType = ptInput
      end
      item
        Name = 'inCaseNumber'
        Value = ''
        Component = edCaseNumber
        DataType = ftString
        ParamType = ptInput
      end
      item
        Name = 'inRoomNumber'
        Value = ''
        Component = edRoomNumber
        DataType = ftString
        ParamType = ptInput
      end
      item
        Name = 'inStreetId'
        Value = ''
        Component = StreetGuides
        ComponentItem = 'Key'
        ParamType = ptInput
      end
      item
        Name = 'inPrepareDayCount'
        Value = 0.000000000000000000
        Component = cePrepareDayCount
        DataType = ftFloat
        ParamType = ptInput
      end
      item
        Name = 'inDocumentDayCount'
        Value = 0.000000000000000000
        Component = ceDocumentDayCount
        DataType = ftFloat
        ParamType = ptInput
      end
      item
        Name = 'inJuridicalId'
        Value = ''
        Component = dsdJuridicalGuides
        ComponentItem = 'JuridicalId'
        ParamType = ptInput
      end
      item
        Name = 'inRouteId'
        Value = ''
        Component = dsdRouteGuides
        ComponentItem = 'Key'
        ParamType = ptInput
      end
      item
        Name = 'inRouteSortingId'
        Value = ''
        Component = dsdRouteSortingGuides
        ComponentItem = 'Key'
        ParamType = ptInput
      end
      item
        Name = 'inMemberTakeId'
        Value = ''
        Component = dsdMemberTakeGuides
        ComponentItem = 'Key'
        ParamType = ptInput
      end
      item
        Name = 'inMemberId'
        Value = ''
        Component = MemberGuides
        ComponentItem = 'Key'
        ParamType = ptInput
      end
      item
        Name = 'inMemberTradeId'
        Value = ''
        Component = MemberTradeGuides
        ComponentItem = 'Key'
        ParamType = ptInput
      end
      item
        Name = 'inAreaId'
        Value = ''
        Component = AreaGuides
        ComponentItem = 'Key'
        ParamType = ptInput
      end
      item
        Name = 'inPartnerTagId'
        Value = ''
        Component = PartnerTagGuides
        ComponentItem = 'Key'
        ParamType = ptInput
      end
      item
        Name = 'inPriceListId'
        Value = ''
        Component = dsdPriceListGuides
        ComponentItem = 'Key'
        ParamType = ptInput
      end
      item
        Name = 'inPriceListPromoId'
        Value = ''
        Component = dsdPriceListPromoGuides
        ComponentItem = 'Key'
        ParamType = ptInput
      end
      item
        Name = 'inStartPromo'
        Value = 0d
        Component = edStartPromo
        DataType = ftDateTime
        ParamType = ptInput
      end
      item
        Name = 'inEndPromo'
        Value = 0d
        Component = edEndPromo
        DataType = ftDateTime
        ParamType = ptInput
      end>
    Left = 312
    Top = 398
  end
  inherited spGet: TdsdStoredProc
    StoredProcName = 'gpGet_Object_Partner'
    Params = <
      item
        Name = 'inId'
        Value = '0'
        Component = FormParams
        ComponentItem = 'Id'
        ParamType = ptInput
      end
      item
        Name = 'inJuridicalId'
        Value = ''
        Component = FormParams
        ComponentItem = 'JuridicalId'
        ParamType = ptInput
      end
      item
        Name = 'Code'
        Value = 0.000000000000000000
        Component = ceCode
      end
      item
        Name = 'ShortName'
        Value = ''
        Component = edShortName
        DataType = ftString
      end
      item
        Name = 'GLNCode'
        Value = ''
        Component = edGLNCode
        DataType = ftString
      end
      item
        Name = 'Address'
        Value = ''
        Component = edAddress
        DataType = ftString
      end
      item
        Name = 'HouseNumber'
        Value = ''
        Component = edHouseNumber
        DataType = ftString
      end
      item
        Name = 'CaseNumber'
        Value = ''
        Component = edCaseNumber
        DataType = ftString
      end
      item
        Name = 'RoomNumber'
        Value = ''
        Component = edRoomNumber
        DataType = ftString
      end
      item
        Name = 'StreetId'
        Value = ''
        Component = StreetGuides
        ComponentItem = 'Key'
      end
      item
        Name = 'StreetName'
        Value = ''
        Component = StreetGuides
        ComponentItem = 'TextValue'
        DataType = ftString
      end
      item
        Name = 'PrepareDayCount'
        Value = 0.000000000000000000
        Component = cePrepareDayCount
        DataType = ftFloat
      end
      item
        Name = 'DocumentDayCount'
        Value = 0.000000000000000000
        Component = ceDocumentDayCount
        DataType = ftFloat
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
        Name = 'RouteId'
        Value = ''
        Component = dsdRouteGuides
        ComponentItem = 'Key'
        DataType = ftString
      end
      item
        Name = 'RouteName'
        Value = ''
        Component = dsdRouteGuides
        ComponentItem = 'TextValue'
        DataType = ftString
      end
      item
        Name = 'RouteSortingId'
        Value = ''
        Component = dsdRouteSortingGuides
        ComponentItem = 'Key'
        DataType = ftString
      end
      item
        Name = 'RouteSortingName'
        Value = ''
        Component = dsdRouteSortingGuides
        ComponentItem = 'TextValue'
        DataType = ftString
      end
      item
        Name = 'MemberTakeId'
        Value = ''
        Component = dsdMemberTakeGuides
        ComponentItem = 'Key'
        DataType = ftString
      end
      item
        Name = 'MemberTakeName'
        Value = ''
        Component = dsdMemberTakeGuides
        ComponentItem = 'TextValue'
        DataType = ftString
      end
      item
        Name = 'MemberId'
        Value = ''
        Component = MemberGuides
        ComponentItem = 'Key'
      end
      item
        Name = 'MemberName'
        Value = ''
        Component = MemberGuides
        ComponentItem = 'TextValue'
        DataType = ftString
      end
      item
        Name = 'MemberTradeId'
        Value = ''
        Component = MemberTradeGuides
        ComponentItem = 'Key'
      end
      item
        Name = 'MemberTradeName'
        Value = ''
        Component = MemberTradeGuides
        ComponentItem = 'TextValue'
        DataType = ftString
      end
      item
        Name = 'AreaId'
        Value = ''
        Component = AreaGuides
        ComponentItem = 'Key'
      end
      item
        Name = 'AreaName'
        Value = ''
        Component = AreaGuides
        ComponentItem = 'TextValue'
        DataType = ftString
      end
      item
        Name = 'PartnerTagId'
        Value = ''
        Component = PartnerTagGuides
        ComponentItem = 'Key'
      end
      item
        Name = 'PartnerTagName'
        Value = ''
        Component = PartnerTagGuides
        ComponentItem = 'TextValue'
        DataType = ftString
      end
      item
        Name = 'PriceListId'
        Value = ''
        Component = dsdPriceListGuides
        ComponentItem = 'Key'
      end
      item
        Name = 'PriceListName'
        Value = ''
        Component = dsdPriceListGuides
        ComponentItem = 'TextValue'
        DataType = ftString
      end
      item
        Name = 'PriceListPromoId'
        Value = ''
        Component = dsdPriceListPromoGuides
        ComponentItem = 'Key'
      end
      item
        Name = 'PriceListPromoName'
        Value = ''
        Component = dsdPriceListPromoGuides
        ComponentItem = 'TextValue'
        DataType = ftString
      end
      item
        Name = 'StartPromo'
        Value = 0d
        Component = edStartPromo
        DataType = ftDateTime
      end
      item
        Name = 'EndPromo'
        Value = 0d
        Component = edEndPromo
        DataType = ftDateTime
      end>
    Left = 352
    Top = 379
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
        DataType = ftString
        ParamType = ptInput
      end
      item
        Name = 'TextValue'
        Value = ''
        Component = dsdJuridicalGuides
        ComponentItem = 'TextValue'
        DataType = ftString
        ParamType = ptInput
      end>
    Left = 160
    Top = 40
  end
  object dsdMemberTakeGuides: TdsdGuides
    KeyField = 'Id'
    LookupControl = ceMemberTake
    FormNameParam.Value = 'TMember_ObjectForm'
    FormNameParam.DataType = ftString
    FormName = 'TMember_ObjectForm'
    PositionDataSet = 'ClientDataSet'
    Params = <
      item
        Name = 'Key'
        Value = ''
        Component = dsdMemberTakeGuides
        ComponentItem = 'Key'
        DataType = ftString
        ParamType = ptInput
      end
      item
        Name = 'TextValue'
        Value = ''
        Component = dsdMemberTakeGuides
        ComponentItem = 'TextValue'
        DataType = ftString
        ParamType = ptInput
      end>
    Left = 272
    Top = 251
  end
  object dsdRouteSortingGuides: TdsdGuides
    KeyField = 'Id'
    LookupControl = ceRouteSorting
    FormNameParam.Value = 'TRouteSortingForm'
    FormNameParam.DataType = ftString
    FormName = 'TRouteSortingForm'
    PositionDataSet = 'ClientDataSet'
    Params = <
      item
        Name = 'Key'
        Value = ''
        Component = dsdRouteSortingGuides
        ComponentItem = 'Key'
        DataType = ftString
        ParamType = ptInput
      end
      item
        Name = 'TextValue'
        Value = ''
        Component = dsdRouteSortingGuides
        ComponentItem = 'TextValue'
        DataType = ftString
        ParamType = ptInput
      end>
    Left = 520
    Top = 227
  end
  object dsdRouteGuides: TdsdGuides
    KeyField = 'Id'
    LookupControl = ceRoute
    FormNameParam.Value = 'TRouteForm'
    FormNameParam.DataType = ftString
    FormName = 'TRouteForm'
    PositionDataSet = 'ClientDataSet'
    Params = <
      item
        Name = 'Key'
        Value = ''
        Component = dsdRouteGuides
        ComponentItem = 'Key'
        DataType = ftString
        ParamType = ptInput
      end
      item
        Name = 'TextValue'
        Value = ''
        Component = dsdRouteGuides
        ComponentItem = 'TextValue'
        DataType = ftString
        ParamType = ptInput
      end>
    Left = 200
    Top = 235
  end
  object dsdPriceListGuides: TdsdGuides
    KeyField = 'Id'
    LookupControl = cePriceList
    FormNameParam.Value = 'TPriceListForm'
    FormNameParam.DataType = ftString
    FormName = 'TPriceListForm'
    PositionDataSet = 'ClientDataSet'
    Params = <
      item
        Name = 'Key'
        Value = ''
        Component = dsdPriceListGuides
        ComponentItem = 'Key'
        DataType = ftString
        ParamType = ptInput
      end
      item
        Name = 'TextValue'
        Value = ''
        Component = dsdPriceListGuides
        ComponentItem = 'TextValue'
        DataType = ftString
        ParamType = ptInput
      end>
    Left = 200
    Top = 371
  end
  object dsdPriceListPromoGuides: TdsdGuides
    KeyField = 'Id'
    LookupControl = cePriceListPromo
    FormNameParam.Value = 'TPriceListForm'
    FormNameParam.DataType = ftString
    FormName = 'TPriceListForm'
    PositionDataSet = 'ClientDataSet'
    Params = <
      item
        Name = 'Key'
        Value = ''
        Component = dsdPriceListPromoGuides
        ComponentItem = 'Key'
        DataType = ftString
        ParamType = ptInput
      end
      item
        Name = 'TextValue'
        Value = ''
        Component = dsdPriceListPromoGuides
        ComponentItem = 'TextValue'
        DataType = ftString
        ParamType = ptInput
      end>
    Left = 560
    Top = 371
  end
  object StreetGuides: TdsdGuides
    KeyField = 'Id'
    LookupControl = ceStreet
    FormNameParam.Value = 'TStreetForm'
    FormNameParam.DataType = ftString
    FormName = 'TStreetForm'
    PositionDataSet = 'ClientDataSet'
    Params = <
      item
        Name = 'Key'
        Value = ''
        Component = StreetGuides
        ComponentItem = 'Key'
        ParamType = ptInput
      end
      item
        Name = 'TextValue'
        Value = ''
        Component = StreetGuides
        ComponentItem = 'TextValue'
        DataType = ftString
        ParamType = ptInput
      end>
    Left = 176
    Top = 115
  end
  object MemberGuides: TdsdGuides
    KeyField = 'Id'
    LookupControl = ceMember
    FormNameParam.Value = 'TMember_ObjectForm'
    FormNameParam.DataType = ftString
    FormName = 'TMember_ObjectForm'
    PositionDataSet = 'ClientDataSet'
    Params = <
      item
        Name = 'Key'
        Value = ''
        Component = MemberGuides
        ComponentItem = 'Key'
        DataType = ftString
        ParamType = ptInput
      end
      item
        Name = 'TextValue'
        Value = ''
        Component = MemberGuides
        ComponentItem = 'TextValue'
        DataType = ftString
        ParamType = ptInput
      end>
    Left = 608
    Top = 259
  end
  object MemberTradeGuides: TdsdGuides
    KeyField = 'Id'
    LookupControl = ceMemberTrade
    FormNameParam.Value = 'TMember_ObjectForm'
    FormNameParam.DataType = ftString
    FormName = 'TMember_ObjectForm'
    PositionDataSet = 'ClientDataSet'
    Params = <
      item
        Name = 'Key'
        Value = ''
        Component = MemberTradeGuides
        ComponentItem = 'Key'
        DataType = ftString
        ParamType = ptInput
      end
      item
        Name = 'TextValue'
        Value = ''
        Component = MemberTradeGuides
        ComponentItem = 'TextValue'
        DataType = ftString
        ParamType = ptInput
      end>
    Left = 184
    Top = 283
  end
  object AreaGuides: TdsdGuides
    KeyField = 'Id'
    LookupControl = ceArea
    FormNameParam.Value = 'TAreaForm'
    FormNameParam.DataType = ftString
    FormName = 'TAreaForm'
    PositionDataSet = 'ClientDataSet'
    Params = <
      item
        Name = 'Key'
        Value = ''
        Component = AreaGuides
        ComponentItem = 'Key'
        DataType = ftString
        ParamType = ptInput
      end
      item
        Name = 'TextValue'
        Value = ''
        Component = AreaGuides
        ComponentItem = 'TextValue'
        DataType = ftString
        ParamType = ptInput
      end>
    Left = 248
    Top = 331
  end
  object PartnerTagGuides: TdsdGuides
    KeyField = 'Id'
    LookupControl = cePartnerTag
    FormNameParam.Value = 'TPartnerTagForm'
    FormNameParam.DataType = ftString
    FormName = 'TPartnerTagForm'
    PositionDataSet = 'ClientDataSet'
    Params = <
      item
        Name = 'Key'
        Value = ''
        Component = PartnerTagGuides
        ComponentItem = 'Key'
        DataType = ftString
        ParamType = ptInput
      end
      item
        Name = 'TextValue'
        Value = ''
        Component = PartnerTagGuides
        ComponentItem = 'TextValue'
        DataType = ftString
        ParamType = ptInput
      end>
    Left = 592
    Top = 323
  end
end
