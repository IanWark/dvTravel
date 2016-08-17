unit classResult;

interface
type
  TResult = class
  private
    cOldID : Integer;
    cNewID : Integer;
  public
    property OldID : Integer
      read cOldID write cOldID;
    property NewID : Integer
      read cNewId write cNewId;
    constructor Create(nOldID : Integer; nNewID : Integer);
  end;

implementation

constructor TResult.Create(nOldID : Integer; nNewID : Integer);
begin
  OldID := nOldID;
  NewID := nNewID;
end;
end.
