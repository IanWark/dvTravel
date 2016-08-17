unit TravelController;

// Controls the data of the Travel section of the Bookings tab
// mtTravel

interface
uses classTravel, ClientModuleUnit1, Misc,
  Data.FireDACJSONReflect, System.SysUtils;

procedure SetTravel(BookID : Integer);

function FirstRentalStartDate : TDate;
procedure TravelFields(Travel : TTravel);
procedure AddTravel(Travel : TTravel);
procedure EditTravel(Travel : TTravel);
procedure DeleteTravel(TravelID : Integer);

implementation
uses DataController, TravelView;

procedure SetTravel(BookID : Integer);
var
  LDataSetList : TFDJSONDataSets;
  Travel : TTravel;
begin
  LDataSetList := ClientModule1.ServerMethods1Client.GetTravel(BookID);
  Module.mtTravel.AppendData(TFDJSONDataSetsReader.GetListValue(LDataSetList,0));
  Module.mtTravel.Open;
  with Module.mtTravel do
  begin
    First;
    while not EOF do
    begin
      Travel := TTravel.Create(Fields.FieldByName('TravelID').Value,
                               Fields.FieldByName('BookID').Value,
                               IfNull(Fields.FieldByName('TravelMethod').Value,'Other'),
                               IfNull(Fields.FieldByName('TravelInfo').Value,''),
                               IfNull(Fields.FieldByName('ArrivalDate').Value,0),
                               IfNull(Fields.FieldByName('TravelNote').Value,'')
                               );
      TravelView.AddTravelToListBox(Travel);
      Next;
    end;
  end;
end;

// Used in bTravelViewAddNew
function FirstRentalStartDate : TDate;
begin
  with Module.mtRental do
  begin
    First;
    if not EOF then
    begin
      Result := FieldByName('StartDate').AsDateTime;
    end
    else
    begin
      Result := Date;
    end;
  end;
end;

// Sets fields of the current entry in mtTravel according to the TTravel
// Used in AddToTravel and EditTravel
procedure TravelFields(Travel : TTravel);
begin
  with Module.mtTravel do begin
    Fields.FieldByName('TravelID').Value := Travel.ID;
    Fields.FieldByName('BookID').Value := Travel.BookID;
    Fields.FieldByName('TravelMethod').Value := Travel.Method;
    Fields.FieldByName('TravelInfo').Value := Travel.Info;
    Fields.FieldByName('ArrivalDate').Value := Travel.Date;
    Fields.FieldByName('TravelNote').Value := Travel.Notes;
  end;
end;

procedure AddTravel(Travel : TTravel);
begin
  Module.mtTravel.Open;
  Module.mtTravel.Append;
  TravelFields(Travel);
  Module.mtTravel.Post;
end;

procedure EditTravel(Travel : TTravel);
begin
  with Module.mtTravel do begin
    if not Active then Open;
    First;
    while not EOF do
    begin
      if Fields.FieldByName('TravelID').Value = Travel.ID then
      begin
        Edit;
        TravelFields(Travel);
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

procedure DeleteTravel(TravelID : Integer);
begin
  with Module.mtTravel do begin
    if Locate('TravelID',TravelID) then
      Delete
    else
      Print('ERROR: could not find travel object im mtTravel to delete');
  end;
end;

end.
