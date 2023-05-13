FROM docker.elastic.co/elasticsearch/elasticsearch:7.16.3

RUN echo "xpack.security.enabled: false" >> /usr/share/elasticsearch/config/elasticsearch.yml
RUN echo "discovery.type: single-node" >> /usr/share/elasticsearch/config/elasticsearch.yml

RUN bin/elasticsearch-plugin install -b analysis-phonetic
RUN bin/elasticsearch-plugin install -b analysis-icu

ENV discovery.type single-node

ADD elasticsearch/shared/docker-healthcheck.sh /docker-healthcheck.sh

HEALTHCHECK --retries=3 CMD ["bash", "/docker-healthcheck.sh"]

EXPOSE 9200 9300
