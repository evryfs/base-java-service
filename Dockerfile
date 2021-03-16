FROM quay.io/evryfs/base-java:java16-20210316
LABEL maintainer "David J. M. Karlsen <david@davidkarlsen.com>"
ARG OVERMIND_VERSION=v2.2.1
ENV OVERMIND_SOCKET=/tmp/.overmind.sock
ENV DEFAULT_JAVA_OPTIONS="-XX:+HeapDumpOnOutOfMemoryError -XX:InitialRAMPercentage=50.0 -XX:MinRAMPercentage=50.0 -XX:MaxRAMPercentage=75.0 -server -XshowSettings:vm -XX:HeapDumpPath=/tmp"
SHELL ["/bin/bash", "-o", "pipefail", "-c"]
RUN apt-get update && \
    apt-get -y --no-install-recommends install daemontools gosu tmux && \
    apt-get clean && \
    curl --silent -L https://github.com/DarthSim/overmind/releases/download/${OVERMIND_VERSION}/overmind-${OVERMIND_VERSION}-linux-amd64.gz | zcat > /usr/local/bin/overmind && \
    chmod a+x /usr/local/bin/overmind && \
    useradd -c "application user" -d /app -s /bin/bash -m app -u 99 --system && \
    rm -rf /var/cache/apt /var/lib/apt/lists/* /tmp/* /var/tmp/*
COPY entrypoint.sh /
WORKDIR /app
ENTRYPOINT ["/bin/bash", "/entrypoint.sh"]
