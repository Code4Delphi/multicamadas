program ClientFMX;

uses
  System.StartUpCopy,
  FMX.Forms,
  ClientFMX.Main.View in 'Src\ClientFMX.Main.View.pas' {ClientFMXMainView},
  Produtos.Buscar.View in 'Src\Produtos\Produtos.Buscar.View.pas' {ProdutosBuscarView},
  Produtos.DTO in '..\..\Common\Produtos.DTO.pas',
  ProdutosService in '..\..\Common\ProdutosService.pas',
  Produtos.Cadastrar.View2 in 'Src\Produtos\Produtos.Cadastrar.View2.pas' {ProdutosCadastrarView2},
  ClientFMX.Consts in 'Src\ClientFMX.Consts.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TClientFMXMainView, ClientFMXMainView);
  Application.Run;
end.
