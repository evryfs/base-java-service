FROM davidkarlsen/docker-java:11.0.0
LABEL maintainer "David J. M. Karlsen <david@davidkarlsen.com>"
ARG HEROKUISH_VERSION=0.4.4
ARG ENVCONSUL_VERSION=0.7.3
RUN apt update && \
    apt -y install curl daemontools git gosu vim net-tools nmap netcat iputils-ping unzip && \
    apt clean && \
    curl --silent -L https://github.com/gliderlabs/herokuish/releases/download/v${HEROKUISH_VERSION}/herokuish_${HEROKUISH_VERSION}_linux_x86_64.tgz | tar -xzvC /usr/local/bin && \
    wget https://releases.hashicorp.com/envconsul/${ENVCONSUL_VERSION}/envconsul_${ENVCONSUL_VERSION}_linux_amd64.zip -O - |funzip > /usr/local/bin/envconsul && \
    chmod a+x /usr/local/bin/envconsul && \
    useradd -c "application user" -d /app -s /bin/bash -m app && \
    find /var/cache/ -type f -delete
COPY entrypoint.sh /
ENTRYPOINT ["/bin/bash", "/entrypoint.sh"]
