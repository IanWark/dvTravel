program dvTravel;

uses
  System.StartUpCopy,
  FMX.Forms,
  Main in 'Main.pas' {MainForm},
  DataController in 'DataController.pas' {Module: TDataModule},
  ClientClassesUnit1 in 'ClientClassesUnit1.pas',
  ClientModuleUnit1 in 'ClientModuleUnit1.pas' {ClientModule1: TDataModule},
  ResizeForm in 'ResizeForm.pas',
  BookingsTabController in 'Bookings\BookingsTabController.pas',
  ClientsTabController in 'Clients\ClientsTabController.pas',
  BookingsTabView in 'Bookings\BookingsTabView.pas',
  ClientsTabView in 'Clients\ClientsTabView.pas',
  Search in 'Search.pas',
  CalendarView in 'Calendar\CalendarView.pas',
  CalendarController in 'Calendar\CalendarController.pas',
  Reports in 'Bookings\Reports.pas',
  SelectPeople in 'Bookings\SelectPeople.pas',
  RentalController in 'Bookings\RentalController.pas',
  PaymentController in 'Bookings\PaymentController.pas',
  TravelController in 'Bookings\TravelController.pas',
  PersonController in 'Clients\PersonController.pas',
  RentalView in 'Bookings\RentalView.pas',
  PaymentView in 'Bookings\PaymentView.pas',
  TravelView in 'Bookings\TravelView.pas',
  BookingController in 'Clients\BookingController.pas',
  BookingView in 'Clients\BookingView.pas',
  Misc in 'Misc.pas',
  Settings in 'Settings.pas',
  Home in 'Home.pas',
  PDFViewer in 'PDFViewer.pas' {PDFForm},
  DatabaseStrings in '..\dvTravelServer\DatabaseStrings.pas',
  PersonView in 'Clients\PersonView.pas',
  classAccom in '..\Classes\classAccom.pas',
  classBooking in '..\Classes\classBooking.pas',
  classCalendarItem in '..\Classes\classCalendarItem.pas',
  classClient in '..\Classes\classClient.pas',
  classContact in '..\Classes\classContact.pas',
  classEmailUser in '..\Classes\classEmailUser.pas',
  classPayment in '..\Classes\classPayment.pas',
  classPerson in '..\Classes\classPerson.pas',
  classRental in '..\Classes\classRental.pas',
  classResult in '..\Classes\classResult.pas',
  classResultsArray in '..\Classes\classResultsArray.pas',
  classTravel in '..\Classes\classTravel.pas',
  NetworkState in 'Network State\NetworkState.pas',
  NetworkState.Windows in 'Network State\NetworkState.Windows.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TModule, Module);
  Application.CreateForm(TClientModule1, ClientModule1);
  Application.CreateForm(TPDFForm, PDFForm);
  Application.Run;
end.
