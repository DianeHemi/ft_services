#!/bin/sh

openrc
touch /run/openrc/softlevel

#Créer utilisateur
adduser admin
echo "admin:admin" | chpasswd

#chmod 755 home/admin/
#chmod 744 home/admin/*

echo "root:toor" | chpasswd

/etc/init.d/telegraf start
#rc-service vsftpd restart

vsftpd /etc/vsftpd/vsftpd.conf







