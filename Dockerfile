FROM php:7-apache

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get install -y --no-install-recommends \
  postgresql-server-dev-9.4 \
  libfreetype6-dev \
  libjpeg62-turbo-dev \
  libmcrypt-dev \
  libpng12-dev \
  libedit-dev \
  git \
  curl \

  && docker-php-ext-install \
    gd \
    gettext \
    mbstring \
    mcrypt \
    pdo_mysql \
    pdo_pgsql \
    pgsql \
    sockets \

  && apt-get install -y --no-install-recommends \
    libpq5 \
    libmcrypt4 \

  && apt-get autoremove -y \
  && apt-get clean \

  && rm -rf \
    /tmp/* \
    /usr/share/doc/* \
    /var/cache/* \
    /var/lib/apt/lists/* \
    /var/tmp/*

RUN a2enmod rewrite

RUN curl -sS https://getcomposer.org/installer | php \
  && mv composer.phar /usr/local/bin/composer

RUN service apache2 restart
