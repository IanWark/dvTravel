unit classCalendarItem;

interface
uses SysUtils;

type
  TCalendarItem = class
    private
      cBookID : Integer;
      cRentID : Integer;
      cAccomID: Integer;
      cClientID: Integer;
      cStatus : String;
      cOutstanding : Double;
      cStartDate  : TDateTime;
      cEndDate    : TDateTime;
      cAccomName: String;
      cFirstName: String;
      cLastName : String;
      cOccupants : Integer;
      cTravelInfo : String;

    public
      property BookID : Integer
        read cBookID write cBookID;
      property RentID : Integer
        read cRentID write cRentID;
      property AccomID : Integer
        read cAccomID write cAccomID;
      property ClientID : Integer
        read cClientID write cClientID;
      property Status : String
        read cStatus write cStatus;
      property Outstanding : Double
        read cOutstanding write cOutstanding;
      property StartDate : TDateTime
        read cStartDate write cStartDate;
      property EndDate : TDateTime
        read cEndDate write cEndDate;
      property AccomName : String
        read cAccomName write cAccomName;
      property FirstName : String
        read cFirstName write cFirstName;
      property LastName : String
        read cLastName write cLastName;
      property Occupants : Integer
        read cOccupants write cOccupants;
      property TravelInfo : String
        read cTravelInfo write cTravelInfo;

      constructor Create(nBookID : Integer; nRentID : Integer; nAccomID: Integer;
                          nClientID: Integer; nStatus: string; nOutstanding : Double;
                          nStartDate: TDateTime; nEndDate: TDateTime; nAccomName: string;
                          nFirstName: string; nLastName: String; nOccupants : Integer;
                          nTravelInfo : String);
      function ToString : String;

  end;
implementation

  constructor TCalendarItem.Create(nBookID: Integer; nRentID: Integer; nAccomID: Integer;
                          nClientID: Integer; nStatus: string; nOutstanding : Double;
                          nStartDate: TDateTime; nEndDate: TDateTime; nAccomName: string;
                          nFirstName: string; nLastName: String; nOccupants : Integer;
                          nTravelInfo : String);
  begin
    BookID := nBookID;
    RentID := nRentID;
    AccomID := nAccomID;
    ClientID:= nClientID;
    Status := nStatus;
    Outstanding := nOutstanding;
    StartDate := nStartDate;
    EndDate   := nEndDate;
    AccomName := nAccomName;
    FirstName := nFirstName;
    LastName  := nLastName;
    Occupants := nOccupants;
    TravelInfo := nTravelInfo;
  end;

  function TCalendarItem.ToString : String;
  begin
    Result := 'Occupants: '+ Occupants.ToString + sLineBreak +
    TravelInfo + sLineBreak +
    FirstName + ' ' + LastName;
  end;
end.
