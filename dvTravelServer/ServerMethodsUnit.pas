unit ServerMethodsUnit;

interface

uses System.SysUtils, System.Classes, System.Json,
    Datasnap.DSServer, Datasnap.DSAuth, Datasnap.DSProviderDataModuleAdapter,
    classBooking, classResultsArray, classResult, classEmailUser, DatabaseStrings,

  FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.UI.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Phys, FireDAC.Phys.MySQL,
  FireDAC.Phys.MySQLDef, FireDAC.FMXUI.Wait, FireDAC.Stan.StorageJSON,
  FireDAC.Stan.StorageBin, FireDAC.Comp.UI, Data.DB, FireDAC.Comp.Client,
  FireDAC.Comp.DataSet, Data.FireDACJSONReflect,
  FireDAC.Moni.Base, FireDAC.Moni.FlatFile, Variants, Data.DBXPlatform,
  IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient,
  IdExplicitTLSClientServerBase, IdMessageClient, IdSMTPBase, IdSMTP, IdMessage,
  IdAttachmentFile, IdAttachment, IDEmailAddress,
  IOUtils, frxExportHTML, frxClass, frxExportPDF, frxDBSet, Data.Cloud.CloudAPI,
  Data.Cloud.AmazonAPI, FMX.Graphics, DBXJSONCommon;

  const
  sDulceVida = 'Dulce Vida';
  sVoucher = 'Voucher';
  sInvoice = 'Invoice';

var
  sDirName : String;

type
  TServerMethods = class(TDSServerModule)
    qLastID: TFDQuery;
    uTravel: TFDUpdateSQL;
    uRental: TFDUpdateSQL;
    uPerson: TFDUpdateSQL;
    uPayment: TFDUpdateSQL;
    uContact: TFDUpdateSQL;
    uClientBookings: TFDUpdateSQL;
    uClient: TFDUpdateSQL;
    StorageJSONLink: TFDStanStorageJSONLink;
    StorageBinLink: TFDStanStorageBinLink;
    SMTP: TIdSMTP;
    FDMoniFlatFileClientLink1: TFDMoniFlatFileClientLink;
    FDPhysMySQLDriverLink: TFDPhysMySQLDriverLink;
    GUIxWaitCursor: TFDGUIxWaitCursor;
    FDConnection1: TFDConnection;
    qRental: TFDQuery;
    qRentAccom: TFDQuery;
    qTravel: TFDQuery;
    qPayment: TFDQuery;
    qBookingPerson: TFDQuery;
    qAddRental: TFDQuery;
    qAddRentAccom: TFDQuery;
    qAddPayment: TFDQuery;
    qAddTravel: TFDQuery;
    qRentalAvailable: TFDQuery;
    qAllAvailable: TFDQuery;
    qBank: TFDQuery;
    qAccom: TFDQuery;
    qBankByID: TFDQuery;
    qUpDeposits: TFDQuery;
    qRecentBookings: TFDQuery;
    qCalendar: TFDQuery;
    qAutoIncrement: TFDQuery;
    qClient: TFDQuery;
    qClientClientID: TFDAutoIncField;
    qClientCountry: TStringField;
    qClientActive: TBooleanField;
    qClientDateEntered: TDateTimeField;
    qClientAddress: TStringField;
    qClientCity: TStringField;
    qClientProvState: TStringField;
    qClientPostalZip: TStringField;
    qClientNotes: TBlobField;
    qAddClient: TFDQuery;
    qAddPerson: TFDQuery;
    qPerson: TFDQuery;
    qPersonPersonID: TFDAutoIncField;
    qPersonClientID: TIntegerField;
    qPersonLastName: TStringField;
    qPersonFirstName: TStringField;
    qPersonNotes: TStringField;
    qAddContact: TFDQuery;
    qContact: TFDQuery;
    qAddBooking: TFDQuery;
    qClientBookings: TFDQuery;
    qGetBookingByID: TFDQuery;
    qInvoiceClient: TFDQuery;
    dVoucherRental: TfrxDBDataset;
    qVoucherRental: TFDQuery;
    qReportPeople: TFDQuery;
    qVoucherAmt: TFDQuery;
    dVoucherAmt: TfrxDBDataset;
    qReportTravel: TFDQuery;
    dReportTravel: TfrxDBDataset;
    dInvoiceClient: TfrxDBDataset;
    qInvoiceBooking: TFDQuery;
    dInvoiceBooking: TfrxDBDataset;
    dInvoiceRental: TfrxDBDataset;
    qInvoiceRental: TFDQuery;
    MailMessage: TIdMessage;
    qSearchFirst: TFDQuery;
    qSearchLast: TFDQuery;
    qSearchCity: TFDQuery;
    qSearchCountry: TFDQuery;
    qSearchPeople: TFDQuery;
    HTMLExport: TfrxHTMLExport;
    rVoucher: TfrxReport;
    rInvoice: TfrxReport;
    dReportPeople: TfrxDBDataset;
    qMainPerson: TFDQuery;
    PDFExport: TfrxPDFExport;
    qRecentClients: TFDQuery;
    AWSConnection: TAmazonConnectionInfo;
    procedure DSServerModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    // Acknowledges contact from client
    function TestConnection : Boolean;

    // Returns the next ID for table Tablename
    function GetAutoIncrement(TableName : String) : Integer;
    // Returns the highest ID for table TableName
    function LastID(TableName : String) : Integer;
    // CLIENTS
    function GetClient(ClientID : Integer): TFDJSONDataSets;
    function GetPeople(ClientID : Integer): TFDJSONDataSets;
    function GetContacts(ClientID : Integer): TFDJSONDataSets;
    function GetClientBookings(ClientID : Integer) : TFDJSONDataSets;

    // Objects that don't have an ID set yet have a temporary negative ID

    // Saves changes to table and
    // returns array of new ids with corresponding old temp ids of added objects
    function SaveClient(const DeltaList : TFDJSONDeltas) : TResultsArray;
    function SavePeople(const DeltaList : TFDJSONDeltas) : TResultsArray;
    function SaveContacts(const DeltaList : TFDJSONDeltas) : TResultsArray;

    // BOOKINGS
    function GetBookingByID(BookID : Integer) : TFDJSONDataSets;
    function GetRentals(BookID : Integer): TFDJSONDataSets;
    function GetRentAccoms(IDList : String) : TFDJSONDataSets;
    function GetPayments(BookID : Integer): TFDJSONDataSets;
    function GetTravel(BookID : Integer): TFDJSONDataSets;
    function GetBookingPerson(BookID : Integer) : TFDJSONDataSets;

    // Returns true if Accom is already occupied between Start and End Date,
    // and occupier is not RentID object
    function CheckRentalAvailable(AccomID : Integer;
             StartDate : TDateTime; EndDate : TDateTime; RentID : Integer) : Boolean;
    // Same as above but for all casas but 7
    function CheckAllAvailable(StartDate : TDateTime; EndDate : TDateTime; RentID : Integer) : Boolean;

    // Objects that don't have an ID set yet have a temporary negative ID

    // Saves changes to table and
    // returns array of new ids with corresponding old temp ids of added objects
    function SaveBookings(const DeltaList : TFDJSONDeltas) : TResultsArray;
    function SaveRentals(const DeltaList : TFDJSONDeltas) : TResultsArray;
    procedure SaveRentAccoms(const DeltaList : TFDJSONDeltas);
    function SavePayments(const DeltaList : TFDJSONDeltas) : TResultsArray;
    function SaveTravel(const DeltaList : TFDJSONDeltas) : TResultsArray;
    procedure SaveBookingPerson(const DeltaList : TFDJSONDeltas);

    function GetBanks : TFDJSONDataSets;
    function GetBankByID(BankID : Integer) : String;
    function GetAccoms: TFDJSONDataSets;

    // HOME TAB
    function GetUpcomingDeposits(Limit : Integer) : TFDJSONDataSets;
    function GetRecentBookings(Limit : Integer) : TFDJSONDataSets;
    function GetRecentClients(Limit : Integer) : TFDJSONDataSets;

    // SEARCH
    // Searches clients by attribute. Returns Limit results.
    function SearchFirst(FirstName : String; Limit : Integer) : TFDJSONDataSets;
    function SearchLast(LastName : String; Limit : Integer) : TFDJSONDataSets;
    function SearchCity(City : String; Limit : Integer) : TFDJSONDataSets;
    function SearchCountry(Country : String; Limit : Integer) : TFDJSONDataSets;

    // Returns corresponding person objects for successful search results
    function SearchPeople(IDList : String) : TFDJSONDataSets;

    // CALENDAR
    // Returns all available calendar bookings as classBookingItems
    function Calendar(StartDate : TDateTime; EndDate : TDateTime) : TFDJSONDataSets;

    // Sends image of calendar to email in eCalendarExport
    // Idea is that the employees and other people at Casa Dulce Vida print it out
    // and have a schedule of visitors
    function EmailBitmap(Image : TMemoryStream; Email : String; EmailUser : TEmailUser; Body : String) : Boolean;

    // REPORTS
    // Generates a report, saves it, and returns filepath
    function MakeVoucher(BookingID : Integer) : String;
    function MakeInvoice(BookingID : Integer) : String;

    // Uploads a report to Amazon Web Services storage
    // Bucket is AWS bucket to hold it, AWSName is what the object will be saved as,
    // and filename is the filepath to the object to upload
    function UploadToS3(Bucket : String; AWSName : String; Filename : String) : Boolean;

    // Create pdf and upload to S3 and return link so it can be opened with webbrowser
    function PreviewVoucher(BookingID : Integer) : String;
    function PreviewInvoice(BookingID : Integer) : String;

    // Generates and emails a report based on BookingID to addresses in EmailList.
    // will appear as from EmailUser
    function SendVoucher(EmailList : String; EmailUser : TEmailUser; BookingID : Integer) : Boolean;
    function SendInvoice(Mode : Integer; EmailList : String; EmailUser : TEmailUser; BookingID : Integer) : Boolean;

    // Emails file at Filename to all addresses in EmailList
    // Mode 0 is voucher, Mode 1 is Invoice without paypal, Mode 2 is Invoice with paypal message, Mode 3 is Invoice as Receipt
    function SendReport(Mode : Integer; EmailList : String;  EmailUser: TEmailUser; Filename : String) : Boolean;

  end;

  // Ensures value is not null
  function IfNull(const Value : OleVariant; Default : OleVariant) : OleVariant;
  // Creates Directory if it does not exist
  procedure EnsureDirExists;


implementation

{$R *.dfm}

uses System.StrUtils, System.Types, ServerUnit;

// Ensures value is not null
function IfNull(const Value : OleVariant; Default : OleVariant) : OleVariant;
begin
  if Value = NULL then
    Result := Default
  else
    Result := Value;
end;

// Creates Directory if it does not exist
procedure EnsureDirExists;
begin
  sDirName := IOUtils.TPath.Combine(IOUtils.TPath.GetDocumentsPath, 'dvTravel');
  if not DirectoryExists(sDirName) then
  begin
    CreateDir(sDirName);
  end;
end;

// Acknowledges contact from client
function TServerMethods.TestConnection : Boolean;
begin
  Result := True;
end;

// Returns the next ID for table Tablename
function TServerMethods.GetAutoIncrement(TableName: string) : Integer;
begin
  // Clear active so that the query will reexecute
  qAutoIncrement.Active := False;

  // Set query parameters
  qAutoIncrement.ParamByName('tablename').AsString := TableName;

  // Set Result to be result of query
  qAutoIncrement.Open;
  try
    Result := qAutoIncrement.Table.Rows.ItemsI[0].GetValues('Inc');
  except
    Result := -1;
  end;
end;

// Returns the highest ID for table TableName
function TServerMethods.LastID(TableName: string) : Integer;
var
  ID : String;
begin
  // Clear active so that the query will reexecute
  qLastID.Active := False;

  // Set query parameters
  // payment and rental tables have different names for their IDs
  if LowerCase(TableName) = 'payment' then
  begin
    ID := 'PayID';
  end
  else if LowerCase(TableName) = 'rental' then
  begin
    ID := 'RentID';
  end
  else
  begin
    ID := TableName+'ID';
  end;
  qLastID.SQL.Text := 'SELECT COALESCE(MAX('+ID+'),0) as LastID FROM dv.'+TableName;

  // make sure booking isn't cancelled
  if LowerCase(TableName) = 'booking' then
  begin
    qLastID.SQL.Text := qLastID.SQL.Text + sLineBreak + 'WHERE status != "Cancelled"';
  end;


  // Set Result to be result of query
  qLastID.Open;
  try
    Result := qLastID.Table.Rows.ItemsI[0].GetValues('LastID');
  except
    Result := -1;
  end;
end;

function TServerMethods.GetClient(ClientID : Integer): TFDJSONDataSets;
begin
  // Clear active so that the query will reexecute
  qClient.Active := False;
  // Set query parameters
  qClient.ParamByName('ClientID').AsInteger := ClientID;
  // Set Result to be result of query
  Result := TFDJSONDataSets.Create;
  TFDJsonDataSetsWriter.ListAdd(Result, qClient);
end;

function TServerMethods.GetPeople(ClientID : Integer): TFDJSONDataSets;
begin
  // Clear active so that the query will reexecute
  qPerson.Active := False;
  // Set query parameters
  qPerson.ParamByName('ClientID').AsInteger := ClientID;
  // Set Result to be result of query
  Result := TFDJSONDataSets.Create;
  TFDJsonDataSetsWriter.ListAdd(Result, qPerson);
end;

function TServerMethods.GetContacts(ClientID : Integer): TFDJSONDataSets;
begin
  // Clear active so that the query will reexecute
  qContact.Active := False;
  // Set query parameters
  qContact.ParamByName('ClientID').AsInteger := ClientID;
  // Set Result to be result of query
  Result := TFDJSONDataSets.Create;
  TFDJsonDataSetsWriter.ListAdd(Result, qContact);
end;

function TServerMethods.GetClientBookings(ClientID: Integer) : TFDJSONDataSets;
begin
  // Clear active so that the query will reexecute
  qClientBookings.Active := False;
  // Set query parameters
  qClientBookings.ParamByName('ClientID').AsInteger := ClientID;
  // Set Result to be result of query
  Result := TFDJSONDataSets.Create;
  TFDJsonDataSetsWriter.ListAdd(Result, qClientBookings);
end;

// Saves changes to client to client table and
// returns array of new ids with corresponding old temp ids of added clients
// Objects that don't have an ID set yet have a temporary negative ID
function TServerMethods.SaveClient(const DeltaList : TFDJSONDeltas) : TResultsArray;
var
  Apply : IFDJSONDeltasApplyUpdates;
  AutoInc: Integer;
  NumAdded : Integer;
begin
  AutoInc:= GetAutoIncrement('client');
  NumAdded := 0;

  Result := TResultsArray.Create;
  with TFDJSONDeltasReader.GetListValueByName(DeltaList, sClient) do
  begin
    First;
    while not EOF do
    begin
      // Items that don't have an ID set yet have a temporary negative ID
      if FieldByName('ClientID').Value < 0 then
      begin
        Result.AddID(FieldByName('ClientID').Value, AutoInc + NumAdded);
        NumAdded := NumAdded + 1;
      end;
      Next;
    end;
  end;
  Apply := TFDJSONDeltasApplyUpdates.Create(DeltaList);
  Apply.ApplyUpdates(sClient, qClient.Command);

  if Apply.Errors.Count > 0 then
    raise Exception.Create(Apply.Errors.Strings.Text);
end;

// Saves changes to people to person table and
// returns array of new ids with corresponding old temp ids of added people
// Objects that don't have an ID set yet have a temporary negative ID
function TServerMethods.SavePeople(const DeltaList: TFDJSONDeltas) : TResultsArray;
var
  Apply : IFDJSONDeltasApplyUpdates;
  NumAdded : Integer;
  AutoInc: Integer;
begin
  AutoInc := GetAutoIncrement('person');
  NumAdded := 0;

  Result := TResultsArray.Create;
  with TFDJSONDeltasReader.GetListValueByName(DeltaList, sPerson) do
  begin
    First;
    while not EOF do
    begin
      // Items that don't have an ID set yet have a temporary negative ID
      if FieldByName('PersonID').Value < 0 then
      begin
        Result.AddID(FieldByName('PersonID').Value, AutoInc + NumAdded);
        NumAdded := NumAdded + 1;
      end;
      Next;
    end;
  end;
  Apply := TFDJSONDeltasApplyUpdates.Create(DeltaList);
  Apply.ApplyUpdates(sPerson, qPerson.Command);

  if Apply.Errors.Count > 0 then
    raise Exception.Create(Apply.Errors.Strings.Text);
end;

// Saves changes to contacts to contact table and
// returns array of new ids with corresponding old temp ids of added contacts
// Objects that don't have an ID set yet have a temporary negative ID
function TServerMethods.SaveContacts(const DeltaList: TFDJSONDeltas) : TResultsArray;
var
  Apply : IFDJSONDeltasApplyUpdates;
  NumAdded : Integer;
  AutoInc: Integer;
begin
  AutoInc := GetAutoIncrement('contact');
  NumAdded := 0;

  Result := TResultsArray.Create;
  with TFDJSONDeltasReader.GetListValueByName(DeltaList, sContact) do
  begin
    First;
    while not EOF do
    begin
      // Items that don't have an ID set yet have a temporary negative ID
      if FieldByName('ContactID').Value < 0 then
      begin
        Result.AddID(FieldByName('ContactID').Value, AutoInc + NumAdded);
        NumAdded := NumAdded + 1;
      end;
      Next;
    end;
  end;

  Apply := TFDJSONDeltasApplyUpdates.Create(DeltaList);
  Apply.ApplyUpdates(sContact, qContact.Command);

  if Apply.Errors.Count > 0 then
    raise Exception.Create(Apply.Errors.Strings.Text);
end;

// BOOKINGS

function TServerMethods.GetBookingByID(BookID: Integer) : TFDJSONDataSets;
begin
  // Clear active so that the query will reexecute
  qGetBookingById.Active := False;
  // Set query parameters
  qGetBookingById.ParamByName('BookingID').AsInteger := BookID;

  Result := TFDJSONDataSets.Create;
  TFDJSONDataSetsWriter.ListAdd(Result, qGetBookingById);
end;

function TServerMethods.GetRentals(BookID : Integer): TFDJSONDataSets;
begin
  // Clear active so that the query will reexecute
  qRental.Active := False;
  // Set query parameters
  qRental.ParamByName('BookID').AsInteger := BookID;
  // Set Result to be result of query
  Result := TFDJSONDataSets.Create;
  TFDJsonDataSetsWriter.ListAdd(Result, qRental);
end;

function TServerMethods.GetRentAccoms(IDList : String): TFDJSONDataSets;
begin
  // Clear active so that the query will reexecute
  qRentAccom.Active := False;
  // Set query SQL
  qRentAccom.SQL.Text := 'SELECT DISTINCT * ' +
                         'FROM rentaccom ' +
                         'WHERE RentID in ' + IDList;
  // Set Result to be result of query
  Result := TFDJSONDataSets.Create;
  TFDJsonDataSetsWriter.ListAdd(Result, qRentAccom);
end;

function TServerMethods.GetPayments(BookID : Integer): TFDJSONDataSets;
begin
  // Clear active so that the query will reexecute
  qPayment.Active := False;
  // Set query parameters
  qPayment.ParamByName('BookID').AsInteger := BookID;
  // Set Result to be result of query
  Result := TFDJSONDataSets.Create;
  TFDJsonDataSetsWriter.ListAdd(Result, qPayment);
end;

function TServerMethods.GetTravel(BookID : Integer): TFDJSONDataSets;
begin
  // Clear active so that the query will reexecute
  qTravel.Active := False;
  // Set query parameters
  qTravel.ParamByName('BookID').AsInteger := BookID;
  // Set Result to be result of query
  Result := TFDJSONDataSets.Create;
  TFDJsonDataSetsWriter.ListAdd(Result, qTravel);
end;

function TServerMethods.GetBookingPerson(BookID : Integer) : TFDJSONDataSets;
begin
  // Clear active so that the query will reexecute
  qBookingPerson.Active := False;
  // Set query parameters
  qBookingPerson.ParamByName('BookingID').AsInteger := BookID;
  // Set Result to be result of query
  Result := TFDJSONDataSets.Create;
  TFDJsonDataSetsWriter.ListAdd(Result, qBookingPerson);
end;

// Returns true if Accom is already occupied between Start and End Date,
// and occupier is not RentID object
function TServerMethods.CheckRentalAvailable(AccomID : Integer;
             StartDate : TDateTime; EndDate : TDateTime; RentID : Integer) : Boolean;
begin
  // Clear active so that the query will reexecute
  qRentalAvailable.Active := False;
  // Set query parameters
  qRentalAvailable.ParamByName('AccomId').AsInteger := AccomID;
  qRentalAvailable.ParamByName('StartDate').AsDateTime := StartDate;
  qRentalAvailable.ParamByName('EndDate').AsDateTime := EndDate;
  qRentalAvailable.ParamByName('RentID').AsInteger := RentID;
  // Return True if query returned empty, false otherwise
  qRentalAvailable.Open;
  Result := qRentalAvailable.IsEmpty;
end;

// Actually isn't all - just all but 7
function TServerMethods.CheckAllAvailable(StartDate : TDateTime; EndDate : TDateTime;
                                           RentID : Integer) : Boolean;
begin
  // Clear active so that the query will reexecute
  qAllAvailable.Active := False;
  // Set query parameters
  qAllAvailable.ParamByName('StartDate').AsDateTime := StartDate;
  qAllAvailable.ParamByName('EndDate').AsDateTime := EndDate;
  qAllAvailable.ParamByName('RentID').AsInteger := RentID;
  // Return True if query returned empty, false otherwise
  qRentalAvailable.Open;
  Result := qRentalAvailable.IsEmpty;
end;

// Saves changes to bookings to booking table and
// returns array of new ids with corresponding old temp ids of added bookings
// Objects that don't have an ID set yet have a temporary negative ID
function TServerMethods.SaveBookings(const DeltaList: TFDJSONDeltas) : TResultsArray;
var
  Apply : IFDJSONDeltasApplyUpdates;
  NumAdded : Integer;
  AutoInc: Integer;
begin
  AutoInc := GetAutoIncrement('booking');
  NumAdded := 0;

  Result := TResultsArray.Create;
  with TFDJSONDeltasReader.GetListValueByName(DeltaList, sBooking) do
  begin
    First;
    while not EOF do
    begin
      // Items that don't have an ID set yet have a temporary negative ID
      if FieldByName('BookingID').Value < 0 then
      begin
        Result.AddID(FieldByName('BookingID').Value, AutoInc + NumAdded);
        NumAdded := NumAdded + 1;
      end;
      Next;
    end;
  end;
  Apply := TFDJSONDeltasApplyUpdates.Create(DeltaList);
  Apply.ApplyUpdates(sBooking, qClientBookings.Command);

  if Apply.Errors.Count > 0 then
    raise Exception.Create(Apply.Errors.Strings.Text);
end;

// Saves changes to rentals to rental table and
// returns array of new ids with corresponding old temp ids of added rentals
// Objects that don't have an ID set yet have a temporary negative ID
function TServerMethods.SaveRentals(const DeltaList: TFDJSONDeltas) : TResultsArray;
var
  Apply : IFDJSONDeltasApplyUpdates;
  NumAdded : Integer;
  AutoInc: Integer;
begin
  AutoInc := GetAutoIncrement('rental');
  NumAdded := 0;
  Result := TResultsArray.Create;
  with TFDJSONDeltasReader.GetListValueByName(DeltaList, sRental) do
  begin
    First;
    while not EOF do
    begin
    // Items that don't have an ID set yet have a temporary negative ID
      if FieldByName('RentID').Value < 0 then
      begin
        Result.AddID(FieldByName('RentID').Value, AutoInc + NumAdded);
        NumAdded := NumAdded + 1;
      end;
      Next;
    end;
  end;
  Apply := TFDJSONDeltasApplyUpdates.Create(DeltaList);
  Apply.ApplyUpdates(sRental, qRental.Command);

  if Apply.Errors.Count > 0 then
    raise Exception.Create(Apply.Errors.Strings.Text);
end;

// Saves changes to rentaccoms to rentaccom table
procedure TServerMethods.SaveRentAccoms(const DeltaList: TFDJSONDeltas);
var
  Apply : IFDJSONDeltasApplyUpdates;
begin
  Apply := TFDJSONDeltasApplyUpdates.Create(DeltaList);
  Apply.ApplyUpdates(sRentAccom, qRentAccom.Command);

  if Apply.Errors.Count > 0 then
    raise Exception.Create(Apply.Errors.Strings.Text);
end;

// Saves changes to people to person table and
// returns array of new ids with corresponding old  temp ids of added people
// Objects that don't have an ID set yet have a temporary negative ID
function TServerMethods.SavePayments(const DeltaList: TFDJSONDeltas) : TResultsArray;
var
  Apply : IFDJSONDeltasApplyUpdates;
  NumAdded : Integer;
  AutoInc: Integer;
begin
  AutoInc := GetAutoIncrement('payment');
  NumAdded := 0;

  Result := TResultsArray.Create;
  with TFDJSONDeltasReader.GetListValueByName(DeltaList, sPayment) do
  begin
    First;
    while not EOF do
    begin
      // Items that don't have an ID set yet have a temporary negative ID
      if FieldByName('PayID').Value < 0 then
      begin
        Result.AddID(FieldByName('PayID').Value, AutoInc + NumAdded);
        NumAdded := NumAdded + 1;
      end;
      Next;
    end;
  end;
  Apply := TFDJSONDeltasApplyUpdates.Create(DeltaList);
  Apply.ApplyUpdates(sPayment, qPayment.Command);

  if Apply.Errors.Count > 0 then
    raise Exception.Create(Apply.Errors.Strings.Text);
end;

// Saves changes to travels to travel table and
// returns array of new ids with corresponding old temp ids of added travels
// Objects that don't have an ID set yet have a temporary negative ID
function TServerMethods.SaveTravel(const DeltaList: TFDJSONDeltas) : TResultsArray;
var
  Apply : IFDJSONDeltasApplyUpdates;
  NumAdded : Integer;
  AutoInc: Integer;
begin
  AutoInc := GetAutoIncrement('travel');
  NumAdded := 0;

  Result := TResultsArray.Create;
  with TFDJSONDeltasReader.GetListValueByName(DeltaList, sTravel) do
  begin
    First;
    while not EOF do
    begin
      // Items that don't have an ID set yet have a temporary negative ID
      if FieldByName('TravelID').Value < 0 then
      begin
        Result.AddID(FieldByName('TravelID').Value, AutoInc + NumAdded);
        NumAdded := NumAdded + 1;
      end;
      Next;
    end;
  end;
  Apply := TFDJSONDeltasApplyUpdates.Create(DeltaList);
  Apply.ApplyUpdates(sTravel, qTravel.Command);

  if Apply.Errors.Count > 0 then
    raise Exception.Create(Apply.Errors.Strings.Text);
end;

// Saves changes to bookingperson table
procedure TServerMethods.SaveBookingPerson(const DeltaList : TFDJSONDeltas);
var
  Apply : IFDJSONDeltasApplyUpdates;
  str : string;
begin
  Apply := TFDJSONDeltasApplyUpdates.Create(DeltaList);
  str := sBookingPerson;
  Apply.ApplyUpdates(sBookingPerson, qBookingPerson.Command);

  if Apply.Errors.Count > 0 then
    raise Exception.Create(Apply.Errors.Strings.Text);
end;

function TServerMethods.GetBanks : TFDJSONDataSets;
begin
  // Clear active so that the query will reexecute
  qBank.Active := False;
  // Set Result to be result of query
  Result := TFDJSONDataSets.Create;
  TFDJsonDataSetsWriter.ListAdd(Result, qBank);
end;

function TServerMethods.GetBankByID(BankID : Integer) : String;
begin
  // Clear active so that the query will reexecute
  qBankByID.Active := False;
  // Set query parameters
  qBankByID.ParamByName('BankID').AsInteger := BankID;
  // Set Result to be result of query
  qBankByID.Open;
  try
    Result := qBankByID.Table.Rows.ItemsI[0].GetValues('BankName');
  except
    Result := 'Bank not found';
  end;
end;

function TServerMethods.GetAccoms : TFDJSONDataSets;
begin
  // Clear active so that the query will reexecute
  qAccom.Active := False;
  // Set Result to be result of query
  Result := TFDJSONDataSets.Create;
  TFDJsonDataSetsWriter.ListAdd(Result, qAccom);
end;

// HOME TAB
function TServerMethods.GetUpcomingDeposits(Limit : Integer) : TFDJSONDataSets;
begin
  // Clear active so that the query will reexecute
  qUpDeposits.Active := False;
  // Set query parameters
  qUpDeposits.ParamByName('Limit').AsInteger := Limit;
  // Set Result to be result of query
  Result := TFDJSONDataSets.Create;
  TFDJsonDataSetsWriter.ListAdd(Result, qUpDeposits);
end;

function TServerMethods.GetRecentBookings(Limit: Integer) : TFDJSONDataSets;
begin
  // Clear active so that the query will reexecute
  qRecentBookings.Active := False;
  // Set query parameters
  qRecentBookings.ParamByName('Limit').AsInteger := Limit;
  // Set Result to be result of query
  Result := TFDJSONDataSets.Create;
  TFDJSONDataSetsWriter.ListAdd(Result, qRecentBookings);
  Result := Result;
end;

function TServerMethods.GetRecentClients(Limit : Integer) : TFDJSONDataSets;
begin
    // Clear active so that the query will reexecute
  qRecentClients.Active := False;
  // Set query parameters
  qRecentClients.ParamByName('Limit').AsInteger := Limit;
  // Set Result to be result of query
  Result := TFDJSONDataSets.Create;
  TFDJSONDataSetsWriter.ListAdd(Result, qRecentClients);
  Result := Result;
end;

// SEARCH
// Searches clients by First name. Returns Limit results.
function TServerMethods.SearchFirst(FirstName: string; Limit : Integer) : TFDJSONDataSets;
var
  StringList : TStrings;
  Count : Integer;
  I: Integer;
  Text : String;
begin
  // Because spaces get messed up on the cross over from client to server
  FirstName := StringReplace(FirstName,'^',' ', [rfReplaceAll]);
  StringList := DatabaseStrings.SplitString(FirstName);
  Count := StringList.Count;
  if Count > 0 then
  begin
    // Clear active so that the query will reexecute
    qSearchFirst.Active := False;
    // Generate SQL Text
    // First one has no union
    Text := '(SELECT DISTINCT ' + sLineBreak +
      'c.ClientID, c.City, c.ProvState, ' + sLineBreak +
      'c.Country, c.Notes, COALESCE(MAX(b.DateCalled),DateEntered) as Date ' + sLineBreak +
      'FROM client c ' + sLineBreak +
      'LEFT JOIN person p ' + sLineBreak +
      'ON c.ClientID = p.ClientID ' + sLineBreak +
      'LEFT JOIN booking b ' + sLineBreak +
      'ON c.ClientID = b.ClientID ' + sLineBreak +
      'AND b.Status != ''Cancelled'' ' + sLineBreak +
      'WHERE FirstName like CONCAT(''%'',CONCAT(''' + StringList[0] + ''',''%'')) '  + sLineBreak +
      'AND Active = 1 ' + sLineBreak +
      'GROUP BY c.ClientID, c.City, ' + sLineBreak +
      'c.ProvState, c.Country, c.Notes) ';
    if Count > 1 then
    begin
      for I := 1 to Count-1 do
      begin
        // Later ones precede with union
        Text := Text + sLineBreak + 'UNION ' + sLineBreak +
          '(SELECT DISTINCT ' + sLineBreak +
          'c.ClientID, c.City, c.ProvState, ' + sLineBreak +
          'c.Country, c.Notes, COALESCE(MAX(b.DateCalled),DateEntered) as Date ' + sLineBreak +
          'FROM client c ' + sLineBreak +
          'LEFT JOIN person p ' + sLineBreak +
          'ON c.ClientID = p.ClientID ' + sLineBreak +
          'LEFT JOIN booking b ' + sLineBreak +
          'ON c.ClientID = b.ClientID ' + sLineBreak +
          'AND b.Status != ''Cancelled'' ' + sLineBreak +
          'WHERE FirstName like CONCAT(''%'',CONCAT(''' + StringList[I] + ''',''%'')) '  + sLineBreak +
          'AND Active = 1 ' + sLineBreak +
          'GROUP BY c.ClientID, c.City, ' + sLineBreak +
          'c.ProvState, c.Country, c.Notes) ';
      end;
    end;
    Text := Text + sLineBreak + 'ORDER BY Date DESC' + sLineBreak + 'LIMIT ' + Limit.ToString;
    qSearchFirst.SQL.Text := Text;
  end;
  // Set Result to be result of query
  Result := TFDJSONDataSets.Create;
  TFDJsonDataSetsWriter.ListAdd(Result, qSearchFirst);
end;

// Searches clients by Last name. Returns Limit results.
function TServerMethods.SearchLast(LastName: string; Limit : Integer) : TFDJSONDataSets;
var
  StringList : TStrings;
  Count : Integer;
  I: Integer;
  Text : String;
begin
  // Because spaces get messed up on the cross over from client to server
  LastName := StringReplace(LastName,'^',' ', [rfReplaceAll]);
  StringList := DataBaseStrings.SplitString(LastName);
  Count := StringList.Count;
  if Count > 0 then
  begin
    // Clear active so that the query will reexecute
    qSearchLast.Active := False;
    // Generate SQL Text
    // First one has no union
    Text := '(SELECT DISTINCT ' + sLineBreak +
      'c.ClientID, c.City, c.ProvState, ' + sLineBreak +
      'c.Country, c.Notes, COALESCE(MAX(b.DateCalled),DateEntered) as Date ' + sLineBreak +
      'FROM client c ' + sLineBreak +
      'LEFT JOIN person p ' + sLineBreak +
      'ON c.ClientID = p.ClientID ' + sLineBreak +
      'LEFT JOIN booking b ' + sLineBreak +
      'ON c.ClientID = b.ClientID ' + sLineBreak +
      'AND b.Status != ''Cancelled'' ' + sLineBreak +
      'WHERE LastName like CONCAT(''%'',CONCAT(''' + StringList[0] + ''',''%'')) '  + sLineBreak +
      'AND Active = 1 ' + sLineBreak +
      'GROUP BY c.ClientID, c.City, ' + sLineBreak +
      'c.ProvState, c.Country, c.Notes) ';
    if Count > 1 then
    begin
      for I := 1 to Count-1 do
      begin
        // Later ones precede with union
        Text := Text + 'UNION ' + sLineBreak +
          '(SELECT DISTINCT ' + sLineBreak +
          'c.ClientID, c.City, c.ProvState, ' + sLineBreak +
          'c.Country, c.Notes, COALESCE(MAX(b.DateCalled),DateEntered) as Date ' + sLineBreak +
          'FROM client c ' + sLineBreak +
          'LEFT JOIN person p ' + sLineBreak +
          'ON c.ClientID = p.ClientID ' + sLineBreak +
          'LEFT JOIN booking b ' + sLineBreak +
          'ON c.ClientID = b.ClientID ' + sLineBreak +
          'AND b.Status != ''Cancelled'' ' + sLineBreak +
          'WHERE LastName like CONCAT(''%'',CONCAT(''' + StringList[I] + ''',''%'')) '  + sLineBreak +
          'AND Active = 1 ' + sLineBreak +
          'GROUP BY c.ClientID, c.City, ' + sLineBreak +
          'c.ProvState, c.Country, c.Notes) ';
      end;
    end;
    Text := Text + sLineBreak + 'ORDER BY Date DESC' + sLineBreak + 'LIMIT ' + Limit.ToString;
    qSearchLast.SQL.Text := Text;
  end;
  // Set Result to be result of query
  Result := TFDJSONDataSets.Create;
  TFDJsonDataSetsWriter.ListAdd(Result, qSearchLast);
end;

// Searches clients by City. Returns Limit results.
function TServerMethods.SearchCity(City: string; Limit : Integer) : TFDJSONDataSets;
begin
  City := StringReplace(City,'^',' ', [rfReplaceAll]);
  // Clear active so that the query will reexecute
  qSearchCity.Active := False;
  // Set query parameters
  qSearchCity.ParamByName('City').AsString := City;
  qSearchCity.ParamByName('Limit').AsInteger := Limit;
  // Set Result to be result of query
  Result := TFDJSONDataSets.Create;
  TFDJsonDataSetsWriter.ListAdd(Result, qSearchCity);
end;

// Searches clients by Country. Returns Limit results.
function TServerMethods.SearchCountry(Country: string; Limit : Integer) : TFDJSONDataSets;
begin
  Country := StringReplace(Country,'^',' ', [rfReplaceAll]);
  // Clear active so that the query will reexecute
  qSearchCountry.Active := False;
  // Set query parameters
  qSearchCountry.ParamByName('Country').AsString := Country;
  qSearchCountry.ParamByName('Limit').AsInteger := Limit;
  // Set Result to be result of query
  Result := TFDJSONDataSets.Create;
  TFDJsonDataSetsWriter.ListAdd(Result, qSearchCountry);
end;

// Returns corresponding person objects for successful search results
function TServerMethods.SearchPeople(IDList: String) : TFDJSONDataSets;
begin
  // If IDList empty return empty result
  if IDList = '()' then
  begin
    Result := TFDJSONDataSets.Create;
  end
  else
  begin
    // Clear active so that the query will reexecute
    qSearchPeople.Active := False;
    // Set query SQL
    qSearchPeople.SQL.Text := 'SELECT DISTINCT ' +
                              'PersonID, ClientID, FirstName, LastName ' +
                              'FROM person ' +
                              'WHERE ClientID in ' + IDList;

    // Set Result to be result of query
    Result := TFDJSONDataSets.Create;
    TFDJSONDataSetsWriter.ListAdd(Result, qSearchPeople);
  end;
end;

// CALENDAR
// Returns all available calendar bookings as classBookingItems
function TServerMethods.Calendar(StartDate: TDateTime; EndDate: TDateTime) : TFDJSONDataSets;
begin
  // Clear active so that the query will reexecute
  qCalendar.Active := False;
  // Set query parameters
  qCalendar.ParamByName('StartDate').AsDateTime := StartDate;
  qCalendar.ParamByName('EndDate').AsDateTime := EndDate;
  // Set Result to be result of query
  Result := TFDJSONDataSets.Create;
  TFDJsonDataSetsWriter.ListAdd(Result, qCalendar);
end;

// Sends image of calendar to email in eCalendarExport
// Idea is that the employees and other people at Casa Dulce Vida print it out
// and have a schedule of visitors
function TServerMethods.EmailBitmap(Image: TMemoryStream; Email: string; EmailUser : TEmailUser; Body : String) : Boolean;
var
  Attachment : TIdAttachmentFile;
  FileStream : TFileStream;
  Filepath : string;
begin
  Result := False;
  MailMessage.Clear;
  // Setup mail message
  SMTP.Host := 'smtp.dulcevida.com';
  SMTP.Port := 587;
  SMTP.Username := 'liveit@dulcevida.com';
  SMTP.Password := 'Aldama295';
  MailMessage.Recipients.EMailAddresses := Email;
  MailMessage.Subject := 'Dulce Vida Bookings';
  MailMessage.Body.Add(Body);
  MailMessage.From.Address := EmailUser.Address;
  MailMessage.From.Name := EmailUser.Name;

  // Attach image and send email
  try
    EnsureDirExists;
    Filepath := IOUtils.TPath.Combine(sDirName,'Calendar.bmp');
    FileStream := TFileStream.Create(Filepath, fmCreate or fmShareDenyNone);
    FileStream.CopyFrom(Image,Image.Size);
    Filestream.Free;

    Attachment := TIdAttachmentFile.Create(MailMessage.MessageParts, Filepath);

    SMTP.Connect;
    SMTP.Send(MailMessage);
    Result := True;
  finally
    if SMTP.Connected then SMTP.Disconnect;
    Attachment.Free;
  end;
end;

// REPORTS
// Generates a voucher report, saves it, and returns filepath
function TServerMethods.MakeVoucher(BookingID : Integer) : String;
var
  FileStream : TFileStream;
begin
  // Clear active so that the query will reexecute
  qVoucherRental.Active := False;
  qVoucherAmt.Active    := False;
  qReportPeople.Active  := False;
  qReportTravel.Active  := False;
  qMainPerson.Active    := False;
  // Set query parameters
  qVoucherRental.ParamByName('BookingID').AsInteger := BookingID;
  qVoucherAmt.ParamByName('BookingID').AsInteger    := BookingID;
  qReportPeople.ParamByName('BookingID').AsInteger  := BookingID;
  qReportTravel.ParamByName('BookingID').AsInteger  := BookingID;
  qMainPerson.ParamByName('BookingID').AsInteger  := BookingID;
  // Open query
  qVoucherRental.Open;
  qVoucherAmt.Open;
  qReportPeople.Open;
  qReportTravel.Open;
  qMainPerson.Open;

  try
    EnsureDirExists;
    Result := IOUtils.TPath.Combine(sDirName, sDulceVida + ' ' +
      qMainPerson.FieldByName('FirstName').AsString + ' ' +
      qMainPerson.FieldByName('LastName').AsString + ' ' +
      sVoucher + ' ' + qVoucherAmt.FieldByName('Date').AsString) + '.pdf';
    FileStream := TFileStream.Create(Result, fmCreate or fmShareDenyNone);
    PDFExport.Stream := FileStream;
    rVoucher.PrepareReport(True);
    rVoucher.Export(PDFExport);
  finally
    FreeAndNil(FileStream);
    PDFExport.Stream := nil;
  end;
end;

// Generates a invoice report, saves it, and returns filepath
function TServerMethods.MakeInvoice(BookingID : Integer) : String;
var
  FileStream : TFileStream;
begin
    // Clear active so that the query will reexecute
  qInvoiceRental.Active := False;
  qInvoiceBooking.Active:= False;
  qInvoiceClient.Active := False;
  qReportTravel.Active  := False;
  qMainPerson.Active    := False;
  // Set query parameters
  qInvoiceRental.ParamByName('BookingID').AsInteger := BookingID;
  qInvoiceBooking.ParamByName('BookingID').AsInteger:= BookingID;
  qInvoiceClient.ParamByName('BookingID').AsInteger:= BookingID;
  qReportTravel.ParamByName('BookingID').AsInteger  := BookingID;
  qMainPerson.ParamByName('BookingID').AsInteger  := BookingID;
  // Open query
  qInvoiceRental.Open;
  qInvoiceBooking.Open;
  qInvoiceClient.Open;
  qReportTravel.Open;
  qMainPerson.Open;

  try
    EnsureDirExists;
    Result := IOUtils.TPath.Combine(sDirName, sDulceVida + ' ' +
      qMainPerson.FieldByName('FirstName').AsString + ' ' +
      qMainPerson.FieldByName('LastName').AsString + ' ' +
      sInvoice + ' ' + qInvoiceBooking.FieldByName('Date').AsString) + '.pdf';
    FileStream := TFileStream.Create(Result, fmCreate or fmShareDenyNone);
    PDFExport.Stream := FileStream;
    rInvoice.PrepareReport(True);
    rInvoice.Export(PDFExport);
  finally
    FreeAndNil(FileStream);
    PDFExport.Stream := nil;
  end;
end;

// Uploads a report to Amazon Web Services storage
// Bucket is AWS bucket to hold it, AWSName is what the object will be saved as,
// and filename is the filepath to the object to upload
function TServerMethods.UploadToS3(Bucket : String; AWSName : String; Filename : String) : Boolean;
var
  S3 : TAmazonStorageService;
  FS : TFilestream;
  Headers : TStrings;
  Content : TBytes;
begin
  S3 := TAmazonStorageService.Create(AWSConnection);
  try
    FS := TFileStream.Create(Filename, fmOpenRead);

    SetLength(Content,FS.Size);
    if FS.Size > 0 then
      FS.Read(Content[0],FS.Size);

    Headers := TStringList.Create;
    Headers.AddPair('Content-Type','application/pdf');
    Result := S3.UploadObject(Bucket, AWSName, Content, false, nil, Headers, amzbaPublicRead);
  finally
    FreeAndNil(S3);
    FreeAndNil(FS);
  end;
end;

// Create pdf and upload to S3 and return link so it can be opened with webbrowser
function TServerMethods.PreviewVoucher(BookingID : Integer) : String;
var
  Bucket : String;
  AWSObject : String;
  Filename : String;
  Success : Boolean;
begin
  Bucket := 'dvtravel';
  AWSObject := 'Voucher.pdf';
  Filename := MakeVoucher(BookingID);
  Success := UploadToS3(Bucket,AWSObject,Filename);
  if Success then
    Result := 'https://s3.amazonaws.com/'+Bucket + '/' +AWSObject
  else
    Result := 'FAIL';
  DeleteFile(Filename);
end;

// Create pdf and upload to S3 and return link so it can be opened with webbrowser
function TServerMethods.PreviewInvoice(BookingID : Integer) : String;
var
  Bucket : String;
  AWSObject : String;
  Filename : String;
  Success : Boolean;
begin
  Bucket := 'dvtravel';
  AWSObject := 'Invoice.pdf';
  Filename := MakeInvoice(BookingID);
  Success := UploadToS3(Bucket, AWSObject, Filename);
  if Success then
    Result := 'https://s3.amazonaws.com/'+Bucket + '/' +AWSObject
  else
    Result := 'FAIL';
  DeleteFile(Filename);
end;

// Generates and emails a voucher based on BookingID to addresses in EmailList.
// will appear as from EmailUser
function TServerMethods.SendVoucher(EmailList : String; EmailUser : TEmailUser; BookingID : Integer) : Boolean;
var
  Filename : String;
begin
  Filename := MakeVoucher(BookingID);
  Result := SendReport(0, EmailList, EmailUser, Filename);
end;

function TServerMethods.SendInvoice(Mode : Integer; EmailList : String; EmailUser : TEmailUser; BookingID : Integer) : Boolean;
var
  Filename : String;
begin
  Filename := MakeInvoice(BookingID);
  Result := SendReport(Mode, EmailList, EmailUser, Filename);
end;

// http://delphi.about.com/od/indy/a/email-send-indy.htm
// http://support.codegear.com/article/36054
// Emails file at Filename to all addresses in EmailList
// Mode 0 is voucher, Mode 1 is Invoice without paypal, Mode 2 is Invoice with paypal message, Mode 3 is Invoice as Receipt
function TServerMethods.SendReport(Mode : Integer; EmailList : String;  EmailUser: TEmailUser; Filename : String) : Boolean;
var
  Attachment : TIdAttachmentFile;
  From : TIdEmailAddressItem;
  Subject : String;
  Body : String;
begin
  Result := False;
  MailMessage.Clear;
  // Setup mail message
  if Length(EmailList) > 0 then
  begin
    SMTP.Host := '';
    SMTP.Port := 0;
    SMTP.Username := '';
    SMTP.Password := '';
    MailMessage.Recipients.EMailAddresses := EmailList;

    From := MailMessage.ReplyTo.Add;
    From.Address := EmailUser.Address;
    // Because spaces get messed up on the cross over from client to server
    EmailUser.Name := StringReplace(EmailUser.Name,'^',' ', [rfReplaceAll]);
    From.Name := EmailUser.Name;
    MailMessage.From.Name := EmailUser.Name;
    MailMessage.From.Address := EmailUser.Address;
    MailMessage.Sender.Name := EmailUser.Name;
    MailMessage.Sender.Address := EmailUser.Address;

    Subject := 'Dulce Vida ' +
      qMainPerson.FieldByName('FirstName').AsString + ' ' +
      qMainPerson.FieldByName('LastName').AsString;
    if Mode = 0 then
    begin
      Subject := Subject + ' Voucher';
      Body := VoucherMessage;
    end
    else
    if Mode > 0 then
    begin
      Subject := Subject + ' Invoice';
      Body := InvoiceMessage1;
      if Mode <> 3 then Body := Body + InvoiceMessage2;
      if Mode = 2 then Body := Body + InvoiceMessagePaypal;
      Body := Body + InvoiceMessage3 + InvoiceMessage4;
    end;
    Body := Body + sLinebreak + sLineBreak + sTagline;
    MailMessage.Subject := Subject;
    MailMessage.Body.Text := Body;

    if FileExists(Filename) then
    begin
      try
        Attachment := TIdAttachmentFile.Create(MailMessage.MessageParts, Filename);
        SMTP.Connect;
        SMTP.Send(MailMessage);
        DeleteFile(Filename);
        Result := True;
      finally
        if SMTP.Connected then SMTP.Disconnect;
        Attachment.Free;
      end;
    end;
  end;
end;

end.

