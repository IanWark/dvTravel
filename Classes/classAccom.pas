unit classAccom;

interface

type
  TAccom = class
    private
      cAccomID : Integer;
      cAccomName : String;
      cSubID   : Integer;
    public
      property AccomID : Integer
        read cAccomID write cAccomID;
      property AccomName : String
        read cAccomName write cAccomName;
      property SubID : Integer
        read cSubID write cSubID;

      constructor Create(nAccomID : Integer; nAccomName : String; nSubID : Integer);
  end;

implementation

  constructor TAccom.Create(nAccomID: Integer; nAccomName: string; nSubID: Integer);
  begin
    AccomID := nAccomID;
    AccomName := nAccomName;
    SubID := nSubID;
  end;

end.
