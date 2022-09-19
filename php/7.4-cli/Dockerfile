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

FROM php:7.4-cli

ENV TZ=America/New_York
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt-get update && apt-get install -y sudo software-properties-common gpg

RUN touch /var/www/.bashrc

# Install dependencies
RUN apt-get update \
  && apt-get install -y \
    libfreetype6-dev \ 
    libicu-dev \ 
    libjpeg62-turbo-dev \ 
    libmcrypt-dev \ 
    libpng-dev \
    libxslt1-dev \
    libzip-dev \
    cron \
    mariadb-client \
    git \
    redis-tools \
    nano \
    curl \
    jq \
    ca-certificates \
    libonig-dev \
    libmagickwand-dev \
    nodejs \
    ssh \
    unzip --no-install-recommends

# Configure the gd library
RUN docker-php-ext-configure gd --with-freetype --with-jpeg

# Install required PHP extensions
RUN docker-php-ext-install dom gd intl mbstring pdo_mysql xsl zip soap bcmath pcntl sockets mysqli

RUN pecl install -o -f xdebug imagick

RUN docker-php-ext-enable imagick

RUN curl -L https://packages.blackfire.io/gpg.key | gpg --dearmor > blackfire.io-archive-keyring.gpg \
  && install -o root -g root -m 644 blackfire.io-archive-keyring.gpg /etc/apt/trusted.gpg.d/ \
  && echo "deb http://packages.blackfire.io/debian any main" | tee /etc/apt/sources.list.d/blackfire.list \
  && apt-get update \
  && apt-get install blackfire-php

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

ENV PHP_ENABLE_XDEBUG false
ENV MAGENTO_ROOT /var/www/magento
ENV DEBUG false
ENV COMPOSER_ALLOW_SUPERUSER 1
ENV PHP_IDE_CONFIG serverName=magento
ENV COMPOSER_HOME /var/www/composer
ENV UPLOAD_MAX_FILESIZE 64M
ENV NODE_VERSION --lts;

ADD php/shared/etc/php-xdebug.ini /usr/local/etc/php/conf.d/zz-xdebug-settings.ini
ADD php/shared/etc/mail.ini /usr/local/etc/php/conf.d/zz-mail.ini
ADD php/shared/cli-docker-entrypoint.sh /docker-entrypoint.sh
ADD php/shared/etc/php-cli.ini /usr/local/etc/php/conf.d/zz-magento.ini
ADD php/shared/bin/* /usr/local/bin/

VOLUME /var/www/composer/.composer/cache

# Get composer installed to /usr/local/bin/composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer --2

#NVM
RUN mkdir -p /var/www/.nvm  && export NVM_DIR="/var/www/.nvm" \
    && curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | PROFILE=/var/www/.bashrc bash \
    && [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" \
    && nvm install --lts

RUN groupadd -g 1000 www && useradd -g 1000 -u 1000 -d ${MAGENTO_ROOT} -s /bin/bash www
RUN echo '%www ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers && usermod -a -G www-data www && usermod -a -G www www-data && umask 002
RUN chown www:www -R /var/www

RUN ["chmod", "+x", "/docker-entrypoint.sh"]
RUN ["chmod", "+x", "/usr/local/bin/run-cron"]

ENTRYPOINT ["/docker-entrypoint.sh"]

WORKDIR ${MAGENTO_ROOT}

CMD ["bash"]
