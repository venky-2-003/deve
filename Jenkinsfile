pipeline {
    agent any

    environment {
        DOCKER_IMAGE = "lavetivenkatesh/custom-app"
        DOCKER_TAG = "latest"
        CONTAINER_NAME = "custom-container"
        DOCKER_CREDENTIALS = "dockerhub-creds"
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/venky-2-003/deve.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    docker.build("${DOCKER_IMAGE}:${DOCKER_TAG}")
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                script {
                    docker.withRegistry('', "${DOCKER_CREDENTIALS}") {
                        docker.image("${DOCKER_IMAGE}:${DOCKER_TAG}").push()
                    }
                }
            }
        }

        stage('Run Container') {
            steps {
                sh """
                    docker rm -f ${CONTAINER_NAME} || true
                    docker run -d --name ${CONTAINER_NAME} -p 8066:80 ${DOCKER_IMAGE}:${DOCKER_TAG}
                """
            }
        }
    }
}

