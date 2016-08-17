unit CalendarView;

// Controls view of Calendar tab

interface
uses classCalendarItem, classRental, classEmailUser, Misc,
     SysUtils, System.UITypes, FMX.TMSPlannerData, DateUtils, FMX.Graphics;

procedure Clear;
// Change calendar date and set calendar view accordingly
procedure CalendarChange(nDate : TDate);
procedure AfterSelect;

// Set Item's casa and thus colors
procedure SetItemResource(Item : TTMSFMXPlannerItem; AccomID : Integer);
// To make the casas with studio/bedroom difference seem like one thing, add item to bedroom slot
function AddBedroomSlot(CalendarItem : TCalendarItem; AccomID : Integer) : TTMSFMXPlannerItem;
procedure AddItemToCalendar(CalendarItem : TCalendarItem);
procedure SwitchToCalendar;
procedure BookingsCalendarClick;

// Gets image of calendar and sends to email in eCalendarExport
// Idea is that the employees and other people at Casa Dulce Vida print it out
// and have a schedule of visitors
procedure ExportCalendar;

const
  // TAlphaColorRec codes
  // Title colors are actually not used as title color is replaced by color based on booking status
  // (Red for quote, blue for booking)
  // But if things change title colors match item colors
  TitleColors: Array of Integer = [$FFDB7093, // Palevioletred
                                   $FF3CB371, // Mediumseagreen
                                   $FFFFFFFF, // Grey - just to take up space
                                   $FFFA8072, // Salmon
                                   $FF4169E1, // Royalblue
                                   $FFFFFFFF, // Grey - just to take up space
                                   $FFCD853F, // Peru
                                   $FFFFA500, // Orange
                                   $FF00CED1] // Darkturquoise
                                   ;
  ItemColors : Array of Integer = [$FFFFB6C1, // Lightpink
                                   $FF90EE90, // Lightgreen
                                   $FF000000, // White - just to take up space
                                   $FFFFA07A, // Lightsalmon
                                   $FF87CEFA, // LightSkyblue
                                   $FF000000, // White - just to take up space
                                   $FFF5DEB3, // Wheat
                                   $FFFAFAD2, // Lightgoldenrodyellow
                                   $FF7FFFD4] // Aquamarine
                                   ;
  TitleFontColor= $FFFFFFFF; // White
  TextFontColor = $FF000000; // Black

implementation
uses Main, CalendarController;

procedure Clear;
begin
  MainForm.Planner.Items.Clear;
end;

// Change calendar date and set calendar view accordingly
procedure CalendarChange(nDate : TDate);
begin
  ReplaceTime(TDateTime(nDate), EncodeTime(0,0,0,0));
  with MainForm do
  begin
    Planner.BeginUpdate;
    Planner.ModeSettings.StartTime := IncDay(nDate,-7);
    Planner.TimeLine.ViewStart := IncDay(nDate,-3);
    Planner.ModeSettings.EndTime := IncDay(nDate,14);
    try
      if IsConnected then
      begin
        CalendarController.UpdateCalendar(Planner.ModeSettings.StartTime, Planner.ModeSettings.EndTime);
      end;
    except
      on E : Exception do
      begin
        MainForm.circleOnlineStatus.Fill.Color := TAlphaColorRec.Red;
        Print('ERROR: ' + E.ClassName + sLineBreak + E.Message);
      end;
    end;
    Planner.EndUpdate;
  end;
end;

procedure AfterSelect;
begin
  MainForm.Planner.SelectItem(-1);
end;

// Set Item's casa and thus colors
procedure SetItemResource(Item : TTMSFMXPlannerItem; AccomID : Integer);
begin
  // If above 1, due to casas 3 & 5 taking up extra slots slot must be changed
       if AccomID in [2..3] then AccomID := AccomID - 2  // Casas 2/3
  else if AccomID in [4..5] then AccomID := AccomID - 1  // Casas 4/5
  else if AccomID in [6..7] then AccomID := AccomID      // Casas 6/7
  else if AccomID in [8..9] then AccomID := AccomID - 7  // Casa 3 studio/bedroom
  else if AccomID in[10..11]then AccomID := AccomID - 6  // Casa 5 studio/bedroom
  else AccomID := 8;                                     // Misc


  Item.Resource := AccomID;

  // If bedroom resource doesn't align with its colouring
  if (AccomID = 2) or (AccomID = 5) then AccomID := AccomID - 1;

  Item.TitleColor := TitleColors[AccomID];
  Item.Color := ItemColors[AccomID];
end;

// To make the casas with studio/bedroom difference seem like one thing, add item to bedroom slot
function AddBedroomSlot(CalendarItem : TCalendarItem; AccomID : Integer) : TTMSFMXPlannerItem;
begin
       if AccomID = 3 then AccomID := 1
  else if AccomID = 5 then AccomID := 4;

  Result := MainForm.Planner.AddItem(CalendarItem.StartDate,CalendarItem.EndDate);
  Result.Color := ItemColors[AccomID];
  Result.Title := ' ';
  Result.DataObject := CalendarItem;
  Result.Resource := AccomID + 1;

  if CalendarItem.Status = 'Quote'     then Result.TitleColor := TAlphaColorRec.DarkRed
  else
  if CalendarItem.Status = 'Booking'   then Result.TitleColor := TAlphaColorRec.Navy
  else
  if CalendarItem.Status = 'Cancelled' then Result.TitleColor := TAlphaColorRec.Black
  else Result.TitleColor := TitleColors[AccomID];
end;

procedure AddItemToCalendar(CalendarItem : TCalendarItem);
var
  Item : TTMSFMXPlannerItem;
begin
  Item := MainForm.Planner.AddItem(CalendarItem.StartDate,CalendarItem.EndDate);
  Item.Title := '$' + CalendarItem.Outstanding.ToString;
  Item.TitleFontColor := TitleFontColor;
  Item.Text := CalendarItem.ToString;
  Item.FontColor := TextFontColor;
  Item.DataObject := CalendarItem;


  SetItemResource(Item,CalendarItem.AccomID);

  // Casas 3 and 5 take up two spots
  if CalendarItem.AccomID = 3 then
  begin
    AddBedroomSlot(CalendarItem, 3);
  end
  else
  if CalendarItem.AccomID = 5 then
  begin
    AddBedroomSlot(CalendarItem, 5);
  end;

  if CalendarItem.Status = 'Quote'     then Item.TitleColor := TAlphaColorRec.DarkRed
  else
  if CalendarItem.Status = 'Booking'   then Item.TitleColor := TAlphaColorRec.Navy
  else
  if CalendarItem.Status = 'Cancelled' then Item.TitleColor := TAlphaColorRec.Black;

end;

procedure SwitchToCalendar;
begin
  MainForm.TabControl1.ActiveTab := MainForm.TabControl1.Tabs[3];
end;

procedure BookingsCalendarClick;
var
  Rental : TRental;
begin
  if MainForm.lbRental.Count > 0 then
  begin
    Rental := MainForm.lbRental.ListItems[0].Data as TRental;
    MainForm.Calendar.Date := Rental.StartDate;
    CalendarChange(Rental.StartDate);
    SwitchToCalendar;
  end;
end;

// Gets image of calendar and sends to email in eCalendarExport
// Idea is that the employees and other people at Casa Dulce Vida print it out
// and have a schedule of visitors
procedure ExportCalendar;
var
  EmailUser : TEmailUser;
begin
with MainForm do
begin
  EmailUser := TEmailUser.Create(Misc.EmailAddress, eEmailname.Text);
  CalendarController.EmailBitmap(Planner.MakeScreenshot, eCalendarEmail.Text, EmailUser, eCalendarMessage.Text);
end;
end;

end.
