unit DataController;

// Contains all the memtables used in the application

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  FireDAC.Stan.StorageBin,
  FireDAC.Stan.StorageJSON, classResultsArray;

type
  TModule = class(TDataModule)
    mtPerson: TFDMemTable;
    mtRental: TFDMemTable;
    mtPayments: TFDMemTable;
    mtTravel: TFDMemTable;
    mtClient: TFDMemTable;
    mtContact: TFDMemTable;
    mtBooking: TFDMemTable;
    mtRentAccom: TFDMemTable;
    FDStanStorageJSONLink1: TFDStanStorageJSONLink;
    FDStanStorageBinLink1: TFDStanStorageBinLink;
    mtBank: TFDMemTable;
    mtAccom: TFDMemTable;
    mtSearchFirst: TFDMemTable;
    mtClientClientID: TFDAutoIncField;
    mtClientDateEntered: TDateTimeField;
    mtClientActive: TSmallintField;
    mtClientAddress: TStringField;
    mtClientCity: TStringField;
    mtClientProvState: TStringField;
    mtClientCountry: TStringField;
    mtClientPostalZip: TStringField;
    mtClientNotes: TBlobField;
    mtPersonPersonID: TFDAutoIncField;
    mtPersonClientID: TIntegerField;
    mtPersonFirstName: TStringField;
    mtPersonLastName: TStringField;
    mtPersonNotes: TStringField;
    mtContactContactID: TFDAutoIncField;
    mtContactPersonID: TIntegerField;
    mtContactContactType: TStringField;
    mtContactPhone: TStringField;
    mtPaymentsPayID: TFDAutoIncField;
    mtPaymentsBookID: TIntegerField;
    mtPaymentsPayDate: TDateTimeField;
    mtPaymentsAmtPaid: TFloatField;
    mtPaymentsCurrency: TStringField;
    mtPaymentsConversion: TFloatField;
    mtPaymentsAmtRecvd: TFloatField;
    mtPaymentsPayMethod: TStringField;
    mtPaymentsPayType: TStringField;
    mtPaymentsPayNote: TStringField;
    mtPaymentsBankID: TIntegerField;
    mtRentalRentID: TFDAutoIncField;
    mtRentalBookID: TIntegerField;
    mtRentalStartDate: TDateTimeField;
    mtRentalEndDate: TDateTimeField;
    mtRentalOccupants: TIntegerField;
    mtRentalCharges: TFloatField;
    mtRentalRate: TFloatField;
    mtRentalComment: TStringField;
    mtTravelTravelID: TFDAutoIncField;
    mtTravelBookID: TIntegerField;
    mtTravelTravelMethod: TStringField;
    mtTravelTravelInfo: TStringField;
    mtTravelArrivalDate: TDateTimeField;
    mtTravelTravelNote: TStringField;
    mtContactEmail: TStringField;
    mtBookingBookingID: TFDAutoIncField;
    mtBookingClientID: TIntegerField;
    mtBookingDateCalled: TDateTimeField;
    mtBookingInvoiceDate: TDateTimeField;
    mtBookingVoucherDate: TDateTimeField;
    mtBookingDepositDueDate: TDateTimeField;
    mtBookingCurrency: TStringField;
    mtBookingCharges: TFloatField;
    mtBookingDepositAmt: TFloatField;
    mtBookingAmtPaid: TFloatField;
    mtBookingStatus: TStringField;
    mtBookingAcctgNotes: TBlobField;
    mtBookingServiceNotes: TBlobField;
    mtSearchPerson: TFDMemTable;
    mtSearchLast: TFDMemTable;
    mtSearchCity: TFDMemTable;
    mtSearchCountry: TFDMemTable;
    mtSearchMore: TFDMemTable;
    mtBookingPersonId: TIntegerField;
    mtCalendar: TFDMemTable;
    mtExtraTable: TFDMemTable;
    mtBookingPerson: TFDMemTable;
    mtBookingPersonBookingID: TIntegerField;
    mtBookingPersonPersonID: TIntegerField;
    mtSettings: TFDMemTable;
    mtBookingCreatedBy: TStringField;
    mtBookingModified: TDateTimeField;
    mtClientModified: TDateTimeField;
    mtBookingStartDate: TDateTimeField;
    mtBookingEndDate: TDateTimeField;
    mtRentalDiscountDesc: TStringField;
    mtRentalDiscountAmt: TFloatField;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

procedure ChangeIDs(MemTable : TFDMemTable; Field : String; ReturnedResults : TResultsArray);

var
  Module: TModule;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}

{$R *.dfm}

procedure ChangeIDs(MemTable : TFDMemTable; Field : String; ReturnedResults : TResultsArray);
var
  I : Integer;
begin
  with MemTable do
  begin
    if not Active then Open;
    First;
    // For each record...
    while not EOF do
    begin
      // If ID is a temporary ID (negative)...
      if FieldByName(Field).Value < 0 then
      begin
        // For each changed ID...
        for I := 0 to ReturnedResults.GetLen-1 do
        begin
          // Replace old client IDs with new client IDs
          if FieldByName(Field).Value = ReturnedResults.GetID(I).OldID then
          begin
            Edit;
            FieldByName(Field).Value := ReturnedResults.GetID(I).NewID;
            Post;
            Break;
          end;
        end;
      end;
      Next;
    end;
  end;
end;

end.
