unit ClientsTabController;

// Controls the data of the clients tab
// Sub Units are PersonController, BookingController
// Controls mtClient

interface
uses
  classBooking, classClient, ClientModuleUnit1, DatabaseStrings, Misc,
  Variants, Data.FireDACJSONReflect, System.SysUtils, System.Classes, DB,
  classResultsArray, FireDAC.Comp.Client, FMX.ListBox, UITypes;

var
  ClientChanged : Boolean = False;

function LastClientID : Integer;

// Get and Set information on the clients tab
procedure SetClientsTab(ClientID : Integer);
procedure SetClient(ClientID : Integer);

// Returns ID of the first person in mtPerson
function FirstPersonID : Integer;

procedure ClearClients;
procedure AddNewClient;
procedure SaveClient;

implementation
uses Main, DataController,
     ClientsTabView, PersonController, PersonView, BookingController,
     System.Diagnostics;

function LastClientID : Integer;
begin
  Result := ClientModule1.ServerMethods1Client.LastID('client');
end;

procedure SetClientsTab(ClientID : Integer);
begin
  ClearClients;
  SetClient(ClientID);
  PersonController.SetPeople(ClientID);
  BookingController.SetBookings(ClientID);

  // Data is not changed yet
  ClientsTabView.SetTabSaved;
end;

procedure SetClient(ClientID : Integer);
var
  LDataSetList : TFDJSONDataSets;
begin
try
  with Main.MainForm do
  begin
    // Empty memtable
    Module.mtClient.Close;
    Module.mtClient.Open;
    // mtClient
    // Get data
    LDataSetList := ClientModule1.ServerMethods1Client.GetClient(ClientID);
    Module.mtClient.AppendData(TFDJSONDataSetsReader.GetListValue(LDataSetList,0));
    Module.mtClient.Open;
    // Set view
    eDateEntered.Date := IfNull(Module.mtClient.Fields.FieldByName('DateEntered').Value,date);
    if Module.mtClient.Fields.FieldByName('Active').Value = 0 then
    begin
      cbClientActive.IsChecked := False;
    end
    else
    begin
      cbClientActive.IsChecked := True;
    end;

    eAddress.Text := IfNull(Module.mtClient.Fields.FieldByName('Address').Value,'');
    eCity.Text    := IfNull(Module.mtClient.Fields.FieldByName('City').Value,'');
    eProv.Text    := IfNull(Module.mtClient.Fields.FieldByName('ProvState').Value,'');
    eCountry.Text := IfNull(Module.mtClient.Fields.FieldByName('Country').Value,'');
    ePostal.Text  := IfNull(Module.mtClient.Fields.FieldByName('PostalZip').Value,'');
    eClientNotes.Text := IfNull(Module.mtClient.Fields.FieldByName('Notes').AsString,'');

    MainForm.rectNoClientSet.Visible := False;
    MainForm.lNoClientSet.Visible := False;
  end;

except
  on E : Exception do
  begin
    MainForm.circleOnlineStatus.Fill.Color := TAlphaColorRec.Red;
      Print('ERROR: ' + E.ClassName + sLineBreak + E.Message);
  end;
end;
end;

// Returns ID of the first person in mtPerson
// Used in BookingView's NewBooking and SelectBooking
function FirstPersonID : Integer;
begin
  with Module.mtPerson do
  begin
    if not Active then Open;
    First;
    Result := FieldByName('PersonID').AsInteger;
  end;
end;

// Empties memory tables of everything on the client page
procedure ClearClients;
begin
  Module.mtClient.Close;
  Module.mtClient.Open;
  Module.mtPerson.Close;
  Module.mtPerson.Open;
  Module.mtContact.Close;
  Module.mtContact.Open;
  Module.mtBooking.Close;
  Module.mtBooking.Open;

  ClientsTabView.ClearClientsTabView;
end;

procedure AddNewClient;
begin
  with Module.mtClient do
  begin
    if not Active then Open;
    First;
    Edit;
    Fields.FieldByName('ClientID').Value := -1;
    Fields.FieldByName('DateEntered').Value := Date;
    Fields.FieldByName('Active').Value := 1;
    Fields.FieldByName('Address').Value := '';
    Fields.FieldByName('City').Value := '';
    Fields.FieldByName('ProvState').Value := '';
    Fields.FieldByName('Country').Value := '';
    Fields.FieldByName('PostalZip').Value := '';
    Fields.FieldByName('Notes').Value := '';
    Post;
  end;
  if IsConnected then
  begin
    SaveClient;
  end;
end;

// Save changes to the Clients tab
procedure SaveClient;
var
  DeltaList : TFDJsonDeltas;
  ReturnedResults : TResultsArray;
  Field : String;
begin
  try
    if IsConnected then
    begin
      with Module do
      begin
        // Post if editing
        if mtClient.State in dsEditModes then
        begin
          mtClient.Post;
        end;
        if mtPerson.State in dsEditModes then
        begin
          mtPerson.Post;
        end;
        if mtContact.State in dsEditModes then
        begin
          mtContact.Post;
        end;
        if mtBooking.State in dsEditModes then
        begin
          mtBooking.Post;
        end;
        // Client
        // Create a client deltalist, send to server and get changed ids
        if not mtClient.Active then mtClient.Open;
        DeltaList := TFDJSONDeltas.Create;
        TFDJSONDeltasWriter.ListAdd(DeltaList, sClient, mtClient);
        if TFDJSONDeltasReader.GetListValue(DeltaList,0).Table.Rows.Count > 0 then
        begin
          ReturnedResults := ClientModule1.ServerMethods1Client.SaveClient(DeltaList);
          // Update ClientIDs for mtClient, mtPerson, and mtBooking
          if ReturnedResults.GetLen() > 0 then
          begin
            Field := 'ClientID';
            DataController.ChangeIDs(mtClient, Field, ReturnedResults);
            DataController.ChangeIDs(mtPerson, Field, ReturnedResults);
            DataController.ChangeIDs(mtBooking,Field, ReturnedResults);
            ClientsTabView.UpdateClientIDs(ReturnedResults);
          end;
          mtClient.CommitUpdates;
        end;

        // Person
        // Create a person deltalist, send to server and get changed ids
        if not mtPerson.Active then mtPerson.Open;
        DeltaList := TFDJSONDeltas.Create;
        TFDJSONDeltasWriter.ListAdd(DeltaList, sPerson, mtPerson);
        if TFDJSONDeltasReader.GetListValue(DeltaList,0).Table.Rows.Count > 0 then
        begin
          ReturnedResults := ClientModule1.ServerMethods1Client.SavePeople(DeltaList);
          // Update PersonIDs for mtPerson and mtContact
          if ReturnedResults.GetLen() > 0 then
          begin
            Field := 'PersonID';
            DataController.ChangeIDs(mtPerson, Field, ReturnedResults);
            DataController.ChangeIDs(mtContact,Field, ReturnedResults);
            PersonView.UpdatePersonIDs(ReturnedResults);
          end;
          mtPerson.CommitUpdates;
        end;
        // Contact
        // Create a contact deltalist, send to server and get changed ids
        if not mtContact.Active then mtContact.Open;
        DeltaList := TFDJSONDeltas.Create;
        TFDJSONDeltasWriter.ListAdd(DeltaList, sContact, mtContact);
        if TFDJSONDeltasReader.GetListValue(DeltaList,0).Table.Rows.Count > 0 then
        begin
          ReturnedResults := ClientModule1.ServerMethods1Client.SaveContacts(DeltaList);
          // Update ContactIDs for mtContact
          if ReturnedResults.GetLen > 0 then
          begin
            Field := 'ContactID';
            DataController.ChangeIDs(mtContact, Field, ReturnedResults);
            PersonView.UpdateContactIDs(ReturnedResults);
          end;
          mtContact.CommitUpdates;
        end;
        // Data changes have been successfully saved
        ClientsTabView.SetTabSaved;
      end;
    end;
  except
    // Exception occured
    on E : Exception do
    begin
      MainForm.circleOnlineStatus.Fill.Color := TAlphaColorRec.Red;
      Print('ERROR: ' + E.ClassName + sLineBreak + E.Message);
    end;
  end;
end;

end.








