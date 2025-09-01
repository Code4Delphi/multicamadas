unit Main.View;

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
  WEBLib.StdCtrls,
  WEBLib.ExtCtrls,
  Data.DB,
  XData.Web.JsonDataset,
  XData.Web.Dataset,
  XData.Web.Client,
  XData.Web.Connection,
  WEBLib.DB,
  JS,
  Clientes.Cadastrar.View,
  VCL.TMSFNCTypes,
  VCL.TMSFNCUtils,
  VCL.TMSFNCGraphics,
  VCL.TMSFNCGraphicsTypes,
  System.Rtti,
  VCL.TMSFNCDataGridCell,
  VCL.TMSFNCDataGridData,
  VCL.TMSFNCDataGridBase,
  VCL.TMSFNCDataGridCore,
  VCL.TMSFNCDataGridRenderer,
  VCL.TMSFNCCustomControl,
  VCL.TMSFNCDataGrid,
  VCL.TMSFNCCustomComponent,
  VCL.TMSFNCDataGridDatabaseAdapter,
  Configs;

type
  TMainView = class(TWebForm)
    WebLabel1: TWebLabel;
    lbImportant: TWebLabel;
    lbWarning: TWebLabel;
    lbInformational: TWebLabel;
    WebMessageDlg1: TWebMessageDlg;
    WebPanel1: TWebPanel;
    lbCodigo: TWebLabel;
    edtCodigo: TWebEdit;
    btnGetNome: TWebButton;
    btnGet: TWebButton;
    XDataWebConnection1: TXDataWebConnection;
    XDataWebClient1: TXDataWebClient;
    XDataWebDataSet1: TXDataWebDataSet;
    WebDataSource1: TWebDataSource;
    XDataWebDataSet1Id: TIntegerField;
    XDataWebDataSet1IdCidade: TIntegerField;
    XDataWebDataSet1Nome: TStringField;
    XDataWebDataSet1Profissao: TStringField;
    XDataWebDataSet1Limite: TFloatField;
    XDataWebDataSet1Porcentagem: TFloatField;
    btnListar: TWebButton;
    XDataWebDataSet1Ativo: TBooleanField;
    btnPost: TWebButton;
    btnAlterar: TWebButton;
    btnDelete: TWebButton;
    TMSFNCDataGrid1: TTMSFNCDataGrid;
    TMSFNCDataGridDatabaseAdapter1: TTMSFNCDataGridDatabaseAdapter;
    procedure lbImportantClick(Sender: TObject);
    [Async]
    procedure lbWarningClick(Sender: TObject);
    procedure lbInformationalClick(Sender: TObject);
    [Async]
    procedure btnGetNomeClick(Sender: TObject);
    procedure WebFormCreate(Sender: TObject);
    [Async]
    procedure btnGetClick(Sender: TObject);
    [Async]
    procedure btnListarClick(Sender: TObject);
    [Async]
    procedure btnPostClick(Sender: TObject);
    [Async]
    procedure btnAlterarClick(Sender: TObject);
    [Async]
    procedure btnDeleteClick(Sender: TObject);
    procedure XDataWebClient1Error(Error: TXDataClientError);
    procedure XDataWebConnection1Error(Error: TXDataWebConnectionError);
    procedure XDataWebConnection1Request(Args: TXDataWebConnectionRequest);
  private
    function GetClientePreenchido(const AView: TClientesCadastrarView): TJSObject;
  public

  end;

var
  MainView: TMainView;

implementation

{$R *.dfm}

procedure TMainView.WebFormCreate(Sender: TObject);
begin
  XDataWebConnection1.Open;
end;

procedure TMainView.lbImportantClick(Sender: TObject);
begin
  //MessageDlg('Minha mensagem', mtError, []);
  WebMessageDlg1.ShowDialog('Minha menagem componente', mtWarning, []);
end;

procedure TMainView.lbWarningClick(Sender: TObject);
var
  LResult: TModalResult;
begin
  LResult := await(TModalResult, MessageDlgAsync('Pergunta com await?', mtConfirmation, [mbYes, mbNo]));

  if LResult = mrYes then
    ShowMessage('Respondeu sim')
  else
    ShowMessage('Respondeu não');
end;

procedure TMainView.lbInformationalClick(Sender: TObject);
begin
  MessageDlg('Minha pergunta?', mtConfirmation, [mbYes, mbNo],
    procedure(AValue: TModalResult)
    begin
      if AValue = mrYes then
        ShowMessage('Clicou em sim')
      else
        ShowMessage('Clicou em não');
    end);
end;

procedure TMainView.XDataWebClient1Error(Error: TXDataClientError);
begin
  ShowMessage(
    'StatusCode: ' + Error.StatusCode.ToString + sLineBreak +
    'RequestUrl: ' + Error.RequestUrl + sLineBreak +
    'RequestId: ' + Error.RequestId + sLineBreak +
    'ErrorCode: ' + Error.ErrorCode + sLineBreak +
    'ErrorMessage: ' + Error.ErrorMessage);
end;

procedure TMainView.XDataWebConnection1Error(Error: TXDataWebConnectionError);
begin
  ShowMessage('StatusCode: ' + Error.ErrorMessage);
end;

procedure TMainView.XDataWebConnection1Request(Args: TXDataWebConnectionRequest);
begin
  Args.Request.Headers.SetValue('Authorization', 'Bearer ' + Configs_Token);
end;

procedure TMainView.btnGetNomeClick(Sender: TObject);
var
  LResponse: TXDataClientResponse;
begin
  if StrToIntDef(edtCodigo.Text, 0) <= 0 then
  begin
    MessageDlg('Informe o código desejado', mtInformation, []);
    edtCodigo.SetFocus;
    Exit;
  end;

  if not XDataWebConnection1.Connected then
    XDataWebConnection1.Open;

  LResponse := TAwait.Exec<TXDataClientResponse>(
    XDataWebClient1.RawInvokeAsync('IClientesService.GetNome', [StrToIntDef(edtCodigo.Text, 0)]));

  ShowMessage(LResponse.ResponseText);
end;

procedure TMainView.btnGetClick(Sender: TObject);
var
  LResponse: TXDataClientResponse;
begin
  if StrToIntDef(edtCodigo.Text, 0) <= 0 then
  begin
    MessageDlg('Informe o código desejado', mtInformation, []);
    edtCodigo.SetFocus;
    Exit;
  end;

  if not XDataWebConnection1.Connected then
    XDataWebConnection1.Open;

  LResponse := TAwait.Exec<TXDataClientResponse>(
    XDataWebClient1.RawInvokeAsync('IClientesService.Get', [StrToIntDef(edtCodigo.Text, 0)]));

  XDataWebDataSet1.Close;
  XDataWebDataSet1.SetJsonData(LResponse.Result);
  XDataWebDataSet1.Open;

//  mmTeste.Lines.Clear;
//  mmTeste.Lines.Add('Id: ' + XDataWebDataSet1Id.AsString);
//  mmTeste.Lines.Add('Id Cidade: ' + XDataWebDataSet1IdCidade.AsString);
//  mmTeste.Lines.Add('Nome: ' +  XDataWebDataSet1Nome.AsString);
//  mmTeste.Lines.Add('Profissão: ' +  XDataWebDataSet1Profissao.AsString);
//  mmTeste.Lines.Add('Limite: ' +  XDataWebDataSet1Limite.AsString);
//  mmTeste.Lines.Add('Porcentagem: ' +  XDataWebDataSet1Porcentagem.AsString);
//  mmTeste.Lines.Add('Ativo: ' +  XDataWebDataSet1Ativo.AsString);
end;

procedure TMainView.btnListarClick(Sender: TObject);
var
  LResponse: TXDataClientResponse;
begin
  if not XDataWebConnection1.Connected then
    XDataWebConnection1.Open;

  LResponse := TAwait.Exec<TXDataClientResponse>(
    XDataWebClient1.RawInvokeAsync('IClientesService.List', []));

  XDataWebDataSet1.Close;
  XDataWebDataSet1.SetJsonData(TJSObject(LResponse.Result)['value']);
  XDataWebDataSet1.Open;

//  XDataWebDataSet1.First;
//  while not XDataWebDataSet1.Eof do
//  begin
//    mmTeste.Lines.Add(XDataWebDataSet1Id.AsString + ' - ' +
//      XDataWebDataSet1Nome.AsString + ' - ' + XDataWebDataSet1Profissao.AsString);
//    XDataWebDataSet1.Next;
//  end;
end;

procedure TMainView.btnDeleteClick(Sender: TObject);
var
  LResponse: TXDataClientResponse;
begin
  if not XDataWebConnection1.Connected then
    XDataWebConnection1.Open;

  if await(TModalResult, MessageDlgAsync('Confirma realmente deletar o registro?', mtConfirmation, [mbYes, mbNo])) <> mrYes then
    Exit;

  LResponse := TAwait.Exec<TXDataClientResponse>(
    XDataWebClient1.RawInvokeAsync('IClientesService.Delete', [StrToIntDef(edtCodigo.Text, 0)]));

  ShowMessage('StatusCode: ' + LResponse.StatusCode.ToString + sLineBreak +
   'ResponseText: ' + LResponse.ResponseText);
end;

procedure TMainView.btnPostClick(Sender: TObject);
var
  LView: TClientesCadastrarView;
  LResponse: TXDataClientResponse;
  LCliente: TJSObject;
begin
  LView := TClientesCadastrarView.Create(Self);
  try
    LView.Popup := True;
    LView.Border := fbDialogSizeable;

    //CARREGAR ARQUIVO HTML TEMPLATE + CONTROLES
    TAwait.ExecP<TClientesCadastrarView>(LView.Load());

    //EXECUTAR FORMULARIO E AGUARDAR FECHAMENTO
    if TAwait.ExecP<TModalResult>(LView.Execute) <> mrOk then
      Exit;

    LCliente := Self.GetClientePreenchido(LView);
  finally
    LView.Free;
  end;

  LResponse := TAwait.Exec<TXDataClientResponse>(
    XDataWebClient1.RawInvokeAsync('IClientesService.Post', [LCliente]));

  ShowMessage(LResponse.ResponseText);
end;

procedure TMainView.btnAlterarClick(Sender: TObject);
var
  LView: TClientesCadastrarView;
  LResponse: TXDataClientResponse;
  LCliente: TJSObject;
begin
   if XDataWebDataSet1Id.AsInteger <= 0 then
  begin
    MessageDlg('Informe o código desejado', mtInformation, []);
    edtCodigo.SetFocus;
    Exit;
  end;

  LView := TClientesCadastrarView.Create(Self);
  try
    LView.Popup := True;
    LView.Border := fbDialogSizeable;

    //CARREGAR ARQUIVO HTML TEMPLATE + CONTROLES
    TAwait.ExecP<TClientesCadastrarView>(LView.Load());

    LView.edtCodigo.Text := XDataWebDataSet1Id.AsString;
    LView.edtNome.Text := XDataWebDataSet1Nome.AsString;
    LView.edtIdCidade.Value := XDataWebDataSet1IdCidade.AsInteger;
    LView.edtProfissao.Text := XDataWebDataSet1Profissao.AsString;
    LView.edtPorcentagem.Value := XDataWebDataSet1Porcentagem.AsInteger;
    LView.edtLimite.Text := XDataWebDataSet1Limite.AsString;
    LView.ckAtivo.Checked := XDataWebDataSet1Ativo.AsBoolean;

    //EXECUTAR FORMULARIO E AGUARDAR FECHAMENTO
    if TAwait.ExecP<TModalResult>(LView.Execute) <> mrOk then
      Exit;

    LCliente := Self.GetClientePreenchido(LView);
  finally
    LView.Free;
  end;

  LResponse := TAwait.Exec<TXDataClientResponse>(
    XDataWebClient1.RawInvokeAsync('IClientesService.Update', [XDataWebDataSet1Id.AsInteger, LCliente]));

  ShowMessage(LResponse.ResponseText);
end;

function TMainView.GetClientePreenchido(const AView: TClientesCadastrarView): TJSObject;
begin
  Result := TJSObject.new;
  Result['IdCidade'] := AView.edtIdCidade.Value;
  Result['Nome'] := AView.edtNome.Text;
  Result['Profissao'] := AView.edtProfissao.Text;
  Result['Limite'] := AView.edtLimite.Value;
  Result['Porcentagem'] := AView.edtPorcentagem.Value;
  Result['Ativo'] := AView.ckAtivo.Checked;
end;

end.
