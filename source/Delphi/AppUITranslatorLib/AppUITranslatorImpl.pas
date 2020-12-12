unit AppUITranslatorImpl;

interface

uses
  {VCL}
  System.Classes,
  System.SysUtils,
  System.Generics.Collections,
  {App}
  AppUITranslatorIntf;

type
  /// <summary>
  /// App UI translation file
  /// </summary>
  TAppUITranslationFile = class(TInterfacedObject, IAppUITranslationFile)
  strict private
    /// <summary> Language identifier </summary>
    FLanguageID: integer;
    /// <summary> Language name </summary>
    FLanguageName: string;
    /// <summary> Full path to translation file </summary>
    FFullPath: string;
  private
    function GetLanguageID(): integer;
    function GetLanguageName(): string;
    function GetFullPath(): string;
  public
    /// <summary> Constructor </summary>
    /// <param name="ALanguageID"> Language identifier <see cref="T:integer"/> </param>
    /// <param name="ALanguageName"> Language name <see cref="T:string"/> </param>
    /// <param name="AFullPath"> Full path to translation file <see cref="T:string"/> </param>
    constructor Create(
      const ALanguageID  : integer;
      const ALanguageName: string;
      const AFullPath    : string);
  end;

type
  /// <summary>
  /// App UI translation source finder
  /// </summary>
  TAppUITranslationFileFinder = class(TInterfacedObject, IAppUITranslationFileFinder)
  private
    /// <summary> Find App UI translation files </summary>
    /// <param name="APath"> File search directory <see cref="T:string"/> </param>
    /// <param name="AMask"> File name mask <see cref="T:string"/> </param>
    function Find(
      const APath: String;
      const AMask: String): TArray<IAppUITranslationFile>;
  end;

type
  /// <summary>
  /// App UI default translation
  /// </summary>
  TAppUITranslationDefault = class(TInterfacedObject, IAppUITranslation)
  private
    /// <summary> Get text value for UI element </summary>
    /// <param name="ASection"> Section name <see cref="T:string"/> </param>
    /// <param name="AId"> UI element identifier <see cref="T:string"/> </param>
    /// <param name="ADefault"> Default text value <see cref="T:string"/> </param>
    function GetText(
      const ASection: string;
      const AId     : string;
      const ADefault: string = ''): string;
  end;

type
  /// <summary>
  /// App UI translation
  /// </summary>
  TAppUITranslation = class(TInterfacedObject, IAppUITranslation)
  strict private
    FDictionary: TDictionary<string, TDictionary<string, string>>;
  private
    /// <summary> Get text value for UI element </summary>
    /// <param name="ASection"> Section name <see cref="T:string"/> </param>
    /// <param name="AId"> UI element identifier <see cref="T:string"/> </param>
    /// <param name="ADefault"> Default text value <see cref="T:string"/> </param>
    function GetText(
      const ASection: string;
      const AId     : string;
      const ADefault: string = ''): string;
  public
    /// <summary> Constructor </summary>
    /// <param name="ADictionary"> Dictionary that allows to get a collection of text values for a given section <see cref="T:TDictionary"/> </param>
    constructor Create(
      const ADictionary: TDictionary<string, TDictionary<string, string>>);
    /// <summary> Destructor </summary>
    destructor Destroy(); override;
  end;

type
  /// <summary>
  /// App UI translation reader
  /// </summary>
  TAppUITranslationReader = class(TInterfacedObject, IAppUITranslationReader)
  strict private
    FFileName: string;
    FStream: TStream;
    FEncoding: TEncoding;
  private
    /// <summary> Read App UI translation </summary>
    function Read(): IAppUITranslation;
  public
    /// <summary> Constructor </summary>
    constructor Create(
      const AFileName: string); overload;
    /// <summary> Constructor </summary>
    constructor Create(
      const AFileName: string; 
      const AEncoding: TEncoding); overload;
    /// <summary> Constructor </summary>
    constructor Create(
      const AStream: TStream); overload; virtual;
    /// <summary> Constructor </summary>
    constructor Create(
      const AStream  : TStream;
      const AEncoding: TEncoding); overload; virtual;
    /// <summary> Destructor </summary>
    destructor Destroy(); override;
  end;

type
  /// <summary>
  /// App UI element
  /// </summary>
  TAppUIElement = class(TInterfacedObject, IAppUIElement)
  strict private
    /// <summary> Section name </summary>
    FSection: string;
    /// <summary> Identifier </summary>
    FId: string;
    /// <summary> Text value </summary>
    FText: string;
  private
    function GetSection(): string;
    function GetId(): string;
    function GetText(): string;
    procedure SetText(const value: string);
  public
    /// <summary> Constructor </summary>
    /// <param name="ASection"> Section name <see cref="T:string"/> </param>
    /// <param name="AId"> Identifier <see cref="T:string"/> </param>
    /// <param name="AText"> Text value <see cref="T:string"/> </param>
    constructor Create(
      const ASection: string;
      const AId     : string;
      const AText   : string);
  end;

type
  /// <summary>
  /// App UI translator
  /// </summary>
  TAppUITranslator = class(TInterfacedObject, IAppUITranslator)
  private
    /// <summary> Translate App UI </summary>
    /// <param name="AView"> App UI view to translate <see cref="T:IAppUIView"/> </param>
    /// <param name="ATranslation"> Translation for UI view <see cref="T:IAppUITranslation"/> </param>
    procedure Translate(
      const AView       : IAppUIView;
      const ATranslation: IAppUITranslation);
  end;

implementation

uses
  System.IniFiles;

{------------------------------------------------------------------------------}
{ TAppUITranslationFile }
{------------------------------------------------------------------------------}

/// <summary> Constructor </summary>
constructor TAppUITranslationFile.Create(
  const ALanguageID  : integer;
  const ALanguageName: string;
  const AFullPath    : string);
begin
  inherited Create();

  FLanguageID   := ALanguageID;
  FLanguageName := ALanguageName;
  FFullPath     := AFullPath;
end;

function TAppUITranslationFile.GetLanguageID(): integer;
begin
  Result := FLanguageID;
end;

function TAppUITranslationFile.GetLanguageName(): string;
begin
  Result := FLanguageName;
end;

function TAppUITranslationFile.GetFullPath(): string;
begin
  Result := FFullPath;
end;

{------------------------------------------------------------------------------}
{ TAppUITranslationFileFinder }
{------------------------------------------------------------------------------}

/// <summary> Find App UI translation files </summary>
function TAppUITranslationFileFinder.Find(
  const APath: String;
  const AMask: String): TArray<IAppUITranslationFile>;
var
  searchRec: TSearchRec;
begin
  var files := TList<IAppUITranslationFile>.Create();
  try
    var filePath := IncludeTrailingPathDelimiter(APath);
    var findRes  := FindFirst(filePath + AMask, faAnyFile, {var}searchRec);
    try
      while (findRes = 0) do
      begin
        // read the header of the found file
        var ini := TMemIniFile.Create(filePath + searchRec.Name);
        try
          var section  := 'FileInfo';
          var langID   := ini.ReadInteger(section, 'LanguageID', 0);
          var langName := ini.ReadString (section, 'LanguageName', '');

          if (langID > 0) and (langName.Length > 0) then
          begin
            var file_ := TAppUITranslationFile.Create(
              langID, langName, filePath + searchRec.Name);
            files.Add(file_);
          end;
        finally
          FreeAndNil(ini);
        end;

        findRes := FindNext({var}searchRec);
      end;
    finally
      FindClose(searchRec);
    end;

    Result := files.ToArray();
  except
    FreeAndNil(files);
  end;
end;

{------------------------------------------------------------------------------}
{ TAppUITranslationDefault }
{------------------------------------------------------------------------------}

/// <summary> Get text value for UI element </summary>
function TAppUITranslationDefault.GetText(
  const ASection: string;
  const AId     : string;
  const ADefault: string = ''): string;
begin
  Result := ADefault;
end;

{------------------------------------------------------------------------------}
{ TAppUITranslation }
{------------------------------------------------------------------------------}

/// <summary> Constructor </summary>
constructor TAppUITranslation.Create(
  const ADictionary: TDictionary<string, TDictionary<string, string>>);
begin  
  inherited Create();

  if not Assigned(ADictionary) then
    raise EArgumentNilException.Create('ADictionary');
  
  FDictionary := ADictionary;
end;

/// <summary> Destructor </summary>
destructor TAppUITranslation.Destroy(); 
begin  
  FreeAndNil(FDictionary);

  inherited Destroy();
end;

/// <summary> Get text value for UI element </summary>
function TAppUITranslation.GetText(
  const ASection: string;
  const AId     : string;
  const ADefault: string = ''): string;
begin
  Result := ADefault;

  var values: TDictionary<string, string>;
  if (FDictionary.TryGetValue(ASection, {out}values)) then
    if (not values.TryGetValue(AId, {out}Result)) then
      Result := ADefault;
end;

{------------------------------------------------------------------------------}
{ TAppUITranslationReader }
{------------------------------------------------------------------------------}

/// <summary> Constructor </summary>
constructor TAppUITranslationReader.Create(
  const AFileName: string);
begin
  Create(AFileName, nil);
end;

/// <summary> Constructor </summary>
constructor TAppUITranslationReader.Create(
  const AFileName: string;
  const AEncoding: TEncoding);
begin
  inherited Create();

  if (AFileName.Length <= 0) then
    raise EArgumentNilException.Create('AFileName');

  FFileName := AFileName;
  FEncoding := AEncoding;
end;
  
/// <summary> Constructor </summary>
constructor TAppUITranslationReader.Create(
  const AStream: TStream);
begin
  Create(AStream, nil);
end;
  
/// <summary> Constructor </summary>
constructor TAppUITranslationReader.Create(
  const AStream  : TStream;
  const AEncoding: TEncoding);  
begin
  inherited Create();

  FStream   := AStream;
  FEncoding := AEncoding;
end;
  
/// <summary> Destructor </summary>
destructor TAppUITranslationReader.Destroy(); 
begin
  FreeAndNil(FStream);
  FreeAndNil(FEncoding);

  inherited Destroy();
end;

/// <summary> Read App UI translation </summary>
function TAppUITranslationReader.Read(): IAppUITranslation;
begin
  var dict := TDictionary<string, TDictionary<string, string>>.Create();
  try
    if (not Assigned(FStream)) then
      if (FileExists(FFileName)) then
        FStream := TFileStream.Create(FFileName, fmOpenRead);

    if (Assigned(FStream)) then
    begin
      var ini := TMemIniFile.Create(FStream, FEncoding);
      try
        // read all sections
        var sections := TStringList.Create();
        try
          ini.ReadSections(sections);
          var strings := TStringList.Create();
          try
            // read values form each section
            for var i := 0 to sections.Count - 1 do
            begin
              ini.ReadSectionValues(sections[i], strings);
              var dictValues := TDictionary<string, string>.Create();
              for var j := 0 to strings.Count - 1 do
                dictValues.Add(strings.KeyNames[j], strings.ValueFromIndex[j]);
              dict.Add(sections[i], dictValues);
            end;
          finally
            FreeAndNil(strings);
          end;
        finally
          FreeAndNil(sections);
        end;
      finally
        FreeAndNil(ini);
      end;
    end;

    // create result with dictionary
    Result := TAppUITranslation.Create(dict);
  except
    FreeAndNil(dict);
    raise;
  end;
end;

{------------------------------------------------------------------------------}
{ TAppUIElement }
{------------------------------------------------------------------------------}

/// <summary> Constructor </summary>
constructor TAppUIElement.Create(
  const ASection: string;
  const AId     : string;
  const AText   : string);
begin
  inherited Create();

  FSection := ASection;
  FId      := AId;
  FText    := AText;
end;

function TAppUIElement.GetSection(): string;
begin
  Result := FSection;
end;

function TAppUIElement.GetId(): string;
begin
  Result := FId;
end;

function TAppUIElement.GetText(): string;
begin
  Result := FText;
end;

procedure TAppUIElement.SetText(const value: string);
begin
  FText := value;
end;

{------------------------------------------------------------------------------}
{ TAppUITranslator }
{------------------------------------------------------------------------------}

/// <summary> Translate App UI </summary>
procedure TAppUITranslator.Translate(
  const AView       : IAppUIView;
  const ATranslation: IAppUITranslation);
begin
  for var element in AView.Elements do
  begin
    var text := ATranslation.GetText(element.Section, element.Id);
    if (text.Length >= 0) then
      element.Text := text;
  end;
end;

end.
