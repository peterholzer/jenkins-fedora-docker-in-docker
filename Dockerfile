FROM fedora:29

LABEL "maintainer"="Peter Holzer spam@h0lzer.com"
LABEL "description"="Jenkins with docker client on Fedora 29"

# Add repositories for jenkins and docker-ce
ADD http://pkg.jenkins-ci.org/redhat/jenkins.repo           /etc/yum.repos.d/jenkins.repo
ADD https://download.docker.com/linux/fedora/docker-ce.repo /etc/yum.repos.d/docker-ce.repo
# install jenkins and docker-ce client
RUN rpm --import http://pkg.jenkins-ci.org/redhat/jenkins-ci.org.key \
 && yum update -y \
 && yum install -y jenkins java unzip findutils docker-ce-cli \
 && yum clean all \
 && rm -rf /var/yum/cache/*

# Add scripts from git repo of the original Jenkins docker image
ADD https://raw.githubusercontent.com/jenkinsci/docker/master/install-plugins.sh /usr/local/bin/install-plugins.sh
ADD https://raw.githubusercontent.com/jenkinsci/docker/master/jenkins-support    /usr/local/bin/jenkins-support
RUN chmod 755 /usr/local/bin/*

USER jenkins
ENV JENKINS_HOME=/var/lib/jenkins/
# ENV JENKINS_HOME=/var/jenkins_home
ENV REF=${JENKINS_HOME}/plugins/
ENV JENKINS_UC https://updates.jenkins.io
ENV JENKINS_UC_DOWNLOAD=http://mirrors.jenkins-ci.org
ENV JENKINS_UC_EXPERIMENTAL=https://updates.jenkins.io/experimental
# ENV JENKINS_INCREMENTALS_REPO_MIRROR=https://repo.jenkins-ci.org/incrementals


# Install plugins
RUN install-plugins.sh \
    build-timeout:latest \
    cloudbees-folder:latest \
    dashboard-view:latest \
    git:latest \
    git-changelog:latest \
    workflow-aggregator:latest \
    pipeline-stage-view:latest \
    ssh-slaves:latest \
    timestamper:latest \
    ws-cleanup:latest

VOLUME ${JENKINS_HOME}

# COPY ./entrypoint.sh /entrypoint.sh

EXPOSE 8080

# USER root

# CMD ["/entrypoint.sh"]

ENV JENKINS_OPTS="--logfile=/dev/stdout --httpPort=8080 --debug=5 --handlerCountMax=100 --handlerCountMaxIdle=20"
ENV JAVA_OPTS="-Djava.awt.headless=true -DJENKINS_HOME=${JENKINS_HOME}"
# } -Djenkins.install.runSetupWizard=false

# DOCKER_OPTS="-H tcp://0.0.0.0:2376 -H unix:///var/run/docker.sock"
# ENV DOCKER_HOST="tcp://proxy1:2375"

CMD /usr/bin/java \
    ${JAVA_OPTS} \
    -jar /usr/lib/jenkins/jenkins.war \
    ${JENKINS_OPTS}

# --webroot=/var/cache/jenkins/war
# docker run -it jenkins bash
# docker run jenkins install-plugins.sh fancy-plugin:latest
