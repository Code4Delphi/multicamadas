unit Main.View;

interface

uses
  System.SysUtils,
  System.Classes,
  System.Math,
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
  Produtos.Cadastrar.View,
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
  TProdutoFiltros = class
  public
    Id: Integer;
    Nome: string;
    Registro: Integer;
    Offset: Integer;
    Limit: Integer;
  end;

  TMainView = class(TWebForm)
    WebLabel1: TWebLabel;
    lbImportant: TWebLabel;
    lbWarning: TWebLabel;
    lbInformational: TWebLabel;
    WebMessageDlg1: TWebMessageDlg;
    WebPanel1: TWebPanel;
    lbCodigo: TWebLabel;
    edtCodigo: TWebEdit;
    btnGetEstoque: TWebButton;
    btnGet: TWebButton;
    XDataWebConnection1: TXDataWebConnection;
    XDataWebClient1: TXDataWebClient;
    XDataWebDataSet1: TXDataWebDataSet;
    WebDataSource1: TWebDataSource;
    btnListar: TWebButton;
    btnPost: TWebButton;
    btnAlterar: TWebButton;
    btnDelete: TWebButton;
    TMSFNCDataGrid1: TTMSFNCDataGrid;
    TMSFNCDataGridDatabaseAdapter1: TTMSFNCDataGridDatabaseAdapter;
    XDataWebDataSet1Id: TIntegerField;
    XDataWebDataSet1Nome: TStringField;
    XDataWebDataSet1Estoque: TFloatField;
    XDataWebDataSet1Preco: TFloatField;
    XDataWebDataSet1Registro: TIntegerField;
    btnProximo: TWebButton;
    btnUltimo: TWebButton;
    btnAnterior: TWebButton;
    btnPrimeiro: TWebButton;
    lbPaginacao: TWebLabel;
    procedure lbImportantClick(Sender: TObject);
    [Async]
    procedure lbWarningClick(Sender: TObject);
    procedure lbInformationalClick(Sender: TObject);
    [Async]
    procedure btnGetEstoqueClick(Sender: TObject);
    procedure WebFormCreate(Sender: TObject);
    [Async]
    procedure btnGetClick(Sender: TObject);
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
    procedure btnPrimeiroClick(Sender: TObject);
    procedure btnAnteriorClick(Sender: TObject);
    procedure btnProximoClick(Sender: TObject);
    procedure btnUltimoClick(Sender: TObject);
  private
    FPageIndex: Integer;
    FPageSize: Integer;
    FPageTotal: Integer;
    FRecordsTotal: Integer;
    function GetProdutoPreenchido(const AView: TProdutosCadastrarView): TJSObject;
    procedure ProcessaPaginacao;
    [Async]
    procedure ListarDados;
  public

  end;

var
  MainView: TMainView;

implementation

{$R *.dfm}

procedure TMainView.WebFormCreate(Sender: TObject);
begin
  FPageSize := 15;
  FPageIndex := 1;
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

procedure TMainView.btnGetEstoqueClick(Sender: TObject);
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
    XDataWebClient1.RawInvokeAsync('IProdutosService.GetEstoque', [StrToIntDef(edtCodigo.Text, 0)]));

  ShowMessage('O estoque do produto é: ' + string(TJSObject(LResponse.Result)['value']));
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
    XDataWebClient1.RawInvokeAsync('IProdutosService.Get', [StrToIntDef(edtCodigo.Text, 0)]));

  XDataWebDataSet1.Close;
  XDataWebDataSet1.SetJsonData(LResponse.Result);
  XDataWebDataSet1.Open;
end;

procedure TMainView.btnListarClick(Sender: TObject);
begin
  FPageIndex := 1;
  Self.ListarDados;
end;

procedure TMainView.ListarDados;
var
  LResponse: TXDataClientResponse;
  LFiltros: TProdutoFiltros;
begin
  if not XDataWebConnection1.Connected then
    XDataWebConnection1.Open;

  LFiltros := TProdutoFiltros.Create;
  try
    LFiltros.Offset := (FPageIndex - 1) * FPageSize;
    LFiltros.Limit  := FPageSize;

    LResponse := TAwait.Exec<TXDataClientResponse>(
      XDataWebClient1.RawInvokeAsync('IProdutosService.List', [LFiltros]));
  finally
    LFiltros.Free;
  end;

  XDataWebDataSet1.Close;
  XDataWebDataSet1.SetJsonData(TJSObject(LResponse.Result)['ListProdutos']);
  XDataWebDataSet1.Open;

  FRecordsTotal := Integer(TJSObject(LResponse.Result)['RecordsTotal']);
  Self.ProcessaPaginacao;
end;

procedure TMainView.ProcessaPaginacao;
begin
  FPageTotal := 1;
  if FPageSize > 0 then
    FPageTotal := Ceil(FRecordsTotal / FPageSize);

  lbPaginacao.Caption := Format('Página %d de %d', [FPageIndex, FPageTotal]);
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
    XDataWebClient1.RawInvokeAsync('IProdutosService.Delete', [StrToIntDef(edtCodigo.Text, 0)]));

  ShowMessage('StatusCode: ' + LResponse.StatusCode.ToString + sLineBreak +
   'ResponseText: ' + LResponse.ResponseText);
end;

procedure TMainView.btnPostClick(Sender: TObject);
var
  LView: TProdutosCadastrarView;
  LResponse: TXDataClientResponse;
  LProduto: TJSObject;
begin
  LView := TProdutosCadastrarView.Create(Self);
  try
    LView.Popup := True;
    LView.Border := fbDialogSizeable;

    //CARREGAR ARQUIVO HTML TEMPLATE + CONTROLES
    TAwait.ExecP<TProdutosCadastrarView>(LView.Load());

    //EXECUTAR FORMULARIO E AGUARDAR FECHAMENTO
    if TAwait.ExecP<TModalResult>(LView.Execute) <> mrOk then
      Exit;

    LProduto := Self.GetProdutoPreenchido(LView);
  finally
    LView.Free;
  end;

  LResponse := TAwait.Exec<TXDataClientResponse>(
    XDataWebClient1.RawInvokeAsync('IProdutosService.Post', [LProduto]));

  ShowMessage('Id do produto inserido: ' + string(TJSObject(LResponse.Result)['value']));
end;

procedure TMainView.btnAlterarClick(Sender: TObject);
var
  LView: TProdutosCadastrarView;
  LResponse: TXDataClientResponse;
  LProduto: TJSObject;
begin
   if XDataWebDataSet1id.AsInteger <= 0 then
  begin
    MessageDlg('Informe o código desejado', mtInformation, []);
    edtCodigo.SetFocus;
    Exit;
  end;

  LView := TProdutosCadastrarView.Create(Self);
  try
    LView.Popup := True;
    LView.Border := fbDialogSizeable;

    //CARREGAR ARQUIVO HTML TEMPLATE + CONTROLES
    TAwait.ExecP<TProdutosCadastrarView>(LView.Load());

    LView.edtCodigo.Text := XDataWebDataSet1id.AsString;
    LView.edtNome.Text := XDataWebDataSet1nome.AsString;
    LView.edtEstoque.Text := XDataWebDataSet1estoque.AsString;
    LView.edtPreco.Text := XDataWebDataSet1preco.AsString;
    LView.edtRegistro.Value := XDataWebDataSet1registro.AsInteger;

    //EXECUTAR FORMULARIO E AGUARDAR FECHAMENTO
    if TAwait.ExecP<TModalResult>(LView.Execute) <> mrOk then
      Exit;

    LProduto := Self.GetProdutoPreenchido(LView);
  finally
    LView.Free;
  end;

  LResponse := TAwait.Exec<TXDataClientResponse>(
    XDataWebClient1.RawInvokeAsync('IProdutosService.Update', [XDataWebDataSet1Id.AsInteger, LProduto]));

  ShowMessage('StatusCode: ' + LResponse.StatusCode.ToString + sLineBreak +
   'ResponseText: ' + LResponse.ResponseText);
end;

function TMainView.GetProdutoPreenchido(const AView: TProdutosCadastrarView): TJSObject;
begin
  Result := TJSObject.new;
  Result['Nome'] := AView.edtNome.Text;
  Result['Estoque'] := StrToFloatDef(AView.edtEstoque.Text, 0);
  Result['Preco'] := StrToFloatDef(AView.edtPreco.Text, 0);
  Result['Registro'] := AView.edtRegistro.Value;
end;

procedure TMainView.btnPrimeiroClick(Sender: TObject);
begin
  FPageIndex := 1;
  Self.ListarDados;
end;

procedure TMainView.btnAnteriorClick(Sender: TObject);
begin
  if FPageIndex > 1 then
  begin
    Dec(FPageIndex);
    Self.ListarDados;
  end;
end;

procedure TMainView.btnProximoClick(Sender: TObject);
begin
  if FPageIndex < FPageTotal then
  begin
    Inc(FPageIndex);
    Self.ListarDados;
  end;
end;

procedure TMainView.btnUltimoClick(Sender: TObject);
begin
  FPageIndex := FPageTotal;
  Self.ListarDados;
end;

end.
