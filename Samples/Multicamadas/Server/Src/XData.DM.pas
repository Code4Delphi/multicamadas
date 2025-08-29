unit XData.DM;

interface

uses
  System.SysUtils, System.Classes, Sparkle.HttpServer.Module, Sparkle.HttpServer.Context, XData.Server.Module,
  Sparkle.Comp.Server, XData.Comp.Server, Sparkle.Comp.HttpSysDispatcher;

type
  TXDataDM = class(TDataModule)
    SparkleHttpSysDispatcher1: TSparkleHttpSysDispatcher;
    XDataServer1: TXDataServer;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  XDataDM: TXDataDM;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

end.
