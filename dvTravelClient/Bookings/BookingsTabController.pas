unit BookingsTabController;

// Controls the data of the Bookings tab
// Sub Units are RentalController, PaymentController, TravelController
// Controls mtBooking

interface
uses
    classBooking, classResultsArray, ClientModuleUnit1, DatabaseStrings, Misc,
    Variants, Data.FireDACJSONReflect, System.SysUtils, System.Classes, UITypes;

function CurrentBookingID : Integer;
function LastBookingID: Integer;
function GetBookingByID(BookID : Integer) : TBooking;

procedure ClearBookingsTab;
procedure SetEditBookingItem(Booking : TBooking);

procedure SaveBooking;

implementation
uses Main, DataController, ClientsTabController, SelectPeople,
     RentalController, PaymentController, TravelController,
     BookingsTabView, RentalView, PaymentView, TravelView;

function CurrentBookingID : Integer;
begin
  Result := Module.mtClient.Fields.FieldByName('ClientID').Value;
end;

function LastBookingID: Integer;
begin
  Result := ClientModule1.ServerMethods1Client.LastID('booking');
end;

function GetBookingByID(BookID : Integer) : TBooking;
var
  LDataSetList : TFDJSONDataSets;
begin
  Module.mtExtraTable.Close;
  // Get Data
  LDataSetList := ClientModule1.ServerMethods1Client.GetBookingByID(BookID);
  Module.mtExtraTable.AppendData(TFDJSONDataSetsReader.GetListValue(LDataSetList,0));
  Module.mtExtraTable.Open;
  with Module.mtExtraTable do
  begin
    First;
    if not EOF then
    begin
      Result := TBooking.Create(FieldByName('BookingID').Value,
                               FieldByName('ClientID').Value,
                               IfNull(FieldByName('PersonID').Value,0),
                               IfNull(FieldByName('DateCalled').Value,0),
                               IfNull(FieldByName('InvoiceDate').Value,0),
                               IfNull(FieldByName('VoucherDate').Value,0),
                               IfNull(FieldByName('DepositDueDate').Value,0),
                               IfNull(FieldByName('Currency').Value,'Other'),
                               IfNull(FieldByName('Charges').AsFloat,0),
                               IfNull(FieldByName('DepositAmt').Value,0),
                               IfNull(FieldByName('AmtPaid').Value,0),
                               IfNull(FieldByName('Status').Value,''),
                               IfNull(FieldByName('AcctgNotes').asString,''),
                               IfNull(FieldByName('ServiceNotes').asString,''),
                               IfNull(FieldByName('CreatedBy').AsString,''),
                               IfNull(FieldByName('Modified').AsDateTime,0),
                               IfNull(FieldByName('StartDate').AsDateTime,0),
                               IfNull(FieldByName('EndDate').AsDateTime,0));
    end
    else
    begin
      Result := nil;
    end;
  end;
end;

procedure ClearBookingsTab;
begin
  Module.mtRental.Close;
  Module.mtRental.Open;
  Module.mtRentAccom.Close;
  Module.mtRentAccom.Open;
  Module.mtPayments.Close;
  Module.mtPayments.Open;
  Module.mtTravel.Close;
  Module.mtTravel.Open;
  Module.mtBookingPerson.Open;
  Module.mtBookingPerson.Close;

  BookingsTabView.ClearBookingTabView;
end;

procedure SetEditBookingItem(Booking : TBooking);
begin
try
  // mtClient
  // If the current client is not the bookings client, change client to match
  BookingsTabView.ClientID := Booking.ClientID;
  Module.mtClient.Open;
  if Module.mtClient.Fields.FieldByName('ClientID').Value <> Booking.ClientID then
  begin
    ClientsTabController.SetClientsTab(Booking.ClientId);
  end;

  ClearBookingsTab;
  RentalController.SetRentals(Booking.BookingId);
  PaymentController.SetPayments(Booking.BookingId);
  TravelController.SetTravel(Booking.BookingId);
  SelectPeople.SetBookingPerson(Booking.BookingID, Booking.PersonID);

  SetBooking(Booking);

  MainForm.rectNoBookingSet.Visible := False;
  MainForm.lNoBookingSet.Visible := False;

  BookingsTabView.SetTabSaved;
except
  on E : Exception do
  begin
    Print('ERROR: ' + E.ClassName + sLineBreak + E.Message);
  end;
end;
end;

procedure SaveBooking;
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
        if mtRental.State in dsEditModes then
        begin
          mtRental.Post;
        end;
        if mtRentAccom.State in dsEditModes then
        begin
          mtRentAccom.Post;
        end;
        if mtPayments.State in dsEditModes then
        begin
          mtPayments.Post;
        end;
        if mtTravel.State in dsEditModes then
        begin
          mtTravel.Post;
        end;
        if mtBooking.State in dsEditModes then
        begin
          mtBooking.Post;
        end;

        // Booking
        // Create a booking deltalist, send to server and get changed ids
        if not mtBooking.Active then mtBooking.Open;
        DeltaList := TFDJSONDeltas.Create;
        TFDJSONDeltasWriter.ListAdd(DeltaList, sBooking, mtBooking);
        if TFDJSONDeltasReader.GetListValue(DeltaList,0).Table.Rows.Count > 0 then
        begin
          ReturnedResults := ClientModule1.ServerMethods1Client.SaveBookings(DeltaList);
          // Update BookingIDs for mtBooking, mtRental, mtPayments, and mtTravel
          if ReturnedResults.GetLen() > 0 then
          begin
            Field := 'BookID';
            DataController.ChangeIDs(mtBooking,'BookingID', ReturnedResults);
            DataController.ChangeIDs(mtRental,  Field, ReturnedResults);
            DataController.ChangeIDs(mtPayments,Field, ReturnedResults);
            DataController.ChangeIDs(mtTravel,  Field, ReturnedResults);
            BookingsTabView.UpdateBookingIDs(ReturnedResults);
          end;
          mtBooking.CommitUpdates;
        end;

        // Rental
        // Create a rental deltalist, send to server and get changed ids
        if not mtRental.Active then mtRental.Open;
        DeltaList := TFDJSONDeltas.Create;
        TFDJSONDeltasWriter.ListAdd(DeltaList, sRental, mtRental);
        if TFDJSONDeltasReader.GetListValue(DeltaList,0).Table.Rows.Count > 0 then
        begin
          ReturnedResults := ClientModule1.ServerMethods1Client.SaveRentals(DeltaList);
          // Update BookingIDs for mtRental and mtRentAccom
          if ReturnedResults.GetLen() > 0 then
          begin
            Field := 'RentID';
            DataController.ChangeIDs(mtRental,  Field, ReturnedResults);
            DataController.ChangeIDs(mtRentAccom,Field, ReturnedResults);
            RentalView.UpdateRentalIDs(ReturnedResults);
          end;
          mtRental.CommitUpdates;
        end;

        // RentAccom
        // Create a rental deltalist, send to server
        if not mtRentAccom.Active then mtRentAccom.Open;
        DeltaList := TFDJSONDeltas.Create;
        TFDJSONDeltasWriter.ListAdd(DeltaList, sRentAccom, mtRentAccom);
        if TFDJSONDeltasReader.GetListValue(DeltaList,0).Table.Rows.Count > 0 then
        begin
          ClientModule1.ServerMethods1Client.SaveRentAccoms(DeltaList);
          mtRentAccom.CommitUpdates;
        end;

        // Payment
        // Create a payment deltalist, send to server and get changed ids
        if not mtPayments.Active then mtPayments.Open;
        DeltaList := TFDJSONDeltas.Create;
        TFDJSONDeltasWriter.ListAdd(DeltaList, sPayment, mtPayments);
        if TFDJSONDeltasReader.GetListValue(DeltaList,0).Table.Rows.Count > 0 then
        begin
          ReturnedResults := ClientModule1.ServerMethods1Client.SavePayments(DeltaList);
          // Update BookingIDs for mtPayments
          if ReturnedResults.GetLen() > 0 then
          begin
            Field := 'PayID';
            DataController.ChangeIDs(mtPayments,Field, ReturnedResults);
            PaymentView.UpdatePaymentIDs(ReturnedResults);
          end;
          mtPayments.CommitUpdates;
        end;

        // Travel
        // Create a travel deltalist, send to server and get changed ids
        if not mtTravel.Active then mtTravel.Open;
        DeltaList := TFDJSONDeltas.Create;
        TFDJSONDeltasWriter.ListAdd(DeltaList, sTravel, mtTravel);
        if TFDJSONDeltasReader.GetListValue(DeltaList,0).Table.Rows.Count > 0 then
        begin
          ReturnedResults := ClientModule1.ServerMethods1Client.SaveTravel(DeltaList);
          // Update TravelIDs for mtTravel
          if ReturnedResults.GetLen() > 0 then
          begin
            Field := 'TravelID';
            DataController.ChangeIDs(mtTravel,Field, ReturnedResults);
            TravelView.UpdateTravelIDs(ReturnedResults);
          end;
          mtTravel.CommitUpdates;
        end;

        // BookingPerson
        // Create a travel deltalist, send to server and get changed ids
        if not mtBookingPerson.Active then mtBookingPerson.Open;
        DeltaList := TFDJSONDeltas.Create;
        TFDJSONDeltasWriter.ListAdd(DeltaList, sBookingPerson, mtBookingPerson);
        if TFDJSONDeltasReader.GetListValue(DeltaList,0).Table.Rows.Count > 0 then
        begin
          ClientModule1.ServerMethods1Client.SaveBookingPerson(DeltaList);
          mtBookingPerson.CommitUpdates;
        end;
        // Changes have been saved
        BookingsTabView.SetTabSaved;
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




