## Welcome to Adobe Commerce Docker Images

[![Docker Pulls][ico-downloads]][link-dockerhub]

This project was born out of necessity - when no working Docker images for Adobe Commerce were available, I took the initiative to create something reliable and efficient, building upon the foundation of the Meanbee images.
These Docker images are designed to make your Adobe Commerce or similar environments effortless to set up, requiring no additional software installations.
## Why Choose These Docker Images?
 - Seamless setup for Adobe Commerce.
 - Fully customizable to suit your unique project requirements.

To make things even easier, we’ve included a CLI interface for quickly creating and managing your environment (But I still improving it).

## How To Use Images

- [How to use images for Local Environment](https://github.com/sashas777/magento-docker-pipelines/wiki/Docker-Local-Environment-For-A-New-Project)
- [How to use images with Bitbucket Pipeline](https://github.com/sashas777/magento-docker-pipelines/wiki/Bitbucket-Pipeline)
- [How to use images with GitLab CI/CD Pipeline](https://github.com/sashas777/magento-docker-pipelines/wiki/GitLab-CI-CD-Pipeline)
- [How to setup with CLI [WIP]](https://github.com/sashas777/docker_cli)

## Adobe Commerce Support

| Adobe Commerce Version | PHP      | Elasticsearch | OpenSearch | nginx      | Redis         | Varnish            |
|------------------------|----------|---------------|------------|------------|---------------|--------------------|
| 2.4.7.x                | 8.3, 8.2 | 8.11          | 2.12       | 1.24       | 7.2           | 7.5                | 
| 2.4.6.x                | 8.2, 8.1 | 8.11, 7.17    | 2.12, 2.5  | 1.24, 1.22 | 7.2, 7.0      | 7.5, 7.3, 7.1      | 
| 2.4.5.x                | 8.1      | 7.17          | 1.3        | 1.24       | 7.2, 7.0, 6.2 | 7.5, 7.3, 7.1, 7.0 | 
| 2.4.4.x                | 8.1      | 7.17, 7.16    | 1.3, 1.2   | 1.24, 1.22 | 7.2, 7.0, 6.2 | 7.5, 7.3, 7.1, 7.0 | 
| 2.4.3.x                | 7.4      | 7.16          | 1.2        | 1.18       | 6.0           | 6.5                | 
| 2.4.2.x                | 7.4      | 7.9           | N/A        | 1.18       | 6.0           | 6.4                | 

Source: [Adobe Commerce System requirements](https://experienceleague.adobe.com/docs/commerce-operations/installation-guide/system-requirements.html)

Do you need OpenSearch? If so submit a GitHub issue, please.

## Docker Images
The table below lists all Docker images available and ready for use with the Adobe Commerce platform. Note that older versions no longer receive updates and remain at their last working build.
If you're interested in having a specific version updated, feel free to contact me via GitHub issues or a sponsorship request.

| Image                 | End of Life  | Update Status |
|-----------------------|--------------|---------------|
| php:7.1               | Nov 28, 2018 | Inactive      |
| php:7.2               | Nov 28, 2019 | Inactive      |
| php:7.3               | Nov 28, 2020 | Inactive      |
| php:7.4               | Nov 28, 2022 | Inactive      |
| php:8.1               | Nov 25, 2024 | Inactive      |
| php:8.2               | Dec 8, 2024  | Active        |
| php:8.3               | Nov 23, 2026 | Active        |
| php:arm64v8           | N/A          | Inactive      |
| elasticsearch:1.7     | Jan 16, 2017 | Inactive      |
| elasticsearch:2.4     | Apr 28, 2017 | Inactive      |
| elasticsearch:5.2     | Jul 31, 2018 | Inactive      |
| elasticsearch:6.8.0   | Feb 10, 2022 | Inactive      |
| elasticsearch:7.6.2   | Aug 11, 2021 | Inactive      |
| elasticsearch:7.9.3   | Feb 18, 2022 | Inactive      |
| elasticsearch:7.13.4  | Aug 1, 2023  | Inactive      |
| elasticsearch:7.16.3  | Aug 1, 2023  | Inactive      |
| elasticsearch:7.17.10 | Aug 1, 2023  | Inactive      |
| elasticsearch:8.4.3   | Aug 10, 2024 | Inactive      |
| elasticsearch:8.5.3   | Aug 10, 2024 | Inactive      |
| elasticsearch:8.11.4  | Aug 10, 2024 | Active        |
| nginx:1.9             | 2015         | Inactive      |
| nginx:1.21            | 2021         | Active        |
| nginx:1.22            | Apr 11, 2023 | Active        |
| nginx:latest          | N/A          | Active        |
| nginx:arm64v8         | N/A          | Inactive      |
| redis:5.0             | Dec 31, 2019 | Inactive      |
| redis:6.2             | Feb 28, 2025 | Inactive      |
| redis:7.0             | N/A          | Inactive      |
| redis:7.2             | Feb, 2026    | Active        |
| varnish:6.5           | Sep 15, 2021 | Inactive      |
| varnish:7.0           | Sep 15, 2022 | Inactive      |
| varnish:7.1           | Mar 15, 2023 | Inactive      |
| varnish:7.5           | Mar 15, 2025 | Active        |

EOL Sources:
- [Elasticsearch](https://www.elastic.co/support/eol)
- [Redis](https://redis.io/docs/latest/operate/rs/installing-upgrading/product-lifecycle/)
- [Varnish](https://varnish-cache.org/releases/)

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
docker buildx build --platform linux/amd64,linux/arm64,linux/arm/v7 -t sashas777/magento-php:8.2-cli --push -f php/8.2-cli/Dockerfile .
docker buildx build --platform linux/amd64,linux/arm64,linux/arm/v7 -t sashas777/magento-php:8.3-cli --push -f php/8.3-cli/Dockerfile .
```

## PHP FPM
```shell
docker buildx build --platform linux/amd64,linux/arm64,linux/arm/v7 -t sashas777/magento-php:8.2-fpm --push -f php/8.2-fpm/Dockerfile .
docker buildx build --platform linux/amd64,linux/arm64,linux/arm/v7 -t sashas777/magento-php:8.3-fpm --push -f php/8.3-fpm/Dockerfile .
```

## Nginx
```shell
docker buildx build --platform linux/amd64,linux/arm64 -t sashas777/magento-nginx:1.21 --push -f nginx/1.21/Dockerfile .
docker buildx build --platform linux/amd64,linux/arm64 -t sashas777/magento-nginx:1.22 --push -f  nginx/1.22/Dockerfile .
docker buildx build --platform linux/amd64,linux/arm64 -t sashas777/magento-nginx:latest --push -f  nginx/latest/Dockerfile .
```

## ElasticSearch
```shell
docker buildx build --platform linux/amd64,linux/arm64 -t sashas777/magento-elasticsearch:8.11.4 --push -f elasticsearch/8.11/Dockerfile .
```

## Varnish
```shell
docker buildx build --platform linux/amd64,linux/arm64,linux/arm/v7 -t sashas777/magento-varnish:7.5 --push -f varnish/7.5/Dockerfile .
```

## Redis
```shell
docker buildx build --platform linux/amd64,linux/arm64,linux/arm/v7 -t sashas777/magento-redis:7.2 --push -f redis/7.2/Dockerfile .
```