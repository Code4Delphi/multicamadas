unit Produtos.Cadastrar.View;

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
  Data.DB,
  XData.Client,
  Aurelius.Bind.BaseDataset,
  Aurelius.Bind.Dataset,
  Produtos.DTO,
  ProdutosService;

type
  TProdutosCadastrarView = class(TForm)
    lytContent: TLayout;
    retContent: TRectangle;
    vsbProdutos: TVertScrollBox;
    lytBuscaVazia: TLayout;
    txtBuscaVazia: TLabel;
    imgBuscaVazia: TPath;
    retHeader: TRectangle;
    btnVoltar: TButton;
    imgVoltar: TPath;
    btnBuscar: TButton;
    imgBuscar: TPath;
    edtBuscar: TEdit;
    ShadowEffect: TShadowEffect;
    retFooter: TRectangle;
    btnAnterior: TButton;
    imgAnterior: TPath;
    btnProximo: TButton;
    imgProximo: TPath;
    lblPaginas: TLabel;
    DataSource1: TDataSource;
    Dataset1: TAureliusDataset;
    Dataset1Id: TIntegerField;
    Dataset1Nome: TStringField;
    Dataset1Estoque: TFloatField;
    Dataset1Preco: TFloatField;
    Dataset1Registro: TIntegerField;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnVoltarClick(Sender: TObject);
    procedure btnBuscarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    FXDataClient: TXDataClient;
    FList: TList<TProduto>;
    procedure ListarDados;
  public

  end;

implementation

{$R *.fmx}

procedure TProdutosCadastrarView.FormCreate(Sender: TObject);
begin
  FXDataClient := TXDataClient.Create;
  FXDataClient.Uri := 'http://localhost:2001/tms/xdata/';

  FList := TList<TProduto>.Create;
end;

procedure TProdutosCadastrarView.FormDestroy(Sender: TObject);
begin
  Dataset1.Close;
  FList.Free;
  FXDataClient.Free;
end;

procedure TProdutosCadastrarView.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := TCloseAction.caFree;
end;

procedure TProdutosCadastrarView.btnVoltarClick(Sender: TObject);
begin
  Self.Close;
end;

procedure TProdutosCadastrarView.btnBuscarClick(Sender: TObject);
begin
  Self.ListarDados;
end;

procedure TProdutosCadastrarView.ListarDados;
var
  LProdutosService: IProdutosService;
  LFiltros: TProdutoFiltros;
begin
  try
    Dataset1.Close;
    LProdutosService := FXDataClient.Service<IProdutosService>;
    FreeAndNil(FList);

    LFiltros := TProdutoFiltros.Create;
    try
      LFiltros.Nome := edtBuscar.Text;
      FList := LProdutosService.List(LFiltros);
    finally
      LFiltros.Free;
    end;

    Dataset1.SetSourceList(FList);
    Dataset1.Open;
    Dataset1.Last;

    //lbTotal.Caption := FormatFloat('000000', DataSource1.DataSet.RecordCount);
  finally
    //Screen.Cursor := crDefault;
  end;
end;

end.
