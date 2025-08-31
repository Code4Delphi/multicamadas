unit Produtos.Cadastrar.View;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects, FMX.Controls.Presentation, FMX.StdCtrls,
  FMX.Edit;

type
  TProdutosCadastrarView = class(TForm)
    retHeader: TRectangle;
    btnVoltar: TButton;
    imgVoltar: TPath;
    btnAlterar: TButton;
    imgAlterar: TPath;
    txtBuscaVazia: TLabel;
    retBack: TRectangle;
    lbNome: TLabel;
    edtNome: TEdit;
    lbEstoque: TLabel;
    edtEstoque: TEdit;
    lbPreco: TLabel;
    edtPreco: TEdit;
    lbRegistro: TLabel;
    edtRegistro: TEdit;
    procedure btnVoltarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ProdutosCadastrarView: TProdutosCadastrarView;

implementation

{$R *.fmx}

procedure TProdutosCadastrarView.btnVoltarClick(Sender: TObject);
begin
  Self.Close;
end;

end.
