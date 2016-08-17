object Module: TModule
  OldCreateOrder = False
  Height = 387
  Width = 706
  object mtPerson: TFDMemTable
    FieldDefs = <
      item
        Name = 'PersonID'
        DataType = ftAutoInc
      end
      item
        Name = 'ClientID'
        DataType = ftInteger
      end
      item
        Name = 'FirstName'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'LastName'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'Notes'
        DataType = ftString
        Size = 20
      end>
    CachedUpdates = True
    IndexDefs = <>
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    UpdateOptions.KeyFields = 'PersonID'
    UpdateOptions.AutoIncFields = 'PersonID'
    StoreDefs = True
    Left = 88
    Top = 120
    object mtPersonPersonID: TFDAutoIncField
      FieldName = 'PersonID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      IdentityInsert = True
    end
    object mtPersonClientID: TIntegerField
      FieldName = 'ClientID'
    end
    object mtPersonFirstName: TStringField
      FieldName = 'FirstName'
    end
    object mtPersonLastName: TStringField
      FieldName = 'LastName'
    end
    object mtPersonNotes: TStringField
      FieldName = 'Notes'
    end
  end
  object mtRental: TFDMemTable
    FieldDefs = <>
    CachedUpdates = True
    IndexDefs = <>
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    UpdateOptions.KeyFields = 'RentID'
    UpdateOptions.AutoIncFields = 'RentID'
    StoreDefs = True
    Left = 216
    Top = 64
    object mtRentalRentID: TFDAutoIncField
      FieldName = 'RentID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      IdentityInsert = True
    end
    object mtRentalBookID: TIntegerField
      FieldName = 'BookID'
    end
    object mtRentalStartDate: TDateTimeField
      FieldName = 'StartDate'
    end
    object mtRentalEndDate: TDateTimeField
      FieldName = 'EndDate'
    end
    object mtRentalOccupants: TIntegerField
      FieldName = 'Occupants'
    end
    object mtRentalCharges: TFloatField
      FieldName = 'Charges'
    end
    object mtRentalRate: TFloatField
      FieldName = 'Rate'
    end
    object mtRentalComment: TStringField
      FieldName = 'Comment'
      Size = 30
    end
    object mtRentalDiscountDesc: TStringField
      FieldName = 'DiscountDesc'
      Size = 50
    end
    object mtRentalDiscountAmt: TFloatField
      FieldName = 'DiscountAmt'
    end
  end
  object mtPayments: TFDMemTable
    FieldDefs = <
      item
        Name = 'PayID'
        DataType = ftAutoInc
      end
      item
        Name = 'BookID'
        DataType = ftInteger
      end
      item
        Name = 'PayDate'
        DataType = ftDateTime
      end
      item
        Name = 'AmtPaid'
        DataType = ftFloat
      end
      item
        Name = 'Currency'
        DataType = ftString
        Size = 5
      end
      item
        Name = 'Conversion'
        DataType = ftFloat
      end
      item
        Name = 'AmtRecvd'
        DataType = ftFloat
      end
      item
        Name = 'PayMethod'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'PayType'
        DataType = ftString
        Size = 16
      end
      item
        Name = 'PayNote'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'BankID'
        DataType = ftInteger
      end>
    CachedUpdates = True
    IndexDefs = <>
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    UpdateOptions.KeyFields = 'PayID'
    UpdateOptions.AutoIncFields = 'PayID'
    StoreDefs = True
    Left = 24
    Top = 64
    object mtPaymentsPayID: TFDAutoIncField
      FieldName = 'PayID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      IdentityInsert = True
    end
    object mtPaymentsBookID: TIntegerField
      FieldName = 'BookID'
    end
    object mtPaymentsPayDate: TDateTimeField
      FieldName = 'PayDate'
    end
    object mtPaymentsAmtPaid: TFloatField
      FieldName = 'AmtPaid'
    end
    object mtPaymentsCurrency: TStringField
      FieldName = 'Currency'
      Size = 5
    end
    object mtPaymentsConversion: TFloatField
      FieldName = 'Conversion'
    end
    object mtPaymentsAmtRecvd: TFloatField
      FieldName = 'AmtRecvd'
    end
    object mtPaymentsPayMethod: TStringField
      FieldName = 'PayMethod'
    end
    object mtPaymentsPayType: TStringField
      FieldName = 'PayType'
      Size = 16
    end
    object mtPaymentsPayNote: TStringField
      FieldName = 'PayNote'
    end
    object mtPaymentsBankID: TIntegerField
      FieldName = 'BankID'
    end
  end
  object mtTravel: TFDMemTable
    FieldDefs = <
      item
        Name = 'TravelID'
        DataType = ftAutoInc
      end
      item
        Name = 'BookID'
        DataType = ftInteger
      end
      item
        Name = 'TravelMethod'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'TravelInfo'
        DataType = ftString
        Size = 25
      end
      item
        Name = 'ArrivalDate'
        DataType = ftDateTime
      end
      item
        Name = 'TravelNote'
        DataType = ftString
        Size = 45
      end>
    CachedUpdates = True
    IndexDefs = <>
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    UpdateOptions.KeyFields = 'TravelID'
    UpdateOptions.AutoIncFields = 'TravelID'
    StoreDefs = True
    Left = 88
    Top = 64
    object mtTravelTravelID: TFDAutoIncField
      FieldName = 'TravelID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      IdentityInsert = True
    end
    object mtTravelBookID: TIntegerField
      FieldName = 'BookID'
    end
    object mtTravelTravelMethod: TStringField
      FieldName = 'TravelMethod'
    end
    object mtTravelTravelInfo: TStringField
      FieldName = 'TravelInfo'
      Size = 25
    end
    object mtTravelArrivalDate: TDateTimeField
      FieldName = 'ArrivalDate'
    end
    object mtTravelTravelNote: TStringField
      FieldName = 'TravelNote'
      Size = 45
    end
  end
  object mtClient: TFDMemTable
    FieldDefs = <>
    CachedUpdates = True
    IndexDefs = <>
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    UpdateOptions.KeyFields = 'ClientID'
    UpdateOptions.AutoIncFields = 'ClientID'
    StoreDefs = True
    Left = 24
    Top = 120
    object mtClientClientID: TFDAutoIncField
      FieldName = 'ClientID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      IdentityInsert = True
    end
    object mtClientDateEntered: TDateTimeField
      FieldName = 'DateEntered'
    end
    object mtClientActive: TSmallintField
      FieldName = 'Active'
      Required = True
    end
    object mtClientAddress: TStringField
      FieldName = 'Address'
      Size = 40
    end
    object mtClientCity: TStringField
      FieldName = 'City'
    end
    object mtClientProvState: TStringField
      FieldName = 'ProvState'
      Size = 15
    end
    object mtClientCountry: TStringField
      FieldName = 'Country'
      Size = 15
    end
    object mtClientPostalZip: TStringField
      FieldName = 'PostalZip'
      Size = 10
    end
    object mtClientNotes: TBlobField
      FieldName = 'Notes'
    end
    object mtClientModified: TDateTimeField
      FieldName = 'Modified'
    end
  end
  object mtContact: TFDMemTable
    FieldDefs = <>
    CachedUpdates = True
    IndexDefs = <>
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    UpdateOptions.KeyFields = 'ContactID'
    UpdateOptions.AutoIncFields = 'ContactID'
    StoreDefs = True
    Left = 152
    Top = 120
    object mtContactContactID: TFDAutoIncField
      FieldName = 'ContactID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      IdentityInsert = True
    end
    object mtContactPersonID: TIntegerField
      FieldName = 'PersonID'
    end
    object mtContactContactType: TStringField
      FieldName = 'ContactType'
      Size = 15
    end
    object mtContactPhone: TStringField
      FieldName = 'Phone'
      Size = 80
    end
    object mtContactEmail: TStringField
      FieldName = 'Email'
      Size = 80
    end
  end
  object mtBooking: TFDMemTable
    FieldDefs = <>
    CachedUpdates = True
    IndexDefs = <>
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    FormatOptions.AssignedValues = [fvMapRules, fvDataSnapCompatibility]
    FormatOptions.OwnMapRules = True
    FormatOptions.MapRules = <
      item
        SourceDataType = dtSingle
        TargetDataType = dtDouble
      end>
    FormatOptions.DataSnapCompatibility = True
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    UpdateOptions.KeyFields = 'BookingID'
    UpdateOptions.AutoIncFields = 'BookingID'
    StoreDefs = True
    Left = 24
    Top = 8
    object mtBookingBookingID: TFDAutoIncField
      FieldName = 'BookingID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      IdentityInsert = True
    end
    object mtBookingClientID: TIntegerField
      FieldName = 'ClientID'
    end
    object mtBookingDateCalled: TDateTimeField
      FieldName = 'DateCalled'
    end
    object mtBookingInvoiceDate: TDateTimeField
      FieldName = 'InvoiceDate'
    end
    object mtBookingVoucherDate: TDateTimeField
      FieldName = 'VoucherDate'
    end
    object mtBookingDepositDueDate: TDateTimeField
      FieldName = 'DepositDueDate'
    end
    object mtBookingCurrency: TStringField
      FieldName = 'Currency'
      Size = 5
    end
    object mtBookingCharges: TFloatField
      FieldName = 'Charges'
    end
    object mtBookingDepositAmt: TFloatField
      FieldName = 'DepositAmt'
    end
    object mtBookingAmtPaid: TFloatField
      FieldName = 'AmtPaid'
    end
    object mtBookingStatus: TStringField
      FieldName = 'Status'
      Size = 10
    end
    object mtBookingAcctgNotes: TBlobField
      FieldName = 'AcctgNotes'
    end
    object mtBookingServiceNotes: TBlobField
      FieldName = 'ServiceNotes'
    end
    object mtBookingPersonId: TIntegerField
      FieldName = 'PersonId'
    end
    object mtBookingCreatedBy: TStringField
      FieldName = 'CreatedBy'
    end
    object mtBookingModified: TDateTimeField
      FieldName = 'Modified'
    end
    object mtBookingStartDate: TDateTimeField
      FieldName = 'StartDate'
    end
    object mtBookingEndDate: TDateTimeField
      FieldName = 'EndDate'
    end
  end
  object mtRentAccom: TFDMemTable
    FieldDefs = <
      item
        Name = 'RentID'
        DataType = ftInteger
      end
      item
        Name = 'AccomID'
        DataType = ftInteger
      end>
    CachedUpdates = True
    IndexDefs = <>
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    UpdateOptions.KeyFields = 'AccomID;RentID'
    StoreDefs = True
    Left = 152
    Top = 64
  end
  object FDStanStorageJSONLink1: TFDStanStorageJSONLink
    Left = 352
    Top = 8
  end
  object FDStanStorageBinLink1: TFDStanStorageBinLink
    Left = 488
    Top = 8
  end
  object mtBank: TFDMemTable
    FieldDefs = <
      item
        Name = 'BankID'
        DataType = ftInteger
      end
      item
        Name = 'BankName'
        DataType = ftString
        Size = 20
      end>
    IndexDefs = <>
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    StoreDefs = True
    Left = 24
    Top = 232
  end
  object mtAccom: TFDMemTable
    Active = True
    FieldDefs = <
      item
        Name = 'AccomID'
        DataType = ftInteger
      end
      item
        Name = 'AccomName'
        DataType = ftString
        Size = 30
      end
      item
        Name = 'SubID'
        DataType = ftInteger
      end>
    IndexDefs = <>
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    StoreDefs = True
    Left = 88
    Top = 232
  end
  object mtSearchFirst: TFDMemTable
    FieldDefs = <
      item
        Name = 'ClientID'
        DataType = ftInteger
      end
      item
        Name = 'City'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'ProvState'
        DataType = ftString
        Size = 15
      end
      item
        Name = 'Country'
        DataType = ftString
        Size = 25
      end
      item
        Name = 'Notes'
        DataType = ftBlob
      end>
    IndexDefs = <>
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    StoreDefs = True
    Left = 240
    Top = 232
  end
  object mtSearchPerson: TFDMemTable
    Active = True
    FieldDefs = <
      item
        Name = 'PersonID'
        DataType = ftInteger
      end
      item
        Name = 'ClientID'
        DataType = ftInteger
      end
      item
        Name = 'LastName'
        DataType = ftString
        Size = 25
      end
      item
        Name = 'FirstName'
        DataType = ftString
        Size = 30
      end>
    IndexDefs = <>
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    StoreDefs = True
    Left = 240
    Top = 184
  end
  object mtSearchLast: TFDMemTable
    FieldDefs = <
      item
        Name = 'ClientID'
        DataType = ftInteger
      end
      item
        Name = 'City'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'ProvState'
        DataType = ftString
        Size = 15
      end
      item
        Name = 'Country'
        DataType = ftString
        Size = 25
      end
      item
        Name = 'Notes'
        DataType = ftBlob
      end>
    IndexDefs = <>
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    StoreDefs = True
    Left = 320
    Top = 232
  end
  object mtSearchCity: TFDMemTable
    FieldDefs = <
      item
        Name = 'ClientID'
        DataType = ftInteger
      end
      item
        Name = 'City'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'ProvState'
        DataType = ftString
        Size = 15
      end
      item
        Name = 'Country'
        DataType = ftString
        Size = 25
      end
      item
        Name = 'Notes'
        DataType = ftBlob
      end>
    IndexDefs = <>
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    StoreDefs = True
    Left = 400
    Top = 232
  end
  object mtSearchCountry: TFDMemTable
    FieldDefs = <
      item
        Name = 'ClientID'
        DataType = ftInteger
      end
      item
        Name = 'City'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'ProvState'
        DataType = ftString
        Size = 15
      end
      item
        Name = 'Country'
        DataType = ftString
        Size = 25
      end
      item
        Name = 'Notes'
        DataType = ftBlob
      end>
    IndexDefs = <>
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    StoreDefs = True
    Left = 480
    Top = 232
  end
  object mtSearchMore: TFDMemTable
    FieldDefs = <
      item
        Name = 'ClientID'
        DataType = ftInteger
      end
      item
        Name = 'City'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'ProvState'
        DataType = ftString
        Size = 15
      end
      item
        Name = 'Country'
        DataType = ftString
        Size = 25
      end
      item
        Name = 'Notes'
        DataType = ftBlob
      end>
    IndexDefs = <>
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    StoreDefs = True
    Left = 480
    Top = 184
  end
  object mtCalendar: TFDMemTable
    FieldDefs = <
      item
        Name = 'RentID'
        DataType = ftInteger
      end
      item
        Name = 'BookID'
        DataType = ftInteger
      end
      item
        Name = 'AccomID'
        DataType = ftInteger
      end
      item
        Name = 'ClientID'
        DataType = ftInteger
      end
      item
        Name = 'Status'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'Outstanding'
        DataType = ftFloat
      end
      item
        Name = 'StartDate'
        DataType = ftDateTime
      end
      item
        Name = 'EndDate'
        DataType = ftDateTime
      end
      item
        Name = 'AccomName'
        DataType = ftString
        Size = 30
      end
      item
        Name = 'FirstName'
        DataType = ftString
        Size = 30
      end
      item
        Name = 'LastName'
        DataType = ftString
        Size = 25
      end
      item
        Name = 'Occupants'
        DataType = ftInteger
      end
      item
        Name = 'TravelInfo'
        DataType = ftString
        Size = 400
      end>
    IndexDefs = <>
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    StoreDefs = True
    Left = 480
    Top = 88
  end
  object mtExtraTable: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 88
    Top = 320
  end
  object mtBookingPerson: TFDMemTable
    FieldDefs = <
      item
        Name = 'BookingID'
        DataType = ftInteger
      end
      item
        Name = 'PersonID'
        DataType = ftInteger
      end>
    CachedUpdates = True
    IndexDefs = <>
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    StoreDefs = True
    Left = 288
    Top = 64
    object mtBookingPersonBookingID: TIntegerField
      FieldName = 'BookingID'
    end
    object mtBookingPersonPersonID: TIntegerField
      FieldName = 'PersonID'
    end
  end
  object mtSettings: TFDMemTable
    Active = True
    FieldDefs = <
      item
        Name = 'Emailname'
        DataType = ftString
        Size = 60
      end
      item
        Name = 'Username'
        DataType = ftString
        Size = 60
      end
      item
        Name = 'Height'
        DataType = ftInteger
      end
      item
        Name = 'Width'
        DataType = ftInteger
      end>
    IndexDefs = <>
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    StoreDefs = True
    Left = 624
    Top = 328
  end
end
