FROM php:8.2-fpm

ENV TZ=America/New_York
ARG TARGETARCH
ARG PHP_SHORT_VERSION=8.2
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install dependencies
RUN apt-get update \
  && apt-get install -y \
    sudo \
    software-properties-common \
    libfreetype6-dev \
    libicu-dev \
    libjpeg62-turbo-dev \
    libmcrypt-dev \
    libpng-dev \
    libzip-dev \
    libxslt1-dev \
    curl \
    nano \
    ca-certificates \
    libmagickwand-dev \
    librabbitmq-dev \
    msmtp \
    libonig-dev --no-install-recommends \
    && rm -rf /var/lib/apt/lists/*

# Configure the gd library
RUN docker-php-ext-configure gd --with-freetype --with-jpeg

## Install required PHP extensions
RUN docker-php-ext-install dom gd intl mbstring pdo_mysql xsl zip soap bcmath pcntl sockets mysqli
RUN pecl install -o -f amqp xdebug imagick
RUN docker-php-ext-enable imagick amqp

#SourceGuardian
RUN if [ ${TARGETARCH}= "x86_64" ]; then file="loaders.linux-x86_64.tar.gz"; ext=".lin"; fi \
    && if [ ${TARGETARCH} = "amd64" ]; then file="loaders.linux-x86_64.tar.gz"; ext=".lin"; fi \
    && if [ ${TARGETARCH} = "arm" ]; then file="loaders.linux-armhf.tar.gz"; ext=".lin"; fi \
    && if [ ${TARGETARCH} = "aarch64" ]; then file="loaders.linux-aarch64.tar.gz"; ext=".lin"; fi \
    && if [ ${TARGETARCH} = "arm64" ]; then file="loaders.macosx-arm64.tar.gz"; ext=".dar"; fi \
    && mkdir -p /tmp/sourceguardian && cd /tmp/sourceguardian \
    && curl -Os https://www.sourceguardian.com/loaders/download/${file} && tar xzf ${file} \
    && cp ixed.${PHP_SHORT_VERSION}${ext} "$(php -i | grep '^extension_dir =' | cut -d' ' -f3)/sourceguardian.so" \
    && echo "extension=sourceguardian.so" > /usr/local/etc/php/conf.d/zz-sourceguardian.ini \
    && rm -rf /tmp/sourceguardian

#ionCube
RUN if [ ${TARGETARCH} = "x86_64" ]; then file="ioncube_loaders_lin_x86-64.tar.gz"; ext="lin"; fi \
    && if [ ${TARGETARCH} = "amd64" ]; then file="ioncube_loaders_lin_x86-64.tar.gz"; ext="lin"; fi \
    && if [ ${TARGETARCH} = "aarch64" ]; then file="ioncube_loaders_lin_aarch64.tar.gz"; ext="lin"; fi \
    && if [ ${TARGETARCH} = "arm" ]; then file="ioncube_loaders_lin_armv7l.tar.gz"; ext="lin"; fi \
    && if [ ${TARGETARCH} = "arm64" ]; then file="ioncube_loaders_dar_arm64.tar.gz"; ext="dar"; fi \
    && mkdir -p /tmp/ioncube && cd /tmp/ioncube \
    && curl -Os https://downloads.ioncube.com/loader_downloads/${file} && tar xzf ${file} \
    && cp ioncube/ioncube_loader_${ext}_${PHP_SHORT_VERSION}.so "$(php -i | grep '^extension_dir =' | cut -d' ' -f3)/ioncube.so" \
    && echo "zend_extension=ioncube.so" > /usr/local/etc/php/conf.d/zz-ioncube.ini \
    && rm -rf /tmp/ioncube

RUN mkdir /var/www/composer && chmod 777 -R  /var/www/composer

ENV PHP_MEMORY_LIMIT 4G
ENV PHP_ENABLE_XDEBUG false
ENV MAGENTO_ROOT /var/www/magento
ENV DEBUG false
ENV UPLOAD_MAX_FILESIZE 64M
ENV PHP_IDE_CONFIG serverName=magento

COPY php/shared/etc/php-xdebug.ini /usr/local/etc/php/conf.d/zz-xdebug-settings.ini
COPY php/shared/etc/mail.ini /usr/local/etc/php/conf.d/zz-mail.ini
COPY php/shared/fpm-docker-entrypoint.sh /docker-entrypoint.sh
COPY php/shared/etc/php-fpm.ini /usr/local/etc/php/conf.d/zz-magento.ini
COPY php/shared/etc/php-fpm.conf /usr/local/etc/
COPY php/shared/magento-vars.php /var/www/magento-vars.php
COPY php/shared/op-exclude.txt /var/www/op-exclude.txt

RUN groupadd -g 1000 www && useradd -g 1000 -u 1000 -d /var/www/ -s /bin/bash www
RUN echo '%www ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers && usermod -a -G www-data www && usermod -a -G www www-data && umask 002
RUN chown www:www -R /var/www

RUN ["chmod", "+x", "/docker-entrypoint.sh"]

ENTRYPOINT ["/docker-entrypoint.sh"]

WORKDIR ${MAGENTO_ROOT}

CMD ["php-fpm", "-R"]

# HEALTHCHECK
#https://github.com/php/php-src/issues/10314