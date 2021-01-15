#!/bin/sh


openrc
touch /run/openrc/softlevel

/etc/init.d/mariadb setup
/etc/init.d/mariadb start

echo '> mariadb start : ok'
echo '> Creating users and loading wordpress database...'

mysql -u root < /www/mariadb_user_creation.sql
mysql wordpress_db -u root < /www/wordpress_db.sql

echo '> Everything went well !'

