#!/bin/sh

openrc
touch /run/openrc/softlevel
/etc/init.d/telegraf start

cd /usr/share/grafana && /usr/sbin/grafana-server --config=/etc/grafana.ini

