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
  Produtos.DM;

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
    procedure btnGravarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
  private
    FIdAlterar: Integer;
    FIdSelecionado: Integer;
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
end;

procedure TProdutosCadastrarView.FormShow(Sender: TObject);
begin
  ProdutosDM.Get(FIdAlterar);
  if ProdutosDM.QCadastrar.IsEmpty then
    ProdutosDM.QCadastrar.Append
  else
    ProdutosDM.QCadastrar.Edit;

  edtNome.SetFocus;
end;

procedure TProdutosCadastrarView.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  ProdutosDM.QCadastrar.Close;
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
  if ProdutosDm.QCadastrarnome.AsString.Trim.IsEmpty then
    raise Exception.Create('Informe o nome do produto');

  if ProdutosDm.QCadastrarestoque.AsFloat <= 0 then
    raise Exception.Create('Informe o estoque');

  if ProdutosDm.QCadastrarpreco.AsFloat <= 0 then
    raise Exception.Create('Informe o preço');

  ProdutosDM.QCadastrar.Post;

  FIdSelecionado := ProdutosDM.QCadastrarId.AsInteger;
  Self.Close;
  Self.ModalResult := mrOk;
end;

procedure TProdutosCadastrarView.btnCancelarClick(Sender: TObject);
begin
  ProdutosDM.QCadastrar.Cancel;

  Self.Close;
  Self.ModalResult := mrCancel;
end;

end.
