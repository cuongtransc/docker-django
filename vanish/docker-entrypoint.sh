#!/bin/bash
set -e

if [ "$1" = 'vanishd' ]; then
    for name in BACKEND_PORT_80_TCP_ADDR; do
        eval value=\$$name
        sed "s|\${${name}}|${value}|g" /etc/varnish/default.tmpl > /etc/varnish/default.vcl
    done

    varnishd -F -f /etc/varnish/default.vcl -s malloc,$CACHE_SIZE -a 0.0.0.0:80
fi

exec "$@"
