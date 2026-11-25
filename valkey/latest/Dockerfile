FROM valkey/valkey:latest

VOLUME /data

EXPOSE 6379

CMD ["valkey-server"]

# HEALTHCHECK
HEALTHCHECK --interval=5s --timeout=1s --retries=12 CMD ["valkey-cli", "ping"]

