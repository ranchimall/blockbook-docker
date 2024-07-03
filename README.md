# Blockbook Docker (Single Container)

This guide will help you build and run the Docker image for Blockbook Mainnet and Testnet, which is based on Ubuntu 22.04 and includes both backend and frontend components in a single container.

## Prerequisites

- [Docker installed on your machine](https://docs.docker.com/engine/install/).
- Clone or download the repository to your local machine.

---

# Mainnet

Steps to build the Docker image for Mainnet.

- **Building the Docker Image**

    Navigate to the directory where the repository is cloned and build the Docker image:

    ```sh
    git clone https://github.com/ranchimall/blockbook-docker
    cd blockbook-docker
    docker build -f Dockerfile -t ranchimall/blockbook-mainnet:1.0.0 .
    ```

- **Running the Docker Container**

    Create a named volume for persistent storage:

    ```sh
    docker volume create mainnet
    ```

    Run the Docker container in detached mode and map port `9166` of the container to port `9166` (or any other port) on the host machine (`-p host-port:container-port`):

    ```sh
    docker run -d -e ZIP=false -e NETWORK=mainnet --name blockbook-mainnet -p 9166:9166 --mount source=mainnet,target=/opt/coins ranchimall/blockbook-mainnet:1.0.0
    ```

- **Accessing the Frontend**

    Once the Docker container is running, you can access the frontend of the application by navigating to: [https://localhost:9166](https://localhost:9166) in your web browser.

- **Accessing Logs**

    To check the logs, you can access the container shell and use the `tail` command:

    ```sh
    docker exec -it blockbook-mainnet bash
    ```

    To view the logs of the backend and frontend, run:

    ```sh
    # Backend logs
    tail -f /opt/coins/data/flo/backend/debug.log

    # Frontend logs
    tail -f /opt/coins/blockbook/flo/logs/blockbook.INFO
    ```

---

# Testnet

Steps to build the Docker image for Testnet.

- **Building the Docker Image**

    Navigate to the directory where the repository is cloned or downloaded and build the Docker image:

    ```sh
    cd blockbook-docker
    docker build -f Dockerfile-testnet -t ranchimall/blockbook-testnet:1.0.0 .
    ```

- **Running the Docker Container**

    Create a named volume for persistent storage:

    ```sh
    docker volume create testnet
    ```

    Run the Docker container in detached mode and map port `19166` of the container to port `19166` (or any other port) on the host machine (`-p host-port:container-port`):

    ```sh
    docker run -d -e ZIP=false -e NETWORK=testnet --name blockbook-testnet -p 19166:19166 --mount source=testnet,target=/opt/coins ranchimall/blockbook-testnet:1.0.0
    ```

- **Accessing the Frontend**

    Once the Docker container is running, you can access the frontend of the application by navigating to: [https://localhost:19166](https://localhost:19166) in your web browser.

- **Accessing Logs**

    To check the logs, you can access the container shell and use the `tail` command:

    ```sh
    docker exec -it blockbook-testnet bash
    ```

    To view the logs of the backend and frontend, run:

    ```sh
    # Backend logs
    tail -f /opt/coins/data/flo_testnet/backend/testnet4/debug.log

    # Frontend logs
    tail -f /opt/coins/blockbook/flo_testnet/logs/blockbook.INFO
    ```

## Environment Variables

Blockbook uses environment variables to allow for configuration settings. You set the environment variables in your Docker run startup command. Here are the config settings offered by this image:

- NETWORK: [mainnet|testnet] The FLO network you wish to run the Blockbook on.
- ZIP: [true|false] To download the bootstrap data or not to speed up the syncing of blocks, which will be reflected in Blockbook.
- TESTNET_ZIP_URL: The URL for Testnet to download the zip for bootstrapping Blockbook (Testnet).
- MAINNET_ZIP_URL: The URL for Mainnet to download the zip for bootstrapping Blockbook (Mainnet).

You can use the `--env-file` flag to pass these environments through a file during runtime. Create a `.env` file in the same directory as your project, using the `.env.example` file as a guide. Then, run your app with the following command to load the environment variables from the file:
```sh
#to run mainnet add mainnet Environment Variables.
docker run -d --env-file .env --name blockbook-mainnet -p 9166:9166 --mount source=mainnet,target=/opt/coins ranchimall/blockbook-mainnet:1.0.0

#to run testnet add testnet Environment Variables.
docker run -d --env-file .env -name blockbook-testnet -p 19166:19166 --mount source=testnet,target=/opt/coins ranchimall/blockbook-testnet:1.0.0
```

## Additional Commands

- **Stopping the Docker Container:**

    To stop the container, use:

    ```sh
    docker stop <containername>
    ```

- **Removing the Docker Container:**

    To remove the container, use:

    ```sh
    docker rm <containername>
    ```

- **Removing the Docker Image:**

    To remove the image, use:

    ```sh
    docker rmi <imagename>
    ```

Replace `<imagename>` and `<containername>` with the actual image name and container name or ID, respectively.

## Troubleshooting

- Ensure that no other application is using port `9166` or `19166` on your host machine.
- If you encounter issues, check the Docker container logs:

    ```sh
    docker logs <containername>
    ```