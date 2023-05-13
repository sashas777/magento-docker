#!/bin/bash

# Fail if any of the healthchecks failed
set -e

# Verify nginx config is valid
nginx -t

# Check if nginx started and listening tcp port
netstat -nlp | grep -E 'tcp.*LISTEN.*nginx' >/dev/null || exit 1