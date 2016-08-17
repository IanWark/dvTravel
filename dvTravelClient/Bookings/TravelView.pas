unit TravelView;

// Controls view of Travel section of Bookings Tab

interface
uses classTravel, classResultsArray,
     FMX.ListBox, System.SysUtils, System.UITypes;

const
  AddTravel : String = 'Add Travel';
  EditTravel : String = 'Edit Travel';

var
  TravelID : Integer;

function RoundToQuarterHour(ParamTime : TTime) : TTime;
// Manipulate lbTravel
procedure AddTravelToListBox(Travel : TTravel);
procedure EditTravelListBox(Travel : TTravel);
procedure UpdateTravelIDs(ResultsArray : TResultsArray);
// Set panelAddTravel
procedure SetEditTravelItem(const Item: TListBoxItem);
procedure SetAddNewTravel;
// User Options for panelAddTravel
procedure AddTravelMethodChange;
procedure AddTravelCancel;
procedure AddTravelSave;
procedure AddTravelDelete;

implementation
uses Main, TravelController, BookingsTabView;

function RoundToQuarterHour(ParamTime : TTime) : TTime;
var
  Hours, Minutes, Seconds, Milliseconds, Diff : Word;
begin
  // Round time to nearest 15 minutes
  DecodeTime(ParamTime, Hours, Minutes, Seconds, Milliseconds);
  Diff := Minutes mod 15;
  Minutes := Minutes - Diff;
  if Diff > 6 then Minutes := Minutes + 15;
  if Minutes >= 60 then
  begin
    Minutes := 0;
    Hours := Hours + 1;
  end;
  Result :=  EncodeTime(Hours, Minutes, Seconds, Milliseconds);
end;

// Manipulate lbTravel
procedure AddTravelToListBox(Travel : TTravel);
var
  ListBoxItem : TListBoxItem;
begin
  ListBoxItem := TListBoxItem.Create(MainForm.lbTravel);
  ListBoxItem.Text := Travel.ID.ToString;
  ListBoxItem.Data := Travel;
  ListBoxItem.ItemData.Detail := Travel.ToString;
  ListBoxItem.StyleLookup := 'NormalListBoxItem';
  MainForm.lbTravel.AddObject(ListBoxItem);
end;

procedure EditTravelListBox(Travel : TTravel);
var
  I : Integer;
begin
  with MainForm.lbTravel do
  begin
    I := Items.IndexOf(Travel.ID.ToString);
    ListItems[I].ItemData.Detail := Travel.ToString;
    ListItems[I].Data := Travel;
  end;
end;

procedure UpdateTravelIDs(ResultsArray : TResultsArray);
var
  I : Integer;
  J : Integer;
  Travel : TTravel;
begin
  with MainForm.lbTravel do
  begin
    for I := 0 to ResultsArray.GetLen do
    begin
      J := Items.IndexOf(ResultsArray.GetID(I).OldID.ToString);
      while J <> -1 do
      begin
        Travel := ListItems[J].Data as TTravel;
        Travel.ID := ResultsArray.GetID(I).NewID;
        ListItems[J].Data := Travel;
        ListItems[J].Text := Travel.ID.ToString;
        ListItems[J].ItemData.Detail := Travel.ToString;
        J := Items.IndexOf(ResultsArray.GetID(I).OldID.ToString);
      end;
    end;
  end;
end;

// Set panelAddTravel

procedure SetEditTravelItem(const Item: TListBoxItem);
var
  Travel : TTravel;
begin
with MainForm do
begin
  bAddTravelDelete.Visible := True;

  lAddTravel.Text  := EditTravel;
  Travel := Item.Data as TTravel;
  TravelID := Travel.ID;
  eAddTravelMethod.ItemIndex := eAddTravelMethod.Items.IndexOf(Travel.Method);
  eAddTravelFlight.Text := Travel.Info;
  eAddTravelDate.Date   := Travel.Date;
  eAddTravelTime.Time   := Travel.Date;
  eAddTravelNotes.Text  := Travel.Notes;
  // Method can be custom set
  if eAddTravelMethod.Items.IndexOf(Travel.Method) <> -1 then
  begin
    eAddTravelMethod.ItemIndex := eAddTravelMethod.Items.IndexOf(Travel.Method);
  end
  else
  begin
    eAddTravelMethod.ItemIndex := eAddTravelMethod.Items.IndexOf('Other');
    eAddTravelOtherDesc.Text   := Travel.Method;
  end;

  OpenPanel(panelAddTravel);
end;
end;

procedure SetAddNewTravel;
var
  TravelTime : TTime;
begin
with MainForm do
  begin
    bAddTravelDelete.Visible := False;

    lAddTravel.Text := AddTravel;
    TravelID := lbTravel.Count-1;
    eAddTravelMethod.ItemIndex := -1;
    eAddTravelFlight.Text := '';
    eAddTravelDate.Date := TravelController.FirstRentalStartDate;
    eAddTravelOtherDesc.Text := '';

    // Round time to nearest 15 minutes
    TravelTime := RoundToQuarterHour(time);
    eAddTravelTime.Time := TravelTime;
    eAddTravelNotes.Text := '';
    OpenPanel(panelAddTravel);
  end;
end;

// User options for panelAddTravel

// When method changes, different boxes appear
procedure AddTravelMethodChange;
var
  Selected : String;
begin
  with MainForm do
  begin
    layAddTravelFlight.Visible := False;
    layAddTravelOtherDesc.Visible := False;
    if eAddTravelMethod.ItemIndex > -1 then
    begin
      Selected := eAddTravelMethod.Selected.Text;
      if Selected = 'Air' then
      begin
        layAddTravelFlight.Visible := True;
      end
      else
      if Selected = 'Other' then
      begin
        layAddTravelOtherDesc.Visible := True;
      end;
      lAddTravelMethod.FontColor := TAlphaColorRec.Black;
    end;
  end;
end;

procedure AddTravelCancel;
begin
with MainForm do
begin
  ClosePanel(panelAddTravel);
end;
end;

procedure AddTravelSave;
var
  Travel: TTravel;
  DateTime : TDateTime;
  Method : String;
  Info : String;
  Error : Boolean;
begin
with MainForm do
begin
  Error := False;
  lAddTravelMethod.FontColor := TAlphaColorRec.Black;

  if eAddTravelMethod.ItemIndex = -1 then
  begin
    Error := True;
    lAddTravelMethod.FontColor := TAlphaColorRec.Red;
  end
  else
  if eAddTravelMethod.ItemIndex = eAddTravelMethod.Items.IndexOf('Air') then
  begin
    Method := eAddTravelMethod.Selected.Text;
    Info := eAddTravelFlight.Text;
  end
  else
  if eAddTravelMethod.ItemIndex = eAddTravelMethod.Items.IndexOf('Car') then
  begin
    Method := eAddTravelMethod.Selected.Text;
    Info := '';
  end
  else
  if eAddTravelMethod.ItemIndex = eAddTravelMethod.Items.IndexOf('Bus') then
  begin
    Method := eAddTravelMethod.Selected.Text;
    Info := '';
  end;
  if eAddTravelMethod.ItemIndex = eAddTravelMethod.Items.IndexOf('Other') then
  begin
    Method := eAddTravelOtherDesc.Text;
    Info := '';
  end;


  if Error = False then
  begin
    DateTime := trunc(eAddTravelDate.Date) + eAddTravelTime.Time;
    Travel := TTravel.Create(TravelID,
                            StrToInt(lInvNumData.Text),
                            Method,
                            Info,
                            DateTime,
                            eAddTravelNotes.Text);
    if lAddTravel.Text = AddTravel then
    begin
      TravelController.AddTravel(Travel);
      AddTravelToListBox(Travel);
    end
    else if lAddTravel.Text = EditTravel then
    begin
      TravelController.EditTravel(Travel);
      EditTravelListBox(Travel);
    end;

    ClosePanel(panelAddTravel);
    /// Set Bookings tab to changed
    cbBookingsSave.IsChecked := False;

    // Push changes to database
    BookingsTabView.SaveBooking;
  end;
end;
end;

procedure AddTravelDelete;
begin
  TravelController.DeleteTravel(TravelID);
  MainForm.DeleteFromListBox(MainForm.lbTravel, TravelID);
  with MainForm do
  begin
    ClosePanel(PanelAddTravel);
    cbBookingsSave.isChecked := False;

    // Push changes to database
    BookingsTabView.SaveBooking;
  end;
end;

end.
