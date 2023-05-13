FROM varnish:7.1

ENV CACHE_SIZE      64m
ENV VCL_CONFIG /data/default.vcl
ENV VARNISHD_PARAMS -p default_ttl=3600 -p default_grace=3600 -p feature=+esi_ignore_https -p feature=+esi_disable_xml_check
 
COPY etc/default.vcl /etc/varnish/