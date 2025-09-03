unit Produtos.Buscar.View;

interface

uses
  System.SysUtils,
  System.Types,
  System.UITypes,
  System.Classes,
  System.Variants,
  System.Generics.Collections,
  FMX.Types,
  FMX.Controls,
  FMX.Forms,
  FMX.Graphics,
  FMX.Dialogs,
  FMX.Objects,
  FMX.Controls.Presentation,
  FMX.StdCtrls,
  FMX.Effects,
  FMX.Edit,
  FMX.Layouts,
  FMX.ListBox,
  Data.DB,
  XData.Client,
  Produtos.DTO,
  ProdutosService,
  Produtos.Cadastrar.View2,
  ClientFMX.Consts;

type
  TProdutosBuscarView = class(TForm)
    lytContent: TLayout;
    retContent: TRectangle;
    lytSemRegistros: TLayout;
    imgSemRegistro: TPath;
    retHeader: TRectangle;
    btnVoltar: TButton;
    imgVoltar: TPath;
    btnListar: TButton;
    imgBuscar: TPath;
    edtBuscar: TEdit;
    ShadowEffect: TShadowEffect;
    retFooter: TRectangle;
    btnAnterior: TButton;
    imgAnterior: TPath;
    btnProximo: TButton;
    imgProximo: TPath;
    lblPaginas: TLabel;
    ListBox1: TListBox;
    txtBuscaVazia: TLabel;
    btnNovo: TButton;
    imgNovo: TPath;
    btnAlterar: TButton;
    imgAlterar: TPath;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnVoltarClick(Sender: TObject);
    procedure btnListarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure ListBox1Click(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
  private
    FXDataClient: TXDataClient;
    FList: TList<TProduto>;
    procedure ListarDados;
    procedure ScreenProdutos;
  public

  end;

implementation

{$R *.fmx}


procedure TProdutosBuscarView.FormCreate(Sender: TObject);
begin
  FXDataClient := TXDataClient.Create;
  FXDataClient.Uri := C_URI;

  FList := TList<TProduto>.Create;
end;

procedure TProdutosBuscarView.FormDestroy(Sender: TObject);
begin
  FList.Free;
  FXDataClient.Free;
end;

procedure TProdutosBuscarView.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := TCloseAction.caFree;
end;

procedure TProdutosBuscarView.btnVoltarClick(Sender: TObject);
begin
  Self.Close;
end;

procedure TProdutosBuscarView.btnListarClick(Sender: TObject);
begin
  Self.ListarDados;
end;

procedure TProdutosBuscarView.ListarDados;
var
  LProdutosService: IProdutosService;
  LFiltros: TProdutoFiltros;
begin
  ListBox1.Clear;
  LProdutosService := FXDataClient.Service<IProdutosService>;
  FreeAndNil(FList);

  LFiltros := TProdutoFiltros.Create;
  try
    LFiltros.Nome := edtBuscar.Text;
    FList := LProdutosService.List(LFiltros);
  finally
    LFiltros.Free;
  end;

  lytSemRegistros.Visible := FList.Count <= 0;

  Self.ScreenProdutos;
end;

procedure TProdutosBuscarView.ListBox1Click(Sender: TObject);
begin
   if Assigned(ListBox1.Selected) then
    ShowMessage('Texto: ' + ListBox1.Selected.Text + ' | ID: ' + TProduto(ListBox1.Selected.Data).Nome);
end;

procedure TProdutosBuscarView.ScreenProdutos;
begin
  for var LProdutos in FList do
    ListBox1.Items.AddObject(Format('%D - %S', [LProdutos.Id, LProdutos.Nome]), LProdutos);
end;

procedure TProdutosBuscarView.btnNovoClick(Sender: TObject);
begin
  var LView := TProdutosCadastrarView2.Create(nil);
  LView.Show;
end;

procedure TProdutosBuscarView.btnAlterarClick(Sender: TObject);
begin
  if not Assigned(ListBox1.Selected) then
    raise Exception.Create('Selecione um registro');

  var LView := TProdutosCadastrarView2.Create(nil);
  LView.IdAlterar := TProduto(ListBox1.Selected.Data).Id;
  LView.Show;
end;

end.
