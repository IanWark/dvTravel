unit PDFViewer;

// For previewing reports (invoices and vouchers)

interface

uses
  Misc,
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.WebBrowser,
  FMX.TMSWebBrowser, FMX.Objects, Winsoft.FireMonkey.PDFium;

type
  TPDFForm = class(TForm)
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Navigate(URL : String);
  end;

var
  PDFForm: TPDFForm;
  WebBrowser : TTMSFMXWebBrowser;

implementation

{$R *.fmx}

procedure TPDFForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  WebBrowser.Destroy;
end;

procedure TPDFForm.FormCreate(Sender: TObject);
begin
  Top := 0;
end;

// Webbrowser must be made new and destroyed each time
// Otherwise it interferes with and gets interfered by date pickers and comboboxes
procedure TPDFForm.Navigate(URL: string);
begin
  WebBrowser := TTMSFMXWebBrowser.Create(Self);
  WebBrowser.Parent := Self;
  WebBrowser.Align := TAlignLayout.Contents;
  WebBrowser.Navigate(URL);
end;

end.
