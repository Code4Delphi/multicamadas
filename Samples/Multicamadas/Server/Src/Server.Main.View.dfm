object ServerMainView: TServerMainView
  Left = 0
  Top = 0
  Caption = 'Multicamadas - Server'
  ClientHeight = 378
  ClientWidth = 570
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  KeyPreview = True
  Position = poScreenCenter
  OnCreate = FormCreate
  TextHeight = 15
  object btnStart: TButton
    Left = 32
    Top = 41
    Width = 75
    Height = 25
    Caption = 'Start'
    TabOrder = 0
    OnClick = btnStartClick
  end
  object btnStop: TButton
    Left = 128
    Top = 41
    Width = 75
    Height = 25
    Caption = 'Stop'
    TabOrder = 1
    OnClick = btnStopClick
  end
  object Memo1: TMemo
    Left = 32
    Top = 72
    Width = 489
    Height = 261
    TabOrder = 2
  end
end
