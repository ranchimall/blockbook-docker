FROM ubuntu:22.04

# Backend
COPY ./deb-files/backend-flo-testnet_0.15.1.1-satoshilabs-1_amd64.deb /opt/testnet-backend.deb
COPY ./deb-files/blockbook-flo-testnet_0.4.0_amd64.deb /opt/testnet-blockbook.deb

RUN apt update && apt install -y /opt/testnet-backend.deb /opt/testnet-blockbook.deb curl && \
    sed -i 's/daemon=1/daemon=0/' /opt/coins/nodes/flo_testnet/flo_testnet.conf && \
    sed -i '/rpcport=18066/a rpcallowip=0.0.0.0/0' /opt/coins/nodes/flo_testnet/flo_testnet.conf && \
    echo "addnode=ramanujam.ranchimall.net" >> /opt/coins/nodes/flo_testnet/flo_testnet.conf && \
    echo "addnode=turing.ranchimall.net" >> /opt/coins/nodes/flo_testnet/flo_testnet.conf && \
    echo "addnode=stevejobs.ranchimall.net" >> /opt/coins/nodes/flo_testnet/flo_testnet.conf && \
    echo "addnode=brahmagupta.ranchimall.net" >> /opt/coins/nodes/flo_testnet/flo_testnet.conf && \
    echo "addnode=feynman.ranchimall.net" >> /opt/coins/nodes/flo_testnet/flo_testnet.conf

WORKDIR /opt/coins/blockbook/flo_testnet

# Execution
COPY ./entrypoint.sh /opt/entrypoint.sh
RUN chmod +x /opt/entrypoint.sh
ENTRYPOINT ["/opt/entrypoint.sh"]
