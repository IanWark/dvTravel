unit NetworkState;

// http://community.embarcadero.com/blogs/entry/dave-nottage--checking-for-an-internet-connection-on-mobile-devices-with-delphi-xe5-43021
// Checks if device app is on is connected to the internet
// Works for Windows, Android
// I (Ian Wark) created NetworkState.Windows but thats it

interface

type
  TCustomNetworkState = class(TObject)
    function CurrentSSID: string; virtual; abstract;
    function IsConnected: Boolean; virtual; abstract;
    function IsWifiConnected: Boolean; virtual; abstract;
    function IsMobileConnected: Boolean; virtual; abstract;
  end;

  TNetworkState = class(TCustomNetworkState)
  private
    FPlatformNetworkState: TCustomNetworkState;
  public
    constructor Create;
    destructor Destroy; override;
    function CurrentSSID: string;
    function IsConnected: Boolean; override;
    function IsWifiConnected: Boolean; override;
    function IsMobileConnected: Boolean; override;
  end;

implementation

uses
  {$IFDEF ANDROID}
  NetworkState.Android;
  {$ENDIF}
  {$IFDEF MSWINDOWS}
  NetworkState.Windows;
  {$ENDIF}

{ TNetworkState }

constructor TNetworkState.Create;
begin
  inherited;
  FPlatformNetworkState := TPlatformNetworkState.Create;
end;

destructor TNetworkState.Destroy;
begin
  FPlatformNetworkState.Free;
  inherited;
end;

function TNetworkState.CurrentSSID: string;
begin
  Result := FPlatformNetworkState.CurrentSSID;
end;

function TNetworkState.IsConnected: Boolean;
begin
  Result := FPlatformNetworkState.IsConnected;
end;

function TNetworkState.IsMobileConnected: Boolean;
begin
  Result := FPlatformNetworkState.IsMobileConnected;
end;

function TNetworkState.IsWifiConnected: Boolean;
begin
  Result := FPlatformNetworkState.IsWifiConnected;
end;

end.
