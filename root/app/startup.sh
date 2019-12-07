#!/bin/sh

# Use SSL if certs exist
if [ -f "/config/nginx.crt" ] && [ -f "/config/nginx.key" ]; then
  mv /etc/nginx/nginx.conf.ssl /etc/nginx/nginx.conf
else
  rm /etc/nginx/nginx.conf.ssl
fi

mkdir /run/nginx/
nginx &
python3 __main__.py
