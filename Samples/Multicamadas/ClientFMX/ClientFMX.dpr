program ClientFMX;

uses
  System.StartUpCopy,
  FMX.Forms,
  ClientFMX.Main.View in 'Src\ClientFMX.Main.View.pas' {ClientFMXMainView},
  Produtos.Buscar.View in 'Src\Produtos\Produtos.Buscar.View.pas' {ProdutosBuscarView},
  Produtos.DTO in '..\..\Common\Produtos.DTO.pas',
  ProdutosService in '..\..\Common\ProdutosService.pas',
  Produtos.Cadastrar.View in 'Src\Produtos\Produtos.Cadastrar.View.pas' {ProdutosCadastrarView};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TClientFMXMainView, ClientFMXMainView);
  Application.CreateForm(TProdutosCadastrarView, ProdutosCadastrarView);
  Application.Run;
end.
