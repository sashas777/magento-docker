FROM opensearchproject/opensearch:3.0.0

# Disable security plugin to simplify local development/testing setup
RUN bin/opensearch-plugin remove opensearch-security

# Configure for single-node cluster
RUN echo "discovery.type: single-node" >> /usr/share/opensearch/config/opensearch.yml

# Install Magento required analysis plugins
RUN bin/opensearch-plugin install -b analysis-phonetic
RUN bin/opensearch-plugin install -b analysis-icu

ENV discovery.type=single-node
ENV OPENSEARCH_HOST=localhost
ENV OPENSEARCH_PORT=9200

USER root
ADD opensearch/shared/docker-healthcheck.sh /docker-healthcheck.sh
RUN chmod +x /docker-healthcheck.sh
USER opensearch

# HEALTHCHECK
HEALTHCHECK --retries=3 CMD ["bash", "/docker-healthcheck.sh"]

EXPOSE 9200 9300
