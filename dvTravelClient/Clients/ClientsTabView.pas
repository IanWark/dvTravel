unit ClientsTabView;

// Controls the view of the clients tab
// Sub Units are PersonView, BookingView

interface
uses
  classPerson, classBooking, classResultsArray,
  FMX.ListBox, System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants, DateUtils, StrUtils;

  // Set current tab to clients tab
  procedure SwitchToClients;
  procedure ClearClientsTabView;

  // Updates old negative temporary IDs of client sub-objects (person, contact, booking)
  // with new ones once client has been properly added to the database
  procedure UpdateClientIDs(ResultsArray : TResultsArray);

  procedure SetAddNewClient;
  procedure SetTabSaved;
  procedure ClientSave;

implementation
uses Main, DataController, ClientsTabController, BookingView;

// Set current tab to clients tab
procedure SwitchToClients;
begin
  MainForm.TabControl1.ActiveTab := MainForm.TabControl1.Tabs[1];
end;

procedure ClearClientsTabView;
begin
  MainForm.lbPeople.Clear;
  MainForm.lbClientsBookings.Clear;
end;

// Updates old negative temporary IDs of client sub-objects (person, contact, booking)
// with new ones once client has been properly added to the database
procedure UpdateClientIDs(ResultsArray : TResultsArray);
var
  I : Integer;
  J : Integer;
  Person : TPerson;
  Booking: TBooking;
begin
  with MainForm.lbPeople do
  begin
    // For each record...
    for I := 0 to Count-1 do
    begin
      // Change ClientID
      if ListItems[I].Data.ToString = 'TPerson' then
      begin
        Person := ListItems[I].Data as TPerson;
        // For each changed ID...
        for J := 0 to ResultsArray.GetLen-1 do
        begin
          // Replace old client IDs with new client IDs
          if Person.Client = ResultsArray.GetID(I).OldID then
          begin
            Person.Client := ResultsArray.GetID(I).NewID;
            ListItems[I].Data := Person;
            Break;
          end;
        end;
      end
      else
      if ListItems[I].Data.ToString = 'TContact' then
      begin
        // Do nothing
      end;
    end;
  end;
  with MainForm.lbClientsBookings do
  begin
    // For each record...
    for I := 0 to Count-1 do
    begin
      Booking := ListItems[I].Data as TBooking;
      // For each changed ID...
      for J := 0 to ResultsArray.GetLen-1 do
      begin
        // Replace old client IDs with new client IDs
        if Booking.ClientId = ResultsArray.GetID(I).OldID then
        begin
          Booking.ClientID := ResultsArray.GetID(I).NewID;
          ListItems[I].Data := Booking;
          Break;
        end;
      end;
    end;
  end;
end;

procedure SetAddNewClient;
begin
  ClientsTabController.ClearClients;
  ClientsTabController.AddNewClient;

  with MainForm do
  begin
    rectNoClientSet.Visible := False;
    lNoClientSet.Visible := False;

    eAddress.Text := '';
    ePostal.Text  := '';
    eCity.Text    := '';
    eProv.Text    := '';
    eCountry.Text := '';
    eClientNotes.Text := '';
    eDateEntered.Date := Date;
    cbClientActive.IsChecked := True;
    cbClientsSave.IsChecked := False;
  end;
  BookingView.BookingsOutstandingCalculate;
end;

procedure SetTabSaved;
begin
  MainForm.cbClientsSave.IsChecked := True;
end;

procedure ClientSave;
begin
  // If anything on the client page changed
  if MainForm.cbClientsSave.IsChecked = False then
  begin
    // If the actual parts of the client record changed
    if ClientsTabController.ClientChanged then
    begin
      with Module.mtClient do
      begin
        if not Active then Open;
        First;
        Edit;
        Fields.FieldByName('DateEntered').Value := MainForm.eDateEntered.Date;
        // If active not checked set as inactive
        if not MainForm.cbClientActive.IsChecked then
        begin
          Fields.FieldByName('Active').Value := 0;
        end
        else
        begin
          Fields.FieldByName('Active').Value := 1;
        end;
        Fields.FieldByName('Address').Value := MainForm.eAddress.Text;
        Fields.FieldByName('City').Value := MainForm.eCity.Text;
        Fields.FieldByName('ProvState').Value := MainForm.eProv.Text;
        Fields.FieldByName('Country').Value := MainForm.eCountry.Text;
        Fields.FieldByName('PostalZip').Value := MainForm.ePostal.Text;
        Fields.FieldByName('Notes').Value := MainForm.eClientNotes.Text;
        Fields.FieldByName('Modified').Value := Now;
        Post;
      end;
      ClientsTabController.ClientChanged := False;
    end;
    ClientsTabController.SaveClient;
  end;
end;

end.
