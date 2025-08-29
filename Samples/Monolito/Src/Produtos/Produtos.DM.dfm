object ProdutosDM: TProdutosDM
  Height = 362
  Width = 482
  object QCadastrar: TFDQuery
    Connection = ConexaoDM.FDConnection1
    SQL.Strings = (
      'select * '
      'from produtos'
      'where id = :ID'
      'limit 1')
    Left = 112
    Top = 72
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
    Connection = ConexaoDM.FDConnection1
    SQL.Strings = (
      'select * from produtos')
    Left = 200
    Top = 72
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
