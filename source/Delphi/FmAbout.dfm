object Fm_About: TFm_About
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'About'
  ClientHeight = 221
  ClientWidth = 294
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Btn_Close: TButton
    Left = 112
    Top = 180
    Width = 75
    Height = 25
    Caption = 'Close'
    TabOrder = 0
    OnClick = Btn_CloseClick
  end
  object Pnl_About: TPanel
    Left = 8
    Top = 8
    Width = 278
    Height = 150
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 1
    object Lbl_Name: TLabel
      AlignWithMargins = True
      Left = 5
      Top = 5
      Width = 268
      Height = 30
      Align = alTop
      Alignment = taCenter
      AutoSize = False
      Caption = 'AppUITranslatorDemo'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      WordWrap = True
    end
    object Lbl_Description: TLabel
      AlignWithMargins = True
      Left = 5
      Top = 75
      Width = 268
      Height = 70
      Align = alBottom
      Alignment = taCenter
      AutoSize = False
      Caption = 
        'This is a demo application with an example of translating the ap' +
        'plication'#39's user interface.'
      WordWrap = True
      ExplicitTop = 106
    end
  end
end
