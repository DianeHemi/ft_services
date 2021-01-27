#!/bin/sh

openrc
touch /run/openrc/softlevel
/etc/init.d/nginx start
/etc/init.d/telegraf start

tail -f /dev/null