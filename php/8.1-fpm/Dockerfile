FROM golang:latest AS builder

RUN if [ $(uname -m) = "x86_64" ]; then mailhog_arch="amd64"; else mailhog_arch="arm64"; fi \
    && wget -O mhsendmail.tar.gz https://github.com/mailhog/mhsendmail/archive/refs/tags/v0.2.0.tar.gz \
    && tar -xf mhsendmail.tar.gz \
    && mkdir -p ./src/github.com/mailhog/ \
    && mv ./mhsendmail-0.2.0 ./src/github.com/mailhog/mhsendmail \
    && cd ./src/github.com/mailhog/mhsendmail/ \
    && go env -w GO111MODULE=auto \
    && go get . \
    && GOOS=linux GOARCH=${mailhog_arch} go build -o mhsendmail .

FROM php:8.1-fpm

ENV TZ=America/New_York
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt-get update && apt-get install -y sudo software-properties-common

# Install dependencies
RUN apt-get update \
  && apt-get install -y \
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
    libonig-dev --no-install-recommends

# Configure the gd library
RUN docker-php-ext-configure gd --with-freetype --with-jpeg

# Install required PHP extensions
RUN docker-php-ext-install dom gd intl mbstring pdo_mysql xsl zip soap bcmath pcntl sockets mysqli

RUN pecl install -o -f xdebug imagick

RUN docker-php-ext-enable imagick

RUN rm -f /usr/local/etc/php/conf.d/*sodium.ini \
  && rm -f /usr/local/lib/php/extensions/*/*sodium.so \
  && apt-get remove libsodium* -y \
  && mkdir -p /tmp/libsodium \
  && curl -sL https://github.com/jedisct1/libsodium/archive/1.0.18-RELEASE.tar.gz | tar xzf - -C  /tmp/libsodium \
  && cd /tmp/libsodium/libsodium-1.0.18-RELEASE/ \
  && ./configure \
  && make && make check \
  && make install \
  && cd / \
  && rm -rf /tmp/libsodium \
  && pecl install -o -f libsodium \
  && echo "extension=sodium.so" > /usr/local/etc/php/conf.d/zz-sodium.ini

#SourceGuardian
RUN PHP_VERSION=$(php -v | head -n1 | cut -d' ' -f2 | cut -d. -f1-2) \
    && if [ $(uname -m) = "x86_64" ]; then sg_arch_file="loaders.linux-x86_64.tar.gz"; else sg_arch_file="loaders.macosx-arm64.tar.gz"; fi \
    && if [ $(uname -m) = "x86_64" ]; then sg_module_ext="lin"; else sg_module_ext="dar"; fi \
    && mkdir -p /tmp/sourceguardian \
    && cd /tmp/sourceguardian \
    && curl -Os https://www.sourceguardian.com/loaders/download/${sg_arch_file} \
    && tar xzf ${sg_arch_file} \
    && cp ixed.${PHP_VERSION}.${sg_module_ext} "$(php -i | grep '^extension_dir =' | cut -d' ' -f3)/sourceguardian.so" \
    && echo "extension=sourceguardian.so" > /usr/local/etc/php/conf.d/zz-sourceguardian.ini \
    && rm -rf /tmp/sourceguardian

# Install MailHog
COPY --from=builder /go/src/github.com/mailhog/mhsendmail/mhsendmail /usr/bin/mhsendmail
RUN sudo chmod +x /usr/bin/mhsendmail

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

RUN groupadd -g 1000 www && useradd -g 1000 -u 1000 -d ${MAGENTO_ROOT} -s /bin/bash www
RUN echo '%www ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers && usermod -a -G www-data www && usermod -a -G www www-data && umask 002
RUN chown www:www -R /var/www

RUN ["chmod", "+x", "/docker-entrypoint.sh"]

ENTRYPOINT ["/docker-entrypoint.sh"]

WORKDIR ${MAGENTO_ROOT}

CMD ["php-fpm", "-R"]
