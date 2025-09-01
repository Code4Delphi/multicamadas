unit LoginServiceImplementation;

interface

uses
  System.SysUtils,
  XData.Server.Module,
  XData.Service.Common,
  LoginService,
  Bcl.JOSE.Core.Builder,
  Bcl.Jose.Core.JWA,
  Bcl.JOSE.Core.JWT,
  Bcl.JOSE.Core.JWK;

type
  [ServiceImplementation]
  TLoginService = class(TInterfacedObject, ILoginService)
  private
    function Login(const User, Password: string): string;
  end;

implementation

function TLoginService.Login(const User, Password: string): string;
var
  LJWT: TJWT;
begin
  if (User <> 'admin') or (Password <> 'admin') then
    raise Exception.Create('Usuário ou senha inválidos');

  LJWT := TJWT.Create;
  try
    //CLAIMS RESERVADAS
    LJWT.Claims.Issuer := 'Code4Delphi';
    LJWT.Claims.Subject := '123';
    LJWT.Claims.Expiration := Now + 100;

    //MINHAS CLAIMS
    LJWT.Claims.SetClaimOfType<string>('usuario', User);
    LJWT.Claims.SetClaimOfType<Boolean>('admin', True);
    LJWT.Claims.SetClaimOfType<string>('teste', 'asdf');

    Result := TJOSE.SHA256CompactToken('sua-chave-secreta-1234567890-12345', LJWT);
  finally
    LJWT.Free;
  end;
end;

initialization
  RegisterServiceType(TLoginService);

end.
