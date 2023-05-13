FROM redis:6.2

VOLUME /data

EXPOSE 6379

CMD ["redis-server"]

HEALTHCHECK --interval=5s --timeout=1s --retries=12 CMD ["CMD", "redis-cli", "--raw", "incr", "ping"]