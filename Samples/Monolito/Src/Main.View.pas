unit Main.View;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.Menus,
  Produtos.Buscar.View;

type
  TMainView = class(TForm)
    MainMenu1: TMainMenu;
    Cadastros1: TMenuItem;
    Produtos1: TMenuItem;
    procedure Produtos1Click(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
  private

  public

  end;

var
  MainView: TMainView;

implementation

{$R *.dfm}

procedure TMainView.FormCreate(Sender: TObject);
begin
  ReportMemoryLeaksOnShutdown := True;
end;

procedure TMainView.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
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

procedure TMainView.Produtos1Click(Sender: TObject);
begin
  var LView := TProdutosBuscarView.Create(nil);
  try
    LView.ShowModal;
  finally
    LView.Free;
  end;
end;

end.
