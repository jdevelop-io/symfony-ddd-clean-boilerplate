ARG PHP_VERSION=8.4
ARG COMPOSER_VERSION=2.5

FROM composer:${COMPOSER_VERSION} AS composer

FROM php:${PHP_VERSION}-cli AS base

ENV WORKDIR=/var/www/html

# Turn off Xdebug by default, override this if you want to enable Xdebug
ENV XDEBUG_MODE=off

WORKDIR $WORKDIR

# Install composer
COPY --from=composer /usr/bin/composer /usr/bin/composer

# Set the PHP configuration
COPY ./deploy/local/docker/tools/php.ini /usr/local/etc/php/conf.d/php.ini

# Install dependencies
RUN apt-get update -y && \
    apt-get install -y --no-install-recommends \
    git \
    libzip-dev \
    unzip && \
    pecl install xdebug && \
    rm -rf /var/lib/apt/lists/* && \
    && docker-php-ext-install zip xdebug

COPY ./deploy/local/docker/web/symfony/entrypoint.sh /usr/local/bin/entrypoint.sh

ENTRYPOINT ["entrypoint.sh"]

FROM base AS phpcs

ENTRYPOINT ["entrypoint.sh", "php", "vendor/bin/phpcs"]
