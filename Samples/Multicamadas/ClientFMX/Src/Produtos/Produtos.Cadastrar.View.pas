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
  FMX.Objects,
  FMX.Controls.Presentation,
  FMX.StdCtrls,
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
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private

  public

  end;

implementation

{$R *.fmx}

procedure TProdutosCadastrarView.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := TCloseAction.caFree;
end;

procedure TProdutosCadastrarView.btnVoltarClick(Sender: TObject);
begin
  Self.Close;
end;

end.
