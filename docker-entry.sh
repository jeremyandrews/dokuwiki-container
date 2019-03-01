#!/bin/sh

# Launch php-fpm and nginx
service php7.0-fpm start && \
  nginx -g 'daemon off;'