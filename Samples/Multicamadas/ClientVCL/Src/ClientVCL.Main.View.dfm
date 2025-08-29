object ClientVCLMainView: TClientVCLMainView
  Left = 0
  Top = 0
  Caption = 'Multicamadas - Client VCL'
  ClientHeight = 620
  ClientWidth = 860
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Menu = MainMenu1
  WindowState = wsMaximized
  OnKeyDown = FormKeyDown
  TextHeight = 15
  object MainMenu1: TMainMenu
    Left = 208
    Top = 176
    object Cadastros1: TMenuItem
      Caption = 'Cadastros'
      object Produtos1: TMenuItem
        Caption = 'Produtos'
        OnClick = Produtos1Click
      end
    end
  end
end
