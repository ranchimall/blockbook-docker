FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

# RUN echo "supervisor supervisor/daemon_enable boolean true" | debconf-set-selections

COPY peers.dat /tmp
COPY backend-flo-testnet_0.15.1.1-satoshilabs-1_amd64.deb /tmp/backend-flo.deb
COPY blockbook-flo-testnet_0.4.0_amd64.deb /tmp/blockbook-flo.deb
COPY supervisord.conf /tmp/supervisord.conf

RUN apt-get update && \
    apt-get install -y /tmp/backend-flo.deb /tmp/blockbook-flo.deb supervisor && \
    # apt-get -y supervisor && \
    rm /tmp/backend-flo.deb /tmp/blockbook-flo.deb

RUN cd /opt/coins/nodes/flo_testnet && \
    /opt/coins/nodes/flo_testnet/bin/flod --testnet -datadir=/opt/coins/data/flo_testnet/backend -conf=/opt/coins/nodes/flo_testnet/flo_testnet.conf -pid=/run/flo_testnet/flo_testnet.pid && \
    pkill flod

RUN mv /tmp/peers.dat /opt/coins/data/flo_testnet/backend/testnet4/peers.dat

EXPOSE 19166

VOLUME /opt/coins

CMD ["/usr/bin/supervisord", "-c", "/tmp/supervisord.conf"]
# CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/supervisord.conf"]
