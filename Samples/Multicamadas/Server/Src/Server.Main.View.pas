unit Server.Main.View;

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
  Server.XData.DM;

type
  TServerMainView = class(TForm)
    btnStart: TButton;
    btnStop: TButton;
    mmLog: TMemo;
    btnSwaggerDocumentacao: TButton;
    procedure btnStartClick(Sender: TObject);
    procedure btnStopClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnSwaggerDocumentacaoClick(Sender: TObject);
  private
    procedure UpdateScreen;
    function GetServerBaseUrl: string;
  public

  end;

var
  ServerMainView: TServerMainView;

implementation

{$R *.dfm}

procedure TServerMainView.FormCreate(Sender: TObject);
begin
  ReportMemoryLeaksOnShutdown := True;
  Self.UpdateScreen;
end;

procedure TServerMainView.UpdateScreen;
begin
  btnStart.Enabled := not ServerXDataDM.SparkleHttpSysDispatcher1.Active;
  btnStop.Enabled := not btnStart.Enabled;

  if ServerXDataDM.SparkleHttpSysDispatcher1.Active then
    mmLog.Lines.Add('Servidor iniciado em: ' + Self.GetServerBaseUrl)
  else
    mmLog.Lines.Add('Servidor parado');
end;

function TServerMainView.GetServerBaseUrl: string;
const
  HTTP = 'http://+';
  HTTP_LOCALHOST = 'http://localhost';
begin
  Result := ServerXDataDM.XDataServer1.BaseUrl.Replace(HTTP, HTTP_LOCALHOST, [rfIgnoreCase]);
end;

procedure TServerMainView.btnStartClick(Sender: TObject);
begin
  ServerXDataDM.SparkleHttpSysDispatcher1.Start;
  Self.UpdateScreen;
end;

procedure TServerMainView.btnStopClick(Sender: TObject);
begin
  ServerXDataDM.SparkleHttpSysDispatcher1.Stop;
  Self.UpdateScreen;
end;

procedure TServerMainView.btnSwaggerDocumentacaoClick(Sender: TObject);
begin
  ShellExecute(Handle, 'open', PChar(Self.GetServerBaseUrl + '/swaggerui'), nil, nil, SW_SHOWNORMAL);
end;

end.
