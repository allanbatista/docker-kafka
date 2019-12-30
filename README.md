## Kafka On Docker

Este projeto tem como objetivo fazer parte do projeto de conclusão de curso do Instituto Infnet na pós graduação de BIG DATA MIT do ano de 2019.

### Utilização da Imagem Docker

Esta imagem esta configurada para aceitar variáveis de ambiente direto de configuração de envvar o que torna fácil o deploy de uma nova instancia.

```
$ docker run --rm \
  -e kafka.num.partitions=3 \
  -e kafka.zookeeper.connect=IP:PORT \
  allanbatista/kafka:latest kafka-server
```

### Como inicializar o Cluster

A configuração do comando da criação do cluster foi feito em docker-compose para facilitar o desenvolvimento.

```
$ git clone https://github.com/allanbatista/docker-kafka
$ cd docker-kafka
$ docker-compose up
```

Esse cluster será iniciado em alta disponibilidade com 3 nós zookeeper e 4 nós Kafkas.

O kafka está com as seguintes configurações padrões:
* 3 partições
* 3 replicas de cada partição
* o reserved.broker.max.id esta definido como 2^32 por padrão
* o broaker.id é gerado randomicamente se não for definido.