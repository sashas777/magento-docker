#!/bin/bash
set -e

# Test php-fpm configuration
php-fpm -t

# Check if php-fpm is listening and accepting connections on port 9000
php -r '
$socket = @fsockopen("127.0.0.1", 9000, $errno, $errstr, 2);
if ($socket) {
    fclose($socket);
    exit(0);
}
exit(1);
'
