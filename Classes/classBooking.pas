unit classBooking;

interface
type
  TBooking = class
    Private
      cBookingID  : Integer;
      cClientID   : Integer;
      cPersonID   : Integer;
      cDateCalled : TDateTime;
      cInvoiceDate: TDateTime;
      cVoucherDate: TDateTime;
      cDepositDueDate:TDateTime;
      cCurrency   : String;
      cCharges    : Double;
      cDeposit    : Double;
      cPaid       : Double;
      cStatus      : String;
      cAcctgNotes  : String;
      cServiceNotes: String;
      cCreatedBy   : String;
      cModified    : TDateTime;
      cStartDate   : TDateTime;
      cEndDate     : TDateTime;
    public
      property BookingId : Integer
        read cBookingId write cBookingId;
      property ClientId : Integer
        read cClientId write cClientId;
      property PersonID : Integer
        read cPersonID write cPersonID;
      property DateCalled : TDateTime
        read cDateCalled write cDateCalled;
      property InvoiceDate : TDateTime
        read cInvoiceDate write cInvoiceDate;
      property VoucherDate : TDateTime
        read cVoucherDate write cVoucherDate;
      property DepositDueDate : TDateTime
        read cDepositDueDate write cDepositDueDate;
      property Currency : String
        read cCurrency write cCurrency;
      property Charges : Double
        read cCharges write cCharges;
      property Deposit : Double
        read cDeposit write cDeposit;
      property Paid : Double
        read cPaid write cPaid;
      property Status : String
        read cStatus write cStatus;
      property AcctgNotes : String
        read cAcctgNotes write cAcctgNotes;
      property ServiceNotes : String
        read cServiceNotes write cServiceNotes;
      property CreatedBy : string
        read cCreatedBy write cCreatedBy;
      property Modified : TDateTime
        read cModified write cModified;
      property StartDate : TDateTime
        read cStartDate write cStartDate;
      property EndDate : TDateTime
        read cEndDate write cEndDate;
      constructor Create(nBookingID  : Integer;
                        nClientID   : Integer;
                        nPersonID   : Integer;
                        nDateCalled : TDateTime;
                        nInvoiceDate: TDateTime;
                        nVoucherDate: TDateTime;
                        nDepositDueDate:TDateTime;
                        nCurrency   : String;
                        nCharges    : Double;
                        nDeposit    : Double;
                        nPaid       : Double;
                        nStatus      : String;
                        nAcctgNotes  : String;
                        nServiceNotes: String;
                        nCreatedBy   : String;
                        nModified    : TDateTime;
                        nStartDate   : TDateTime;
                        nEndDate     : TDateTIme);
      function ToString : String;
  end;

implementation
uses SysUtils;

  constructor TBooking.Create(nBookingID: Integer;
                             nClientID: Integer;
                             nPersonID: Integer;
                             nDateCalled: TDateTime;
                             nInvoiceDate: TDateTime;
                             nVoucherDate: TDateTime;
                             nDepositDueDate: TDateTime;
                             nCurrency: string;
                             nCharges: Double;
                             nDeposit: Double;
                             nPaid: Double;
                             nStatus: string;
                             nAcctgNotes: string;
                             nServiceNotes: string;
                             nCreatedBy: string;
                             nModified: TDateTime;
                             nStartDate   : TDateTime;
                             nEndDate     : TDateTIme);
  begin
    BookingId       := nBookingID;
    ClientId        := nClientID;
    PersonID        := nPersonID;
    DateCalled      := nDateCalled;
    InvoiceDate     := nInvoiceDate;
    VoucherDate     := nVoucherDate;
    DepositDueDate  := nDepositDueDate;
    Currency        := nCurrency;
    Charges         := nCharges;
    Deposit         := nDeposit;
    Paid            := nPaid;
    Status          := nStatus;
    AcctgNotes      := nAcctgNotes;
    ServiceNotes    := nServiceNotes;
    CreatedBy       := nCreatedBy;
    Modified        := nModified;
    StartDate       := nStartDate;
    EndDate         := nEndDate;
  end;

  function TBooking.ToString : String;
  begin
    Result := '#' + IntToStr(BookingID) +
    ' | ' + Status +
    ' | Charges : $' + Charges.ToString +
    ' | Paid : $' + Paid.ToString +
    ' | Outstanding: $' + (Charges-Paid).ToString +
    ' | ';

    if StartDate = 0 then
      Result := Result + '?? - '
    else
      Result := Result + DateToStr(StartDate) + ' - ';

    if EndDate = 0 then
      Result := Result + '??'
    else
      Result := Result + DateToStr(EndDate);
  end;

end.
