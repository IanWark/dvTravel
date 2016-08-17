unit PersonController;

// Secret mind control project
// Controls the data of the People section of the Clients tab (mtPerson + mtContact)

interface
uses classPerson, classContact, ClientModuleUnit1, Misc,
     Data.FireDACJSONReflect, SysUtils;

// Add and Edit People and Contacts
procedure SetPeople(ClientID : Integer);
procedure PersonFields(Person : TPerson);
procedure ContactFields(Contact : TContact; PersonID : Integer);
procedure AddPerson(Person : TPerson; Contacts : Array of TContact);
procedure EditPerson(Person: TPerson; Contacts : Array of TContact);
procedure DeletePerson(PersonID : Integer);

implementation
uses DataController, PersonView;

procedure SetPeople(ClientID : Integer);
var
  LDataSetList : TFDJSONDataSets;
  Person : TPerson;
  Contact : TContact;
  I : Integer;
  J : Integer;
begin
  // Clear memtables
  Module.mtPerson.Close;
  Module.mtContact.Close;

  // Get data
  // mtPerson
  LDataSetList := ClientModule1.ServerMethods1Client.GetPeople(ClientID);
  Module.mtPerson.AppendData(TFDJSONDataSetsReader.GetListValue(LDataSetList,0));
  Module.mtPerson.Open;

  // mtContact
  LDataSetList := ClientModule1.ServerMethods1Client.GetContacts(
                        Module.mtClient.Table.Rows[0].GetValues('ClientID'));
  Module.mtContact.AppendData(TFDJSONDataSetsReader.GetListValue(LDataSetList,0));
  Module.mtContact.Open;

  if not Module.mtPerson.IsEmpty then
  begin
    Module.mtPerson.First;
    PersonView.ClearListBox;
    // For each person
    for I := 0 to Module.mtPerson.Table.Rows.Count-1 do
    begin
      // Set data
      Person := TPerson.Create(Module.mtPerson.Fields.FieldByName('PersonID').Value,
                               Module.mtClient.Fields.FieldByName('ClientID').Value,
                               IfNull(Module.mtPerson.Fields.FieldByName('LastName').Value,''),
                               IfNull(Module.mtPerson.Fields.FieldByName('FirstName').Value,''),
                               IfNull(Module.mtPerson.Fields.FieldByName('Notes').Value,''));
      PersonView.AddPersonToListBox(Person);
      // for each contact for this person add to list box
      Module.mtContact.First;
      for J := 0 to Module.mtContact.Table.Rows.Count-1 do
      begin
        if Module.mtContact.Fields.FieldByName('PersonID').Value
         = Module.mtPerson.Fields.FieldByName('PersonID').Value then
        begin
          Contact := TContact.Create(Module.mtContact.Fields.FieldByName('ContactID').Value,
                                     Module.mtContact.Fields.FieldByName('PersonID').Value,
                                     IfNull(Module.mtContact.Fields.FieldByName('ContactType').Value,''),
                                     IfNull(Module.mtContact.Fields.FieldByName('Phone').Value,''),
                                     IfNull(Module.mtContact.Fields.FieldByName('Email').Value,''));

          PersonView.AddContactToListBox(Contact);
        end;
        Module.mtContact.Next;
      end;
      Module.mtPerson.Next;
    end;
  end;
end;


// Sets fields of the current entry in mtPeople according to the TPerson
// Used in AddToPerson and EditPerson
procedure PersonFields(Person : TPerson);
begin
  with Module.mtPerson do
  begin
    Fields.FieldByName('PersonID').Value := Person.PersonID;
    Fields.FieldByName('ClientID').Value := Person.Client;
    Fields.FieldByName('LastName').Value := Person.Last;
    Fields.FieldByName('FirstName').Value:= Person.First;
    Fields.FieldByName('Notes').Value := Person.Notes;
  end;
end;

// Sets fields of the current entry in mtContact according to the TContact and PersonID
// Used in AddToPerson and EditPerson
procedure ContactFields(Contact : TContact; PersonID : Integer);
begin
  with Module.mtContact do
  begin
    Fields.FieldByName('ContactID').Value  := Contact.ID;
    Fields.FieldByName('PersonID').Value   := PersonID;
    Fields.FieldByName('ContactType').Value:= Contact.ContactType;
    Fields.FieldByName('Phone').Value := Contact.Phone;
    Fields.FieldByName('Email').Value := Contact.Email;
  end;
end;

procedure AddPerson(Person : TPerson; Contacts : Array of TContact);
var
  I : Integer;
begin
  with Module do
  begin
    Module.mtPerson.Open;
    Module.mtPerson.Append;
    PersonFields(Person);
    Module.mtPerson.Post;

    if Length(Contacts) > 0 then
    begin
      mtContact.Open;
      for I := 0 to Length(Contacts)-1 do
      begin
        mtContact.Append;
        ContactFields(Contacts[I], Person.PersonID);
      end;
      mtContact.Post;
    end;
  end;
end;

procedure EditPerson(Person : TPerson; Contacts : Array of TContact);
var
  I: Integer;
  test : String;
begin
  with Module.mtPerson do
  begin
    if not Active then Open;
    First;
    while not EOF do
    begin
      if Fields.FieldByName('PersonID').Value = Person.PersonID then
      begin
        Edit;
        PersonFields(Person);

        Break;
      end
      else Next;
    end;
  end;
  // Contacts
  with Module.mtContact do
  begin
    // Delete all contacts for that person
    if not Active then Open;
    First;
    while not EOF do
    begin
      test := Fields.FieldByName('ContactID').Value;
      if Fields.FieldByName('PersonID').Value = Person.PersonID then
      begin
        Delete;
      end
      else Next;
    end;
    First;
    for I := 0 to Length(Contacts)-1 do
    begin
      Append;
      ContactFields(Contacts[I],Person.PersonID);
      Post;
    end;
  end;
end;

procedure DeletePerson(PersonID : Integer);
begin
  // Person
  with Module.mtPerson do
  begin
    if not Active then Open;
    First;
    while not EOF do
    begin
      if Fields.FieldByName('PersonID').Value = PersonID then
      begin
        Edit;
        Delete;

        Break;
      end
      else Next;
    end;
  end;
  // Contacts
  with Module.mtContact do
  begin
    // Delete all contacts for that person
    if not Active then Open;
    First;
    while not EOF do
    begin
      if Fields.FieldByName('PersonID').Value = PersonID then
      begin
        Delete;
      end
      else Next;
    end;
  end;
end;

end.
