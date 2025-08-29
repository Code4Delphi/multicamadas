unit ClientVCL.Main.View;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus,
  Produtos.Buscar.View;

type
  TClientVCLMainView = class(TForm)
    MainMenu1: TMainMenu;
    Cadastros1: TMenuItem;
    Produtos1: TMenuItem;
    procedure Produtos1Click(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private

  public

  end;

var
  ClientVCLMainView: TClientVCLMainView;

implementation

{$R *.dfm}

procedure TClientVCLMainView.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  case Key of
    VK_F4:
    begin
      if ssAlt in Shift then
        Key := 0;
    end;
    VK_ESCAPE:
      Application.Terminate;
  end;
end;

procedure TClientVCLMainView.Produtos1Click(Sender: TObject);
begin
  var LView := TProdutosBuscarView.Create(nil);
  try
    LView.ShowModal;
  finally
    LView.Free;
  end;
end;

end.
