
FROM fedora:29
LABEL maintainer="yourname@somewhere.com"

RUN dnf -y install socat \
 && dnf clean all

VOLUME /var/run/docker.sock

# docker tcp port
EXPOSE 2375

ENTRYPOINT ["socat", "TCP-LISTEN:2375,reuseaddr,fork","UNIX-CLIENT:/var/run/docker.sock"]
