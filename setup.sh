#!/bin/sh

#Nettoyage, au cas ou
printf "\033[0;32mCleaning...\033[0m\n"
sudo minikube delete

#Necessaire
sudo apt-get install -y conntrack
sudo apt remove -y golang-docker-credential-helpers


#Lancement de minikube
printf "\033[0;32mStarting minikube...\033[0m\n"
minikube start --vm-driver=none
sleep 1
eval $(minikube -p minikube docker-env)


docker load -i srcs/alpine/alpine.tar
minikube addons enable metrics-server
minikube addons enable dashboard



minikube ip > srcs/ip
IP=$(cat srcs/ip)
sed -i -e "s/ipminikube/$IP/g" ./srcs/metallb-config.yaml
sed -i -e "s/ipminikube/$IP/g" ./srcs/ftps/vsftpd.conf
sed -i -e "s/ipminikube/$IP/g" ./srcs/mysql/wordpress_db.sql
rm -f srcs/ip

#Build des images Docker
printf "\033[0;32mBuilding images...\033[0m\n"
docker build -t img-nginx srcs/nginx/
docker build -t img-pma srcs/phpmyadmin/
docker build -t img-wordpress srcs/wordpress/
docker build -t img-mysql srcs/mysql/
docker build -t img-ftps srcs/ftps/
docker build -t img-grafana srcs/grafana/
docker build -t img-influxdb srcs/influxdb/

#Lancement de metalLB
printf "\033[0;32mLoading metallb config files...\033[0m\n"
docker load -i srcs/alpine/controller.tar
docker load -i srcs/alpine/speaker.tar
kubectl apply -f srcs/metallb-namespace.yaml
kubectl apply -f srcs/metallb.yaml
kubectl apply -f srcs/metallb-config.yaml

#Deploiements et services
kubectl apply -f srcs/mysql.yaml
kubectl apply -f srcs/influxdb.yaml
kubectl apply -f srcs/phpmyadmin.yaml

printf "\033[0;32mWaiting for databases to fully initialize...\033[0m\n"
sleep 30

kubectl apply -f srcs/ftps.yaml
kubectl apply -f srcs/grafana.yaml
kubectl apply -f srcs/wordpress.yaml
kubectl apply -f srcs/nginx.yaml

sed -i -e "s/$IP/ipminikube/g" ./srcs/metallb-config.yaml
sed -i -e "s/$IP/ipminikube/g" ./srcs/ftps/vsftpd.conf
sed -i -e "s/$IP/ipminikube/g" ./srcs/mysql/wordpress_db.sql

echo 
echo
printf "\033[0;32mUseful commands :\033[0m\n"
printf "\033[0;33msudo kubectl get po,svc \nsudo minikube dashboard\033[0m\n"
printf "\033[0;33msudo kubectl exec -it pod/podname -- /bin/sh \nsudo kubectl delete podname\033[0m\n"