FROM apache/activemq-artemis:2.39.0-alpine

USER root

# Install curl for healthcheck
RUN apk --no-cache add curl

USER artemis

# EXPOSE AMQP (61616) and Web Console (8161) ports
EXPOSE 61616 8161

# HEALTHCHECK
HEALTHCHECK --interval=10s --timeout=5s --retries=3 CMD curl --silent --fail http://localhost:8161/ || exit 1
