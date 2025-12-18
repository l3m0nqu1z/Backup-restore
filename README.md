# Backup & Restore Challenge

Docker Compose configuration to solve the Hackattic "Backup restore" challenge.

## System requirements

- Docker Compose v2

## Preparation

Set up the `ACCESS_TOKEN` environment variable which is your access token from hackattic.com.

## Start

To start the Compose stack and attach the `sidecar` service to the current terminal, run:

```shell
docker compose -f compose.yaml --env-file .defaults up --attach sidecar
```

## Stop

To stop and remove the containers, run:

```shell
docker compose -f compose.yaml down
```
