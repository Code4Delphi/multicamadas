object ServerXDataDM: TServerXDataDM
  Height = 411
  Width = 572
  object SparkleHttpSysDispatcher1: TSparkleHttpSysDispatcher
    Left = 136
    Top = 64
  end
  object XDataServer1: TXDataServer
    BaseUrl = 'http://+:8000/tms/xdata'
    Dispatcher = SparkleHttpSysDispatcher1
    EntitySetPermissions = <>
    SwaggerOptions.Enabled = True
    SwaggerUIOptions.Enabled = True
    Left = 136
    Top = 136
  end
end
