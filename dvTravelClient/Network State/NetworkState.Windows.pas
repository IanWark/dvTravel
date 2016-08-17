unit NetworkState.Windows;

interface

uses
  NetworkState, ClientModuleUnit1;

type
  TPlatformNetworkState = class(TCustomNetworkState)
  public
    function CurrentSSID: string; override;
    function IsConnected: Boolean; override;
    function IsWifiConnected: Boolean; override;
    function IsMobileConnected: Boolean; override;
  end;

implementation

uses
  System.SysUtils;

{ TPlatformNetworkState }

function TPlatformNetworkState.CurrentSSID: string;
begin
  Result := '';
end;

function TPlatformNetworkState.IsConnected: Boolean;
begin
    try
    Result := ClientModule1.ServerMethods1Client.TestConnection;
  except
    on E : Exception do
      begin
        Result := False;
      end;
  end;
end;

function TPlatformNetworkState.IsMobileConnected: Boolean;
begin
  Result := False;
end;

function TPlatformNetworkState.IsWifiConnected: Boolean;
begin
  Result := False;
end;

end.
