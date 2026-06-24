FROM rabbitmq:4.2-management

USER root
RUN apt-get update \
  && apt-get upgrade -y libssl3t64 openssl perl-base libgnutls30t64 \
  && rm -rf /var/lib/apt/lists/*
USER rabbitmq

# HEALTHCHECK
HEALTHCHECK --interval=10s --timeout=5s --retries=3 CMD ["rabbitmq-diagnostics", "-q", "ping"]
