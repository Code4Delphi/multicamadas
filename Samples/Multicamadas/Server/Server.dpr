program Server;

uses
  Vcl.Forms,
  Server.Main.View in 'Src\Server.Main.View.pas' {ServerMainView},
  Server.XData.DM in 'Src\Server.XData.DM.pas' {ServerXDataDM: TDataModule},
  ProdutosService in '..\Common\ProdutosService.pas',
  ProdutosServiceImplementation in 'Src\Produtos\ProdutosServiceImplementation.pas',
  Produtos.DM in 'Src\Produtos\Produtos.DM.pas' {ProdutosDM: TDataModule},
  Produtos.DTO in '..\Common\Produtos.DTO.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'Server - Multicamadas Code4Delphi';
  Application.CreateForm(TServerXDataDM, ServerXDataDM);
  Application.CreateForm(TServerMainView, ServerMainView);
  Application.Run;
end.
