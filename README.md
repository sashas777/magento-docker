# Magento Docker

[![Docker Build Status][ico-dockerbuild]][link-dockerhub]
[![Docker Pulls][ico-downloads]][link-dockerhub]
[![Docker Stars][ico-dockerstars]][link-dockerhub]

[![Docker Build Status][ico-dockerbuild2]][link-dockerhub2]
[![Docker Build Status][ico-dockerbuild3]][link-dockerhub3]

A collection of build configurations to emulate Magento environment locally.

## Docker Hub

https://hub.docker.com/r/sashas777/

## Credits

Inspired by [meanbee/docker-magento2](https://github.com/meanbee/docker-magento2)

# Usage

## To stop containers and restore them afterwards:

```bash
bin/stop
```

## Start containers from suspended state.

```bash
bin/start
```

## To update images

```bash
docker-compose pull
```

# Installation

## Build files to containers and run in the background.

```bash
bin/install
bin/up
```
#Uninstall

## To stop and remove all data

```bash
bin/down
```

## Executing commands


### Connecting to CLI container

```bash
docker-compose run cli bash
```

### Running Magento command

```bash
docker-compose run cli magento-command
```

[ico-dockerbuild]: https://img.shields.io/docker/build/sashas777/magento-php.svg?style=flat-square
[ico-dockerbuild2]: https://img.shields.io/docker/build/sashas777/magento-elasticsearch.svg?style=flat-square
[ico-dockerbuild3]: https://img.shields.io/docker/build/sashas777/magento-nginx.svg?style=flat-square
[ico-downloads]: https://img.shields.io/docker/pulls/sashas777/magento-php.svg?style=flat-square
[ico-dockerstars]: https://img.shields.io/docker/stars/sashas777/magento-php.svg?style=flat-square

[link-dockerhub]: https://hub.docker.com/r/sashas777/magento-php
[link-dockerhub2]: https://hub.docker.com/r/sashas777/magento-elasticsearch
[link-dockerhub3]: https://hub.docker.com/r/sashas777/magento-nginx

## Quick reference

### ImportDB Dump
To import a database dump, place the SQL file into the dev/docker-entrypoint-initdb.d folder.

### Cron Logs
```bash
docker-compose run cli bash -c "cat /var/www/magento/var/log/magento.cron.log"
```
