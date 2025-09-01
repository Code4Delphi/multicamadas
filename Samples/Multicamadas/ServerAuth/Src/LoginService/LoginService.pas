unit LoginService;

interface

uses
  XData.Service.Common;

type
  [ServiceContract]
  ILoginService = interface(IInvokable)
    ['{B9EC981F-FFC0-4171-8E46-8CAA2D301B21}']
    [HttpPost, Route('')]
    function Login(const User, Password: string): string;
  end;

implementation

initialization
  RegisterServiceType(TypeInfo(ILoginService));

end.
