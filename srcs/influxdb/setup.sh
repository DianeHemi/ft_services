#!/bin/sh

openrc
touch /run/openrc/softlevel
/etc/init.d/influxdb start
/etc/init.d/telegraf start


sleep 1


#setup influxdb database
influx -execute "CREATE DATABASE influxdb"
influx -execute "CREATE DATABASE grafana"
influx -execute "CREATE DATABASE nginx"
influx -execute "CREATE DATABASE wordpress"
influx -execute "CREATE DATABASE phpmyadmin"
influx -execute "CREATE DATABASE ftps"
influx -execute "CREATE USER admin WITH PASSWORD 'admin'"
influx -execute "GRANT ALL ON influxdb to admin"



#setup influxdb config
#/etc/init.d/influxdb stop
#influxd -config /etc/influxdb.conf


tail -f /dev/null