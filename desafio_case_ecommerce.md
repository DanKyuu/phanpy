# Desafio Case Ecommerce

- Descrição:
    - Para simular um mundo real de ingestão de dados foi criado um Cloudformation para ingerir dados que serão processados e analisados.
    - O processo se inicia com funções AWS Lambda que geram dados aleatórios que são enviados ao Kinesis Streams.
    - O Kinesis Streams é consumido por três consumidores diferentes: Kinesis Firehose, Kinesis Data Analytics e uma Lambda Function. Então temos três destinados para cada registro.
    - O Kinesis Data Analytics realiza agregação nos dados em near real time. 
    - O Kinesis Firehose grava os dados brutos (raw) para um bucket S3 para ser analisado posteriormente.
    - Também há outra função Lambda que pode enviar dados para o ElasticSearch e na sequencia visualizá-los no Kibana.

- Fluxo de dados criado pelo Cloudformation:

    ![alt text](https://github.com/schmidt-samuel/fia_batalha_de_dados1/blob/master/desafio_case_ecommerce/imagens/fluxo_de_dados.png)


- Realizar deploy do Cloudformation template:
    - Apos logar na sua conta da AWS criada recentemente, clique neste link para iniciar o deploy do cloudformation:
    ```
    https://console.aws.amazon.com/cloudformation/home?region=us-east-1#/stacks/new?&templateURL=https:%2F%2Fs3.amazonaws.com%2Fhhug-demo-data%2Fkinesis-demo%2Fecommerce%2Fstreaming-ecommerce-es.template
    ```
   
    
- Preencher os valores dos parâmetros solicitados de forma semelhante ao seguinte exemplo:
     - obs 1: Lembre-se que o nome do S3 bucket (Bucket Name) tem que possuir um prefixo unico em nível global.
     - obs 2: Lembre-se de fazer deploy na region da N. Virgina (para escolhar a region selecione no conto de acima no lado direito do browser (na página da console da AWS) a region solicitada.

    ![alt text](https://github.com/schmidt-samuel/fia_batalha_de_dados1/blob/master/desafio_case_ecommerce/imagens/cloudformation_passo1.png)


- Verifique o status da evolução do cloudformation ecommerce:
    - Para verificar a evolução clique no link:
    ```
    https://console.aws.amazon.com/cloudformation/home?region=us-east-1#/stacks
    ```

    ![alt text](https://github.com/schmidt-samuel/fia_batalha_de_dados1/blob/master/desafio_case_ecommerce/imagens/cloudformation_passo2.png)


- Aguarde, entre 12 e 20 minutos, para o deploy fique com o status de completo (CREATE_COMPLETE):
  
    ![alt text](https://github.com/schmidt-samuel/fia_batalha_de_dados1/blob/master/desafio_case_ecommerce/imagens/cloudformation_passo3.png)


- Valide os recursos criados:

    ![alt text](https://github.com/schmidt-samuel/fia_batalha_de_dados1/blob/master/desafio_case_ecommerce/imagens/cloudformation_passo4.png)


   ## Kinesis
- Va para a console do Kinesis:
    ```
    https://console.aws.amazon.com/kinesis/home?region=us-east-1#/dashboard
    ```
    - obs: Explore o Kinesis data streams e o Kinesis Firehose.
    
   ![alt text](https://github.com/schmidt-samuel/fia_batalha_de_dados1/blob/master/desafio_case_ecommerce/imagens/kinesis_dashboard.png)
  
  
   ### Kinesis Analytics
- Inicie a aplicação do Kinesis Analytics:
    ```
    https://console.aws.amazon.com/kinesisanalytics/home?region=us-east-1#/
    ```
    - Selecione e abra "Application details":
    
    ![alt text](https://github.com/schmidt-samuel/fia_batalha_de_dados1/blob/master/desafio_case_ecommerce/imagens/kinesis_analytics_passo1.png)
    
    - Abra a aplicação e va para o botão "Go To SQL editor":
    
    ![alt text](https://github.com/schmidt-samuel/fia_batalha_de_dados1/blob/master/desafio_case_ecommerce/imagens/kinesis_analytics_passo2.png)
    
    - Clique para ir para o SQL editor e inicie a application, clique “Yes, start application”:
    
    ![alt text](https://github.com/schmidt-samuel/fia_batalha_de_dados1/blob/master/desafio_case_ecommerce/imagens/kinesis_analytics_passo3.png)
    
    #### Explore o código SQL no Kinesis Analytics
    - Para agregar as métricas para cada Customer ID (custid) com a função Stagger Window podemos agrupar eventos para uma unica sessão por navegação de Usuário ou Device:
    - A cada 1 minuto o código extrai o inicio e fim das navegações, em termos de navegação de URL e tempo de navegação. Também é criado um Session_ID concatenando custid + 1-3 substring do Device + Timestamp removendo milissegundos.  
    ![alt text](https://github.com/schmidt-samuel/fia_batalha_de_dados1/blob/master/desafio_case_ecommerce/imagens/kinesis_analytics_query.png)
    
    - verifique a amostra de dados no streaming:
     ![alt text](https://github.com/schmidt-samuel/fia_batalha_de_dados1/blob/master/desafio_case_ecommerce/imagens/kinesis_analytics_sample.png)
     
     ![alt text](https://github.com/schmidt-samuel/fia_batalha_de_dados1/blob/master/desafio_case_ecommerce/imagens/kinesis_analytics_sample2.png)
    
    ## Verificar o Amazon S3 na console
    ```
    https://console.aws.amazon.com/s3/home?region=us-east-1
    ```
    - Clique no nome do bucket que você criou e verifique se há duas pastas "raw" e "aggregated". Aguarde por um tempo para que os dados agregados sejam armazenados no bucket.
    
    ![alt text](https://github.com/schmidt-samuel/fia_batalha_de_dados1/blob/master/desafio_case_ecommerce/imagens/s3_bucket_raw_aggregated.png)
    
    - Navegue nas pastas e verifique os arquivos:
    
    ![alt text](https://github.com/schmidt-samuel/fia_batalha_de_dados1/blob/master/desafio_case_ecommerce/imagens/s3_bucket_raw_files.png)
    
  ## Crawler do s3 para obter a definição de tabela no Glue
    ```
    https://console.aws.amazon.com/glue/home?region=us-east-1#catalog:tab=crawlers
    ```
    - Vá até o menu do Glue e clique em Crawler, selecione sessionization_ecommerce.
    - Marque o job e clique em "Run crawler". 
    ![alt text](https://github.com/schmidt-samuel/fia_batalha_de_dados1/blob/master/desafio_case_ecommerce/imagens/glue_crawler_passo1.png)
  
    ![alt text](https://github.com/schmidt-samuel/fia_batalha_de_dados1/blob/master/desafio_case_ecommerce/imagens/glue_crawler_passo2.png)

  ## Realize query nos dados no Amazon Athena
    ```
    https://console.aws.amazon.com/athena/home?region=us-east-1#query
    ```
    - Vá até o menu do Athena e clique em Databases, selecione sessions_ecommerce.
    - Clique em Get Started, então clique (x) para sair do tutorial:
     ![alt text](https://github.com/schmidt-samuel/fia_batalha_de_dados1/blob/master/desafio_case_ecommerce/imagens/athena_tutorial.png)
     
    - Escolha o database sessions_ecommerce:
     
     ![alt text](https://github.com/schmidt-samuel/fia_batalha_de_dados1/blob/master/desafio_case_ecommerce/imagens/athena_database.png)
    
    - Verifique as tabelas raw e aggregated:
  
     ![alt text](https://github.com/schmidt-samuel/fia_batalha_de_dados1/blob/master/desafio_case_ecommerce/imagens/athena_query_raw.png)
  ## Tarefas
  
  ### Tarefas 1 - Query e schema:
  - Apresente os produtos mais procurados, salve a query e uma amostra do resultado com as primeiras 10 linhas para apresentar posteriormente.
  
  #### Tarefa 1.1 - ajuste de schema:
  - Ajuste o schema da tabela aggregated, alterando os nomes das colunas de acordo com a tabela abaixo:
  
| (Nome Atual) | (Novo Nome)   |   |
|--------------|---------------|---|
| col0         | sessionid     |   |
| col1         | userid        |   |
| col2         | device        |   |
| col3         | aggreg_time   |   |
| col4         | events        |   |
| col5         | beginurl      |   |
| col6         | endurl        |   |
| col7         | begin_min_ss  |   |
| col8         | end_min_ss    |   |
| col9         | totaltime_sec |   |
| partition_0  | year          |   |
| partition_1  | month         |   |
| partition_2  | day           |   |
| partition_3  | hour          |   |

  #### Tarefa 1.2 - Inferir Schema e criar Hive Tables:
  - As tabelas dos dados raw e aggregated data foram criadas atraves do Glue Crawlers.
  - Em vez de utilizar o Glue, apresente como seria o processo para inferir os schemas dos dois tipos de dados brutos (raw - estrutura json e aggregated - estrutura csv) disponiveis no S3, utilizando PySpark e gerando um schema de tabela no Hive Metastore (o schema pode ser salvo no Glue Catalog).
  - Na sequencia demonstre como realizar queries HiveQL ou no Athena nas duas tabelas criadas, realizando filtros simples e count de linhas. 

 ### Tarefas 2 - Armazenamento e Processamento Batch Data Lake:
  - Crie novo(s) bucket(s) S3 para armazenar outra(s) camada(s) do datalake. A(s) outra(s) camadas devem prover um armazenamento eficiente dos dados em termos de espaço e desempenho de acesso para queries exploratórias que possam ser realizadas de forma ad-hoc por diferentes equipes de usuários, analistas ou cientista de dados. 
  - Os dados brutos armazenados no bucket atual devem ser processados pelo Spark ou Hive para serem gravados na(s) outra(s) camada(s).
 
 ### Tarefas 3 - Visualização:
  - Apresentar gráficos (de barra, pizza, ou outros tipos) em uma ferramenta de Analytics/BI, analisando os acessos de navegação.
  #### Tarefa 3.1 - Gráfico de pizza por device:
   - Gerar um gráfico de acessos por diferentes devices, semelhante ao seguinte exemplo:
   
   ![alt text](https://github.com/schmidt-samuel/fia_batalha_de_dados1/blob/master/desafio_case_ecommerce/imagens/acessos_por_device.png)
   
  #### Tarefa 3.2 - Heat Map:
   - Apresentar um mapa de calor (Heat map) de acessos por Trafficfrom e Url.
  
  #### Tarefa 3.3 - Insights:
   - Apresentar até dois insights com gráficos e análises que possam ser reveladores ou muitos interessantes para os executivos, gestores ou especialistas de negócios da empresa de ecommerce.   
   
 ### Tarefas 4 - Processamento Near Real Time:
   - Ler os dados em near real time diretamente Kinesis Streams utilizando ferramentas de streaming/microbatching. 
   #### Tarefa 4.1 - Usuarios unicos com janelas de 15 segundos:
   - Processar quantos usuários unicos navegam nas URLs, apresentando resultados com janelas de 15 segundos.
   
   #### Tarefa 4.2 - Usuarios unicos com janelas de 1 minuto:
   - Processar quantos usuários unicos navegam nas URLs, apresentando resultados com janelas de 1 minuto.
   
   #### Tarefa 4.3 - Paginas de origem (trafficfrom) mais utilizadas com janelas de 1 minuto:
   - Processar quais são as páginas de origem mais utilizadas com janelas de 1 minuto.
   
 ### Tarefas 5 - Dashboard Near Real Time no Kibana:
   #### Tarefa 5.1 - Visualização de visitante unicos no Kibana:
   - Desenvolva um Dashboard no Kibana, apresentando a quantidade de visitantes unicos navegando no ecommerce ao longo do tempo.
 
 
   
  
    
  
   
    

  
  
  
  
  
  