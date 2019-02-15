/*
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
        stage('Test docker daemon (always true)') {
            steps {

                catchError {
                    sh 'docker version || true'
                }
                echo currentBuild.result
            }
        }
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
*/


node {
    checkout scm

    docker.image('mysql:5').withRun('-e "MYSQL_ROOT_PASSWORD=my-secret-pw"') { c ->

        stage("Build") {
            docker.image('mysql:5').inside("--link ${c.id}:db") {
                /* Wait until mysql service is up */
                sh 'while ! mysqladmin ping -hdb --silent; do sleep 1; done'
            }
        }
        stage("Build") {
            docker.image('centos:7').inside("--link ${c.id}:db") {
                /*
                 * Run some tests which require MySQL, and assume that it is
                 * available on the host name `db`
                 */
                sh 'uname'
            }
        }
    }
}
