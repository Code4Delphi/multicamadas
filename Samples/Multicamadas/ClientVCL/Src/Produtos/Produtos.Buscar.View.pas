unit Produtos.Buscar.View;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  System.UITypes,
  System.Generics.Collections,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Data.DB,
  Vcl.Grids,
  Vcl.DBGrids,
  Vcl.StdCtrls,
  Vcl.Buttons,
  Vcl.ExtCtrls,
  XData.Client,
  Aurelius.Bind.BaseDataset,
  Aurelius.Bind.Dataset,
  Produtos.DTO,
  ProdutosService,
  Produtos.Cadastrar.View;

type
  TProdutosBuscarView = class(TForm)
    pnTopo: TPanel;
    Label1: TLabel;
    edtBuscar: TEdit;
    pnRodape: TPanel;
    rdGroupFiltros: TRadioGroup;
    btnCadastrar: TBitBtn;
    btnFechar: TBitBtn;
    btnAlterar: TBitBtn;
    pnTotal: TPanel;
    lbTotal: TLabel;
    pnGrid: TPanel;
    DBGrid1: TDBGrid;
    DataSource1: TDataSource;
    Label2: TLabel;
    Dataset1: TAureliusDataset;
    btnAtualizar: TBitBtn;
    btnExcluir: TBitBtn;
    Dataset1Nome: TStringField;
    Dataset1Id: TIntegerField;
    Dataset1Estoque: TFloatField;
    Dataset1Preco: TFloatField;
    Dataset1Registro: TIntegerField;
    procedure edtBuscarChange(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnFecharClick(Sender: TObject);
    procedure btnCadastrarClick(Sender: TObject);
    procedure DBGrid1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnAlterarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnAtualizarClick(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure Dataset1ObjectRemove(Dataset: TDataSet; AObject: TObject);
  private
    FXDataClient: TXDataClient;
    FResultList: TResultList;
    FRecordsTotal: Integer;
    procedure ListarDados;
    procedure ChamarTelaCadastrar(const AId: Integer = 0);
  public

  end;

var
  ProdutosBuscarView: TProdutosBuscarView;

implementation

{$R *.dfm}

procedure TProdutosBuscarView.FormCreate(Sender: TObject);
begin
  FXDataClient := TXDataClient.Create;
  FXDataClient.Uri := 'http://localhost:8000/tms/xdata/';
  FRecordsTotal := 0;
end;

procedure TProdutosBuscarView.FormDestroy(Sender: TObject);
begin
  Dataset1.Close;
  FXDataClient.Free;
end;

procedure TProdutosBuscarView.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  case Key of
    VK_F4:
    begin
      if ssAlt in Shift then
        Key := 0;
    end;
    VK_F5:
      Self.ListarDados;
    VK_ESCAPE:
      btnFechar.Click;
  end;

  if Key in[VK_F1..VK_F12] then
  begin
    if rdGroupFiltros.Items.Count >= Key - VK_F1 then
      rdGroupFiltros.ItemIndex := Key - VK_F1;
  end;
end;

procedure TProdutosBuscarView.edtBuscarChange(Sender: TObject);
begin
  Self.ListarDados;
end;

procedure TProdutosBuscarView.btnFecharClick(Sender: TObject);
begin
  Self.Close;
end;

procedure TProdutosBuscarView.btnAtualizarClick(Sender: TObject);
begin
  Self.ListarDados;
end;

procedure TProdutosBuscarView.ListarDados;
var
  LProdutosService: IProdutosService;
  LFiltros: TProdutoFiltros;
begin
  Screen.Cursor := crHourGlass;
  try
    Dataset1.Close;
    LProdutosService := FXDataClient.Service<IProdutosService>;

    LFiltros := TProdutoFiltros.Create;
    try
      case rdGroupFiltros.ItemIndex of
        0: LFiltros.Id := StrToIntDef(edtBuscar.Text, 0);
        1: LFiltros.Nome := edtBuscar.Text;
        2: LFiltros.Registro := StrToIntDef(edtBuscar.Text, 0);
      end;

      FResultList := LProdutosService.List(LFiltros);
    finally
      LFiltros.Free;
    end;

    FRecordsTotal := FResultList.RecordsTotal;

    Dataset1.SetSourceList(FResultList.ListProdutos);
    Dataset1.Open;
    Dataset1.Last;

    lbTotal.Caption := FormatFloat('000000', DataSource1.DataSet.RecordCount);
  finally
    Screen.Cursor := crDefault;
  end;
end;

procedure TProdutosBuscarView.DBGrid1DblClick(Sender: TObject);
begin
  btnAlterar.Click;
end;

procedure TProdutosBuscarView.DBGrid1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if (ssCtrl in Shift) and (Key = VK_DELETE) then
    Key := 0;
end;

procedure TProdutosBuscarView.btnExcluirClick(Sender: TObject);
begin
  if Dataset1.IsEmpty then
    raise Exception.Create('Selecione um registro para continuar');

  if MessageDlg('Deseja realmente excluir este registro?', mtConfirmation, [mbYes, mbNo], 0) <> mrYes then
    Exit;

  Dataset1.Delete;
  lbTotal.Caption := FormatFloat('000000', DataSource1.DataSet.RecordCount);
end;

procedure TProdutosBuscarView.Dataset1ObjectRemove(Dataset: TDataSet; AObject: TObject);
var
  LProdutosService: IProdutosService;
begin
  LProdutosService := FXDataClient.Service<IProdutosService>;
  LProdutosService.Delete(TProduto(AObject).Id);
end;

procedure TProdutosBuscarView.btnCadastrarClick(Sender: TObject);
begin
  Self.ChamarTelaCadastrar;
end;

procedure TProdutosBuscarView.btnAlterarClick(Sender: TObject);
begin
  if Dataset1.IsEmpty then
    raise Exception.Create('Selecione um registro para continuar');

  Self.ChamarTelaCadastrar(Dataset1Id.AsInteger);
end;

procedure TProdutosBuscarView.ChamarTelaCadastrar(const AId: Integer = 0);
var
  LView: TProdutosCadastrarView;
begin
  LView := TProdutosCadastrarView.Create(nil);
  try
    LView.IdAlterar := AId;
    if LView.ShowModal <> mrOk then
      Exit;

    Self.ListarDados;
    DataSet1.Locate('id', LView.IdSelecionado, [loCaseInsensitive]);
  finally
    LView.Free;
  end;
end;

end.
