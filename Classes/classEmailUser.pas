unit classEmailUser;

// Contains address and name that an email should be from

interface
type
  TEmailUser = class
    private
      cAddress : String;
      cName    : String;
    public
      property Address : String
        read cAddress write cAddress;
      property Name : String
        read cName write cName;
      constructor Create(nAddress : String; nName : String);

  end;

implementation

  constructor TEmailUser.Create(nAddress: string; nName: string);
  begin
    cAddress := nAddress;
    cName    := nName;
  end;
end.
