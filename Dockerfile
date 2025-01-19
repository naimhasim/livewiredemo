FROM php:8.3-fpm-alpine3.20

RUN apk add --no-cache shadow && \
    usermod -u 1000 www-data && \
    groupmod -g 1000 www-data && \
    apk del shadow

RUN apk update \
  && apk add --no-cache \
  git \
  curl \
  libpng-dev \
  oniguruma-dev \
  libxml2-dev \
  zip \
  unzip \
  zlib-dev \
  libpq-dev \
  libzip-dev \
  && docker-php-ext-configure pgsql -with-pgsql=/usr/local/pgsql \
  && docker-php-ext-install pdo pdo_pgsql pgsql zip bcmath gd \
  && apk del gcc make g++ # Remove build dependencies

COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

EXPOSE 9000
