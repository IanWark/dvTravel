unit RentalView;

// Controls view of Rental section of Bookings Tab

interface
uses classAccom, classRental, classResultsArray, Misc,
     FMX.ListBox, System.SysUtils, System.UITypes, DateUtils;

const
  AddRental : String = 'Add Accomodation';
  EditRental : String = 'Edit Accomodation';

var
  AddRentalTotalBeingChanged : Boolean = False;
  RentID : Integer;

// When Rentals change, change the total amount on the BookingsTab
// also, set deposit amount to half total
procedure CalculateRentalsTotal;

// Manipulate lbRental
procedure AddRentalToListBox(Rental : TRental);
procedure EditRentalListBox(Rental : TRental);
procedure UpdateRentalIDs(ResultsArray : TResultsArray);

// Set panelAddRental
procedure SetEditRentalItem(const Item: TListBoxItem);
procedure SetAddNewRental;

// User Options for panelAddRental

procedure ChargesChange; // When Charges change, change rate
procedure RateChange;  // When rate changes, change Charges
procedure DiscountChange; // Calls TotalCalculate
procedure AutomaticDiscounts; // if Month between June and October, 7th night is free
procedure TotalCalculate; // Sets Total

procedure AddRentalCancel;
procedure AddRentalSave;
procedure AddRentalAll(Rental : TRental);
procedure AddRentalDelete;

implementation
uses Main, RentalController, BookingsTabView;

// RENTAL
// When Rentals change, change the total amount on the BookingsTab
// also, set deposit amount to half total
procedure CalculateRentalsTotal;
var
  Total : Double;
  Rental : TRental;
  I: Integer;
begin
  Total := 0;
  for I := 0 to MainForm.lbRental.Count-1 do
  begin
    Rental := MainForm.lbRental.ListItems[I].Data as TRental;
    Total := Total + (Rental.Charges - Rental.DiscountAmt);
  end;
  MainForm.lRentalTotalData.Text := Total.ToString;
  MainForm.eDeposit.Value := Trunc(Total/2);
  BookingsTabView.CalculateOutstanding;
end;

// Manipulate lbRental

procedure AddRentalToListBox(Rental : TRental);
var
  Item : TListBoxItem;
begin
  Item := TListBoxItem.Create(MainForm.lbRental);
  Item.Text := Rental.RentID.ToString;
  Item.Data := Rental;
  Item.ItemData.Detail := Rental.ToString;
  Item.StyleLookup := 'NormalListBoxItem';
  MainForm.lbRental.AddObject(Item);
  CalculateRentalsTotal;
end;

procedure EditRentalListBox(Rental : TRental);
var
  I : Integer;
begin
  with MainForm.lbRental do
  begin
    I := Items.IndexOf(Rental.RentID.ToString);
    ListItems[I].ItemData.Detail := Rental.ToString;
    ListItems[I].Data := Rental;
  end;
  CalculateRentalsTotal;
end;

procedure UpdateRentalIDs(ResultsArray : TResultsArray);
var
  I : Integer;
  J : Integer;
  Rental : TRental;
begin
  with MainForm.lbRental do
  begin
    for I := 0 to ResultsArray.GetLen do
    begin
      J := Items.IndexOf(ResultsArray.GetID(I).OldID.ToString);
      while J <> -1 do
      begin
        Rental := ListItems[J].Data as TRental;
        Rental.RentID := ResultsArray.GetID(I).NewID;
        ListItems[J].Data := Rental;
        ListItems[J].Text := Rental.RentID.ToString;
        ListItems[J].ItemData.Detail := Rental.ToString;
        J := Items.IndexOf(ResultsArray.GetID(I).OldID.ToString);
      end;
    end;
  end;
end;


// Set panelAddRental
procedure SetEditRentalItem(const Item: TListBoxItem);
var
  Rental : TRental;
begin
  try
    // Need to be connected to server to check for availabilty
    if IsConnected then
    begin
      with MainForm do
      begin
        AddRentalTotalBeingChanged := True;

        layAddRentalError.Visible := False;
        bAddRentalDelete.Visible := True;

        lAddRental.Text := EditRental;
        Rental := Item.Data as TRental;
        RentID := Rental.RentID;
        eAddRentalOccupants.Value := Rental.Occupants;

        // If more than one accom assume that it is the 2,3,4,5,6 one
        if Rental.GetAccomsLength > 1 then eAddRentalCasa.ItemIndex := 0 else
        eAddRentalCasa.ItemIndex := IfNull(eAddRentalCasa.Items.IndexOf(Rental.GetAccom(0).AccomName),-1);

        eAddRentalRate.Value := Rental.Rate;
        eAddRentalFrom.Date := Rental.StartDate;
        eAddRentalTo.Date := Rental.EndDate;
        eAddRentalCharges.Value := Rental.Charges;
        eDiscountDesc.Text := Rental.DiscountDesc;
        eDiscountAmt.Value := Rental.DiscountAmt;
        eAddRentalComment.Text := Rental.Comment;

        AddRentalTotalBeingChanged := False;
        OpenPanel(panelAddRental);
      end;
    end
    else
    begin
      Print('Cannot connect to the server.');
    end;
  except
    // Exception occured
    on E : Exception do
    begin
      MainForm.circleOnlineStatus.Fill.Color := TAlphaColorRec.Red;
      Print('ERROR: ' + E.ClassName + sLineBreak + E.Message);
    end;
  end;
end;

procedure SetAddNewRental;
begin
  try
    // Need to be connected to server to check for availabilty
    if IsConnected then
    begin
      with MainForm do
      begin
        layAddRentalError.Visible := False;
        bAddRentalDelete.Visible := False;

        lAddRental.Text := AddRental;
        RentID := -lbRental.Count-1;
        eAddRentalOccupants.Value := 0;
        eAddRentalCasa.ItemIndex := -1;
        eAddRentalRate.Value := 0;
        eAddRentalFrom.Date := date;
        eAddRentalTo.Date := date;
        eAddRentalCharges.Value := 0;
        eDiscountDesc.Text := '';
        eAddRentalComment.Text := '';
        OpenPanel(panelAddRental);
      end;
    end
    else
    begin
      Print('Cannot connect to the server.');
    end;
  except
    // Exception occured
    on E : Exception do
    begin
      MainForm.circleOnlineStatus.Fill.Color := TAlphaColorRec.Red;
      Print('ERROR: ' + E.ClassName + sLineBreak + E.Message);
    end;
  end;
end;

// User Options for panelAddRental

// When Charges change, change rate
procedure ChargesChange;
begin
with MainForm do
begin
  if not AddRentalTotalBeingChanged then
  begin
    AddRentalTotalBeingChanged := True;
    MainForm.eAddRentalRate.Value := eAddRentalCharges.Value / DaysBetween(eAddRentalTo.Date,eAddRentalFrom.Date);
    AddRentalTotalBeingChanged := False;
  end;
end;
  TotalCalculate;
end;

// When rate changes, change Charges
procedure RateChange;
begin
with MainForm do
begin
  if not AddRentalTotalBeingChanged then
  begin
    AddRentalTotalBeingChanged := True;
    eAddRentalCharges.Value := DaysBetween(eAddRentalTo.Date,eAddRentalFrom.Date)*eAddRentalRate.Value;
    AddRentalTotalBeingChanged := False;
  end;
end;
  AutomaticDiscounts;
  TotalCalculate;
end;

// Calls TotalCalculate
procedure DiscountChange;
begin
  TotalCalculate;
end;

procedure AutomaticDiscounts;
var
  Year, Month, Day : Word;
  DiscountApplies : Boolean;
  Days : Integer;
begin
with MainForm do
begin
  if not AddRentalTotalBeingChanged then
  begin
    DiscountApplies := False;
    // 7th night free between June and October
    DecodeDate(eAddRentalFrom.Date, Year, Month, Day);
    if (Month >= 6) AND (Month <=10) then
      DiscountApplies := True
    else
    begin
      DecodeDate(eAddRentalTo.Date, Year, Month, Day);
      if (Month >= 6) AND (Month <=10) then
        DiscountApplies := True;
    end;
    if DiscountApplies then
    begin
      Days := Trunc(DaysBetween(eAddRentalTo.Date,eAddRentalFrom.Date)/7);
      eDiscountAmt.Value := Days * eAddRentalRate.Value;
      if eDiscountAmt.Value > 0 then eDiscountDesc.Text := '7th Night Free!'
      else eDiscountDesc.Text := '';
    end
    else
    begin
      eDiscountDesc.Text := '';
      eDiscountAmt.Value := 0;
    end;
  end;
end;
end;

// Sets Total
procedure TotalCalculate;
begin
with MainForm do
begin
  eAddRentalTotal.Text := (eAddRentalCharges.Value - eDiscountAmt.Value).ToString;
end;
end;

procedure AddRentalCancel;
begin
with MainForm do
begin
  ClosePanel(PanelAddRental);
end;
end;

procedure AddRentalSave;
var
  Rental : TRental;
  Available : Boolean;
  Error : Boolean;
begin
with MainForm do
begin
  // If there is a problem with the data highlight it and stop
  Error := False;
  lAddRentalCasa.FontColor := TAlphaColorRec.Black;
  lAddRentalDates.FontColor := TAlphaColorRec.Black;
  layAddRentalError.Visible := False;

  if eAddRentalCasa.ItemIndex < 0 then
  begin
    lAddRentalCasa.FontColor := TAlphaColorRec.Red;
    Error := True;
  end;
  if eAddRentalFrom.Date >= eAddRentalTo.Date then
  begin
    lAddRentalDates.FontColor := TAlphaColorRec.Red;
    Error := True;
  end;

  // If no errors go ahead and add
  if Error = False then
  begin
    try
      // Only save if connected because requires checking availability
      if IsConnected then
      begin
        Rental := TRental.Create(RentID,
                                 StrToInt(lInvNumData.Text),
                                 eAddRentalFrom.Date,
                                 eAddRentalTo.Date,
                                 trunc(eAddRentalOccupants.Value),
                                 eAddRentalCharges.Value,
                                 eAddRentalRate.Value,
                                 eDiscountDesc.Text,
                                 eDiscountAmt.Value,
                                 eAddRentalComment.Text);
        Rental.ClearAccoms;
        Rental.AddAccom(eAddRentalCasa.Selected.Data as TAccom);

        // If AccomID = 1 try to add casas 2,3,4,5,6
        if Rental.GetAccom(0).AccomID = 1 then
        begin
          AddRentalAll(Rental);
        end
        else
        // Just adds the one casa
        begin
          // Checks if casa is available at that time
          Available := RentalController.CheckRentalAvailable
            (Rental.GetAccom(0).AccomID,eAddRentalFrom.Date, eAddRentalTo.Date, Rental.RentID);

          if not Available then
          begin
            lAddRentalError.Text := 'That room is already booked at that time.';
            layAddRentalError.Visible := True;
          end
          else
          begin
            if lAddRental.Text = EditRental then
            begin
              RentalController.EditRental(Rental);
              EditRentalListBox(Rental);
            end
            else
            begin
              RentalController.AddRental(Rental);
              AddRentalToListBox(Rental);
            end;

            ClosePanel(PanelAddRental);

            // Set Bookings tab to changed
            cbBookingsSave.IsChecked := False;

            BookingsTabView.SaveBooking;
          end;
        end;
      end
      // If not connected...
      else
      begin
        Print('Cannot connect to server.');
      end;

    except
      on E : Exception do
      begin
        MainForm.circleOnlineStatus.Fill.Color := TAlphaColorRec.Red;
        Print('ERROR: ' + E.ClassName + sLineBreak + E.Message);
      end;
    end;
  end;
end;
end;

procedure AddRentalAll(Rental : TRental);
var
  Available : Boolean;
begin
  Rental.AddAccom(TAccom.Create(2,'Casa 2',2));
  Rental.AddAccom(TAccom.Create(3,'Casa 3',3));
  Rental.AddAccom(TAccom.Create(4,'Casa 4',4));
  Rental.AddAccom(TAccom.Create(5,'Casa 5',5));
  Rental.AddAccom(TAccom.Create(6,'Casa 6',6));

  Available := RentalController.CheckAllAvailable(Rental.StartDate,
                   Rental.EndDate, Rental.RentID);
  if not Available then
  begin
    MainForm.lAddRentalError.Text := 'There is a room conflict.';
    MainForm.layAddRentalError.Visible := True;
  end
  else
  begin
    if MainForm.lAddRental.Text = EditRental then
    begin
      RentalController.EditRental(Rental);
      EditRentalListBox(Rental);
    end
    else
    begin
      RentalController.AddRental(Rental);
      AddRentalToListBox(Rental);
    end;
    MainForm.ClosePanel(MainForm.PanelAddRental);

    // Set Bookings tab to changed
    MainForm.cbBookingsSave.IsChecked := False;

    // Push changes to database
    BookingsTabView.SaveBooking;
  end;
end;

procedure AddRentalDelete;
begin
  RentalController.DeleteRental(RentID);
  MainForm.DeleteFromListBox(MainForm.lbRental, RentID);
  CalculateRentalsTotal;
  with MainForm do
  begin
    ClosePanel(PanelAddRental);
    cbBookingsSave.isChecked := False;

    // Push changes to database
    BookingsTabView.SaveBooking;
  end;
end;

end.
