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

    stage("Build jenkins image") {
        def customImage1 = docker.build("jenkins:${env.BUILD_ID}")

    }
    stage("Build docker-socket-proxy image") {
        def customImage = docker.build("docker-socket-proxy:${env.BUILD_ID}", "-f docker-socket-proxy.Dockerfile .")
    }
    // stage("Setup mysql") {
        docker.image('mysql:5').withRun('-e "MYSQL_ROOT_PASSWORD=my-secret-pw"') { c ->

            // stage("Run mysql") {
                docker.image('mysql:5').inside("--link ${c.id}:db") {
                    /* Wait until mysql service is up */
                    sh 'while ! mysqladmin ping -hdb --silent; do sleep 1; done'
                }
            // }
            // stage("Run centos") {
                docker.image('centos:7').inside("--link ${c.id}:db") {
                    /*
                     * Run some tests which require MySQL, and assume that it is
                     * available on the host name `db`
                     */
                    sh 'uname'
                }
            // }
            /*stage("Run custom") {
                def customImage = docker.build("docker-socket-proxy:${env.BUILD_ID}", "-f docker-socket-proxy.Dockerfile .")
                customImage.inside() {
                    /*
                     * Run some tests which require MySQL, and assume that it is
                     * available on the host name `db`
                     */
                    sh 'uname'
                }
            }*/
        }
    // }
}
