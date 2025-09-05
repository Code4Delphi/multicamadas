# Multicamadas
Aplicação de exemplo de como transformar uma aplicação de arquitetura monolítica em uma arquitetura em camadas


## 🔷 Componentes utilizados
| Nome              | Local utilizado | Download | Demonstração | Descrição |
|-------------------|-----------------| ---------|--------------|-----------|
| **XData**         | Criação e consumo da API Rest | [Download](https://www.tmssoftware.com/site/xdata.asp) | [Demonstração](https://www.youtube.com/watch?v=cwb6_SKbB6A&list=PLLHSz4dOnnN2Xlf7OX47cF20gbmz9-9z0) | TMS XData é um Framework Delphi para desenvolvimento de servidores de API REST/JSON |
| **TMS Web Core**  | Criação do client Web | [Download](https://www.tmssoftware.com/site/tmswebcore.asp) | [Demonstração](https://www.youtube.com/watch?v=n51xdFBRzX0&list=PLLHSz4dOnnN2Xlf7OX47cF20gbmz9-9z0) | Framework para criação de aplicações web modernas em Delphi |
| **FNC Data Grid** | Grid para client Web  | [Download](https://github.com/Code4Delphi/TMS-FNC-DataGridSample) | [Demonstração](https://www.youtube.com/watch?v=gB2Fz69LlDs&list=PLLHSz4dOnnN2Xlf7OX47cF20gbmz9-9z0) | O TMS FNC Grid oferece uma grade totalmente multiplataforma, de alto desempenho, versátil e repleta de recursos|



## 🔶 Samples
🔸 **Aplicação monolítica que será refatorada:** 
| [Aplicação monolítica](Samples/Monolito) |
|---|

🔸 **Aplicação multicamadas:**

Back-end:
| [ServerAuth](Samples/Multicamadas/ServerAuth) | [Server](Samples/Multicamadas/Server) | 
|---|---|

Front-end:
| [ClientVCL](Samples/Multicamadas/ClientVCL) | [ClientFMX](Samples/Multicamadas/ClientFMX) | [ClientWeb](Samples/Multicamadas/ClientWeb) |
|---|---|---|

## 🔷 Postman
O postman é uma ótima ferramenta e pode ser utilizada para realziar teste de acesso as APIs, segue o link do arquivo para importação da collection a ser importada no Postman: [Multicamadas-Cod4Delphi.postman_collection.json](Extras/Multicamadas-Cod4Delphi.postman_collection.json)
