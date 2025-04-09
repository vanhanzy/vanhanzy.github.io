pipeline {
    agent {
        docker {
            image 'docker:latest'
            args '-v /var/run/docker.sock:/var/run/docker.sock'
        }
    }

    environment {
        IMAGE_NAME = "vanhanzy-web"
    }

    stages {
        stage('Probar Docker') {
            steps {
                sh 'docker version'
                sh 'docker ps'
            }
        }

        stage('Build Imagen Docker') {
            steps {
                sh 'docker build -t $IMAGE_NAME .'
            }
        }

        stage('Subir Imagen a Minikube') {
            steps {
                sh 'minikube image load $IMAGE_NAME'
            }
        }

        stage('Desplegar en Kubernetes') {
            steps {
                sh 'kubectl rollout restart deployment vanhanzy'
            }
        }
    }
}
