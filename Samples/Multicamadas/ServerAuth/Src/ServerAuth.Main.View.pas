unit ServerAuth.Main.View;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  ShellAPI,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.StdCtrls,
  ServerAuth.XData.DM;

type
  TServerAuthMainView = class(TForm)
    btnStart: TButton;
    btnStop: TButton;
    mmLog: TMemo;
    btnSwaggerDocumentacao: TButton;
    procedure FormCreate(Sender: TObject);
    procedure btnStartClick(Sender: TObject);
    procedure btnStopClick(Sender: TObject);
    procedure btnSwaggerDocumentacaoClick(Sender: TObject);
  private
    procedure UpdateScreen;
    function GetServerBaseUrl: string;
  public
  end;

var
  ServerAuthMainView: TServerAuthMainView;

implementation

{$R *.dfm}

procedure TServerAuthMainView.FormCreate(Sender: TObject);
begin
  ReportMemoryLeaksOnShutdown := True;
  Self.UpdateScreen;
end;

function TServerAuthMainView.GetServerBaseUrl: string;
const
  HTTP = 'http://+';
  HTTP_LOCALHOST = 'http://localhost';
begin
  Result := ServerAuthXDataDM.XDataServer1.BaseUrl.Replace(HTTP, HTTP_LOCALHOST, [rfIgnoreCase]);
end;

procedure TServerAuthMainView.UpdateScreen;
begin
  btnStop.Enabled := ServerAuthXDataDM.SparkleHttpSysDispatcher1.Active;
  btnStart.Enabled := not btnStop.Enabled;

  if ServerAuthXDataDM.SparkleHttpSysDispatcher1.Active then
  begin
    mmLog.Lines.Add('Servidor iniciado em:');
    mmLog.Lines.Add(Self.GetServerBaseUrl);
    mmLog.Lines.Add(Self.GetServerBaseUrl + '/LoginService/');
  end
  else
    mmLog.Lines.Add('Servidor parado');
end;

procedure TServerAuthMainView.btnStartClick(Sender: TObject);
begin
  ServerAuthXDataDM.SparkleHttpSysDispatcher1.Start;
  Self.UpdateScreen;
end;

procedure TServerAuthMainView.btnStopClick(Sender: TObject);
begin
  ServerAuthXDataDM.SparkleHttpSysDispatcher1.Stop;
  Self.UpdateScreen;
end;

procedure TServerAuthMainView.btnSwaggerDocumentacaoClick(Sender: TObject);
begin
  ShellExecute(Handle, 'open', PChar(Self.GetServerBaseUrl + '/swaggerui'), nil, nil, SW_SHOWNORMAL);
end;

end.
