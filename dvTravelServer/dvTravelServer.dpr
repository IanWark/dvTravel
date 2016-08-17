program dvTravelServer;
{$APPTYPE GUI}

{$R *.dres}

uses
  Vcl.Forms,
  Web.WebReq,
  IdHTTPWebBrokerBridge,
  ServerUnit in 'ServerUnit.pas' {Form1},
  ServerMethodsUnit in 'ServerMethodsUnit.pas' {ServerMethods: TDSServerModule},
  WebModuleUnit in 'WebModuleUnit.pas' {WebModule1: TWebModule},
  DatabaseStrings in 'DatabaseStrings.pas',
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
  classTravel in '..\Classes\classTravel.pas';

{$R *.res}

begin
  if WebRequestHandler <> nil then
    WebRequestHandler.WebModuleClass := WebModuleClass;
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
