## Magento 2 Docker Container Images

[![Docker Pulls][ico-downloads]][link-dockerhub]

Magento 2 docker container images for local environment and tests.

## Get Started

- [Local Environment](https://github.com/sashas777/magento-docker-pipelines/wiki/Docker-Local-Environment-For-A-New-Project)
- [Bitbucket Pipeline](https://github.com/sashas777/magento-docker-pipelines/wiki/Bitbucket-Pipeline)
- [GitLab CI/CD Pipeline](https://github.com/sashas777/magento-docker-pipelines/wiki/GitLab-CI-CD-Pipeline)

# Related Resources

- [Pipelines/Local Environment Configuration](https://github.com/sashas777/magento-docker-pipelines)
- [Magento 2 Test Framework](https://github.com/sashas777/magento2-testing-framework)
- [Docker Hub](https://hub.docker.com/r/sashas777/)
- Inspired by [meanbee/docker-magento2](https://github.com/meanbee/docker-magento2)

[ico-downloads]: https://img.shields.io/docker/pulls/sashas777/magento-php.svg?style=flat-square
[link-dockerhub]: https://hub.docker.com/r/sashas777/

# Build Images

## PHP CLI
```shell
docker buildx build --platform linux/amd64,linux/arm64 -t sashas777/magento-php:8.1-cli --push -f php/8.1-cli/Dockerfile .
```

## PHP FPM
```shell
docker buildx build --platform linux/amd64,linux/arm64 -t sashas777/magento-php:8.1-fpm --push -f php/8.1-fpm/Dockerfile .
```