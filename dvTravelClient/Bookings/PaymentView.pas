unit PaymentView;

// Controls View of payments in Bookings Tab

interface
uses classPayment, classResultsArray,
     FMX.ListBox, System.SysUtils, System.UITypes;

const
  AddPayment : String = 'Add Payment';
  EditPayment : String = 'Edit Payment';

var
  AddPaymentCurrencyBeingChanged : Boolean = False;
  PayID : Integer;

// When Payments change, change the total amount
procedure CalculatePaymentsTotal;

// Manipulate lbPayment
procedure AddPaymentToListBox(Payment : TPayment);
procedure EditPaymentListBox(Payment : TPayment);
procedure UpdatePaymentIDs(ResultsArray : TResultsArray);

// Set panelAddPayment
procedure SetEditPaymentItem(const Item: TListBoxItem);
procedure SetAddNewPayment;

// User Options for panelAddPayment

// When Payment method changes the info related changes (Currency and BankID)
procedure AddPaymentMethodChange;
// Add different options for currencies other than USD
procedure AddPaymentCurrencyChange;
// When amount changes set AmtRecvd
procedure AddPaymentAmountChange;
// When AmtRecvd changes set Conversion rate
procedure AddPaymentAmtRecvdChange;
// When conversion rate changes set AmtRecvd
procedure AddPaymentConversionChange;

procedure AddPaymentCancel;
procedure AddPaymentSave;
procedure AddPaymentDelete;

implementation
uses Main, PaymentController, BookingsTabView;

// PAYMENT
// When Payments change, change the total amount
procedure CalculatePaymentsTotal;
var
  Total : Double;
  Payment : TPayment;
  I: Integer;
begin
  Total := 0;
  for I := 0 to MainForm.lbPayments.Count-1 do
  begin
    Payment := MainForm.lbPayments.ListItems[I].Data as TPayment;
    Total := Total + Payment.AmtRecvd;
  end;
  MainForm.lPaymentTotalData.Text := Total.ToString;
  BookingsTabView.CalculateOutstanding;
end;

// Manipulate lbPayments
procedure AddPaymentToListBox(Payment : TPayment);
var
  Item : TListBoxItem;
begin
  Item := TListBoxItem.Create(MainForm.lbPayments);
  Item.Text := Payment.PayID.ToString;
  Item.Data := Payment;
  Item.ItemData.Detail := Payment.ToString;
  Item.StyleLookup := 'NormalListBoxItem';
  MainForm.lbPayments.AddObject(Item);
  CalculatePaymentsTotal;
end;

procedure EditPaymentListBox(Payment : TPayment);
var
  I : Integer;
begin
  with MainForm.lbPayments do
  begin
    I := Items.IndexOf(Payment.PayID.ToString);
    ListItems[I].ItemData.Detail := Payment.ToString;
    ListItems[I].Data := Payment;
  end;
  CalculatePaymentsTotal;
end;

procedure UpdatePaymentIDs(ResultsArray : TResultsArray);
var
  I : Integer;
  J : Integer;
  Payment : TPayment;
begin
  with MainForm.lbPayments do
  begin
    for I := 0 to ResultsArray.GetLen do
    begin
      J := Items.IndexOf(ResultsArray.GetID(I).OldID.ToString);
      while J <> -1 do
      begin
        Payment := ListItems[J].Data as TPayment;
        Payment.PayID := ResultsArray.GetID(I).NewID;
        ListItems[J].Data := Payment;
        ListItems[J].Text := Payment.PayID.ToString;
        ListItems[J].ItemData.Detail := Payment.ToString;
        J := Items.IndexOf(ResultsArray.GetID(I).OldID.ToString);
      end;
    end;
  end;
end;

// Set panelAddPayment

procedure SetEditPaymentItem(const Item: TListBoxItem);
var
  Payment : TPayment;
begin
with MainForm do
begin
  bAddPaymentDelete.Visible := True;

  lAddPayment.Text  := EditPayment;
  Payment := Item.Data as TPayment;
  PayID := Payment.PayID;
  eAddPaymentDate.Date       := Payment.PayDate;
  eAddPaymentAmount.Value    := Payment.AmtPaid;
  eAddPaymentNote.Text := Payment.PayNote;
  eAddPaymentConversion.Value := Payment.Conversion;
  eAddPaymentAmtRecvd.Value := Payment.AmtRecvd;
  try
    eAddPaymentMethod.ItemIndex := eAddPaymentMethod.Items.IndexOf(Payment.PayMethod);
  except
    MainForm.Print('ERROR: Method not found');
  end;
  try
    eAddPaymentType.ItemIndex := eAddPaymentType.Items.IndexOf(Payment.PayType);
  except
    MainForm.Print('ERROR: Type not found');
  end;
  try
    eAddPaymentBankID.ItemIndex := eAddPaymentBankID.Items.IndexOf(Payment.BankName);
  except
    MainForm.Print('ERROR: Bank not found');
  end;
  // Currency has possibilty of being custom set
  if eAddPaymentCurrency.Items.IndexOf(Payment.Currency) <> -1 then
  begin
    eAddPaymentCurrency.ItemIndex := eAddPaymentCurrency.Items.IndexOf(Payment.Currency);
  end
  else
  begin
    eAddPaymentCurrency.ItemIndex := eAddPaymentCurrency.Items.IndexOf('Other');
    eAddPaymentOther.Text := Payment.Currency;
  end;

  OpenPanel(panelAddPayment);
end;
end;

procedure SetAddNewPayment;
begin
  with MainForm do
  begin
    bAddPaymentDelete.Visible := False;

    lAddPayment.Text  := AddPayment;
    PayID := lbPayments.Count-1;
    eAddPaymentAmount.Value := 0;
    eAddPaymentDate.Date := date;
    eAddPaymentMethod.ItemIndex := -1;
    eAddPaymentOther.Text := '';
    eAddPaymentType.ItemIndex := 2;
    eAddPaymentCurrency.ItemIndex := 0;
    eAddPaymentConversion.Value := 1;
    eAddPaymentAmtRecvd.Value := 0;
    OpenPanel(panelAddPayment);
  end;
end;

// User options for panelAddPayment

// When Payment method changes the info related changes (Currency and BankID)
procedure AddPaymentMethodChange;
begin
with MainForm do
begin
  if eAddPaymentMethod.ItemIndex = -1 then
  begin
    layAddPaymentBankID.Visible := False;
    layAddPaymentC.Visible := False;
  end
  else
  if eAddPaymentMethod.Selected.Text = 'Transfer' then
  begin
    layAddPaymentBankID.Visible := True;
    layAddPaymentC.Visible := False;
  end
  else
  if eAddPaymentMethod.Selected.Text = 'Cash' then
  begin
    layAddPaymentBankID.Visible := False;
    layAddPaymentC.Visible := True;
  end
  else
  if eAddPaymentMethod.Selected.Text = 'Cheque' then
  begin
    layAddPaymentBankID.Visible := True;
    layAddPaymentC.Visible := True;
  end
  else
  begin
    layAddPaymentBankID.Visible := False;
    layAddPaymentC.Visible := False;
  end;
end;
end;

// Add different options for currencies other than USD
procedure AddPaymentCurrencyChange;
begin
with MainForm do
begin
  layAddPaymentOther.Visible := False;
  layAddPaymentConversion.Visible := False;
  layAddPaymentAmtRecvd.Visible := False;
  if (eAddPaymentCurrency.Selected.Text <> '') and
  (eAddPaymentCurrency.Selected.Text <> 'USD') then
  begin
    if eAddPaymentCurrency.Selected.Text = 'Other' then
    begin
      layAddPaymentOther.Visible := True;
    end;
    layAddPaymentConversion.Visible := True;
    layAddPaymentAmtRecvd.Visible := True;
  end;
end;
end;

// When amount changes set AmtRecvd
procedure AddPaymentAmountChange;
var
  Conversion : Double;
begin
with MainForm do
begin
  if not AddPaymentCurrencyBeingChanged then
  begin
    AddPaymentCurrencyBeingChanged := True;
    Conversion := eAddPaymentConversion.Value;
    if Conversion <> 0 then
    begin
      eAddPaymentAmtRecvd.Value := Conversion * eAddPaymentAmount.Value;
    end;
    AddPaymentCurrencyBeingChanged := False;
  end;
end;
end;

// When AmtRecvd changes set Conversion rate
procedure AddPaymentAmtRecvdChange;
var
  Amount : Double;
  Recvd  : Double;
begin
with MainForm do
begin
  if not AddPaymentCurrencyBeingChanged then
  begin
    AddPaymentCurrencyBeingChanged := True;
    Amount := eAddPaymentAmount.Value;
    Recvd := eAddPaymentAmtRecvd.Value;
    if (Amount <> 0) and (Recvd <> 0) then
    begin
      eAddPaymentConversion.Value := Recvd / Amount;
    end;
    AddPaymentCurrencyBeingChanged := False;
  end;
end;
end;

// When conversion rate changes set AmtRecvd
procedure AddPaymentConversionChange;
var
  Amount : Double;
begin
with MainForm do
begin
  if not AddPaymentCurrencyBeingChanged then
  begin
    AddPaymentCurrencyBeingChanged := True;
    Amount := eAddPaymentAmount.Value;
    if Amount <> 0 then
    begin
      eAddPaymentAmtRecvd.Value := eAddPaymentConversion.Value * Amount;
    end;
    AddPaymentCurrencyBeingChanged := False;
  end;
end;
end;

procedure AddPaymentCancel;
begin
with MainForm do
begin
  ClosePanel(panelAddPayment);
end;
end;

procedure AddPaymentSave;
var
  Payment : TPayment;
  Currency: String;
  Conversion : Double;
  AmtRecvd : Double;
  BankID : Integer;
  BankName : String;
  Error : Boolean;
begin
with MainForm do
begin
  // If there is a problem with the data highlight it and stop
  Error := False;
  lAddPaymentMethod.FontColor := TAlphaColorRec.Black;
  lAddPaymentAmount.FontColor := TAlphaColorRec.Black;
  if eAddPaymentMethod.ItemIndex = -1 then
  begin
    lAddPaymentMethod.FontColor := TAlphaColorRec.Red;
    Error := True;
  end;
  if eAddPaymentAmount.Value < 1 then
  begin
    lAddPaymentAmount.FontColor := TAlphaColorRec.Red;
    Error := True;
  end;

  if Error = False then
  begin
    if layAddPaymentC.Visible = False then
    begin
      Currency := 'USD';
      Conversion := 1;
      AmtRecvd := eAddPaymentAmount.Value;
    end
    else
    begin
      if eAddPaymentCurrency.Selected.Text = 'Other' then
      begin
        Currency := eAddPaymentOther.Text;
      end
      else
      begin
        Currency := eAddPaymentCurrency.Selected.Text;
      end;
      Conversion := eAddPaymentConversion.Value;
      AmtRecvd := eAddPaymentAmtRecvd.Value;
    end;

    if layAddPaymentBankID.Visible = False then
    begin
      BankID := -1;
      BankName := 'Bank not found';
    end
    else
    begin
      BankID := Integer(eAddPaymentBankID.Selected.Data);
      BankName := eAddPaymentBankID.Selected.Text;
    end;

    Payment := TPayment.Create(PayID,
                              StrToInt(lInvNumData.Text),
                              eAddPaymentDate.Date,
                              eAddPaymentAmount.Value,
                              Currency,
                              Conversion,
                              AmtRecvd,
                              eAddPaymentMethod.Selected.Text,
                              eAddPaymentType.Selected.Text,
                              eAddPaymentNote.Text,
                              BankID,
                              BankName);
    if lAddPayment.Text = EditPayment then
    begin
      PaymentController.EditPayment(Payment);
      EditPaymentListBox(Payment);
    end
    else
    begin
      PaymentController.AddPayment(Payment);
      AddPaymentToListBox(Payment);
    end;
    CalculatePaymentsTotal;
    ClosePanel(panelAddPayment);

    // Set Bookings tab to changed
    cbBookingsSave.IsChecked := False;

    // Push changes to database
    BookingsTabView.SaveBooking;
  end;
end;
end;

procedure AddPaymentDelete;
begin
  PaymentController.DeletePayment(PayID);
  MainForm.DeleteFromListBox(MainForm.lbPayments, PayID);
  CalculatePaymentsTotal;
  with MainForm do
  begin
    ClosePanel(PanelAddPayment);
    cbBookingsSave.isChecked := False;

    // Push changes to database
    BookingsTabView.SaveBooking;
  end;
end;


end.
