#!/bin/sh

openrc
touch /run/openrc/softlevel
/etc/init.d/telegraf start
rc-service nginx start

tail -f /dev/null