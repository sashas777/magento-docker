FROM php:8.5-fpm

ENV TZ=America/New_York
ARG TARGETARCH
ARG PHP_SHORT_VERSION=8.5
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install dependencies (only runtime tools, no compilation headers needed)
RUN apt-get update \
  && apt-get install -y \
    sudo \
    curl \
    nano \
    ca-certificates \
    msmtp --no-install-recommends \
  && rm -rf /var/lib/apt/lists/*

# Add the PHP extension installer script
ADD --chmod=0755 https://github.com/mlocati/docker-php-extension-installer/releases/latest/download/install-php-extensions /usr/local/bin/

# Install and configure all required PHP extensions (and automatically clean up build tools)
RUN install-php-extensions gd intl pdo_mysql xsl zip soap bcmath pcntl sockets mysqli ftp amqp xdebug imagick

#SourceGuardian
RUN if [ ${TARGETARCH} = "x86_64" ]; then file="loaders.linux-x86_64.tar.gz"; ext=".lin"; fi \
    && if [ ${TARGETARCH} = "amd64" ]; then file="loaders.linux-x86_64.tar.gz"; ext=".lin"; fi \
    && if [ ${TARGETARCH} = "aarch64" ]; then file="loaders.linux-aarch64.tar.gz"; ext=".lin"; fi \
    && if [ ${TARGETARCH} = "arm" ]; then file="loaders.linux-armhf.tar.gz"; ext=".lin"; fi \
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
    && if [ ${TARGETARCH} = "arm64" ]; then file="ioncube_loaders_lin_aarch64.tar.gz"; ext="lin"; fi \
    && mkdir -p /tmp/ioncube && cd /tmp/ioncube \
    && curl -Os https://downloads.ioncube.com/loader_downloads/${file} && tar xzf ${file} \
    && cp ioncube/ioncube_loader_${ext}_${PHP_SHORT_VERSION}.so "$(php -i | grep '^extension_dir =' | cut -d' ' -f3)/ioncube.so" \
    && echo "zend_extension=ioncube.so" > /usr/local/etc/php/conf.d/0zz-ioncube.ini \
    && rm -rf /tmp/ioncube

RUN mkdir /var/www/composer && chmod 777 -R  /var/www/composer

ENV PHP_MEMORY_LIMIT=4G
ENV PHP_ENABLE_XDEBUG=false
ENV MAGENTO_ROOT=/var/www/magento
ENV DEBUG=false
ENV UPLOAD_MAX_FILESIZE=64M
ENV PHP_IDE_CONFIG="serverName=magento"

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

COPY php/shared/fpm-docker-healthcheck.sh /docker-healthcheck.sh
RUN ["chmod", "+x", "/docker-entrypoint.sh"]
RUN ["chmod", "+x", "/docker-healthcheck.sh"]

ENTRYPOINT ["/docker-entrypoint.sh"]

WORKDIR ${MAGENTO_ROOT}

CMD ["php-fpm", "-R"]

# HEALTHCHECK
HEALTHCHECK --interval=10s --timeout=3s --retries=3 CMD ["/docker-healthcheck.sh"]