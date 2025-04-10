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
                    // Construir la imagen de Docker
                    sh 'docker build -t $IMAGE_NAME .'
                }
            }
        }

        stage('Deploy to Minikube') {
            steps {
                script {
                    // Cargar la imagen en Minikube
                    sh "minikube image load $IMAGE_NAME"
                }
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                script {
                    // Realizar el despliegue en Kubernetes
                    sh 'kubectl apply -f k8s/deployment.yaml'
                    sh 'kubectl apply -f k8s/service.yaml'
                }
            }
        }
    }
}
