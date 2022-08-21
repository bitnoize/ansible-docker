#!/bin/sh

set -e

if [ "$(id -u)" = "0" ]; then
  if [ -n "$UID" ] && [ ! "$UID" = "$(id devops -u)" ]; then
    usermod -u "$UID" devops
  fi

  if [ -n "$GID" ] && [ ! "$GID" = "$(id devops -g)" ]; then
    groupmod -g "$GID" devops
  fi

  chown devops:devops /home/devops || true

  exec gosu devops "$@"
else
  exec "$@"
fi

