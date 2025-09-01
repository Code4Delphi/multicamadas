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
  Vcl.StdCtrls, Vcl.Mask, WEBLib.Mask;

type
  TProdutosCadastrarView = class(TWebForm)
    lbNome: TWebLabel;
    lbCodigo: TWebLabel;
    lbEstoque: TWebLabel;
    edtCodigo: TWebEdit;
    lbPreco: TWebLabel;
    lbPorcentagem: TWebLabel;
    edtNome: TWebEdit;
    edtEstoque: TWebEdit;
    edtPreco: TWebEdit;
    edtRegistro: TWebSpinEdit;
    btnGravar: TWebButton;
    btnLimpar: TWebButton;
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
  edtEstoque.Text := '0';
  edtPreco.Text := '0';
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

  if StrToFloatDef(edtPreco.Text, 0) <= 0 then
  begin
    ShowMessage('Preenchar o campo preço');
    edtPreco.SetFocus;
    Exit;
  end;

  Self.ModalResult := mrOk;
  Self.Close;
end;

end.