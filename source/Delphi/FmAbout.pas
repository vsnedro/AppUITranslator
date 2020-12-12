unit FmAbout;

interface

uses
  {VCL}
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  System.Generics.Collections,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.StdCtrls,
  Vcl.ExtCtrls,
  {App}
  AppUITranslatorIntf;

type
  /// <summary>
  /// Form "About"
  /// </summary>
  TFm_About = class(TForm, IAppUIView)
    Btn_Close: TButton;
    Pnl_About: TPanel;
    Lbl_Name: TLabel;
    Lbl_Description: TLabel;
    procedure Btn_CloseClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  strict private
    FElements: TList<IAppUIElement>;
  private
    {$REGION ' IAppUIView '}
    function GetElements(): TArray<IAppUIElement>;
    {$ENDREGION}
  public
    procedure Translate(
      const AUITranslation: IAppUITranslation);
  end;

implementation

{$R *.dfm}

{ TFm_About }

procedure TFm_About.FormCreate(Sender: TObject);
begin
  inherited;

  FElements := TList<IAppUIElement>.Create();
end;

procedure TFm_About.FormDestroy(Sender: TObject);
begin
  FreeAndNil(FElements);

  inherited;
end;

procedure TFm_About.Btn_CloseClick(Sender: TObject);
begin
  Close();
end;

{$REGION ' IAppUIView '}
function TFm_About.GetElements: TArray<IAppUIElement>;
begin
  Result := FElements.ToArray();
end;
{$ENDREGION}

procedure TFm_About.Translate(
  const AUITranslation: IAppUITranslation);
begin
  var s := 'About';
  Self           .Caption := AUITranslation.GetText(s, '0', Self.Caption);
  Lbl_Name       .Caption := AUITranslation.GetText(s, '1', Lbl_Name.Caption);
  Lbl_Description.Caption := AUITranslation.GetText(s, '2', Lbl_Description.Caption);
  Btn_Close      .Caption := AUITranslation.GetText(s, '3', Btn_Close.Caption);
end;

end.
