unit PersonView;

interface
uses classPerson, classContact, classResultsArray,
     FMX.ListBox, System.SysUtils, System.UITypes;

const
  AddPerson : String = 'Add Person';
  EditPerson : String = 'Edit Person';

var
  PersonID : Integer;
  NumContactsToAdd : Integer;

// Manipulate lbPeople
procedure ClearListBox;
procedure AddPersonToListBox(Person : TPerson);
procedure AddContactToListBox(Contact : TContact);
procedure EditPersonListBox(Person : TPerson; Contacts : Array of TContact);
procedure DeletePersonFromListBox(PersonID : Integer);

// Updates old negative temporary IDs
// with new ones once they've been properly added to the database
procedure UpdatePersonIDs(ResultsArray : TResultsArray);
procedure UpdateContactIDs(ResultsArray : TResultsArray);

// Set panelAddPerson
procedure SetEditPersonItem(const Item: TListBoxItem);
procedure SetAddNewPerson;

// User options for panelAddPerson
// Called when user clicks on a existing contact in panelAddPerson
procedure AddPersonRemoveContact(const Item: TListBoxItem);
// Adds new contact to lbContact in AddPersonPanel
procedure AddNewContact;
// Returns without making any changes
procedure AddPersonCancel;
// Saves changes locally, returns
procedure AddPersonSave;
// Deletes currently selected person
procedure AddPersonDelete;

implementation
uses Main, PersonController, ClientsTabView, BookingsTabController;

// Manipulate lbPeople

procedure ClearListBox;
begin
  MainForm.lbPeople.Clear;
end;

// Adds Person to lbPeople
procedure AddPersonToListBox(Person : TPerson);
var
  Item : TListBoxItem;
begin
  Item := TListBoxItem.Create(MainForm.lbPeople);
  Item.Text := Person.PersonID.ToString;
  Item.ItemData.Detail := Person.ToString;
  Item.Data := Person;
  Item.StyleLookup := 'HeaderListBoxItem';
  MainForm.lbPeople.AddObject(Item);
end;

// Adds Contact to lbPeople
procedure AddContactToListBox(Contact : TContact);
var
  Item : TListBoxItem;
begin
  Item := TListBoxItem.Create(MainForm.lbPeople);
  Item.Text := 'Contact' + Contact.PersonID.ToString;
  Item.Data := Contact;
  Item.ItemData.Detail := Contact.ToString;
  Item.StyleLookup := 'SubListBoxItem';
  MainForm.lbPeople.AddObject(Item);
end;

// Edits Person and Corresponding contacts in lbPeople
procedure EditPersonListBox(Person : TPerson; Contacts : Array of TContact);
var
  PersonIndex : Integer;
  I : Integer;
begin
  with MainForm.lbPeople do
  begin
    PersonIndex := Items.IndexOf(Person.PersonID.ToString);
    ListItems[PersonIndex].ItemData.Detail := Person.ToString;
    ListItems[PersonIndex].Data := Person;

    // Delete all contacts with that person ID
    I := Items.IndexOf('Contact'+Person.PersonID.ToString);
    while I <> -1 do
    begin
      Items.Delete(I);
      I := Items.IndexOf('Contact'+Person.PersonID.ToString);
    end;

    for I := 0 to Length(Contacts)-1 do
    begin
      Items.InsertObject(PersonIndex+1, 'Contact'+Person.PersonID.ToString, Contacts[I]);
      ListItems[PersonIndex+1].ItemData.Detail := Contacts[I].ToString;
      ListItems[PersonIndex+1].StyleLookup := 'SubListBoxItem';
      PersonIndex := PersonIndex + 1;
    end;
  end;
end;

procedure DeletePersonFromListBox(PersonID : Integer);
var
  I : Integer;
begin
  with MainForm.lbPeople do
  begin
    // Delete Person
    I := Items.IndexOf(PersonID.ToString);
    ListItems[I].Free;

    // Delete Contacts
    I := Items.IndexOf('Contact'+PersonID.ToString);
    while I <> -1 do
    begin
      ListItems[I].Free;
      I := Items.IndexOf('Contact'+PersonID.ToString);
    end;
  end;
end;

// Updates old negative temporary IDs (of people and contacts)
// with new ones once people been properly added to the database
procedure UpdatePersonIDs(ResultsArray : TResultsArray);
var
  I : Integer;
  J : Integer;
  test : string;
  Person : TPerson;
  Contact: TContact;
begin
  with MainForm.lbPeople do
  begin
    // For each record...
    for I := 0 to Count-1 do
    begin
      // change PersonID
      if ListItems[I].Data.ToString = 'TPerson' then
      begin
        Person := ListItems[I].Data as TPerson;
        // If ID is a temporary ID (negative)...
        if Person.PersonID < 0 then
        begin
          // For each changed ID...
          for J := 0 to ResultsArray.GetLen-1 do
          begin
            // Replace old client IDs with new client IDs
            if Person.PersonID = ResultsArray.GetID(J).OldID then
            begin
              Person.PersonID := ResultsArray.GetID(J).NewID;
              ListItems[I].Data := Person;
              ListItems[I].Text := Person.PersonID.ToString;
              test := Person.ToString;
              ListItems[I].ItemData.Detail := Person.ToString;
              test := ListItems[I].ItemData.Detail;
              test := '';
              Break;
            end;
          end;
        end;
      end
      else
      // change PersonID
      if ListItems[I].Data.ToString = 'TContact' then
      begin
        Contact := ListItems[I].Data as TContact;
        // If ID is a temporary ID (negative)...
        if Contact.PersonID < 0 then
        begin
          // For each changed ID...
          for J := 0 to ResultsArray.GetLen-1 do
          begin
            // Replace old client IDs with new client IDs
            if Contact.PersonID = ResultsArray.GetID(J).OldID then
            begin
              Contact.PersonID := ResultsArray.GetID(J).NewID;
              ListItems[I].Data := Contact;
              ListItems[I].Text := 'Contact'+Contact.PersonID.ToString;
              ListItems[I].ItemData.Detail := Contact.ToString;
              Break;
            end;
          end;
        end;
      end;
    end;
  end;
end;

// Updates old negative temporary IDs
// with new ones once contacts been properly added to the database
procedure UpdateContactIDs(ResultsArray : TResultsArray);
var
  I : Integer;
  J : Integer;
  Contact: TContact;
begin
  with MainForm.lbPeople do
  begin
    // For each record...
    for I := 0 to Count-1 do
    begin
      if ListItems[I].Data.ToString = 'TPerson' then
      begin
        // Do nothing
      end
      else
      if ListItems[I].Data.ToString = 'TContact' then
      begin
        // its a contact, change contactID
        Contact := ListItems[I].Data as TContact;

        // If ID is a temporary ID (negative)...
        if Contact.ID < 0 then
        begin
          // For each changed ID...
          for J := 0 to ResultsArray.GetLen-1 do
          begin
            // Replace old client IDs with new client IDs
            if Contact.ID = ResultsArray.GetID(J).OldID then
            begin
              Contact.ID := ResultsArray.GetID(J).NewID;
              ListItems[I].Data := Contact;
              ListItems[I].ItemData.Detail := Contact.ToString;
              Break;
            end;
          end;
        end;
      end;
    end;
  end;
end;

// Set panelAddPerson

// Set panelAddPerson for editing
procedure SetEditPersonItem(const Item: TListBoxItem);
var
  Person : TPerson;
  Contact: TContact;
  I : Integer;
begin
with MainForm do
begin
  // Deletion is available while editing
  bAddPersonDelete.Enabled := True;

  Person := Item.Data as TPerson;
  lAddPerson.Text := EditPerson;
  PersonID := Person.PersonID;
  eAddPersonLastName.Text := Person.Last;
  eAddPersonFirstName.Text := Person.First;
  eAddPersonNotes.Text := Person.Notes;
  eContactEmail.Text := '';
  eContactPhone.Text := '';
  eContactType.Text  := '';

  lbContact.Clear;
  for I := 0 to lbPeople.Count-1 do
  begin
    if lbPeople.Items[I] = 'Contact'+Person.PersonID.ToString then
    begin
      Contact := lbPeople.ListItems[I].Data as TContact;
      lbContact.Items.AddObject(Contact.ToString,Contact);
    end;
  end;

  OpenPanel(PanelAddPerson);
end;
end;

// Set panelAddPerson for adding
procedure SetAddNewPerson;
begin
with MainForm do
  begin
    // Cannot delete a person who hasn't been added yet
    bAddPersonDelete.Enabled := False;

    lAddPerson.Text := AddPerson;
    PersonID := -(lbPeople.Count)-1;
    eAddPersonLastName.Text := '';
    eAddPersonFirstName.Text:= '';
    eAddPersonNotes.Text    := '';
    eContactEmail.Text := '';
    eContactPhone.Text := '';
    eContactType.Text  := '';
    lbContact.Clear;

    OpenPanel(panelAddPerson);
  end;
end;

// panelAddPerson user options

// Called when user clicks on a existing contact in panelAddPerson
procedure AddPersonRemoveContact(const Item: TListBoxItem);
var
  Contact : TContact;
  I : Integer;
begin
  Contact := Item.Data as TContact;
  I := MainForm.lbContact.Items.IndexOf(Contact.ToString);
  MainForm.lbContact.Items.Delete(I);
end;

// Adds new contact to lbContact in AddPersonPanel
procedure AddNewContact;
var
  Contact : TContact;
  Email : String;
  Curr : Char;
  I, Step : Integer;
  Error : Boolean;
begin
with MainForm do
begin
  // If not all fields are empty
  if (eContactType.Text <> '') or (eContactPhone.Text <> '') or (eContactEmail.Text <> '') then
  begin
    Error := False;

    // Ensure email is valid
    if eContactEmail.Text <> '' then
    begin
      Email := eContactEmail.Text;
      Step  := 0;
      for I := 1 to Email.Length do
      begin
        Curr := Email[I];
        // if not alphanumeric, check if @ or ., else bad
        if not (Curr in ['a'..'z','A'..'Z','0'..'9','_']) then
        begin
          if (Step = 0) and (Curr = '@') then
          begin
            Step := 1;
          end
          else
          if (Step = 1) and (Curr = '.') then
          begin
            Step := 2;
          end;
        end
        else
        // If alphanumeric
        begin
          if Step = 2 then
          begin
            Step := 3;
          end;
        end;
      end;
      if Step <> 3 then
        begin
          Error := True;
        end;
    end;

    if Error = False then
    begin

      // If no problems, add, make sure email color is Black
      Contact := TContact.Create(-(lbPeople.Count)-2-NumContactsToAdd,
                                 PersonID,
                                 eContactType.Text,
                                 eContactPhone.Text,
                                 eContactEmail.Text);
      lbContact.Items.AddObject(Contact.ToString,Contact);
      lContactEmail.FontColor := TAlphaColorRec.Black;
      eContactType.Text  := '';
      eContactPhone.Text := '';
      eContactEmail.Text := '';

      Inc(NumContactsToAdd,1);
    end
    else
    begin
      // If problem with email, set color to Red
      lContactEmail.FontColor := TAlphaColorRec.Red;
    end;
  end;
end;
end;

// Returns without making any changes
procedure AddPersonCancel;
begin
with MainForm do
begin
  ClosePanel(panelAddPerson);
end;
end;

// Saves changes locally, returns
procedure AddPersonSave;
var
  Person : TPerson;
  Contacts : Array of TContact;
  Size : Integer;
  I: Integer;
begin
with MainForm do
begin
  // Person
  Person := TPerson.Create(PersonID,
                           BookingsTabController.CurrentBookingID,
                           eAddPersonLastName.Text,
                           eAddPersonFirstName.Text,
                           eAddPersonNotes.Text);


  // Contacts
  Size := lbContact.Count;
  if Size > 0 then
  begin
    SetLength(Contacts, Size);
    for I := 0 to Size-1 do
    begin
      Contacts[I] := lbContact.ListItems[I].Data as TContact;
    end;
  end;

  // If there was a contact filled out but not added, add to contacts
  // If its a person with one contact it saves time, may prevent errors such as forgetting to add contact
  if (eContactType.Text <> '') or (eContactPhone.Text <> '') or (eContactEmail.Text <> '') then
  begin
    AddNewContact;
  end;

  Size := Length(Contacts);
  if lAddPerson.Text = AddPerson then
  begin
    // Data
    PersonController.AddPerson(Person,Contacts);
    // View
    AddPersonToListBox(Person);
    for I := 0 to Size-1 do
    begin
      AddContactToListBox(Contacts[I]);
    end;
  end
  else
  if lAddPerson.Text = EditPerson then
  begin
    // Data
    PersonController.EditPerson(Person, Contacts);
    // View
    EditPersonListBox(Person, Contacts);
  end;

  NumContactsToAdd := 0;
  cbClientsSave.IsChecked := False;
  lContactEmail.FontColor := TAlphaColorRec.Black;
  ClosePanel(panelAddPerson);

  // Push changes to database
  ClientsTabView.ClientSave;
end;
end;

// Deletes currently selected person
procedure AddPersonDelete;
begin
  // Data
  PersonController.DeletePerson(PersonID);
  // View
  DeletePersonFromListBox(PersonID);

  MainForm.cbClientsSave.IsChecked := False;
  MainForm.ClosePanel(MainForm.panelAddPerson);

  // Push changes to database
  ClientsTabView.ClientSave;
end;

end.

