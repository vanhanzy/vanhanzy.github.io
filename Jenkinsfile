pipeline {
    agent {
        docker {
            image 'docker:20.10-dind'
            args '-v /var/run/docker.sock:/var/run/docker.sock'
        }
    }

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
                sh 'docker version'  // Verifica que Docker esté disponible
                sh 'docker build -t $IMAGE_NAME .'  // Construye la imagen Docker
            }
        }

        stage('Cargar Imagen a Minikube') {
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
