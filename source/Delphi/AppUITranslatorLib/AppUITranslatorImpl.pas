unit AppUITranslatorImpl;

interface

uses
  {VCL}
  System.Classes,
  System.Generics.Collections,
  {App}
  AppUITranslatorIntf;

type
  /// <summary>
  /// App UI language file
  /// </summary>
  TAppUILanguageFile = class(TInterfacedObject, IAppUILanguage, IAppUILanguageFile)
  strict private
    /// <summary> Language identifier </summary>
    FLanguageID: integer;
    /// <summary> Language name </summary>
    FLanguageName: string;
    /// <summary> Full path to language file </summary>
    FFullPath: string;
  public
    /// <summary> Get language identifier </summary>
    function GetLanguageID(): integer;
    /// <summary> Get language name </summary>
    function GetLanguageName(): string;
    /// <summary> Get full path to language file </summary>
    function GetFullPath(): string;
  public
    /// <summary> Constructor </summary>
    /// <param name="ALanguageID"> Language identifier <see cref="T:integer"/> </param>
    /// <param name="ALanguageName"> Language name <see cref="T:string"/> </param>
    /// <param name="AFullPath"> Full path to language file <see cref="T:string"/> </param>
    constructor Create(
      const ALanguageID  : integer;
      const ALanguageName: string;
      const AFullPath    : string);
  end;

type
  /// <summary>
  /// App UI translation source finder
  /// </summary>
  TAppUILanguageFileFinder = class(TInterfacedObject, IAppUILanguageFileFinder)
  strict private
  const
    /// <summary> Default file search directory </summary>
    CDefaultFilePath = 'Languages';
    /// <summary> Default file name mask </summary>
    CDefaultFileMask = '*.lng';
  public
    /// <summary> Find App UI language files </summary>
    function Find(): TArray<IAppUILanguageFile>; overload;
    /// <summary> Find App UI language files </summary>
    /// <param name="AFilePath"> File search directory <see cref="T:string"/> </param>
    /// <param name="AFileMask"> File name mask <see cref="T:string"/> </param>
    function Find(
      const AFilePath: String;
      const AFileMask: String): TArray<IAppUILanguageFile>; overload;
  end;

type
  /// <summary>
  /// App UI default translation
  /// </summary>
  TAppUITranslationCustom = class abstract(TInterfacedObject, IAppUITranslation)
  strict private
    /// <summary> Language identifier </summary>
    FLanguageID: integer;
  private
    /// <summary> Get language identifier </summary>
    function GetLanguageID(): integer;
  public
    /// <summary> Get text value for UI element </summary>
    /// <param name="ASection"> Section name <see cref="T:string"/> </param>
    /// <param name="AId"> UI element identifier <see cref="T:string"/> </param>
    /// <param name="ADefault"> Default text value <see cref="T:string"/> </param>
    function GetText(
      const ASection: string;
      const AId     : string;
      const ADefault: string = ''): string; virtual; abstract;
  public
    /// <summary> Constructor </summary>
    /// <param name="ALanguageID"> Language identifier <see cref="T:integer"/> </param>
    constructor Create(
      const ALanguageID: integer);
  end;

type
  /// <summary>
  /// App UI default translation
  /// </summary>
  TAppUITranslationDefault = class(TAppUITranslationCustom)
  public
    /// <summary> Get text value for UI element </summary>
    /// <param name="ASection"> Section name <see cref="T:string"/> </param>
    /// <param name="AId"> UI element identifier <see cref="T:string"/> </param>
    /// <param name="ADefault"> Default text value <see cref="T:string"/> </param>
    function GetText(
      const ASection: string;
      const AId     : string;
      const ADefault: string = ''): string; override;
  end;

type
  /// <summary>
  /// App UI translation
  /// </summary>
  TAppUITranslation = class(TAppUITranslationCustom)
  strict private
    FDictionary: TDictionary<string, TDictionary<string, string>>;
  public
    /// <summary> Get text value for UI element </summary>
    /// <param name="ASection"> Section name <see cref="T:string"/> </param>
    /// <param name="AId"> UI element identifier <see cref="T:string"/> </param>
    /// <param name="ADefault"> Default text value <see cref="T:string"/> </param>
    function GetText(
      const ASection: string;
      const AId     : string;
      const ADefault: string = ''): string; override;
  public
    /// <summary> Constructor </summary>
    /// <param name="ALanguageID"> Language identifier <see cref="T:integer"/> </param>
    /// <param name="ADictionary"> Dictionary that allows to get a collection of text values for a given section <see cref="T:TDictionary"/> </param>
    constructor Create(
      const ALanguageID: integer;
      const ADictionary: TDictionary<string, TDictionary<string, string>>);
    /// <summary> Destructor </summary>
    destructor Destroy(); override;
  end;

type
  /// <summary>
  /// App UI translation loader
  /// </summary>
  TAppUITranslationLoader = class(TInterfacedObject, IAppUITranslationLoader)
  strict private
    /// <summary> Loads a translation from a stream </summary>
    /// <param name="AStream"> Data stream <see cref="T:TStream"/> </param>
    function LoadTranslation(
      const AStream: TStream): IAppUITranslation;
  public
    /// <summary> Loads a translation from a file </summary>
    /// <param name="AFileName"> Full path to the file <see cref="T:string"/> </param>
    function LoadFromFile(
      const AFileName: string): IAppUITranslation;
    /// <summary> Loads a translation from a stream </summary>
    /// <param name="AStream"> Data stream <see cref="T:TStream"/> </param>
    function LoadFromStream(
      const AStream: TStream): IAppUITranslation;
  end;

type
  /// <summary>
  /// App UI translation API
  /// </summary>
  TAppUITranslationApi = class(TInterfacedObject, IAppUITranslationApi)
  strict private
    /// <summary> App UI translation loader </summary>
    FLoader: IAppUITranslationLoader;
    /// <summary> List of App UI language files </summary>
    FLangFiles: TArray<IAppUILanguageFile>;
    /// <summary> Current App UI translation </summary>
    FTranslation: IAppUITranslation;
  private
    /// <summary> Get list of available languages for translating the App UI </summary>
    function GetLanguages(): TArray<IAppUILanguageFile>;
    /// <summary> Get current App UI translation </summary>
    function GetTranslation(): IAppUITranslation;
  public
    /// <summary> Set App UI translation by language identifier </summary>
    /// <param name="ALanguageID"> Language identifier <see cref="T:integer"/> </param>
    procedure SetLanguage(
      const ALanguageID: integer);
  public
    /// <summary> Constructor </summary>
    /// <param name="AFileFinder"> App UI language file finder <see cref="T:IAppUILanguageFileFinder"/> </param>
    /// <param name="ALoader"> App UI translation loader <see cref="T:IAppUITranslationLoader"/> </param>
    constructor Create(
      const AFileFinder: IAppUILanguageFileFinder;
      const ALoader    : IAppUITranslationLoader);
    /// <summary> Destructor </summary>
    destructor Destroy(); override;
  end;

type
  /// <summary>
  /// App UI translation API Factory
  /// </summary>
  TAppUITranslationApiFactory = class(TInterfacedObject, IAppUITranslationApiFactory)
  public
    /// <summary> Create instance of App UI translation API </summary>
    function CreateApi(): IAppUITranslationApi;
  end;

implementation

uses
  System.SysUtils,
  System.IniFiles;

{------------------------------------------------------------------------------}
{ TAppUILanguageFile }
{------------------------------------------------------------------------------}

/// <summary> Constructor </summary>
constructor TAppUILanguageFile.Create(
  const ALanguageID  : integer;
  const ALanguageName: string;
  const AFullPath    : string);
begin
  inherited Create();

  FLanguageID   := ALanguageID;
  FLanguageName := ALanguageName;
  FFullPath     := AFullPath;
end;

/// <summary> Get language identifier </summary>
function TAppUILanguageFile.GetLanguageID(): integer;
begin
  Result := FLanguageID;
end;

/// <summary> Get language name </summary>
function TAppUILanguageFile.GetLanguageName(): string;
begin
  Result := FLanguageName;
end;

/// <summary> Get full path to language file </summary>
function TAppUILanguageFile.GetFullPath(): string;
begin
  Result := FFullPath;
end;

{------------------------------------------------------------------------------}
{ TAppUILanguageFileFinder }
{------------------------------------------------------------------------------}

/// <summary> Find App UI language files </summary>
function TAppUILanguageFileFinder.Find(): TArray<IAppUILanguageFile>;
begin
  Result := Find(CDefaultFilePath, CDefaultFileMask);
end;

/// <summary> Find App UI language files </summary>
function TAppUILanguageFileFinder.Find(
  const AFilePath: String;
  const AFileMask: String): TArray<IAppUILanguageFile>;
var
  searchRec: TSearchRec;
begin
  var files := TList<IAppUILanguageFile>.Create();
  try
    var filePath := IncludeTrailingPathDelimiter(AFilePath);
    var findRes  := FindFirst(filePath + AFileMask, faAnyFile, {var}searchRec);
    try
      while (findRes = 0) do
      begin
        // read the header of the found file
        var ini := TMemIniFile.Create(filePath + searchRec.Name);
        try
          var langID   := ini.ReadInteger('FileInfo', 'LanguageID', 0);
          var langName := ini.ReadString ('FileInfo', 'LanguageName', '');
          if (langID > 0) then
          begin
            var file_ := TAppUILanguageFile.Create(
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
{ TAppUITranslationCustom }
{------------------------------------------------------------------------------}

/// <summary> Constructor </summary>
constructor TAppUITranslationCustom.Create(
  const ALanguageID: integer);
begin
  inherited Create();

  FLanguageID := ALanguageID;
end;

/// <summary> Get language identifier </summary>
function TAppUITranslationCustom.GetLanguageID(): integer;
begin
  Result := FLanguageID;
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
  const ALanguageID: integer;
  const ADictionary: TDictionary<string, TDictionary<string, string>>);
begin  
  inherited Create(ALanguageID);

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
{ TAppUITranslationLoader }
{------------------------------------------------------------------------------}

/// <summary> Loads a translation from a file </summary>
function TAppUITranslationLoader.LoadFromFile(
  const AFileName: string): IAppUITranslation;
begin
  var stream := TMemoryStream.Create();
  try
    stream.LoadFromFile(AFileName);
    Result := LoadFromStream(stream);
  finally
    FreeAndNil(stream);
  end;
end;

/// <summary> Loads a translation from a stream </summary>
function TAppUITranslationLoader.LoadFromStream(
  const AStream: TStream): IAppUITranslation;
begin
  Result := LoadTranslation(AStream);
end;

/// <summary> Loads a translation from a stream </summary>
function TAppUITranslationLoader.LoadTranslation(
  const AStream: TStream): IAppUITranslation;
begin
  var languageID: integer := 0;

  var dict := TDictionary<string, TDictionary<string, string>>.Create();
  try
    var ini := TMemIniFile.Create(AStream);
    try
      languageID := ini.ReadInteger('FileInfo', 'LanguageID', 0);

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

    // create result with dictionary
    Result := TAppUITranslation.Create(languageID, dict);
  except
    FreeAndNil(dict);
    raise;
  end;
end;

{------------------------------------------------------------------------------}
{ TAppUITranslationApi }
{------------------------------------------------------------------------------}

/// <summary> Constructor </summary>
constructor TAppUITranslationApi.Create(
  const AFileFinder: IAppUILanguageFileFinder;
  const ALoader    : IAppUITranslationLoader);
begin
  inherited Create();

  if (not Assigned(AFileFinder)) then
    raise EArgumentNilException.Create('AFileFinder');
  if (not Assigned(ALoader)) then
    raise EArgumentNilException.Create('ALoader');

  FLoader      := ALoader;
  FLangFiles   := AFileFinder.Find();
  FTranslation := TAppUITranslationDefault.Create(0);
end;

/// <summary> Destructor </summary>
destructor TAppUITranslationApi.Destroy();
begin
  SetLength(FLangFiles, 0);

  inherited Destroy();
end;

/// <summary> Get list of available languages for translating the App UI </summary>
function TAppUITranslationApi.GetLanguages(): TArray<IAppUILanguageFile>;
begin
  Result := FLangFiles;
end;

/// <summary> Get current App UI translation </summary>
function TAppUITranslationApi.GetTranslation(): IAppUITranslation;
begin
  Result := FTranslation;
end;

/// <summary> Set App UI translation by language identifier </summary>
procedure TAppUITranslationApi.SetLanguage(
  const ALanguageID: integer);
begin
  if (FTranslation.LanguageID <> ALanguageID) then
    for var langFile in FLangFiles do
      if (langFile.LanguageID = ALanguageID) then
      begin
        FTranslation := FLoader.LoadFromFile(langFile.FullPath);
        Break;
      end;
end;

{------------------------------------------------------------------------------}
{ TAppUITranslationApiFactory }
{------------------------------------------------------------------------------}

/// <summary> Create instance of App UI translation API </summary>
function TAppUITranslationApiFactory.CreateApi(): IAppUITranslationApi;
begin
  var fileFinder: IAppUILanguageFileFinder := TAppUILanguageFileFinder.Create();
  var fileLoader: IAppUITranslationLoader  := TAppUITranslationLoader.Create();

  Result := TAppUITranslationApi.Create(fileFinder, fileLoader);
end;

end.
