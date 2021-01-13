#!/bin/sh

# 1. Launch minikube
# 2. eval $(minikube docker-env)    // eval $(minikube -p minikube docker-env)
# 3. docker build -t name /path
# 4. kubectl create/apply -f file_name.yaml

#Lancement de minikube
minikube start --vm-driver=docker
$(minikube -p minikube docker-env)



#Build des images Docker



#Lancement de metalLB
kubectl apply -f metallb-namespace.yaml
kubectl apply -f metallb.yaml
kubectl apply -f metallb-config.yaml


