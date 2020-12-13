unit AppUITranslatorIntf;

interface

uses
  System.Classes;

type
  /// <summary>
  /// App UI language
  /// </summary>
  IAppUILanguage = interface
    ['{27B4B48E-F80D-497A-9912-75AEFD956E50}']
    function GetLanguageID(): integer;
    function GetLanguageName(): string;

    /// <summary> Language identifier </summary>
    property LanguageID: integer read GetLanguageID;
    /// <summary> Language name </summary>
    property LanguageName: string read GetLanguageName;
  end;

type
  /// <summary>
  /// App UI language file
  /// </summary>
  IAppUILanguageFile = interface
    ['{A8E816A9-9F67-4EDB-9718-A060C949B7EB}']
    function GetLanguageID(): integer;
    function GetLanguageName(): string;
    function GetFullPath(): string;

    /// <summary> Language identifier </summary>
    property LanguageID: integer read GetLanguageID;
    /// <summary> Language name </summary>
    property LanguageName: string read GetLanguageName;
    /// <summary> Full path to language file </summary>
    property FullPath: string read GetFullPath;
  end;

type
  /// <summary>
  /// App UI language file finder
  /// </summary>
  IAppUILanguageFileFinder = interface
    ['{04BA9574-445E-46DD-8932-93808DE5CEDF}']
    /// <summary> Find App UI language files </summary>
    function Find(): TArray<IAppUILanguageFile>; overload;
    /// <summary> Find App UI language files </summary>
    /// <param name="ADirectory"> File search directory <see cref="T:string"/> </param>
    /// <param name="AFileMask"> File name mask <see cref="T:string"/> </param>
    function Find(
      const ADirectory: String;
      const AFileMask : String): TArray<IAppUILanguageFile>; overload;
  end;

type
  /// <summary>
  /// App UI translation
  /// </summary>
  IAppUITranslation = interface
    ['{E8FB9A1B-BE9E-495C-AEB6-DE1D3453741A}']
    /// <summary> Get language identifier </summary>
    function GetLanguageID(): integer;

    /// <summary> Get text value for UI element </summary>
    /// <param name="ASection"> Section name <see cref="T:string"/> </param>
    /// <param name="AId"> UI element identifier <see cref="T:string"/> </param>
    /// <param name="ADefault"> Default text value <see cref="T:string"/> </param>
    function GetText(
      const ASection: string;
      const AId     : string;
      const ADefault: string = ''): string;

    /// <summary> Language identifier </summary>
    property LanguageID: integer read GetLanguageID;
  end;

type
  /// <summary>
  /// App UI translation loader
  /// </summary>
  IAppUITranslationLoader = interface
    ['{B6B508C4-AB7C-4FA7-A2C3-B55F4EDBA22C}']
    /// <summary> Loads a translation from a file </summary>
    function LoadFromFile(
      const AFileName: string): IAppUITranslation;
    /// <summary> Loads a translation from a stream </summary>
    function LoadFromStream(
      const AStream: TStream): IAppUITranslation;
  end;

type
  /// <summary>
  /// App UI translation API
  /// </summary>
  IAppUITranslationApi = interface
    ['{065CC249-08BE-46CB-B22C-B03C0FC8266A}']
    /// <summary> Get list of available languages for translating the App UI </summary>
    function GetLanguages(): TArray<IAppUILanguageFile>;
    /// <summary> Get current App UI translation </summary>
    function GetTranslation(): IAppUITranslation;

    /// <summary> Set App UI translation by language identifier </summary>
    /// <param name="ALanguageID"> Language identifier <see cref="T:integer"/> </param>
    procedure SetLanguage(
      const ALanguageID: integer);

    /// <summary> List of available languages for translating the App UI </summary>
    property Languages: TArray<IAppUILanguageFile> read GetLanguages;
    /// <summary> Current App UI translation </summary>
    property Translation: IAppUITranslation read GetTranslation;
  end;

type
  /// <summary>
  /// App UI translation API Factory
  /// </summary>
  IAppUITranslationApiFactory = interface
    ['{A8A02F09-B5B5-4946-824F-02263453E25E}']
    /// <summary> Create instance of App UI translation API </summary>
    function CreateApi(): IAppUITranslationApi;
  end;

implementation

end.
