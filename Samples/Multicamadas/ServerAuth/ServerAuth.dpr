program ServerAuth;

uses
  Vcl.Forms,
  ServerAuth.Main.View in 'Src\ServerAuth.Main.View.pas' {ServerAuthMainView},
  ServerAuth.XData.DM in 'Src\ServerAuth.XData.DM.pas' {ServerAuthXDataDM: TDataModule},
  LoginService in 'Src\LoginService\LoginService.pas',
  LoginServiceImplementation in 'Src\LoginService\LoginServiceImplementation.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'ServerAuth - Multicamadas C4D';
  Application.CreateForm(TServerAuthXDataDM, ServerAuthXDataDM);
  Application.CreateForm(TServerAuthMainView, ServerAuthMainView);
  Application.Run;
end.
