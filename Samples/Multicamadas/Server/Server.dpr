program Server;

uses
  Vcl.Forms,
  Server.Main.View in 'Src\Server.Main.View.pas' {ServerMainView},
  XData.DM in 'Src\XData.DM.pas' {XDataDM: TDataModule},
  ProdutosService in '..\..\Common\ProdutosService.pas',
  ProdutosServiceImplementation in 'Src\Produtos\ProdutosServiceImplementation.pas',
  Produtos.DM in 'Src\Produtos\Produtos.DM.pas' {ProdutosDM: TDataModule},
  Produtos.DTO in '..\..\Common\Produtos.DTO.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TXDataDM, XDataDM);
  Application.CreateForm(TServerMainView, ServerMainView);
  Application.Run;
end.
