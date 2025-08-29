object ProdutosDM: TProdutosDM
  OnCreate = DataModuleCreate
  Height = 480
  Width = 640
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
  object QCadastrar: TFDQuery
    Connection = FDConnection1
    SQL.Strings = (
      'select * '
      'from produtos'
      'where id = :ID'
      'limit 1')
    Left = 136
    Top = 272
    ParamData = <
      item
        Name = 'ID'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end>
    object QCadastrarid: TFDAutoIncField
      FieldName = 'id'
      Origin = 'id'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = False
      DisplayFormat = '000000'
    end
    object QCadastrarnome: TWideStringField
      FieldName = 'nome'
      Origin = 'nome'
      Size = 40
    end
    object QCadastrarestoque: TFloatField
      FieldName = 'estoque'
      Origin = 'estoque'
      DisplayFormat = ',,0.00'
    end
    object QCadastrarpreco: TFloatField
      FieldName = 'preco'
      Origin = 'preco'
      DisplayFormat = ',,0.00'
    end
    object QCadastrarregistro: TIntegerField
      FieldName = 'registro'
      Origin = 'registro'
    end
  end
  object QListar: TFDQuery
    Connection = FDConnection1
    SQL.Strings = (
      'select * from produtos')
    Left = 224
    Top = 272
    object QListarid: TFDAutoIncField
      FieldName = 'id'
      Origin = 'id'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = False
      DisplayFormat = '000000'
    end
    object QListarnome: TWideStringField
      FieldName = 'nome'
      Origin = 'nome'
      Size = 40
    end
    object QListarestoque: TFloatField
      FieldName = 'estoque'
      Origin = 'estoque'
      DisplayFormat = ',,0.00'
    end
    object QListarpreco: TFloatField
      FieldName = 'preco'
      Origin = 'preco'
      DisplayFormat = ',,0.00'
    end
    object QListarregistro: TIntegerField
      FieldName = 'registro'
      Origin = 'registro'
    end
  end
end
