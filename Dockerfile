FROM ubuntu:14.04
MAINTAINER Matthias Neugebauer <matthias.neugebauer@mtneug.de>

ENV NETATALK_VERSION=3.1.8 \
    DEV_LIBRARIES="\
      libcrack2-dev \
      libwrap0-dev \
      autotools-dev \
      libdb-dev \
      libacl1-dev \
      libdb5.3-dev \
      libgcrypt11-dev \
      libtdb-dev \
      libkrb5-dev \
    "

RUN ln -s -f /bin/true /usr/bin/chfn \
 && apt-get update \
 && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
      build-essential wget pkg-config checkinstall automake libtool \
      db-util db5.3-util libgcrypt11 ${DEV_LIBRARIES} \
 && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /timemachine /usr/local/src/netatalk \
 && cd /usr/local/src/netatalk \
 && wget "http://prdownloads.sourceforge.net/netatalk/netatalk-${NETATALK_VERSION}.tar.gz" \
 && tar xvf netatalk-${NETATALK_VERSION}.tar.gz \
 && cd netatalk-${NETATALK_VERSION} \
 && ./configure \
       --enable-debian \
       --enable-krbV-uam \
       --disable-zeroconf \
       --enable-krbV-uam \
       --enable-tcp-wrappers \
       --with-cracklib \
       --with-acls \
       --with-dbus-sysconf-dir=/etc/dbus-1/system.d \
       --with-init-style=debian-sysv \
       --with-pam-confdir=/etc/pam.d \
 && make \
 && checkinstall \
       --pkgname=netatalk \
       --pkgversion=$NETATALK_VERSION \
       --backup=no \
       --deldoc=yes \
       --default \
       --fstrans=no \
 && touch /var/log/afpd.log \
 && rm -rf /usr/local/src/netatalk

VOLUME ["/timemachine"]
EXPOSE 548 636

COPY docker-entrypoint.sh /entrypoint.sh
CMD "/entrypoint.sh"
