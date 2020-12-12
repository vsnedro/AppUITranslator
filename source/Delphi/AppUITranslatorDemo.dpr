program AppUITranslatorDemo;

uses
  Vcl.Forms,
  AppUITranslatorIntf in 'AppUITranslatorLib\AppUITranslatorIntf.pas',
  AppUITranslatorImpl in 'AppUITranslatorLib\AppUITranslatorImpl.pas',
  FmAbout in 'FmAbout.pas' {Fm_About},
  FmMain in 'FmMain.pas' {Fm_Example};

{$R *.res}

begin
  Application.Initialize();
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFm_Example, Fm_Example);
  Application.Run();
end.
