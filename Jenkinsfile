pipeline {
    agent { dockerfile true }
    stages {
        stage('Test java') {
            steps {
                sh 'java -version'
            }
        }
        stage('Test docker') {
            steps {
                sh 'docker version || true'
            }
        }
    }
}
