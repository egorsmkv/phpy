# FROM php:8.2.13-cli-bullseye
FROM php:8.3.20-cli-bullseye

LABEL authors="Heelie"

RUN apt update && apt upgrade -y && apt install -y gpg python3-dev python3-venv python3-pip

WORKDIR /opt
COPY . /opt/phpy

# Compile and install
RUN cd /opt/phpy && docker-php-source extract && \
    phpize && \
    ./configure --with-python-config=/usr/bin/python3-config && \
    make && make install && \
    docker-php-ext-enable phpy && \
    docker-php-source delete

CMD ["bash"]

