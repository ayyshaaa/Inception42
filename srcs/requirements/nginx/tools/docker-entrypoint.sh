#!/bin/bash
set -e

# Generate SSL certificate with actual domain name
if [ ! -f /etc/nginx/ssl/nginx.crt ]; then
    openssl req -newkey rsa:2048 -nodes \
        -keyout /etc/nginx/ssl/nginx.key \
        -x509 -days 365 \
        -out /etc/nginx/ssl/nginx.crt \
        -subj "/C=FR/ST=Paris/L=Paris/O=42/OU=42/CN=$DOMAIN_NAME"
    chmod 600 /etc/nginx/ssl/nginx.key
    chmod 644 /etc/nginx/ssl/nginx.crt
fi

echo "Starting Nginx..."
echo "Executing: $@"
exec "$@"
