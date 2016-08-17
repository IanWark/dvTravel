unit classContact;

interface

type
  TContact = class
    private
      cID: Integer;
      cPerson : Integer;
      cContactType : String;
      cPhone: String;
      cEmail: String;
    public
      property ID : Integer
        read cID write cID;
      property PersonID : Integer
        read cPerson write cPerson;
      property ContactType : String
        read cContactType write cContactType;
      property Phone : String
        read cPhone write cPhone;
      property Email : String
        read cEmail write cEmail;
      constructor Create(nID : Integer; nPerson : Integer; nType : String; nPhone : String; nEmail : String);
      function ToString : String;
    end;

implementation
uses SysUtils;

  constructor TContact.Create(nID : Integer; nPerson : Integer; nType : String; nPhone : String; nEmail : String);
  begin
    ID := nID;
    PersonID := nPerson;
    ContactType := nType;

    if nPhone = '0' then
    begin
      nPhone := '';
    end;

    Phone := nPhone;
    Email := nEmail;
  end;

  function TContact.ToString;
  var
    Empty : Boolean;
  begin
    Result := '';
    Empty := True;
    if ContactType <> '' then
    begin
      Result := Result + ContactType;
      Empty := False;
    end;
    if Phone <> '' then
    begin
      if Empty = False then
      begin
        Result := Result + ' | ';
      end;
      Result := Result + Phone;
      Empty := False;
    end;
    if Email <> '' then
    begin
      if Empty = False then
      begin
        Result := Result + ' | ';
      end;
      Result := Result + Email;
      Empty := False;
    end;
  end;

end.
