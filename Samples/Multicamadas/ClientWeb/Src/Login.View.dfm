object LoginView: TLoginView
  Width = 640
  Height = 480
  Caption = 'DelphiWeb - Login'
  OnCreate = WebFormCreate
  OnShow = WebFormShow
  object WebLabel1: TWebLabel
    Left = 192
    Top = 80
    Width = 136
    Height = 15
    Caption = 'Informe seu login e senha'
    ElementID = 'lbTitulo'
    HeightPercent = 100.000000000000000000
    WidthPercent = 100.000000000000000000
  end
  object edtLogin: TWebEdit
    Left = 232
    Top = 176
    Width = 121
    Height = 22
    ChildOrder = 1
    ElementID = 'edtEmail'
    HeightPercent = 100.000000000000000000
    Text = 'admin'
    WidthPercent = 100.000000000000000000
    OnKeyPress = edtLoginKeyPress
  end
  object edtSenha: TWebEdit
    Left = 232
    Top = 216
    Width = 121
    Height = 22
    ChildOrder = 2
    ElementID = 'edtPassword'
    HeightPercent = 100.000000000000000000
    Text = 'admin'
    WidthPercent = 100.000000000000000000
    OnKeyPress = edtSenhaKeyPress
  end
  object btnEntrar: TWebButton
    Left = 232
    Top = 272
    Width = 96
    Height = 25
    Caption = 'Entrar'
    ChildOrder = 3
    ElementID = 'btnEntrar'
    HeightPercent = 100.000000000000000000
    WidthPercent = 100.000000000000000000
    OnClick = btnEntrarClick
  end
  object ckLembrarMe: TWebCheckBox
    Left = 224
    Top = 244
    Width = 113
    Height = 22
    Caption = 'Lembrar-me'
    ChildOrder = 4
    ElementID = 'ckDefault'
    HeightPercent = 100.000000000000000000
    WidthPercent = 100.000000000000000000
  end
  object XDataWebConnection1: TXDataWebConnection
    URL = 'http://localhost:2001/tms/auth/'
    Left = 72
    Top = 16
  end
  object XDataWebClient1: TXDataWebClient
    Connection = XDataWebConnection1
    OnError = XDataWebClient1Error
    Left = 216
    Top = 16
  end
end
