unit ProdutosServiceImplementation;

interface

uses
  System.SysUtils,
  System.Generics.Collections,
  FireDac.Stan.Param,
  Data.DB,
  XData.Server.Module,
  XData.Service.Common,
  ProdutosService,
  Produtos.DM,
  Produtos.DTO;

type
  [ServiceImplementation]
  TProdutosService = class(TInterfacedObject, IProdutosService)
  private
    FDm: TProdutosDM;
    FList: TList<TProduto>;
    function GetEstoque(id: Integer): Double;
    function Get(Id: Integer): TProduto;
    function List([FromQuery] Filtros: TProdutoFiltros): TList<TProduto>;
    function Post(Produto: TProduto): Integer;
    procedure Alterar(Id: Integer; Produto: TProduto);
    procedure Delete(Id: Integer);
  public
    constructor Create;
    destructor Destroy; override;
  end;

implementation

constructor TProdutosService.Create;
begin
  FDm := TProdutosDM.Create(nil);
end;

destructor TProdutosService.Destroy;
begin
  FDm.Free;
  inherited;
end;

function TProdutosService.GetEstoque(id: Integer): Double;
begin
  FDm.Listar('where id = ' + id.ToString);
  Result := FDm.QListarestoque.AsFloat;
end;

function TProdutosService.Get(Id: Integer): TProduto;
begin
  FDm.Listar('where id = ' + id.ToString);

  if FDm.QListar.IsEmpty then
    Exit(nil);

  Result := TProduto.Create;
  Result.Id := FDm.QListarid.AsInteger;
  Result.Nome := FDm.QListarnome.AsString;
  Result.Estoque := FDm.QListarestoque.AsFloat;
  Result.Preco := FDm.QListarpreco.AsFloat;
  Result.Registro := FDm.QListarRegistro.AsInteger;
end;

function TProdutosService.List([FromQuery] Filtros: TProdutoFiltros): TList<TProduto>;
var
  LProduto: TProduto;
begin
  FDm.QListar.Close;
  FDm.QListar.SQL.Add('where 1 = 1');

  if Filtros.Id > 0 then
  begin
    FDm.QListar.SQL.Add('and produtos.id = :Id');
    FDm.QListar.ParamByName('Id').AsInteger := Filtros.Id;
  end;

  if not Filtros.Nome.IsEmpty then
  begin
    FDm.QListar.SQL.Add('and produtos.nome like :Nome');
    FDm.QListar.ParamByName('Nome').AsString := '%' + Filtros.Nome + '%';
  end;

  if Filtros.Registro > 0 then
  begin
    FDm.QListar.SQL.Add('and produtos.Registro like :Registro');
    FDm.QListar.ParamByName('Registro').AsString := '%' + Filtros.Registro.ToString + '%';
  end;

  FDm.QListar.Open;

  if FDm.QListar.IsEmpty then
    Exit(nil);

  FreeAndNil(FList);
  FList := TList<TProduto>.Create;

  FDm.QListar.First;
  while not FDm.QListar.Eof do
  begin
    LProduto := TProduto.Create;
    LProduto.Id := FDm.QListarid.AsInteger;
    LProduto.Nome := FDm.QListarnome.AsString;
    LProduto.Estoque := FDm.QListarestoque.AsFloat;
    LProduto.Preco := FDm.QListarpreco.AsFloat;
    LProduto.Registro := FDm.QListarRegistro.AsInteger;
    FList.Add(LProduto);

    FDm.QListar.Next;
  end;

  Result := FList;
end;

function TProdutosService.Post(Produto: TProduto): Integer;
begin
  FDm.Cadastrar(0);
  FDm.QCadastrar.Append;
  FDm.QCadastrarid.AsInteger := Produto.Id;
  FDm.QCadastrarnome.AsString := Produto.Nome;
  FDm.QCadastrarestoque.AsFloat := Produto.Estoque;
  FDm.QCadastrarpreco.AsFloat := Produto.Preco;
  FDm.QCadastrarRegistro.AsInteger := Produto.Registro;
  FDm.QCadastrar.Post;

  Result := FDm.QCadastrarid.AsInteger;
end;

procedure TProdutosService.Alterar(Id: Integer; Produto: TProduto);
begin
  FDm.Cadastrar(Id);

  if FDm.QCadastrar.IsEmpty then
    raise Exception.Create('Produto não encontrado para alteração');

  FDm.QCadastrar.Edit;
  FDm.QCadastrarnome.AsString := Produto.Nome;
  FDm.QCadastrarestoque.AsFloat := Produto.Estoque;
  FDm.QCadastrarpreco.AsFloat := Produto.Preco;
  FDm.QCadastrarRegistro.AsFloat := Produto.Registro;
  FDm.QCadastrar.Post;
end;

procedure TProdutosService.Delete(Id: Integer);
begin
  FDm.Cadastrar(Id);

  if FDm.QCadastrar.IsEmpty then
    raise Exception.Create('Produto não encontrado para exclusão');

  FDm.QCadastrar.Delete;
end;

initialization
  RegisterServiceType(TProdutosService);

end.
