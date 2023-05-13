FROM nginx:1.22

ENV TZ=America/New_York
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt-get update \
  && apt-get install -y \
    openssl \
    nano

ENV UPLOAD_MAX_FILESIZE 64M
ENV FPM_HOST fpm
ENV FPM_PORT 9000
ENV MAGENTO_ROOT /var/www/magento
ENV MAGENTO_RUN_MODE developer
ENV NGINX_WORKER_PROCESSES 1
ENV NGINX_WORKER_CONNECTIONS 1024
ENV UPSTREAM_HOST web
ENV UPSTREAM_PORT 8080
ENV DEBUG false

COPY etc/nginx.conf /etc/nginx/
COPY etc/vhost.conf /etc/nginx/conf.d/default.conf
COPY etc/mapping.conf /etc/nginx/conf.d/a-mapping.conf
COPY etc/nginx.conf.sample /etc/nginx/magento.conf.sample

RUN mkdir /etc/nginx/ssl

RUN openssl req -x509 -nodes -days 730 \
    -subj  "/C=US/ST=TX/L=New York/O=TheSGroup/OU=Magento Docker/CN=sashas.org" \
     -newkey rsa:2048 -keyout /etc/nginx/ssl/magento.key \
     -out /etc/nginx/ssl/magento.crt;

EXPOSE 443

COPY docker-entrypoint.sh /docker-entrypoint.sh
RUN ["chmod", "+x", "/docker-entrypoint.sh"]
ENTRYPOINT ["/docker-entrypoint.sh"]

CMD ["nginx", "-g", "daemon off;"]
