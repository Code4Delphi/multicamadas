unit Produtos.DTO;

interface

type
  TProduto = class
  private
    FId: Integer;
    FNome: string;
    FEstoque: Double;
    FPreco: Double;
    FRegistro: Integer;
  public
    property Id: Integer read FId write FId;
    property Nome: string read FNome write FNome;
    property Estoque: Double read FEstoque write FEstoque;
    property Preco: Double read FPreco write FPreco;
    property Registro: Integer read FRegistro write FRegistro;
  end;

implementation

end.
