unit BookingsTabView;

// Controls view of BookingsTab
// Sub Units are RentalView, PaymentView, TravelView

interface
uses
  classRental, classPayment, classTravel, classBooking, classResultsArray, Misc,
  ClientModuleUnit1,
  FMX.ListBox, System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants, DateUtils, StrUtils;

var
  ClientID: Integer;

procedure SwitchToBookings;

// Sets Outstanding $ for the current booking on the bookings tab
procedure CalculateOutstanding;
procedure ClearBookingTabView;
procedure SetBooking(Booking : TBooking);

// Updates old negative temporary IDs with new ones once they've been properly
// added to the database
procedure UpdateBookingIDs(ResultsArray : TResultsArray);
procedure SetTabSaved;
procedure SaveBooking;

implementation
uses Main, BookingController, BookingView, BookingsTabController, SelectPeople;

procedure SwitchToBookings;
begin
  MainForm.TabControl1.ActiveTab := MainForm.TabControl1.Tabs[2];
end;

// Sets Outstanding $ for the current booking on the bookings tab
// Called by bPaymentView.CalculatePaymentsTotal and bRentalView.CalculateRentalsTotal
procedure CalculateOutstanding;
var
  Value : Double;
begin
with MainForm do
begin
  Value := StrToFloat(lRentalTotalData.Text) - StrToFloat(lPaymentTotalData.Text);
  lBookingsOutstandingData.Text := Value.ToString;
end;
end;

procedure ClearBookingTabView;
begin
  MainForm.eDeposit.Value := 0;
  MainForm.lRentalTotalData.Text := '0';
  MainForm.lPaymentTotalData.Text := '0';

  MainForm.lbRental.Clear;
  MainForm.lbPayments.Clear;
  MainForm.lbTravel.Clear;
end;

procedure SetBooking(Booking : TBooking);
var
  I : Integer;
begin
  with MainForm do
  begin
    // mtBooking
    lInvNumData.Text := Booking.BookingId.ToString;

    // If dates are null set then to appear null
    if Booking.DateCalled = NullDate then
    begin
      eCalledDate.Date := Date;
      eCalledDate.Format := ' ';
    end
    else
      eCalledDate.Date := Booking.DateCalled;

    if Booking.InvoiceDate = NullDate then
    begin
      eInvoiceDate.Date := Date;
      eInvoiceDate.Format := ' ';
    end
    else
      eInvoiceDate.Date := Booking.InvoiceDate;

    if Booking.VoucherDate = NullDate then
    begin
      eVoucherDate.Date := Date;
      eVoucherDate.Format := ' ';
    end
    else
      eVoucherDate.Date := Booking.VoucherDate;

    if Booking.DepositDueDate = NullDate then
    begin
      eDepositDate.Date := Date;
      eDepositDate.Format := ' ';
    end
    else
      eDepositDate.Date := Booking.DepositDueDate;
    // Everything else
    I := eRentalCurrency.Items.IndexOf(Booking.Currency);
    if I > -1 then
    begin
      eRentalCurrency.ItemIndex := I;
    end
    else
    begin
      eRentalCurrency.ItemIndex := eRentalCurrency.Items.IndexOf('Other');
    end;

    // If not created by info, make it invisible
    if Booking.CreatedBy <> '' then
    begin
      lCreatedByTitle.Visible := True;
      lCreatedByData.Text := Booking.CreatedBy;
    end
    else
    begin
      lCreatedByTitle.Visible := False;
    end;

    eDeposit.Value := Booking.Deposit;
    eBookingsStatus.ItemIndex := eBookingsStatus.Items.IndexOf(Booking.Status);
    eRentalNotes.Text := Booking.ServiceNotes;
    ePaymentNotes.Text := Booking.AcctgNotes;

    lBookingsClient.Text := SelectPeople.GetClientNames;
  end;
end;

// Updates old negative temporary IDs with new ones once they've been properly
// added to the database
procedure UpdateBookingIDs(ResultsArray : TResultsArray);
var
  I : Integer;
  J : Integer;
  Booking : TBooking;
  Rental : TRental;
  Payment: TPayment;
  Travel : TTravel;
begin
  with MainForm.lbClientsBookings do
  begin
    // For each changed ID...
    for J := 0 to ResultsArray.GetLen-1 do
    begin
      I := Items.IndexOf(ResultsArray.GetID(J).OldID.ToString);
      while I <> -1 do
      begin
        Booking := ListItems[I].Data as TBooking;
        Booking.BookingId := ResultsArray.GetID(J).NewID;
        ListItems[I].Data := Booking;
        ListItems[I].Text := Booking.BookingId.ToString;
        ListItems[I].ItemData.Detail := Booking.ToString;
        I := Items.IndexOf(ResultsArray.GetID(J).OldID.ToString);
      end;
    end;
  end;
  with MainForm.lInvNumData do
  begin
    for J := 0 to ResultsArray.GetLen-1 do
    begin
      if Text = ResultsArray.GetID(J).OldID.ToString then
      begin
        Text := ResultsArray.GetID(J).NewID.ToString;
      end;
    end;
  end;
  with MainForm.lbRental do
  begin
    // For each Rental
    for I := 0 to Count-1 do
    begin
      // For each changed ID (probably only one)
      for J := 0 to ResultsArray.GetLen-1 do
      begin
        Rental := ListItems[I].Data as TRental;
        if Rental.BookID = ResultsArray.GetID(J).OldID then
        begin
          Rental.BookID := ResultsArray.GetID(J).NewID;
          ListItems[I].Data := Rental;
          ListItems[I].ItemData.Detail := Rental.ToString;
        end;
      end;
    end;
  end;
  with MainForm.lbPayments do
  begin
    // For each Payment
    for I := 0 to Count-1 do
    begin
      // For each changed ID (probably only one)
      for J := 0 to ResultsArray.GetLen-1 do
      begin
        Payment := ListItems[I].Data as TPayment;
        if Payment.BookID = ResultsArray.GetID(J).OldID then
        begin
          Payment.BookID := ResultsArray.GetID(J).NewID;
          ListItems[I].Data := Payment;
          ListItems[I].ItemData.Detail := Payment.ToString;
        end;
      end;
    end;
  end;
  with MainForm.lbTravel do
  begin
    // For each Travel
    for I := 0 to Count-1 do
    begin
      // For each changed ID (probably only one)
      for J := 0 to ResultsArray.GetLen-1 do
      begin
        Travel := ListItems[I].Data as TTravel;
        if Travel.BookID = ResultsArray.GetID(J).OldID then
        begin
          Travel.BookID := ResultsArray.GetID(J).NewID;
          ListItems[I].Data := Travel;
          ListItems[I].ItemData.Detail := Travel.ToString;
        end;
      end;
    end;
  end;
end;

procedure SetTabSaved;
begin
  Main.MainForm.cbBookingsSave.IsChecked := True;
end;

procedure SaveBooking;
var
  Booking : TBooking;
  Error : Boolean;
  Voucher : TDate;
  Invoice : TDate;
  PersonID: Integer;
  StartDate : TDateTime;
  EndDate : TDateTime;
  Rental : TRental;

  I: Integer;
begin
with MainForm do
begin
  if cbBookingsSave.IsChecked = False then
  begin
    Error := False;
    lCalledDate.FontColor := TAlphaColorRec.Black;
    bInvoice.FontColor := TAlphaColorRec.Black;
    lDepositDate.FontColor := TAlphaColorRec.Black;
    // DateCalled, InvoiceDate, and DepositDueDate must not be null
    if (eCalledDate.Format <> '')  then
    begin
      Error := True;
      lCalledDate.FontColor := TAlphaColorRec.Red;
    end;
    if (eDepositDate.Format <> '') then
    begin
      Error := True;
      lDepositDate.FontColor := TAlphaColorRec.Red;
    end;
    // If blank, voucher date is null
    if eVoucherDate.Format = '' then
      Voucher := eVoucherDate.Date
    else
      Voucher := NullDate;
    // If blank, invoice date is null
    if eInvoiceDate.Format = '' then
      Invoice := eInvoiceDate.Date
    else
      Invoice := NullDate;

    if not Error then
    begin
      try
        PersonID := Integer(cbMainPerson.Selected.Data);
      except
        PersonID := 0;
      end;

      // Find min StartDate, max EndDate from rentals
      StartDate := 1000000000;
      EndDate := 0;
      with MainForm.lbRental do
      begin
        for I := 0 to Count-1 do
        begin
          Rental := ListItems[I].Data as TRental;
          if Rental.StartDate < StartDate then StartDate := Rental.StartDate;
          if Rental.EndDate > EndDate then EndDate := Rental.EndDate;
        end;
      end;
      if StartDate = 1000000000 then StartDate := 0;



      Booking := TBooking.Create(
                          StrToInt(lInvNumData.Text),
                          ClientID,
                          PersonID,
                          eCalledDate.Date,
                          Invoice,
                          Voucher,
                          eDepositDate.Date,
                          eRentalCurrency.Selected.Text,
                          StrToFloat(lRentalTotalData.Text),
                          eDeposit.Value,
                          StrToFloat(lPaymentTotalData.Text),
                          eBookingsStatus.Selected.Text,
                          eRentalNotes.Text,
                          ePaymentNotes.Text,
                          lCreatedByData.Text,
                          Now,
                          StartDate,
                          EndDate); // Last two are start/end dates

      try
      // Add
      if Booking.BookingId < 0 then
      begin
        BookingController.AddBooking(Booking);
        BookingView.AddBookingToListBox(Booking);
      end
      // Edit
      else
      begin
        BookingController.EditBooking(Booking);
        BookingView.EditBookingListBox(Booking);
      end;
      except
      on E : Exception do
        begin
          MainForm.circleOnlineStatus.Fill.Color := TAlphaColorRec.Red;
          Print('ERROR: ' + E.ClassName + sLineBreak + E.Message);
        end;
      end;

      // Remove "No Booking Selected" screen
      rectNoBookingSet.Visible := False;
      lNoBookingSet.Visible := False;

      // Push changes to database
      BookingsTabController.SaveBooking;
    end;
  end;
end;
end;

end.
