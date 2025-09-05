unit Produtos.Buscar.View;

interface

uses
  System.SysUtils,
  System.Types,
  System.UITypes,
  System.Classes,
  System.Variants,
  System.Generics.Collections,
  System.Math,
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
  FMX.DialogService,
  Data.DB,
  XData.Client,
  Produtos.DTO,
  ProdutosService,
  Produtos.Cadastrar.View,
  ClientFMX.Consts;

type
  TProdutosBuscarView = class(TForm)
    lytTudo: TLayout;
    retContent: TRectangle;
    lytSemRegistros: TLayout;
    imgSemRegistro: TPath;
    retTopo: TRectangle;
    btnVoltar: TButton;
    imgVoltar: TPath;
    btnListar: TButton;
    imgListar: TPath;
    edtBuscar: TEdit;
    S: TShadowEffect;
    ListBox1: TListBox;
    txtBuscaVazia: TLabel;
    Rectangle1: TRectangle;
    btnNovo: TButton;
    imgNovo: TPath;
    btnAlterar: TButton;
    imgAlterar: TPath;
    btnExcluir: TButton;
    imgExcluir: TPath;
    retPaginacao: TRectangle;
    btnAnterior: TButton;
    imgAnterior: TPath;
    btnProximo: TButton;
    imgProximo: TPath;
    lbPaginacao: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnVoltarClick(Sender: TObject);
    procedure btnListarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnAnteriorClick(Sender: TObject);
    procedure btnProximoClick(Sender: TObject);
  private
    FXDataClient: TXDataClient;
    FResultList: TResultList;
    FPageIndex: Integer;
    FPageSize: Integer;
    FPageTotal: Integer;
    procedure ListarDados;
    procedure ScreenProdutos;
    procedure ProcessaPaginacao;
  public

  end;

implementation

{$R *.fmx}


procedure TProdutosBuscarView.FormCreate(Sender: TObject);
begin
  FXDataClient := TXDataClient.Create;
  FXDataClient.Uri := C_URI;

  FPageSize := 20;
  FPageIndex := 1;
end;

procedure TProdutosBuscarView.FormDestroy(Sender: TObject);
begin
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

procedure TProdutosBuscarView.btnNovoClick(Sender: TObject);
begin
  var LView := TProdutosCadastrarView.Create(nil);
  LView.ShowModal(
    procedure(ModalResult: TModalResult)
    begin
      Self.ListarDados;
      ListBox1.ItemIndex := Pred(ListBox1.Count);
    end);
end;

procedure TProdutosBuscarView.btnAlterarClick(Sender: TObject);
begin
  if not Assigned(ListBox1.Selected) then
    raise Exception.Create('Selecione um registro');

  var LView := TProdutosCadastrarView.Create(nil);
  LView.IdAlterar := TProduto(ListBox1.Selected.Data).Id;
  LView.ShowModal(
    procedure(ModalResult: TModalResult)
    begin
      Self.ListarDados;
    end);
end;

procedure TProdutosBuscarView.btnExcluirClick(Sender: TObject);
begin
  if not Assigned(ListBox1.Selected) then
    raise Exception.Create('Selecione um registro');

  TDialogService.MessageDialog('Confirma exclusão?', TMsgDlgType.mtConfirmation, [TMsgDlgBtn.mbYes, TMsgDlgBtn.mbNo], TMsgDlgBtn.mbNo, 0,
    procedure(const AResult: TModalResult)
    begin
      if AResult = mrYes then
      begin
         FXDataClient.Service<IProdutosService>.Delete(TProduto(ListBox1.Selected.Data).Id);
         Self.ListarDados;
      end;
    end);
end;

procedure TProdutosBuscarView.btnAnteriorClick(Sender: TObject);
begin
  if FPageIndex > 1 then
  begin
    Dec(FPageIndex);
    Self.ListarDados;
  end;
end;

procedure TProdutosBuscarView.btnProximoClick(Sender: TObject);
begin
  if FPageIndex < FPageTotal then
  begin
    Inc(FPageIndex);
    Self.ListarDados;
  end;
end;

procedure TProdutosBuscarView.btnListarClick(Sender: TObject);
begin
  FPageIndex := 1;
  Self.ListarDados;
end;

procedure TProdutosBuscarView.ListarDados;
var
  LProdutosService: IProdutosService;
  LFiltros: TProdutoFiltros;
begin
  ListBox1.Clear;
  LProdutosService := FXDataClient.Service<IProdutosService>;

  LFiltros := TProdutoFiltros.Create;
  try
    LFiltros.Nome := edtBuscar.Text;
    LFiltros.Offset := (FPageIndex - 1) * FPageSize;
    LFiltros.Limit  := FPageSize;
    FResultList := LProdutosService.List(LFiltros);
  finally
    LFiltros.Free;
  end;

  lytSemRegistros.Visible := FResultList.ListProdutos.Count <= 0;
  Self.ScreenProdutos;
  Self.ProcessaPaginacao;
end;

procedure TProdutosBuscarView.ScreenProdutos;
begin
  for var LProdutos in FResultList.ListProdutos do
    ListBox1.Items.AddObject(Format('%d - %s | R$ %n', [LProdutos.Id, LProdutos.Nome, LProdutos.Preco]), LProdutos);
end;

procedure TProdutosBuscarView.ProcessaPaginacao;
var
  LRecordsTotal: Integer;
begin
  LRecordsTotal := FResultList.RecordsTotal;

  FPageTotal := 1;
  if FPageSize > 0 then
    FPageTotal := Ceil(LRecordsTotal / FPageSize);

  lbPaginacao.Text := Format('%d de %d', [FPageIndex, FPageTotal]);
end;

end.
