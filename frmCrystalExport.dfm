object frm_crystal_export: Tfrm_crystal_export
  Left = 0
  Top = 0
  Caption = 'Crystal Export'
  ClientHeight = 246
  ClientWidth = 417
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnCreate = FormCreate
  TextHeight = 15
  object Label1: TLabel
    Left = 263
    Top = 19
    Width = 42
    Height = 15
    Caption = 'Param1'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label2: TLabel
    Left = 263
    Top = 67
    Width = 42
    Height = 15
    Caption = 'Param2'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label3: TLabel
    Left = 263
    Top = 111
    Width = 42
    Height = 15
    Caption = 'Param3'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object ButtonImprimir: TButton
    Left = 168
    Top = 197
    Width = 97
    Height = 41
    Caption = 'Print'
    TabOrder = 0
    OnClick = ButtonImprimirClick
  end
  object edtParam1: TEdit
    Left = 263
    Top = 38
    Width = 121
    Height = 23
    TabOrder = 1
  end
  object edtParam2: TEdit
    Left = 263
    Top = 82
    Width = 121
    Height = 23
    TabOrder = 2
  end
  object edtParam3: TEdit
    Left = 263
    Top = 127
    Width = 121
    Height = 23
    TabOrder = 3
  end
  object GroupBox1: TGroupBox
    Left = 8
    Top = 19
    Width = 218
    Height = 159
    Caption = 'SQL Connection '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 4
    object Label4: TLabel
      Left = 3
      Top = 33
      Width = 41
      Height = 15
      Caption = 'Server:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label5: TLabel
      Left = 3
      Top = 62
      Width = 20
      Height = 15
      Caption = 'DB:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label6: TLabel
      Left = 3
      Top = 91
      Width = 29
      Height = 15
      Caption = 'User:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label7: TLabel
      Left = 3
      Top = 120
      Width = 55
      Height = 15
      Caption = 'Password:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object edtServer: TEdit
      Left = 62
      Top = 30
      Width = 144
      Height = 23
      TabOrder = 0
    end
    object edtDatabase: TEdit
      Left = 62
      Top = 59
      Width = 144
      Height = 23
      TabOrder = 1
    end
    object edtUser: TEdit
      Left = 62
      Top = 88
      Width = 144
      Height = 23
      TabOrder = 2
    end
    object edtPassword: TEdit
      Left = 62
      Top = 117
      Width = 144
      Height = 23
      TabOrder = 3
    end
  end
end
