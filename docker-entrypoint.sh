#!/bin/sh

set -e

if [ "$(id -u)" = "0" ]; then
  if [ -n "$UID" ] && [ ! "$UID" = "$(id ansible -u)" ]; then
    usermod -u "$UID" ansible
  fi

  if [ -n "$GID" ] && [ ! "$GID" = "$(id ansible -g)" ]; then
    groupmod -g "$GID" ansible
  fi

  chown ansible:ansible /home/ansible

  exec gosu ansible "$@"
else
  exec "$@"
fi

