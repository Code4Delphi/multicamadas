program ClientVCL;

uses
  Vcl.Forms,
  ClientVCL.Main.View in 'Src\ClientVCL.Main.View.pas' {ClientVCLMainView},
  Produtos.DTO in '..\..\Common\Produtos.DTO.pas',
  ProdutosService in '..\..\Common\ProdutosService.pas',
  Produtos.Buscar.View in 'Src\Produtos\Produtos.Buscar.View.pas' {ProdutosBuscarView},
  Produtos.Cadastrar.View in 'Src\Produtos\Produtos.Cadastrar.View.pas' {ProdutosCadastrarView};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TClientVCLMainView, ClientVCLMainView);
  Application.Run;
end.
