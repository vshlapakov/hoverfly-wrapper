#! /bin/sh

set -e

signal_handler() {
    kill -TERM -$$  # negative PID, kill process group
}
trap signal_handler INT

HOVERFLY_JWT_SECRET=jwt-secret
HOVERFLY_JWT_EXPIRE=72  # hours
HOVERFLY_ADMIN_NAME=super-admin
HOVERFLY_ADMIN_PASS=weird-password
HOVERFLY_ADMIN_PORT=8888
HOVERFLY_PROXY_PORT=8500

if test -f "$1" ; then
  source "$1"
fi

export HoverflySecret=$HOVERFLY_JWT_SECRET \
  HoverflyTokenExpiration=$HOVERFLY_JWT_EXPIRE
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