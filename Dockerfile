FROM ubuntu:22.04

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update \
&& apt-get install -y --no-install-recommends \
wget ca-certificates gnupg2 \
&& apt-get update \
&& apt-get upgrade -y \
&& apt-get remove -fy \
&& apt-get autoclean -y \
&& apt-get autoremove -y \
&& rm -rf /var/lib/apt/lists/* /var/tmp/* /tmp/*

RUN wget -O- https://keys.anydesk.com/repos/DEB-GPG-KEY | gpg --dearmor > /usr/share/keyrings/anydesk-archive-keyring.gpg
RUN printf "deb [signed-by=/usr/share/keyrings/anydesk-archive-keyring.gpg] http://deb.anydesk.com/ all main" > /etc/apt/sources.list.d/anydesk.list

RUN apt-get update \
&& apt-get install -y \
anydesk libpolkit-gobject-1-0 \
lsb-release pciutils \
libpango1.0-0 pulseaudio ffmpeg libsm6 libxext6 dbus-x11 tzdata

ARG UNAME=udocker
ARG UID=1000
ARG GNAME=$UNAME
ARG GID=1000
ARG GROUPS=$GNAME

RUN groupadd -g $GID $GNAME \
&& useradd --create-home -d /home/$UNAME -g $GID -u $UID $UNAME \
&& usermod -a -G $GROUPS $UNAME
USER $UNAME
WORKDIR /home/$UNAME

ENTRYPOINT ["/usr/bin/anydesk"]
