## Magento 2 Docker Container Images

[![Docker Pulls][ico-downloads]][link-dockerhub]

Magento 2 docker container images for local environment and tests.

## How To Use Images

- [How to use images for Local Environment](https://github.com/sashas777/magento-docker-pipelines/wiki/Docker-Local-Environment-For-A-New-Project)
- [How to use images with Bitbucket Pipeline](https://github.com/sashas777/magento-docker-pipelines/wiki/Bitbucket-Pipeline)
- [How to use images with GitLab CI/CD Pipeline](https://github.com/sashas777/magento-docker-pipelines/wiki/GitLab-CI-CD-Pipeline)

## Support Matrix
The image supported per official support docs or may be updated per GitHub request.
If you interested in a specific version - feel free to contact or use GitHub sponsorship.
The support matrix below has been created based on image downloads from DockerHub.

- [Magento Support Matrix](https://experienceleague.adobe.com/docs/commerce-operations/installation-guide/system-requirements.html)


| Image                 | End of Life  | Support Status |
|-----------------------|--------------|----------------|
| php:7.1               | Nov 28, 2018 | Inactive       |
| php:7.2               | Nov 28, 2019 | Inactive       |
| php:7.3               | Nov 28, 2020 | Inactive       |
| php:7.4               | Nov 28, 2022 | Inactive         |
| php:8.1               | Nov 25, 2024 | Active         |
| php:8.2               | Dec 8, 2024  | Active         |
| php:arm64v8           | N/A          | Inactive       |
| elasticsearch:1.7     | Jan 16, 2017 | Inactive       |
| elasticsearch:2.4     | Apr 28, 2017 | Inactive       |
| elasticsearch:5.2     | Jul 31, 2018 | Inactive       |
| elasticsearch:6.8.0   | Feb 10, 2022 | Inactive       |
| elasticsearch:7.6.2   | Aug 11, 2021 | Inactive       |
| elasticsearch:7.9.3   | Feb 18, 2022 | Active         |
| elasticsearch:7.16.3  | Aug 1, 2023  | Active         |
| elasticsearch:7.17.10 | Aug 1, 2023  | Active         |
| elasticsearch:8.4.3   | Aug 10, 2024 | Active         |
| nginx:1.9             | 2015         | Inactive       |
| nginx:1.21            | 2021         | Active         |
| nginx:1.22            | Apr 11, 2023 | Active         |
| nginx:latest          | N/A          | Active         |
| nginx:arm64v8         | N/A          | Inactive       |
| redis:5.0             | Dec 31, 2019 | Inactive       |
| redis:6.2             | Aug 31, 2023 | Active         |
| redis:7.0             | N/A          | Active         |
| varnish:6.5           | Sep 15, 2021 | Inactive       |
| varnish:7.0           | Sep 15, 2022 | Active         |
| varnish:7.1           | Mar 15, 2023 | Active         |

# Related Resources

- [Pipelines/Local Environment Configuration](https://github.com/sashas777/magento-docker-pipelines)
- [Magento 2 Test Framework](https://github.com/sashas777/magento2-testing-framework)
- [Docker Hub](https://hub.docker.com/r/sashas777/)
- Inspired by [meanbee/docker-magento2](https://github.com/meanbee/docker-magento2), [Docksal](https://docksal.io/)

[ico-downloads]: https://img.shields.io/docker/pulls/sashas777/magento-php.svg?style=flat-square
[link-dockerhub]: https://hub.docker.com/r/sashas777/

# Build Images
 
## PHP CLI
```shell
docker buildx build --platform linux/amd64,linux/arm64 -t sashas777/magento-php:8.1-cli --push -f php/8.1-cli/Dockerfile .
docker buildx build --platform linux/amd64,linux/arm64 -t sashas777/magento-php:8.2-cli --push -f php/8.2-cli/Dockerfile .
docker buildx build --platform linux/amd64,linux/arm64 -t sashas777/magento-php:7.4-cli --push -f php/7.4-cli/Dockerfile .
```

## PHP FPM
```shell
docker buildx build --platform linux/amd64,linux/arm64 -t sashas777/magento-php:8.1-fpm --push -f php/8.1-fpm/Dockerfile .
docker buildx build --platform linux/amd64,linux/arm64 -t sashas777/magento-php:8.2-fpm --push -f php/8.2-fpm/Dockerfile .
docker buildx build --platform linux/amd64,linux/arm64 -t sashas777/magento-php:7.4-fpm --push -f php/7.4-fpm/Dockerfile .
```

## Nginx
```shell
docker buildx build --platform linux/amd64,linux/arm64 -t sashas777/magento-nginx:1.21 --push -f nginx/1.21/Dockerfile .
docker buildx build --platform linux/amd64,linux/arm64 -t sashas777/magento-nginx:1.22 --push -f  nginx/1.22/Dockerfile .
docker buildx build --platform linux/amd64,linux/arm64 -t sashas777/magento-nginx:latest --push -f  nginx/latest/Dockerfile .
```

## ElasticSearch
```shell
docker buildx build --platform linux/amd64,linux/arm64 -t sashas777/magento-elasticsearch:8.4.3 --push -f elasticsearch/8.4.3/Dockerfile .
docker buildx build --platform linux/amd64,linux/arm64 -t sashas777/magento-elasticsearch:7.17.10 --push -f elasticsearch/7.17.10/Dockerfile .
docker buildx build --platform linux/amd64,linux/arm64 -t sashas777/magento-elasticsearch:7.16.3 --push -f elasticsearch/7.16.3/Dockerfile .
docker buildx build --platform linux/amd64,linux/arm64 -t sashas777/magento-elasticsearch:7.9.3 --push -f elasticsearch/7.9.3/Dockerfile .
```

## Varnish
```shell
docker buildx build --platform linux/amd64,linux/arm64 -t sashas777/magento-varnish:7.1 --push -f varnish/7.1/Dockerfile .
docker buildx build --platform linux/amd64,linux/arm64 -t sashas777/magento-varnish:7.0 --push -f varnish/7.0/Dockerfile .
```

## Redis
```shell
docker buildx build --platform linux/amd64,linux/arm64 -t sashas777/magento-redis:6.2 --push -f Dockerfile .
docker buildx build --platform linux/amd64,linux/arm64 -t sashas777/magento-redis:7.0 --push -f Dockerfile .
```