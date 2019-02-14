pipeline {
    agent { dockerfile true }
    stages {
        stage('Test') {
            steps {
                sh 'java -version'
                sh 'docker version'
            }
        }
    }
}
