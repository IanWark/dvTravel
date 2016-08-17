unit classRental;

interface
uses classAccom, System.Classes;

type
  TRental = class
    private
      cRentID : Integer;
      cBookID : Integer;
      cStartDate : TDate;
      cEndDate : TDate;
      cOccupants : Integer;
      cCharges : Double;
      cRate : Double;
      cDiscountDesc : String;
      cDiscountAmt : Double;
      cComment : String;
      cAccoms : TList;

    public
      property RentID : Integer
        read cRentID write cRentID;
      property BookID : Integer
        read cBookID write cBookID;
      property StartDate : TDate
        read cStartDate write cStartDate;
      property EndDate : TDate
        read cEndDate write cEndDate;
      property Occupants : Integer
        read cOccupants write cOccupants;
      property Charges : Double
        read cCharges write cCharges;
      property Rate : Double
        read cRate write cRate;
      property DiscountDesc : String
        read cDiscountDesc write cDiscountDesc;
      property DiscountAmt : Double
        read cDiscountAmt write cDiscountAmt;
      property Comment : String
        read cComment write cComment;


      constructor Create(nRentID : Integer; nBookID : Integer; nStartDate : TDate;
      nEndDate : TDate; nOccupants : Integer; nCharges : Double; nRate : Double;
      nDiscountDesc : String; nDiscountAmt : Double;  nComment : String);
      destructor Destroy;
      procedure AddAccom(Accom : TAccom);
      function GetAccomsLength : Integer;
      function GetAccom(Index : Integer) : TAccom;
      procedure ClearAccoms;
      function ToString : String;
  end;

implementation
  uses SysUtils;

constructor TRental.Create(nRentID : Integer; nBookID : Integer;
nStartDate : TDate; nEndDate : TDate; nOccupants : Integer; nCharges : Double;
nRate : Double; nDiscountDesc : String; nDiscountAmt : Double; nComment : String);
begin
  RentID := nRentID;
  BookID := nBookID;
  StartDate := nStartDate;
  EndDate := nEndDate;
  Occupants := nOccupants;
  Charges := nCharges;
  Rate := nRate;
  DiscountDesc := nDiscountDesc;
  DiscountAmt := nDiscountAmt;
  Comment := nComment;

  cAccoms := TList.Create;
end;

destructor TRental.Destroy;
var
  I : Integer;
begin
  for I := 0 to cAccoms.Count-1 do
  begin
    TAccom(cAccoms[I]).Free;
  end;
  cAccoms.Free;

  inherited;
end;

procedure TRental.AddAccom(Accom : TAccom);
begin
  cAccoms.Add(Accom);
end;

function TRental.GetAccomsLength : Integer;
begin
  Result := cAccoms.Count;
end;

// Attempt to get Accom at Index
function TRental.GetAccom(Index : Integer) : TAccom;
begin
  Result := cAccoms[Index];
end;

procedure TRental.ClearAccoms;
begin
  cAccoms.Clear;
end;

function TRental.ToString : String;
var
  I: Integer;
begin
  Result := '$'+ (Charges - DiscountAmt).ToString +' - ';
  if Occupants = 1 then
  begin
    Result := Result + Occupants.ToString + ' Occupant | ';
  end
  else
  begin
    Result := Result + Occupants.ToString + ' Occupants | ';
  end;
  Result := Result + DateToStr(StartDate) + ' - ' + DateToStr(EndDate);
  Result := Result + ' | $' + Rate.ToString + '/day';
  if GetAccomsLength = 1 then
  begin
    Result := Result + ' | ' + GetAccom(0).AccomName
  end
  else
  if GetAccomsLength > 1 then
  begin
    Result := Result + ' | Casas ' + GetAccom(0).AccomID.ToString;
    for I := 1 to GetAccomsLength-1 do
    begin
      Result := Result + ', ' + GetAccom(I).AccomID.ToString;
    end;
  end;
end;

end.
