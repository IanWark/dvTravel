unit BookingView;

// Deals with the bookings listbox in the CLIENTS TAB,
// not the currently active booking, thats BookingsTabController

interface
uses classBooking, Misc, ClientsTabController,
     FMX.ListBox, System.SysUtils, DateUtils;

// Calculates and sets the outstanding amount summary
procedure BookingsOutstandingCalculate;
procedure ClearListBox;

// Adds booking to beginning of listbox
procedure AddBookingToListBox(Booking : TBooking);
// Adds booking to end of listbox
procedure AddBookingToListBoxAtStart(Booking : TBooking);

procedure EditBookingListBox(Booking : TBooking);
procedure SelectBooking(const Item: TListBoxItem);
procedure NewBooking;

implementation
uses Main, BookingsTabView, BookingsTabController, SelectPeople;

// Calculates and sets the outstanding amount summary
procedure BookingsOutstandingCalculate;
var
  Total : Double;
  Booking : TBooking;
  I: Integer;
begin
  Total := 0;
  for I := 0 to MainForm.lbClientsBookings.Count-1 do
  begin
    Booking := MainForm.lbClientsBookings.ListItems[I].Data as TBooking;
    if Booking.Status <> 'Cancelled' then
    begin
      Total := Total + Booking.Charges - Booking.Paid;
    end;
  end;
  MainForm.lClientsOutstandingData.Text := Total.ToString;
end;

procedure ClearListBox;
begin
  MainForm.lbClientsBookings.Clear;
end;

// Adds booking to beginning of listbox
procedure AddBookingToListBox(Booking : TBooking);
var
  Item : TListBoxItem;
begin
  Item := TListBoxItem.Create(MainForm.lbClientsBookings);
  Item.Text := Booking.BookingId.ToString;
  Item.Data := Booking;
  Item.ItemData.Detail := Booking.ToString;
  Item.StyleLookup := 'NormalListBoxItem';
  MainForm.lbClientsBookings.InsertObject(0,Item);
  BookingsOutstandingCalculate;
end;

// Adds booking to end of listbox
procedure AddBookingToListBoxAtStart(Booking : TBooking);
var
  Item : TListBoxItem;
begin
  Item := TListBoxItem.Create(MainForm.lbClientsBookings);
  Item.Text := Booking.BookingId.ToString;
  Item.Data := Booking;
  Item.ItemData.Detail := Booking.ToString;
  Item.StyleLookup := 'NormalListBoxItem';
  MainForm.lbClientsBookings.AddObject(Item);
  BookingsOutstandingCalculate;
end;

procedure EditBookingListBox(Booking : TBooking);
var
  I : Integer;
begin
  with Main.MainForm do begin
    I := lbClientsBookings.Items.IndexOf(Booking.BookingId.ToString);
    lbClientsBookings.ListItems[I].ItemData.Detail := Booking.ToString;
    lbClientsBookings.ListItems[I].Data := Booking;

    BookingsOutstandingCalculate;
  end;
end;

procedure SelectBooking(const Item: TListBoxItem);
var
  Booking : TBooking;
begin
  Booking := Item.Data as TBooking;
  BookingsTabView.SwitchToBookings;
  BookingsTabController.SetEditBookingItem(Booking);
end;

// When new booking button is clicked, sets blank booking tab
procedure NewBooking;
var
  Booking : TBooking;
begin
  Booking := TBooking.Create(-MainForm.lbClientsBookings.Count-1,
                             BookingsTabController.CurrentBookingID,
                             ClientsTabController.FirstPersonID,
                             Date,
                             NullDate,
                             NullDate,
                             NullDate,
                             'USD',
                             0,
                             0,
                             0,
                             'Quote',
                             '',
                             '',
                             MainForm.eEmailname.Text,
                             Now,
                             0,
                             0);
  BookingsTabView.ClientID := Booking.ClientID;
  BookingsTabController.ClearBookingsTab;
  BookingsTabView.SetBooking(Booking);
  SelectPeople.SetMainPerson(ClientsTabController.FirstPersonID);
  MainForm.lBookingsClient.Text := SelectPeople.GetClientNames;

  // Deposit due date is week after calling in
  MainForm.eDepositDate.Date := IncDay(Date, 7);

  MainForm.cbBookingsSave.IsChecked := False;
  MainForm.rectNoBookingSet.Visible := False;
  MainForm.lNoBookingSet.Visible    := False;
  BookingsTabView.SwitchToBookings;
end;

end.
