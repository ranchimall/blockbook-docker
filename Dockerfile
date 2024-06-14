FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

# Copying files to the container
COPY /deb-files-mainnet/supervisord.conf /tmp
COPY /deb-files-mainnet/backend-flo_0.15.1.1-satoshilabs-1_amd64.deb /tmp/backend-flo.deb
COPY /deb-files-mainnet/blockbook-flo_0.4.0_amd64.deb /tmp/blockbook-flo.deb

# Installing Blockbook and Supervisor
RUN apt-get update && \
    apt-get install -y /tmp/backend-flo.deb /tmp/blockbook-flo.deb supervisor && \
    rm /tmp/backend-flo.deb /tmp/blockbook-flo.deb && \
    rm -rf /var/lib/apt/lists/*

# Configuring backend as forground process under supervisord
RUN sed -i "s/daemon=1/daemon=0/g" /opt/coins/nodes/flo/flo.conf
    
EXPOSE 9166

VOLUME /opt/coins

CMD ["/usr/bin/supervisord", "-c", "/tmp/supervisord.conf"]

# check logs 
# tail -f /opt/coins/data/flo/backend/debug.log
# tail -f /opt/coins/blockbook/flo/logs/blockbook.INFO
