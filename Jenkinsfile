pipeline {
    agent any

    environment {
        IMAGE_NAME = "vanhanzy-web"
    }

    stages {
        stage('Prepare Minikube Docker Env') {
            steps {
                script {
                    // Exporta manualmente las variables necesarias
                    sh '''
                        eval $(minikube -p minikube docker-env --shell bash)
                        echo $DOCKER_HOST
                    '''
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    sh 'docker build -t $IMAGE_NAME .'
                }
            }
        }

        stage('Load Image into Minikube') {
            steps {
                script {
                    sh 'minikube image load $IMAGE_NAME'
                }
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                script {
                    sh 'kubectl apply -f k8s/deployment.yaml'
                    sh 'kubectl apply -f k8s/service.yaml'
                }
            }
        }
    }
}
