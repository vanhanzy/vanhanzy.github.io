pipeline {
    agent any

    environment {
        IMAGE_NAME = "vanhanzy-web"
    }

    stages {
        stage('Checkout') {
            steps {
                git 'https://github.com/vanhanzy/vanhanzy.github.io.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh "docker build -t $IMAGE_NAME ."
            }
        }

        stage('Deploy to Minikube') {
            steps {
                sh "minikube image load $IMAGE_NAME"
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                sh '''
                    kubectl apply -f k8s/deployment.yaml
                    kubectl apply -f k8s/service.yaml
                '''
            }
        }
    }
}
