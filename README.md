# Magento Docker

[![Docker Build Status][ico-dockerbuild]][link-dockerhub]
[![Docker Pulls][ico-downloads]][link-dockerhub]
[![Docker Stars][ico-dockerstars]][link-dockerhub]

A collection of build configurations to emulate Magento environment locally.

## Docker Hub

https://hub.docker.com/r/sashas777/

## Credits

Inspired by [meanbee/docker-magento2](https://github.com/meanbee/docker-magento2)

# Usage

## START

```bash
docker-compose run cli magento-installer
docker-compose up -d
```

## Build files to containers and run in the background.

```bash
docker-compose up -d
```

## To stop containers and restore them afterwards:

```bash
docker-compose stop
```

## Start containers from suspended state.

```bash
docker-compose start
```

## To stop and remove the Docker configuration:

```bash
docker-compose down -v
```
## Stop and remove all data 

```bash
docker-compose down -v --rmi all --remove-orphans
```

## To update images

```bash
docker-compose pull
```

## Installation


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
[ico-downloads]: https://img.shields.io/docker/pulls/sashas777/magento-php.svg?style=flat-square
[ico-dockerstars]: https://img.shields.io/docker/stars/sashas777/magento-php.svg?style=flat-square

[link-dockerhub]: https://hub.docker.com/r/sashas777/magento-php


## Quick reference

* [Importing DB dump](https://devdocs.magento.com/guides/v2.3/cloud/docker/docker-development.html#database-container)
* [Checking cron logs](https://devdocs.magento.com/guides/v2.3/cloud/docker/docker-development.html#cron-container)
