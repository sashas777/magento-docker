FROM varnish:6.5

ENV CACHE_SIZE      64m
ENV VCL_CONFIG /data/default.vcl
ENV VARNISHD_PARAMS -p default_ttl=3600 -p default_grace=3600 -p feature=+esi_ignore_https -p feature=+esi_disable_xml_check
ENV VARNISH_PORT 80
ENV VARNISH_ADMIN_PORT 6082

COPY varnish/shared/etc/default.vcl /etc/varnish/
COPY varnish/shared/docker-healthcheck.sh /docker-healthcheck.sh

HEALTHCHECK --interval=5s --timeout=1s --retries=12 CMD ["/docker-healthcheck.sh"]