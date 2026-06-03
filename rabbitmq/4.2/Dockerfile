FROM rabbitmq:4.2-management

# HEALTHCHECK
HEALTHCHECK --interval=10s --timeout=5s --retries=3 CMD ["rabbitmq-diagnostics", "-q", "ping"]
