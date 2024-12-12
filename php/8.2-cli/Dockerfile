FROM php:8.2-cli

ENV TZ=America/New_York
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN touch /var/www/.bashrc

# Install dependencies
RUN apt-get update \
  && apt-get install -y \
    software-properties-common \
    sudo \
    gpg \
    wget \
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
    openconnect \
    msmtp \
    librabbitmq-dev \
    unzip --no-install-recommends \
    && rm -rf /var/lib/apt/lists/*

# Configure the gd library
RUN docker-php-ext-configure gd --with-freetype --with-jpeg

## Install required PHP extensions
RUN docker-php-ext-install dom gd intl mbstring pdo_mysql xsl zip soap bcmath pcntl sockets mysqli
RUN pecl install -o -f amqp xdebug imagick
RUN docker-php-ext-enable imagick amqp

# Blackfire
RUN curl -L https://packages.blackfire.io/gpg.key | gpg --dearmor > blackfire.io-archive-keyring.gpg \
  && install -o root -g root -m 644 blackfire.io-archive-keyring.gpg /etc/apt/trusted.gpg.d/ \
  && echo "deb http://packages.blackfire.io/debian any main" | tee /etc/apt/sources.list.d/blackfire.list \
  && apt-get update \
  && apt-get install blackfire-php \
  && rm -rf /var/lib/apt/lists/*

#SourceGuardian
RUN PHP_VERSION=$(php -v | head -n1 | cut -d' ' -f2 | cut -d. -f1-2) \
    && if [ $(uname -m) = "x86_64" ]; then sg_arch_file="loaders.linux-x86_64.tar.gz"; else sg_arch_file="loaders.linux-aarch64.tar.gz"; fi \
    && if [ $(uname -m) = "x86_64" ]; then sg_module_ext="lin"; else sg_module_ext="lin"; fi \
    && mkdir -p /tmp/sourceguardian \
    && cd /tmp/sourceguardian \
    && curl -Os https://www.sourceguardian.com/loaders/download/${sg_arch_file} \
    && tar xzf ${sg_arch_file} \
    && cp ixed.${PHP_VERSION}.${sg_module_ext} "$(php -i | grep '^extension_dir =' | cut -d' ' -f3)/sourceguardian.so" \
    && echo "extension=sourceguardian.so" > /usr/local/etc/php/conf.d/zz-sourceguardian.ini \
    && rm -rf /tmp/sourceguardian

#NVM
RUN mkdir -p /var/www/.nvm  && export NVM_DIR="/var/www/.nvm" \
    && wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | PROFILE=/var/www/.bashrc bash \
    && [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" \
    && nvm install 20 && nvm use 20

RUN mkdir /var/www/composer && chmod 777 -R  /var/www/composer

ENV PHP_ENABLE_XDEBUG false
ENV MAGENTO_ROOT /var/www/magento
ENV DEBUG false
ENV COMPOSER_ALLOW_SUPERUSER 1
ENV PHP_IDE_CONFIG serverName=magento
ENV COMPOSER_HOME /var/www/composer
ENV UPLOAD_MAX_FILESIZE 64M
ENV NVM_DIR /var/www/.nvm;

ADD php/shared/etc/php-xdebug.ini /usr/local/etc/php/conf.d/zz-xdebug-settings.ini
ADD php/shared/etc/mail.ini /usr/local/etc/php/conf.d/zz-mail.ini
ADD php/shared/cli-docker-entrypoint.sh /docker-entrypoint.sh
ADD php/shared/etc/php-cli.ini /usr/local/etc/php/conf.d/zz-magento.ini
ADD php/shared/bin/* /usr/local/bin/

VOLUME /var/www/composer/.composer/cache

# Get composer installed to /usr/local/bin/composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer --2

RUN groupadd -g 1000 www && useradd -g 1000 -u 1000 -d ${MAGENTO_ROOT} -s /bin/bash www
RUN echo '%www ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers && usermod -a -G www-data www && usermod -a -G www www-data && umask 002
RUN chown www:www -R /var/www

RUN ["chmod", "+x", "/docker-entrypoint.sh"]
RUN ["chmod", "+x", "/usr/local/bin/run-cron"]

ENTRYPOINT ["/docker-entrypoint.sh"]

WORKDIR ${MAGENTO_ROOT}

CMD ["bash"]
