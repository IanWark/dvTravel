unit classResultsArray;

interface
uses classResult, System.Classes;

type
  TResultsArray = class
    private
      // Arrays of Arrays of 2 Integers - Old ID and New ID
      IDs : Array of TResult;
    public
      constructor Create;
      destructor Destroy;
      procedure AddID(OldID : Integer; NewId : Integer);
      function GetLen : Integer;
      function GetID(Index : Integer) : TResult;
  end;

implementation
uses SysUtils;

constructor TResultsArray.Create;
begin
  SetLength(IDs,0);
end;

destructor TResultsArray.Destroy;
var
  I : Integer;
begin
  for I := 0 to GetLen-1 do
  begin
    TResult(IDs[I]).Free;
  end;
  SetLength(IDs,0);

  inherited;
end;

procedure TResultsArray.AddID(OldID: Integer; NewId: Integer);
begin
  SetLength(IDs,GetLen+1);
  IDs[Length(IDs)-1] := TResult.Create(OldID, NewID);
end;

function TResultsArray.GetLen;
begin
  Result := Length(IDs);
end;

function TResultsArray.GetID(Index: Integer) : TResult;
begin
  Result := IDs[Index];
end;

end.
