unit classPayment;

interface

type
  TPayment = class
    private
      cPayID     : Integer;
      cBookID    : Integer;
      cPayDate   : TDate;
      cAmtPaid   : Single;
      cCurrency  : String;
      cConversion: Double;
      cAmtRecvd  : Single;
      cPayMethod : String;
      cPayType   : String;
      cPayNote   : String;
      cBankID    : Integer;
      cBankName  : String;
    public
      property PayID : Integer
        read cPayID write cPayID;
      property BookID : Integer
        read cBookID write cBookID;
      property PayDate : TDate
        read cPayDate write cPayDate;
      property AmtPaid : Single
        read cAmtPaid write cAmtPaid;
      property Currency : String
        read cCurrency write cCurrency;
      property Conversion : Double
        read cConversion write cConversion;
      property AmtRecvd : Single
        read cAmtRecvd write cAmtRecvd;
      property PayMethod : String
        read cPayMethod write cPayMethod;
      property PayType : String
        read cPayType write cPayType;
      property PayNote : String
        read cPayNote write cPayNote;
      property BankID : Integer
        read cBankId write cBankId;
      property BankName : String
        read cBankName write cBankName;
      constructor Create(nPayID : Integer; nBookId : Integer; nPayDate : TDate;
                        nAmtPaid : Single; nCurrency : String; nConversion : Double;
                        nAmtRecvd : Single; nPayMethod : String; nPayType : String;
                        nPayNote : String; nBankID : Integer; nBankName : String);
      function ToString : String;
  end;

implementation
uses SysUtils;
    constructor TPayment.Create(nPayID : Integer; nBookId : Integer; nPayDate : TDate;
                        nAmtPaid : Single; nCurrency : String; nConversion : Double;
                        nAmtRecvd : Single; nPayMethod : String; nPayType : String;
                        nPayNote : String; nBankID : Integer; nBankName : String);
    begin
      PayID     := nPayID;
      BookId    := nBookID;
      PayDate   := nPayDate;
      AmtPaid   := nAmtPaid;
      Currency  := nCurrency;
      Conversion:= nConversion;
      AmtRecvd  := nAmtRecvd;
      PayMethod := nPayMethod;
      PayType   := nPayType;
      PayNote   := nPayNote;
      BankID    := nBankID;
      BankName  := nBankName;
    end;

    function TPayment.ToString : String;
    begin
      Result := '$' + AmtPaid.ToString + ' ' + Currency + ' - ';
      if PayType <> '' then
      begin
        Result := Result + PayType + ' - ';
      end;
      Result := Result + PayMethod + ' - ' + DateToStr(PayDate);
    end;
end.
