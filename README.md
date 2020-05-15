# Magento 2 Docker Containers

[![Docker Pulls][ico-downloads]][link-dockerhub]

Magento 2 docker containers for local environment and tests.

# Resources

- [Pipelines configuration](https://github.com/sashas777/magento-docker-pipelines)
- [Magento 2 Static/Unit Test Framework](https://github.com/sashas777/magento2-testing-framework)
- [Docker Hub](https://hub.docker.com/r/sashas777/)
- Inspired by [meanbee/docker-magento2](https://github.com/meanbee/docker-magento2)

# Commands

```bash
bin/stop
```
Stop containers and restore them afterwards.

```bash
bin/start
```
Start containers from suspended state.

```bash
docker-compose pull
```
Update images

## Local Environment
 
```bash
bin/install
bin/up
```

Build files to containers and run in the background.
 
```bash
bin/down
```
Stop and remove all data
  
```bash
docker-compose run cli bash
```
Connect to CLI container
 
```bash
docker-compose run cli magento-command
```
Running Magento command
 
### ImportDB Dump
To import a database dump, place the SQL file into the dev/docker-entrypoint-initdb.d folder.

### Cron Logs
```bash
docker-compose run cli bash -c "cat /var/www/magento/var/log/magento.cron.log"
```
 
[ico-downloads]: https://img.shields.io/docker/pulls/sashas777/magento-php.svg?style=flat-square