unit Server.Main.View;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.StdCtrls,
  XData.DM;

type
  TServerMainView = class(TForm)
    btnStart: TButton;
    btnStop: TButton;
    Memo1: TMemo;
    procedure btnStartClick(Sender: TObject);
    procedure btnStopClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    procedure UpdateScreen;
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
  btnStart.Enabled := not XDataDM.SparkleHttpSysDispatcher1.Active;
  btnStop.Enabled := not btnStart.Enabled;

  if XDataDM.SparkleHttpSysDispatcher1.Active then
    Memo1.Lines.Add('## Conectado' + sLineBreak + XDataDM.XDataServer1.BaseUrl)
  else
    Memo1.Lines.Add('## Desconectado ##');
end;

procedure TServerMainView.btnStartClick(Sender: TObject);
begin
  XDataDM.SparkleHttpSysDispatcher1.Start;
  Self.UpdateScreen;
end;

procedure TServerMainView.btnStopClick(Sender: TObject);
begin
  XDataDM.SparkleHttpSysDispatcher1.Stop;
  Self.UpdateScreen;
end;

end.
