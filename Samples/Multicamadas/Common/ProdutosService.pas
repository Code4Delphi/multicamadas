unit ProdutosService;

interface

uses
  System.Generics.Collections,
  XData.Service.Common,
  Produtos.DTO;

type
  TProdutoFiltros = class
  public
    Id: Integer;
    Nome: string;
    Registro: Integer;
    Offset: Integer;
    Limit: Integer;
  end;

  TResultList = class
  private
    FRecordsTotal: Integer;
    FListProdutos: TList<TProduto>;
  public
    property RecordsTotal: Integer read FRecordsTotal write FRecordsTotal;
    property ListProdutos: TList<TProduto> read FListProdutos write FListProdutos;
    constructor Create;
    destructor Destroy; override;
  end;

  [ServiceContract]
  IProdutosService = interface(IInvokable)
    ['{DECC5B93-5FAF-4166-9985-D72518081EF0}']
    [HttpGet]
    function GetEstoque(id: Integer): Double;
    [HttpGet, Route('{id}')]
    function Get(Id: Integer): TProduto;
    [HttpGet, Route('')]
    function List([FromQuery] Filtros: TProdutoFiltros): TResultList;
    [HttpPost, Route('')]
    function Post(Produto: TProduto): Integer;
    [HttpPut, Route('{id}')]
    procedure Update(Id: Integer; Produto: TProduto);
    [HttpDelete, Route('{id}')]
    procedure Delete(Id: Integer);
  end;

implementation

{ TResultList }

constructor TResultList.Create;
begin
  FListProdutos := TList<TProduto>.Create;
end;

destructor TResultList.Destroy;
begin
   FListProdutos.Free;
  inherited;
end;

initialization
  RegisterServiceType(TypeInfo(IProdutosService));

end.
