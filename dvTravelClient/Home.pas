unit Home;

// Handles anything in Home Tab

interface
uses ClientModuleUnit1, Misc,
     Data.FireDACJSONReflect, SysUtils, FMX.ListBox, UITypes;

const
  ItemHeight = 34;

procedure SetHomeTab;
procedure SetUpcomingDeposits(Limit : Integer);
procedure SetRecentBookings(Limit : Integer);
procedure SetRecentClients(Limit : Integer);

// Sets tab to corresponding item
procedure ClickBookingItem(Item : TListBoxItem);
procedure ClickClientItem(Item : TListBoxItem);

implementation
uses Main, DataController, BookingsTabController, BookingsTabView,
     ClientsTabController, ClientsTabView;

procedure SetHomeTab;
var
  Limit : Integer;
begin
  try
    if IsConnected then
    begin
      Limit := Trunc(MainForm.lbUpcomingDeposits.Height / ItemHeight);
      SetUpcomingDeposits(Limit);
      SetRecentBookings(Limit);
      SetRecentClients(Limit);
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

procedure SetUpcomingDeposits(Limit : Integer);
var
  LDataSetList : TFDJSONDataSets;
  Str : String;
  Item : TListBoxItem;
  DepositAmt : Integer;
  Paid : Integer;
begin
  // Clear Memtable
  Module.mtExtraTable.Close;
  // Get Data
  LDataSetList := ClientModule1.ServerMethods1Client.GetUpcomingDeposits(Limit);
  Module.mtExtraTable.AppendData(TFDJSONDataSetsReader.GetListValue(LDataSetList,0));
  Module.mtExtraTable.Open;
  // Clear View
  MainForm.lbUpcomingDeposits.Clear;
  // Set View
  with Module.mtExtraTable do
  begin
    First;
    while not EOF do
    begin
      DepositAmt := FieldByName('DepositAmt').AsInteger;
      Paid := FieldByName('AmtPaid').AsInteger;
      Str :=
      ' Due: ' + FieldByName('DepositDueDate').AsString +
      ' | Deposit Balance: $' + (DepositAmt - Paid).ToString + // Amount left owed
      ' | Total Charged: $' + FieldByName('Charges').AsString +
      ' | Paid: $' + Paid.ToString +
      ' | ' + FieldByName('Firstname').AsString +
      ' ' + FieldByName('Lastname').AsString;
      with MainForm.lbUpcomingDeposits do
      begin
        Item := TListBoxItem.Create(MainForm.lbUpcomingDeposits);
        Item.Text := FieldByName('BookingID').AsString;
        Item.ItemData.Detail := Str;
        Item.StyleLookup := 'NormalListBoxItem';
        AddObject(Item);
      end;

      Next;
    end;
  end;
end;

procedure SetRecentBookings(Limit : Integer);
var
  LDataSetList : TFDJSONDataSets;
  Str : String;
  Item : TListBoxItem;
  Charges : Integer;
  Paid : Integer;
begin
  // Clear Memtable
  Module.mtExtraTable.Close;
  // Get Data
  LDataSetList := ClientModule1.ServerMethods1Client.GetRecentBookings(Limit);
  Module.mtExtraTable.AppendData(TFDJSONDataSetsReader.GetListValue(LDataSetList,0));
  Module.mtExtraTable.Open;
  // Clear View
  MainForm.lbRecentBookings.Clear;
  // Set View
  with Module.mtExtraTable do
  begin
    First;
    while not EOF do
    begin
      Charges := FieldByName('Charges').AsInteger;
      Paid := FieldByName('AmtPaid').AsInteger;
      Str := '#' + FieldByName('BookingID').AsString +
    ' | ' + FieldByName('Status').AsString +
    ' | Charges : $' + Charges.ToString +
    ' | Paid : $' + Paid.ToString +
    ' | Outstanding: $' + (Charges-Paid).ToString +
    ' | ' + FieldByName('NameList').AsString;

      with MainForm.lbRecentBookings do
      begin
        Item := TListBoxItem.Create(MainForm.lbRecentBookings);
        Item.Text := FieldByName('BookingID').AsString;
        Item.ItemData.Detail := Str;
        Item.StyleLookup := 'NormalListBoxItem';
        AddObject(Item);
      end;

      Next;
    end;
  end;
end;

procedure SetRecentClients(Limit : Integer);
var
  LDataSetList : TFDJSONDataSets;
  Detail : String;
  CurrentString : String;
  Item : TListBoxItem;

begin
  // Clear Memtable
  Module.mtExtraTable.Close;
  // Get Data
  LDataSetList := ClientModule1.ServerMethods1Client.GetRecentClients(Limit);
  Module.mtExtraTable.AppendData(TFDJSONDataSetsReader.GetListValue(LDataSetList,0));
  Module.mtExtraTable.Open;
  // Why I have to have atleast one record for this one, I have no idea (Has something to do with group_concat??)
  if Module.mtExtraTable.FieldByName('ClientID').AsInteger = 0 then Exit;
  // Clear View
  MainForm.lbRecentClients.Clear;

  // Set View
  with Module.mtExtraTable do
  begin
    First;
    while not EOF do
    begin

      // Detail is 'Names | City, ProvState, Country'
      Detail := ifNull(FieldByName('City').AsString,'');

      CurrentString := ifNull(FieldByName('ProvState').AsString,'');
      if CurrentString <> '' then
      begin
        if Detail <> '' then Detail := Detail + ', ';
        Detail := Detail + CurrentString;
      end;
      CurrentString := ifNull(FieldByName('Country').AsString,'');
      if CurrentString <> '' then
      begin
        if Detail <> '' then Detail := Detail + ', ';
        Detail := Detail + CurrentString;
      end;

      if Detail <> '' then
        Detail := FieldByName('Namelist').AsString + ' | ' + Detail
      else
        Detail := FieldByName('Namelist').AsString;

      with MainForm.lbRecentClients do
      begin
        Item := TListBoxItem.Create(MainForm.lbRecentClients);
        Item.Text := FieldByName('ClientID').AsString;
        Item.ItemData.Detail := Detail;
        Item.StyleLookup := 'NormalListBoxItem';
        AddObject(Item);
      end;

      Next;
    end;
  end;
end;

// Sets booking tab to corresponding booking
procedure ClickBookingItem(Item : TListBoxItem);
begin
  try
    if IsConnected then
    begin
      BookingsTabController.SetEditBookingItem(BookingsTabController.GetBookingByID(StrToInt(Item.Text)));
      BookingsTabView.SwitchToBookings;
    end
    else
    begin
      Print('Cannot load when not connected to internet.');
    end;
  except
    on E : Exception do
    begin
      MainForm.circleOnlineStatus.Fill.Color := TAlphaColorRec.Red;
      Print('ERROR: ' + E.ClassName + sLineBreak + E.Message);
    end;
  end;
end;

// Sets clients tab to corresponding client
procedure ClickClientItem(Item : TListBoxItem);
begin
  try
    if IsConnected then
    begin
      ClientsTabController.SetClientsTab(StrToInt(Item.Text));
      ClientsTabView.SwitchToClients;
    end
    else
    begin
      Print('Cannot load when not connected to internet.');
    end;
  except
    on E : Exception do
    begin
      MainForm.circleOnlineStatus.Fill.Color := TAlphaColorRec.Red;
      Print('ERROR: ' + E.ClassName + sLineBreak + E.Message);
    end;
  end;
end;

end.
