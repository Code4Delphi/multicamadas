unit Produtos.DM;

interface

uses
  System.SysUtils,
  System.Classes,
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
  FireDAC.Comp.Client,
  FireDAC.UI.Intf,
  FireDAC.VCLUI.Wait,
  FireDAC.Stan.ExprFuncs,
  FireDAC.Phys.SQLiteWrapper.Stat,
  FireDAC.Phys.SQLiteDef,
  FireDAC.Stan.Def,
  FireDAC.Stan.Pool,
  FireDAC.Phys,
  FireDAC.Phys.SQLite,
  FireDAC.Comp.UI;

type
  TProdutosDM = class(TDataModule)
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    FDPhysSQLiteDriverLink1: TFDPhysSQLiteDriverLink;
    FDConnection1: TFDConnection;
    QCadastrar: TFDQuery;
    QCadastrarid: TFDAutoIncField;
    QCadastrarnome: TWideStringField;
    QCadastrarestoque: TFloatField;
    QCadastrarpreco: TFloatField;
    QListar: TFDQuery;
    QListarid: TFDAutoIncField;
    QListarnome: TWideStringField;
    QListarestoque: TFloatField;
    QListarpreco: TFloatField;
    QCadastrarregistro: TIntegerField;
    QListarregistro: TIntegerField;
    procedure DataModuleCreate(Sender: TObject);
  private

  public
    procedure Cadastrar(const AId: Integer);
    procedure Listar(const ACondicao: string);
  end;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TProdutosDM.DataModuleCreate(Sender: TObject);
begin
  FDConnection1.Connected := False;
  FDConnection1.Params.Database := '..\..\..\DB\dados.db';
end;

procedure TProdutosDM.Cadastrar(const AId: Integer);
begin
  QCadastrar.Close;
  QCadastrar.ParamByName('id').AsInteger := AId;
  QCadastrar.Open;
end;

procedure TProdutosDM.Listar(const ACondicao: string);
begin
  QListar.Close;
  QListar.SQL.Clear;
  QListar.SQL.Add('select * from produtos');
  QListar.SQL.Add(ACondicao);
  QListar.Open;
end;

end.
