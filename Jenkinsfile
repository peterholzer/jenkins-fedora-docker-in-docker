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

    def jenkins_img
    def proxy_img

    stage("Build jenkins image") {
        jenkins_img = docker.build("jenkins:${env.BUILD_ID}")

    }
    stage("Build docker-socket-proxy image") {
        proxy_img = docker.build("docker-socket-proxy:${env.BUILD_ID}", "-f docker-socket-proxy.Dockerfile .")
    }/*
    stage("Setup mysql") {
        docker.image('mysql:5').withRun('-e "MYSQL_ROOT_PASSWORD=my-secret-pw"') { c ->

            // stage("Run mysql") {
                docker.image('mysql:5').inside("--link ${c.id}:db") {
                    // Wait until mysql service is up
                    sh 'while ! mysqladmin ping -hdb --silent; do sleep 1; done'
                }
            // }
            // stage("Run centos") {
                docker.image('centos:7').inside("--link ${c.id}:db") {
                    sh 'uname'
                }
            // }
        }
    }*/
    stage("Check Jenkins image Java") {
        jenkins_img.inside() {
            sh 'uname'
            sh 'java -version'
        }
    }
    stage("check Proxy image docker") {
        // proxy_img.inside() {
        // proxy_img.inside('-v /var/run/docker.sock:/var/run/docker.sock') {
            // sh 'uname'
            // sh 'docker -v'
            // sh 'docker version'
        // }
    }
    stage("Run custom") {
        proxy_img.withRun('-v /var/run/docker.sock:/var/run/docker.sock') { d ->
            // proxy_img.run()
            jenkins_img.inside("-e DOCKER_HOST=tcp://proxy --link ${d.id}:proxy") {
                sh 'uname'
                sh 'java -version'
                sh 'docker -v'
                sh 'docker version'
            }
            // d.stop()
        }
    }
}
