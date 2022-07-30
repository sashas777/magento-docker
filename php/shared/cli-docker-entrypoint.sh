#!/bin/bash

[ "$DEBUG" = "true" ] && set -x

# If asked, we'll ensure that the www is set to the same uid/gid as the
# mounted volume.  This works around permission issues with virtualbox shared
# folders.
if [[ "$UPDATE_UID_GID" = "true" ]]; then
    echo "Updating www uid and gid"

    DOCKER_UID=`stat -c "%u" $MAGENTO_ROOT`
    DOCKER_GID=`stat -c "%g" $MAGENTO_ROOT`

    INCUMBENT_USER=`getent passwd $DOCKER_UID | cut -d: -f1`
    INCUMBENT_GROUP=`getent group $DOCKER_GID | cut -d: -f1`

    echo "Docker: uid = $DOCKER_UID, gid = $DOCKER_GID"
    echo "Incumbent: user = $INCUMBENT_USER, group = $INCUMBENT_GROUP"

    # Once we've established the ids and incumbent ids then we need to free them
    # up (if necessary) and then make the change to www.

    [ ! -z "${INCUMBENT_USER}" ] && sudo usermod -u 99$DOCKER_UID $INCUMBENT_USER
    sudo usermod -u $DOCKER_UID www

    [ ! -z "${INCUMBENT_GROUP}" ] && sudo groupmod -g 99$DOCKER_GID $INCUMBENT_GROUP
    sudo groupmod -g $DOCKER_GID www
fi

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
[ ! -z "${PHP_MEMORY_LIMIT}" ] && sudo sed -i "s/!PHP_MEMORY_LIMIT!/${PHP_MEMORY_LIMIT}/" /usr/local/etc/php/conf.d/zz-magento.ini
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

