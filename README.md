# AnyDesk

## Build
### Docker via GitHub repository

```bash
docker build --build-arg UID=$(id -u) --build-arg GID=$(id -g) --tag alireaza/anydesk:$(date -u +%Y%m%d) --tag alireaza/anydesk:latest https://github.com/alireaza/anydesk.git
```

### Podman via GitHub repository

```bash
podman build --build-arg UID=$(id -u) --build-arg GID=$(id -g) --tag alireaza/anydesk:$(date -u +%Y%m%d) --tag alireaza/anydesk:latest https://github.com/alireaza/anydesk.git
```

## Run
### Docker

```bash
docker run \
--rm \
--name="anydesk" \
--device="/dev/dri:/dev/dri" \
--env="DISPLAY=$DISPLAY" \
--env="XAUTHORITY=/home/udocker/.XAuthority" \
--env="PULSE_SERVER=unix:${XDG_RUNTIME_DIR}/pulse/native" \
--mount="type=bind,source=$(pwd)/udocker,target=/home/udocker" \
--mount="type=bind,source=/tmp/.X11-unix,target=/tmp/.X11-unix" \
--mount="type=bind,source=$XAUTHORITY,target=/home/udocker/.XAuthority" \
--mount="type=bind,source=${XDG_RUNTIME_DIR}/pulse/native,target=${XDG_RUNTIME_DIR}/pulse/native" \
--net="host" \
alireaza/anydesk
```

### Podman

```
podman run \
--rm \
--name="anydesk" \
--device="/dev/dri:/dev/dri" \
--env="DISPLAY" \
--env="XAUTHORITY=/home/udocker/.XAuthority" \
--env="PULSE_SERVER=unix:${XDG_RUNTIME_DIR}/pulse/native" \
--mount="type=bind,source=$(pwd)/udocker,target=/home/udocker" \
--mount="type=bind,source=/tmp/.X11-unix,target=/tmp/.X11-unix" \
--mount="type=bind,source=$XAUTHORITY,target=/home/udocker/.XAuthority" \
--mount="type=bind,source=${XDG_RUNTIME_DIR}/pulse/native,target=${XDG_RUNTIME_DIR}/pulse/native" \
--security-opt="label=type:container_runtime_t" \
--userns="keep-id" \
--net="host" \
alireaza/anydesk
```
