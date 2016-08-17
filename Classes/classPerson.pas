unit classPerson;

interface
uses classContact, System.Classes;

type
  TPerson = class
    private
      cID    : Integer;
      cClient: Integer;
      cFirst : String;
      cLast  : String;
      cNotes : String;
      Contacts : TList;
    public
      property PersonID    : Integer
        read cID write cID;
      property Client: Integer
        read cClient write cClient;
      property First : String
        read cFirst write cFirst;
      property Last  : String
        read cLast write cLast;
      property Notes  : String
        read cNotes write cNotes;
      constructor Create(nPersonID : Integer; nClient : Integer; nLast : String; nFirst: String; nNotes : String);
      destructor Destroy;
      procedure Add(Contact : TContact);
      function GetLength : Integer;
      function GetContact(Index : Integer) : TContact;
      function ToString : String;
  end;
implementation
uses SysUtils;

constructor TPerson.Create(nPersonID : Integer; nClient : Integer; nLast : String; nFirst : String; nNotes : String);
begin
  PersonID := nPersonID;
  Client:= nClient;
  Last  := nLast;
  First := nFirst;
  Notes := nNotes;

  Contacts := TList.Create;
end;

destructor TPerson.Destroy;
var
  I : Integer;
begin
  for I := 0 to Contacts.Count-1 do
  begin
    TContact(Contacts[I]).Free;
  end;
  Contacts.Free;

  inherited;
end;

function TPerson.ToString : String;
begin
  Result := First + ' ' + Last;
  if Notes <> '' then
  begin
    Result := Result + ' - ' + Notes;
  end;
end;

procedure TPerson.Add(Contact: TContact);
begin
  Contacts.Add(Contact);
end;

function TPerson.GetLength : Integer;
begin
  Result := Contacts.Count;
end;

function TPerson.GetContact(Index: Integer) : TContact;
begin
  Result := Contacts[Index];
end;
end.
