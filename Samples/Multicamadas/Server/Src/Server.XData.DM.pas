unit Server.XData.DM;

interface

uses
  System.SysUtils, System.Classes, Sparkle.HttpServer.Module, Sparkle.HttpServer.Context, XData.Server.Module,
  Sparkle.Comp.Server, XData.Comp.Server, Sparkle.Comp.HttpSysDispatcher;

type
  TServerXDataDM = class(TDataModule)
    SparkleHttpSysDispatcher1: TSparkleHttpSysDispatcher;
    XDataServer1: TXDataServer;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ServerXDataDM: TServerXDataDM;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

end.
