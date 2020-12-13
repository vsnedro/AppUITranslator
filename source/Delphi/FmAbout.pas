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
  TFm_About = class(TForm)
    Btn_Close: TButton;
    Pnl_About: TPanel;
    Lbl_Name: TLabel;
    Lbl_Description: TLabel;
    {}
    procedure Btn_CloseClick(Sender: TObject);
  public
    procedure Translate(
      const AUITranslation: IAppUITranslation);
  end;

implementation

{$R *.dfm}

{ TFm_About }

procedure TFm_About.Btn_CloseClick(Sender: TObject);
begin
  Close();
end;

procedure TFm_About.Translate(
  const AUITranslation: IAppUITranslation);
begin
  if (AUITranslation.LanguageID > 0) then
  begin
    var s := 'About';
    Self           .Caption := AUITranslation.GetText(s, '0', Self.Caption);
    Lbl_Name       .Caption := AUITranslation.GetText(s, '1', Lbl_Name.Caption);
    Lbl_Description.Caption := AUITranslation.GetText(s, '2', Lbl_Description.Caption);
    Btn_Close      .Caption := AUITranslation.GetText(s, '3', Btn_Close.Caption);
  end;
end;

end.
