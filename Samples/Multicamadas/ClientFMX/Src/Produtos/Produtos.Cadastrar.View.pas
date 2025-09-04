unit Produtos.Cadastrar.View;

interface

uses
  System.SysUtils,
  System.Types,
  System.UITypes,
  System.Classes,
  System.Variants,
  FMX.Types,
  FMX.Controls,
  FMX.Forms,
  FMX.Graphics,
  FMX.Dialogs,
  FMX.StdCtrls,
  FMX.Objects,
  FMX.Controls.Presentation,
  FMX.Edit,
  XData.Client,
  Produtos.DTO,
  ProdutosService,
  ClientFMX.Consts;

type
  TProdutosCadastrarView = class(TForm)
    retHeader: TRectangle;
    btnVoltar: TButton;
    imgVoltar: TPath;
    btnConfirmar: TButton;
    imgConfirmar: TPath;
    txtBuscaVazia: TLabel;
    retCorpo: TRectangle;
    lbNome: TLabel;
    edtNome: TEdit;
    lbEstoque: TLabel;
    edtEstoque: TEdit;
    lbPreco: TLabel;
    edtPreco: TEdit;
    lbRegistro: TLabel;
    edtRegistro: TEdit;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnVoltarClick(Sender: TObject);
    procedure btnConfirmarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edtRegistroKeyDown(Sender: TObject; var Key: Word; var KeyChar: WideChar; Shift: TShiftState);
  private
    FXDataClient: TXDataClient;
    FProduto: TProduto;
    FIdAlterar: Integer;
    procedure ValidarPreenchimentoCampos;
    procedure GravarProduto;
    procedure BuscarProdutoEdicaoSeNecessario;
  public
    property IdAlterar: Integer write FIdAlterar;
  end;


implementation

{$R *.fmx}

procedure TProdutosCadastrarView.FormCreate(Sender: TObject);
begin
  FXDataClient := TXDataClient.Create;
  FProduto := TProduto.Create;
  FXDataClient.Uri := C_URI;
  FIdAlterar := 0;
end;

procedure TProdutosCadastrarView.FormDestroy(Sender: TObject);
begin
  FProduto.Free;
  FXDataClient.Free;
end;

procedure TProdutosCadastrarView.FormShow(Sender: TObject);
begin
  Self.BuscarProdutoEdicaoSeNecessario;
end;

procedure TProdutosCadastrarView.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := TCloseAction.caFree;
end;

procedure TProdutosCadastrarView.BuscarProdutoEdicaoSeNecessario;
begin
  if FIdAlterar <= 0 then
    Exit;

  FProduto := FXDataClient.Service<IProdutosService>.Get(FIdAlterar);
  edtNome.Text := FProduto.Nome;
  edtEstoque.Text := FProduto.Estoque.ToString;
  edtPreco.Text := FProduto.Preco.ToString;
  edtRegistro.Text := FProduto.Registro.ToString;
end;

procedure TProdutosCadastrarView.edtRegistroKeyDown(Sender: TObject; var Key: Word; var KeyChar: WideChar;  Shift: TShiftState);
begin
  if Key = vkReturn then
    btnConfirmarClick(btnConfirmar);
end;

procedure TProdutosCadastrarView.btnVoltarClick(Sender: TObject);
begin
  Self.Close
end;

procedure TProdutosCadastrarView.btnConfirmarClick(Sender: TObject);
begin
  Self.ValidarPreenchimentoCampos;
  Self.GravarProduto;
end;

procedure TProdutosCadastrarView.ValidarPreenchimentoCampos;
begin
  if Trim(edtNome.Text).IsEmpty then
  begin
    edtNome.SetFocus;
    ShowMessage('Informe o campo nome');
    Abort;
  end;

  if StrToFloatDef(edtPreco.Text, 0) <= 0 then
  begin
    edtPreco.SetFocus;
    ShowMessage('Informe o campo preço');
    Abort;
  end;
end;

procedure TProdutosCadastrarView.GravarProduto;
begin
  FProduto.Nome := edtNome.Text;
  FProduto.Estoque := StrToFloatDef(edtEstoque.Text, 0);
  FProduto.Preco := StrToFloatDef(edtPreco.Text, 0);
  FProduto.Registro := StrToIntDef(edtRegistro.Text, 0);

  if FProduto.Id > 0 then
    FXDataClient.Service<IProdutosService>.Update(FProduto.Id, FProduto)
  else
    FXDataClient.Service<IProdutosService>.Post(FProduto);

  Self.Close;
end;

end.
