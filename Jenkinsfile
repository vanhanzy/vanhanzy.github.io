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
                    args '-v /var/run/docker.sock:/var/run/docker.sock'
                }
            }
            steps {
                sh 'docker build -t $IMAGE_NAME .'
                sh 'minikube image load $IMAGE_NAME'
                sh 'kubectl rollout restart deployment vanhanzy'
            }
        }
    }
}
