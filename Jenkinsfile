pipeline {
    agent { dockerfile true }
    stages {
        stage('Check java availability') {
            steps {
                sh 'java -version'
            }
        }
        stage('Test docker') {
            steps {
                sh 'DOCKER_HOST= docker version'
            }
        }
    }
}
