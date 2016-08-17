unit SelectPeople;

// Allows association of specific people in client to a booking

interface
uses BookingsTabView, DataController, ClientModuleUnit1,
     FireDac.Comp.Client, Data.FireDACJSONReflect, FMX.ListBox, SysUtils, UITypes;

var
  OldItemIndex : Integer;

// Should only be called when for sure Client is same as the bookings Client
procedure SetBookingPerson(BookingID : Integer; PersonID : Integer);

// Should only be called when for sure Client is same as the bookings Client
// (i.e. after just opening new booking from that person)
procedure SetMainPerson(PersonID : Integer);

function GetClientNames : String;
procedure OpenPanel;
procedure PopulateListBox(MemTable : TFDMemTable);
procedure PreparePanel;
procedure CancelChanges;
procedure SaveChanges;

implementation
uses Main;

// BookingID is ID of booking, PersonID is ID of main person of booking
// Should only be called when for sure Client is same as the bookings Client
procedure SetBookingPerson(BookingID : Integer; PersonID : Integer);
var
  LDataSetList : TFDJSONDataSets;
begin
  // Get Data
  LDataSetList := ClientModule1.ServerMethods1Client.GetBookingPerson(BookingID);
  Module.mtBookingPerson.AppendData(TFDJSONDataSetsReader.GetListValue(LDataSetList,0));
  Module.mtBookingPerson.Open;

  SetMainPerson(PersonID);
end;

// PersonID is ID of main person of booking
// Should only be called when for sure Client is same as the bookings Client
// (i.e. after just opening new booking from that person)
procedure SetMainPerson(PersonID : Integer);
var
  Detail : String;
  I : Integer;
  MainPersonInList : Boolean;
begin
  with MainForm do
  begin
    // Add people to MainPerson list
    cbMainPerson.Clear;
    with Module.mtPerson do
    begin
      First;
      while not EOF do
      begin
        Detail := FieldByName('FirstName').AsString + ' ' + FieldByName('LastName').AsString;
        cbMainPerson.Items.AddObject(Detail, TObject(FieldByName('PersonID').AsInteger));
        Next;
      end;
    end;
    // Set current MainPerson
    I := cbMainPerson.Items.IndexOfObject(TObject(PersonID));
    if (I = -1) and (cbMainPerson.Count > 0) then I := 0;
    cbMainPerson.ItemIndex := I;
    // If MainPerson not in mtBookingsPerson then add them
    MainPersonInList := False;
    with Module.mtBookingPerson do
    begin
      First;
      while not EOF do
      begin
        if FieldByName('PersonID').AsInteger = PersonID then
        begin
          MainPersonInList := True;
        end;
        Next;
      end;
      if not MainPersonInList then
      begin
        Append;
        FieldByName('PersonID').AsInteger := PersonID;
        FieldByName('BookingID').AsInteger := StrToInt(lInvNumData.Text);
      end;
    end;
  end;
end;

function GetClientNames : String;
var
  I: Integer;
  SelectedPeople : Array of Integer;
  PersonID : Integer;
  ResEmpty : Boolean;
begin
  // Get list of people who are selected
  SetLength(SelectedPeople,0);
  with Module.mtBookingPerson do
  begin
    if not Active then Open;
    First;
    I := 0;
    while not EOF do
    begin
      SetLength(SelectedPeople,Length(SelectedPeople)+1);
      SelectedPeople[I] := FieldByName('PersonID').Value;
      I := I + 1;
      Next;
    end;
  end;

  Result := '';
  ResEmpty := True;
  if Module.mtBookingPerson.Table.Rows.Count > 0 then
  begin
    Module.mtPerson.First;
    while not Module.mtPerson.EOF do
    begin
      PersonID := Module.mtPerson.FieldByName('PersonID').AsInteger;
      for I := 0 to Length(SelectedPeople)-1 do
      begin
        if PersonID = SelectedPeople[I] then
        begin
          if ResEmpty then
          begin
            Result := Result +
            Module.mtPerson.Fields.FieldByName('FirstName').Value + ' ' +
            Module.mtPerson.Fields.FieldByName('LastName').Value + ' ';
            ResEmpty := False;
          end
          else
          begin
            Result := Result + '+ ' +
            Module.mtPerson.Fields.FieldByName('FirstName').Value + ' ' +
            Module.mtPerson.Fields.FieldByName('LastName').Value + ' ';
          end;
          Break;
        end;
      end;
      Module.mtPerson.Next;
    end;
  end;
end;

procedure OpenPanel;
begin
  with MainForm do
  begin
    OpenPanel(panelSelectPeople);
    if (cbMainPerson.Count > 0) then OldItemIndex := cbMainPerson.Selected.Index;
  end;
  PreparePanel;
end;

procedure PopulateListBox(MemTable : TFDMemTable);
var
  Item: TListBoxItem;
  SelectedPeople : Array of Integer;
  I : Integer;
  PersonID : Integer;
begin

  // Get list of people who are selected
  with Module.mtBookingPerson do
  begin
    SetLength(SelectedPeople,0);
    if not Active then Open;
    First;
    I := 0;
    while not EOF do
    begin
      SetLength(SelectedPeople,Length(SelectedPeople)+1);
      SelectedPeople[I] := FieldByName('PersonID').Value;
      I := I + 1;
      Next;
    end;
  end;
  // Populate list with people
  with MemTable do
  begin
    if not Active then Open;
    First;
    while not EOF do
    begin
      Item := TListBoxItem.Create(MainForm.lbSelectPeople);
      Item.StyleLookup := 'CheckBoxItem';
      Item.Text := FieldByName('PersonID').AsString;
      Item.ItemData.Detail := FieldByName('FirstName').AsString + ' ' + FieldByName('LastName').AsString;
      PersonID := FieldByName('PersonID').AsInteger;
      for I := 0 to Length(SelectedPeople)-1 do
      begin
        if PersonID = SelectedPeople[I] then
        begin
          Item.IsChecked := True;
          Break;
        end;
      end;
      MainForm.lbSelectPeople.AddObject(Item);
      Next;
    end;
  end;
end;

// MainPerson should be unable to be unchecked and setting MainPerson should check that person
procedure PreparePanel;
var
  LDataSetList : TFDJSONDataSets;
begin
  MainForm.lMainPerson.FontColor := TAlphaColorRec.Black;

  MainForm.lbSelectPeople.Clear;

  // if current Client is client of booking, get people from mtPerson
  if BookingsTabView.ClientID = Module.mtClient.FieldByName('ClientID').Value then
  begin
    PopulateListBox(Module.mtPerson);
  end
  else
  // Else get person list from online
  begin
    Module.mtExtraTable.Close;
    LDataSetList := ClientModule1.ServerMethods1Client.GetPeople(BookingsTabView.ClientID);
    Module.mtExtraTable.AppendData(TFDJSONDataSetsReader.GetListValue(LDataSetList,0));
    Module.mtExtraTable.Open;
    PopulateListBox(Module.mtExtraTable);
  end;
end;

procedure CancelChanges;
begin
  with MainForm do
  begin
    cbMainPerson.ItemIndex := OldItemIndex;
    ClosePanel(panelSelectPeople);
  end;
end;

procedure SaveChanges;
var
  Num : Integer;
  I: Integer;

begin
  // If main person is empty you can't save
  if (MainForm.cbMainPerson.Count <= 0) then
  begin
    MainForm.lMainPerson.FontColor := TAlphaColorRec.Red;
    Exit;
  end;
  MainForm.lMainPerson.FontColor := TAlphaColorRec.Black;

  // Ensure MainPerson is included in active people
  with MainForm do
  begin
    I := Integer(cbMainPerson.ListItems[cbMainPerson.ItemIndex].Data);
    I := lbSelectPeople.Items.IndexOf(I.ToString);
    lbSelectPeople.ListItems[I].IsChecked := True;
  end;

  // Delete all
  with Module.mtBookingPerson do
  begin
    First;
    while not EOF do
    begin
      Delete;
      Next;
    end;
  end;

  Module.mtBookingPerson.Open;
  with MainForm.lbSelectPeople do
  begin
    Num := Count;
    if Num > 0 then
    begin
      for I := 0 to Num-1 do
      begin
        if ListItems[I].IsChecked = True then
        begin
          with Module.mtBookingPerson do
          begin
            Append;
            FieldByName('BookingID').Value := Module.mtBooking.FieldByName('BookingID').Value;
            FieldByName('PersonID').Value := StrToInt(ListItems[I].Text);
          end;
        end;
      end;
    end;
  end;
  with MainForm do
  begin
    lBookingsClient.Text := GetClientNames;
    cbBookingsSave.IsChecked := False;
    ClosePanel(panelSelectPeople);

    // Push changes to database
    BookingsTabView.SaveBooking;
  end;
end;

end.
