unit ResizeForm;

// Handles resizing the application
// Different views depending on whether has landscape or portrait dimensions
// Landscape is standard view

interface
uses FMX.Types;

const
  DefaultWidth = 1024;
  MinWidth = 768;
  DefaultHeight= 768;
  MinHeight= 668;

procedure Landscape;
procedure Portrait;

procedure HomeTab(Mode : Integer);
procedure BookingsTab(Mode : Integer);
procedure ClientsTAb(Mode : Integer);
procedure CalendarTab(Mode : Integer);

implementation
uses Main;


// Vertical - Tablet Straight up
procedure Portrait;
var
  Min : Integer;
begin
  with Main.MainForm do
  begin
    // Width
    Min := MinWidth + 10;
    if MainForm.Width < Min then
    begin
      MainForm.Width := Min;
    end;

    // Height
    Min := MinHeight + 16;
    if MainForm.Height < Min then
    begin
      MainForm.Height := Min;
    end;
  end;

  HomeTab(1);
  BookingsTab(1);
  ClientsTab(1);
  CalendarTab(1);
end;


// Horizontal - Tablet on its side/normal PC view
procedure Landscape;
var
  Min : Integer;
begin
  with Main.MainForm do
  begin
    // Width
    Min := MinWidth + 10;
    if MainForm.Width < Min then
    begin
      MainForm.Width := Min;
    end;

    // Height
    Min := MinHeight + 16;
    if MainForm.Height < Min then
    begin
      MainForm.Height := Min;
    end;
  end;

  HomeTab(0);
  BookingsTab(0);
  ClientsTab(0);
  CalendarTab(0);
end;

// Mode 0 is Landscape, Mode 1 is Portrait
procedure HomeTab(Mode : Integer);
var
  Size : Integer;
begin
with MainForm do
begin
  // Portrait
  if Mode = 1 then
  begin
    HomeImage.Visible := False;
    layHomeRight.Width := MainForm.Width - 25;
  end
  else
  // Landscape
  begin
    HomeImage.Visible := True;
    layHomeRight.Width := Trunc(MainForm.Width - HomeImage.Width - 26);
  end;

  Size := MainForm.Height - 38 - 40 - 50 - 30 - 60;
  Size := Trunc(Size/3);
  rectRecentBookings.Height   := Size;
  rectRecentClients.Height    := Size;
  rectUpcomingDeposits.Height := Size;
end;
end;

// Mode 0 is Landscape, Mode 1 is Portrait
procedure BookingsTab(Mode : Integer);
var
  Size : Integer;
begin
with MainForm do
begin
  // Portrait
  if Mode = 1 then
  begin
    // Make Layout more Vertical
    layBookingsRentalLeft.Align := TAlignLayout.Top;
    layBookingsRentalRight.Align:= TAlignLayout.Bottom;
    layBookingsPaymentsLeft.Align := TAlignLayout.Top;
    layBookingsPaymentsRight.Align:= TAlignLayout.Bottom;

    // Across whole screen
    Size := MainForm.Width - 25;
    layBookings1.Width := Size;
    layBookingsRental.Width := Size;
    layBookingsPayment.Width := Size;
    layBookingsTravel.Width := Size;

    layBookings1Right.Width := 400;
    layBookings1Left.Width := Size - layBookings1Right.Width;

    layBookingsRentalLeft.Width := Size;
    layBookingsRentalRight.Width := Size;
    layBookingsPaymentsLeft.Width := Size;
    layBookingsPaymentsRight.Width := Size;

    // Half Screen Block
    Size := Trunc((Size - 10)/2);
    rectTravel.Width := Size;
    layBookingsBottomRight.Width := Size;

    // Bookings Top
    rectInv.Margins.Right := 0;
    rectBookingsClient.Width := LayBookings1Left.Width - 10 - RectInv.Width;
    rectBookingsClient.Margins.Left := 10;
    layBookingsStatus.Margins.Right := 0;
    layBookingsOutstanding.Margins.Right := 0;

    // Bookings Buttons
    Size := Trunc((layBookingsBottomRight.Width - 362)/2);
    layBookingsDates.Margins.Left   := Size;
    layBookingsDates.Margins.Right  := Size;
    layBookingsButtons.Margins.Left := Size;
    layBookingsButtons.Margins.Right:= Size;

    Size := 360;
    layBookingsDates.Width := Size;
    layBookingsButtons.Width := Size;

    Size := 5;
    bBookingsCalendar.Margins.Left := Size;
    bBookingsCalendar.Margins.Right := Size;
    bVoucher.Margins.Left:= Size;
    bVoucher.Margins.Right:= Size;
    eVoucherDate.Margins.Left := Size;
    eVoucherDate.Margins.Right:= Size;
    bInvoice.Margins.Left := Size;
    bInvoice.Margins.Right:= Size;
    eInvoiceDate.Margins.Left := Size;
    eInvoiceDate.Margins.Right:= Size;
    bBookingsSave.Margins.Left := Size;
    bBookingsSave.Margins.Right := Size;

    Size := 35;
    layBookingsSaveCB.Margins.Left := Size;
    layBookingsSaveCB.Margins.Right := Size;

    // Height
    Size := MainForm.Height - 146 - 241 - 10 - 46;
    Size := Trunc(Size/6);
    layBookingsRental.Height := 3*Size + 10;
    layBookingsPayment.Height := 3*Size + 10;
    layBookingsTravel.Height := 170;
    layBookingsRentalLeft.Height := 2*Size;
    layBookingsRentalRight.Height := Size;
    layBookingsPaymentsLeft.Height := 2*Size;
    layBookingsPaymentsRight.Height := Size;
  end
  else
  // Landscape
  begin
    // Make Layout more Horizontal
    layBookingsRentalLeft.Align := TAlignLayout.Left;
    layBookingsRentalRight.Align:= TAlignLayout.Right;
    layBookingsPaymentsLeft.Align := TAlignLayout.Left;
    layBookingsPaymentsRight.Align:= TAlignLayout.Right;

    // Across whole screen
    Size := MainForm.Width - 10;
    layBookings1.Width := Size;
    layBookingsRental.Width := Size;
    layBookingsPayment.Width := Size;
    layBookingsTravel.Width := Size;

    layBookings1Right.Width := 460;
    layBookings1Left.Width := Size - 60 - layBookings1Right.Width;

    // Half Screen block
    Size := Trunc((MainForm.Width-10)/2)-13;
    layBookingsRentalLeft.Width := Size;
    layBookingsRentalRight.Width := Size;
    layBookingsPaymentsLeft.Width := Size;
    layBookingsPaymentsRight.Width := Size;

    rectTravel.Width := Size;
    layBookingsBottomRight.Width := Size;

    // Bookings Top
    rectInv.Margins.Right := 20;
    rectBookingsClient.Width := layBookings1Left.Width - 20 - rectInv.Width;
    rectBookingsClient.Margins.Left := 20;
    layBookingsStatus.Margins.Right := 10;
    layBookingsOutstanding.Margins.Right := 80;

    // Bookings Buttons
    Size := Trunc((layBookingsBottomRight.Width - 442)/2);
    layBookingsDates.Margins.Left   := Size;
    layBookingsDates.Margins.Right  := Size;
    layBookingsButtons.Margins.Left := Size;
    layBookingsButtons.Margins.Right:= Size;

    Size := 221;
    layBookingsDates.Width   := Size;
    layBookingsButtons.Width := Size;

    Size := 15;
    bBookingsCalendar.Margins.Left := Size;
    bBookingsCalendar.Margins.Right := Size;
    bVoucher.Margins.Left:= Size;
    bVoucher.Margins.Right:= Size;
    eVoucherDate.Margins.Left := Size;
    eVoucherDate.Margins.Right:= Size;
    bInvoice.Margins.Left := Size;
    bInvoice.Margins.Right:= Size;
    eInvoiceDate.Margins.Left := Size;
    eInvoiceDate.Margins.Right:= Size;
    bBookingsSave.Margins.Left := Size;
    bBookingsSave.Margins.Right := Size;

    Size := 45;
    cbBookingsSave.Margins.Left := Size;
    cbBookingsSave.Margins.Right := Size;

    // Height
    Size := MainForm.Height - 146 - 241 - 10 - 46;
    Size := Trunc(Size/6);
    layBookingsRental.Height := 3*Size + 10;
    layBookingsPayment.Height := 3*Size + 10;
    layBookingsTravel.Height := 170;
    layBookingsRentalLeft.Height := 2*Size;
    layBookingsRentalRight.Height := Size;
    layBookingsPaymentsLeft.Height := 2*Size;
    layBookingsPaymentsRight.Height := Size;
  end;
end;
end;

// Mode 0 is Landscape, Mode 1 is Portrait
procedure ClientsTab(Mode : Integer);
var
  Size : Integer;
  Size2: Integer;
begin
with MainForm do
begin
  // Portrait
  if Mode = 1 then
  begin
    // Layout stuff
    // Make the layout more vertical
    layPeople.Align := TAlignLayout.Top;
    layClients1Right.Align := TAlignLayout.Top;
    layClients2.Align := TAlignLayout.Bottom;

    // Across whole screen
    Size := MainForm.Width - 25;
    layClients1.Width  := Size;
    layClientsBookings.Width := Size;
    layClients1Right.Width := Size;
    layPeople.Width := Size;

    // Address
    Size := Size - 10;
    layAddressTop.Width := Size;
    layAddressBottom.Width := Size;

    Size := Size - 30;
    Size2 := Trunc(Size*0.2);
    layPostal.Width := Size2;
    layProv.Width := Size2;
    layAddress.Width := Size - Size2;

    Size := Size - 30;
    layCity.Width := Trunc((Size-Size2)/2);
    layCountry.Width := layCity.Width;

    // Height
    Size := MainForm.Height - 38 - 40 - 50;
    layClients1.Height := 280;
    layClients1Right.Height := 280;
    layClients1.Margins.Bottom   := 10;
    layClients1Right.Margins.Top := 10;
    layClients2.Height := Size - layClients1.Height - layClients1Right.Height - 65 - 55;
  end
  else
  // Landscape
  begin
    // Layout stuff
    layClients1Right.Align := TAlignLayout.Right;
    layPeople.Align := TAlignLayout.Left;
    layClients1.Align := TAlignLayout.Top;

    // Across whole screen
    Size := MainForm.Width - 10;
    layClients1.Width  := Size;
    layClientsBookings.Width := Size - 16;

    // Half Screen block
    Size := Trunc((MainForm.Width-10)/2)-13;
    layClients1Right.Width := Size;
    layPeople.Width := Size;

    // Address
    Size := Size - 10;
    layAddressTop.Width := Size;
    layAddressBottom.Width := Size;

    Size := Size - 30;
    Size2:= Trunc(Size*0.2);
    layPostal.Width := Size2;
    layProv.Width := Size2;
    layAddress.Width := Size - Size2;

    Size := Size - 30;
    layCity.Width := Trunc((Size-Size2)/2);
    layCountry.Width := layCity.Width;

    // Height
    Size := MainForm.Height - 90 - 40 - 90;
    layClients1.Height := 280;
    layClients1Right.Height := 280;
    layClients1.Margins.Bottom   := 0;
    layClients1Right.Margins.Top := 0;
    layClients2.Height := Size - layClients1.Height - 25;
  end;
end;
end;

// Mode 0 is Landscape, Mode 1 is Portrait
procedure CalendarTab(Mode : Integer);
begin
with MainForm do
begin
  // Portrait
  if Mode = 1 then
  begin
    // Calendar
    layCalendarBar.Align  := TAlignLayout.Top;
    layCalendarBar.Height := 230;
    layCalendar.Align     := TAlignLayout.Left;
    layCalendar.Width     := 250;
    Planner.Margins.Right := 0;
    Planner.Margins.Top   := 230;
  end
  else
  // Landscape
  begin
    layCalendarBar.Align  := TAlignLayout.Right;
    layCalendarBar.Width  := 250;
    layCalendar.Align     := TAlignLayout.Top;
    layCalendar.Height    := 230;
    Planner.Margins.Right := 250;
    Planner.Margins.Top   := 0;
  end;
end;
end;

end.
