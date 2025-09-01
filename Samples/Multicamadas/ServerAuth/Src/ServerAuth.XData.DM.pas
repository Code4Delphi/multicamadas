unit ServerAuth.XData.DM;

interface

uses
  System.SysUtils,
  System.Classes,
  Sparkle.HttpServer.Module,
  Sparkle.HttpServer.Context,
  XData.Server.Module,
  Sparkle.Comp.Server,
  XData.Comp.Server,
  Sparkle.Comp.HttpSysDispatcher, Sparkle.Comp.CompressMiddleware, Sparkle.Comp.CorsMiddleware;

type
  TServerAuthXDataDM = class(TDataModule)
    SparkleHttpSysDispatcher1: TSparkleHttpSysDispatcher;
    XDataServer1: TXDataServer;
    XDataServer1CORS: TSparkleCorsMiddleware;
    XDataServer1Compress: TSparkleCompressMiddleware;
  private

  public

  end;

var
  ServerAuthXDataDM: TServerAuthXDataDM;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

end.
