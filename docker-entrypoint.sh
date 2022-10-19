#!/bin/sh

set -e

if [ "$(id -u)" = "0" ]; then
  if [ -n "$UID" ] && [ ! "$UID" = "$(id ansible -u)" ]; then
    usermod -u "$UID" ansible
  fi

  if [ -n "$GID" ] && [ ! "$GID" = "$(id ansible -g)" ]; then
    groupmod -g "$GID" ansible
  fi

  chown -R ansible:ansible /home/ansible

  if [ -x "/lib/entrypoint.d" ]; then
    run-parts -v --regex '.*sh$' /lib/entrypoint.d
  fi

  exec gosu ansible "$@"
else
  exec "$@"
fi

