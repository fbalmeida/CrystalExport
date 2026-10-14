unit CrystalEmulation;

interface

uses
  System.SysUtils,
  System.Classes,
  System.Variants,
  System.StrUtils,
  System.NetEncoding,
  Winapi.Windows,
  Winapi.ShellAPI,
  Vcl.Dialogs;

type
  // Mock class to store old database logon fields seamlessly
  TConnectEmulation = class
  public
    ServerName: string;
    DatabaseName: string;
    UserID: string;
    Password: string;
  end;

  // Mock class to handle single parameter inputs cleanly
  TParamItem = class
  public
    Name: string;
    CurrentValue: string;
  end;

  // Mock class to catch legacy indexed array assignments like ParamFields[0]
  TParamFieldsEmulation = class
  private
    FList: TList;
    function GetItem(Index: Integer): TParamItem;
  public
    constructor Create;
    destructor Destroy; override;
    function AddItem: TParamItem;
    procedure Clear;
    property Items[Index: Integer]: TParamItem read GetItem; default;
    function Count: Integer;
  end;

  // The primary emulator class that intercepts all legacy TCrpe calls
  TCrpe = class
  private
    FReportName: string;
  public
    Connect: TConnectEmulation;
    ParamFields: TParamFieldsEmulation;

    constructor Create(AOwner: TComponent); overload;
    constructor Create; overload;
    destructor Destroy; override;

    procedure Execute;

    property ReportName: string read FReportName write FReportName;
  end;

implementation

{ TParamFieldsEmulation }

constructor TParamFieldsEmulation.Create;
begin
  FList := TList.Create;
end;

destructor TParamFieldsEmulation.Destroy;
begin
  Clear;
  FList.Free;
  inherited;
end;

procedure TParamFieldsEmulation.Clear;
var
  i: Integer;
begin
  for i := 0 to FList.Count - 1 do
    TParamItem(FList[i]).Free;
  FList.Clear;
end;

function TParamFieldsEmulation.AddItem: TParamItem;
begin
  Result := TParamItem.Create;
  FList.Add(Result);
end;

function TParamFieldsEmulation.Count: Integer;
begin
  Result := FList.Count;
end;

function TParamFieldsEmulation.GetItem(Index: Integer): TParamItem;
begin
  // Safe bounds check: If the legacy code accesses an index before creating it,
  // we dynamically populate the underlying list array elements instantly.
  while FList.Count <= Index do
    AddItem;

  Result := TParamItem(FList[Index]);
end;

{ TCrpe }

constructor TCrpe.Create(AOwner: TComponent);
begin
  Create; // Redirects safely to the base internal parameter allocation logic
end;

constructor TCrpe.Create;
begin
  Connect := TConnectEmulation.Create;
  ParamFields := TParamFieldsEmulation.Create;
end;

destructor TCrpe.Destroy;
begin
  Connect.Free;
  ParamFields.Free;
  inherited;
end;

procedure TCrpe.Execute;
var
  JsonData: string;
  Base64Payload: string;
  ParamJsonList: string;
  ParamItemStr: string;
  i: Integer;
  AppDir: string;
begin
  if FReportName = '' then
  begin
    ShowMessage('Error: ReportName string assignment is empty.');
    Exit;
  end;

  if not FileExists(FReportName) then
  begin
    ShowMessage('Error: Target report template file missing at: ' + FReportName);
    Exit;
  end;

  // 1. Pack assigned indexed array variables cleanly into a valid JSON array string
  ParamJsonList := '';
  for i := 0 to ParamFields.Count - 1 do
  begin
    if (ParamFields[i].Name <> '') and (ParamFields[i].CurrentValue <> '') then
    begin
      ParamItemStr := Format('{"Name":"%s","Value":"%s"}', [
        ParamFields[i].Name,
        ParamFields[i].CurrentValue
      ]);

      if ParamJsonList <> '' then
        ParamJsonList := ParamJsonList + ',';

      ParamJsonList := ParamJsonList + ParamItemStr;
    end;
  end;

  // 2. Assemble the main JSON properties payload.
  // We use ReplaceStr to escape backslashes within paths cleanly so the C# JSON reader won't break.
  JsonData := Format(
    '{"ReportPath":"%s",' +
    '"ServerName":"%s",' +
    '"DatabaseName":"%s",' +
    '"UserID":"%s",' +
    '"Password":"%s",' +
    '"Parameters":[%s]}',
    [
      ReplaceStr(FReportName, '\', '\\'),
      Connect.ServerName,
      Connect.DatabaseName,
      Connect.UserID,
      Connect.Password,
      ParamJsonList
    ]
  );

  try
    // 3. Compress data down to a unified Base64 string to keep command-line strings stable
    Base64Payload := TNetEncoding.Base64.Encode(JsonData);

    // Strip out newline control blocks that standard Base64 headers append
    Base64Payload := ReplaceStr(Base64Payload, #13, '');
    Base64Payload := ReplaceStr(Base64Payload, #10, '');
    AppDir := ExtractFilePath(ParamStr(0));

    // 4. Command Windows to hand the package payload down to your custom compiled C# binary.
    // This looks for "CrystalRunner.exe" directly in your Delphi app's execution folder.
    ShellExecute(
      0,
      'open',
      PChar(AppDir + 'CrystalRunner.exe'), // Forces the program to look inside the active path
      PChar(Base64Payload),
      PChar(AppDir),                       // Explicitly maps the working execution directory
      SW_SHOWNORMAL
    );

  except
    on E: Exception do
      ShowMessage('Failed to execute modern C# bridge utility framework: ' + E.Message);
  end;
end;

end.

