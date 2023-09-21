# Use a base image
FROM nestybox/ubuntu-focal-systemd-docker

# Install necessary packages
RUN apt update && \
    apt install -y wget gnupg2 software-properties-common unzip

# Download deb files based on the TESTNET environment variable
ARG TESTNET=false

# If TESTNET is true, download testnet deb files; otherwise, download mainnet deb files
RUN if [ "$TESTNET" = "true" ]; then \
        wget https://github.com/ranchimall/blockbook-docker/archive/testnet.zip && unzip testnet.zip && \
        cd blockbook-docker-testnet && sudo apt install -y ./dind_backend-flo_0.15.1.1-satoshilabs-1_amd64.deb && sudo apt install -y ./dind_blockbook-flo_0.4.0_amd64.deb; \
    else \
        wget https://github.com/ranchimall/blockbook-docker/archive/main.zip && unzip main.zip && \
        cd blockbook-docker-main && sudo apt install -y ./dind_backend-flo_0.15.1.1-satoshilabs-1_amd64.deb && sudo apt install -y ./dind_blockbook-flo_0.4.0_amd64.deb; \
    fi

# Expose ports
EXPOSE 22 80 9166

# Start your applications (Uncomment and replace with your application start commands)
CMD ["/lib/systemd/systemd"]
