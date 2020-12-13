object Fm_Example: TFm_Example
  Left = 0
  Top = 0
  Caption = 'Fm_Main'
  ClientHeight = 241
  ClientWidth = 584
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  Position = poScreenCenter
  ShowHint = True
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object GBox_Customer: TGroupBox
    Left = 8
    Top = 8
    Width = 280
    Height = 135
    Caption = 'Customer'
    TabOrder = 0
    object Lbl_CustomerFirstName: TLabel
      Left = 10
      Top = 24
      Width = 50
      Height = 13
      Caption = 'First name'
    end
    object Lbl_CustomerLastName: TLabel
      Left = 10
      Top = 51
      Width = 49
      Height = 13
      Caption = 'Last name'
    end
    object Lbl_CustomerPhone: TLabel
      Left = 10
      Top = 78
      Width = 30
      Height = 13
      Caption = 'Phone'
    end
    object Lbl_CustomerEmail: TLabel
      Left = 10
      Top = 105
      Width = 28
      Height = 13
      Caption = 'E-mail'
    end
    object Edt_CustomerFirstName: TEdit
      Left = 104
      Top = 21
      Width = 165
      Height = 21
      MaxLength = 10
      TabOrder = 0
    end
    object Edt_CustomerLastName: TEdit
      Left = 104
      Top = 48
      Width = 165
      Height = 21
      MaxLength = 10
      TabOrder = 1
    end
    object Edt_CustomerPhone: TEdit
      Left = 104
      Top = 75
      Width = 165
      Height = 21
      MaxLength = 10
      TabOrder = 2
    end
    object Edt_CustomerEmail: TEdit
      Left = 104
      Top = 102
      Width = 165
      Height = 21
      MaxLength = 10
      TabOrder = 3
    end
  end
  object GBox_Order: TGroupBox
    Left = 296
    Top = 8
    Width = 280
    Height = 135
    Caption = 'Order'
    TabOrder = 1
    object Lbl_OrderNumber: TLabel
      Left = 10
      Top = 24
      Width = 37
      Height = 13
      Caption = 'Number'
    end
    object Lbl_OrderDate: TLabel
      Left = 10
      Top = 51
      Width = 23
      Height = 13
      Caption = 'Date'
    end
    object Lbl_OrderCost: TLabel
      Left = 10
      Top = 78
      Width = 22
      Height = 13
      Caption = 'Cost'
    end
    object Lbl_OrderComment: TLabel
      Left = 10
      Top = 105
      Width = 45
      Height = 13
      Caption = 'Comment'
    end
    object Edt_OrderNumber: TEdit
      Left = 104
      Top = 21
      Width = 165
      Height = 21
      MaxLength = 10
      TabOrder = 0
    end
    object Edt_OrderDate: TEdit
      Left = 104
      Top = 48
      Width = 165
      Height = 21
      MaxLength = 10
      TabOrder = 1
    end
    object Edt_OrderCost: TEdit
      Left = 104
      Top = 75
      Width = 165
      Height = 21
      MaxLength = 10
      TabOrder = 2
    end
    object Edt_OrderComment: TEdit
      Left = 104
      Top = 102
      Width = 165
      Height = 21
      MaxLength = 10
      TabOrder = 3
    end
  end
  object Btn_Preview: TButton
    Left = 400
    Top = 196
    Width = 75
    Height = 25
    Caption = 'Preview'
    TabOrder = 2
  end
  object Btn_Print: TButton
    Left = 490
    Top = 196
    Width = 75
    Height = 25
    Caption = 'Print'
    TabOrder = 3
  end
  object MainMenu1: TMainMenu
    Left = 104
    object MI_File: TMenuItem
      Caption = 'File'
      object MI_New: TMenuItem
        Action = Act_New
      end
      object MI_Open: TMenuItem
        Action = Act_Open
      end
      object MI_Save: TMenuItem
        Action = Act_Save
      end
      object N1: TMenuItem
        Caption = '-'
      end
      object MI_Exit: TMenuItem
        Action = Act_Exit
      end
    end
    object MI_Options: TMenuItem
      Caption = 'Options'
      object MI_Configuration: TMenuItem
        Action = Act_Configuration
      end
      object N2: TMenuItem
        Caption = '-'
      end
      object MI_Language: TMenuItem
        Action = Act_Language
      end
    end
    object MI_Help: TMenuItem
      Caption = 'Help'
      object MI_Contents: TMenuItem
        Action = Act_Contents
      end
      object N3: TMenuItem
        Caption = '-'
      end
      object MI_About: TMenuItem
        Action = Act_About
      end
    end
  end
  object ActionList1: TActionList
    Left = 144
    object Act_New: TAction
      Caption = 'New'
      Hint = 'Create new document'
      OnExecute = Act_NewExecute
    end
    object Act_Open: TAction
      Caption = 'Open'
      Hint = 'Open document'
      OnExecute = Act_OpenExecute
    end
    object Act_Save: TAction
      Caption = 'Save'
      Hint = 'Save document'
      OnExecute = Act_SaveExecute
    end
    object Act_Exit: TAction
      Caption = 'Exit'
      Hint = 'Close application'
      OnExecute = Act_ExitExecute
    end
    object Act_Configuration: TAction
      Caption = 'Configuration'
      OnExecute = Act_ConfigurationExecute
    end
    object Act_Contents: TAction
      Caption = 'Contents'
      OnExecute = Act_ContentsExecute
    end
    object Act_About: TAction
      Caption = 'About'
      Hint = 'Show the "About" window'
      OnExecute = Act_AboutExecute
    end
    object Act_Language: TAction
      Caption = 'Language'
      OnExecute = Act_LanguageExecute
    end
  end
end
