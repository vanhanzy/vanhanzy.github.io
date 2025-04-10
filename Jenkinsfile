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
                script {
                    sh '''
                        eval $(minikube -p minikube docker-env)
                        docker build -t $IMAGE_NAME .
                    '''
                }
            }
        }

        stage('Deploy to Minikube') {
            steps {
                script {
                    sh '''
                        eval $(minikube -p minikube docker-env)
                        minikube image load $IMAGE_NAME
                    '''
                }
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                script {
                    sh '''
                        kubectl apply -f k8s/deployment.yaml
                        kubectl apply -f k8s/service.yaml
                    '''
                }
            }
        }
    }
}
