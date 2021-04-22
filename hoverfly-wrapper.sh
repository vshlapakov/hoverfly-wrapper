#! /bin/sh

set -e

signal_handler() {
    kill -TERM -$$  # negative PID, kill process group
}
trap signal_handler INT

HOVERFLY_JWT_SECRET=jwt-secret
HOVERFLY_JWT_EXPIRE_HOURS=72
HOVERFLY_ADMIN_NAME=super-admin
HOVERFLY_ADMIN_PASS=weird-password
HOVERFLY_ADMIN_PORT=8888
HOVERFLY_PROXY_PORT=8500

# allow to redefine it via environment variable
HOVERFLY_SETTINGS_PATH=${HOVERFLY_SETTINGS_PATH:-'/mnt/mesos/sandbox/settings.sh'}
if test -f "$HOVERFLY_SETTINGS_PATH" ; then
  source "$HOVERFLY_SETTINGS_PATH"
fi

export HoverflySecret=$HOVERFLY_JWT_SECRET \
  HoverflyTokenExpiration=$HOVERFLY_JWT_EXPIRE_HOURS
  /bin/hoverfly \
  -listen-on-host=0.0.0.0 \
  -webserver \
  -auth -add \
  -username $HOVERFLY_ADMIN_NAME \
  -password $HOVERFLY_ADMIN_PASS \
  -ap $HOVERFLY_ADMIN_PORT \
  -pp $HOVERFLY_PROXY_PORT \
  &

wait