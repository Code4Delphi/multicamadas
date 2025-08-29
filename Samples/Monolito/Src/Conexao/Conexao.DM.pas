unit Conexao.DM;

interface

uses
  System.SysUtils,
  System.Classes,
  FireDAC.UI.Intf,
  FireDAC.VCLUI.Wait,
  FireDAC.Stan.ExprFuncs,
  FireDAC.Phys.SQLiteWrapper.Stat,
  FireDAC.Phys.SQLiteDef,
  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Error,
  FireDAC.Phys.Intf,
  FireDAC.Stan.Def,
  FireDAC.Stan.Pool,
  FireDAC.Stan.Async,
  FireDAC.Phys,
  FireDAC.Phys.SQLite,
  Data.DB,
  FireDAC.Comp.Client,
  FireDAC.Comp.UI;

type
  TConexaoDM = class(TDataModule)
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    FDPhysSQLiteDriverLink1: TFDPhysSQLiteDriverLink;
    FDConnection1: TFDConnection;
    procedure DataModuleCreate(Sender: TObject);
  private

  public

  end;

var
  ConexaoDM: TConexaoDM;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TConexaoDM.DataModuleCreate(Sender: TObject);
begin
  FDConnection1.Connected := False;
  FDConnection1.Params.Database := '..\..\DB\dados.db';
end;

end.
