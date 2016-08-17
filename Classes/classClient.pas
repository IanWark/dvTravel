unit classClient;
interface
uses classBooking, classPerson;

// CURRENTLY NOT USED - need to add destructor if used

type
  TClient = Class
    private
      cClientID : Integer;
      cDateEntered : TDateTime;
      cActive   : Integer;
      cAddress : String;
      cCity : String;
      cProvState : String;
      cCountry : String;
      cPostalZip : String;
      cNotes : String;
      People : Array of TPerson;
      Bookings: Array of TBooking;

    public
      property ClientID : Integer
        read cClientId write cClientId;
      property DateEntered : TDateTime
        read cDateEntered write cDateEntered;
      property Active : Integer
        read cActive write cActive;
      property Address : String
        read cAddress write cAddress;
      property City : String
        read cCity write cCity;
      property ProvState : String
        read cProvState write cProvState;
      property Country : String
        read cCountry write cCountry;
      property PostalZip : String
        read cPostalZip write cPostalZip;
      property Notes : String
        read cNotes write cNotes;
      constructor Create(nClientID : Integer;
                        nDateEntered : TDateTime;
                        nActive   : Integer;
                        nAddress : String;
                        nCity : String;
                        nProvState : String;
                        nCountry : String;
                        nPostalZip : String;
                        nNotes : String;
                        PersonSize : Integer;
                        BookingSize : Integer);
      procedure AddPerson(Person : TPerson; Index : Integer);
      function GetPeopleLength : Integer;
      function GetPerson(Index : Integer) : TPerson;
      procedure AddBooking(Booking : TBooking; Index : Integer);
      function GetBookingsLength : Integer;
      function GetBooking(Index : Integer) : TBooking;
  end;

implementation
uses SysUtils;

  constructor TClient.Create(nClientID: Integer; nDateEntered: TDateTime;
                            nActive: Integer; nAddress: string;
                            nCity: string; nProvState: string; nCountry: string;
                            nPostalZip: string; nNotes: string;
                            PersonSize: Integer; BookingSize: Integer);
  begin
    ClientId := nClientID;
    DateEntered := nDateEntered;
    Active := nActive;
    Address := nAddress;
    City := nCity;
    ProvState := nProvState;
    Country := nCountry;
    PostalZip := nPostalZip;
    Notes     := nNotes;
    SetLength(People, PersonSize);
    SetLength(Bookings,BookingSize);
  end;

  procedure TClient.AddPerson(Person : TPerson; Index : Integer );
  var
    E : EHeapException;
  begin
    // If Index is past length by 1, enlarge array by 1
    // Else if Index is past length by more than one, raise exception
    if Index > (Length(People)-1) then
    begin
      if Index = Length(People) then
      begin
        SetLength(People, Length(People) + 1);
      end
      else
      begin
        raise E.Create('ERROR: Adding into People array past its length');
      end;
    end;

    People[Index] := Person;
  end;

  function TClient.GetPeopleLength : Integer;
  begin
    Result := Length(People);
  end;

  function TClient.GetPerson(Index : Integer) : TPerson;
  begin
    Result := People[Index];
  end;

  procedure TClient.AddBooking(Booking : TBooking; Index : Integer );
  var
    E : EHeapException;
  begin
    // If Index is past length by 1, enlarge array by 1
    // Else if Index is past length by more than one, raise exception
    if Index > (Length(Bookings)-1) then
    begin
      if Index = Length(Bookings) then
      begin
        SetLength(Bookings, Length(Bookings) + 1);
      end
      else
      begin
        raise E.Create('ERROR: Adding into Bookings array past its length');
      end;
    end;

    Bookings[Index] := Booking;
  end;

  function TClient.GetBookingsLength : Integer;
  begin
    Result := Length(Bookings);
  end;

  function TClient.GetBooking(Index : Integer) : TBooking;
  begin
    Result := Bookings[Index];
  end;

end.
