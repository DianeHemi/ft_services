#!/bin/sh

#clé ssl ici ?

openrc
touch /run/openrc/softlevel
/etc/init.d/nginx start

#lancement sshd ici ?