unit RentalController;

// Controls the data of the Rental (or Accomodation) section of the Bookings tab
// mtAccom, mtRental, mtRentAccom
// mtRentAccom is a link between a rental and what accomodation it uses

interface
  uses classRental, classAccom, ClientModuleUnit1, Misc,
  Data.FireDACJSONReflect, System.SysUtils;

// Gets list of available casas and sets them to be available when adding a rental
procedure SetAccomTable;
function  GetAccomByID(AccomID : Integer) : TAccom;
procedure SetRentals(BookID : Integer);

// Returns true if Accom is already occupied between Start and End Date,
// and occupier is not RentID object
function CheckRentalAvailable(AccomID : Integer;
         StartDate : TDateTime; EndDate : TDateTime; RentID : Integer) : Boolean;
function CheckAllAvailable(StartDate : TDateTime; EndDate : TDateTime; RentID : Integer) : Boolean;

procedure RentalFields(Rental : TRental);
procedure AddRental(Rental : TRental);
procedure EditRentAccom(Rental : TRental);
procedure EditRental(Rental : TRental);
procedure DeleteRental(RentID : Integer);

implementation
uses Main, DataController, RentalView;

// Gets list of available casas and sets them to be available when adding a rental
procedure SetAccomTable;
var
  LDataSetList : TFDJSONDataSets;
  Accom : TAccom;
begin
  // Get Data
  LDataSetList := ClientModule1.ServerMethods1Client.GetAccoms;
  Module.mtAccom.AppendData(TFDJSONDataSetsReader.GetListValue(LDataSetList,0));
  Module.mtAccom.Open;
  // Set View
  with Main.MainForm do
  begin
    eAddRentalCasa.Clear;
    Module.mtAccom.First;
    while not Module.mtAccom.Eof do
    begin
      Accom := TAccom.Create(Module.mtAccom.Fields.FieldByName('AccomID').Value,
                             Module.mtAccom.Fields.FieldByName('AccomName').Value,
                             Module.mtAccom.Fields.FieldByName('SubID').Value);
      eAddRentalCasa.Items.AddObject(Accom.AccomName,
                                     Accom);
      Module.mtAccom.Next;
    end;
  end;
end;

// Gets a TAccom from mtAccom by its AccomID
function GetAccomByID(AccomID : Integer) : TAccom;
var
  I : Integer;
begin
  Result := TAccom.Create(-1,'Null',-1);
  with Module.mtAccom do
  begin
    First;
    for I := 0 to Table.Rows.Count do
    begin
      if Fields.FieldByName('AccomID').Value = AccomID then
      begin
        Result := TAccom.Create(AccomID,
                                Fields.FieldByName('AccomName').Value,
                                Fields.FieldByName('SubID').Value
                                );
        Break;
      end;
      Next;
    end;
  end;
end;

procedure SetRentals(BookID : Integer);
var
  LDataSetList : TFDJSONDataSets;
  IDList : String;
  Rental : TRental;
  Accom  : TAccom;
begin
  // mtRental
  LDataSetList := ClientModule1.ServerMethods1Client.GetRentals(BookID);
  Module.mtRental.AppendData(TFDJSONDataSetsReader.GetListValue(LDataSetList,0));
  Module.mtRental.Open;
  // Generate IDList for GetRentAccoms
  with Module.mtRental do
  begin
    IDList := '(';
    First;
    IDList := IDList + FieldByName('RentID').AsString;
    Next;
    while not EOF do
    begin
      IDList := IDList + ',' + FieldByName('RentID').AsString;
      Next;
    end;
    IDList := IDList + ')';
  end;
  // mtRentAccom
  LDataSetList := ClientModule1.ServerMethods1Client.GetRentAccoms(IDList);
  if LDataSetList <> nil then
  begin
    Module.mtRentAccom.AppendData(TFDJSONDataSetsReader.GetListValue(LDataSetList,0));
    Module.mtRentAccom.Open;
  end;
  // For each rental add it to listbox
  with Module.mtRental do
  begin
    First;
    while not EOF do
    begin
      Rental := TRental.Create(Fields.FieldByName('RentID').Value,
                               Fields.FieldByName('BookID').Value,
                               Fields.FieldByName('StartDate').Value,
                               Fields.FieldByName('EndDate').Value,
                               ifNull(Fields.FieldByName('Occupants').Value,0),
                               ifNull(Fields.FieldByName('Charges').Value,0),
                               ifNull(Fields.FieldByName('Rate').Value,0),
                               ifNull(Fields.FieldByName('DiscountDesc').Value,''),
                               ifNull(Fields.FieldByName('DiscountAmt').Value,0),
                               ifNull(Fields.FieldByName('Comment').Value,'')
                               );
      // RentAccom
      with Module.mtRentAccom do
      begin
        First;
        while not EOF do
        begin
          if Fields.FieldByName('RentID').Value = Rental.RentID then
          begin
            Accom := GetAccomByID(Fields.FieldByName('AccomID').Value);
            Rental.AddAccom(Accom);
          end;
          Next;
        end;
      end;
      RentalView.AddRentalToListBox(Rental);
      Next;
    end;
  end;
  RentalView.CalculateRentalsTotal;
end;

// Returns true if Accom is already occupied between Start and End Date,
// and occupier is not RentID object
function CheckRentalAvailable(AccomID : Integer;
         StartDate : TDateTime; EndDate : TDateTime; RentID : Integer) : Boolean;
var
  I : Integer;
  Rental : TRental;
begin
  Result := True;
  // Check for conflicts with the client side rental
  with Module.mtRentAccom do
  begin
    First;
    while not EOF do
    begin
      if (FieldByName('AccomID').AsInteger = AccomID) AND (FieldByName('RentID').AsInteger <> RentID) then
      begin
        I := MainForm.lbRental.Items.IndexOf(FieldByName('RentID').AsString);
        Rental := MainForm.lbRental.ListItems[I].Data as TRental;
        if (StartDate < rental.EndDate) AND (EndDate > rental.StartDate) then
        begin
          Result := False;
          Break;
        end;
      end;
      Next;
    end;
  end;

  // If no conflicts with the client side rentals, check the database
  if Result = True then
  begin
    Result := ClientModule1.ServerMethods1Client.CheckRentalAvailable
          (AccomID, StartDate, EndDate, RentID);
  end;
end;

// Actually doesn't check all - just all but 7
function CheckAllAvailable(StartDate : TDateTime; EndDate : TDateTime; RentID : Integer) : Boolean;
var
  I : Integer;
  Rental : TRental;
  AccomIDs : Set of 2..11;
begin
  Result := True;
  AccomIDs := [2..6,8..11];
  // Check for conflicts with the client side rental
  with Module.mtRentAccom do
  begin
    First;
    while not EOF do
    begin
      if ((FieldByName('AccomID').AsInteger) in AccomIDs) AND (FieldByName('RentID').AsInteger <> RentID) then
      begin
        I := MainForm.lbRental.Items.IndexOf(FieldByName('RentID').AsString);
        Rental := MainForm.lbRental.ListItems[I].Data as TRental;
        if (StartDate < rental.EndDate) AND (EndDate > rental.StartDate) then
        begin
          Result := False;
          Break;
        end;
      end;
      Next;
    end;
  end;

    // If no conflicts with the client side rentals, check the database
  if Result = True then
  begin
    Result := ClientModule1.ServerMethods1Client.CheckAllAvailable
          (StartDate, EndDate, RentID);
  end;
end;

// Sets fields of the current entry in mtRental according to the TRental
// Used in AddRental and EditRental
procedure RentalFields(Rental : TRental);
begin
  with Module.mtRental do
  begin
    Fields.FieldByName('RentID').Value  := Rental.RentID;
    Fields.FieldByName('BookID').Value  := Rental.BookID;
    Fields.FieldByName('StartDate').Value  := Rental.StartDate;
    Fields.FieldByName('EndDate').Value  := Rental.EndDate;
    Fields.FieldByName('Occupants').Value  := Rental.Occupants;
    Fields.FieldByName('Charges').Value  := Rental.Charges;
    Fields.FieldByName('Rate').Value  := Rental.Rate;
    Fields.FieldByName('DiscountDesc').Value := Rental.DiscountDesc;
    Fields.FieldByName('DiscountAmt').Value := Rental.DiscountAmt;
    Fields.FieldByName('Comment').AsString  := Rental.Comment;
  end;
end;

procedure AddRental(Rental : TRental);
var
  I: Integer;
begin
  with Module.mtRental do begin
    Open;
    Append;
    RentalFields(Rental);

    // RentAccom
    if Rental.GetAccomsLength > 0 then
    begin
      with Module.mtRentAccom do begin
        Open;
        for I := 0 to Rental.GetAccomsLength-1 do
        begin
          Append;
          Fields.FieldByName('RentID').Value := Rental.RentID;
          Fields.FieldByName('AccomID').Value:= Rental.GetAccom(I).AccomID;
        end;
        Post;
      end;
    end;
    Post;
  end;

end;

// Called in EditRental
procedure EditRentAccom(Rental : TRental);
var
  I : Integer;
begin
  // Delete and replace RentAccoms
  I := 0;
  with Module.mtRentAccom do
  begin
    First;
    while not EOF do
    begin
      if Fields.FieldByName('RentID').Value = Rental.RentID then
      begin
        // If there are still items to add, replace
        if Rental.GetAccomsLength > I then
        begin
          Edit;
          Fields.FieldByName('AccomID').Value := Rental.GetAccom(I).AccomID;
          I := I + 1;
        end
        else
        // If not still items to add, delete
        begin
          Delete;
        end;

          // If still items to add, add
        if Rental.GetAccomsLength > I then
        begin
          Append;
          Fields.FieldByName('RentID').Value := Rental.RentID;
          Fields.FieldByName('AccomID').Value:= Rental.GetAccom(I).AccomID;
        end;
      end;
      Next;
    end;
  end;
end;

procedure EditRental(Rental : TRental);
begin
  with Module.mtRental do begin
    if not Active then Open;
    First;
    while not EOF do
    begin
      if Fields.FieldByName('RentID').Value = Rental.RentID then
      begin
        Edit;
        RentalFields(Rental);
        Post;

        EditRentAccom(Rental);

        Break;
      end
      else
      begin
        Next;
      end;
    end;
  end;
  RentalView.EditRentalListBox(Rental);
end;

procedure DeleteRental(RentID : Integer);
begin
  // Rental
  with Module.mtRental do
  begin
    if Locate('RentID',RentID) then
      Delete
    else
      MainForm.Print('ERROR: could not find payment object in mtPayment to delete');
  end;
  // RentAccom
  with Module.mtRentAccom do
  begin
    while Locate('RentID',RentID) do
      Delete;
  end;
end;

end.
