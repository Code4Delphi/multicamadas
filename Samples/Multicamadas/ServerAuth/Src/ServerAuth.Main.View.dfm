object ServerAuthMainView: TServerAuthMainView
  Left = 0
  Top = 0
  Caption = 'ServerAuth - Multicamadas Code4Delphi'
  ClientHeight = 343
  ClientWidth = 545
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  OnCreate = FormCreate
  TextHeight = 15
  object btnStart: TButton
    Left = 24
    Top = 16
    Width = 75
    Height = 25
    Caption = 'Start'
    TabOrder = 0
    OnClick = btnStartClick
  end
  object btnStop: TButton
    Left = 105
    Top = 16
    Width = 75
    Height = 25
    Caption = 'Stop'
    TabOrder = 1
    OnClick = btnStopClick
  end
  object mmLog: TMemo
    Left = 24
    Top = 64
    Width = 505
    Height = 257
    ScrollBars = ssVertical
    TabOrder = 2
  end
  object btnSwaggerDocumentacao: TButton
    Left = 336
    Top = 16
    Width = 193
    Height = 25
    Caption = 'Abrir documenta'#231#227'o Swagger'
    TabOrder = 3
    OnClick = btnSwaggerDocumentacaoClick
  end
end
