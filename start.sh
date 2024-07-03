#!/bin/bash

DOWNLOAD_DIR="/tmp"
EXTRACT_DIR="/opt/coins"
ZIP_FILE="${DOWNLOAD_DIR}/data.tar.gz"
SUPERVISOR_CONF="/etc/supervisor/supervisord.conf"

mkdir -p ${DOWNLOAD_DIR}

start_supervisor() {
    echo "Starting Supervisor..."
    /usr/bin/supervisord -c ${SUPERVISOR_CONF}
}
#setting the zip url to mainnet or testnet (bootstrap)
if [ "${NETWORK}" = "testnet" ]; then
    ZIP_URL="${TESTNET_ZIP_URL}"
elif [ "${NETWORK}" = "mainnet" ]; then
    ZIP_URL="${MAINNET_ZIP_URL}"
else
    echo "Invalid or missing NETWORK variable. Please set NETWORK to 'testnet' or 'mainnet'."
    exit 1
fi

#to download bootstrap or not.
if [ "${ZIP}" = "true" ]; then
    echo "Downloading ${ZIP_URL}..."
    wget -q --show-progress ${ZIP_URL} -O ${ZIP_FILE}

    if [ $? -ne 0 ]; then
        echo "Failed to download the zip file."
        exit 1
    fi

    echo "Extracting ${ZIP_FILE} to ${EXTRACT_DIR}..."
    tar -xzf ${ZIP_FILE} -C ${EXTRACT_DIR}

    if [ $? -ne 0 ]; then
        echo "Failed to extract the zip file."
        exit 1
    fi

    rm ${ZIP_FILE}
else
    echo "Skipping download and extraction of the zip file."
fi

start_supervisor
