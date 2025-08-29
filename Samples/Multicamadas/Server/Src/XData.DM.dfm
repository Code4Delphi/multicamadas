object XDataDM: TXDataDM
  Height = 411
  Width = 572
  object SparkleHttpSysDispatcher1: TSparkleHttpSysDispatcher
    Left = 136
    Top = 64
  end
  object XDataServer1: TXDataServer
    BaseUrl = 'http://localhost:2001/tms/xdata'
    Dispatcher = SparkleHttpSysDispatcher1
    EntitySetPermissions = <>
    Left = 136
    Top = 136
  end
end
