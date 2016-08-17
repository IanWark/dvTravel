unit Misc;

// Miscellaneous methods and constants used by most files

interface
uses DB, Variants, NetworkState, UITypes;

const
  dsEditModes = dsEditModes;
  NullDate = 0;
  EmailAddress = 'liveit@dulcevida.com';

procedure Print(Str : String);
function IfNull(const Value : OleVariant; Default : OleVariant) : OleVariant;
function IsConnected : Boolean;

implementation
uses Main;

// Displays message
procedure Print(Str : String);
begin
  MainForm.Print(Str);
end;

// Ensures value is not null
function IfNull(const Value : OleVariant; Default : OleVariant) : OleVariant;
begin
  if Value = NULL then
    Result := Default
  else
    Result := Value;
end;

// Check if connected to internet, set circleOnlineStatus accordingly
function IsConnected : Boolean;
var
  NS : TNetworkState;
begin
  Result := False;
  try
    NS := TNetworkState.Create;
    if NS.IsConnected then
    begin
      MainForm.circleOnlineStatus.Fill.Color := TAlphaColorRec.Green;
      Result := True;
    end
    else
    begin
      MainForm.circleOnlineStatus.Fill.Color := TAlphaColorRec.Red;
      Result := False;
    end;
  finally
    NS.Free;
  end;
end;

end.
