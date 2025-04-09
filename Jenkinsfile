pipeline {
    agent any

    environment {
        IMAGE_NAME = "vanhanzy-web"
    }

    stages {
        stage('Clonar Repo') {
            steps {
                git 'https://github.com/vanhanzy/vanhanzy.github.io.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    sh 'docker build -t $IMAGE_NAME .'
                }
            }
        }

        stage('Cargar imagen a Minikube') {
            steps {
                script {
                    sh "minikube image load $IMAGE_NAME"
                }
            }
        }

        stage('Rollout en Kubernetes') {
            steps {
                script {
                    sh 'kubectl rollout restart deployment vanhanzy'
                }
            }
        }
    }
}
