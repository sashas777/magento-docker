FROM docker.elastic.co/elasticsearch/elasticsearch:7.6.2

RUN echo "xpack.security.enabled: false" >> /usr/share/elasticsearch/config/elasticsearch.yml
RUN /usr/share/elasticsearch/bin/elasticsearch-plugin install -b analysis-phonetic

EXPOSE 9200 9300
