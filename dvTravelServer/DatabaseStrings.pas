unit DatabaseStrings;

// Strings related to the database and server
// Shared by both apps to ensure tables references by both are exactly the same

interface
uses System.Classes;

const
  sClient = 'dv.client';
  sPerson = 'dv.person';
  sContact = 'dv.contact';
  sBooking = 'dv.booking';
  sRental = 'dv.rental';
  sRentAccom = 'dv.rentaccom';
  sPayment = 'dv.payment';
  sTravel = 'dv.travel';
  sBookingPerson = 'dv.bookingperson';

  sTagline = 'and remember ... Don''t just Visit, Live It !!!';

  // Reports body text
  // Voucher
  VoucherMessage = 'Please find your Voucher attached to this email in Adobe Acrobat (pdf) format. ' +
  'If you have troubles please download the latest version of the free Adobe Acrobat Reader (https://get.adobe.com/reader).';

  // First half of invoice message
  InvoiceMessage1 =  'Thank you for choosing Casa Dulce Vida.' +
  sLineBreak +
  sLineBreak +
  'Please find your Invoice attached to this email in Adobe Acrobat (pdf) format. ' +
  'If you have troubles please download the latest version of the free Adobe Acrobat Reader (https://get.adobe.com/reader).' +
  sLineBreak +
  sLineBreak;
  InvoiceMessage2 = 'The deposit may be' +
  sLineBreak +
  '1.  Direct Deposit to any Wells Fargo bank' +
  sLineBreak +
  '2.  Online bank to bank' +
  sLineBreak +
  '3.  USD cheque (from a USA bank) or bank draft with account # and payable to Chawnalee Wark and mailed to bank address.';
  // Optional paypal addition
  InvoiceMessagePaypal = sLineBreak + '4. Paypal to chawnalee@yahoo.com.';
  // Second half of invoice message
  InvoiceMessage3 =
  sLineBreak +
  sLineBreak +
  'Remainder of funds due at check in can be paid in cash, USD or Pesos ' +
  '(there are ATMs in PV for withdrawl) or online bank to bank.'+
  sLineBreak +
  sLineBreak;
  InvoiceMessage4 =
  'On receipt of deposit you will receive a confirmation voucher with all the details. ' +
  'The time of your arrival is required so we can arrange your check in. ' +
  'If arriving by air please additionally provide airline and flight number information ' +
  'so that we can monitor your flight delays. Taxis are available from the airport.' +
  sLineBreak +
  sLineBreak +
  'Bank Information: ' +
  sLineBreak +
  'Wells Fargo, 15240 W Sunset Blvd, Pacific Palisades, CA 90272' +
  sLineBreak +
  'Account # 7119217995 Chawnalee Wark';

  function SplitString(Str : String) : TStrings;

implementation

// Splits string with different words into list of strings
function SplitString(Str : String) : TStrings;
begin
  Result := TStringList.Create;
  Result.Delimiter := ' ';
  Result.StrictDelimiter := True;
  Result.DelimitedText := Str;
end;

end.
