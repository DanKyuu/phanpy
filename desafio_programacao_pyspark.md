# Desafio Programação PySpark

## Descrição da Tarefa:
   - Dado um dataframe com duas colunas [id_cliente, categorias]. 
   - Fazer um dataframe resultado, com uma coluna pra cada tipo de categoria, com valor 1 caso aquela categoria exista e 0 caso não exista, isso para cada cliente (one-hot-encoded).

- Regras:
    - Usar pyspark.
    - Pode usar qualquer biblioteca auxiliar.
    - O número de categorias é dinamico e não conhecido de antemão.
    - O script tem que funcionar para os dois dataframes exemplos.
    - Os seus dataframes resposta têm que ser exatamente iguais aos apresentados abaixo.
    - O script deve executar com o menor tempo possível, este tempo de execução será comparado entre os grupos participantes. 
    - Os tempos de execução devem ser medidos e apresentados utilizando o time library do python.

- Bibliotecas necessárias:
```python
from pyspark.sql.types import *
from pyspark.sql.functions import *
import time
```

- Dataframe de exemplo 1:
```python
df = spark.createDataFrame([
    ('id_cliente-1',  'cat-1, cat-2, cat-3'),
    ('id_cliente-2',  'cat-1, cat-4, cat-5'),
    ('id_cliente-3',  'cat-6, cat-7'),
    ('id_cliente-4',  'cat-1, cat-2, cat-7, cat-10'),
    ('id_cliente-5',  'cat-8, cat-10'),
    ('id_cliente-6',  'cat-1, cat-9, cat-10'),
    ('id_cliente-7',  'cat-1, cat-4, cat-5, cat-10'),
    ('id_cliente-8',  'cat-7, cat-9'),
    ('id_cliente-9',  'cat-1'),
    ('id_cliente-10', 'cat-1, cat-2, cat-3, cat-4, cat-5, cat-6, cat-7, cat-8, cat-10')
], ['id_cliente', 'categorias'])
```

- Dataframe de exemplo 2:
```python
df2 = spark.createDataFrame([
    ('id_cliente-1',  'cat-1, cat-2, cat-3, cat-15'),
    ('id_cliente-2',  'cat-1, cat-4, cat-5, cat-11, cat-14'),
    ('id_cliente-3',  'cat-4, cat-14, cat-15'),
    ('id_cliente-4',  'cat-1, cat-2, cat-7, cat-10'),
    ('id_cliente-5',  'cat-8, cat-10, cat-11'),
    ('id_cliente-6',  'cat-1, cat-9, cat-10, cat-11, cat-13'),
    ('id_cliente-7',  'cat-1, cat-4, cat-5, cat-10'),
    ('id_cliente-8',  'cat-7, cat-9, cat-12, cat-13, cat-14'),
    ('id_cliente-9',  'cat-2'),
    ('id_cliente-10', 'cat-1, cat-2, cat-3, cat-4, cat-5, cat-6, cat-7, cat-8, cat-10')
], ['client-id', 'categorias'])
```

- Calcular tempo:
```python
start = time.time()
# Seu script
print(time.time() - start)
```

- Dataframe de saída 1 (df1):

![alt text](https://github.com/schmidt-samuel/fia_batalha_de_dados1/blob/master/desafio_programacao/imagens/dataframe_saida1.png)

- Dataframe de saída 2 (df2):

![alt text](https://github.com/schmidt-samuel/fia_batalha_de_dados1/blob/master/desafio_programacao/imagens/dataframe_saida2.png)

