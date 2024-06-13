FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

COPY peers.dat /tmp
COPY supervisord.conf /tmp

COPY backend-flo-testnet_0.15.1.1-satoshilabs-1_amd64.deb /tmp/backend-flo.deb
COPY blockbook-flo-testnet_0.4.0_amd64.deb /tmp/blockbook-flo.deb

RUN apt-get update && \
    apt-get install -y /tmp/backend-flo.deb /tmp/blockbook-flo.deb supervisor && \
    rm /tmp/backend-flo.deb /tmp/blockbook-flo.deb

RUN sed -i "s/daemon=1/daemon=0/g" /opt/coins/nodes/flo_testnet/flo_testnet.conf
RUN sed -i '$a addnode=ramanujam.ranchimall.net\naddnode=turing.ranchimall.net\naddnode=stevejobs.ranchimall.net\naddnode=brahmagupta.ranchimall.net\naddnode=feynman.ranchimall.net' /opt/coins/nodes/flo_testnet/flo_testnet.conf

# RUN cd /opt/coins/nodes/flo_testnet && \
#     /opt/coins/nodes/flo_testnet/bin/flod --testnet -datadir=/opt/coins/data/flo_testnet/backend -conf=/opt/coins/nodes/flo_testnet/flo_testnet.conf -pid=/run/flo_testnet/flo_testnet.pid

# RUN mv /tmp/peers.dat /opt/coins/data/flo_testnet/backend/testnet4/peers.dat

EXPOSE 19166

VOLUME /opt/coins

CMD ["/usr/bin/supervisord", "-c", "/tmp/supervisord.conf"]
