FROM php:7.3-cli

ENV TZ=America/New_York
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt-get update && apt-get install -y sudo
RUN curl -sL https://deb.nodesource.com/setup_15.x | sudo -E bash -

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
    rsyslog \ 
    mariadb-client \
    git \
    redis-tools \
    nano \
    curl \
    git \
    jq \
    ca-certificates \
    libmagickwand-dev \
    nodejs \
    unzip

# Configure the gd library
RUN docker-php-ext-configure \
  gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/

# Install required PHP extensions
RUN docker-php-ext-install dom gd intl mbstring pdo_mysql xsl zip bcmath soap sockets opcache

RUN pecl install -o -f xdebug imagick

RUN docker-php-ext-enable imagick
	
RUN curl -Lsf 'https://storage.googleapis.com/golang/go1.12.linux-amd64.tar.gz' | tar -C '/usr/local' -xvzf -
ENV PATH /usr/local/go/bin:$PATH
RUN go get github.com/mailhog/mhsendmail
RUN cp /root/go/bin/mhsendmail /usr/bin/mhsendmail

ENV PHP_MEMORY_LIMIT 4G
ENV PHP_ENABLE_XDEBUG false
ENV MAGENTO_ROOT /var/www/magento
ENV DEBUG false
ENV COMPOSER_ALLOW_SUPERUSER 1

ADD etc/php-xdebug.ini /usr/local/etc/php/conf.d/zz-xdebug-settings.ini
ADD etc/mail.ini /usr/local/etc/php/conf.d/zz-mail.ini
ADD docker-entrypoint.sh /docker-entrypoint.sh
ADD etc/php-cli.ini /usr/local/etc/php/conf.d/zz-magento.ini

VOLUME /root/.composer/cache

# Get composer installed to /usr/local/bin/composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer  --1
RUN composer global require hirak/prestissimo

RUN groupadd -g 1000 www && useradd -g 1000 -u 1000 -d ${MAGENTO_ROOT} -s /bin/bash www
RUN echo '%www ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers && usermod -a -G www-data www && usermod -a -G www www-data && umask 002

ADD bin/* /usr/local/bin/

RUN ["chmod", "+x", "/usr/local/bin/magento-installer"]
RUN ["chmod", "+x", "/usr/local/bin/magento-command"]
RUN ["chmod", "+x", "/usr/local/bin/magento-build"]
RUN ["chmod", "+x", "/usr/local/bin/magento-deploy"]
RUN ["chmod", "+x", "/usr/local/bin/run-cron"]
RUN ["chmod", "+x", "/docker-entrypoint.sh"]

ENTRYPOINT ["/docker-entrypoint.sh"]

WORKDIR ${MAGENTO_ROOT}

CMD ["bash"]
