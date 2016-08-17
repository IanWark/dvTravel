unit Reports;

// Controls previewing and sending reports (Vouchers and Invoices)

interface
uses ClientModuleUnit1, Misc, PDFViewer, classEmailUser,
     FMX.ListBox, Data.FireDACJSONReflect, FireDAC.Comp.Client, SysUtils,
     System.UITypes, System.Classes, IOUtils;

const
  InvoiceTitle = 'Send Invoice';
  VoucherTitle = 'Send Voucher';
  InvoiceMode = 0;
  VoucherMode = 1;

procedure OpenPanel(Mode : Integer);
// Populate lbReports with emails. MainPerson's first email is autoselected.
procedure PopulateListBox(MemTable : TFDMemTable; MainPerson : Integer);
procedure PreparePanel;
procedure PreviewReport;
procedure SendReport;

implementation
uses Main, DataController, BookingsTabView;

// Called in main when bInvoice is clicked
procedure OpenPanel(Mode : Integer);
var
  Problem : Boolean;
begin
  with MainForm do
  begin
    // If Called Date or Depoist Date not set, do not open
    Problem := False;
    if (eCalledDate.Format <> '')  then
    begin
      lCalledDate.FontColor := TAlphaColorRec.Red;
      Problem := True;
    end;
    if (eDepositDate.Format <> '') then
    begin
      lDepositDate.FontColor := TAlphaColorRec.Red;
      Problem := True;
    end;
    if not Problem then
    begin
      try
        if IsConnected then
        begin
          // Do actual stuff
          if Mode = InvoiceMode then
          begin
            lReports.Text := InvoiceTitle;
            layReportsPaypal.Visible := True;
          end
          else
          if Mode = VoucherMode then
          begin
            lReports.Text := VoucherTitle;
            layReportsPaypal.Visible := False;
          end;

          cbReportsPaypal.IsChecked := False;
          OpenPanel(panelReports);
          PreparePanel;

        end
        else
        // If not connected to the internet, do not open
        begin
          Print('Cannot connect to internet.');
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
  end;
end;

// Populate lbReports with emails. MainPerson's first email is autoselected.
procedure PopulateListBox(MemTable : TFDMemtable; MainPerson : Integer);
var
  Item: TListBoxItem;
  MainPersonFirst : Boolean;
begin
  if MainPerson <> 0 then
  begin
    MainPersonFirst := False;
    // MainPerson comes first, and MainPerson's first email is autochecked
    with Memtable do
    begin
      First;
      while not EOF do
      begin
        // If email value not empty add to list
        if (IfNull(FieldByName('Email').Value,'') <> '') and
           (FieldByName('PersonID').Value = MainPerson) then
        begin
          Item := TListBoxItem.Create(MainForm.lbReports);
          Item.Text := FieldByName('Email').Value;
          Item.ItemData.Detail := FieldByName('Email').Value;
          Item.StyleLookup := 'CheckBoxItem';
          if MainPersonFirst = False then
          begin
            Item.IsChecked := True;
            MainPersonFirst:= True;
          end;
          MainForm.lbReports.AddObject(Item);
        end;
        Next;
      end;
    end;
  end;
  // Everything else
  with Memtable do
  begin
    First;
    while not EOF do
    begin
      // If email value not empty add to list
      if (IfNull(FieldByName('Email').Value,'') <> '') and
         (FieldByName('PersonID').Value <> MainPerson) then
      begin
        Item := TListBoxItem.Create(MainForm.lbReports);
        Item.Text := FieldByName('Email').Value;
        Item.ItemData.Detail := FieldByName('Email').Value;
        Item.StyleLookup := 'CheckBoxItem';
        MainForm.lbReports.AddObject(Item);
      end;
      Next;
    end;
  end;
end;

procedure PreparePanel;
var
  MainPerson : Integer;
  LDataSetList : TFDJSONDataSets;
begin
  begin
    // Save changes first so data is consistent
    BookingsTabView.SaveBooking;
    MainForm.lReportsDesc.FontColor := TAlphaColorRec.Black;
    MainForm.lbReports.Clear;

    try
      MainPerson := Integer(MainForm.cbMainPerson.Selected.Data);
    except
      MainPerson := 0;
    end;

    // If current Client is client of booking, get contacts from mtContact
    if BookingsTabView.ClientID = Module.mtClient.FieldByName('ClientID').Value then
    begin
      PopulateListBox(Module.mtContact, MainPerson);
    end
    else
    // Else, get contact list from online
    begin
      Module.mtExtraTable.Close;
      LDataSetList := ClientModule1.ServerMethods1Client.GetContacts(BookingsTabView.ClientID);
      Module.mtExtraTable.AppendData(TFDJSONDataSetsReader.GetListValue(LDataSetList,0));
      Module.mtExtraTable.Open;
      PopulateListBox(Module.mtExtraTable, MainPerson);
    end;
  end;
end;

procedure PreviewReport;
var
  DirName : String;
  FileName : String;
  FileStream : TFileStream;
  URL : String;
begin
  PDFForm.Show;

  if MainForm.lReports.Text = VoucherTitle then
    URL := ClientModule1.ServerMethods1Client.PreviewVoucher(StrToInt(MainForm.lInvNumData.Text))
  else
  if MainForm.lReports.Text = InvoiceTitle then
    URL := ClientModule1.ServerMethods1Client.PreviewInvoice(StrToInt(MainForm.lInvNumData.Text));

  if URL = 'FAIL' then
  begin
    Print('There was an error creating the preview.');
  end
  else
  begin
    PDFForm.Navigate(URL);
  end;
end;

procedure SendReport;
var
  I: Integer;
  EmailList : String;
  ListEmpty : Boolean;
  Success : Boolean;
  EmailName : String;
  EmailUser : TEmailUser;
  BookingID : Integer;
begin
  Success := False;
  MainForm.lReportsDesc.FontColor := TAlphaColorRec.Black;

  if MainForm.lbReports.Count > 0 then
  begin
    ListEmpty := True;
    with MainForm.lbReports do
    begin
      for I := 0 to Count-1 do
      begin
        if ListItems[I].IsChecked then
        begin
          if ListEmpty then
          begin
            EmailList := ListItems[I].Text;
            ListEmpty := False;
          end
          else EmailList := EmailList + ',' + ListItems[I].Text;
        end;
      end;
    end;

    if not ListEmpty then
    begin
      BookingID := StrToInt(MainForm.lInvNumData.Text);
      EmailName := MainForm.eEmailname.Text;
      EmailName := StringReplace(EmailName,' ','^', [rfReplaceAll]);
      EmailUser := TEmailUser.Create(Misc.EmailAddress,EmailName);

      if MainForm.lReports.Text = VoucherTitle then
      Success := ClientModule1.ServerMethods1Client.SendVoucher(EmailList, EmailUser, BookingID)
      else
      if MainForm.lReports.Text = InvoiceTitle then
      begin
        if MainForm.cbReportsReceipt.IsChecked then
          Success := ClientModule1.ServerMethods1Client.SendInvoice(3, EmailList, EmailUser, BookingID)
        else if MainForm.cbReportsPaypal.IsChecked then
          Success := ClientModule1.ServerMethods1Client.SendInvoice(2, EmailList, EmailUser, BookingID)
        else
          Success := ClientModule1.ServerMethods1Client.SendInvoice(1, EmailList, EmailUser, BookingID);
      end;

      if Success then
      begin
        if MainForm.lReports.Text = VoucherTitle then
        begin
          MainForm.eVoucherDate.Date := Date;
          MainForm.eVoucherDate.Format := '';
          MainForm.cbBookingsSave.IsChecked := False;
        end
        else
        if MainForm.lReports.Text = InvoiceTitle then
        begin
          MainForm.eInvoiceDate.Date := Date;
          MainForm.eInvoiceDate.Format := '';
          MainForm.cbBookingsSave.IsChecked := False;
        end;
        // Save new date
        Print('Email Sent!');
        BookingsTabView.SaveBooking;
        MainForm.ClosePanel(MainForm.panelReports);
      end
      else
      begin
        MainForm.Print('Sending Email failed.');
      end;
    end
    else MainForm.lReportsDesc.FontColor := TAlphaColorRec.Red;
  end
  else MainForm.lReportsDesc.FontColor := TAlphaColorRec.Red;;
end;

end.
