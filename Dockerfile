FROM evryfs/docker-java:java8
LABEL maintainer "David J. M. Karlsen <david@davidkarlsen.com>"
ARG OVERMIND_VERSION=v2.0.3
ENV OVERMIND_SOCKET=/tmp/.overmind.sock
RUN apt update && \
    apt -y install daemontools git gosu tmux && \
    apt clean && \
    curl --silent -L https://github.com/DarthSim/overmind/releases/download/${OVERMIND_VERSION}/overmind-${OVERMIND_VERSION}-linux-amd64.gz | zcat > /usr/local/bin/overmind && \
    chmod a+x /usr/local/bin/overmind && \
    useradd -c "application user" -d /app -s /bin/bash -m app -u 99 --system && \
    find /var/cache/ -type f -delete
COPY entrypoint.sh /
ENTRYPOINT ["/bin/bash", "/entrypoint.sh"]
