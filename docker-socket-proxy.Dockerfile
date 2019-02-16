# https://engineering.riotgames.com/news/jenkins-ephemeral-docker-tutorial
# https://github.com/maxfields2000/dockerjenkins_tutorial/blob/master/tutorial_07/docker-proxy/Dockerfile
FROM fedora:29

LABEL maintainer="Peter Holzer spam@h0lzer.com"
LABEL description="Exposes docker tcp socket without configuring the daemon."

RUN dnf -y install socat \
 && dnf clean all \
 && rm -rf /var/cache/yum/*

VOLUME /var/run/docker.sock

EXPOSE 2375

ENTRYPOINT ["socat", "TCP-LISTEN:2375,reuseaddr,fork","UNIX-CLIENT:/var/run/docker.sock"]
