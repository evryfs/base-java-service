FROM davidkarlsen/docker-java:8u181
LABEL maintainer "David J. M. Karlsen <david@davidkarlsen.com>"
ARG OVERMIND_VERSION=v1.2.1
ENV OVERMIND_SOCKET=/tmp/.overmind.sock
RUN apt update && \
    apt -y install curl daemontools git gosu vim net-tools nmap netcat iputils-ping tmux unzip gzip && \
    apt clean && \
    curl --silent -L https://github.com/DarthSim/overmind/releases/download/${OVERMIND_VERSION}/overmind-${OVERMIND_VERSION}-linux-amd64.gz | zcat > /usr/local/bin/overmind && \
    chmod a+x /usr/local/bin/overmind && \
    useradd -c "application user" -d /app -s /bin/bash -m app && \
    find /var/cache/ -type f -delete
COPY entrypoint.sh /
ENTRYPOINT ["/bin/bash", "/entrypoint.sh"]
