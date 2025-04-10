#!/bin/bash

# Obtener las variables de entorno que necesitas para hablar con el Docker de Minikube
eval $(minikube -p minikube docker-env)

# Ejecuta el comando que se te trabe aquí
docker build -t vanhanzy-web .
minikube image load vanhanzy-web
