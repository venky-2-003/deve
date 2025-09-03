pipeline {
    agent any

    environment {
        DOCKER_IMAGE = "lavetivenkatesh/custom-app"
        DOCKER_TAG = "latest"
        CONTAINER_NAME = "custom-container"
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/venky-2-003/deve.git'
            }
        }

        stage('Build Jar') {
            steps {
                script {
                    sh "mvn clean package -DskipTests"
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    sh "docker build -t ${DOCKER_IMAGE}:${DOCKER_TAG} ."
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                script {
                    withCredentials([usernamePassword(credentialsId: 'dockerhub-creds', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                        sh "echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin"
                        sh "docker push ${DOCKER_IMAGE}:${DOCKER_TAG}"
                    }
                }
            }
        }

        stage('Run Container') {
            steps {
                script {
                    sh "docker rm -f ${CONTAINER_NAME} || true"
                    sh "docker run -d --name ${CONTAINER_NAME} -p 8066:8080 ${DOCKER_IMAGE}:${DOCKER_TAG}"
                }
            }
        }
    }
}
