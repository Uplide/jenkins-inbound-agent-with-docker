pipeline {
    agent {
        label 'docker-agent'
    }
    environment {
        DOCKER_REPO = "docker.uplide.com/repository/uplide-docker/jenkins-inbound-agent-with-docker"
        DOCKER_CREDENTIALS_ID = "nexus"
        GITHUB_CREDENTIALS_ID = 'github'
    }
    stages {
        stage('BUILD') {
            steps {
                script {
                   docker.build("${env.DOCKER_REPO}:${env.BUILD_ID}")
                }
            }
        }
        stage('TAG') {
            steps {
                sh "docker tag ${env.DOCKER_REPO}:${env.BUILD_ID} ${env.DOCKER_REPO}:latest"
            }
        }
        stage('PUSH') {
            steps {
                script {
                    docker.withRegistry("http://${env.DOCKER_REPO}", "${env.DOCKER_CREDENTIALS_ID}") {
                        docker.image("${env.DOCKER_REPO}:latest").push()
                    }
                }
            }
        }
    }
    post {
        always {
            cleanWs()
        }
    }
}
