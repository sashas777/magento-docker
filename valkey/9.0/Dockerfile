FROM valkey/valkey:9.0

VOLUME /data

EXPOSE 6379

CMD ["valkey-server"]

# HEALTHCHECK
HEALTHCHECK --interval=5s --timeout=1s --retries=12 CMD ["valkey-cli", "ping"]
