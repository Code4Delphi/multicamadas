program ClientWeb;

{$R *.dres}

uses
  Vcl.Forms,
  WEBLib.Forms,
  Main.View in 'Src\Main.View.pas' {MainView: TWebForm} {*.html},
  Login.View in 'Src\Login.View.pas' {LoginView: TWebForm} {*.html},
  Produtos.Cadastrar.View in 'Src\Produtos\Produtos.Cadastrar.View.pas' {ProdutosCadastrarView: TWebForm} {*.html},
  Configs in 'Src\Configs.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TLoginView, LoginView);
  Application.Run;
end.
