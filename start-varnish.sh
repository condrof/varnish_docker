#!/bin/bash
for name in BACKEND_PORT
do
  eval value=\$$name
  sed -ie "s|\${${name}}|${value}|g" /etc/varnish/default.templ
  sed "s|\${${name}}|${value}|g" /etc/varnish/default.templ > /etc/varnish/default.vcl
done

for name in BACKEND_PORT
do
  eval value=\$$name
  sed "s|\${${name}}|${value}|g" /etc/varnish/default.templ > /etc/varnish/default.vcl
done

cat /etc/varnish/default.vcl
varnishd -F -f /etc/varnish/default.vcl -s malloc,$CACHE_SIZE -a 0.0.0.0:80
