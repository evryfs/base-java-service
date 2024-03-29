FROM quay.io/evryfs/base-java:master-20221209
LABEL maintainer "David J. M. Karlsen <david@davidkarlsen.com>"
ENV DEFAULT_JAVA_OPTIONS="-XX:+HeapDumpOnOutOfMemoryError -XX:InitialRAMPercentage=50.0 -XX:MinRAMPercentage=50.0 -XX:MaxRAMPercentage=75.0 -server -XshowSettings:vm -XX:HeapDumpPath=/tmp"
SHELL ["/bin/bash", "-o", "pipefail", "-c"]
RUN apt-get update && \
    apt-get -y --no-install-recommends install gosu && \
    apt-get clean && \
    useradd -c "application user" -d /app -s /bin/bash -m app -u 99 --system && \
    chmod o+rx /app && \
    rm -rf /var/cache/apt /var/lib/apt/lists/* /tmp/* /var/tmp/*
COPY entrypoint.sh /
WORKDIR /app
ENTRYPOINT ["/bin/bash", "/entrypoint.sh"]
