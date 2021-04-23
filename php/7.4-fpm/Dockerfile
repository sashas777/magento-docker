FROM php:7.4-fpm

ENV TZ=America/New_York
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt-get update && apt-get install -y sudo software-properties-common
RUN curl -sL https://deb.nodesource.com/setup_15.x | sudo -E bash -
RUN sudo add-apt-repository ppa:longsleep/golang-backports -y
RUN sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys F6BC817356A3D45E

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
    git \
    nano \
    ca-certificates \
    libmagickwand-dev \
    golang-go \
    nodejs \
    libonig-dev --no-install-recommends

# Configure the gd library
RUN docker-php-ext-configure gd --with-freetype --with-jpeg

# Install required PHP extensions

RUN docker-php-ext-install dom gd intl mbstring pdo_mysql xsl zip soap bcmath pcntl sockets

RUN pecl install -o -f xdebug imagick

RUN docker-php-ext-enable imagick

RUN go get github.com/mailhog/mhsendmail
RUN cp /root/go/bin/mhsendmail /usr/bin/mhsendmail

ENV PHP_MEMORY_LIMIT 4G
ENV PHP_ENABLE_XDEBUG false
ENV MAGENTO_ROOT /var/www/magento
ENV DEBUG false
ENV MAGENTO_RUN_MODE developer
ENV UPLOAD_MAX_FILESIZE 64M
ENV PHP_IDE_CONFIG serverName=magento

COPY etc/php-xdebug.ini /usr/local/etc/php/conf.d/zz-xdebug-settings.ini
COPY etc/mail.ini /usr/local/etc/php/conf.d/zz-mail.ini
COPY docker-entrypoint.sh /docker-entrypoint.sh

RUN groupadd -g 1000 www && useradd -g 1000 -u 1000 -d ${MAGENTO_ROOT} -s /bin/bash www
RUN echo '%www ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers && usermod -a -G www-data www && usermod -a -G www www-data && umask 002

COPY etc/php-fpm.ini /usr/local/etc/php/conf.d/zz-magento.ini
COPY etc/php-fpm.conf /usr/local/etc/

RUN ["chmod", "+x", "/docker-entrypoint.sh"]

ENTRYPOINT ["/docker-entrypoint.sh"]

WORKDIR ${MAGENTO_ROOT}

CMD ["php-fpm", "-R"]
