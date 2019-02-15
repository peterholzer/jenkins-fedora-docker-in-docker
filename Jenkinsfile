pipeline {
    agent { dockerfile true }
    stages {
        stage('Check java availability') {
            steps {
                sh 'java -version'
            }
        }
        stage('Test docker client') {
            steps {
                sh 'docker -v'
            }
        }
        stage('Test docker daemon') {
            steps {

            catchError {
                build job: 'system-check-flow'
            }
            echo currentBuild.result
                sh 'docker version || true'
            }
        }
    }
}
