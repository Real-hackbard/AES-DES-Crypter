object Form2: TForm2
  Left = 1652
  Top = 145
  BorderStyle = bsDialog
  Caption = 'Login'
  ClientHeight = 194
  ClientWidth = 578
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Shell Dlg 2'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object lblIteration: TLabel
    Left = 16
    Top = 160
    Width = 57
    Height = 13
    Caption = 'Iteration :'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lblKeyLen: TLabel
    Left = 184
    Top = 160
    Width = 47
    Height = 13
    Caption = 'KeyLen :'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object grpLogin: TGroupBox
    Left = 8
    Top = 8
    Width = 561
    Height = 97
    Caption = 'Login'
    TabOrder = 0
    object lblUserName: TLabel
      Left = 16
      Top = 16
      Width = 61
      Height = 13
      Caption = 'Username:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblPassword: TLabel
      Left = 16
      Top = 40
      Width = 81
      Height = 13
      Caption = 'Password        :'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblSecretKey: TLabel
      Left = 16
      Top = 64
      Width = 64
      Height = 13
      Caption = 'Secret Key:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object txtUserName: TEdit
      Left = 128
      Top = 16
      Width = 425
      Height = 21
      TabOrder = 0
      Text = 'https://www.gmx.net/consent-management/'
    end
    object txtPassword: TEdit
      Left = 128
      Top = 40
      Width = 425
      Height = 21
      PasswordChar = '*'
      TabOrder = 1
      Text = 'Password'
    end
    object txtSecretKey: TEdit
      Left = 128
      Top = 64
      Width = 425
      Height = 21
      TabOrder = 2
    end
  end
  object btnGenerate: TButton
    Left = 8
    Top = 112
    Width = 81
    Height = 25
    Caption = 'Generate'
    TabOrder = 1
    OnClick = btnGenerateClick
  end
  object BtnCheck: TButton
    Left = 96
    Top = 112
    Width = 75
    Height = 25
    Caption = 'Check'
    TabOrder = 2
    OnClick = BtnCheckClick
  end
  object txtIteration: TEdit
    Left = 88
    Top = 156
    Width = 41
    Height = 21
    TabOrder = 3
    Text = '1'
  end
  object txtKeyLen: TEdit
    Left = 256
    Top = 156
    Width = 57
    Height = 21
    TabOrder = 4
    Text = '32'
  end
  object chkHexa: TCheckBox
    Left = 352
    Top = 160
    Width = 65
    Height = 17
    Caption = 'HEX'
    Checked = True
    State = cbChecked
    TabOrder = 5
    OnClick = chkHexaClick
  end
  object btnInternalCheck: TButton
    Left = 384
    Top = 112
    Width = 185
    Height = 25
    Caption = 'Internal Verification'
    TabOrder = 6
    OnClick = btnInternalCheckClick
  end
end
