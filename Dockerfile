FROM debian:stable-slim

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        ca-certificates gnupg2 curl \
    && curl -sL https://keys.anydesk.com/repos/DEB-GPG-KEY | gpg --dearmor > /usr/share/keyrings/anydesk-archive-keyring.gpg \
    && printf "deb [signed-by=/usr/share/keyrings/anydesk-archive-keyring.gpg] http://deb.anydesk.com/ all main" > /etc/apt/sources.list.d/anydesk.list \
    && apt-get update \
    && apt-get install -y \
        anydesk libpolkit-gobject-1-0 \
        lsb-release pciutils \
        libpango1.0-0 pulseaudio ffmpeg libsm6 libxext6 dbus-x11 tzdata xauth tini \
    && apt-get remove -y curl gnupg2 \
    && rm -rf /var/lib/apt/lists/*

ARG USERNAME=udocker
ARG UID=1000
ARG GROUPNAME=$USERNAME
ARG GID=1000
ARG GROUPS=$GROUPNAME

RUN groupadd -g $GID $GROUPNAME \
&& useradd --create-home -d /home/$USERNAME -g $GID -u $UID $USERNAME \
&& usermod -a -G $GROUPS $USERNAME
USER $USERNAME
WORKDIR /home/$USERNAME

ENTRYPOINT ["/usr/bin/tini", "--" ]

CMD ["/usr/bin/anydesk"]
