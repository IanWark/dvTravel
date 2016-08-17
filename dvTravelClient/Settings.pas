unit Settings;

// Handles saving, loading, and changing settings

interface
uses SysUtils, UITypes, IOUtils;

procedure SaveSettings;
procedure LoadSettings;
procedure ButtonClick;
procedure WidthChange;
procedure HeightChange;

implementation
uses Main, DataController, ResizeForm;

procedure SaveSettings;
var
  DirName : String;
  SaveFile: String;
begin
  DirName := IOUtils.TPath.Combine(IOUtils.TPath.GetDocumentsPath, 'dvTravel');
  SaveFile:= IOUtils.TPath.Combine(DirName, 'Settings');
  if not DirectoryExists(DirName) then
  begin
    CreateDir(DirName);
  end;

  with Module.mtSettings do
  begin
    Open;
    if Table.Rows.Count < 1 then
    begin
      Append;
    end
    else
    begin
      First;
      Edit;
    end;
    FieldByName('Emailname').AsString := MainForm.eEmailname.Text;
    if MainForm.eHeight.Visible then
    begin
      FieldByName('Height').AsSingle  := MainForm.eHeight.Value;
    end;
    if MainForm.eWidth.Visible then
    begin
      FieldByName('Width').AsSingle   := MainForm.eWidth.Value;
    end;
    Post;
    SaveToFile(SaveFile);
  end;
end;

procedure LoadSettings;
var
  DirName : String;
  LoadName: String;
begin
  DirName := IOUtils.TPath.Combine(IOUtils.TPath.GetDocumentsPath, 'dvTravel');
  LoadName:= IOUtils.TPath.Combine(DirName, 'Settings.FDS');

  {$IFDEF IOS}
  MainForm.eHeight.Visible := False;
  MainForm.eWidth.Visible  := False;
  {$ELSEIF ANDROID}
  MainForm.eHeight.Visible := False;
  MainForm.eWidth.Visible  := False;
  {$ENDIF}

  // Load file and set them up
  if FileExists(LoadName) then
  begin
    with Module.mtSettings do
    begin
      if not Active then Open;
      LoadFromFile(LoadName);
      MainForm.eEmailname.Text := FieldByName('Emailname').AsString;
      if MainForm.eHeight.Visible then
      begin
        MainForm.eHeight.Value  := FieldByName('Height').AsSingle;
        MainForm.Height         := FieldByName('Height').AsInteger;
      end;
      if MainForm.eWidth.Visible then
      begin
        MainForm.eWidth.Value   := FieldByName('Width').AsSingle;
        MainForm.Width          := FieldByName('Width').AsInteger;
      end;
    end;
  end
  else
  begin
    // If no settings file (first time run (hopefully))
    with MainForm do
    begin
      if MainForm.eHeight.Visible then
      begin
        MainForm.eHeight.Value := DefaultHeight;
      end;
      if MainForm.eWidth.Visible then
      begin
        MainForm.eWidth.Value  := DefaultWidth;
      end;
      OpenPanel(panelSettings);
      //Print('Please enter the name that will appear on your emails.');
    end;
  end;
end;

procedure ButtonClick;
begin
  with MainForm do
  begin
    SaveSettings;
    ClosePanel(panelSettings);
  end;
end;

procedure WidthChange;
begin
  MainForm.Width := Trunc(MainForm.eWidth.Value);
end;

procedure HeightChange;
begin
  MainForm.Height := Trunc(MainForm.eHeight.Value);
end;

end.
