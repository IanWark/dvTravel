unit classTravel;

interface
type
  TTravel = class
    private
      cID     : Integer;
      cBookID : Integer;
      cMethod : String;
      cInfo : String;
      cDate   : TDateTime;
      cNotes  : String;
    public
      property ID : Integer
        read cID write cID;
      property BookID : Integer
        read cBookID write cBookID;
      property Method : String
        read cMethod write cMethod;
      property Info : String
        read cInfo write cInfo;
      property Date : TDateTime
        read cDate write cDate;
      property Notes : String
        read cNotes write cNotes;
      constructor Create(nID: Integer; nBookID : integer; nMethod: string;
                          nInfo: string; nDate: TDate; nNotes: string);
      function ToString : String;
  end;

implementation
uses SysUtils;
  constructor TTravel.Create(nID: Integer; nBookID : integer; nMethod: string;
                             nInfo: string; nDate: TDate; nNotes: string);
  begin
    ID     := nID;
    BookID := nBookID;
    Method := nMethod;
    Info   := nInfo;
    Date   := nDate;
    Notes  := nNotes;
  end;

  function TTravel.ToString : String;
  begin
    if Method = 'Air' then
    begin
      Result := Info;
    end
    else
    begin
      Result := Method;
    end;

    if Date <> 0 then
    begin
      Result := Result + ' - ' + DateToStr(Date) + ' @ ' + TimeToStr(Date);
    end;

    if Notes <> '' then
    begin
      Result := Result + ' - ' + Notes;
    end;
  end;

end.
