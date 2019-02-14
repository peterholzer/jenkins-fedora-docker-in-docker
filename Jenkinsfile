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
                sh 'DOCKER_HOST=tcp://proxy1:2375 docker version'
            }
        }
    }
}
