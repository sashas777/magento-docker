FROM docker.elastic.co/elasticsearch/elasticsearch:7.9.3

RUN echo "xpack.security.enabled: false" >> /usr/share/elasticsearch/config/elasticsearch.yml
RUN /usr/share/elasticsearch/bin/elasticsearch-plugin install -b analysis-phonetic

ENV discovery.type single-node

EXPOSE 9200 9300
