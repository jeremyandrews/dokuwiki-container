FROM	alpine:3.9

# The version of Dokuwiki to install: (see https://github.com/splitbrain/dokuwiki/releases )
ENV DOKUWIKI_INSTALL "release_stable_2018-04-22b.tar.gz"

WORKDIR /usr/share

# Base requirements:
RUN apk add --no-cache wget lighttpd php7-common php7-cgi php7-iconv php7-xml php7-json php7-gd php7-imap php7-session fcgi

# Allow installation of extensions:
RUN apk add --no-cache php7-curl php7-openssl

#RUN apk add --no-cache bash

# Configure lighttpd
COPY lighttpd/lighttpd.conf /etc/lighttpd/lighttpd.conf
RUN /bin/mkdir /run/lighttpd && \
  /bin/chown lighttpd:lighttpd /run/lighttpd

# Download and install Dokuwiki
RUN /usr/bin/wget --continue https://github.com/splitbrain/dokuwiki/archive/${DOKUWIKI_INSTALL} && \
  /bin/tar xvfz /usr/share/${DOKUWIKI_INSTALL} && \
  DOKUWIKI_INSTALLED=`/usr/bin/find . -type d -maxdepth 1 | /bin/grep doku` && \
  /bin/rmdir /var/www/localhost/htdocs && \
  /bin/ln -s /usr/share/${DOKUWIKI_INSTALLED} /var/www/localhost/htdocs && \
  /bin/chown -R lighttpd:lighttpd /usr/share/${DOKUWIKI_INSTALLED}

# Edit lighttpd.conf and this EXPOSE to change the listening port
EXPOSE 8080
CMD ["/usr/sbin/lighttpd", "-D", "-f", "/etc/lighttpd/lighttpd.conf"]

