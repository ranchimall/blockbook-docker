# Blockbook Docker (Single Container)

This guide will help you build and run the Docker image for Blockbook Mainnet and Testnet, which is based on Ubuntu 22.04 and includes both backend and frontend components in a single container.

## Prerequisites

-   [Docker installed on your machine](https://docs.docker.com/engine/install/).
-   Clone or download the repository to your local machine.

---

# Mainnet

Steps to build the Docker image for mainnet.

-   **Building the Docker Image**

    Navigate to the directory where the repository is cloned or downloaded and build the Docker image:

    ```sh
    cd <path/to/cloned/repository>
    docker build -t asif158/mainnet:1.0.0 .
    ```

-   **Running the Docker Container**

    Create a named volume for persistent storage using:

    ```sh
    docker volume create mainnet
    ```

    Run the Docker container in detached mode and for mainnet map port `9166` on your host to port `9166` on the container:

    ```sh
    docker run -d --name blockbook-mainnet -p 9166:9166 --mount source=mainnet,target=/opt/coins asif158/mainnet:1.0.0

    ```

-   **Accessing the Frontend**

    Once the Docker container is running, you can access the frontend of the application by navigating to:

    `https://localhost:9166`

    in your web browser.

-   **Accessing Logs**

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

-   **Building the Docker Image**

    Navigate to the directory where the repository is cloned or downloaded and build the Docker image:

    ```sh
    cd <path/to/cloned/repository>
    docker build -f Dockerfile-testnet -t asif158/testnet:1.0.0 .
    ```

-   **Running the Docker Container**

    Create a named volume for persistent storage using:

    ```sh
    docker volume create testnet
    ```

    Run the Docker container in detached mode and for Testnet map port `19166` on your host to port `19166` on the container:

    ```sh
    docker run -d --name blockbook-testnet -p 19166:19166 --mount source=testnet,target=/opt/coins asif158/testnet:1.0.0
    ```

-   **Accessing the Frontend**

    Once the Docker container is running, you can access the frontend of the application by navigating to:

    `https://localhost:19166`

    in your web browser.

-   **Accessing Logs**

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

## Additional Commands

-   **Stopping the Docker Container:**

    To stop the container, use:

    ```sh
    docker stop <containername>
    ```

-   **Removing the Docker Container:**

    To remove the container, use:

    ```sh
    docker rm <containername>
    ```

-   **Removing the Docker Image:**

    To remove the image, use:

    ```sh
    docker rmi <imagename>
    ```

Replace `<path/to/cloned/repository>`, `<imagename>`, and `<containername>` with the actual path, image name, and container name or ID, respectively.

## Troubleshooting

-   Ensure that no other application is using port `9166` or `19166` on your host machine.
-   If you encounter issues, check the Docker container logs:

    ```sh
    docker logs <containername>
    ```
