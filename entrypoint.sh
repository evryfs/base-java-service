#!/bin/bash

set -e

# If GOSU_CHOWN environment variable set, recursively chown all specified directories 
# to match the user:group set in GOSU_USER environment variable.
if [ -n "$GOSU_CHOWN" ]; then
  for DIR in $GOSU_CHOWN
  do
    chown -R $GOSU_USER $DIR
  done
fi

if (( `id -u` == 0 )); then
  chown -R app:app /app || true
fi

# If GOSU_USER environment variable set to something other than 0:0 (root:root),
# become user:group set within and exec command passed in args
if [ -n "$GOSU_USER" ] && [ "$GOSU_USER" != "0:0" ]; then
  IFS=':' read -r -a uidgid <<< $GOSU_USER
  groupmod -o -g "${uidgid[1]}" app || true
  usermod -u "${uidgid[0]}" -g "${uidgid[1]}" app
  exec gosu $GOSU_USER "$@"
fi

# If GOSU_USER was 0:0 exec command passed in args without gosu (assume already root)
exec "$@"
