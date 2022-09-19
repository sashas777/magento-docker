#!/bin/bash

[ "$DEBUG" = "true" ] && set -x

source /var/www/.bashrc

# Ensure our Magento directory exists
mkdir -p $MAGENTO_ROOT
sudo chown -R www:www $MAGENTO_ROOT
sudo chown -R www:www /var/www/composer
umask 002
sudo chgrp www $MAGENTO_ROOT
sudo chmod g+s $MAGENTO_ROOT

CRON_LOG=/var/log/cron.log
sudo touch $CRON_LOG

# Substitute in php.ini values
[ ! -z "${TZ}" ] && export TZ_ESCAPED=$(echo $TZ | sed 's/\//\\\//g') && sudo sed -i "s/!TZ!/${TZ_ESCAPED}/" /usr/local/etc/php/conf.d/zz-magento.ini

[ "$PHP_ENABLE_XDEBUG" = "true" ] && \
    sudo -E docker-php-ext-enable xdebug && \
    echo "Xdebug is enabled"

# Configure composer
[ ! -z "${COMPOSER_GITHUB_TOKEN}" ] && \
    composer config --global github-oauth.github.com $COMPOSER_GITHUB_TOKEN

[ ! -z "${COMPOSER_MAGENTO_USERNAME}" ] && \
    composer config --global http-basic.repo.magento.com \
        $COMPOSER_MAGENTO_USERNAME $COMPOSER_MAGENTO_PASSWORD

exec "$@"

