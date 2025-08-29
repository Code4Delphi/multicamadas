program Monolito;

uses
  Vcl.Forms,
  Main.View in 'Src\Main.View.pas' {MainView},
  Produtos.Cadastrar.View in 'Src\Produtos\Produtos.Cadastrar.View.pas' {ProdutosCadastrarView},
  Produtos.Buscar.View in 'Src\Produtos\Produtos.Buscar.View.pas' {ProdutosBuscarView},
  Produtos.DM in 'Src\Produtos\Produtos.DM.pas' {ProdutosDM: TDataModule},
  Conexao.DM in 'Src\Conexao\Conexao.DM.pas' {ConexaoDM: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TConexaoDM, ConexaoDM);
  Application.CreateForm(TMainView, MainView);
  Application.Run;
end.
