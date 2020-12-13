unit FmMain;

interface

uses
  {VCL}
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  System.Actions,
  System.IOUtils,
  System.Generics.Collections,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.Menus,
  Vcl.ActnList,
  Vcl.StdCtrls,
  Vcl.ExtCtrls,
  {App}
  AppUITranslatorIntf,
  AppUITranslatorImpl,
  FmAbout;

type
  /// <summary>
  /// Example main form
  /// </summary>
  TFm_Example = class(TForm)
    MainMenu1: TMainMenu;
    MI_File: TMenuItem;
    MI_Options: TMenuItem;
    MI_Help: TMenuItem;
    MI_New: TMenuItem;
    MI_Open: TMenuItem;
    MI_Save: TMenuItem;
    N1: TMenuItem;
    MI_Exit: TMenuItem;
    MI_Configuration: TMenuItem;
    N2: TMenuItem;
    MI_Language: TMenuItem;
    MI_Contents: TMenuItem;
    N3: TMenuItem;
    MI_About: TMenuItem;
    ActionList1: TActionList;
    Act_New: TAction;
    Act_Open: TAction;
    Act_Save: TAction;
    Act_Exit: TAction;
    Act_Configuration: TAction;
    Act_Language: TAction;
    Act_Contents: TAction;
    Act_About: TAction;
    GBox_Customer: TGroupBox;
    Lbl_CustomerFirstName: TLabel;
    Edt_CustomerFirstName: TEdit;
    Lbl_CustomerLastName: TLabel;
    Edt_CustomerLastName: TEdit;
    Lbl_CustomerPhone: TLabel;
    Lbl_CustomerEmail: TLabel;
    Edt_CustomerPhone: TEdit;
    Edt_CustomerEmail: TEdit;
    GBox_Order: TGroupBox;
    Lbl_OrderNumber: TLabel;
    Lbl_OrderDate: TLabel;
    Lbl_OrderCost: TLabel;
    Lbl_OrderComment: TLabel;
    Edt_OrderNumber: TEdit;
    Edt_OrderDate: TEdit;
    Edt_OrderCost: TEdit;
    Edt_OrderComment: TEdit;
    Btn_Preview: TButton;
    Btn_Print: TButton;
    {}
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure MI_LanguageClick(Sender: TObject);
    {}
    procedure Act_NewExecute(Sender: TObject);
    procedure Act_OpenExecute(Sender: TObject);
    procedure Act_SaveExecute(Sender: TObject);
    procedure Act_ExitExecute(Sender: TObject);
    procedure Act_ConfigurationExecute(Sender: TObject);
    procedure Act_LanguageExecute(Sender: TObject);
    procedure Act_ContentsExecute(Sender: TObject);
    procedure Act_AboutExecute(Sender: TObject);
  strict private
    /// <summary> App UI translation API </summary>
    FUITranslationApi: IAppUITranslationApi;
  public
    procedure Translate(
      const AUITranslation: IAppUITranslation);
  end;

var
  Fm_Example: TFm_Example;

implementation

{$R *.dfm}

{ TFm_Example }

procedure TFm_Example.FormCreate(Sender: TObject);
begin
  inherited;

  var factory: IAppUITranslationApiFactory := TAppUITranslationApiFactory.Create();
  FUITranslationApi := factory.CreateApi();
end;

procedure TFm_Example.FormShow(Sender: TObject);
begin
  // create menu items with languages
  for var language in FUITranslationApi.Languages do
  begin
    var menuItem := TMenuItem.Create(nil);
    menuItem.OnClick := MI_LanguageClick;
    menuItem.Caption := language.LanguageName;
    menuItem.Tag     := language.LanguageID;
    if (language.LanguageID = 1033) then
      menuItem.Click();
    MI_Language.Add(menuItem);
  end;
end;

procedure TFm_Example.MI_LanguageClick(Sender: TObject);
begin
  if (Sender is TMenuItem) then
  begin
    if (not TMenuItem(Sender).Checked) then
    begin
      // check the menu item for the selected language
      for var i := 0 to MI_Language.Count - 1 do
        MI_Language[i].Checked := False;
      TMenuItem(Sender).Checked := True;

      // apply the selected language to the user interface
      for var language in FUITranslationApi.Languages do
        if (language.LanguageID = TMenuItem(Sender).Tag) then
        begin
          FUITranslationApi.SetLanguage(language.LanguageID);
          Translate(FUITranslationApi.Translation);
          Break;
        end;
    end;
  end;
end;

procedure TFm_Example.Act_NewExecute(Sender: TObject);
begin
  ShowMessage(Act_New.Hint);
end;

procedure TFm_Example.Act_OpenExecute(Sender: TObject);
begin
  ShowMessage(Act_Open.Hint);
end;

procedure TFm_Example.Act_SaveExecute(Sender: TObject);
begin
  ShowMessage(Act_Save.Hint);
end;

procedure TFm_Example.Act_ExitExecute(Sender: TObject);
begin
  Close();
end;

procedure TFm_Example.Act_ConfigurationExecute(Sender: TObject);
begin
  ShowMessage(Act_Configuration.Hint);
end;

procedure TFm_Example.Act_LanguageExecute(Sender: TObject);
begin
  {}
end;

procedure TFm_Example.Act_ContentsExecute(Sender: TObject);
begin
  ShowMessage(Act_Contents.Hint);
end;

procedure TFm_Example.Act_AboutExecute(Sender: TObject);
begin
  var Fm := TFm_About.Create(nil);
  try
    Fm.Translate(FUITranslationApi.Translation);
    Fm.ShowModal();
  finally
    FreeAndNil(Fm);
  end;
end;

procedure TFm_Example.Translate(
  const AUITranslation: IAppUITranslation);
begin
  if (AUITranslation.LanguageID > 0) then
  begin
    var s := 'Main';
    Self              .Caption := AUITranslation.GetText(s, '0', Self.Caption);
    {}
    MI_File           .Caption := AUITranslation.GetText(s, '100', MI_File.Caption);
    MI_Options        .Caption := AUITranslation.GetText(s, '200', MI_Options.Caption);
    MI_Help           .Caption := AUITranslation.GetText(s, '300', MI_Help.Caption);
    {}
    Act_New           .Caption := AUITranslation.GetText(s, '110', Act_New.Caption);
    Act_New           .Hint    := AUITranslation.GetText(s, '111', Act_New.Hint);
    Act_Open          .Caption := AUITranslation.GetText(s, '120', Act_Open.Caption);
    Act_Open          .Hint    := AUITranslation.GetText(s, '121', Act_Open.Hint);
    Act_Save          .Caption := AUITranslation.GetText(s, '130', Act_Save.Caption);
    Act_Save          .Hint    := AUITranslation.GetText(s, '131', Act_Save.Hint);
    Act_Exit          .Caption := AUITranslation.GetText(s, '150', Act_Exit.Caption);
    Act_Exit          .Hint    := AUITranslation.GetText(s, '151', Act_Exit.Hint);
    Act_Configuration .Caption := AUITranslation.GetText(s, '210', Act_Configuration.Caption);
    Act_Configuration .Hint    := AUITranslation.GetText(s, '211', Act_Configuration.Hint);
    Act_Language      .Caption := AUITranslation.GetText(s, '220', Act_Language.Caption);
    Act_Language      .Hint    := AUITranslation.GetText(s, '221', Act_Language.Hint);
    Act_Contents      .Caption := AUITranslation.GetText(s, '310', Act_Contents.Caption);
    Act_Contents      .Hint    := AUITranslation.GetText(s, '311', Act_Contents.Hint);
    Act_About         .Caption := AUITranslation.GetText(s, '320', Act_About.Caption);
    Act_About         .Hint    := AUITranslation.GetText(s, '321', Act_About.Hint);
    {}
    GBox_Customer         .Caption := AUITranslation.GetText(s, '1100', GBox_Customer.Hint);
    Lbl_CustomerFirstName .Caption := AUITranslation.GetText(s, '1101', Lbl_CustomerFirstName.Hint);
    Lbl_CustomerLastName  .Caption := AUITranslation.GetText(s, '1102', Lbl_CustomerLastName.Hint);
    Lbl_CustomerPhone     .Caption := AUITranslation.GetText(s, '1103', Lbl_CustomerPhone.Hint);
    Lbl_CustomerEmail     .Caption := AUITranslation.GetText(s, '1104', Lbl_CustomerEmail.Hint);
    GBox_Order            .Caption := AUITranslation.GetText(s, '1200', GBox_Order.Hint);
    Lbl_OrderNumber       .Caption := AUITranslation.GetText(s, '1201', Lbl_OrderNumber.Hint);
    Lbl_OrderDate         .Caption := AUITranslation.GetText(s, '1202', Lbl_OrderDate.Hint);
    Lbl_OrderCost         .Caption := AUITranslation.GetText(s, '1203', Lbl_OrderCost.Hint);
    Lbl_OrderComment      .Caption := AUITranslation.GetText(s, '1204', Lbl_OrderComment.Hint);
    Btn_Preview           .Caption := AUITranslation.GetText(s, '1301', Btn_Preview.Hint);
    Btn_Preview           .Hint    := AUITranslation.GetText(s, '1302', Btn_Preview.Hint);
    Btn_Print             .Caption := AUITranslation.GetText(s, '1401', Btn_Print.Hint);
    Btn_Print             .Hint    := AUITranslation.GetText(s, '1402', Btn_Print.Hint);
  end;
end;

end.
