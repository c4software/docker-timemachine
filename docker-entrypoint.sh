#!/bin/bash

set -e

if [ ! -e /.initialized ]; then
  if [ -z $AFP_LOGIN ]; then
    echo "no AFP_LOGIN specified!"
    exit 1
  fi

  if [ -z $AFP_PASSWORD ]; then
    echo "no AFP_PASSWORD specified!"
    exit 1
  fi

  if [ -z $AFP_NAME ]; then
    echo "no AFP_NAME specified!"
    exit 1
  fi

  useradd $AFP_LOGIN -M
  echo $AFP_LOGIN:$AFP_PASSWORD | chpasswd
  chown $AFP_LOGIN:$AFP_LOGIN /timemachine

  echo "[Global]
  mimic model = Xserve
  log file = /proc/self/fd/1
  log level = default:info
  zeroconf = no

  [${AFP_NAME}]
  path = /timemachine
  time machine = yes
  valid users = ${AFP_LOGIN}" > /usr/local/etc/afp.conf

  if [ -n "$AFP_SIZE_LIMIT" ]; then
    echo "
  vol size limit = ${AFP_SIZE_LIMIT}" >> /usr/local/etc/afp.conf
  fi

  touch /.initialized
fi

rm -f /var/lock/netatalk
/usr/local/sbin/netatalk -d
