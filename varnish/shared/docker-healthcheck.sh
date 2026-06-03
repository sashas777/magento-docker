#!/usr/bin/env sh

# Fail if any of the health checks failed
set -e

# Helper to check if a port is listening using /proc/net/tcp
port_listening() {
    port=$1
    # Convert port to 4-character uppercase hex
    hex_port=$(printf "%04X" "$port")

    # Check both /proc/net/tcp and /proc/net/tcp6 if they exist
    for f in /proc/net/tcp /proc/net/tcp6; do
        if [ -f "$f" ]; then
            if awk '{print $2, $4}' "$f" | grep -q -i ":${hex_port} 0A"; then
                return 0
            fi
        fi
    done
    return 1
}

# If netstat is available, use it. Otherwise, fallback to /proc/net/tcp
if command -v netstat >/dev/null 2>&1; then
    netstat -nlp | grep -E "tcp.*:${VARNISH_PORT}.*LISTEN.*" >/dev/null
else
    port_listening "$VARNISH_PORT"
fi

# Check varnishadm status if available
if command -v varnishadm >/dev/null 2>&1; then
    varnishadm status | grep -q "Child in state running"
fi