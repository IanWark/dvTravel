unit Search;

// All the stuff related to searching for clients

interface
uses ClientModuleUnit1, DatabaseStrings, Misc,
     Data.FireDACJSONReflect, SysUtils,FMX.ListBox, FireDAC.Comp.Client,
     System.Classes, UITypes;

Const
  sFooter = 'See More...';
  sFirst = 'First Name';
  sFirstHeader = 'Header First Name';
  sFirstFooter = 'Footer First Name';
  sFirstSearch = 'Search By First Name';
  sLast = 'Last Name';
  sLastHeader = 'Header Last Name';
  sLastFooter = 'Footer Last Name';
  sLastSearch = 'Search By Last Name';
  sCity = 'City';
  sCityHeader = 'Header City';
  sCityFooter = 'Footer City';
  sCitySearch = 'Search By City';
  sCountry = 'Country';
  sCountryHeader = 'Header Country';
  sCountryFooter = 'Footer Country';
  sCountrySearch = 'Search By Country';

  SearchLimit = 3;
  SearchUnLimit = 1000;

  ResultsStringLimit = 35;
  MoreStringLimit = 60;

procedure Clear;

// Gets data from Person table from IDs gotten in SearchFirst, SearchLast, etc.
procedure GetPersonData(MemTable : TFDMemTable);

// Generates a list of IDs for use in ServerMethods.SearchPeople
function GenerateIDList(MemTable : TFDMemTable) : String;

// Bolds the parts of the StringList that contain Str
function BoldNames(Str : String; StringList : TStrings) : String;

// Generates the text for the search results
// Memtable is the memtable to get the info from, SearchParam is FirstName, LastName, etc.
// Search is the text entered into the search field
function GenerateDetail(MemTable : TFDMemTable; SearchParam : String; SearchText : String; PersonStringLimit : Integer) : String;

// Adds header to search list e.g. First Name
procedure AddSearchHeader(Text : String; Detail : String);

// Adds clients to search list
procedure AddSearchItems(MemTable : TFDMemTable; SearchParam : String; SearchText : String);

// Adds 'Search More...' footers to each result with more results than limit
procedure AddSearchFooter(Text : String; Detail : String);

// Search for clients in database with attribute containing SearchText
procedure SearchFirst(SearchText : String);
procedure SearchLast(SearchText : String);
procedure SearchCity(SearchText : String);
procedure SearchCountry(SearchText : String);

// If there are more results than those displayed in normal search
// SearchMore displays all of the results in a seperate popup panel
procedure SearchMore(SearchText : String; Footer : String);

// When magnifying class is clicked, search all attributes by text in eSearch.Text
procedure SearchButtonClick;

// When Search Item selected
procedure ItemClick(Item : TListBoxItem);

implementation
uses Main, DataController, ClientsTabController, ClientsTabView;

procedure Clear;
begin
  with Module do
  begin
    mtSearchFirst.Close;
    mtSearchFirst.Open;
    mtSearchLast.Close;
    mtSearchLast.Open;
    mtSearchCity.Close;
    mtSearchCity.Open;
    mtSearchCountry.Close;
    mtSearchCountry.Open;
  end;

  MainForm.lbSearchResults.Clear;
end;

// Gets data from Person table from IDs gotten in SearchFirst, SearchLast, etc.
// Used in SearchFirst, SearchLast, SearchCity, SearchCountry, SearchMore
procedure GetPersonData(MemTable : TFDMemTable);
var
  LDataSetList : TFDJSONDataSets;
  test : String;
begin
  // Get Person data for those clients
  Module.mtSearchPerson.Close;
  Module.mtSearchPerson.Open;
  test := GenerateIDList(MemTable);
  LDataSetList := ClientModule1.ServerMethods1Client.SearchPeople(GenerateIDList(MemTable));
  Module.mtSearchPerson.AppendData(TFDJSONDataSetsReader.GetListValue(LDataSetList,0));
end;

// Generates a list of IDs for use in ServerMethods.SearchPeople
function GenerateIDList(MemTable : TFDMemTable) : String;
begin
  with MemTable do
  begin
    Result := '(';
    First;
    Result := Result + FieldByName('ClientID').AsString;
    Next;
    while not EOF do
    begin
      Result := Result + ',' + FieldByName('ClientID').AsString;
      Next;
    end;
    Result := Result + ')';
  end;
end;

// Bolds the parts of the StringList that contain Str
function BoldNames(Str : String; StringList : TStrings) : String;
var
  Count : Integer;
  I : Integer;
begin
  Result := Str;
  Count := StringList.Count;
  if Count > 0 then
  begin
    for I := 0 to Count-1 do
    begin
      // Does it thrice because of case
      // can do IgnoreCase but then DAMIAN becomes DAMIan and so on
      Result := StringReplace
        (Result, StringList[I],'<b>' + StringList[I] + '</b>', [rfReplaceAll]);
      Result := StringReplace
        (Result, LowerCase(StringList[I]),'<b>' + LowerCase(StringList[I]) + '</b>', [rfReplaceAll]);
      Result := StringReplace
        (Result, UpperCase(StringList[I]),'<b>' + UpperCase(StringList[I]) + '</b>', [rfReplaceAll]);
    end;
  end;
end;

// Generates the text for the search results
// Memtable is the memtable to get the info from, SearchParam is FirstName, LastName, etc.
// Search is the text entered into the search field
function GenerateDetail(MemTable : TFDMemTable; SearchParam : String; SearchText : String; PersonStringLimit : Integer) : String;
var
  ClientID : Integer;
  FirstPerson : Boolean;
  FirstName : String;
  LastName : String;
  StringList : TStrings;
  StringLength : Integer;
begin
  StringList := SplitString(SearchText);
  ClientID := MemTable.FieldByName('ClientID').AsInteger;
  FirstPerson := True;
  Result := '';
  // Add people associated with client to result
  with Module.mtSearchPerson do
  begin
    First;
    while not EOF do
    begin
      if FieldByName('ClientID').AsInteger = ClientID then
      begin
        // First person in result doesn't have a + in front
        if not FirstPerson then
        begin
          Result := Result + ' + ';
        end
        else
        begin
          FirstPerson := False;
        end;

        FirstName := FieldByName('FirstName').AsString;
        LastName := FieldByName('LastName').AsString;

        // If search by FirstName, bold matches
        if (Result.Length + FirstName.Length) < PersonStringLimit then
        begin
          if (SearchParam = sFirst) then
          begin
            StringLength := FirstName.Length;
            FirstName := BoldNames(FirstName, StringList);
            StringLength := FirstName.Length - StringLength;
            PersonStringLimit := PersonStringLimit + StringLength;
          end;
          Result := Result + FirstName + ' ';
        end
        else
        // Cut string if overly long
        begin
          Result := Result + FirstName + ' ';
          Result := Copy(Result,0,Result.Length-3) + '...';
          Break;
        end;
        // If search by LastName, bold matches
        if (Result.Length + FirstName.Length) < PersonStringLimit then
        begin
          if (SearchParam = sLast) then
          begin
            StringLength := LastName.Length;
            LastName := BoldNames(LastName, StringList);
            StringLength := LastName.Length - StringLength;
            PersonStringLimit := PersonStringLimit + StringLength;
          end;
          Result := Result + LastName + ' ';
        end
        else
        // Cut string if overly long
        begin
          Result := Result + LastName + ' ';
          Result := Copy(Result,0,Result.Length-3) + '...';
          Break;
        end;
      end;
      Next;
    end;
  end;
  Result := Result + sLineBreak;
  // Add client location to result
  with MemTable do
  begin
    if FieldByName('City').AsString <> '' then
    begin
      // If search by City, bold matches
      if SearchParam = sCity then
      begin
        Result := Result + '<b>' + FieldByName('City').AsString + '</b>, ';
      end
      else
      begin
        Result := Result + FieldByName('City').AsString + ', ';
      end;
    end;
    if FieldByName('ProvState').AsString <> '' then
    begin
      Result := Result + FieldByName('ProvState').AsString + ', ';
    end;
    if FieldByName('Country').AsString <> '' then
    begin
      // If search by Country, bold matches
      if SearchParam = sCountry then
      begin
         Result := Result + '<b>' + FieldByName('Country').AsString + '</b>';
      end
      else
      begin
        Result := Result + FieldByName('Country').AsString;
      end;
    end;
  end;

end;

// Adds header to search list e.g. First Name
// Used in SearchFirst, SearchLast, SearchCity, SearchCountry
procedure AddSearchHeader(Text : String; Detail : String);
var
  Header : TListBoxGroupHeader;
begin
  Header := TListBoxGroupHeader.Create(MainForm.lbSearchResults);
  Header.Text := Text;
  Header.ItemData.Detail := Detail;
  Header.StyleLookup := 'HeaderListBoxItem';
  Header.Height := 30;
  MainForm.lbSearchResults.AddObject(Header);
end;

// Adds clients to search list
// Used in SearchFirst, SearchLast, SearchCity, SearchCountry, SearchMore
procedure AddSearchItems(MemTable : TFDMemTable; SearchParam : String; SearchText : String);
var
  Detail : String;
  Item : TListBoxItem;
begin
  with MemTable do
  begin
    First;
    while not EOF do
    begin
      Item := TListBoxItem.Create(MainForm.lbSearchResults);
      Item.Text := FieldByName('ClientID').AsString;
      Detail := GenerateDetail(MemTable,SearchParam,SearchText,ResultsStringLimit);
      Item.ItemData.Detail := Detail;
      Item.StyleLookup := 'SearchListBoxItem';
      Item.Height := 40;
      MainForm.lbSearchResults.AddObject(Item);
      Next;
    end;
  end;
end;

// Adds 'Search More...' footers to each result with more results than limit
// Used in SearchFirst, SearchLast, SearchCity, SearchCountry
procedure AddSearchFooter(Text : String; Detail : String);
var
  Footer : TListBoxGroupFooter;
begin
  Footer := TListBoxGroupFooter.Create(MainForm.lbSearchResults);
  Footer.Text := Text;
  Footer.ItemData.Detail := Detail;
  Footer.StyleLookup := 'NormalListBoxItem';
  Footer.Height := 20;
  MainForm.lbSearchResults.AddObject(Footer);
end;

// Search for clients in database with First Name containing SearchText
procedure SearchFirst(SearchText : String);
var
  LDataSetList : TFDJSONDataSets;
begin
  // Get client data, add to table
  LDataSetList := ClientModule1.ServerMethods1Client.SearchFirst
      (StringReplace(SearchText,' ','^', [rfReplaceAll]), SearchLimit);
  Module.mtSearchFirst.AppendData(TFDJSONDataSetsReader.GetListValue(LDataSetList,0));

  if Module.mtSearchFirst.Table.Rows.Count > 0 then
  begin
    GetPersonData(Module.mtSearchFirst);

    // Add to view
    AddSearchHeader(sFirstHeader, sFirst);

    AddSearchItems(Module.mtSearchFirst, sFirst, SearchText);

    if Module.mtSearchFirst.Table.Rows.Count >= SearchLimit  then
    begin
      AddSearchFooter(sFirstFooter, sFooter);
    end;
  end;
end;

// Search for clients in databse with Last Name containing SearchText
procedure SearchLast(SearchText : String);
var
  LDataSetList : TFDJSONDataSets;
begin
  // Get client data, add to table
  LDataSetList := ClientModule1.ServerMethods1Client.SearchLast
    (StringReplace(SearchText,' ','^', [rfReplaceAll]), SearchLimit);
  Module.mtSearchLast.AppendData(TFDJSONDataSetsReader.GetListValue(LDataSetList,0));

  if Module.mtSearchLast.Table.Rows.Count > 0 then
  begin
    GetPersonData(Module.mtSearchLast);

    // Add to view
    AddSearchHeader(sLastHeader, sLast);
    AddSearchItems(Module.mtSearchLast, sLast, SearchText);

    if Module.mtSearchLast.Table.Rows.Count >= SearchLimit  then
    begin
      AddSearchFooter(sLastFooter, sFooter);
    end;
  end;
end;

// Search for clients in databse with City containing SearchText
procedure SearchCity(SearchText : String);
var
  LDataSetList : TFDJSONDataSets;
begin
  // Get client data, add to table
  LDataSetList := ClientModule1.ServerMethods1Client.SearchCity
    (StringReplace(SearchText,' ','^', [rfReplaceAll]), SearchLimit);
  Module.mtSearchCity.AppendData(TFDJSONDataSetsReader.GetListValue(LDataSetList,0));

  if Module.mtSearchCity.Table.Rows.Count > 0 then
  begin
    GetPersonData(Module.mtSearchCity);

    // Add to view
    AddSearchHeader(sCityHeader, sCity);
    AddSearchItems(Module.mtSearchCity, sCity, SearchText);

    if Module.mtSearchCity.Table.Rows.Count >= SearchLimit  then
    begin
      AddSearchFooter(sCityFooter, sFooter);
    end;
  end;
end;

// Search for clients in databse with Country containing SearchText
procedure SearchCountry(SearchText : String);
var
  LDataSetList : TFDJSONDataSets;
begin
  // Get client data, add to table
  LDataSetList := ClientModule1.ServerMethods1Client.SearchCountry
    (StringReplace(SearchText,' ','^', [rfReplaceAll]), SearchLimit);
  Module.mtSearchCountry.AppendData(TFDJSONDataSetsReader.GetListValue(LDataSetList,0));

  if Module.mtSearchCountry.Table.Rows.Count > 0 then
  begin
    GetPersonData(Module.mtSearchCountry);

    // Add to view
    AddSearchHeader(sCountryHeader, sCountry);
    AddSearchItems(Module.mtSearchCountry, sCountry, SearchText);

    if Module.mtSearchCountry.Table.Rows.Count >= SearchLimit  then
    begin
      AddSearchFooter(sCountryFooter, sFooter);
    end;
  end;
end;

// If there are more results than those displayed in normal search
// This displays all of the results in a seperate popup panel
procedure SearchMore(SearchText : String; Footer : String);
var
  LDataSetList : TFDJSONDataSets;
  SearchParam : String;
  Detail : String;
  Count : Integer;
begin
  // Clear tables
  Module.mtSearchMore.Close;
  Module.mtSearchMore.Open;
  MainForm.lbSearchMore.Clear;

  MainForm.OpenPanel(MainForm.panelSearchMore);

  // Get data
  if Footer = sFirstFooter then
  begin
    LDataSetList := ClientModule1.ServerMethods1Client.SearchFirst(SearchText, SearchUnLimit);
    Module.mtSearchMore.AppendData(TFDJSONDataSetsReader.GetListValue(LDataSetList, 0));

    MainForm.lSearchMore.Text := sFirstSearch;
    SearchParam := sFirst;
  end
  else
  if Footer = sLastFooter then
  begin
    LDataSetList := ClientModule1.ServerMethods1Client.SearchLast(SearchText, SearchUnLimit);
    Module.mtSearchMore.AppendData(TFDJSONDataSetsReader.GetListValue(LDataSetList, 0));

    MainForm.lSearchMore.Text := sLastSearch;
    SearchParam := sLast;
  end
  else
  if Footer = sCityFooter then
  begin
    LDataSetList := ClientModule1.ServerMethods1Client.SearchCity(SearchText, SearchUnLimit);
    Module.mtSearchMore.AppendData(TFDJSONDataSetsReader.GetListValue(LDataSetList, 0));

    MainForm.lSearchMore.Text := sCitySearch;
    SearchParam := sCity;
  end
  else
  if Footer = sCountryFooter then
  begin
    LDataSetList := ClientModule1.ServerMethods1Client.SearchCountry(SearchText, SearchUnLimit);
    Module.mtSearchMore.AppendData(TFDJSONDataSetsReader.GetListValue(LDataSetList, 0));

    MainForm.lSearchMore.Text := sCountrySearch;
    SearchParam := sCountry;
  end;
  // Populate panel
  MainForm.lSearchString.Text := '"' + SearchText + '"';

  GetPersonData(Module.mtSearchMore);
  with Module.mtSearchMore do
  begin
    if Table.Rows.Count > 0 then
    begin
      First;
      while not EOF do
      begin
        MainForm.lbSearchMore.Items.Add(FieldByName('ClientID').AsString);
        Detail := GenerateDetail(Module.mtSearchMore,SearchParam,SearchText,MoreStringLimit);
        Count := MainForm.lbSearchMore.Count;
        MainForm.lbSearchMore.ListItems[Count-1].ItemData.Detail := Detail;
        MainForm.lbSearchMore.ListItems[Count-1].StyleLookup := 'SearchListBoxItem';
        MainForm.lbSearchMore.ListItems[Count-1].Height := 50;
        Next;
      end;
    end
    else
    begin
      MainForm.lSearchString.Text := 'ERROR: Results empty';
    end;
  end;
end;

// When magnifying class is clicked, search all attributes by text in eSearch.Text
procedure SearchButtonClick;
var
  Item : TListBoxGroupHeader;
begin
  with MainForm do
  begin
    // Continue if there is actually text in search box
    if eSearch.Text <> '' then
    begin
      // Continue only if connected to internet
      try
        if IsConnected then
        begin
          Search.Clear;

          Search.SearchFirst(eSearch.Text);
          Search.SearchLast(eSearch.Text);
          Search.SearchCity(eSearch.Text);
          Search.SearchCountry(eSearch.Text);

          rectTrans.Visible := True;
          lbSearchResults.Visible := True;

          // Bring lbSearchResults parent to front
          HeaderToolBar.BringToFront;
          LaySearch.BringToFront;
          lbSearchResults.BringToFront;

          if lbSearchResults.Count = 0 then
          begin
            Item := TListBoxGroupHeader.Create(MainForm.lbSearchResults);
            Item.Text := 'No Results';
            Item.ItemData.Detail := 'No Results';
            Item.StyleLookup := 'HeaderListBoxItem';
            Item.Height := 80;
            MainForm.lbSearchResults.AddObject(Item);
          end;
        end
        else
        begin
          Print('Cannot connect to the server.');
        end;

        except
          // Exception occured
          on E : Exception do
          begin
            MainForm.circleOnlineStatus.Fill.Color := TAlphaColorRec.Red;
            Print('ERROR: ' + E.ClassName + sLineBreak + E.Message);
          end;
      end;
    end;
  end;
end;

// When search result is selected
// If Item, go to that item
// If Footer, do SearchMore
procedure ItemClick(Item : TListBoxItem);
begin
  if Item.ClassName = 'TListBoxItem' then
  begin
    ClientsTabView.SwitchToClients;
    ClientsTabController.SetClientsTab(StrToInt(Item.Text));
    MainForm.rectTrans.Visible := False;
    MainForm.lbSearchResults.Visible := False;
    MainForm.panelSearchMore.Visible := False;
  end
  else
  if Item.ClassName = 'TListBoxGroupFooter' then
  begin
    Search.SearchMore(MainForm.eSearch.Text, Item.Text);
  end;
end;

end.
