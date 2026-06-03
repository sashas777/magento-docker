#!/bin/bash
set -e

# Check if cron service is active if pid file exists
if [ -f /var/run/crond.pid ]; then
    kill -0 $(cat /var/run/crond.pid) || exit 1
elif [ -f /var/run/cron.pid ]; then
    kill -0 $(cat /var/run/cron.pid) || exit 1
fi

# Verify PHP works
php -v >/dev/null
