FROM quay.io/evryfs/base-java:java8-20200323
LABEL maintainer "David J. M. Karlsen <david@davidkarlsen.com>"
ARG OVERMIND_VERSION=v2.1.1
ENV OVERMIND_SOCKET=/tmp/.overmind.sock
SHELL ["/bin/bash", "-o", "pipefail", "-c"]
RUN apt-get update && \
    apt-get -y --no-install-recommends install daemontools git gosu tmux && \
    apt-get clean && \
    curl --silent -L https://github.com/DarthSim/overmind/releases/download/${OVERMIND_VERSION}/overmind-${OVERMIND_VERSION}-linux-amd64.gz | zcat > /usr/local/bin/overmind && \
    chmod a+x /usr/local/bin/overmind && \
    useradd -c "application user" -d /app -s /bin/bash -m app -u 99 --system && \
    rm -rf /var/cache/apt /var/lib/apt/lists/* /tmp/* /var/tmp/*
COPY entrypoint.sh /
ENTRYPOINT ["/bin/bash", "/entrypoint.sh"]
