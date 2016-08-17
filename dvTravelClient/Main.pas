unit Main;

// A few common view based functions as well as the start up method
// Mainly holds all the components and controls
// and redirects on events to the different files

interface

uses
  classBooking, classResultsArray, classCalendarItem, Misc,
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.TabControl,
  FMX.StdCtrls, FMX.Gestures, FMX.Calendar, FMX.Controls.Presentation,
  FMX.ListBox, FMX.Layouts, FMX.Edit, FMX.TMSBaseControl, FMX.TMSPlannerBase,
  FMX.TMSPlannerData, FMX.TMSPlanner, FMX.Objects, FMX.DateTimeCtrls,
  FMX.EditBox, FMX.NumberBox, FMX.Menus, FMX.Ani,
  FMX.TMSDateTimeEdit, FMX.ScrollBox, FMX.Memo, FMX.TMSHTMLText;

type
  TMainForm = class(TForm)
    HeaderToolBar: TToolBar;
    ToolBarLabel: TLabel;
    TabControl1: TTabControl;
    tHome: TTabItem;
    tBookings: TTabItem;
    tClients: TTabItem;
    tCalendar: TTabItem;
    Calendar: TCalendar;
    lRecentBookings: TLabel;
    layHomeRight: TLayout;
    lbRecentBookings: TListBox;
    Planner: TTMSFMXPlanner;
    lbPayments: TListBox;
    lPayments: TLabel;
    layBookingsRental: TLayout;
    bPayments: TButton;
    lbRental: TListBox;
    lRental: TLabel;
    lRentalTotalTitle: TLabel;
    lRentalTotalData: TLabel;
    bRental: TButton;
    layBookingsPayment: TLayout;
    layBookingsTravel: TLayout;
    lPaymentNotes: TLabel;
    lRentalNotes: TLabel;
    layBookings1: TLayout;
    bVoucher: TButton;
    bInvoice: TButton;
    bBookingsCalendar: TButton;
    rectPayments: TRectangle;
    rectRental: TRectangle;
    lineRentalTotal: TLine;
    lineRentalLabel: TLine;
    linePaymentsTotal: TLine;
    linePaymentsLabel: TLine;
    lTravel: TLabel;
    rectPaymentNotes: TRectangle;
    rectRentalNotes: TRectangle;
    rectTravel: TRectangle;
    layBookingsBottomRight: TLayout;
    layBookingsDates: TLayout;
    eInvoiceDate: TDateEdit;
    eVoucherDate: TDateEdit;
    layBookingsRentalLeft: TLayout;
    layBookingsRentalRight: TLayout;
    layBookingsPaymentsLeft: TLayout;
    layBookingsPaymentsRight: TLayout;
    rectInv: TRectangle;
    lInvNumTitle: TLabel;
    layInvNum: TLayout;
    layCreatedBy: TLayout;
    rectBookingsClient: TRectangle;
    eBookingsStatus: TComboBox;
    lbiQuote: TListBoxItem;
    lbiBooking: TListBoxItem;
    layBookings1Right: TLayout;
    layBookingsStatus: TLayout;
    lBookingsStatus: TLabel;
    layCalledDate: TLayout;
    lCalledDate: TLabel;
    eCalledDate: TDateEdit;
    layBalanceDate: TLayout;
    lDepositDate: TLabel;
    eDepositDate: TDateEdit;
    layBookings1Left: TLayout;
    lineTravelLabel: TLine;
    lineTravelTotal: TLine;
    bTravel: TButton;
    lbTravel: TListBox;
    rectRecentBookings: TRectangle;
    lineRecentBookings: TLine;
    layPaymentsNotesTop: TLayout;
    layRentalNotesTop: TLayout;
    lbiCancelled: TListBoxItem;
    lInvNumData: TLabel;
    layBookingsClient1: TLayout;
    layBookingsClient: TLayout;
    layBookingsClient2: TLayout;
    lBookingsClient: TLabel;
    lMainPerson: TLabel;
    rectClientNotes: TRectangle;
    layPeople: TLayout;
    rectPeople: TRectangle;
    lbPeople: TListBox;
    linePeopleBottom: TLine;
    bPeople: TButton;
    linePeopleTop: TLine;
    lPeople: TLabel;
    layClients1: TLayout;
    layClients2: TLayout;
    layClientsBookings: TLayout;
    rectClientsBookings: TRectangle;
    lbClientsBookings: TListBox;
    lineBookingsClientsBottom: TLine;
    bClientsBookings: TButton;
    lClientsOutstandingData: TLabel;
    lClientsOutstandingTitle: TLabel;
    lineClientsBookingsTop: TLine;
    lClientsBookingsTitle: TLabel;
    rectAddress: TRectangle;
    eAddress: TEdit;
    layAddress: TLayout;
    layAddressBottom: TLayout;
    lAddress: TLabel;
    eCity: TEdit;
    lCity: TLabel;
    layCity: TLayout;
    layCountry: TLayout;
    eCountry: TEdit;
    lCountry: TLabel;
    layProv: TLayout;
    eProv: TEdit;
    lProv: TLabel;
    layAddressTop: TLayout;
    layPostal: TLayout;
    ePostal: TEdit;
    lPostal: TLabel;
    layClients1Right: TLayout;
    layClientsBottom: TLayout;
    bClientNew: TButton;
    bBookingsSave: TButton;
    cbBookingsSave: TCheckBox;
    lineAddressTitle: TLine;
    lAddressTitle: TLabel;
    bClientSave: TButton;
    lClientNotesTitle: TLabel;
    layClientNotesTop: TLayout;
    layDateEntered: TLayout;
    lDateEntered: TLabel;
    eDateEntered: TDateEdit;
    bSearch: TButton;
    bSettings: TButton;
    lBookingsOutstandingTitle: TLabel;
    layBookingsOutstanding: TLayout;
    lBookingsOutstandingData: TLabel;
    HomeImage: TImage;
    rectUpcomingDeposits: TRectangle;
    lbUpcomingDeposits: TListBox;
    lineUpcomingDeposits: TLine;
    lUpcomingArrivals: TLabel;
    rectRecentClients: TRectangle;
    lbRecentClients: TListBox;
    lineRecentClients: TLine;
    lRecentClients: TLabel;
    panelAddPayment: TPanel;
    lAddPayment: TLabel;
    layAddPaymentMethod: TLayout;
    layCenter: TLayout;
    rectDim: TRectangle;
    eAddPaymentMethod: TComboBox;
    lAddPaymentMethod: TLabel;
    Cash: TListBoxItem;
    Cheque: TListBoxItem;
    Paypal: TListBoxItem;
    Transfer: TListBoxItem;
    layAddPaymentAmount: TLayout;
    lAddPaymentAmount: TLabel;
    layAddPaymentCurrency: TLayout;
    lAddPaymentCurrency: TLabel;
    layAddPaymentType: TLayout;
    lAddPaymentType: TLabel;
    layAddPaymentBottom: TLayout;
    bAddPaymentCancel: TButton;
    bAddPaymentSave: TButton;
    eAddPaymentAmount: TNumberBox;
    panelAddRental: TPanel;
    lAddRental: TLabel;
    layAddRentalCasa: TLayout;
    eAddRentalCasa: TComboBox;
    Casa2: TListBoxItem;
    Casa3: TListBoxItem;
    Casa4: TListBoxItem;
    Casa5: TListBoxItem;
    lAddRentalCasa: TLabel;
    layAddRentalRate: TLayout;
    lAddRentalRate: TLabel;
    eAddRentalRate: TNumberBox;
    layAddRentalOccupants: TLayout;
    lAddRentalOccupants: TLabel;
    layAddRentalDates: TLayout;
    lAddRentalDates: TLabel;
    layAddRentalBottom: TLayout;
    bAddRentalCancel: TButton;
    bAddRentalSave: TButton;
    layAddRentalTo: TLayout;
    lAddRentalTo: TLabel;
    layAddRentalCharges: TLayout;
    lAddRentalCharges: TLabel;
    eAddRentalOccupants: TNumberBox;
    eAddRentalTo: TDateEdit;
    eAddRentalFrom: TDateEdit;
    Casa6: TListBoxItem;
    Casa7: TListBoxItem;
    CasaAll: TListBoxItem;
    panelAddTravel: TPanel;
    lAddTravel: TLabel;
    layAddTravelMethod: TLayout;
    eAddTravelMethod: TComboBox;
    Other: TListBoxItem;
    Car: TListBoxItem;
    lAddTravelMethod: TLabel;
    layAddTravelNotes: TLayout;
    lAddTravelNotes: TLabel;
    layAddTravelFlight: TLayout;
    lAddTravelFlight: TLabel;
    layAddTravelDate: TLayout;
    lAddTravelDate: TLabel;
    eAddTravelDate: TDateEdit;
    layAddTravelBottom: TLayout;
    bAddTravelCancel: TButton;
    bAddTravelSave: TButton;
    layAddTravelTime: TLayout;
    lAddTravelTime: TLabel;
    panelAddPerson: TPanel;
    lAddPerson: TLabel;
    layAddPersonLastName: TLayout;
    lAddPersonLastName: TLabel;
    layAddPersonFirstName: TLayout;
    lAddPersonFirstName: TLabel;
    layAddPersonBottom: TLayout;
    bAddPersonCancel: TButton;
    bAddPersonSave: TButton;
    eAddPersonLastName: TEdit;
    eAddPersonFirstName: TEdit;
    layContact: TLayout;
    lbContact: TListBox;
    layContactType: TLayout;
    lContactType: TLabel;
    eContactType: TEdit;
    layContactEmail: TLayout;
    lContactEmail: TLabel;
    eContactEmail: TEdit;
    layContactPhone: TLayout;
    lContactPhone: TLabel;
    layContactButton: TLayout;
    bContact: TButton;
    eAddTravelTime: TTimeEdit;
    eAddTravelNotes: TEdit;
    eAddTravelFlight: TEdit;
    layAddTravelOtherDesc: TLayout;
    lAddTravelOtherDesc: TLabel;
    eAddTravelOtherDesc: TEdit;
    Air: TListBoxItem;
    layAddPaymentDate: TLayout;
    lAddPaymentDate: TLabel;
    eAddPaymentDate: TDateEdit;
    eAddPaymentType: TComboBox;
    Deposit: TListBoxItem;
    OnArrival: TListBoxItem;
    TypeOther: TListBoxItem;
    layAddPersonNotes: TLayout;
    lAddPersonNotes: TLabel;
    eAddPersonNotes: TEdit;
    lContact: TLabel;
    eAddPaymentCurrency: TComboBox;
    USD: TListBoxItem;
    Pesos: TListBoxItem;
    PaymentOther: TListBoxItem;
    layAddPaymentOther: TLayout;
    lAddPaymentOther: TLabel;
    eAddPaymentOther: TEdit;
    eContactPhone: TEdit;
    Layout1: TLayout;
    Layout2: TLayout;
    eSearch: TEdit;
    laySearch: TLayout;
    lbSearchResults: TListBox;
    rectTrans: TRectangle;
    layHomeImage: TLayout;
    layBookingsButtons: TLayout;
    layCalendarBar: TLayout;
    layCalendar: TLayout;
    eRentalCurrency: TComboBox;
    eDeposit: TNumberBox;
    lBookingsClientID: TLabel;
    cbClientActive: TCheckBox;
    ListBoxItem6: TListBoxItem;
    ListBoxItem7: TListBoxItem;
    ListBoxItem8: TListBoxItem;
    lDeposit: TLabel;
    layDeposit: TLayout;
    layRentalCurrency: TLayout;
    lRentalCurrency: TLabel;
    layAddPaymentNote: TLayout;
    lAddPaymentNote: TLabel;
    eAddPaymentNote: TEdit;
    layAddPaymentBankID: TLayout;
    lAddPaymentBankID: TLabel;
    eAddPaymentBankID: TComboBox;
    ListBoxItem9: TListBoxItem;
    ListBoxItem12: TListBoxItem;
    ListBoxItem13: TListBoxItem;
    layAddPaymentConversion: TLayout;
    lAddPaymentConversion: TLabel;
    eAddPaymentConversion: TNumberBox;
    layAddPaymentAmtRecvd: TLayout;
    lAddPaymentAmtRecvd: TLabel;
    eAddPaymentAmtRecvd: TNumberBox;
    layAddPaymentMethodMaster: TLayout;
    layAddPaymentCurrencyMaster: TLayout;
    layAddPaymentC: TLayout;
    layAddPaymentCurr3: TLayout;
    layAddPaymentCurr2: TLayout;
    eAddRentalCharges: TNumberBox;
    layAddRentalComment: TLayout;
    lAddRentalComment: TLabel;
    eAddRentalComment: TEdit;
    ePaymentNotes: TMemo;
    eRentalNotes: TMemo;
    cbClientsSave: TCheckBox;
    layClientsButtons: TLayout;
    layAddRentalError: TLayout;
    lAddRentalError: TLabel;
    eClientNotes: TMemo;
    bAddPersonDelete: TButton;
    bAddRentalDelete: TButton;
    bAddTravelDelete: TButton;
    bAddPaymentDelete: TButton;
    StyleBook1: TStyleBook;
    panelSearchMore: TPanel;
    lSearchMore: TLabel;
    lSearchString: TLabel;
    lbSearchMore: TListBox;
    laySearchMoreBottom: TLayout;
    bSearchMoreCancel: TButton;
    cbMainPerson: TComboBox;
    panelSelectPeople: TPanel;
    lSelectPeople: TLabel;
    laySelectPeopleButtons: TLayout;
    bSelectPeopleCancel: TButton;
    bSelectPeopleSave: TButton;
    layMainPerson: TLayout;
    panelReports: TPanel;
    lReports: TLabel;
    layReportsButtons: TLayout;
    bReportsCancel: TButton;
    bReportsSend: TButton;
    bReportsPreview: TButton;
    lbReports: TListBox;
    bSelectPeople: TButton;
    lReportsDesc: TLabel;
    lbSelectPeople: TListBox;
    TBA: TListBoxItem;
    cbReportsPaypal: TCheckBox;
    layReportsBottom: TLayout;
    lReportsPaypal: TLabel;
    layReportsPaypal: TLayout;
    panelSettings: TPanel;
    lSettings: TLabel;
    layHeight: TLayout;
    lHeight: TLabel;
    layNames: TLayout;
    lEmailname: TLabel;
    eEmailname: TEdit;
    laySettingsButtons: TLayout;
    bSettingsSave: TButton;
    eHeight: TNumberBox;
    layDimensions: TLayout;
    layWidth: TLayout;
    lWidth: TLabel;
    eWidth: TNumberBox;
    lDimensions: TLabel;
    layEmailname: TLayout;
    lCreatedByTitle: TLabel;
    lCreatedByData: TLabel;
    Bus: TListBoxItem;
    bRefreshHome: TButton;
    layHomeRightTop: TLayout;
    cbReportsReceipt: TCheckBox;
    lReportsReceipt: TLabel;
    layAddRentalDiscount: TLayout;
    layDiscountDesc: TLayout;
    lDiscountDesc: TLabel;
    layDiscountAmt: TLayout;
    lDiscountAmt: TLabel;
    eDiscountAmt: TNumberBox;
    eDiscountDesc: TEdit;
    layAddRentalTotal: TLayout;
    lAddRentalTotal: TLabel;
    eAddRentalTotal: TLabel;
    layCalendarExport: TLayout;
    eCalendarEmail: TEdit;
    bCalendarExport: TButton;
    rectBookingsSave: TRectangle;
    layBookingsSaveCB: TLayout;
    layClientsCheckBox: TLayout;
    rectClientsSave: TRectangle;
    lCalendarEmail: TLabel;
    lCalendarExport: TLabel;
    eCalendarMessage: TMemo;
    lCalendarMessage: TLabel;
    circleOnlineStatus: TCircle;
    layoutRentalTotal: TLayout;
    lRentalDollarSign: TLabel;
    layPaymentTotal: TLayout;
    lPaymentTotalData: TLabel;
    lPaymentTotalTitle: TLabel;
    lPaymentDollarSign: TLabel;
    rectNoBookingSet: TRectangle;
    lNoBookingSet: TLabel;
    rectNoClientSet: TRectangle;
    lNoClientSet: TLabel;
    layResetTables: TLayout;
    bResetAccoms: TButton;
    bResetBanks: TButton;
    Layout3: TLayout;
    lBookingsOutstandingDollarSign: TLabel;
    lineAddRentalDates: TLine;

    procedure FormCreate(Sender: TObject);
    // The real create because you cannot do connect to server on FormCreate
    procedure FormActivate(Sender: TObject);
    procedure Print(str : String);
    procedure FormResize(Sender: TObject);

    // OTHER \\
    // Deletes item with ID from ListBox
    procedure DeleteFromListBox(ListBox : TListBox; ID : Integer);
    procedure DateChange(Sender: TObject);

    // Opens a panel and creates a dark background (rectDim)
    // that when clicked cancels out of panel
    procedure OpenPanel(Panel : TPanel);
    // Closes panel and rectDim
    procedure ClosePanel(Panel : TPanel);
    // Cancels changes and closes all panels
    procedure rectDimClick(Sender: TObject);
    // Closes search results
    procedure rectTransClick(Sender: TObject);

    // The majority of the methods here just handle events and redirect to the
    // other files - for an explaination go to right after rectTransClick
    // (approx line 700 (!))

    // BOOKINGS \\
    procedure BookingsDateChange(Sender: TObject);
    procedure BookingsChange(Sender: TObject);
    procedure bSelectPeopleClick(Sender: TObject);
    procedure bSelectPeopleCancelClick(Sender: TObject);
    procedure bSelectPeopleSaveClick(Sender: TObject);
    procedure cbBookingsSaveChange(Sender: TObject);

    // Rental
    procedure eAddRentalRateChange(Sender: TObject);
    procedure eAddRentalChargesChange(Sender: TObject);
    procedure eDiscountAmtChange(Sender: TObject);
    procedure eAddRentalDateChange(Sender: TObject);
    procedure lbRentalItemClick(const Sender: TCustomListBox;
      const Item: TListBoxItem);
    procedure bRentalClick(Sender: TObject);
    procedure bAddRentalCancelClick(Sender: TObject);
    procedure bAddRentalDeleteClick(Sender: TObject);
    procedure bAddRentalSaveClick(Sender: TObject);

    // Payments
    procedure eAddPaymentMethodChange(Sender: TObject);
    procedure eAddPaymentCurrencyChange(Sender: TObject);
    procedure eAddPaymentAmountChange(Sender: TObject);
    procedure eAddPaymentAmtRecvdChange(Sender: TObject);
    procedure eAddPaymentConversionChange(Sender: TObject);
    procedure lbPaymentsItemClick(const Sender: TCustomListBox;
      const Item: TListBoxItem);
    procedure bPaymentsClick(Sender: TObject);
    procedure bAddPaymentCancelClick(Sender: TObject);
    procedure bAddPaymentSaveClick(Sender: TObject);

    // Travel
    procedure eAddTravelMethodChange(Sender: TObject);
    procedure lbTravelItemClick(const Sender: TCustomListBox;
      const Item: TListBoxItem);
    procedure bTravelClick(Sender: TObject);
    procedure bAddTravelCancelClick(Sender: TObject);
    procedure bAddTravelDeleteClick(Sender: TObject);
    procedure bAddTravelSaveClick(Sender: TObject);
    procedure bBookingsClientClick(Sender: TObject);
    procedure bBookingsSaveClick(Sender: TObject);

    // CLIENTS \\
    procedure ClientsChange(Sender: TObject);
    // People
    procedure lbPeopleItemClick(const Sender: TCustomListBox;
      const Item: TListBoxItem);
    procedure bPeopleClick(Sender: TObject);
    procedure bAddPersonCancelClick(Sender: TObject);
    procedure bAddPersonDeleteClick(Sender: TObject);
    procedure bAddPersonSaveClick(Sender: TObject);
    procedure bContactClick(Sender: TObject);
    procedure lbClientsBookingsItemClick(const Sender: TCustomListBox;
      const Item: TListBoxItem);
    procedure bClientsBookingsClick(Sender: TObject);
    procedure bClientSaveClick(Sender: TObject);

    procedure bAddPaymentDeleteClick(Sender: TObject);
    procedure lbContactItemClick(const Sender: TCustomListBox;
      const Item: TListBoxItem);
    procedure bClientNewClick(Sender: TObject);
    procedure cbClientsSaveChange(Sender: TObject);

    // Search
    procedure bSearchClick(Sender: TObject);
    procedure eSearchKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
    procedure lbSearchMoreItemClick(const Sender: TCustomListBox;
      const Item: TListBoxItem);
    procedure lbSearchResultsItemClick(const Sender: TCustomListBox;
      const Item: TListBoxItem);
    procedure bSearchMoreCancelClick(Sender: TObject);

    // Calendar
    procedure CalendarChange(Sender: TObject);
    procedure PlannerBeforeSelectItem(Sender: TObject;
      AItem: TTMSFMXPlannerItem; var ACanSelect: Boolean);
    procedure PlannerAfterSelectItem(Sender: TObject;
      AItem: TTMSFMXPlannerItem);
    procedure bBookingsCalendarClick(Sender: TObject);
    procedure bCalendarExportClick(Sender: TObject);

    // Reports
    procedure bVoucherClick(Sender: TObject);
    procedure bInvoiceClick(Sender: TObject);
    procedure bReportsCancelClick(Sender: TObject);
    procedure bReportsPreviewClick(Sender: TObject);
    procedure bReportsSendClick(Sender: TObject);
    procedure cbReportsReceiptChange(Sender: TObject);

    // Settings
    procedure bSettingsClick(Sender: TObject);
    procedure bSettingsSaveClick(Sender: TObject);
    procedure eWidthChange(Sender: TObject);
    procedure eHeightChange(Sender: TObject);
    procedure bResetAccomsClick(Sender: TObject);
    procedure bResetBanksClick(Sender: TObject);

    // Home
    // Upcoming due deposits and Recent Bookings
    procedure lbHomeBookingItemClick(const Sender: TCustomListBox; const Item: TListBoxItem);
    // Recent Clients
    procedure lbHomeClientItemClick(const Sender: TCustomListBox; const Item: TListBoxItem);
    procedure bRefreshHomeClick(Sender: TObject);

  private
  public
    { Public declarations }
    // Sets date to not appear null if it changes
    procedure SetDateFormat(Sender : TObject);
  end;

var
  MainForm: TMainForm;
  OneTimeStartUp: Boolean;

implementation

uses ResizeForm,
     Search, Reports, SelectPeople, Settings, Home,
     BookingsTabController, RentalController, PaymentController,
     BookingsTabView, RentalView, PaymentView, TravelView,
     ClientsTabView, PersonView, BookingView,
     CalendarController, CalendarView, DataController,
     ClientsTabController, DateUtils, PDFViewer;

{$R *.fmx}

// Sets date to not appear null if it changes
procedure TMainForm.SetDateFormat(Sender : TObject);
var
  DateEdit : TDateEdit;
begin
  DateEdit := Sender as TDateEdit;
  if DateEdit.Date = NullDate then
  begin
    DateEdit.Format := ' ';
  end
  else
  begin
    DateEdit.Format := '';
  end;
end;

// Form \\

procedure TMainForm.FormCreate(Sender: TObject);
begin
  OneTimeStartUp := True;
end;

// The real create because you cannot do connect to server on FormCreate
procedure TMainForm.FormActivate(Sender: TObject);
var
  Booking : TBooking;
begin
  if OneTimeStartUp then
  begin
    // Load this device's settings
    Settings.LoadSettings;

    // Set Calendar tab
    Calendar.Date := Date;
    CalendarView.CalendarChange(Calendar.Date);

    lNoBookingSet.Text := 'No Booking Currently Set' + sLineBreak + sLineBreak +
                          'Select a Booking in Clients or Calendar Tab';
    lNoClientSet.Text := 'No Client Currently Set' + sLineBreak + sLineBreak +
                         'To Set a Client either:' + sLineBreak +
                         'Use the Search bar to find Clients,' + sLineBreak +
                         'Select a Booking in the Calendar Tab,' + sLineBreak +
                         'or Add a new Client';

    // If connected to internet, connect to server and get data
    try
      if IsConnected then
      begin

        // Get data for the bank and accoms lists
        PaymentController.SetBankTable;
        RentalController.SetAccomTable;

        // Sets active booking to the booking with the latest ID,
        // and sets active client to that booking's client
        //Booking := BookingsTabController.GetBookingByID(BookingsTabController.LastBookingID);
        //if Booking <> nil then BookingsTabController.SetEditBookingItem(Booking);

        // Set home listboxes (must be after settings because it uses height/width)
        Home.SetHomeTab;
      end;
    except
      on E : Exception do
      begin
        MainForm.circleOnlineStatus.Fill.Color := TAlphaColorRec.Red;
        Print('ERROR: ' + E.ClassName + sLineBreak + E.Message);
      end;
    end;

    OneTimeStartUp := False;
  end;
end;

procedure TMainForm.Print(str: string);
begin
  ShowMessage(str);
end;

procedure TMainForm.FormResize(Sender: TObject);
begin
  if (Width < 900) then
  begin
    ResizeForm.Portrait;
  end
  else
  begin
    ResizeForm.Landscape;
  end;
end;

// Other \\
// Deletes item with ID from ListBox
procedure TMainForm.DeleteFromListBox(ListBox: TListBox; ID: Integer);
var
  I : Integer;
begin
  with ListBox do
  begin
    I := Items.IndexOf(ID.ToString);
    ListItems[I].Free;
  end;
end;

procedure TMainForm.DateChange(Sender: TObject);
begin
  SetDateFormat(Sender);
end;

// Opens a panel and creates a dark background (rectDim)
// that when clicked cancels out of panel
procedure TMainForm.OpenPanel(Panel : TPanel);
begin
  rectDim.Visible := True;
  Panel.Visible   := True;
  rectDim.BringToFront;
  layCenter.BringToFront;
end;

// Closes panel and rectDim
procedure TMainForm.ClosePanel(Panel : TPanel);
begin
  rectDim.Visible := False;
  Panel.Visible   := False;
end;

// Cancels changes and closes all panels
procedure TMainForm.rectDimClick(Sender: TObject);
begin
  panelSettings.Visible := False;
  panelAddRental.Visible := False;
  panelAddPayment.Visible:= False;
  panelAddTravel.Visible := False;
  panelAddPerson.Visible := False;
  panelSearchMore.Visible:= False;
  SelectPeople.CancelChanges;
  panelReports.Visible := False;
  rectDim.Visible := False;
end;

// Closes search results
procedure TMainForm.rectTransClick(Sender: TObject);
begin
  lbSearchResults.Visible := False;
  rectTrans.Visible := False;
  eSearch.Text := '';
end;

// In an attempt to break up the previously massive file, this section mainly
// handles the different events and then calls the corresponding function from
// the other files (BookingsView, ClientsView, etc.). Even then, this file and
// the others are still fairly large.

// Really those other tab should be their own forms which then can apparently
// be put inside of a certain component that holds a form.
// Then each tab would have one of these so that the components (layClients, etc.)
// aren't in the same massive form, but I didn't know you could do that until too late
// and it is not worth doing such a massive refactoring

// BookingsView \\

procedure TMainForm.BookingsDateChange(Sender: TObject);
begin
  SetDateFormat(Sender);
  // Set Bookings tab to changed
  cbBookingsSave.IsChecked := False;
end;

procedure TMainForm.BookingsChange(Sender: TObject);
begin
  // Set Bookings tab to changed
  cbBookingsSave.IsChecked := False;
end;

procedure TMainForm.bSelectPeopleClick(Sender: TObject);
begin
  SelectPeople.OpenPanel;
end;

procedure TMainForm.bSelectPeopleCancelClick(Sender: TObject);
begin
  SelectPeople.CancelChanges;
end;

procedure TMainForm.bSelectPeopleSaveClick(Sender: TObject);
begin
  SelectPeople.SaveChanges;
end;

procedure TMainForm.cbBookingsSaveChange(Sender: TObject);
begin
  if not cbBookingsSave.IsChecked then RectBookingsSave.Visible := True
  else RectBookingsSave.Visible := False;
end;

// RENTAL
procedure TMainForm.eAddRentalRateChange(Sender: TObject);
begin
  RentalView.RateChange;
end;

procedure TMainForm.eAddRentalChargesChange(Sender: TObject);
begin
  RentalView.ChargesChange;
end;

procedure TMainForm.eDiscountAmtChange(Sender: TObject);
begin
  RentalView.DiscountChange;
end;

procedure TMainForm.eAddRentalDateChange(Sender: TObject);
var
  Rate : Single;
  Total: Single;
begin
  Rate := eAddRentalRate.Value;
  Total:= eAddRentalCharges.Value;

  if (Rate = 0) AND (Total = 0) then
  begin
    // Do Nothing
  end
  else
  if (Rate = 0) then
  begin
    RentalView.ChargesChange;
  end
  else
  begin
    RentalView.RateChange;
  end;
end;

procedure TMainForm.lbRentalItemClick(const Sender: TCustomListBox;
  const Item: TListBoxItem);
begin
  RentalView.SetEditRentalItem(Item);
end;

procedure TMainForm.bRentalClick(Sender: TObject);
begin
  RentalView.SetAddNewRental;
end;

procedure TMainForm.bAddRentalCancelClick(Sender: TObject);
begin
  RentalView.AddRentalCancel;
end;

procedure TMainForm.bAddRentalDeleteClick(Sender: TObject);
begin
  RentalView.AddRentalDelete;
end;

procedure TMainForm.bAddRentalSaveClick(Sender: TObject);
begin
  RentalView.AddRentalSave;
end;

// PAYMENT
procedure TMainForm.eAddPaymentCurrencyChange(Sender: TObject);
begin
  PaymentView.AddPaymentCurrencyChange;
end;

procedure TMainForm.eAddPaymentMethodChange(Sender: TObject);
begin
  PaymentView.AddPaymentMethodChange;
end;

procedure TMainForm.eAddPaymentAmountChange(Sender: TObject);
begin
  PaymentView.AddPaymentAmountChange;
end;

procedure TMainForm.eAddPaymentAmtRecvdChange(Sender: TObject);
begin
  PaymentView.AddPaymentAmtRecvdChange;
end;

procedure TMainForm.eAddPaymentConversionChange(Sender: TObject);
begin
  PaymentView.AddPaymentConversionChange;
end;

procedure TMainForm.lbPaymentsItemClick(const Sender: TCustomListBox;
  const Item: TListBoxItem);
begin
  PaymentView.SetEditPaymentItem(Item);
end;

procedure TMainForm.bPaymentsClick(Sender: TObject);
begin
  PaymentView.SetAddNewPayment;
end;

procedure TMainForm.bAddPaymentCancelClick(Sender: TObject);
begin
  PaymentView.AddPaymentCancel;
end;

procedure TMainForm.bAddPaymentDeleteClick(Sender: TObject);
begin
  PaymentView.AddPaymentDelete;
end;

procedure TMainForm.bAddPaymentSaveClick(Sender: TObject);
begin
  PaymentView.AddPaymentSave;
end;

// TRAVEL
procedure TMainForm.eAddTravelMethodChange(Sender: TObject);
begin
  TravelView.AddTravelMethodChange;
end;

procedure TMainForm.lbTravelItemClick(const Sender: TCustomListBox;
  const Item: TListBoxItem);
begin
  TravelView.SetEditTravelItem(Item);
end;

procedure TMainForm.bTravelClick(Sender: TObject);
begin
  TravelView.SetAddNewTravel;
end;

procedure TMainForm.bAddTravelCancelClick(Sender: TObject);
begin
  TravelView.AddTravelCancel;
end;

procedure TMainForm.bAddTravelDeleteClick(Sender: TObject);
begin
  TravelView.AddTravelDelete;
end;

procedure TMainForm.bAddTravelSaveClick(Sender: TObject);
begin
  TravelView.AddTravelSave;
end;

// OTHER
procedure TMainForm.bBookingsClientClick(Sender: TObject);
begin
  // Set Bookings tab to changed
  cbBookingsSave.IsChecked := False;
end;

procedure TMainForm.bBookingsSaveClick(Sender: TObject);
begin
  BookingsTabView.SaveBooking;
end;

// ClientsView \\
procedure TMainForm.ClientsChange(Sender: TObject);
begin
  ClientsTabController.ClientChanged := True;
  cbClientsSave.IsChecked := False;
end;

// PEOPLE
procedure TMainForm.lbPeopleItemClick(const Sender: TCustomListBox;
  const Item: TListBoxItem);
begin
  if Item.Data.ClassName = 'TPerson' then
  begin
    PersonView.SetEditPersonItem(Item);
  end;
end;

procedure TMainForm.bPeopleClick(Sender: TObject);
begin
  PersonView.SetAddNewPerson;
end;

procedure TMainForm.bAddPersonCancelClick(Sender: TObject);
begin
  PersonView.AddPersonCancel;
end;

procedure TMainForm.bAddPersonDeleteClick(Sender: TObject);
begin
  PersonView.AddPersonDelete;
end;

procedure TMainForm.bAddPersonSaveClick(Sender: TObject);
begin
  PersonView.AddPersonSave;
end;

procedure TMainForm.bContactClick(Sender: TObject);
begin
  PersonView.AddNewContact;
end;

procedure TMainForm.lbClientsBookingsItemClick(const Sender: TCustomListBox;
  const Item: TListBoxItem);
begin
  BookingView.SelectBooking(Item);
end;

procedure TMainForm.lbContactItemClick(const Sender: TCustomListBox;
  const Item: TListBoxItem);
begin
  PersonView.AddPersonRemoveContact(Item);
end;

procedure TMainForm.bClientsBookingsClick(Sender: TObject);
begin
  BookingView.NewBooking;
end;

procedure TMainForm.bClientNewClick(Sender: TObject);
begin
  ClientsTabView.SetAddNewClient;
end;

procedure TMainForm.bClientSaveClick(Sender: TObject);
begin
  ClientsTabView.ClientSave;
end;

procedure TMainForm.cbClientsSaveChange(Sender: TObject);
begin
  if not cbClientsSave.IsChecked then rectClientsSave.Visible := True
  else rectClientsSave.Visible := False;
  rectClientsSave.BringToFront;
end;

// Search

procedure TMainForm.bSearchClick(Sender: TObject);
begin
  Search.SearchButtonClick;
end;

// Press enter on search bar to search instead of pressing button
procedure TMainForm.eSearchKeyDown(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  if Key = 13 then Search.SearchButtonClick;
end;

procedure TMainForm.lbSearchMoreItemClick(const Sender: TCustomListBox;
  const Item: TListBoxItem);
begin
  Search.ItemClick(Item);
end;

procedure TMainForm.lbSearchResultsItemClick(const Sender: TCustomListBox;
  const Item: TListBoxItem);
begin
  Search.ItemClick(Item);
end;

procedure TMainForm.bSearchMoreCancelClick(Sender: TObject);
begin
  ClosePanel(panelSearchMore);
end;

// Calendar

procedure TMainForm.CalendarChange(Sender: TObject);
begin
  CalendarView.CalendarChange(Calendar.Date);
end;

procedure TMainForm.PlannerBeforeSelectItem(Sender: TObject;
  AItem: TTMSFMXPlannerItem; var ACanSelect: Boolean);
begin
  CalendarController.ItemClick((AItem.DataObject as TCalendarItem).BookID);
end;

procedure TMainForm.PlannerAfterSelectItem(Sender: TObject;
  AItem: TTMSFMXPlannerItem);
begin
  CalendarView.AfterSelect;
end;

procedure TMainForm.bBookingsCalendarClick(Sender: TObject);
begin
  CalendarView.BookingsCalendarClick;
end;

procedure TMainForm.bCalendarExportClick(Sender: TObject);
begin
  CalendarView.ExportCalendar;
end;

// Reports
procedure TMainForm.bVoucherClick(Sender: TObject);
begin
  Reports.OpenPanel(VoucherMode);
end;

procedure TMainForm.bInvoiceClick(Sender: TObject);
begin
  Reports.OpenPanel(InvoiceMode);
end;

procedure TMainForm.bReportsCancelClick(Sender: TObject);
begin
  ClosePanel(panelReports);
end;

procedure TMainForm.bReportsPreviewClick(Sender: TObject);
begin
  Reports.PreviewReport;
end;

procedure TMainForm.bReportsSendClick(Sender: TObject);
begin
  Reports.SendReport;
end;

procedure TMainForm.cbReportsReceiptChange(Sender: TObject);
begin
  cbReportsPaypal.IsChecked := False;
  if cbReportsReceipt.IsChecked then
  begin
    cbReportsPaypal.Enabled := False;
  end
  else
  begin
    cbReportsPaypal.Enabled := True;
  end;
end;

// SETTINGS
procedure TMainForm.bSettingsClick(Sender: TObject);
begin
  lEmailname.FontColor := TAlphaColorRec.Black;
  OpenPanel(panelSettings);
end;

procedure TMainForm.bSettingsSaveClick(Sender: TObject);
begin
  Settings.ButtonClick;
end;

procedure TMainForm.eWidthChange(Sender: TObject);
begin
  Settings.WidthChange;
end;

procedure TMainForm.eHeightChange(Sender: TObject);
begin
  Settings.HeightChange;
end;

procedure TMainForm.bResetAccomsClick(Sender: TObject);
begin
  try
    if IsConnected then
    begin
      RentalController.SetAccomTable;
    end
    else Print('Cannot connect to server.');
  except
    // Exception occured
    on E : Exception do
    begin
      MainForm.circleOnlineStatus.Fill.Color := TAlphaColorRec.Red;
      Print('ERROR: ' + E.ClassName + sLineBreak + E.Message);
    end;
  end;
end;

procedure TMainForm.bResetBanksClick(Sender: TObject);
begin
  try
    if IsConnected then
    begin
      PaymentController.SetBankTable;
    end
    else Print('Cannot connect to server.');
  except
    // Exception occured
    on E : Exception do
    begin
      MainForm.circleOnlineStatus.Fill.Color := TAlphaColorRec.Red;
      Print('ERROR: ' + E.ClassName + sLineBreak + E.Message);
    end;
  end;
end;

// HOME
// Upcoming due deposits and Recent Bookings
procedure TMainForm.lbHomeBookingItemClick(const Sender: TCustomListBox;
  const Item: TListBoxItem);
begin
  lbUpcomingDeposits.ItemIndex := -1;
  lbRecentBookings.ItemIndex := -1;
  lbRecentClients.ItemIndex := -1;
  Home.ClickBookingItem(Item);
end;
// Recent Clients
procedure TMainForm.lbHomeClientItemClick(const Sender: TCustomListBox;
  const Item: TListBoxItem);
begin
  lbUpcomingDeposits.ItemIndex := -1;
  lbRecentBookings.ItemIndex := -1;
  lbRecentClients.ItemIndex := -1;
  Home.ClickClientItem(Item);
end;

procedure TMainForm.bRefreshHomeClick(Sender: TObject);
begin
  Home.SetHomeTab;
end;

end.
