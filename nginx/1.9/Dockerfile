FROM nginx:1.9

ENV TZ=America/New_York
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

COPY etc/vhost.conf /etc/nginx/conf.d/default.conf
COPY etc/mapping.conf /etc/nginx/conf.d/a-mapping.conf
COPY etc/certs/ /etc/nginx/ssl/
COPY bin/* /usr/local/bin/

EXPOSE 443

ENV UPLOAD_MAX_FILESIZE 64M
ENV FPM_HOST fpm
ENV FPM_PORT 9000
ENV MAGENTO_ROOT /var/www/magento
ENV MAGENTO_RUN_MODE developer
ENV DEBUG false

RUN ["chmod", "+x", "/usr/local/bin/docker-environment"]

ENTRYPOINT ["/usr/local/bin/docker-environment"]
CMD ["nginx", "-g", "daemon off;"]
