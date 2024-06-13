# Blockbook Docker

This guide will help you build and run the Docker image for Blockbook Mainnet and Testnet, which is based on Ubuntu 22.04 and includes both backend and frontend components.

## Prerequisites

-   [Docker installed on your machine](https://docs.docker.com/engine/install/).
-   Clone or download the repository to your local machine.

## Building the Docker Image

Navigate to the directory where the repository is cloned or downloaded:

```sh
cd <path/to/cloned/repository>
```

Build the Docker image using the following command:

```sh
docker build -t <imagename> .
```

## Running the Docker Container

Create a named volume for Persistent storage using:

```sh
docker volume create <volume_name>
```

Run the Docker container in detached mode and for mainnet map port `9166` on your host to port `9166` on the container and for testnet map `19166`:

```sh
docker run -d -p 9166:9166 --mount source=<volume_name>,target=/opt/coins <imagename>
```

## Accessing the Frontend

Once the Docker container is running, you can access the frontend of the application by navigating to:

```sh
https://localhost:9166
```

in your web browser.

## Accessing Logs

To check the logs, you can access the container shell and use the `tail` command.

First, get the container's name or ID:

```sh
docker ps -a
```

Then, access the container shell:

```sh
docker exec -it <containername> bash
```

### Checking Backend Logs

To view the backend logs, run:

```sh
tail -f /opt/coins/data/flo/backend/debug.log
```

### Checking Frontend Logs

To view the frontend logs, run:

```sh
tail -f /opt/coins/blockbook/flo/logs/blockbook.INFO
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

-   Ensure that no other application is using port `9166` on your host machine.
-   If you encounter issues, check the Docker container logs:

    ```sh
    docker logs <containername>
    ```
