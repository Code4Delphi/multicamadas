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
    lbTotal: TLabel;
    Label1: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnVoltarClick(Sender: TObject);
    procedure btnListarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
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
  lbTotal.Text := '0';
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
  lbTotal.Text := FList.Count.ToString;
  Self.ScreenProdutos;
end;

procedure TProdutosBuscarView.ScreenProdutos;
begin
  for var LProdutos in FList do
    ListBox1.Items.AddObject(Format('%d - %s | R$ %n', [LProdutos.Id, LProdutos.Nome, LProdutos.Preco]), LProdutos);
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

end.
