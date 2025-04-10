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

        stage('Prepare Minikube Docker Env') {
            steps {
                script {
                    def envVars = sh(
                        script: "minikube -p minikube docker-env --shell bash",
                        returnStdout: true
                    ).trim()

                    envVars.split('\n').each {
                        def matcher = it =~ /export (.+?)="(.+?)"/
                        if (matcher.matches()) {
                            env[matcher[0][1]] = matcher[0][2]
                        }
                    }
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t $IMAGE_NAME .'
            }
        }

        stage('Deploy to Minikube') {
            steps {
                sh "minikube image load $IMAGE_NAME"
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                sh 'kubectl apply -f k8s/deployment.yaml'
                sh 'kubectl apply -f k8s/service.yaml'
            }
        }
    }
}
