#!/bin/sh


openrc
touch /run/openrc/softlevel
/etc/init.d/php-fpm7 start
/etc/init.d/nginx start
/etc/init.d/telegraf start

tail -f /dev/null