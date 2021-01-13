#!/bin/sh


openrc
touch /run/openrc/softlevel
/etc/init.d/nginx start
/etc/init.d/php-fpm7 start

