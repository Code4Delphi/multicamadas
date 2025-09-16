# Do Monolito ao Multicamadas

Exemplos que demonstram a transformação de uma arquitetura monolítica em uma arquitetura em camadas. Esses exemplos fazem parte da minha palestra apresentada na Embarcadero Conference 2025, com o tema "Uma Base de Código, Três Frentes: Delphi Desktop, Mobile e Web. Do Monolito à Arquitetura em Camadas".

## 📚 Slides da epresentação
[Slides apresentação Econ2025](Extras/Econ2025-Cesar-Cardoso.pdf)

## 🔷 Componentes utilizados
| Nome              | Local utilizado               | Download                                                          | Demonstração                                                                                        | Descrição                                                                                       |
|-------------------|-------------------------------| ------------------------------------------------------------------|-----------------------------------------------------------------------------------------------------|-------------------------------------------------------------------------------------------------|
| **TMS XData**         | Criação e consumo da API Rest | [Download](https://www.tmssoftware.com/site/xdata.asp)            | [Demonstração](https://www.youtube.com/watch?v=cwb6_SKbB6A&list=PLLHSz4dOnnN2Xlf7OX47cF20gbmz9-9z0) | TMS XData é um Framework Delphi para desenvolvimento de servidores de API REST/JSON             |
| **TMS Web Core**  | Criação do client Web         | [Download](https://www.tmssoftware.com/site/tmswebcore.asp)       | [Demonstração](https://www.youtube.com/watch?v=n51xdFBRzX0&list=PLLHSz4dOnnN2Xlf7OX47cF20gbmz9-9z0) | Framework para criação de aplicações web modernas em Delphi                                     |
| **TMS FNC Data Grid** | Grid para client Web          | [Download](https://github.com/Code4Delphi/TMS-FNC-DataGridSample) | [Demonstração](https://www.youtube.com/watch?v=gB2Fz69LlDs&list=PLLHSz4dOnnN2Xlf7OX47cF20gbmz9-9z0) | Oferece uma grade totalmente multiplataforma, de alto desempenho, versátil e repleta de recursos|


## 🔶 Samples
🔸 **Aplicação monolítica que será refatorada:** 
| [Aplicação monolítica](Samples/Monolito) | Aplicação com arquitetura monolítica que servirá de base para a criação da aplicação em arquitetura multicamadas |
|---|---| 


🔸 **Aplicação multicamadas:**

Back-end:

| Nome | Descrição |
|------|-----------|
| [ServerAuth](Samples/Multicamadas/ServerAuth) | Servidor de autenticação, utilizado para validar permissões de acesso por meio de JWT |
| [Server](Samples/Multicamadas/Server)         | API REST que proverá os dados a serem consumidos pelos front-ends                     |

Front-end:

| Nome | Descrição |
|------|-----------|
| [ClientVCL](Samples/Multicamadas/ClientVCL) | Aplicação desktop em Delphi VCL que consome os dados da API REST |
| [ClientFMX](Samples/Multicamadas/ClientFMX) | Aplicação multiplataforma em Delphi FMX (Windows, macOS, Android, iOS) que consome os dados da API REST |
| [ClientWeb](Samples/Multicamadas/ClientWeb) | Aplicação web criada com TMS Web Core que consome os dados da API REST |


## 🛠️ Ferramentas auxiliares
| Nome              | Link                                                              | Descrição                                                                                       |
|-------------------| ------------------------------------------------------------------|-------------------------------------------------------------------------------------------------|
| **Postman**       | [Postman.com](https://www.postman.com/)                           | É uma ótima ferramenta que pode ser utilizada para realizar testes de acesso às APIs. Criamos uma collection para facilitar os testes e o entendimento do consumo das APIs REST desta aplicação de exemplo. Segue o link para importação no Postman: [Multicamadas-Cod4Delphi.postman_collection.json](Extras/Multicamadas-Cod4Delphi.postman_collection.json)|
| **Ngrok** | [Download](https://ngrok.com/downloads/) | O Ngrok é uma ferramenta que cria túneis seguros, permitindo expor servidores locais à internet. ([vídeo de desmonstração de uso do Ngrok](https://youtu.be/9KxcsnSL_5U?si=8PGvonKkc-IzmGsl&t=516)) |




## 📞 Contatos
[![Telegram](https://img.shields.io/badge/Telegram-Join-blue?logo=telegram)](https://t.me/Code4Delphi)
[![YouTube](https://img.shields.io/badge/YouTube-Join-red?logo=youtube&logoColor=red)](https://www.youtube.com/@code4delphi)
[![Instagram](https://img.shields.io/badge/Intagram-Follow-red?logo=instagram&logoColor=pink)](https://www.instagram.com/code4delphi/)
[![LinkedIn](https://img.shields.io/badge/LinkedIn-Connect-blue)](https://www.linkedin.com/in/cesar-cardoso-dev)
[![Blog](https://img.shields.io/badge/Blog-Code4Delphi-F00?logo=delphi)](https://code4delphi.com.br/blog/)
[![Course](https://img.shields.io/badge/Course-Delphi-F00?logo=delphi)](https://go.hotmart.com/U81331747Y?dp=1)
[![E-mail](https://img.shields.io/badge/E--mail-Send-yellowgreen?logo=maildotru&logoColor=yellowgreen)](mailto:contato@code4delphi.com.br)
