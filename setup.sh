#!/bin/sh

#Nettoyage, au cas ou
minikube delete

#Lancement de minikube
minikube start --vm-driver=docker
sleep 1
eval $(minikube -p minikube docker-env)

docker load -i srcs/alpine/alpine.tar


minikube addons enable metrics-server
minikube addons enable dashboard
minikube addons enable metallb


#Build des images Docker
docker build -t img-nginx srcs/nginx/
docker build -t img-pma srcs/phpmyadmin/
docker build -t img-wordpress srcs/wordpress/
docker build -t img-mysql srcs/mysql/
docker build -t img-ftps srcs/ftps/
docker build -t img-grafana srcs/grafana/
docker build -t img-influxdb srcs/influxdb/


#Lancement de metalLB
kubectl apply -f srcs/metallb-namespace.yaml
kubectl apply -f srcs/metallb.yaml
kubectl apply -f srcs/metallb-config.yaml

#Deploiements et services
kubectl apply -f srcs/nginx.yaml
kubectl apply -f srcs/phpmyadmin.yaml
kubectl apply -f srcs/wordpress.yaml
kubectl apply -f srcs/mysql.yaml
kubectl apply -f srcs/ftps.yaml
kubectl apply -f srcs/grafana.yaml
kubectl apply -f srcs/influxdb.yaml