unit AppUITranslatorIntf;

interface

type
  /// <summary>
  /// App UI translation file
  /// </summary>
  IAppUITranslationFile = interface
    ['{A8E816A9-9F67-4EDB-9718-A060C949B7EB}']
    function GetLanguageID(): integer;
    function GetLanguageName(): string;
    function GetFullPath(): string;

    /// <summary> Language identifier </summary>
    property LanguageID: integer read GetLanguageID;
    /// <summary> Language name </summary>
    property LanguageName: string read GetLanguageName;
    /// <summary> Full path to translation file </summary>
    property FullPath: string read GetFullPath;
  end;

type
  /// <summary>
  /// App UI translation file finder
  /// </summary>
  IAppUITranslationFileFinder = interface
    ['{04BA9574-445E-46DD-8932-93808DE5CEDF}']
    /// <summary> Find App UI translation files </summary>
    /// <param name="APath"> File search directory <see cref="T:string"/> </param>
    /// <param name="AMask"> File name mask <see cref="T:string"/> </param>
    function Find(
      const APath: String;
      const AMask: String): TArray<IAppUITranslationFile>;
  end;

type
  /// <summary>
  /// App UI translation
  /// </summary>
  IAppUITranslation = interface
    ['{E8FB9A1B-BE9E-495C-AEB6-DE1D3453741A}']
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
  /// App UI translation reader
  /// </summary>
  IAppUITranslationReader = interface
    ['{B6B508C4-AB7C-4FA7-A2C3-B55F4EDBA22C}']
    /// <summary> Read App UI translation </summary>
    function Read(): IAppUITranslation;
  end;

type
  /// <summary>
  /// App UI element
  /// </summary>
  IAppUIElement = interface
    ['{5D13FFB1-FD59-4678-9750-08FB4B370A4D}']
    function GetSection(): string;
    function GetId(): string;
    function GetText(): string;
    procedure SetText(const value: string);

    /// <summary> Section name </summary>
    property Section: string read GetSection;
    /// <summary> Identifier </summary>
    property Id: string read GetId;
    /// <summary> Text value </summary>
    property Text: string read GetText write SetText;
  end;

type
  /// <summary>
  /// App UI view
  /// </summary>
  IAppUIView = interface
    ['{17747731-1E84-439C-B4BA-75329EFA7B80}']
    function GetElements(): TArray<IAppUIElement>;

    /// <summary> App UI elements </summary>
    property Elements: TArray<IAppUIElement> read GetElements;
  end;

type
  /// <summary>
  /// App UI translator
  /// </summary>
  IAppUITranslator = interface
    ['{4DBD5C20-A428-41C5-B9C2-CEFD348677DF}']
    /// <summary> Translate App UI </summary>
    /// <param name="AView"> App UI view to translate <see cref="T:IAppUIView"/> </param>
    /// <param name="ATranslation"> Translation for UI view <see cref="T:IAppUITranslation"/> </param>
    procedure Translate(
      const AView       : IAppUIView;
      const ATranslation: IAppUITranslation);
  end;

implementation

end.
