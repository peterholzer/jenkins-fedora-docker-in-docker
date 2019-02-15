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
        }/*
        stage('Test docker daemon (always true)') {
            steps {

                catchError {
                    sh 'docker version || true'
                }
                echo currentBuild.result
            }
        }*/
        stage('other') {
            agent {
                docker { image 'node:7-alpine' }
            }
            steps {
                sh 'node --version'
            }
        }
    }
}
