#!/bin/bash

[ "$DEBUG" = "true" ] && set -x

# Ensure our Magento directory exists
mkdir -p $MAGENTO_ROOT
chown -R www:www $MAGENTO_ROOT
umask 002
sudo chgrp www $MAGENTO_ROOT
sudo chmod g+s $MAGENTO_ROOT
sudo chown -R www:www /var/www/composer

# Substitute in php.ini values
[ ! -z "${PHP_MEMORY_LIMIT}" ] && sudo sed -i "s/!PHP_MEMORY_LIMIT!/${PHP_MEMORY_LIMIT}/" /usr/local/etc/php/conf.d/zz-magento.ini
[ ! -z "${UPLOAD_MAX_FILESIZE}" ] && sudo sed -i "s/!UPLOAD_MAX_FILESIZE!/${UPLOAD_MAX_FILESIZE}/" /usr/local/etc/php/conf.d/zz-magento.ini
[ ! -z "${TZ}" ] && export TZ_ESCAPED=$(echo $TZ | sed 's/\//\\\//g') && sudo sed -i "s/!TZ!/${TZ_ESCAPED}/" /usr/local/etc/php/conf.d/zz-magento.ini

[ "$PHP_ENABLE_XDEBUG" = "true" ] && \
    sudo -E docker-php-ext-enable xdebug && \
    echo "Xdebug is enabled"

# Set host.docker.internal if not available
HOST_NAME="host.docker.internal"
HOST_IP=$(php -r "putenv('RES_OPTIONS=retrans:1 retry:1 timeout:1 attempts:1'); echo gethostbyname('$HOST_NAME');")
if [[ "$HOST_IP" == "$HOST_NAME" ]]; then
  HOST_IP=$(/sbin/ip route|awk '/default/ { print $3 }')
  printf "\n%s %s\n" "$HOST_IP" "$HOST_NAME" >> /etc/hosts
fi

exec "$@"

