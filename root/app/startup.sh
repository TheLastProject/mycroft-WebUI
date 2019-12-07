#!/bin/sh

# Use SSL if certs exist
if [ -f "/config/nginx.crt" ] && [ -f "/config/nginx.key" ]; then
  mv /etc/nginx/nginx.conf.ssl /etc/nginx/nginx.conf
else
  rm /etc/nginx/nginx.conf.ssl
fi

# Use env vars for auth if no .htaccess exists
if [ ! -f "/config/.htpasswd" ]; then
  if [ -z "$ADMIN_USERNAME" ] || [ -z "$ADMIN_PASSWORD" ]; then
    echo "No .htpasswd file provided and ADMIN_USERNAME and ADMIN_PASSWORD environment variables not set. You need to provide a .htpasswd file or define ADMIN_USERNAME and ADMIN_PASSWORD."
    exit 1
  fi
  htpasswd -cb /config/.htpasswd "$ADMIN_USERNAME" "$ADMIN_PASSWORD"
fi

mkdir /run/nginx/
nginx &
python3 __main__.py
