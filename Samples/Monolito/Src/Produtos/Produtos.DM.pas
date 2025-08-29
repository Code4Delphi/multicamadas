unit Produtos.DM;

interface

uses
  System.SysUtils,
  System.Classes,
  Conexao.DM,
  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Param,
  FireDAC.Stan.Error,
  FireDAC.DatS,
  FireDAC.Phys.Intf,
  FireDAC.DApt.Intf,
  FireDAC.Stan.Async,
  FireDAC.DApt,
  Data.DB,
  FireDAC.Comp.DataSet,
  FireDAC.Comp.Client;

type
  TProdutosDM = class(TDataModule)
    QCadastrar: TFDQuery;
    QListar: TFDQuery;
    QCadastrarid: TFDAutoIncField;
    QCadastrarnome: TWideStringField;
    QCadastrarestoque: TFloatField;
    QCadastrarpreco: TFloatField;
    QListarid: TFDAutoIncField;
    QListarnome: TWideStringField;
    QListarestoque: TFloatField;
    QListarpreco: TFloatField;
    QCadastrarregistro: TIntegerField;
    QListarregistro: TIntegerField;
  private
  public
    procedure Get(const AId: Integer);
    procedure List(const ACondicao: string);
  end;

var
  ProdutosDM: TProdutosDM;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TProdutosDM.Get(const AId: Integer);
begin
  QCadastrar.Close;
  QCadastrar.ParamByName('id').AsInteger := AId;
  QCadastrar.Open;
end;

procedure TProdutosDM.List(const ACondicao: string);
begin
  QListar.Close;
  QListar.SQL.Clear;
  QListar.SQL.Add('select * from produtos');
  QListar.SQL.Add(ACondicao);
  QListar.Open;
end;

end.
