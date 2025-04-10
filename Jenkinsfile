pipeline {
    agent any

    environment {
        IMAGE_NAME = "vanhanzy-web"
    }

    stages {
        stage('Checkout') {
            steps {
                // Clonar el repositorio
                git 'https://github.com/vanhanzy/vanhanzy.github.io.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    // Construir imagen usando Docker de Minikube
                    sh 'eval $(minikube -p minikube docker-env) && docker build -t $IMAGE_NAME .'
                }
            }
        }

        stage('Deploy to Minikube') {
            steps {
                script {
                    // Cargar imagen a Minikube
                    sh 'eval $(minikube -p minikube docker-env) && minikube image load $IMAGE_NAME'
                }
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                script {
                    // Aplicar manifiestos en K8s
                    sh 'kubectl apply -f k8s/deployment.yaml'
                    sh 'kubectl apply -f k8s/service.yaml'
                }
            }
        }
    }
}
