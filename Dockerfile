FROM	debian:9.7-slim

# The version of Dokuwiki to install: (see https://github.com/splitbrain/dokuwiki/releases )
ENV DOKUWIKI_INSTALL "release_stable_2018-04-22b.tar.gz"

WORKDIR /opt/dokuwiki
COPY docker-entry.sh /opt/bin/

# Base requirements:
RUN apt-get update && apt-get -y upgrade && \
  apt-get -y install nginx wget vim && \
  apt-get -y install php-common php-xml php-json php-gd php-imap php-fpm

# Allow installation of extensions:
RUN apt-get -y install php-curl

# Configure nginx
COPY nginx/default /etc/nginx/sites-enabled/
RUN /bin/mkdir /run/php && \
  /bin/chown www-data:www-data /run/php

# Download and install Dokuwiki
RUN /usr/bin/wget --continue https://github.com/splitbrain/dokuwiki/archive/${DOKUWIKI_INSTALL} && \
  /bin/tar xvfz /opt/dokuwiki/${DOKUWIKI_INSTALL} && \
  DOKUWIKI_INSTALLED=`/usr/bin/find . -type d -maxdepth 1 | /bin/grep doku` && \
  /bin/rm -r /var/www/html && \
  /bin/ln -s /opt/dokuwiki/${DOKUWIKI_INSTALLED} /var/www/html && \
  /bin/chown -R www-data:www-data /opt/dokuwiki/${DOKUWIKI_INSTALLED}

# Edit nginx/default and this EXPOSE to change the listening port
EXPOSE 8080
CMD ["sh", "/opt/bin/docker-entry.sh"]
