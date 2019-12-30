FROM ubuntu:18.04

LABEL mantainer="Allan Batista <allan@allanbatista.com.br>"

EXPOSE 9092

# no interaction
ENV DEBIAN_FRONTEND noninteractive
ENV TERM linux

# language
ENV LANGUAGE en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LC_ALL en_US.UTF-8
ENV LC_CTYPE en_US.UTF-8
ENV LC_MESSAGES en_US.UTF-8

ENV KAFKA_HOME=/kafka
ENV KAFKA_LOG_DIR=/kafka/log

# Install Deps
RUN apt-get update \
    && apt-get install openjdk-8-jdk locales wget python3 python3-pip -y \
    && sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && locale-gen \
    && apt-get clean

# Download And install Kafka
RUN cd /tmp \
    && wget http://ftp.unicamp.br/pub/apache/kafka/2.3.0/kafka_2.11-2.3.0.tgz \
    && tar xzfv kafka_2.11-2.3.0.tgz -C / \
    && mv /kafka_2.11-2.3.0 /kafka \
    && rm kafka_2.11-2.3.0.tgz

# Setup Workdir
WORKDIR /kafka

COPY entrypoint.sh /
COPY parse_envs.py /
RUN chmod +x /entrypoint.sh

ENTRYPOINT [ "/entrypoint.sh", "server" ]