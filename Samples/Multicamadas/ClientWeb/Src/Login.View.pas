unit Login.View;

interface

uses
  System.SysUtils,
  System.Classes,
  Web,
  WEBLib.Graphics,
  WEBLib.Controls,
  WEBLib.Forms,
  WEBLib.Dialogs,
  Vcl.Controls,
  Vcl.StdCtrls,
  WEBLib.StdCtrls, Main.View, XData.Web.Client, XData.Web.Connection, JS, Configs;

type
  TLoginView = class(TWebForm)
    WebLabel1: TWebLabel;
    edtLogin: TWebEdit;
    edtSenha: TWebEdit;
    btnEntrar: TWebButton;
    ckLembrarMe: TWebCheckBox;
    [Async]
    XDataWebConnection1: TXDataWebConnection;
    XDataWebClient1: TXDataWebClient;
    [Async]
    procedure btnEntrarClick(Sender: TObject);
    procedure WebFormShow(Sender: TObject);
    procedure edtLoginKeyPress(Sender: TObject; var Key: Char);
    procedure edtSenhaKeyPress(Sender: TObject; var Key: Char);
    procedure WebFormCreate(Sender: TObject);
    procedure XDataWebClient1Error(Error: TXDataClientError);
  private

  public

  end;

var
  LoginView: TLoginView;

implementation

{$R *.dfm}

procedure TLoginView.WebFormCreate(Sender: TObject);
begin
  Application.ThemeColor := clGrayText;
  Application.Themed := True;
end;

procedure TLoginView.WebFormShow(Sender: TObject);
begin
  edtLogin.SetFocus;
end;

procedure TLoginView.XDataWebClient1Error(Error: TXDataClientError);
begin
  ShowMessage(
    'StatusCode: ' + Error.StatusCode.ToString + sLineBreak +
    'RequestUrl: ' + Error.RequestUrl + sLineBreak +
    'RequestId: ' + Error.RequestId + sLineBreak +
    'ErrorCode: ' + Error.ErrorCode + sLineBreak +
    'ErrorMessage: ' + Error.ErrorMessage);
end;

procedure TLoginView.edtLoginKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
    edtSenha.SetFocus;
end;

procedure TLoginView.edtSenhaKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
    btnEntrar.Click;
end;

procedure TLoginView.btnEntrarClick(Sender: TObject);
var
  LResponse: TXDataClientResponse;
begin
  if Trim(edtLogin.Text).IsEmpty or Trim(edtSenha.Text).IsEmpty then
  begin
    ShowMessage('Login e senha devem ser informados');
    edtLogin.SetFocus;
    Exit;
  end;

  LResponse := TAwait.Exec<TXDataClientResponse>(
    XDataWebClient1.RawInvokeAsync('ILoginService.Login', [edtLogin.Text, edtSenha.Text]));

  if LResponse.StatusCode <>  200 then
  begin
    ShowMessage('Login ou senha informados são inválidos');
    edtLogin.SetFocus;
    Exit;
  end;

  Configs_Token := string(TJSObject(LResponse.Result)['value']);
  if Configs_Token.Trim.IsEmpty then
  begin
    ShowMessage('Token não pode ser recuperado');
    edtLogin.SetFocus;
    Exit;
  end;

  //ShowMessage('Token: ' + Configs_Token);

  MainView := TMainView.CreateNew;
  MainView.ShowModal;
end;

end.