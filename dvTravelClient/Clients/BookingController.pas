unit BookingController;

// Deals mainly with data side of bookings and server connection stuff

interface
uses classBooking, ClientModuleUnit1, Misc,
     Data.FireDACJSONReflect;

// Sets the booking list in CLIENTS TAB, not the currently active booking
// thats BookingsTabController
procedure SetBookings(ClientID : Integer);

// Add and Edit Bookings
procedure BookingFields(Booking : TBooking);
procedure AddBooking(Booking : TBooking);
procedure EditBooking(Booking : TBooking);

implementation
uses  DataController, BookingView;

// Sets the booking list in CLIENTS TAB, not the currently active booking
// thats BookingsTabController
procedure SetBookings(ClientID : Integer);
var
  LDataSetList : TFDJSONDataSets;
  Booking : TBooking;
  Total : Double;
begin
  // Clear memtable
  Module.mtBooking.Close;
  // Get data
  LDataSetList := ClientModule1.ServerMethods1Client.GetClientBookings(ClientID);
  Module.mtBooking.Open;
  Module.mtBooking.AppendData(TFDJSONDataSetsReader.GetListValue(LDataSetList,0));
  // Set data
  Total := 0;
  with Module.mtBooking do begin
    First;
    begin
      while not EOF do
      begin
        Total := Total + FieldByName('Charges').AsFloat - Fields.FieldByName('AmtPaid').AsFloat;

        Booking := TBooking.Create(Fields.FieldByName('BookingID').Value,
                                   Fields.FieldByName('ClientID').Value,
                                   IfNull(Fields.FieldByName('PersonID').Value,0),
                                   IfNull(Fields.FieldByName('DateCalled').Value,0),
                                   IfNull(Fields.FieldByName('InvoiceDate').Value,0),
                                   IfNull(Fields.FieldByName('VoucherDate').Value,0),
                                   IfNull(Fields.FieldByName('DepositDueDate').Value,0),
                                   IfNull(Fields.FieldByName('Currency').Value,'Other'),
                                   IfNull(Fields.FieldByName('Charges').AsFloat,0),
                                   IfNull(Fields.FieldByName('DepositAmt').Value,0),
                                   IfNull(Fields.FieldByName('AmtPaid').Value,0),
                                   IfNull(Fields.FieldByName('Status').Value,''),
                                   IfNull(Fields.FieldByName('AcctgNotes').asString,''),
                                   IfNull(Fields.FieldByName('ServiceNotes').asString,''),
                                   IfNull(Fields.FieldByName('CreatedBy').AsString,''),
                                   IfNull(Fields.FieldByName('Modified').AsDateTime,0),
                                   IfNull(Fields.FieldByName('StartDate').AsDateTime,0),
                                   IfNull(Fields.FieldByName('EndDate').AsDateTime,0));

        BookingView.AddBookingToListBoxAtStart(Booking);
        Next;
      end;
    end;
  end;
  BookingView.BookingsOutstandingCalculate;
end;

// BOOKING
// Sets fields of the current entry in mtBooking according to the TBooking
// Used in AddToBookings and EditBooking
procedure BookingFields(Booking : TBooking);
begin
  with Module.mtBooking do begin
    Fields.FieldByName('BookingID').AsInteger       := Booking.BookingId;
    Fields.FieldByName('ClientId').AsInteger        := Booking.ClientId;
    Fields.FieldByName('PersonID').AsInteger        := Booking.PersonID;
    Fields.FieldByName('DateCalled').AsDateTime     := Booking.DateCalled;
    Fields.FieldByName('InvoiceDate').AsDateTime    := Booking.InvoiceDate;
    Fields.FieldByName('VoucherDate').AsDateTime    := Booking.VoucherDate;
    Fields.FieldByName('DepositDueDate').AsDateTime := Booking.DepositDueDate;
    Fields.FieldByName('Currency').AsString         := Booking.Currency;
    Fields.FieldByName('Charges').AsFloat           := Booking.Charges;
    Fields.FieldByName('DepositAmt').AsFloat        := Booking.Deposit;
    Fields.FieldByName('AmtPaid').AsFloat           := Booking.Paid;
    Fields.FieldByName('Status').AsString           := Booking.Status;
    Fields.FieldByName('AcctgNotes').AsString       := Booking.AcctgNotes;
    Fields.FieldByName('ServiceNotes').AsString     := Booking.ServiceNotes;
    Fields.FieldByName('CreatedBy').AsString        := Booking.CreatedBy;
    Fields.FieldByName('Modified').AsDateTime       := Booking.Modified;
  end;
end;

procedure AddBooking(Booking : TBooking);
begin
  Module.mtBooking.Open;
  Module.mtBooking.Append;
  BookingFields(Booking);
  Module.mtBooking.Post;
end;

procedure EditBooking(Booking : TBooking);
begin
  with Module.mtBooking do begin
    if not Active then Open;
    First;
    while not EOF do
    begin
      if Fields.FieldByName('BookingID').Value = Booking.BookingId then
      begin
        Edit;
        BookingFields(Booking);
        Post;

        Break;
      end
      else
      begin
        Next;
      end;
    end;
  end;
end;

end.
