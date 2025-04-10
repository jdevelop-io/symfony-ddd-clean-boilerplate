ARG PHP_VERSION=8.4
ARG COMPOSER_VERSION=2.5

FROM composer:${COMPOSER_VERSION} AS composer

FROM php:${PHP_VERSION}-alpine AS development

EXPOSE 80

ENV WORKDIR=/var/www/html

WORKDIR $WORKDIR

# Install composer
COPY --from=composer /usr/bin/composer /usr/bin/composer

# Install dependencies
RUN apk add --no-cache \
    bash \
    git \
    libzip-dev \
    unzip \
    zip && \
    docker-php-ext-install zip

COPY ./deploy/local/docker/web/symfony/entrypoint.sh /usr/local/bin/entrypoint.sh

ENTRYPOINT ["entrypoint.sh"]
CMD ["php", "-S", "0.0.0.0:80", "-t", "/var/www/html/public"]
