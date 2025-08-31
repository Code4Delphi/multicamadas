unit ClientFMX.Main.View;

interface

uses
  System.SysUtils,
  System.Types,
  System.UITypes,
  System.Classes,
  System.Variants,
  FMX.Types,
  FMX.Controls,
  FMX.Forms,
  FMX.Graphics,
  FMX.Dialogs,
  FMX.StdCtrls,
  FMX.Controls.Presentation,
  FMX.Objects,
  Produtos.Cadastrar.View;

type
  TClientFMXMainView = class(TForm)
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private

  public

  end;

var
  ClientFMXMainView: TClientFMXMainView;

implementation

{$R *.fmx}

procedure TClientFMXMainView.FormCreate(Sender: TObject);
begin
  ReportMemoryLeaksOnShutdown := True;
end;

procedure TClientFMXMainView.Button1Click(Sender: TObject);
var
  LView: TProdutosCadastrarView;
begin
  LView := TProdutosCadastrarView.Create(nil);
  LView.Show;
end;

end.
