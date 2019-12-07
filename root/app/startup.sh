#!/bin/sh

mkdir /run/nginx/
nginx &
python3 __main__.py
