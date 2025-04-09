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

        stage('Build & Deploy') {
            agent {
                docker {
                    image 'docker:latest'
                    args '-v /var/run/docker.sock:/var/run/docker.sock -v $HOME:$HOME'
                }
            }
            steps {
                sh 'docker version' // ✅ Verifica que sí existe docker
                sh 'docker build -t $IMAGE_NAME .'
                sh "minikube image load $IMAGE_NAME"
                sh "kubectl rollout restart deployment vanhanzy"
            }
        }
    }
}
