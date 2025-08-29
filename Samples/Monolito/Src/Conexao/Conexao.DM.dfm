object ConexaoDM: TConexaoDM
  OnCreate = DataModuleCreate
  Height = 381
  Width = 310
  object FDGUIxWaitCursor1: TFDGUIxWaitCursor
    Provider = 'Forms'
    Left = 136
    Top = 120
  end
  object FDPhysSQLiteDriverLink1: TFDPhysSQLiteDriverLink
    Left = 136
    Top = 192
  end
  object FDConnection1: TFDConnection
    Params.Strings = (
      'Database=C:\Lives\monolito-multicamadas-live\Samples\DB\dados.db'
      'DriverID=SQLite')
    LoginPrompt = False
    Left = 136
    Top = 56
  end
end
