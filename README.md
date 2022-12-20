# AnyDesk

## Build
Via GitHub repository
```bash
$ docker build --build-arg UID=$(id -u) --build-arg GID=$(id -g) --tag alireaza/anydesk:$(date -u +%Y%m%d) --tag alireaza/anydesk:latest https://github.com/alireaza/anydesk.git
```

## Run
```bash
docker run \
--interactive \
--tty \
--rm \
--mount="type=bind,source=/tmp/.X11-unix,target=/tmp/.X11-unix" \
--env="DISPLAY=$DISPLAY" \
--device="/dev/dri:/dev/dri" \
--env="PULSE_SERVER=unix:${XDG_RUNTIME_DIR}/pulse/native" \
--mount="type=bind,source=${XDG_RUNTIME_DIR}/pulse/native,target=${XDG_RUNTIME_DIR}/pulse/native" \
--mount="type=bind,source=$(pwd)/udocker,target=/home/udocker" \
--name="anydesk" \
alireaza/anydesk
```

