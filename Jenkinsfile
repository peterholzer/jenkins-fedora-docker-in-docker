
node {
    checkout scm

    def jenkins_img
    def proxy_img

    stage("Build jenkins image") {
        jenkins_img = docker.build("jenkins:${env.BUILD_ID}")

    }

    stage("Build docker-socket-proxy image") {
        proxy_img = docker.build("docker-socket-proxy:${env.BUILD_ID}", "-f docker-socket-proxy.Dockerfile .")
    }

    stage("Setup tests") {
        proxy_img.withRun('-v /var/run/docker.sock:/var/run/docker.sock') { prx ->
            jenkins_img.inside("-e DOCKER_HOST=tcp://proxy1 --link ${prx.id}:proxy1") {
                sh 'uname'
                sh 'java -version'

                stage("Test docker client binary") {
                    sh 'docker -v'
                }

                stage("Test docker daemon connection") {
                    sh 'docker version'
                }
            }
        }
    }
}

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
    }
}
*/
