unit Produtos.Cadastrar.View;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.StrUtils,
  System.Variants,
  System.Classes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.StdCtrls,
  Vcl.Mask,
  Vcl.ExtCtrls,
  Vcl.DBCtrls,
  Vcl.Buttons,
  Data.DB,
  XData.Client,
  Aurelius.Bind.BaseDataset,
  Aurelius.Bind.Dataset,
  ProdutosService,
  Produtos.DTO;

type
  TProdutosCadastrarView = class(TForm)
    pnRodape: TPanel;
    btnGravar: TBitBtn;
    btnCancelar: TBitBtn;
    pnDados: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label4: TLabel;
    edtCodigo: TDBEdit;
    edtNome: TDBEdit;
    edtPreco: TDBEdit;
    Label5: TLabel;
    edtRegistro: TDBEdit;
    DataSource1: TDataSource;
    Label6: TLabel;
    edtEstoque: TDBEdit;
    Dataset1: TAureliusDataset;
    Dataset1Id: TIntegerField;
    Dataset1Nome: TStringField;
    Dataset1Estoque: TFloatField;
    Dataset1Preco: TFloatField;
    Dataset1Registro: TIntegerField;
    procedure btnGravarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormDestroy(Sender: TObject);
    procedure Dataset1ObjectUpdate(Dataset: TDataSet; AObject: TObject);
    procedure Dataset1ObjectInsert(Dataset: TDataSet; AObject: TObject);
  private
    FIdAlterar: Integer;
    FIdSelecionado: Integer;
    FXDataClient: TXDataClient;
    FProduto: TProduto;
  public
    property IdAlterar: Integer write FIdAlterar;
    property IdSelecionado: Integer read FIdSelecionado;
  end;

implementation

{$R *.dfm}

procedure TProdutosCadastrarView.FormCreate(Sender: TObject);
begin
  FIdAlterar := 0;
  FIdSelecionado := 0;
  FXDataClient := TXDataClient.Create;
  FXDataClient.Uri := 'http://localhost:2001/tms/xdata/';
end;

procedure TProdutosCadastrarView.FormDestroy(Sender: TObject);
begin
  Dataset1.Close;
  FXDataClient.Free;
end;

procedure TProdutosCadastrarView.FormShow(Sender: TObject);
var
  FProdutosService: IProdutosService;
begin
  Dataset1.Close;

  if FIdAlterar > 0 then
  begin
    FProdutosService := FXDataClient.Service<IProdutosService>;

    FProduto := FProdutosService.Get(FIdAlterar);
    if FProduto.Id <= 0 then
    begin
      ShowMessage('Dados do produto não puderam ser buscado');
      Self.Close;
    end;
  end
  else
  begin
    FProduto := TProduto.Create;
    FProduto.Nome := '';
    FProduto.Estoque := 0;
    FProduto.Preco := 0;
    FProduto.Registro := 0;
  end;

  Dataset1.SetSourceObject(FProduto);
  Dataset1.Open;

  if FIdAlterar > 0 then
    Dataset1.Edit
  else
    Dataset1.Append;

  edtNome.SetFocus;
end;

procedure TProdutosCadastrarView.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Perform(CM_DIALOGKEY, VK_TAB, 0);
    Key := #0;
  end;
end;

procedure TProdutosCadastrarView.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  case Key of
    VK_F3:
    begin
      btnGravar.SetFocus;
      btnGravar.Click;
    end;
    VK_F4:
    begin
      if ssAlt in Shift then
        Key := 0;
    end;
    VK_ESCAPE:
    begin
      btnCancelar.SetFocus;
      btnCancelar.Click;
    end;
  end;
end;

procedure TProdutosCadastrarView.btnGravarClick(Sender: TObject);
begin
  if Dataset1Nome.AsString.Trim.IsEmpty then
    raise Exception.Create('Informe o nome do produto');

  if Dataset1estoque.AsFloat <= 0 then
    raise Exception.Create('Informe o estoque');

  if Dataset1preco.AsFloat <= 0 then
    raise Exception.Create('Informe o preço');

  Dataset1.Post;

  FIdSelecionado := Dataset1Id.AsInteger;
  Self.Close;
  Self.ModalResult := mrOk;
end;

procedure TProdutosCadastrarView.btnCancelarClick(Sender: TObject);
begin
  Self.Close;
  Self.ModalResult := mrCancel;
end;

procedure TProdutosCadastrarView.Dataset1ObjectInsert(Dataset: TDataSet; AObject: TObject);
var
  FProdutosService: IProdutosService;
begin
  FProdutosService := FXDataClient.Service<IProdutosService>;
  FProdutosService.Post(TProduto(AObject));
end;

procedure TProdutosCadastrarView.Dataset1ObjectUpdate(Dataset: TDataSet; AObject: TObject);
var
  FProdutosService: IProdutosService;
begin
  FProdutosService := FXDataClient.Service<IProdutosService>;
  FProdutosService.Alterar(TProduto(AObject).Id, TProduto(AObject));
end;

end.
