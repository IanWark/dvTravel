unit PaymentController;

// Controls the data of the Payment section of the Bookings tab
// mtBank, mtPayment

interface
uses classPayment, ClientModuleUnit1,
     Data.FireDACJSONReflect;

procedure SetBankTable;
procedure SetPayments(BookID : Integer);

procedure PaymentFields(Payment : TPayment);
procedure AddPayment(Payment : TPayment);
procedure EditPayment(Payment : TPayment);
procedure DeletePayment(PayID : Integer);

implementation
uses Main, DataController, PaymentView;

procedure SetBankTable;
var
  LDataSetList : TFDJSONDataSets;
  I: Integer;
begin
  // Get Data
  LDataSetList := ClientModule1.ServerMethods1Client.GetBanks;
  Module.mtBank.AppendData(TFDJSONDataSetsReader.GetListValue(LDataSetList,0));
  Module.mtBank.Open;
  // Set View
  with Main.MainForm do
  begin
    eAddPaymentBankID.Clear;
    Module.mtBank.First;
    while not Module.mtBank.Eof do
    begin
      I := Module.mtBank.Fields.FieldByName('BankID').Value;
      eAddPaymentBankID.Items.AddObject(Module.mtBank.Fields.FieldByName('BankName').Value,
                                        TObject(I));
      Module.mtBank.Next;
    end;
  end;
end;

procedure SetPayments(BookID : Integer);
var
  LDataSetList : TFDJSONDataSets;
  Payment: TPayment;
begin
  LDataSetList := ClientModule1.ServerMethods1Client.GetPayments(BookID);
  Module.mtPayments.AppendData(TFDJSONDataSetsReader.GetListValue(LDataSetList,0));
  Module.mtPayments.Open;
  with Module.mtPayments do
  begin
    First;
    while not EOF do
    begin
      Payment := TPayment.Create(Fields.FieldByName('PayID').Value,
                                 Fields.FieldByName('BookID').Value,
                                 Fields.FieldByName('PayDate').Value,
                                 Fields.FieldByName('AmtPaid').Value,
                                 Fields.FieldByName('Currency').Value,
                                 Fields.FieldByName('Conversion').Value,
                                 Fields.FieldByName('AmtRecvd').Value,
                                 Fields.FieldByName('PayMethod').Value,
                                 Fields.FieldByName('PayType').Value,
                                 Fields.FieldByName('PayNote').Value,
                                 Fields.FieldByName('BankID').Value,
                                 ClientModule1.ServerMethods1Client.GetBankById(Fields.FieldByName('BankID').Value)
                                 );
      PaymentView.AddPaymentToListBox(Payment);
      Next;
    end;
  end;
  PaymentView.CalculatePaymentsTotal;
end;

// Sets fields of the current entry in mtPayment according to the TPayment
// Used in AddToPayments and EditPayments
procedure PaymentFields(Payment : TPayment);
begin
  with Module.mtPayments do begin
    Fields.FieldByName('PayID').Value := Payment.PayID;
    Fields.FieldByName('BookID').Value := Payment.BookID;
    Fields.FieldByName('PayDate').Value := Payment.PayDate;
    Fields.FieldByName('AmtPaid').Value := Payment.AmtPaid;
    Fields.FieldByName('Currency').Value := Payment.Currency;
    Fields.FieldByName('Conversion').Value := Payment.Conversion;
    Fields.FieldByName('AmtRecvd').Value := Payment.AmtRecvd;
    Fields.FieldByName('PayMethod').Value := Payment.PayMethod;
    Fields.FieldByName('PayType').Value := Payment.PayType;
    Fields.FieldByName('PayNote').Value := Payment.PayNote;
    Fields.FieldByName('BankID').Value := Payment.BankID;
  end;
end;

procedure AddPayment(Payment : TPayment);
begin
  Module.mtPayments.Open;
  Module.mtPayments.Append;
  PaymentFields(Payment);
  Module.mtPayments.Post;
end;

procedure EditPayment(Payment : TPayment);
begin
  with Module.mtPayments do begin
    if not Active then Open;
    First;
    while not EOF do
    begin
      if Fields.FieldByName('PayID').Value = Payment.PayID then
      begin
        Edit;
        PaymentFields(Payment);
        Post;

        Break;
      end
      else
      begin
        Next;
      end;
    end;
  end;
end;

procedure DeletePayment(PayID : Integer);
begin
  // Payment
  with Module.mtPayments do begin
    if Locate('PayID',PayID) then
      Delete
    else
      MainForm.Print('ERROR: could not find payment object in mtPayment to delete');
  end;
end;

end.
