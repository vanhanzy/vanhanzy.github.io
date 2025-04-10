#!/bin/bash

echo "🔥 Activando entorno de Docker de Minikube..."
eval $(minikube -p minikube docker-env)

echo "🚨 Matando Jenkins viejo si existe..."
docker stop jenkins 2>/dev/null
docker rm jenkins 2>/dev/null

echo "⚙️ Levantando nuevo contenedor Jenkins con Docker inside Minikube..."

docker run -d \
  --name jenkins \
  -p 8080:8080 \
  -p 50000:50000 \
  --user root \
  -v jenkins_home:/var/jenkins_home \
  -v /var/run/docker.sock:/var/run/docker.sock \
  jenkins-with-docker:latest

echo "⏳ Esperando 5 segundos para que levante..."
sleep 5

echo "✅ Jenkins debería estar corriendo en http://localhost:8080"
echo "📍 Password inicial: "
docker exec -it jenkins cat /var/jenkins_home/secrets/initialAdminPassword
