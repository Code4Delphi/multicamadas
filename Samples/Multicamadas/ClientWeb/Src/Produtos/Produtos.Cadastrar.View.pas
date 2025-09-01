unit Produtos.Cadastrar.View;

interface

uses
  System.SysUtils,
  System.Classes,
  JS,
  Web,
  WEBLib.Graphics,
  WEBLib.Controls,
  WEBLib.Forms,
  WEBLib.Dialogs,
  Vcl.Controls,
  WEBLib.StdCtrls,
  Vcl.StdCtrls;

type
  TProdutosCadastrarView = class(TWebForm)
    lbNome: TWebLabel;
    btnGravar: TWebButton;
    btnLimpar: TWebButton;
    edtNome: TWebEdit;
    lbCodigo: TWebLabel;
    lbEstoque: TWebLabel;
    edtCodigo: TWebEdit;
    lbPreco: TWebLabel;
    lbPorcentagem: TWebLabel;
    edtRegistro: TWebSpinEdit;
    edtPreco: TWebSpinEdit;
    edtEstoque: TWebSpinEdit;
    procedure btnGravarClick(Sender: TObject);
    procedure WebFormShow(Sender: TObject);
    procedure btnLimparClick(Sender: TObject);
  private
    procedure LimparTela;
  public

  end;

var
  ProdutosCadastrarView: TProdutosCadastrarView;

implementation

{$R *.dfm}

procedure TProdutosCadastrarView.WebFormShow(Sender: TObject);
begin
  Self.LimparTela;
  edtNome.SetFocus;
end;

procedure TProdutosCadastrarView.btnLimparClick(Sender: TObject);
begin
  Self.LimparTela;
end;

procedure TProdutosCadastrarView.LimparTela;
begin
  edtCodigo.Text := '';
  edtNome.Text := '';
  edtEstoque.Value := 0;
  edtPreco.Value := 0;
  edtRegistro.Value := 0;
end;

procedure TProdutosCadastrarView.btnGravarClick(Sender: TObject);
begin
  if Trim(edtNome.Text).IsEmpty then
  begin
    ShowMessage('Preenchar o campo nome');
    edtNome.SetFocus;
    Exit;
  end;

    if edtPreco.Value <= 0 then
  begin
    ShowMessage('Preenchar o campo preço');
    edtPreco.SetFocus;
    Exit;
  end;

  Self.ModalResult := mrOk;
  Self.Close;
end;

end.