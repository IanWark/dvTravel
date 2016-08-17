//
// Created by the DataSnap proxy generator.
// 8/14/2016 1:23:26 PM
//

unit ClientClassesUnit1;

interface

uses System.JSON, Datasnap.DSProxyRest, Datasnap.DSClientRest, Data.DBXCommon, Data.DBXClient, Data.DBXDataSnap, Data.DBXJSON, Datasnap.DSProxy, System.Classes, System.SysUtils, Data.DB, Data.SqlExpr, Data.DBXDBReaders, Data.DBXCDSReaders, Data.FireDACJSONReflect, classResultsArray, classEmailUser, Data.DBXJSONReflect;

type

  IDSRestCachedTResultsArray = interface;
  IDSRestCachedTFDJSONDataSets = interface;

  TServerMethodsClient = class(TDSAdminRestClient)
  private
    FDSServerModuleCreateCommand: TDSRestCommand;
    FTestConnectionCommand: TDSRestCommand;
    FGetAutoIncrementCommand: TDSRestCommand;
    FLastIDCommand: TDSRestCommand;
    FGetClientCommand: TDSRestCommand;
    FGetClientCommand_Cache: TDSRestCommand;
    FGetPeopleCommand: TDSRestCommand;
    FGetPeopleCommand_Cache: TDSRestCommand;
    FGetContactsCommand: TDSRestCommand;
    FGetContactsCommand_Cache: TDSRestCommand;
    FGetClientBookingsCommand: TDSRestCommand;
    FGetClientBookingsCommand_Cache: TDSRestCommand;
    FSaveClientCommand: TDSRestCommand;
    FSaveClientCommand_Cache: TDSRestCommand;
    FSavePeopleCommand: TDSRestCommand;
    FSavePeopleCommand_Cache: TDSRestCommand;
    FSaveContactsCommand: TDSRestCommand;
    FSaveContactsCommand_Cache: TDSRestCommand;
    FGetBookingByIDCommand: TDSRestCommand;
    FGetBookingByIDCommand_Cache: TDSRestCommand;
    FGetRentalsCommand: TDSRestCommand;
    FGetRentalsCommand_Cache: TDSRestCommand;
    FGetRentAccomsCommand: TDSRestCommand;
    FGetRentAccomsCommand_Cache: TDSRestCommand;
    FGetPaymentsCommand: TDSRestCommand;
    FGetPaymentsCommand_Cache: TDSRestCommand;
    FGetTravelCommand: TDSRestCommand;
    FGetTravelCommand_Cache: TDSRestCommand;
    FGetBookingPersonCommand: TDSRestCommand;
    FGetBookingPersonCommand_Cache: TDSRestCommand;
    FCheckRentalAvailableCommand: TDSRestCommand;
    FCheckAllAvailableCommand: TDSRestCommand;
    FSaveBookingsCommand: TDSRestCommand;
    FSaveBookingsCommand_Cache: TDSRestCommand;
    FSaveRentalsCommand: TDSRestCommand;
    FSaveRentalsCommand_Cache: TDSRestCommand;
    FSaveRentAccomsCommand: TDSRestCommand;
    FSavePaymentsCommand: TDSRestCommand;
    FSavePaymentsCommand_Cache: TDSRestCommand;
    FSaveTravelCommand: TDSRestCommand;
    FSaveTravelCommand_Cache: TDSRestCommand;
    FSaveBookingPersonCommand: TDSRestCommand;
    FGetBanksCommand: TDSRestCommand;
    FGetBanksCommand_Cache: TDSRestCommand;
    FGetBankByIDCommand: TDSRestCommand;
    FGetAccomsCommand: TDSRestCommand;
    FGetAccomsCommand_Cache: TDSRestCommand;
    FGetUpcomingDepositsCommand: TDSRestCommand;
    FGetUpcomingDepositsCommand_Cache: TDSRestCommand;
    FGetRecentBookingsCommand: TDSRestCommand;
    FGetRecentBookingsCommand_Cache: TDSRestCommand;
    FGetRecentClientsCommand: TDSRestCommand;
    FGetRecentClientsCommand_Cache: TDSRestCommand;
    FSearchFirstCommand: TDSRestCommand;
    FSearchFirstCommand_Cache: TDSRestCommand;
    FSearchLastCommand: TDSRestCommand;
    FSearchLastCommand_Cache: TDSRestCommand;
    FSearchCityCommand: TDSRestCommand;
    FSearchCityCommand_Cache: TDSRestCommand;
    FSearchCountryCommand: TDSRestCommand;
    FSearchCountryCommand_Cache: TDSRestCommand;
    FSearchPeopleCommand: TDSRestCommand;
    FSearchPeopleCommand_Cache: TDSRestCommand;
    FCalendarCommand: TDSRestCommand;
    FCalendarCommand_Cache: TDSRestCommand;
    FEmailBitmapCommand: TDSRestCommand;
    FMakeVoucherCommand: TDSRestCommand;
    FMakeInvoiceCommand: TDSRestCommand;
    FUploadToS3Command: TDSRestCommand;
    FPreviewVoucherCommand: TDSRestCommand;
    FPreviewInvoiceCommand: TDSRestCommand;
    FSendVoucherCommand: TDSRestCommand;
    FSendInvoiceCommand: TDSRestCommand;
    FSendReportCommand: TDSRestCommand;
  public
    constructor Create(ARestConnection: TDSRestConnection); overload;
    constructor Create(ARestConnection: TDSRestConnection; AInstanceOwner: Boolean); overload;
    destructor Destroy; override;
    procedure DSServerModuleCreate(Sender: TObject);
    function TestConnection(const ARequestFilter: string = ''): Boolean;
    function GetAutoIncrement(TableName: string; const ARequestFilter: string = ''): Integer;
    function LastID(TableName: string; const ARequestFilter: string = ''): Integer;
    function GetClient(ClientID: Integer; const ARequestFilter: string = ''): TFDJSONDataSets;
    function GetClient_Cache(ClientID: Integer; const ARequestFilter: string = ''): IDSRestCachedTFDJSONDataSets;
    function GetPeople(ClientID: Integer; const ARequestFilter: string = ''): TFDJSONDataSets;
    function GetPeople_Cache(ClientID: Integer; const ARequestFilter: string = ''): IDSRestCachedTFDJSONDataSets;
    function GetContacts(ClientID: Integer; const ARequestFilter: string = ''): TFDJSONDataSets;
    function GetContacts_Cache(ClientID: Integer; const ARequestFilter: string = ''): IDSRestCachedTFDJSONDataSets;
    function GetClientBookings(ClientID: Integer; const ARequestFilter: string = ''): TFDJSONDataSets;
    function GetClientBookings_Cache(ClientID: Integer; const ARequestFilter: string = ''): IDSRestCachedTFDJSONDataSets;
    function SaveClient(DeltaList: TFDJSONDeltas; const ARequestFilter: string = ''): TResultsArray;
    function SaveClient_Cache(DeltaList: TFDJSONDeltas; const ARequestFilter: string = ''): IDSRestCachedTResultsArray;
    function SavePeople(DeltaList: TFDJSONDeltas; const ARequestFilter: string = ''): TResultsArray;
    function SavePeople_Cache(DeltaList: TFDJSONDeltas; const ARequestFilter: string = ''): IDSRestCachedTResultsArray;
    function SaveContacts(DeltaList: TFDJSONDeltas; const ARequestFilter: string = ''): TResultsArray;
    function SaveContacts_Cache(DeltaList: TFDJSONDeltas; const ARequestFilter: string = ''): IDSRestCachedTResultsArray;
    function GetBookingByID(BookID: Integer; const ARequestFilter: string = ''): TFDJSONDataSets;
    function GetBookingByID_Cache(BookID: Integer; const ARequestFilter: string = ''): IDSRestCachedTFDJSONDataSets;
    function GetRentals(BookID: Integer; const ARequestFilter: string = ''): TFDJSONDataSets;
    function GetRentals_Cache(BookID: Integer; const ARequestFilter: string = ''): IDSRestCachedTFDJSONDataSets;
    function GetRentAccoms(IDList: string; const ARequestFilter: string = ''): TFDJSONDataSets;
    function GetRentAccoms_Cache(IDList: string; const ARequestFilter: string = ''): IDSRestCachedTFDJSONDataSets;
    function GetPayments(BookID: Integer; const ARequestFilter: string = ''): TFDJSONDataSets;
    function GetPayments_Cache(BookID: Integer; const ARequestFilter: string = ''): IDSRestCachedTFDJSONDataSets;
    function GetTravel(BookID: Integer; const ARequestFilter: string = ''): TFDJSONDataSets;
    function GetTravel_Cache(BookID: Integer; const ARequestFilter: string = ''): IDSRestCachedTFDJSONDataSets;
    function GetBookingPerson(BookID: Integer; const ARequestFilter: string = ''): TFDJSONDataSets;
    function GetBookingPerson_Cache(BookID: Integer; const ARequestFilter: string = ''): IDSRestCachedTFDJSONDataSets;
    function CheckRentalAvailable(AccomID: Integer; StartDate: TDateTime; EndDate: TDateTime; RentID: Integer; const ARequestFilter: string = ''): Boolean;
    function CheckAllAvailable(StartDate: TDateTime; EndDate: TDateTime; RentID: Integer; const ARequestFilter: string = ''): Boolean;
    function SaveBookings(DeltaList: TFDJSONDeltas; const ARequestFilter: string = ''): TResultsArray;
    function SaveBookings_Cache(DeltaList: TFDJSONDeltas; const ARequestFilter: string = ''): IDSRestCachedTResultsArray;
    function SaveRentals(DeltaList: TFDJSONDeltas; const ARequestFilter: string = ''): TResultsArray;
    function SaveRentals_Cache(DeltaList: TFDJSONDeltas; const ARequestFilter: string = ''): IDSRestCachedTResultsArray;
    procedure SaveRentAccoms(DeltaList: TFDJSONDeltas);
    function SavePayments(DeltaList: TFDJSONDeltas; const ARequestFilter: string = ''): TResultsArray;
    function SavePayments_Cache(DeltaList: TFDJSONDeltas; const ARequestFilter: string = ''): IDSRestCachedTResultsArray;
    function SaveTravel(DeltaList: TFDJSONDeltas; const ARequestFilter: string = ''): TResultsArray;
    function SaveTravel_Cache(DeltaList: TFDJSONDeltas; const ARequestFilter: string = ''): IDSRestCachedTResultsArray;
    procedure SaveBookingPerson(DeltaList: TFDJSONDeltas);
    function GetBanks(const ARequestFilter: string = ''): TFDJSONDataSets;
    function GetBanks_Cache(const ARequestFilter: string = ''): IDSRestCachedTFDJSONDataSets;
    function GetBankByID(BankID: Integer; const ARequestFilter: string = ''): string;
    function GetAccoms(const ARequestFilter: string = ''): TFDJSONDataSets;
    function GetAccoms_Cache(const ARequestFilter: string = ''): IDSRestCachedTFDJSONDataSets;
    function GetUpcomingDeposits(Limit: Integer; const ARequestFilter: string = ''): TFDJSONDataSets;
    function GetUpcomingDeposits_Cache(Limit: Integer; const ARequestFilter: string = ''): IDSRestCachedTFDJSONDataSets;
    function GetRecentBookings(Limit: Integer; const ARequestFilter: string = ''): TFDJSONDataSets;
    function GetRecentBookings_Cache(Limit: Integer; const ARequestFilter: string = ''): IDSRestCachedTFDJSONDataSets;
    function GetRecentClients(Limit: Integer; const ARequestFilter: string = ''): TFDJSONDataSets;
    function GetRecentClients_Cache(Limit: Integer; const ARequestFilter: string = ''): IDSRestCachedTFDJSONDataSets;
    function SearchFirst(FirstName: string; Limit: Integer; const ARequestFilter: string = ''): TFDJSONDataSets;
    function SearchFirst_Cache(FirstName: string; Limit: Integer; const ARequestFilter: string = ''): IDSRestCachedTFDJSONDataSets;
    function SearchLast(LastName: string; Limit: Integer; const ARequestFilter: string = ''): TFDJSONDataSets;
    function SearchLast_Cache(LastName: string; Limit: Integer; const ARequestFilter: string = ''): IDSRestCachedTFDJSONDataSets;
    function SearchCity(City: string; Limit: Integer; const ARequestFilter: string = ''): TFDJSONDataSets;
    function SearchCity_Cache(City: string; Limit: Integer; const ARequestFilter: string = ''): IDSRestCachedTFDJSONDataSets;
    function SearchCountry(Country: string; Limit: Integer; const ARequestFilter: string = ''): TFDJSONDataSets;
    function SearchCountry_Cache(Country: string; Limit: Integer; const ARequestFilter: string = ''): IDSRestCachedTFDJSONDataSets;
    function SearchPeople(IDList: string; const ARequestFilter: string = ''): TFDJSONDataSets;
    function SearchPeople_Cache(IDList: string; const ARequestFilter: string = ''): IDSRestCachedTFDJSONDataSets;
    function Calendar(StartDate: TDateTime; EndDate: TDateTime; const ARequestFilter: string = ''): TFDJSONDataSets;
    function Calendar_Cache(StartDate: TDateTime; EndDate: TDateTime; const ARequestFilter: string = ''): IDSRestCachedTFDJSONDataSets;
    function EmailBitmap(Image: TMemoryStream; Email: string; EmailUser: TEmailUser; Body: string; const ARequestFilter: string = ''): Boolean;
    function MakeVoucher(BookingID: Integer; const ARequestFilter: string = ''): string;
    function MakeInvoice(BookingID: Integer; const ARequestFilter: string = ''): string;
    function UploadToS3(Bucket: string; AWSObject: string; Filename: string; const ARequestFilter: string = ''): Boolean;
    function PreviewVoucher(BookingID: Integer; const ARequestFilter: string = ''): string;
    function PreviewInvoice(BookingID: Integer; const ARequestFilter: string = ''): string;
    function SendVoucher(EmailList: string; EmailUser: TEmailUser; BookingID: Integer; const ARequestFilter: string = ''): Boolean;
    function SendInvoice(Mode: Integer; EmailList: string; EmailUser: TEmailUser; BookingID: Integer; const ARequestFilter: string = ''): Boolean;
    function SendReport(Mode: Integer; EmailList: string; EmailUser: TEmailUser; Filename: string; const ARequestFilter: string = ''): Boolean;
  end;

  IDSRestCachedTResultsArray = interface(IDSRestCachedObject<TResultsArray>)
  end;

  TDSRestCachedTResultsArray = class(TDSRestCachedObject<TResultsArray>, IDSRestCachedTResultsArray, IDSRestCachedCommand)
  end;
  IDSRestCachedTFDJSONDataSets = interface(IDSRestCachedObject<TFDJSONDataSets>)
  end;

  TDSRestCachedTFDJSONDataSets = class(TDSRestCachedObject<TFDJSONDataSets>, IDSRestCachedTFDJSONDataSets, IDSRestCachedCommand)
  end;

const
  TServerMethods_DSServerModuleCreate: array [0..0] of TDSRestParameterMetaData =
  (
    (Name: 'Sender'; Direction: 1; DBXType: 37; TypeName: 'TObject')
  );

  TServerMethods_TestConnection: array [0..0] of TDSRestParameterMetaData =
  (
    (Name: ''; Direction: 4; DBXType: 4; TypeName: 'Boolean')
  );

  TServerMethods_GetAutoIncrement: array [0..1] of TDSRestParameterMetaData =
  (
    (Name: 'TableName'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: ''; Direction: 4; DBXType: 6; TypeName: 'Integer')
  );

  TServerMethods_LastID: array [0..1] of TDSRestParameterMetaData =
  (
    (Name: 'TableName'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: ''; Direction: 4; DBXType: 6; TypeName: 'Integer')
  );

  TServerMethods_GetClient: array [0..1] of TDSRestParameterMetaData =
  (
    (Name: 'ClientID'; Direction: 1; DBXType: 6; TypeName: 'Integer'),
    (Name: ''; Direction: 4; DBXType: 37; TypeName: 'TFDJSONDataSets')
  );

  TServerMethods_GetClient_Cache: array [0..1] of TDSRestParameterMetaData =
  (
    (Name: 'ClientID'; Direction: 1; DBXType: 6; TypeName: 'Integer'),
    (Name: ''; Direction: 4; DBXType: 26; TypeName: 'String')
  );

  TServerMethods_GetPeople: array [0..1] of TDSRestParameterMetaData =
  (
    (Name: 'ClientID'; Direction: 1; DBXType: 6; TypeName: 'Integer'),
    (Name: ''; Direction: 4; DBXType: 37; TypeName: 'TFDJSONDataSets')
  );

  TServerMethods_GetPeople_Cache: array [0..1] of TDSRestParameterMetaData =
  (
    (Name: 'ClientID'; Direction: 1; DBXType: 6; TypeName: 'Integer'),
    (Name: ''; Direction: 4; DBXType: 26; TypeName: 'String')
  );

  TServerMethods_GetContacts: array [0..1] of TDSRestParameterMetaData =
  (
    (Name: 'ClientID'; Direction: 1; DBXType: 6; TypeName: 'Integer'),
    (Name: ''; Direction: 4; DBXType: 37; TypeName: 'TFDJSONDataSets')
  );

  TServerMethods_GetContacts_Cache: array [0..1] of TDSRestParameterMetaData =
  (
    (Name: 'ClientID'; Direction: 1; DBXType: 6; TypeName: 'Integer'),
    (Name: ''; Direction: 4; DBXType: 26; TypeName: 'String')
  );

  TServerMethods_GetClientBookings: array [0..1] of TDSRestParameterMetaData =
  (
    (Name: 'ClientID'; Direction: 1; DBXType: 6; TypeName: 'Integer'),
    (Name: ''; Direction: 4; DBXType: 37; TypeName: 'TFDJSONDataSets')
  );

  TServerMethods_GetClientBookings_Cache: array [0..1] of TDSRestParameterMetaData =
  (
    (Name: 'ClientID'; Direction: 1; DBXType: 6; TypeName: 'Integer'),
    (Name: ''; Direction: 4; DBXType: 26; TypeName: 'String')
  );

  TServerMethods_SaveClient: array [0..1] of TDSRestParameterMetaData =
  (
    (Name: 'DeltaList'; Direction: 1; DBXType: 37; TypeName: 'TFDJSONDeltas'),
    (Name: ''; Direction: 4; DBXType: 37; TypeName: 'TResultsArray')
  );

  TServerMethods_SaveClient_Cache: array [0..1] of TDSRestParameterMetaData =
  (
    (Name: 'DeltaList'; Direction: 1; DBXType: 37; TypeName: 'TFDJSONDeltas'),
    (Name: ''; Direction: 4; DBXType: 26; TypeName: 'String')
  );

  TServerMethods_SavePeople: array [0..1] of TDSRestParameterMetaData =
  (
    (Name: 'DeltaList'; Direction: 1; DBXType: 37; TypeName: 'TFDJSONDeltas'),
    (Name: ''; Direction: 4; DBXType: 37; TypeName: 'TResultsArray')
  );

  TServerMethods_SavePeople_Cache: array [0..1] of TDSRestParameterMetaData =
  (
    (Name: 'DeltaList'; Direction: 1; DBXType: 37; TypeName: 'TFDJSONDeltas'),
    (Name: ''; Direction: 4; DBXType: 26; TypeName: 'String')
  );

  TServerMethods_SaveContacts: array [0..1] of TDSRestParameterMetaData =
  (
    (Name: 'DeltaList'; Direction: 1; DBXType: 37; TypeName: 'TFDJSONDeltas'),
    (Name: ''; Direction: 4; DBXType: 37; TypeName: 'TResultsArray')
  );

  TServerMethods_SaveContacts_Cache: array [0..1] of TDSRestParameterMetaData =
  (
    (Name: 'DeltaList'; Direction: 1; DBXType: 37; TypeName: 'TFDJSONDeltas'),
    (Name: ''; Direction: 4; DBXType: 26; TypeName: 'String')
  );

  TServerMethods_GetBookingByID: array [0..1] of TDSRestParameterMetaData =
  (
    (Name: 'BookID'; Direction: 1; DBXType: 6; TypeName: 'Integer'),
    (Name: ''; Direction: 4; DBXType: 37; TypeName: 'TFDJSONDataSets')
  );

  TServerMethods_GetBookingByID_Cache: array [0..1] of TDSRestParameterMetaData =
  (
    (Name: 'BookID'; Direction: 1; DBXType: 6; TypeName: 'Integer'),
    (Name: ''; Direction: 4; DBXType: 26; TypeName: 'String')
  );

  TServerMethods_GetRentals: array [0..1] of TDSRestParameterMetaData =
  (
    (Name: 'BookID'; Direction: 1; DBXType: 6; TypeName: 'Integer'),
    (Name: ''; Direction: 4; DBXType: 37; TypeName: 'TFDJSONDataSets')
  );

  TServerMethods_GetRentals_Cache: array [0..1] of TDSRestParameterMetaData =
  (
    (Name: 'BookID'; Direction: 1; DBXType: 6; TypeName: 'Integer'),
    (Name: ''; Direction: 4; DBXType: 26; TypeName: 'String')
  );

  TServerMethods_GetRentAccoms: array [0..1] of TDSRestParameterMetaData =
  (
    (Name: 'IDList'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: ''; Direction: 4; DBXType: 37; TypeName: 'TFDJSONDataSets')
  );

  TServerMethods_GetRentAccoms_Cache: array [0..1] of TDSRestParameterMetaData =
  (
    (Name: 'IDList'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: ''; Direction: 4; DBXType: 26; TypeName: 'String')
  );

  TServerMethods_GetPayments: array [0..1] of TDSRestParameterMetaData =
  (
    (Name: 'BookID'; Direction: 1; DBXType: 6; TypeName: 'Integer'),
    (Name: ''; Direction: 4; DBXType: 37; TypeName: 'TFDJSONDataSets')
  );

  TServerMethods_GetPayments_Cache: array [0..1] of TDSRestParameterMetaData =
  (
    (Name: 'BookID'; Direction: 1; DBXType: 6; TypeName: 'Integer'),
    (Name: ''; Direction: 4; DBXType: 26; TypeName: 'String')
  );

  TServerMethods_GetTravel: array [0..1] of TDSRestParameterMetaData =
  (
    (Name: 'BookID'; Direction: 1; DBXType: 6; TypeName: 'Integer'),
    (Name: ''; Direction: 4; DBXType: 37; TypeName: 'TFDJSONDataSets')
  );

  TServerMethods_GetTravel_Cache: array [0..1] of TDSRestParameterMetaData =
  (
    (Name: 'BookID'; Direction: 1; DBXType: 6; TypeName: 'Integer'),
    (Name: ''; Direction: 4; DBXType: 26; TypeName: 'String')
  );

  TServerMethods_GetBookingPerson: array [0..1] of TDSRestParameterMetaData =
  (
    (Name: 'BookID'; Direction: 1; DBXType: 6; TypeName: 'Integer'),
    (Name: ''; Direction: 4; DBXType: 37; TypeName: 'TFDJSONDataSets')
  );

  TServerMethods_GetBookingPerson_Cache: array [0..1] of TDSRestParameterMetaData =
  (
    (Name: 'BookID'; Direction: 1; DBXType: 6; TypeName: 'Integer'),
    (Name: ''; Direction: 4; DBXType: 26; TypeName: 'String')
  );

  TServerMethods_CheckRentalAvailable: array [0..4] of TDSRestParameterMetaData =
  (
    (Name: 'AccomID'; Direction: 1; DBXType: 6; TypeName: 'Integer'),
    (Name: 'StartDate'; Direction: 1; DBXType: 11; TypeName: 'TDateTime'),
    (Name: 'EndDate'; Direction: 1; DBXType: 11; TypeName: 'TDateTime'),
    (Name: 'RentID'; Direction: 1; DBXType: 6; TypeName: 'Integer'),
    (Name: ''; Direction: 4; DBXType: 4; TypeName: 'Boolean')
  );

  TServerMethods_CheckAllAvailable: array [0..3] of TDSRestParameterMetaData =
  (
    (Name: 'StartDate'; Direction: 1; DBXType: 11; TypeName: 'TDateTime'),
    (Name: 'EndDate'; Direction: 1; DBXType: 11; TypeName: 'TDateTime'),
    (Name: 'RentID'; Direction: 1; DBXType: 6; TypeName: 'Integer'),
    (Name: ''; Direction: 4; DBXType: 4; TypeName: 'Boolean')
  );

  TServerMethods_SaveBookings: array [0..1] of TDSRestParameterMetaData =
  (
    (Name: 'DeltaList'; Direction: 1; DBXType: 37; TypeName: 'TFDJSONDeltas'),
    (Name: ''; Direction: 4; DBXType: 37; TypeName: 'TResultsArray')
  );

  TServerMethods_SaveBookings_Cache: array [0..1] of TDSRestParameterMetaData =
  (
    (Name: 'DeltaList'; Direction: 1; DBXType: 37; TypeName: 'TFDJSONDeltas'),
    (Name: ''; Direction: 4; DBXType: 26; TypeName: 'String')
  );

  TServerMethods_SaveRentals: array [0..1] of TDSRestParameterMetaData =
  (
    (Name: 'DeltaList'; Direction: 1; DBXType: 37; TypeName: 'TFDJSONDeltas'),
    (Name: ''; Direction: 4; DBXType: 37; TypeName: 'TResultsArray')
  );

  TServerMethods_SaveRentals_Cache: array [0..1] of TDSRestParameterMetaData =
  (
    (Name: 'DeltaList'; Direction: 1; DBXType: 37; TypeName: 'TFDJSONDeltas'),
    (Name: ''; Direction: 4; DBXType: 26; TypeName: 'String')
  );

  TServerMethods_SaveRentAccoms: array [0..0] of TDSRestParameterMetaData =
  (
    (Name: 'DeltaList'; Direction: 1; DBXType: 37; TypeName: 'TFDJSONDeltas')
  );

  TServerMethods_SavePayments: array [0..1] of TDSRestParameterMetaData =
  (
    (Name: 'DeltaList'; Direction: 1; DBXType: 37; TypeName: 'TFDJSONDeltas'),
    (Name: ''; Direction: 4; DBXType: 37; TypeName: 'TResultsArray')
  );

  TServerMethods_SavePayments_Cache: array [0..1] of TDSRestParameterMetaData =
  (
    (Name: 'DeltaList'; Direction: 1; DBXType: 37; TypeName: 'TFDJSONDeltas'),
    (Name: ''; Direction: 4; DBXType: 26; TypeName: 'String')
  );

  TServerMethods_SaveTravel: array [0..1] of TDSRestParameterMetaData =
  (
    (Name: 'DeltaList'; Direction: 1; DBXType: 37; TypeName: 'TFDJSONDeltas'),
    (Name: ''; Direction: 4; DBXType: 37; TypeName: 'TResultsArray')
  );

  TServerMethods_SaveTravel_Cache: array [0..1] of TDSRestParameterMetaData =
  (
    (Name: 'DeltaList'; Direction: 1; DBXType: 37; TypeName: 'TFDJSONDeltas'),
    (Name: ''; Direction: 4; DBXType: 26; TypeName: 'String')
  );

  TServerMethods_SaveBookingPerson: array [0..0] of TDSRestParameterMetaData =
  (
    (Name: 'DeltaList'; Direction: 1; DBXType: 37; TypeName: 'TFDJSONDeltas')
  );

  TServerMethods_GetBanks: array [0..0] of TDSRestParameterMetaData =
  (
    (Name: ''; Direction: 4; DBXType: 37; TypeName: 'TFDJSONDataSets')
  );

  TServerMethods_GetBanks_Cache: array [0..0] of TDSRestParameterMetaData =
  (
    (Name: ''; Direction: 4; DBXType: 26; TypeName: 'String')
  );

  TServerMethods_GetBankByID: array [0..1] of TDSRestParameterMetaData =
  (
    (Name: 'BankID'; Direction: 1; DBXType: 6; TypeName: 'Integer'),
    (Name: ''; Direction: 4; DBXType: 26; TypeName: 'string')
  );

  TServerMethods_GetAccoms: array [0..0] of TDSRestParameterMetaData =
  (
    (Name: ''; Direction: 4; DBXType: 37; TypeName: 'TFDJSONDataSets')
  );

  TServerMethods_GetAccoms_Cache: array [0..0] of TDSRestParameterMetaData =
  (
    (Name: ''; Direction: 4; DBXType: 26; TypeName: 'String')
  );

  TServerMethods_GetUpcomingDeposits: array [0..1] of TDSRestParameterMetaData =
  (
    (Name: 'Limit'; Direction: 1; DBXType: 6; TypeName: 'Integer'),
    (Name: ''; Direction: 4; DBXType: 37; TypeName: 'TFDJSONDataSets')
  );

  TServerMethods_GetUpcomingDeposits_Cache: array [0..1] of TDSRestParameterMetaData =
  (
    (Name: 'Limit'; Direction: 1; DBXType: 6; TypeName: 'Integer'),
    (Name: ''; Direction: 4; DBXType: 26; TypeName: 'String')
  );

  TServerMethods_GetRecentBookings: array [0..1] of TDSRestParameterMetaData =
  (
    (Name: 'Limit'; Direction: 1; DBXType: 6; TypeName: 'Integer'),
    (Name: ''; Direction: 4; DBXType: 37; TypeName: 'TFDJSONDataSets')
  );

  TServerMethods_GetRecentBookings_Cache: array [0..1] of TDSRestParameterMetaData =
  (
    (Name: 'Limit'; Direction: 1; DBXType: 6; TypeName: 'Integer'),
    (Name: ''; Direction: 4; DBXType: 26; TypeName: 'String')
  );

  TServerMethods_GetRecentClients: array [0..1] of TDSRestParameterMetaData =
  (
    (Name: 'Limit'; Direction: 1; DBXType: 6; TypeName: 'Integer'),
    (Name: ''; Direction: 4; DBXType: 37; TypeName: 'TFDJSONDataSets')
  );

  TServerMethods_GetRecentClients_Cache: array [0..1] of TDSRestParameterMetaData =
  (
    (Name: 'Limit'; Direction: 1; DBXType: 6; TypeName: 'Integer'),
    (Name: ''; Direction: 4; DBXType: 26; TypeName: 'String')
  );

  TServerMethods_SearchFirst: array [0..2] of TDSRestParameterMetaData =
  (
    (Name: 'FirstName'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: 'Limit'; Direction: 1; DBXType: 6; TypeName: 'Integer'),
    (Name: ''; Direction: 4; DBXType: 37; TypeName: 'TFDJSONDataSets')
  );

  TServerMethods_SearchFirst_Cache: array [0..2] of TDSRestParameterMetaData =
  (
    (Name: 'FirstName'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: 'Limit'; Direction: 1; DBXType: 6; TypeName: 'Integer'),
    (Name: ''; Direction: 4; DBXType: 26; TypeName: 'String')
  );

  TServerMethods_SearchLast: array [0..2] of TDSRestParameterMetaData =
  (
    (Name: 'LastName'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: 'Limit'; Direction: 1; DBXType: 6; TypeName: 'Integer'),
    (Name: ''; Direction: 4; DBXType: 37; TypeName: 'TFDJSONDataSets')
  );

  TServerMethods_SearchLast_Cache: array [0..2] of TDSRestParameterMetaData =
  (
    (Name: 'LastName'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: 'Limit'; Direction: 1; DBXType: 6; TypeName: 'Integer'),
    (Name: ''; Direction: 4; DBXType: 26; TypeName: 'String')
  );

  TServerMethods_SearchCity: array [0..2] of TDSRestParameterMetaData =
  (
    (Name: 'City'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: 'Limit'; Direction: 1; DBXType: 6; TypeName: 'Integer'),
    (Name: ''; Direction: 4; DBXType: 37; TypeName: 'TFDJSONDataSets')
  );

  TServerMethods_SearchCity_Cache: array [0..2] of TDSRestParameterMetaData =
  (
    (Name: 'City'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: 'Limit'; Direction: 1; DBXType: 6; TypeName: 'Integer'),
    (Name: ''; Direction: 4; DBXType: 26; TypeName: 'String')
  );

  TServerMethods_SearchCountry: array [0..2] of TDSRestParameterMetaData =
  (
    (Name: 'Country'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: 'Limit'; Direction: 1; DBXType: 6; TypeName: 'Integer'),
    (Name: ''; Direction: 4; DBXType: 37; TypeName: 'TFDJSONDataSets')
  );

  TServerMethods_SearchCountry_Cache: array [0..2] of TDSRestParameterMetaData =
  (
    (Name: 'Country'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: 'Limit'; Direction: 1; DBXType: 6; TypeName: 'Integer'),
    (Name: ''; Direction: 4; DBXType: 26; TypeName: 'String')
  );

  TServerMethods_SearchPeople: array [0..1] of TDSRestParameterMetaData =
  (
    (Name: 'IDList'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: ''; Direction: 4; DBXType: 37; TypeName: 'TFDJSONDataSets')
  );

  TServerMethods_SearchPeople_Cache: array [0..1] of TDSRestParameterMetaData =
  (
    (Name: 'IDList'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: ''; Direction: 4; DBXType: 26; TypeName: 'String')
  );

  TServerMethods_Calendar: array [0..2] of TDSRestParameterMetaData =
  (
    (Name: 'StartDate'; Direction: 1; DBXType: 11; TypeName: 'TDateTime'),
    (Name: 'EndDate'; Direction: 1; DBXType: 11; TypeName: 'TDateTime'),
    (Name: ''; Direction: 4; DBXType: 37; TypeName: 'TFDJSONDataSets')
  );

  TServerMethods_Calendar_Cache: array [0..2] of TDSRestParameterMetaData =
  (
    (Name: 'StartDate'; Direction: 1; DBXType: 11; TypeName: 'TDateTime'),
    (Name: 'EndDate'; Direction: 1; DBXType: 11; TypeName: 'TDateTime'),
    (Name: ''; Direction: 4; DBXType: 26; TypeName: 'String')
  );

  TServerMethods_EmailBitmap: array [0..4] of TDSRestParameterMetaData =
  (
    (Name: 'Image'; Direction: 1; DBXType: 33; TypeName: 'TMemoryStream'),
    (Name: 'Email'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: 'EmailUser'; Direction: 1; DBXType: 37; TypeName: 'TEmailUser'),
    (Name: 'Body'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: ''; Direction: 4; DBXType: 4; TypeName: 'Boolean')
  );

  TServerMethods_MakeVoucher: array [0..1] of TDSRestParameterMetaData =
  (
    (Name: 'BookingID'; Direction: 1; DBXType: 6; TypeName: 'Integer'),
    (Name: ''; Direction: 4; DBXType: 26; TypeName: 'string')
  );

  TServerMethods_MakeInvoice: array [0..1] of TDSRestParameterMetaData =
  (
    (Name: 'BookingID'; Direction: 1; DBXType: 6; TypeName: 'Integer'),
    (Name: ''; Direction: 4; DBXType: 26; TypeName: 'string')
  );

  TServerMethods_UploadToS3: array [0..3] of TDSRestParameterMetaData =
  (
    (Name: 'Bucket'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: 'AWSObject'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: 'Filename'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: ''; Direction: 4; DBXType: 4; TypeName: 'Boolean')
  );

  TServerMethods_PreviewVoucher: array [0..1] of TDSRestParameterMetaData =
  (
    (Name: 'BookingID'; Direction: 1; DBXType: 6; TypeName: 'Integer'),
    (Name: ''; Direction: 4; DBXType: 26; TypeName: 'string')
  );

  TServerMethods_PreviewInvoice: array [0..1] of TDSRestParameterMetaData =
  (
    (Name: 'BookingID'; Direction: 1; DBXType: 6; TypeName: 'Integer'),
    (Name: ''; Direction: 4; DBXType: 26; TypeName: 'string')
  );

  TServerMethods_SendVoucher: array [0..3] of TDSRestParameterMetaData =
  (
    (Name: 'EmailList'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: 'EmailUser'; Direction: 1; DBXType: 37; TypeName: 'TEmailUser'),
    (Name: 'BookingID'; Direction: 1; DBXType: 6; TypeName: 'Integer'),
    (Name: ''; Direction: 4; DBXType: 4; TypeName: 'Boolean')
  );

  TServerMethods_SendInvoice: array [0..4] of TDSRestParameterMetaData =
  (
    (Name: 'Mode'; Direction: 1; DBXType: 6; TypeName: 'Integer'),
    (Name: 'EmailList'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: 'EmailUser'; Direction: 1; DBXType: 37; TypeName: 'TEmailUser'),
    (Name: 'BookingID'; Direction: 1; DBXType: 6; TypeName: 'Integer'),
    (Name: ''; Direction: 4; DBXType: 4; TypeName: 'Boolean')
  );

  TServerMethods_SendReport: array [0..4] of TDSRestParameterMetaData =
  (
    (Name: 'Mode'; Direction: 1; DBXType: 6; TypeName: 'Integer'),
    (Name: 'EmailList'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: 'EmailUser'; Direction: 1; DBXType: 37; TypeName: 'TEmailUser'),
    (Name: 'Filename'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: ''; Direction: 4; DBXType: 4; TypeName: 'Boolean')
  );

implementation

procedure TServerMethodsClient.DSServerModuleCreate(Sender: TObject);
begin
  if FDSServerModuleCreateCommand = nil then
  begin
    FDSServerModuleCreateCommand := FConnection.CreateCommand;
    FDSServerModuleCreateCommand.RequestType := 'POST';
    FDSServerModuleCreateCommand.Text := 'TServerMethods."DSServerModuleCreate"';
    FDSServerModuleCreateCommand.Prepare(TServerMethods_DSServerModuleCreate);
  end;
  if not Assigned(Sender) then
    FDSServerModuleCreateCommand.Parameters[0].Value.SetNull
  else
  begin
    FMarshal := TDSRestCommand(FDSServerModuleCreateCommand.Parameters[0].ConnectionHandler).GetJSONMarshaler;
    try
      FDSServerModuleCreateCommand.Parameters[0].Value.SetJSONValue(FMarshal.Marshal(Sender), True);
      if FInstanceOwner then
        Sender.Free
    finally
      FreeAndNil(FMarshal)
    end
    end;
  FDSServerModuleCreateCommand.Execute;
end;

function TServerMethodsClient.TestConnection(const ARequestFilter: string): Boolean;
begin
  if FTestConnectionCommand = nil then
  begin
    FTestConnectionCommand := FConnection.CreateCommand;
    FTestConnectionCommand.RequestType := 'GET';
    FTestConnectionCommand.Text := 'TServerMethods.TestConnection';
    FTestConnectionCommand.Prepare(TServerMethods_TestConnection);
  end;
  FTestConnectionCommand.Execute(ARequestFilter);
  Result := FTestConnectionCommand.Parameters[0].Value.GetBoolean;
end;

function TServerMethodsClient.GetAutoIncrement(TableName: string; const ARequestFilter: string): Integer;
begin
  if FGetAutoIncrementCommand = nil then
  begin
    FGetAutoIncrementCommand := FConnection.CreateCommand;
    FGetAutoIncrementCommand.RequestType := 'GET';
    FGetAutoIncrementCommand.Text := 'TServerMethods.GetAutoIncrement';
    FGetAutoIncrementCommand.Prepare(TServerMethods_GetAutoIncrement);
  end;
  FGetAutoIncrementCommand.Parameters[0].Value.SetWideString(TableName);
  FGetAutoIncrementCommand.Execute(ARequestFilter);
  Result := FGetAutoIncrementCommand.Parameters[1].Value.GetInt32;
end;

function TServerMethodsClient.LastID(TableName: string; const ARequestFilter: string): Integer;
begin
  if FLastIDCommand = nil then
  begin
    FLastIDCommand := FConnection.CreateCommand;
    FLastIDCommand.RequestType := 'GET';
    FLastIDCommand.Text := 'TServerMethods.LastID';
    FLastIDCommand.Prepare(TServerMethods_LastID);
  end;
  FLastIDCommand.Parameters[0].Value.SetWideString(TableName);
  FLastIDCommand.Execute(ARequestFilter);
  Result := FLastIDCommand.Parameters[1].Value.GetInt32;
end;

function TServerMethodsClient.GetClient(ClientID: Integer; const ARequestFilter: string): TFDJSONDataSets;
begin
  if FGetClientCommand = nil then
  begin
    FGetClientCommand := FConnection.CreateCommand;
    FGetClientCommand.RequestType := 'GET';
    FGetClientCommand.Text := 'TServerMethods.GetClient';
    FGetClientCommand.Prepare(TServerMethods_GetClient);
  end;
  FGetClientCommand.Parameters[0].Value.SetInt32(ClientID);
  FGetClientCommand.Execute(ARequestFilter);
  if not FGetClientCommand.Parameters[1].Value.IsNull then
  begin
    FUnMarshal := TDSRestCommand(FGetClientCommand.Parameters[1].ConnectionHandler).GetJSONUnMarshaler;
    try
      Result := TFDJSONDataSets(FUnMarshal.UnMarshal(FGetClientCommand.Parameters[1].Value.GetJSONValue(True)));
      if FInstanceOwner then
        FGetClientCommand.FreeOnExecute(Result);
    finally
      FreeAndNil(FUnMarshal)
    end
  end
  else
    Result := nil;
end;

function TServerMethodsClient.GetClient_Cache(ClientID: Integer; const ARequestFilter: string): IDSRestCachedTFDJSONDataSets;
begin
  if FGetClientCommand_Cache = nil then
  begin
    FGetClientCommand_Cache := FConnection.CreateCommand;
    FGetClientCommand_Cache.RequestType := 'GET';
    FGetClientCommand_Cache.Text := 'TServerMethods.GetClient';
    FGetClientCommand_Cache.Prepare(TServerMethods_GetClient_Cache);
  end;
  FGetClientCommand_Cache.Parameters[0].Value.SetInt32(ClientID);
  FGetClientCommand_Cache.ExecuteCache(ARequestFilter);
  Result := TDSRestCachedTFDJSONDataSets.Create(FGetClientCommand_Cache.Parameters[1].Value.GetString);
end;

function TServerMethodsClient.GetPeople(ClientID: Integer; const ARequestFilter: string): TFDJSONDataSets;
begin
  if FGetPeopleCommand = nil then
  begin
    FGetPeopleCommand := FConnection.CreateCommand;
    FGetPeopleCommand.RequestType := 'GET';
    FGetPeopleCommand.Text := 'TServerMethods.GetPeople';
    FGetPeopleCommand.Prepare(TServerMethods_GetPeople);
  end;
  FGetPeopleCommand.Parameters[0].Value.SetInt32(ClientID);
  FGetPeopleCommand.Execute(ARequestFilter);
  if not FGetPeopleCommand.Parameters[1].Value.IsNull then
  begin
    FUnMarshal := TDSRestCommand(FGetPeopleCommand.Parameters[1].ConnectionHandler).GetJSONUnMarshaler;
    try
      Result := TFDJSONDataSets(FUnMarshal.UnMarshal(FGetPeopleCommand.Parameters[1].Value.GetJSONValue(True)));
      if FInstanceOwner then
        FGetPeopleCommand.FreeOnExecute(Result);
    finally
      FreeAndNil(FUnMarshal)
    end
  end
  else
    Result := nil;
end;

function TServerMethodsClient.GetPeople_Cache(ClientID: Integer; const ARequestFilter: string): IDSRestCachedTFDJSONDataSets;
begin
  if FGetPeopleCommand_Cache = nil then
  begin
    FGetPeopleCommand_Cache := FConnection.CreateCommand;
    FGetPeopleCommand_Cache.RequestType := 'GET';
    FGetPeopleCommand_Cache.Text := 'TServerMethods.GetPeople';
    FGetPeopleCommand_Cache.Prepare(TServerMethods_GetPeople_Cache);
  end;
  FGetPeopleCommand_Cache.Parameters[0].Value.SetInt32(ClientID);
  FGetPeopleCommand_Cache.ExecuteCache(ARequestFilter);
  Result := TDSRestCachedTFDJSONDataSets.Create(FGetPeopleCommand_Cache.Parameters[1].Value.GetString);
end;

function TServerMethodsClient.GetContacts(ClientID: Integer; const ARequestFilter: string): TFDJSONDataSets;
begin
  if FGetContactsCommand = nil then
  begin
    FGetContactsCommand := FConnection.CreateCommand;
    FGetContactsCommand.RequestType := 'GET';
    FGetContactsCommand.Text := 'TServerMethods.GetContacts';
    FGetContactsCommand.Prepare(TServerMethods_GetContacts);
  end;
  FGetContactsCommand.Parameters[0].Value.SetInt32(ClientID);
  FGetContactsCommand.Execute(ARequestFilter);
  if not FGetContactsCommand.Parameters[1].Value.IsNull then
  begin
    FUnMarshal := TDSRestCommand(FGetContactsCommand.Parameters[1].ConnectionHandler).GetJSONUnMarshaler;
    try
      Result := TFDJSONDataSets(FUnMarshal.UnMarshal(FGetContactsCommand.Parameters[1].Value.GetJSONValue(True)));
      if FInstanceOwner then
        FGetContactsCommand.FreeOnExecute(Result);
    finally
      FreeAndNil(FUnMarshal)
    end
  end
  else
    Result := nil;
end;

function TServerMethodsClient.GetContacts_Cache(ClientID: Integer; const ARequestFilter: string): IDSRestCachedTFDJSONDataSets;
begin
  if FGetContactsCommand_Cache = nil then
  begin
    FGetContactsCommand_Cache := FConnection.CreateCommand;
    FGetContactsCommand_Cache.RequestType := 'GET';
    FGetContactsCommand_Cache.Text := 'TServerMethods.GetContacts';
    FGetContactsCommand_Cache.Prepare(TServerMethods_GetContacts_Cache);
  end;
  FGetContactsCommand_Cache.Parameters[0].Value.SetInt32(ClientID);
  FGetContactsCommand_Cache.ExecuteCache(ARequestFilter);
  Result := TDSRestCachedTFDJSONDataSets.Create(FGetContactsCommand_Cache.Parameters[1].Value.GetString);
end;

function TServerMethodsClient.GetClientBookings(ClientID: Integer; const ARequestFilter: string): TFDJSONDataSets;
begin
  if FGetClientBookingsCommand = nil then
  begin
    FGetClientBookingsCommand := FConnection.CreateCommand;
    FGetClientBookingsCommand.RequestType := 'GET';
    FGetClientBookingsCommand.Text := 'TServerMethods.GetClientBookings';
    FGetClientBookingsCommand.Prepare(TServerMethods_GetClientBookings);
  end;
  FGetClientBookingsCommand.Parameters[0].Value.SetInt32(ClientID);
  FGetClientBookingsCommand.Execute(ARequestFilter);
  if not FGetClientBookingsCommand.Parameters[1].Value.IsNull then
  begin
    FUnMarshal := TDSRestCommand(FGetClientBookingsCommand.Parameters[1].ConnectionHandler).GetJSONUnMarshaler;
    try
      Result := TFDJSONDataSets(FUnMarshal.UnMarshal(FGetClientBookingsCommand.Parameters[1].Value.GetJSONValue(True)));
      if FInstanceOwner then
        FGetClientBookingsCommand.FreeOnExecute(Result);
    finally
      FreeAndNil(FUnMarshal)
    end
  end
  else
    Result := nil;
end;

function TServerMethodsClient.GetClientBookings_Cache(ClientID: Integer; const ARequestFilter: string): IDSRestCachedTFDJSONDataSets;
begin
  if FGetClientBookingsCommand_Cache = nil then
  begin
    FGetClientBookingsCommand_Cache := FConnection.CreateCommand;
    FGetClientBookingsCommand_Cache.RequestType := 'GET';
    FGetClientBookingsCommand_Cache.Text := 'TServerMethods.GetClientBookings';
    FGetClientBookingsCommand_Cache.Prepare(TServerMethods_GetClientBookings_Cache);
  end;
  FGetClientBookingsCommand_Cache.Parameters[0].Value.SetInt32(ClientID);
  FGetClientBookingsCommand_Cache.ExecuteCache(ARequestFilter);
  Result := TDSRestCachedTFDJSONDataSets.Create(FGetClientBookingsCommand_Cache.Parameters[1].Value.GetString);
end;

function TServerMethodsClient.SaveClient(DeltaList: TFDJSONDeltas; const ARequestFilter: string): TResultsArray;
begin
  if FSaveClientCommand = nil then
  begin
    FSaveClientCommand := FConnection.CreateCommand;
    FSaveClientCommand.RequestType := 'POST';
    FSaveClientCommand.Text := 'TServerMethods."SaveClient"';
    FSaveClientCommand.Prepare(TServerMethods_SaveClient);
  end;
  if not Assigned(DeltaList) then
    FSaveClientCommand.Parameters[0].Value.SetNull
  else
  begin
    FMarshal := TDSRestCommand(FSaveClientCommand.Parameters[0].ConnectionHandler).GetJSONMarshaler;
    try
      FSaveClientCommand.Parameters[0].Value.SetJSONValue(FMarshal.Marshal(DeltaList), True);
      if FInstanceOwner then
        DeltaList.Free
    finally
      FreeAndNil(FMarshal)
    end
    end;
  FSaveClientCommand.Execute(ARequestFilter);
  if not FSaveClientCommand.Parameters[1].Value.IsNull then
  begin
    FUnMarshal := TDSRestCommand(FSaveClientCommand.Parameters[1].ConnectionHandler).GetJSONUnMarshaler;
    try
      Result := TResultsArray(FUnMarshal.UnMarshal(FSaveClientCommand.Parameters[1].Value.GetJSONValue(True)));
      if FInstanceOwner then
        FSaveClientCommand.FreeOnExecute(Result);
    finally
      FreeAndNil(FUnMarshal)
    end
  end
  else
    Result := nil;
end;

function TServerMethodsClient.SaveClient_Cache(DeltaList: TFDJSONDeltas; const ARequestFilter: string): IDSRestCachedTResultsArray;
begin
  if FSaveClientCommand_Cache = nil then
  begin
    FSaveClientCommand_Cache := FConnection.CreateCommand;
    FSaveClientCommand_Cache.RequestType := 'POST';
    FSaveClientCommand_Cache.Text := 'TServerMethods."SaveClient"';
    FSaveClientCommand_Cache.Prepare(TServerMethods_SaveClient_Cache);
  end;
  if not Assigned(DeltaList) then
    FSaveClientCommand_Cache.Parameters[0].Value.SetNull
  else
  begin
    FMarshal := TDSRestCommand(FSaveClientCommand_Cache.Parameters[0].ConnectionHandler).GetJSONMarshaler;
    try
      FSaveClientCommand_Cache.Parameters[0].Value.SetJSONValue(FMarshal.Marshal(DeltaList), True);
      if FInstanceOwner then
        DeltaList.Free
    finally
      FreeAndNil(FMarshal)
    end
    end;
  FSaveClientCommand_Cache.ExecuteCache(ARequestFilter);
  Result := TDSRestCachedTResultsArray.Create(FSaveClientCommand_Cache.Parameters[1].Value.GetString);
end;

function TServerMethodsClient.SavePeople(DeltaList: TFDJSONDeltas; const ARequestFilter: string): TResultsArray;
begin
  if FSavePeopleCommand = nil then
  begin
    FSavePeopleCommand := FConnection.CreateCommand;
    FSavePeopleCommand.RequestType := 'POST';
    FSavePeopleCommand.Text := 'TServerMethods."SavePeople"';
    FSavePeopleCommand.Prepare(TServerMethods_SavePeople);
  end;
  if not Assigned(DeltaList) then
    FSavePeopleCommand.Parameters[0].Value.SetNull
  else
  begin
    FMarshal := TDSRestCommand(FSavePeopleCommand.Parameters[0].ConnectionHandler).GetJSONMarshaler;
    try
      FSavePeopleCommand.Parameters[0].Value.SetJSONValue(FMarshal.Marshal(DeltaList), True);
      if FInstanceOwner then
        DeltaList.Free
    finally
      FreeAndNil(FMarshal)
    end
    end;
  FSavePeopleCommand.Execute(ARequestFilter);
  if not FSavePeopleCommand.Parameters[1].Value.IsNull then
  begin
    FUnMarshal := TDSRestCommand(FSavePeopleCommand.Parameters[1].ConnectionHandler).GetJSONUnMarshaler;
    try
      Result := TResultsArray(FUnMarshal.UnMarshal(FSavePeopleCommand.Parameters[1].Value.GetJSONValue(True)));
      if FInstanceOwner then
        FSavePeopleCommand.FreeOnExecute(Result);
    finally
      FreeAndNil(FUnMarshal)
    end
  end
  else
    Result := nil;
end;

function TServerMethodsClient.SavePeople_Cache(DeltaList: TFDJSONDeltas; const ARequestFilter: string): IDSRestCachedTResultsArray;
begin
  if FSavePeopleCommand_Cache = nil then
  begin
    FSavePeopleCommand_Cache := FConnection.CreateCommand;
    FSavePeopleCommand_Cache.RequestType := 'POST';
    FSavePeopleCommand_Cache.Text := 'TServerMethods."SavePeople"';
    FSavePeopleCommand_Cache.Prepare(TServerMethods_SavePeople_Cache);
  end;
  if not Assigned(DeltaList) then
    FSavePeopleCommand_Cache.Parameters[0].Value.SetNull
  else
  begin
    FMarshal := TDSRestCommand(FSavePeopleCommand_Cache.Parameters[0].ConnectionHandler).GetJSONMarshaler;
    try
      FSavePeopleCommand_Cache.Parameters[0].Value.SetJSONValue(FMarshal.Marshal(DeltaList), True);
      if FInstanceOwner then
        DeltaList.Free
    finally
      FreeAndNil(FMarshal)
    end
    end;
  FSavePeopleCommand_Cache.ExecuteCache(ARequestFilter);
  Result := TDSRestCachedTResultsArray.Create(FSavePeopleCommand_Cache.Parameters[1].Value.GetString);
end;

function TServerMethodsClient.SaveContacts(DeltaList: TFDJSONDeltas; const ARequestFilter: string): TResultsArray;
begin
  if FSaveContactsCommand = nil then
  begin
    FSaveContactsCommand := FConnection.CreateCommand;
    FSaveContactsCommand.RequestType := 'POST';
    FSaveContactsCommand.Text := 'TServerMethods."SaveContacts"';
    FSaveContactsCommand.Prepare(TServerMethods_SaveContacts);
  end;
  if not Assigned(DeltaList) then
    FSaveContactsCommand.Parameters[0].Value.SetNull
  else
  begin
    FMarshal := TDSRestCommand(FSaveContactsCommand.Parameters[0].ConnectionHandler).GetJSONMarshaler;
    try
      FSaveContactsCommand.Parameters[0].Value.SetJSONValue(FMarshal.Marshal(DeltaList), True);
      if FInstanceOwner then
        DeltaList.Free
    finally
      FreeAndNil(FMarshal)
    end
    end;
  FSaveContactsCommand.Execute(ARequestFilter);
  if not FSaveContactsCommand.Parameters[1].Value.IsNull then
  begin
    FUnMarshal := TDSRestCommand(FSaveContactsCommand.Parameters[1].ConnectionHandler).GetJSONUnMarshaler;
    try
      Result := TResultsArray(FUnMarshal.UnMarshal(FSaveContactsCommand.Parameters[1].Value.GetJSONValue(True)));
      if FInstanceOwner then
        FSaveContactsCommand.FreeOnExecute(Result);
    finally
      FreeAndNil(FUnMarshal)
    end
  end
  else
    Result := nil;
end;

function TServerMethodsClient.SaveContacts_Cache(DeltaList: TFDJSONDeltas; const ARequestFilter: string): IDSRestCachedTResultsArray;
begin
  if FSaveContactsCommand_Cache = nil then
  begin
    FSaveContactsCommand_Cache := FConnection.CreateCommand;
    FSaveContactsCommand_Cache.RequestType := 'POST';
    FSaveContactsCommand_Cache.Text := 'TServerMethods."SaveContacts"';
    FSaveContactsCommand_Cache.Prepare(TServerMethods_SaveContacts_Cache);
  end;
  if not Assigned(DeltaList) then
    FSaveContactsCommand_Cache.Parameters[0].Value.SetNull
  else
  begin
    FMarshal := TDSRestCommand(FSaveContactsCommand_Cache.Parameters[0].ConnectionHandler).GetJSONMarshaler;
    try
      FSaveContactsCommand_Cache.Parameters[0].Value.SetJSONValue(FMarshal.Marshal(DeltaList), True);
      if FInstanceOwner then
        DeltaList.Free
    finally
      FreeAndNil(FMarshal)
    end
    end;
  FSaveContactsCommand_Cache.ExecuteCache(ARequestFilter);
  Result := TDSRestCachedTResultsArray.Create(FSaveContactsCommand_Cache.Parameters[1].Value.GetString);
end;

function TServerMethodsClient.GetBookingByID(BookID: Integer; const ARequestFilter: string): TFDJSONDataSets;
begin
  if FGetBookingByIDCommand = nil then
  begin
    FGetBookingByIDCommand := FConnection.CreateCommand;
    FGetBookingByIDCommand.RequestType := 'GET';
    FGetBookingByIDCommand.Text := 'TServerMethods.GetBookingByID';
    FGetBookingByIDCommand.Prepare(TServerMethods_GetBookingByID);
  end;
  FGetBookingByIDCommand.Parameters[0].Value.SetInt32(BookID);
  FGetBookingByIDCommand.Execute(ARequestFilter);
  if not FGetBookingByIDCommand.Parameters[1].Value.IsNull then
  begin
    FUnMarshal := TDSRestCommand(FGetBookingByIDCommand.Parameters[1].ConnectionHandler).GetJSONUnMarshaler;
    try
      Result := TFDJSONDataSets(FUnMarshal.UnMarshal(FGetBookingByIDCommand.Parameters[1].Value.GetJSONValue(True)));
      if FInstanceOwner then
        FGetBookingByIDCommand.FreeOnExecute(Result);
    finally
      FreeAndNil(FUnMarshal)
    end
  end
  else
    Result := nil;
end;

function TServerMethodsClient.GetBookingByID_Cache(BookID: Integer; const ARequestFilter: string): IDSRestCachedTFDJSONDataSets;
begin
  if FGetBookingByIDCommand_Cache = nil then
  begin
    FGetBookingByIDCommand_Cache := FConnection.CreateCommand;
    FGetBookingByIDCommand_Cache.RequestType := 'GET';
    FGetBookingByIDCommand_Cache.Text := 'TServerMethods.GetBookingByID';
    FGetBookingByIDCommand_Cache.Prepare(TServerMethods_GetBookingByID_Cache);
  end;
  FGetBookingByIDCommand_Cache.Parameters[0].Value.SetInt32(BookID);
  FGetBookingByIDCommand_Cache.ExecuteCache(ARequestFilter);
  Result := TDSRestCachedTFDJSONDataSets.Create(FGetBookingByIDCommand_Cache.Parameters[1].Value.GetString);
end;

function TServerMethodsClient.GetRentals(BookID: Integer; const ARequestFilter: string): TFDJSONDataSets;
begin
  if FGetRentalsCommand = nil then
  begin
    FGetRentalsCommand := FConnection.CreateCommand;
    FGetRentalsCommand.RequestType := 'GET';
    FGetRentalsCommand.Text := 'TServerMethods.GetRentals';
    FGetRentalsCommand.Prepare(TServerMethods_GetRentals);
  end;
  FGetRentalsCommand.Parameters[0].Value.SetInt32(BookID);
  FGetRentalsCommand.Execute(ARequestFilter);
  if not FGetRentalsCommand.Parameters[1].Value.IsNull then
  begin
    FUnMarshal := TDSRestCommand(FGetRentalsCommand.Parameters[1].ConnectionHandler).GetJSONUnMarshaler;
    try
      Result := TFDJSONDataSets(FUnMarshal.UnMarshal(FGetRentalsCommand.Parameters[1].Value.GetJSONValue(True)));
      if FInstanceOwner then
        FGetRentalsCommand.FreeOnExecute(Result);
    finally
      FreeAndNil(FUnMarshal)
    end
  end
  else
    Result := nil;
end;

function TServerMethodsClient.GetRentals_Cache(BookID: Integer; const ARequestFilter: string): IDSRestCachedTFDJSONDataSets;
begin
  if FGetRentalsCommand_Cache = nil then
  begin
    FGetRentalsCommand_Cache := FConnection.CreateCommand;
    FGetRentalsCommand_Cache.RequestType := 'GET';
    FGetRentalsCommand_Cache.Text := 'TServerMethods.GetRentals';
    FGetRentalsCommand_Cache.Prepare(TServerMethods_GetRentals_Cache);
  end;
  FGetRentalsCommand_Cache.Parameters[0].Value.SetInt32(BookID);
  FGetRentalsCommand_Cache.ExecuteCache(ARequestFilter);
  Result := TDSRestCachedTFDJSONDataSets.Create(FGetRentalsCommand_Cache.Parameters[1].Value.GetString);
end;

function TServerMethodsClient.GetRentAccoms(IDList: string; const ARequestFilter: string): TFDJSONDataSets;
begin
  if FGetRentAccomsCommand = nil then
  begin
    FGetRentAccomsCommand := FConnection.CreateCommand;
    FGetRentAccomsCommand.RequestType := 'GET';
    FGetRentAccomsCommand.Text := 'TServerMethods.GetRentAccoms';
    FGetRentAccomsCommand.Prepare(TServerMethods_GetRentAccoms);
  end;
  FGetRentAccomsCommand.Parameters[0].Value.SetWideString(IDList);
  FGetRentAccomsCommand.Execute(ARequestFilter);
  if not FGetRentAccomsCommand.Parameters[1].Value.IsNull then
  begin
    FUnMarshal := TDSRestCommand(FGetRentAccomsCommand.Parameters[1].ConnectionHandler).GetJSONUnMarshaler;
    try
      Result := TFDJSONDataSets(FUnMarshal.UnMarshal(FGetRentAccomsCommand.Parameters[1].Value.GetJSONValue(True)));
      if FInstanceOwner then
        FGetRentAccomsCommand.FreeOnExecute(Result);
    finally
      FreeAndNil(FUnMarshal)
    end
  end
  else
    Result := nil;
end;

function TServerMethodsClient.GetRentAccoms_Cache(IDList: string; const ARequestFilter: string): IDSRestCachedTFDJSONDataSets;
begin
  if FGetRentAccomsCommand_Cache = nil then
  begin
    FGetRentAccomsCommand_Cache := FConnection.CreateCommand;
    FGetRentAccomsCommand_Cache.RequestType := 'GET';
    FGetRentAccomsCommand_Cache.Text := 'TServerMethods.GetRentAccoms';
    FGetRentAccomsCommand_Cache.Prepare(TServerMethods_GetRentAccoms_Cache);
  end;
  FGetRentAccomsCommand_Cache.Parameters[0].Value.SetWideString(IDList);
  FGetRentAccomsCommand_Cache.ExecuteCache(ARequestFilter);
  Result := TDSRestCachedTFDJSONDataSets.Create(FGetRentAccomsCommand_Cache.Parameters[1].Value.GetString);
end;

function TServerMethodsClient.GetPayments(BookID: Integer; const ARequestFilter: string): TFDJSONDataSets;
begin
  if FGetPaymentsCommand = nil then
  begin
    FGetPaymentsCommand := FConnection.CreateCommand;
    FGetPaymentsCommand.RequestType := 'GET';
    FGetPaymentsCommand.Text := 'TServerMethods.GetPayments';
    FGetPaymentsCommand.Prepare(TServerMethods_GetPayments);
  end;
  FGetPaymentsCommand.Parameters[0].Value.SetInt32(BookID);
  FGetPaymentsCommand.Execute(ARequestFilter);
  if not FGetPaymentsCommand.Parameters[1].Value.IsNull then
  begin
    FUnMarshal := TDSRestCommand(FGetPaymentsCommand.Parameters[1].ConnectionHandler).GetJSONUnMarshaler;
    try
      Result := TFDJSONDataSets(FUnMarshal.UnMarshal(FGetPaymentsCommand.Parameters[1].Value.GetJSONValue(True)));
      if FInstanceOwner then
        FGetPaymentsCommand.FreeOnExecute(Result);
    finally
      FreeAndNil(FUnMarshal)
    end
  end
  else
    Result := nil;
end;

function TServerMethodsClient.GetPayments_Cache(BookID: Integer; const ARequestFilter: string): IDSRestCachedTFDJSONDataSets;
begin
  if FGetPaymentsCommand_Cache = nil then
  begin
    FGetPaymentsCommand_Cache := FConnection.CreateCommand;
    FGetPaymentsCommand_Cache.RequestType := 'GET';
    FGetPaymentsCommand_Cache.Text := 'TServerMethods.GetPayments';
    FGetPaymentsCommand_Cache.Prepare(TServerMethods_GetPayments_Cache);
  end;
  FGetPaymentsCommand_Cache.Parameters[0].Value.SetInt32(BookID);
  FGetPaymentsCommand_Cache.ExecuteCache(ARequestFilter);
  Result := TDSRestCachedTFDJSONDataSets.Create(FGetPaymentsCommand_Cache.Parameters[1].Value.GetString);
end;

function TServerMethodsClient.GetTravel(BookID: Integer; const ARequestFilter: string): TFDJSONDataSets;
begin
  if FGetTravelCommand = nil then
  begin
    FGetTravelCommand := FConnection.CreateCommand;
    FGetTravelCommand.RequestType := 'GET';
    FGetTravelCommand.Text := 'TServerMethods.GetTravel';
    FGetTravelCommand.Prepare(TServerMethods_GetTravel);
  end;
  FGetTravelCommand.Parameters[0].Value.SetInt32(BookID);
  FGetTravelCommand.Execute(ARequestFilter);
  if not FGetTravelCommand.Parameters[1].Value.IsNull then
  begin
    FUnMarshal := TDSRestCommand(FGetTravelCommand.Parameters[1].ConnectionHandler).GetJSONUnMarshaler;
    try
      Result := TFDJSONDataSets(FUnMarshal.UnMarshal(FGetTravelCommand.Parameters[1].Value.GetJSONValue(True)));
      if FInstanceOwner then
        FGetTravelCommand.FreeOnExecute(Result);
    finally
      FreeAndNil(FUnMarshal)
    end
  end
  else
    Result := nil;
end;

function TServerMethodsClient.GetTravel_Cache(BookID: Integer; const ARequestFilter: string): IDSRestCachedTFDJSONDataSets;
begin
  if FGetTravelCommand_Cache = nil then
  begin
    FGetTravelCommand_Cache := FConnection.CreateCommand;
    FGetTravelCommand_Cache.RequestType := 'GET';
    FGetTravelCommand_Cache.Text := 'TServerMethods.GetTravel';
    FGetTravelCommand_Cache.Prepare(TServerMethods_GetTravel_Cache);
  end;
  FGetTravelCommand_Cache.Parameters[0].Value.SetInt32(BookID);
  FGetTravelCommand_Cache.ExecuteCache(ARequestFilter);
  Result := TDSRestCachedTFDJSONDataSets.Create(FGetTravelCommand_Cache.Parameters[1].Value.GetString);
end;

function TServerMethodsClient.GetBookingPerson(BookID: Integer; const ARequestFilter: string): TFDJSONDataSets;
begin
  if FGetBookingPersonCommand = nil then
  begin
    FGetBookingPersonCommand := FConnection.CreateCommand;
    FGetBookingPersonCommand.RequestType := 'GET';
    FGetBookingPersonCommand.Text := 'TServerMethods.GetBookingPerson';
    FGetBookingPersonCommand.Prepare(TServerMethods_GetBookingPerson);
  end;
  FGetBookingPersonCommand.Parameters[0].Value.SetInt32(BookID);
  FGetBookingPersonCommand.Execute(ARequestFilter);
  if not FGetBookingPersonCommand.Parameters[1].Value.IsNull then
  begin
    FUnMarshal := TDSRestCommand(FGetBookingPersonCommand.Parameters[1].ConnectionHandler).GetJSONUnMarshaler;
    try
      Result := TFDJSONDataSets(FUnMarshal.UnMarshal(FGetBookingPersonCommand.Parameters[1].Value.GetJSONValue(True)));
      if FInstanceOwner then
        FGetBookingPersonCommand.FreeOnExecute(Result);
    finally
      FreeAndNil(FUnMarshal)
    end
  end
  else
    Result := nil;
end;

function TServerMethodsClient.GetBookingPerson_Cache(BookID: Integer; const ARequestFilter: string): IDSRestCachedTFDJSONDataSets;
begin
  if FGetBookingPersonCommand_Cache = nil then
  begin
    FGetBookingPersonCommand_Cache := FConnection.CreateCommand;
    FGetBookingPersonCommand_Cache.RequestType := 'GET';
    FGetBookingPersonCommand_Cache.Text := 'TServerMethods.GetBookingPerson';
    FGetBookingPersonCommand_Cache.Prepare(TServerMethods_GetBookingPerson_Cache);
  end;
  FGetBookingPersonCommand_Cache.Parameters[0].Value.SetInt32(BookID);
  FGetBookingPersonCommand_Cache.ExecuteCache(ARequestFilter);
  Result := TDSRestCachedTFDJSONDataSets.Create(FGetBookingPersonCommand_Cache.Parameters[1].Value.GetString);
end;

function TServerMethodsClient.CheckRentalAvailable(AccomID: Integer; StartDate: TDateTime; EndDate: TDateTime; RentID: Integer; const ARequestFilter: string): Boolean;
begin
  if FCheckRentalAvailableCommand = nil then
  begin
    FCheckRentalAvailableCommand := FConnection.CreateCommand;
    FCheckRentalAvailableCommand.RequestType := 'GET';
    FCheckRentalAvailableCommand.Text := 'TServerMethods.CheckRentalAvailable';
    FCheckRentalAvailableCommand.Prepare(TServerMethods_CheckRentalAvailable);
  end;
  FCheckRentalAvailableCommand.Parameters[0].Value.SetInt32(AccomID);
  FCheckRentalAvailableCommand.Parameters[1].Value.AsDateTime := StartDate;
  FCheckRentalAvailableCommand.Parameters[2].Value.AsDateTime := EndDate;
  FCheckRentalAvailableCommand.Parameters[3].Value.SetInt32(RentID);
  FCheckRentalAvailableCommand.Execute(ARequestFilter);
  Result := FCheckRentalAvailableCommand.Parameters[4].Value.GetBoolean;
end;

function TServerMethodsClient.CheckAllAvailable(StartDate: TDateTime; EndDate: TDateTime; RentID: Integer; const ARequestFilter: string): Boolean;
begin
  if FCheckAllAvailableCommand = nil then
  begin
    FCheckAllAvailableCommand := FConnection.CreateCommand;
    FCheckAllAvailableCommand.RequestType := 'GET';
    FCheckAllAvailableCommand.Text := 'TServerMethods.CheckAllAvailable';
    FCheckAllAvailableCommand.Prepare(TServerMethods_CheckAllAvailable);
  end;
  FCheckAllAvailableCommand.Parameters[0].Value.AsDateTime := StartDate;
  FCheckAllAvailableCommand.Parameters[1].Value.AsDateTime := EndDate;
  FCheckAllAvailableCommand.Parameters[2].Value.SetInt32(RentID);
  FCheckAllAvailableCommand.Execute(ARequestFilter);
  Result := FCheckAllAvailableCommand.Parameters[3].Value.GetBoolean;
end;

function TServerMethodsClient.SaveBookings(DeltaList: TFDJSONDeltas; const ARequestFilter: string): TResultsArray;
begin
  if FSaveBookingsCommand = nil then
  begin
    FSaveBookingsCommand := FConnection.CreateCommand;
    FSaveBookingsCommand.RequestType := 'POST';
    FSaveBookingsCommand.Text := 'TServerMethods."SaveBookings"';
    FSaveBookingsCommand.Prepare(TServerMethods_SaveBookings);
  end;
  if not Assigned(DeltaList) then
    FSaveBookingsCommand.Parameters[0].Value.SetNull
  else
  begin
    FMarshal := TDSRestCommand(FSaveBookingsCommand.Parameters[0].ConnectionHandler).GetJSONMarshaler;
    try
      FSaveBookingsCommand.Parameters[0].Value.SetJSONValue(FMarshal.Marshal(DeltaList), True);
      if FInstanceOwner then
        DeltaList.Free
    finally
      FreeAndNil(FMarshal)
    end
    end;
  FSaveBookingsCommand.Execute(ARequestFilter);
  if not FSaveBookingsCommand.Parameters[1].Value.IsNull then
  begin
    FUnMarshal := TDSRestCommand(FSaveBookingsCommand.Parameters[1].ConnectionHandler).GetJSONUnMarshaler;
    try
      Result := TResultsArray(FUnMarshal.UnMarshal(FSaveBookingsCommand.Parameters[1].Value.GetJSONValue(True)));
      if FInstanceOwner then
        FSaveBookingsCommand.FreeOnExecute(Result);
    finally
      FreeAndNil(FUnMarshal)
    end
  end
  else
    Result := nil;
end;

function TServerMethodsClient.SaveBookings_Cache(DeltaList: TFDJSONDeltas; const ARequestFilter: string): IDSRestCachedTResultsArray;
begin
  if FSaveBookingsCommand_Cache = nil then
  begin
    FSaveBookingsCommand_Cache := FConnection.CreateCommand;
    FSaveBookingsCommand_Cache.RequestType := 'POST';
    FSaveBookingsCommand_Cache.Text := 'TServerMethods."SaveBookings"';
    FSaveBookingsCommand_Cache.Prepare(TServerMethods_SaveBookings_Cache);
  end;
  if not Assigned(DeltaList) then
    FSaveBookingsCommand_Cache.Parameters[0].Value.SetNull
  else
  begin
    FMarshal := TDSRestCommand(FSaveBookingsCommand_Cache.Parameters[0].ConnectionHandler).GetJSONMarshaler;
    try
      FSaveBookingsCommand_Cache.Parameters[0].Value.SetJSONValue(FMarshal.Marshal(DeltaList), True);
      if FInstanceOwner then
        DeltaList.Free
    finally
      FreeAndNil(FMarshal)
    end
    end;
  FSaveBookingsCommand_Cache.ExecuteCache(ARequestFilter);
  Result := TDSRestCachedTResultsArray.Create(FSaveBookingsCommand_Cache.Parameters[1].Value.GetString);
end;

function TServerMethodsClient.SaveRentals(DeltaList: TFDJSONDeltas; const ARequestFilter: string): TResultsArray;
begin
  if FSaveRentalsCommand = nil then
  begin
    FSaveRentalsCommand := FConnection.CreateCommand;
    FSaveRentalsCommand.RequestType := 'POST';
    FSaveRentalsCommand.Text := 'TServerMethods."SaveRentals"';
    FSaveRentalsCommand.Prepare(TServerMethods_SaveRentals);
  end;
  if not Assigned(DeltaList) then
    FSaveRentalsCommand.Parameters[0].Value.SetNull
  else
  begin
    FMarshal := TDSRestCommand(FSaveRentalsCommand.Parameters[0].ConnectionHandler).GetJSONMarshaler;
    try
      FSaveRentalsCommand.Parameters[0].Value.SetJSONValue(FMarshal.Marshal(DeltaList), True);
      if FInstanceOwner then
        DeltaList.Free
    finally
      FreeAndNil(FMarshal)
    end
    end;
  FSaveRentalsCommand.Execute(ARequestFilter);
  if not FSaveRentalsCommand.Parameters[1].Value.IsNull then
  begin
    FUnMarshal := TDSRestCommand(FSaveRentalsCommand.Parameters[1].ConnectionHandler).GetJSONUnMarshaler;
    try
      Result := TResultsArray(FUnMarshal.UnMarshal(FSaveRentalsCommand.Parameters[1].Value.GetJSONValue(True)));
      if FInstanceOwner then
        FSaveRentalsCommand.FreeOnExecute(Result);
    finally
      FreeAndNil(FUnMarshal)
    end
  end
  else
    Result := nil;
end;

function TServerMethodsClient.SaveRentals_Cache(DeltaList: TFDJSONDeltas; const ARequestFilter: string): IDSRestCachedTResultsArray;
begin
  if FSaveRentalsCommand_Cache = nil then
  begin
    FSaveRentalsCommand_Cache := FConnection.CreateCommand;
    FSaveRentalsCommand_Cache.RequestType := 'POST';
    FSaveRentalsCommand_Cache.Text := 'TServerMethods."SaveRentals"';
    FSaveRentalsCommand_Cache.Prepare(TServerMethods_SaveRentals_Cache);
  end;
  if not Assigned(DeltaList) then
    FSaveRentalsCommand_Cache.Parameters[0].Value.SetNull
  else
  begin
    FMarshal := TDSRestCommand(FSaveRentalsCommand_Cache.Parameters[0].ConnectionHandler).GetJSONMarshaler;
    try
      FSaveRentalsCommand_Cache.Parameters[0].Value.SetJSONValue(FMarshal.Marshal(DeltaList), True);
      if FInstanceOwner then
        DeltaList.Free
    finally
      FreeAndNil(FMarshal)
    end
    end;
  FSaveRentalsCommand_Cache.ExecuteCache(ARequestFilter);
  Result := TDSRestCachedTResultsArray.Create(FSaveRentalsCommand_Cache.Parameters[1].Value.GetString);
end;

procedure TServerMethodsClient.SaveRentAccoms(DeltaList: TFDJSONDeltas);
begin
  if FSaveRentAccomsCommand = nil then
  begin
    FSaveRentAccomsCommand := FConnection.CreateCommand;
    FSaveRentAccomsCommand.RequestType := 'POST';
    FSaveRentAccomsCommand.Text := 'TServerMethods."SaveRentAccoms"';
    FSaveRentAccomsCommand.Prepare(TServerMethods_SaveRentAccoms);
  end;
  if not Assigned(DeltaList) then
    FSaveRentAccomsCommand.Parameters[0].Value.SetNull
  else
  begin
    FMarshal := TDSRestCommand(FSaveRentAccomsCommand.Parameters[0].ConnectionHandler).GetJSONMarshaler;
    try
      FSaveRentAccomsCommand.Parameters[0].Value.SetJSONValue(FMarshal.Marshal(DeltaList), True);
      if FInstanceOwner then
        DeltaList.Free
    finally
      FreeAndNil(FMarshal)
    end
    end;
  FSaveRentAccomsCommand.Execute;
end;

function TServerMethodsClient.SavePayments(DeltaList: TFDJSONDeltas; const ARequestFilter: string): TResultsArray;
begin
  if FSavePaymentsCommand = nil then
  begin
    FSavePaymentsCommand := FConnection.CreateCommand;
    FSavePaymentsCommand.RequestType := 'POST';
    FSavePaymentsCommand.Text := 'TServerMethods."SavePayments"';
    FSavePaymentsCommand.Prepare(TServerMethods_SavePayments);
  end;
  if not Assigned(DeltaList) then
    FSavePaymentsCommand.Parameters[0].Value.SetNull
  else
  begin
    FMarshal := TDSRestCommand(FSavePaymentsCommand.Parameters[0].ConnectionHandler).GetJSONMarshaler;
    try
      FSavePaymentsCommand.Parameters[0].Value.SetJSONValue(FMarshal.Marshal(DeltaList), True);
      if FInstanceOwner then
        DeltaList.Free
    finally
      FreeAndNil(FMarshal)
    end
    end;
  FSavePaymentsCommand.Execute(ARequestFilter);
  if not FSavePaymentsCommand.Parameters[1].Value.IsNull then
  begin
    FUnMarshal := TDSRestCommand(FSavePaymentsCommand.Parameters[1].ConnectionHandler).GetJSONUnMarshaler;
    try
      Result := TResultsArray(FUnMarshal.UnMarshal(FSavePaymentsCommand.Parameters[1].Value.GetJSONValue(True)));
      if FInstanceOwner then
        FSavePaymentsCommand.FreeOnExecute(Result);
    finally
      FreeAndNil(FUnMarshal)
    end
  end
  else
    Result := nil;
end;

function TServerMethodsClient.SavePayments_Cache(DeltaList: TFDJSONDeltas; const ARequestFilter: string): IDSRestCachedTResultsArray;
begin
  if FSavePaymentsCommand_Cache = nil then
  begin
    FSavePaymentsCommand_Cache := FConnection.CreateCommand;
    FSavePaymentsCommand_Cache.RequestType := 'POST';
    FSavePaymentsCommand_Cache.Text := 'TServerMethods."SavePayments"';
    FSavePaymentsCommand_Cache.Prepare(TServerMethods_SavePayments_Cache);
  end;
  if not Assigned(DeltaList) then
    FSavePaymentsCommand_Cache.Parameters[0].Value.SetNull
  else
  begin
    FMarshal := TDSRestCommand(FSavePaymentsCommand_Cache.Parameters[0].ConnectionHandler).GetJSONMarshaler;
    try
      FSavePaymentsCommand_Cache.Parameters[0].Value.SetJSONValue(FMarshal.Marshal(DeltaList), True);
      if FInstanceOwner then
        DeltaList.Free
    finally
      FreeAndNil(FMarshal)
    end
    end;
  FSavePaymentsCommand_Cache.ExecuteCache(ARequestFilter);
  Result := TDSRestCachedTResultsArray.Create(FSavePaymentsCommand_Cache.Parameters[1].Value.GetString);
end;

function TServerMethodsClient.SaveTravel(DeltaList: TFDJSONDeltas; const ARequestFilter: string): TResultsArray;
begin
  if FSaveTravelCommand = nil then
  begin
    FSaveTravelCommand := FConnection.CreateCommand;
    FSaveTravelCommand.RequestType := 'POST';
    FSaveTravelCommand.Text := 'TServerMethods."SaveTravel"';
    FSaveTravelCommand.Prepare(TServerMethods_SaveTravel);
  end;
  if not Assigned(DeltaList) then
    FSaveTravelCommand.Parameters[0].Value.SetNull
  else
  begin
    FMarshal := TDSRestCommand(FSaveTravelCommand.Parameters[0].ConnectionHandler).GetJSONMarshaler;
    try
      FSaveTravelCommand.Parameters[0].Value.SetJSONValue(FMarshal.Marshal(DeltaList), True);
      if FInstanceOwner then
        DeltaList.Free
    finally
      FreeAndNil(FMarshal)
    end
    end;
  FSaveTravelCommand.Execute(ARequestFilter);
  if not FSaveTravelCommand.Parameters[1].Value.IsNull then
  begin
    FUnMarshal := TDSRestCommand(FSaveTravelCommand.Parameters[1].ConnectionHandler).GetJSONUnMarshaler;
    try
      Result := TResultsArray(FUnMarshal.UnMarshal(FSaveTravelCommand.Parameters[1].Value.GetJSONValue(True)));
      if FInstanceOwner then
        FSaveTravelCommand.FreeOnExecute(Result);
    finally
      FreeAndNil(FUnMarshal)
    end
  end
  else
    Result := nil;
end;

function TServerMethodsClient.SaveTravel_Cache(DeltaList: TFDJSONDeltas; const ARequestFilter: string): IDSRestCachedTResultsArray;
begin
  if FSaveTravelCommand_Cache = nil then
  begin
    FSaveTravelCommand_Cache := FConnection.CreateCommand;
    FSaveTravelCommand_Cache.RequestType := 'POST';
    FSaveTravelCommand_Cache.Text := 'TServerMethods."SaveTravel"';
    FSaveTravelCommand_Cache.Prepare(TServerMethods_SaveTravel_Cache);
  end;
  if not Assigned(DeltaList) then
    FSaveTravelCommand_Cache.Parameters[0].Value.SetNull
  else
  begin
    FMarshal := TDSRestCommand(FSaveTravelCommand_Cache.Parameters[0].ConnectionHandler).GetJSONMarshaler;
    try
      FSaveTravelCommand_Cache.Parameters[0].Value.SetJSONValue(FMarshal.Marshal(DeltaList), True);
      if FInstanceOwner then
        DeltaList.Free
    finally
      FreeAndNil(FMarshal)
    end
    end;
  FSaveTravelCommand_Cache.ExecuteCache(ARequestFilter);
  Result := TDSRestCachedTResultsArray.Create(FSaveTravelCommand_Cache.Parameters[1].Value.GetString);
end;

procedure TServerMethodsClient.SaveBookingPerson(DeltaList: TFDJSONDeltas);
begin
  if FSaveBookingPersonCommand = nil then
  begin
    FSaveBookingPersonCommand := FConnection.CreateCommand;
    FSaveBookingPersonCommand.RequestType := 'POST';
    FSaveBookingPersonCommand.Text := 'TServerMethods."SaveBookingPerson"';
    FSaveBookingPersonCommand.Prepare(TServerMethods_SaveBookingPerson);
  end;
  if not Assigned(DeltaList) then
    FSaveBookingPersonCommand.Parameters[0].Value.SetNull
  else
  begin
    FMarshal := TDSRestCommand(FSaveBookingPersonCommand.Parameters[0].ConnectionHandler).GetJSONMarshaler;
    try
      FSaveBookingPersonCommand.Parameters[0].Value.SetJSONValue(FMarshal.Marshal(DeltaList), True);
      if FInstanceOwner then
        DeltaList.Free
    finally
      FreeAndNil(FMarshal)
    end
    end;
  FSaveBookingPersonCommand.Execute;
end;

function TServerMethodsClient.GetBanks(const ARequestFilter: string): TFDJSONDataSets;
begin
  if FGetBanksCommand = nil then
  begin
    FGetBanksCommand := FConnection.CreateCommand;
    FGetBanksCommand.RequestType := 'GET';
    FGetBanksCommand.Text := 'TServerMethods.GetBanks';
    FGetBanksCommand.Prepare(TServerMethods_GetBanks);
  end;
  FGetBanksCommand.Execute(ARequestFilter);
  if not FGetBanksCommand.Parameters[0].Value.IsNull then
  begin
    FUnMarshal := TDSRestCommand(FGetBanksCommand.Parameters[0].ConnectionHandler).GetJSONUnMarshaler;
    try
      Result := TFDJSONDataSets(FUnMarshal.UnMarshal(FGetBanksCommand.Parameters[0].Value.GetJSONValue(True)));
      if FInstanceOwner then
        FGetBanksCommand.FreeOnExecute(Result);
    finally
      FreeAndNil(FUnMarshal)
    end
  end
  else
    Result := nil;
end;

function TServerMethodsClient.GetBanks_Cache(const ARequestFilter: string): IDSRestCachedTFDJSONDataSets;
begin
  if FGetBanksCommand_Cache = nil then
  begin
    FGetBanksCommand_Cache := FConnection.CreateCommand;
    FGetBanksCommand_Cache.RequestType := 'GET';
    FGetBanksCommand_Cache.Text := 'TServerMethods.GetBanks';
    FGetBanksCommand_Cache.Prepare(TServerMethods_GetBanks_Cache);
  end;
  FGetBanksCommand_Cache.ExecuteCache(ARequestFilter);
  Result := TDSRestCachedTFDJSONDataSets.Create(FGetBanksCommand_Cache.Parameters[0].Value.GetString);
end;

function TServerMethodsClient.GetBankByID(BankID: Integer; const ARequestFilter: string): string;
begin
  if FGetBankByIDCommand = nil then
  begin
    FGetBankByIDCommand := FConnection.CreateCommand;
    FGetBankByIDCommand.RequestType := 'GET';
    FGetBankByIDCommand.Text := 'TServerMethods.GetBankByID';
    FGetBankByIDCommand.Prepare(TServerMethods_GetBankByID);
  end;
  FGetBankByIDCommand.Parameters[0].Value.SetInt32(BankID);
  FGetBankByIDCommand.Execute(ARequestFilter);
  Result := FGetBankByIDCommand.Parameters[1].Value.GetWideString;
end;

function TServerMethodsClient.GetAccoms(const ARequestFilter: string): TFDJSONDataSets;
begin
  if FGetAccomsCommand = nil then
  begin
    FGetAccomsCommand := FConnection.CreateCommand;
    FGetAccomsCommand.RequestType := 'GET';
    FGetAccomsCommand.Text := 'TServerMethods.GetAccoms';
    FGetAccomsCommand.Prepare(TServerMethods_GetAccoms);
  end;
  FGetAccomsCommand.Execute(ARequestFilter);
  if not FGetAccomsCommand.Parameters[0].Value.IsNull then
  begin
    FUnMarshal := TDSRestCommand(FGetAccomsCommand.Parameters[0].ConnectionHandler).GetJSONUnMarshaler;
    try
      Result := TFDJSONDataSets(FUnMarshal.UnMarshal(FGetAccomsCommand.Parameters[0].Value.GetJSONValue(True)));
      if FInstanceOwner then
        FGetAccomsCommand.FreeOnExecute(Result);
    finally
      FreeAndNil(FUnMarshal)
    end
  end
  else
    Result := nil;
end;

function TServerMethodsClient.GetAccoms_Cache(const ARequestFilter: string): IDSRestCachedTFDJSONDataSets;
begin
  if FGetAccomsCommand_Cache = nil then
  begin
    FGetAccomsCommand_Cache := FConnection.CreateCommand;
    FGetAccomsCommand_Cache.RequestType := 'GET';
    FGetAccomsCommand_Cache.Text := 'TServerMethods.GetAccoms';
    FGetAccomsCommand_Cache.Prepare(TServerMethods_GetAccoms_Cache);
  end;
  FGetAccomsCommand_Cache.ExecuteCache(ARequestFilter);
  Result := TDSRestCachedTFDJSONDataSets.Create(FGetAccomsCommand_Cache.Parameters[0].Value.GetString);
end;

function TServerMethodsClient.GetUpcomingDeposits(Limit: Integer; const ARequestFilter: string): TFDJSONDataSets;
begin
  if FGetUpcomingDepositsCommand = nil then
  begin
    FGetUpcomingDepositsCommand := FConnection.CreateCommand;
    FGetUpcomingDepositsCommand.RequestType := 'GET';
    FGetUpcomingDepositsCommand.Text := 'TServerMethods.GetUpcomingDeposits';
    FGetUpcomingDepositsCommand.Prepare(TServerMethods_GetUpcomingDeposits);
  end;
  FGetUpcomingDepositsCommand.Parameters[0].Value.SetInt32(Limit);
  FGetUpcomingDepositsCommand.Execute(ARequestFilter);
  if not FGetUpcomingDepositsCommand.Parameters[1].Value.IsNull then
  begin
    FUnMarshal := TDSRestCommand(FGetUpcomingDepositsCommand.Parameters[1].ConnectionHandler).GetJSONUnMarshaler;
    try
      Result := TFDJSONDataSets(FUnMarshal.UnMarshal(FGetUpcomingDepositsCommand.Parameters[1].Value.GetJSONValue(True)));
      if FInstanceOwner then
        FGetUpcomingDepositsCommand.FreeOnExecute(Result);
    finally
      FreeAndNil(FUnMarshal)
    end
  end
  else
    Result := nil;
end;

function TServerMethodsClient.GetUpcomingDeposits_Cache(Limit: Integer; const ARequestFilter: string): IDSRestCachedTFDJSONDataSets;
begin
  if FGetUpcomingDepositsCommand_Cache = nil then
  begin
    FGetUpcomingDepositsCommand_Cache := FConnection.CreateCommand;
    FGetUpcomingDepositsCommand_Cache.RequestType := 'GET';
    FGetUpcomingDepositsCommand_Cache.Text := 'TServerMethods.GetUpcomingDeposits';
    FGetUpcomingDepositsCommand_Cache.Prepare(TServerMethods_GetUpcomingDeposits_Cache);
  end;
  FGetUpcomingDepositsCommand_Cache.Parameters[0].Value.SetInt32(Limit);
  FGetUpcomingDepositsCommand_Cache.ExecuteCache(ARequestFilter);
  Result := TDSRestCachedTFDJSONDataSets.Create(FGetUpcomingDepositsCommand_Cache.Parameters[1].Value.GetString);
end;

function TServerMethodsClient.GetRecentBookings(Limit: Integer; const ARequestFilter: string): TFDJSONDataSets;
begin
  if FGetRecentBookingsCommand = nil then
  begin
    FGetRecentBookingsCommand := FConnection.CreateCommand;
    FGetRecentBookingsCommand.RequestType := 'GET';
    FGetRecentBookingsCommand.Text := 'TServerMethods.GetRecentBookings';
    FGetRecentBookingsCommand.Prepare(TServerMethods_GetRecentBookings);
  end;
  FGetRecentBookingsCommand.Parameters[0].Value.SetInt32(Limit);
  FGetRecentBookingsCommand.Execute(ARequestFilter);
  if not FGetRecentBookingsCommand.Parameters[1].Value.IsNull then
  begin
    FUnMarshal := TDSRestCommand(FGetRecentBookingsCommand.Parameters[1].ConnectionHandler).GetJSONUnMarshaler;
    try
      Result := TFDJSONDataSets(FUnMarshal.UnMarshal(FGetRecentBookingsCommand.Parameters[1].Value.GetJSONValue(True)));
      if FInstanceOwner then
        FGetRecentBookingsCommand.FreeOnExecute(Result);
    finally
      FreeAndNil(FUnMarshal)
    end
  end
  else
    Result := nil;
end;

function TServerMethodsClient.GetRecentBookings_Cache(Limit: Integer; const ARequestFilter: string): IDSRestCachedTFDJSONDataSets;
begin
  if FGetRecentBookingsCommand_Cache = nil then
  begin
    FGetRecentBookingsCommand_Cache := FConnection.CreateCommand;
    FGetRecentBookingsCommand_Cache.RequestType := 'GET';
    FGetRecentBookingsCommand_Cache.Text := 'TServerMethods.GetRecentBookings';
    FGetRecentBookingsCommand_Cache.Prepare(TServerMethods_GetRecentBookings_Cache);
  end;
  FGetRecentBookingsCommand_Cache.Parameters[0].Value.SetInt32(Limit);
  FGetRecentBookingsCommand_Cache.ExecuteCache(ARequestFilter);
  Result := TDSRestCachedTFDJSONDataSets.Create(FGetRecentBookingsCommand_Cache.Parameters[1].Value.GetString);
end;

function TServerMethodsClient.GetRecentClients(Limit: Integer; const ARequestFilter: string): TFDJSONDataSets;
begin
  if FGetRecentClientsCommand = nil then
  begin
    FGetRecentClientsCommand := FConnection.CreateCommand;
    FGetRecentClientsCommand.RequestType := 'GET';
    FGetRecentClientsCommand.Text := 'TServerMethods.GetRecentClients';
    FGetRecentClientsCommand.Prepare(TServerMethods_GetRecentClients);
  end;
  FGetRecentClientsCommand.Parameters[0].Value.SetInt32(Limit);
  FGetRecentClientsCommand.Execute(ARequestFilter);
  if not FGetRecentClientsCommand.Parameters[1].Value.IsNull then
  begin
    FUnMarshal := TDSRestCommand(FGetRecentClientsCommand.Parameters[1].ConnectionHandler).GetJSONUnMarshaler;
    try
      Result := TFDJSONDataSets(FUnMarshal.UnMarshal(FGetRecentClientsCommand.Parameters[1].Value.GetJSONValue(True)));
      if FInstanceOwner then
        FGetRecentClientsCommand.FreeOnExecute(Result);
    finally
      FreeAndNil(FUnMarshal)
    end
  end
  else
    Result := nil;
end;

function TServerMethodsClient.GetRecentClients_Cache(Limit: Integer; const ARequestFilter: string): IDSRestCachedTFDJSONDataSets;
begin
  if FGetRecentClientsCommand_Cache = nil then
  begin
    FGetRecentClientsCommand_Cache := FConnection.CreateCommand;
    FGetRecentClientsCommand_Cache.RequestType := 'GET';
    FGetRecentClientsCommand_Cache.Text := 'TServerMethods.GetRecentClients';
    FGetRecentClientsCommand_Cache.Prepare(TServerMethods_GetRecentClients_Cache);
  end;
  FGetRecentClientsCommand_Cache.Parameters[0].Value.SetInt32(Limit);
  FGetRecentClientsCommand_Cache.ExecuteCache(ARequestFilter);
  Result := TDSRestCachedTFDJSONDataSets.Create(FGetRecentClientsCommand_Cache.Parameters[1].Value.GetString);
end;

function TServerMethodsClient.SearchFirst(FirstName: string; Limit: Integer; const ARequestFilter: string): TFDJSONDataSets;
begin
  if FSearchFirstCommand = nil then
  begin
    FSearchFirstCommand := FConnection.CreateCommand;
    FSearchFirstCommand.RequestType := 'GET';
    FSearchFirstCommand.Text := 'TServerMethods.SearchFirst';
    FSearchFirstCommand.Prepare(TServerMethods_SearchFirst);
  end;
  FSearchFirstCommand.Parameters[0].Value.SetWideString(FirstName);
  FSearchFirstCommand.Parameters[1].Value.SetInt32(Limit);
  FSearchFirstCommand.Execute(ARequestFilter);
  if not FSearchFirstCommand.Parameters[2].Value.IsNull then
  begin
    FUnMarshal := TDSRestCommand(FSearchFirstCommand.Parameters[2].ConnectionHandler).GetJSONUnMarshaler;
    try
      Result := TFDJSONDataSets(FUnMarshal.UnMarshal(FSearchFirstCommand.Parameters[2].Value.GetJSONValue(True)));
      if FInstanceOwner then
        FSearchFirstCommand.FreeOnExecute(Result);
    finally
      FreeAndNil(FUnMarshal)
    end
  end
  else
    Result := nil;
end;

function TServerMethodsClient.SearchFirst_Cache(FirstName: string; Limit: Integer; const ARequestFilter: string): IDSRestCachedTFDJSONDataSets;
begin
  if FSearchFirstCommand_Cache = nil then
  begin
    FSearchFirstCommand_Cache := FConnection.CreateCommand;
    FSearchFirstCommand_Cache.RequestType := 'GET';
    FSearchFirstCommand_Cache.Text := 'TServerMethods.SearchFirst';
    FSearchFirstCommand_Cache.Prepare(TServerMethods_SearchFirst_Cache);
  end;
  FSearchFirstCommand_Cache.Parameters[0].Value.SetWideString(FirstName);
  FSearchFirstCommand_Cache.Parameters[1].Value.SetInt32(Limit);
  FSearchFirstCommand_Cache.ExecuteCache(ARequestFilter);
  Result := TDSRestCachedTFDJSONDataSets.Create(FSearchFirstCommand_Cache.Parameters[2].Value.GetString);
end;

function TServerMethodsClient.SearchLast(LastName: string; Limit: Integer; const ARequestFilter: string): TFDJSONDataSets;
begin
  if FSearchLastCommand = nil then
  begin
    FSearchLastCommand := FConnection.CreateCommand;
    FSearchLastCommand.RequestType := 'GET';
    FSearchLastCommand.Text := 'TServerMethods.SearchLast';
    FSearchLastCommand.Prepare(TServerMethods_SearchLast);
  end;
  FSearchLastCommand.Parameters[0].Value.SetWideString(LastName);
  FSearchLastCommand.Parameters[1].Value.SetInt32(Limit);
  FSearchLastCommand.Execute(ARequestFilter);
  if not FSearchLastCommand.Parameters[2].Value.IsNull then
  begin
    FUnMarshal := TDSRestCommand(FSearchLastCommand.Parameters[2].ConnectionHandler).GetJSONUnMarshaler;
    try
      Result := TFDJSONDataSets(FUnMarshal.UnMarshal(FSearchLastCommand.Parameters[2].Value.GetJSONValue(True)));
      if FInstanceOwner then
        FSearchLastCommand.FreeOnExecute(Result);
    finally
      FreeAndNil(FUnMarshal)
    end
  end
  else
    Result := nil;
end;

function TServerMethodsClient.SearchLast_Cache(LastName: string; Limit: Integer; const ARequestFilter: string): IDSRestCachedTFDJSONDataSets;
begin
  if FSearchLastCommand_Cache = nil then
  begin
    FSearchLastCommand_Cache := FConnection.CreateCommand;
    FSearchLastCommand_Cache.RequestType := 'GET';
    FSearchLastCommand_Cache.Text := 'TServerMethods.SearchLast';
    FSearchLastCommand_Cache.Prepare(TServerMethods_SearchLast_Cache);
  end;
  FSearchLastCommand_Cache.Parameters[0].Value.SetWideString(LastName);
  FSearchLastCommand_Cache.Parameters[1].Value.SetInt32(Limit);
  FSearchLastCommand_Cache.ExecuteCache(ARequestFilter);
  Result := TDSRestCachedTFDJSONDataSets.Create(FSearchLastCommand_Cache.Parameters[2].Value.GetString);
end;

function TServerMethodsClient.SearchCity(City: string; Limit: Integer; const ARequestFilter: string): TFDJSONDataSets;
begin
  if FSearchCityCommand = nil then
  begin
    FSearchCityCommand := FConnection.CreateCommand;
    FSearchCityCommand.RequestType := 'GET';
    FSearchCityCommand.Text := 'TServerMethods.SearchCity';
    FSearchCityCommand.Prepare(TServerMethods_SearchCity);
  end;
  FSearchCityCommand.Parameters[0].Value.SetWideString(City);
  FSearchCityCommand.Parameters[1].Value.SetInt32(Limit);
  FSearchCityCommand.Execute(ARequestFilter);
  if not FSearchCityCommand.Parameters[2].Value.IsNull then
  begin
    FUnMarshal := TDSRestCommand(FSearchCityCommand.Parameters[2].ConnectionHandler).GetJSONUnMarshaler;
    try
      Result := TFDJSONDataSets(FUnMarshal.UnMarshal(FSearchCityCommand.Parameters[2].Value.GetJSONValue(True)));
      if FInstanceOwner then
        FSearchCityCommand.FreeOnExecute(Result);
    finally
      FreeAndNil(FUnMarshal)
    end
  end
  else
    Result := nil;
end;

function TServerMethodsClient.SearchCity_Cache(City: string; Limit: Integer; const ARequestFilter: string): IDSRestCachedTFDJSONDataSets;
begin
  if FSearchCityCommand_Cache = nil then
  begin
    FSearchCityCommand_Cache := FConnection.CreateCommand;
    FSearchCityCommand_Cache.RequestType := 'GET';
    FSearchCityCommand_Cache.Text := 'TServerMethods.SearchCity';
    FSearchCityCommand_Cache.Prepare(TServerMethods_SearchCity_Cache);
  end;
  FSearchCityCommand_Cache.Parameters[0].Value.SetWideString(City);
  FSearchCityCommand_Cache.Parameters[1].Value.SetInt32(Limit);
  FSearchCityCommand_Cache.ExecuteCache(ARequestFilter);
  Result := TDSRestCachedTFDJSONDataSets.Create(FSearchCityCommand_Cache.Parameters[2].Value.GetString);
end;

function TServerMethodsClient.SearchCountry(Country: string; Limit: Integer; const ARequestFilter: string): TFDJSONDataSets;
begin
  if FSearchCountryCommand = nil then
  begin
    FSearchCountryCommand := FConnection.CreateCommand;
    FSearchCountryCommand.RequestType := 'GET';
    FSearchCountryCommand.Text := 'TServerMethods.SearchCountry';
    FSearchCountryCommand.Prepare(TServerMethods_SearchCountry);
  end;
  FSearchCountryCommand.Parameters[0].Value.SetWideString(Country);
  FSearchCountryCommand.Parameters[1].Value.SetInt32(Limit);
  FSearchCountryCommand.Execute(ARequestFilter);
  if not FSearchCountryCommand.Parameters[2].Value.IsNull then
  begin
    FUnMarshal := TDSRestCommand(FSearchCountryCommand.Parameters[2].ConnectionHandler).GetJSONUnMarshaler;
    try
      Result := TFDJSONDataSets(FUnMarshal.UnMarshal(FSearchCountryCommand.Parameters[2].Value.GetJSONValue(True)));
      if FInstanceOwner then
        FSearchCountryCommand.FreeOnExecute(Result);
    finally
      FreeAndNil(FUnMarshal)
    end
  end
  else
    Result := nil;
end;

function TServerMethodsClient.SearchCountry_Cache(Country: string; Limit: Integer; const ARequestFilter: string): IDSRestCachedTFDJSONDataSets;
begin
  if FSearchCountryCommand_Cache = nil then
  begin
    FSearchCountryCommand_Cache := FConnection.CreateCommand;
    FSearchCountryCommand_Cache.RequestType := 'GET';
    FSearchCountryCommand_Cache.Text := 'TServerMethods.SearchCountry';
    FSearchCountryCommand_Cache.Prepare(TServerMethods_SearchCountry_Cache);
  end;
  FSearchCountryCommand_Cache.Parameters[0].Value.SetWideString(Country);
  FSearchCountryCommand_Cache.Parameters[1].Value.SetInt32(Limit);
  FSearchCountryCommand_Cache.ExecuteCache(ARequestFilter);
  Result := TDSRestCachedTFDJSONDataSets.Create(FSearchCountryCommand_Cache.Parameters[2].Value.GetString);
end;

function TServerMethodsClient.SearchPeople(IDList: string; const ARequestFilter: string): TFDJSONDataSets;
begin
  if FSearchPeopleCommand = nil then
  begin
    FSearchPeopleCommand := FConnection.CreateCommand;
    FSearchPeopleCommand.RequestType := 'GET';
    FSearchPeopleCommand.Text := 'TServerMethods.SearchPeople';
    FSearchPeopleCommand.Prepare(TServerMethods_SearchPeople);
  end;
  FSearchPeopleCommand.Parameters[0].Value.SetWideString(IDList);
  FSearchPeopleCommand.Execute(ARequestFilter);
  if not FSearchPeopleCommand.Parameters[1].Value.IsNull then
  begin
    FUnMarshal := TDSRestCommand(FSearchPeopleCommand.Parameters[1].ConnectionHandler).GetJSONUnMarshaler;
    try
      Result := TFDJSONDataSets(FUnMarshal.UnMarshal(FSearchPeopleCommand.Parameters[1].Value.GetJSONValue(True)));
      if FInstanceOwner then
        FSearchPeopleCommand.FreeOnExecute(Result);
    finally
      FreeAndNil(FUnMarshal)
    end
  end
  else
    Result := nil;
end;

function TServerMethodsClient.SearchPeople_Cache(IDList: string; const ARequestFilter: string): IDSRestCachedTFDJSONDataSets;
begin
  if FSearchPeopleCommand_Cache = nil then
  begin
    FSearchPeopleCommand_Cache := FConnection.CreateCommand;
    FSearchPeopleCommand_Cache.RequestType := 'GET';
    FSearchPeopleCommand_Cache.Text := 'TServerMethods.SearchPeople';
    FSearchPeopleCommand_Cache.Prepare(TServerMethods_SearchPeople_Cache);
  end;
  FSearchPeopleCommand_Cache.Parameters[0].Value.SetWideString(IDList);
  FSearchPeopleCommand_Cache.ExecuteCache(ARequestFilter);
  Result := TDSRestCachedTFDJSONDataSets.Create(FSearchPeopleCommand_Cache.Parameters[1].Value.GetString);
end;

function TServerMethodsClient.Calendar(StartDate: TDateTime; EndDate: TDateTime; const ARequestFilter: string): TFDJSONDataSets;
begin
  if FCalendarCommand = nil then
  begin
    FCalendarCommand := FConnection.CreateCommand;
    FCalendarCommand.RequestType := 'GET';
    FCalendarCommand.Text := 'TServerMethods.Calendar';
    FCalendarCommand.Prepare(TServerMethods_Calendar);
  end;
  FCalendarCommand.Parameters[0].Value.AsDateTime := StartDate;
  FCalendarCommand.Parameters[1].Value.AsDateTime := EndDate;
  FCalendarCommand.Execute(ARequestFilter);
  if not FCalendarCommand.Parameters[2].Value.IsNull then
  begin
    FUnMarshal := TDSRestCommand(FCalendarCommand.Parameters[2].ConnectionHandler).GetJSONUnMarshaler;
    try
      Result := TFDJSONDataSets(FUnMarshal.UnMarshal(FCalendarCommand.Parameters[2].Value.GetJSONValue(True)));
      if FInstanceOwner then
        FCalendarCommand.FreeOnExecute(Result);
    finally
      FreeAndNil(FUnMarshal)
    end
  end
  else
    Result := nil;
end;

function TServerMethodsClient.Calendar_Cache(StartDate: TDateTime; EndDate: TDateTime; const ARequestFilter: string): IDSRestCachedTFDJSONDataSets;
begin
  if FCalendarCommand_Cache = nil then
  begin
    FCalendarCommand_Cache := FConnection.CreateCommand;
    FCalendarCommand_Cache.RequestType := 'GET';
    FCalendarCommand_Cache.Text := 'TServerMethods.Calendar';
    FCalendarCommand_Cache.Prepare(TServerMethods_Calendar_Cache);
  end;
  FCalendarCommand_Cache.Parameters[0].Value.AsDateTime := StartDate;
  FCalendarCommand_Cache.Parameters[1].Value.AsDateTime := EndDate;
  FCalendarCommand_Cache.ExecuteCache(ARequestFilter);
  Result := TDSRestCachedTFDJSONDataSets.Create(FCalendarCommand_Cache.Parameters[2].Value.GetString);
end;

function TServerMethodsClient.EmailBitmap(Image: TMemoryStream; Email: string; EmailUser: TEmailUser; Body: string; const ARequestFilter: string): Boolean;
begin
  if FEmailBitmapCommand = nil then
  begin
    FEmailBitmapCommand := FConnection.CreateCommand;
    FEmailBitmapCommand.RequestType := 'POST';
    FEmailBitmapCommand.Text := 'TServerMethods."EmailBitmap"';
    FEmailBitmapCommand.Prepare(TServerMethods_EmailBitmap);
  end;
  FEmailBitmapCommand.Parameters[0].Value.SetStream(Image, FInstanceOwner);
  FEmailBitmapCommand.Parameters[1].Value.SetWideString(Email);
  if not Assigned(EmailUser) then
    FEmailBitmapCommand.Parameters[2].Value.SetNull
  else
  begin
    FMarshal := TDSRestCommand(FEmailBitmapCommand.Parameters[2].ConnectionHandler).GetJSONMarshaler;
    try
      FEmailBitmapCommand.Parameters[2].Value.SetJSONValue(FMarshal.Marshal(EmailUser), True);
      if FInstanceOwner then
        EmailUser.Free
    finally
      FreeAndNil(FMarshal)
    end
    end;
  FEmailBitmapCommand.Parameters[3].Value.SetWideString(Body);
  FEmailBitmapCommand.Execute(ARequestFilter);
  Result := FEmailBitmapCommand.Parameters[4].Value.GetBoolean;
end;

function TServerMethodsClient.MakeVoucher(BookingID: Integer; const ARequestFilter: string): string;
begin
  if FMakeVoucherCommand = nil then
  begin
    FMakeVoucherCommand := FConnection.CreateCommand;
    FMakeVoucherCommand.RequestType := 'GET';
    FMakeVoucherCommand.Text := 'TServerMethods.MakeVoucher';
    FMakeVoucherCommand.Prepare(TServerMethods_MakeVoucher);
  end;
  FMakeVoucherCommand.Parameters[0].Value.SetInt32(BookingID);
  FMakeVoucherCommand.Execute(ARequestFilter);
  Result := FMakeVoucherCommand.Parameters[1].Value.GetWideString;
end;

function TServerMethodsClient.MakeInvoice(BookingID: Integer; const ARequestFilter: string): string;
begin
  if FMakeInvoiceCommand = nil then
  begin
    FMakeInvoiceCommand := FConnection.CreateCommand;
    FMakeInvoiceCommand.RequestType := 'GET';
    FMakeInvoiceCommand.Text := 'TServerMethods.MakeInvoice';
    FMakeInvoiceCommand.Prepare(TServerMethods_MakeInvoice);
  end;
  FMakeInvoiceCommand.Parameters[0].Value.SetInt32(BookingID);
  FMakeInvoiceCommand.Execute(ARequestFilter);
  Result := FMakeInvoiceCommand.Parameters[1].Value.GetWideString;
end;

function TServerMethodsClient.UploadToS3(Bucket: string; AWSObject: string; Filename: string; const ARequestFilter: string): Boolean;
begin
  if FUploadToS3Command = nil then
  begin
    FUploadToS3Command := FConnection.CreateCommand;
    FUploadToS3Command.RequestType := 'GET';
    FUploadToS3Command.Text := 'TServerMethods.UploadToS3';
    FUploadToS3Command.Prepare(TServerMethods_UploadToS3);
  end;
  FUploadToS3Command.Parameters[0].Value.SetWideString(Bucket);
  FUploadToS3Command.Parameters[1].Value.SetWideString(AWSObject);
  FUploadToS3Command.Parameters[2].Value.SetWideString(Filename);
  FUploadToS3Command.Execute(ARequestFilter);
  Result := FUploadToS3Command.Parameters[3].Value.GetBoolean;
end;

function TServerMethodsClient.PreviewVoucher(BookingID: Integer; const ARequestFilter: string): string;
begin
  if FPreviewVoucherCommand = nil then
  begin
    FPreviewVoucherCommand := FConnection.CreateCommand;
    FPreviewVoucherCommand.RequestType := 'GET';
    FPreviewVoucherCommand.Text := 'TServerMethods.PreviewVoucher';
    FPreviewVoucherCommand.Prepare(TServerMethods_PreviewVoucher);
  end;
  FPreviewVoucherCommand.Parameters[0].Value.SetInt32(BookingID);
  FPreviewVoucherCommand.Execute(ARequestFilter);
  Result := FPreviewVoucherCommand.Parameters[1].Value.GetWideString;
end;

function TServerMethodsClient.PreviewInvoice(BookingID: Integer; const ARequestFilter: string): string;
begin
  if FPreviewInvoiceCommand = nil then
  begin
    FPreviewInvoiceCommand := FConnection.CreateCommand;
    FPreviewInvoiceCommand.RequestType := 'GET';
    FPreviewInvoiceCommand.Text := 'TServerMethods.PreviewInvoice';
    FPreviewInvoiceCommand.Prepare(TServerMethods_PreviewInvoice);
  end;
  FPreviewInvoiceCommand.Parameters[0].Value.SetInt32(BookingID);
  FPreviewInvoiceCommand.Execute(ARequestFilter);
  Result := FPreviewInvoiceCommand.Parameters[1].Value.GetWideString;
end;

function TServerMethodsClient.SendVoucher(EmailList: string; EmailUser: TEmailUser; BookingID: Integer; const ARequestFilter: string): Boolean;
begin
  if FSendVoucherCommand = nil then
  begin
    FSendVoucherCommand := FConnection.CreateCommand;
    FSendVoucherCommand.RequestType := 'POST';
    FSendVoucherCommand.Text := 'TServerMethods."SendVoucher"';
    FSendVoucherCommand.Prepare(TServerMethods_SendVoucher);
  end;
  FSendVoucherCommand.Parameters[0].Value.SetWideString(EmailList);
  if not Assigned(EmailUser) then
    FSendVoucherCommand.Parameters[1].Value.SetNull
  else
  begin
    FMarshal := TDSRestCommand(FSendVoucherCommand.Parameters[1].ConnectionHandler).GetJSONMarshaler;
    try
      FSendVoucherCommand.Parameters[1].Value.SetJSONValue(FMarshal.Marshal(EmailUser), True);
      if FInstanceOwner then
        EmailUser.Free
    finally
      FreeAndNil(FMarshal)
    end
    end;
  FSendVoucherCommand.Parameters[2].Value.SetInt32(BookingID);
  FSendVoucherCommand.Execute(ARequestFilter);
  Result := FSendVoucherCommand.Parameters[3].Value.GetBoolean;
end;

function TServerMethodsClient.SendInvoice(Mode: Integer; EmailList: string; EmailUser: TEmailUser; BookingID: Integer; const ARequestFilter: string): Boolean;
begin
  if FSendInvoiceCommand = nil then
  begin
    FSendInvoiceCommand := FConnection.CreateCommand;
    FSendInvoiceCommand.RequestType := 'POST';
    FSendInvoiceCommand.Text := 'TServerMethods."SendInvoice"';
    FSendInvoiceCommand.Prepare(TServerMethods_SendInvoice);
  end;
  FSendInvoiceCommand.Parameters[0].Value.SetInt32(Mode);
  FSendInvoiceCommand.Parameters[1].Value.SetWideString(EmailList);
  if not Assigned(EmailUser) then
    FSendInvoiceCommand.Parameters[2].Value.SetNull
  else
  begin
    FMarshal := TDSRestCommand(FSendInvoiceCommand.Parameters[2].ConnectionHandler).GetJSONMarshaler;
    try
      FSendInvoiceCommand.Parameters[2].Value.SetJSONValue(FMarshal.Marshal(EmailUser), True);
      if FInstanceOwner then
        EmailUser.Free
    finally
      FreeAndNil(FMarshal)
    end
    end;
  FSendInvoiceCommand.Parameters[3].Value.SetInt32(BookingID);
  FSendInvoiceCommand.Execute(ARequestFilter);
  Result := FSendInvoiceCommand.Parameters[4].Value.GetBoolean;
end;

function TServerMethodsClient.SendReport(Mode: Integer; EmailList: string; EmailUser: TEmailUser; Filename: string; const ARequestFilter: string): Boolean;
begin
  if FSendReportCommand = nil then
  begin
    FSendReportCommand := FConnection.CreateCommand;
    FSendReportCommand.RequestType := 'POST';
    FSendReportCommand.Text := 'TServerMethods."SendReport"';
    FSendReportCommand.Prepare(TServerMethods_SendReport);
  end;
  FSendReportCommand.Parameters[0].Value.SetInt32(Mode);
  FSendReportCommand.Parameters[1].Value.SetWideString(EmailList);
  if not Assigned(EmailUser) then
    FSendReportCommand.Parameters[2].Value.SetNull
  else
  begin
    FMarshal := TDSRestCommand(FSendReportCommand.Parameters[2].ConnectionHandler).GetJSONMarshaler;
    try
      FSendReportCommand.Parameters[2].Value.SetJSONValue(FMarshal.Marshal(EmailUser), True);
      if FInstanceOwner then
        EmailUser.Free
    finally
      FreeAndNil(FMarshal)
    end
    end;
  FSendReportCommand.Parameters[3].Value.SetWideString(Filename);
  FSendReportCommand.Execute(ARequestFilter);
  Result := FSendReportCommand.Parameters[4].Value.GetBoolean;
end;

constructor TServerMethodsClient.Create(ARestConnection: TDSRestConnection);
begin
  inherited Create(ARestConnection);
end;

constructor TServerMethodsClient.Create(ARestConnection: TDSRestConnection; AInstanceOwner: Boolean);
begin
  inherited Create(ARestConnection, AInstanceOwner);
end;

destructor TServerMethodsClient.Destroy;
begin
  FDSServerModuleCreateCommand.DisposeOf;
  FTestConnectionCommand.DisposeOf;
  FGetAutoIncrementCommand.DisposeOf;
  FLastIDCommand.DisposeOf;
  FGetClientCommand.DisposeOf;
  FGetClientCommand_Cache.DisposeOf;
  FGetPeopleCommand.DisposeOf;
  FGetPeopleCommand_Cache.DisposeOf;
  FGetContactsCommand.DisposeOf;
  FGetContactsCommand_Cache.DisposeOf;
  FGetClientBookingsCommand.DisposeOf;
  FGetClientBookingsCommand_Cache.DisposeOf;
  FSaveClientCommand.DisposeOf;
  FSaveClientCommand_Cache.DisposeOf;
  FSavePeopleCommand.DisposeOf;
  FSavePeopleCommand_Cache.DisposeOf;
  FSaveContactsCommand.DisposeOf;
  FSaveContactsCommand_Cache.DisposeOf;
  FGetBookingByIDCommand.DisposeOf;
  FGetBookingByIDCommand_Cache.DisposeOf;
  FGetRentalsCommand.DisposeOf;
  FGetRentalsCommand_Cache.DisposeOf;
  FGetRentAccomsCommand.DisposeOf;
  FGetRentAccomsCommand_Cache.DisposeOf;
  FGetPaymentsCommand.DisposeOf;
  FGetPaymentsCommand_Cache.DisposeOf;
  FGetTravelCommand.DisposeOf;
  FGetTravelCommand_Cache.DisposeOf;
  FGetBookingPersonCommand.DisposeOf;
  FGetBookingPersonCommand_Cache.DisposeOf;
  FCheckRentalAvailableCommand.DisposeOf;
  FCheckAllAvailableCommand.DisposeOf;
  FSaveBookingsCommand.DisposeOf;
  FSaveBookingsCommand_Cache.DisposeOf;
  FSaveRentalsCommand.DisposeOf;
  FSaveRentalsCommand_Cache.DisposeOf;
  FSaveRentAccomsCommand.DisposeOf;
  FSavePaymentsCommand.DisposeOf;
  FSavePaymentsCommand_Cache.DisposeOf;
  FSaveTravelCommand.DisposeOf;
  FSaveTravelCommand_Cache.DisposeOf;
  FSaveBookingPersonCommand.DisposeOf;
  FGetBanksCommand.DisposeOf;
  FGetBanksCommand_Cache.DisposeOf;
  FGetBankByIDCommand.DisposeOf;
  FGetAccomsCommand.DisposeOf;
  FGetAccomsCommand_Cache.DisposeOf;
  FGetUpcomingDepositsCommand.DisposeOf;
  FGetUpcomingDepositsCommand_Cache.DisposeOf;
  FGetRecentBookingsCommand.DisposeOf;
  FGetRecentBookingsCommand_Cache.DisposeOf;
  FGetRecentClientsCommand.DisposeOf;
  FGetRecentClientsCommand_Cache.DisposeOf;
  FSearchFirstCommand.DisposeOf;
  FSearchFirstCommand_Cache.DisposeOf;
  FSearchLastCommand.DisposeOf;
  FSearchLastCommand_Cache.DisposeOf;
  FSearchCityCommand.DisposeOf;
  FSearchCityCommand_Cache.DisposeOf;
  FSearchCountryCommand.DisposeOf;
  FSearchCountryCommand_Cache.DisposeOf;
  FSearchPeopleCommand.DisposeOf;
  FSearchPeopleCommand_Cache.DisposeOf;
  FCalendarCommand.DisposeOf;
  FCalendarCommand_Cache.DisposeOf;
  FEmailBitmapCommand.DisposeOf;
  FMakeVoucherCommand.DisposeOf;
  FMakeInvoiceCommand.DisposeOf;
  FUploadToS3Command.DisposeOf;
  FPreviewVoucherCommand.DisposeOf;
  FPreviewInvoiceCommand.DisposeOf;
  FSendVoucherCommand.DisposeOf;
  FSendInvoiceCommand.DisposeOf;
  FSendReportCommand.DisposeOf;
  inherited;
end;

end.

