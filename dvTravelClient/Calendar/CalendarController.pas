unit CalendarController;

// Controls the data and interactions of the calendar tab (mtCalendar)
// Possibly just merge with CalendarView, since really two of the functions have to do with the view

interface
uses classCalendarItem, classBooking, classEmailUser, Misc, ClientModuleUnit1,
     Data.FireDACJSONReflect, SysUtils, FMX.Graphics, Classes,
     JSON, Rest.Json;

procedure ItemClick(BookID : Integer);
procedure UpdateCalendar(StartDate : TDateTime; EndDate : TDateTime);

// Sends image of calendar to email in eCalendarExport
// Idea is that the employees and other people at Casa Dulce Vida print it out
// and have a schedule of visitors
procedure EmailBitmap(Image : TBitmap; Email : String; EmailUser : TEmailUser; Body : String);

implementation
uses DataController, CalendarView, BookingsTabController, BookingsTabView;

procedure ItemClick(BookID : Integer);
var
  Booking : TBooking;
begin
  Booking := BookingsTabController.GetBookingByID(BookID);
  BookingsTabView.SwitchToBookings;
  BookingsTabController.SetEditBookingItem(Booking);
end;

procedure UpdateCalendar(StartDate : TDateTime; EndDate : TDateTime);
var
  LDataSetList : TFDJSONDataSets;
  CalendarItem : TCalendarItem;
  ItemStart: TDateTime;
  ItemEnd  : TDateTime;
begin
  // Clear memtable
  Module.mtCalendar.Close;
  Module.mtCalendar.Open;
  CalendarView.Clear;

  LDataSetList := ClientModule1.ServerMethods1Client.Calendar(StartDate, EndDate);
  Module.mtCalendar.AppendData(TFDJSONDataSetsReader.GetListValue(LDataSetList,0));

  with Module.mtCalendar do
  begin
    First;
    while not EOF do
    begin
      ItemStart := FieldByName('StartDate').AsDateTime;
      ReplaceTime(ItemStart, EncodeTime(13,1,0,0));

      ItemEnd   := FieldByName('EndDate').AsDateTime;
      ReplaceTime(ItemEnd, EncodeTime(12,59,0,0));

      CalendarItem := TCalendarItem.Create(FieldByName('BookID').Value,
                                           FieldByName('RentID').Value,
                                           FieldByName('AccomID').Value,
                                           IfNull(FieldByName('ClientID').Value,0),
                                           FieldByName('Status').Value,
                                           IfNull(FieldByName('Outstanding').Value,0),
                                           ItemStart,
                                           ItemEnd,
                                           FieldByName('AccomName').Value,
                                           IfNull(FieldByName('FirstName').Value,''),
                                           IfNull(FieldByName('LastName').Value,''),
                                           IfNull(FieldByName('Occupants').Value,0),
                                           IfNull(FieldByName('TravelInfo').Value,''));
      CalendarView.AddItemToCalendar(CalendarItem);
      Next;
    end;
  end;
end;

// Sends image of calendar to email in eCalendarExport
// Idea is that the employees and other people at Casa Dulce Vida print it out
// and have a schedule of visitors
procedure EmailBitmap(Image : TBitmap; Email : String; EmailUser : TEmailUser; Body : String);
var
  Success : Boolean;
  Stream : TMemoryStream;
begin
  Success := False;
  if IsConnected then
  begin
    try
      Stream := TMemoryStream.Create;
      Image.SaveToStream(Stream);

      Success := ClientModule1.ServerMethods1Client.EmailBitmap(Stream, Email, EmailUser, Body );
    finally
      if not Success then Print('Error sending calendar.');
      if Success then Print('Email Sent!');

      Image.Free;
    end;
  end
  else
  begin
    Print('Cannot connect to the server.');
  end;
end;


end.


