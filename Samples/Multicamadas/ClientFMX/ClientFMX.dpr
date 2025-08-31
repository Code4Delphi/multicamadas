program ClientFMX;

uses
  System.StartUpCopy,
  FMX.Forms,
  ClientFMX.Main.View in 'Src\ClientFMX.Main.View.pas' {ClientFMXMainView},
  Produtos.Cadastrar.View in 'Src\Produtos\Produtos.Cadastrar.View.pas' {ProdutosCadastrarView},
  Produtos.DTO in '..\..\Common\Produtos.DTO.pas',
  ProdutosService in '..\..\Common\ProdutosService.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TClientFMXMainView, ClientFMXMainView);
  Application.Run;
end.
