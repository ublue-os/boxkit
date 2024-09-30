FROM docker.io/library/ubuntu:22.04
# FROM https://hub.docker.com/_/ubuntu

LABEL com.github.containers.toolbox="true" \
    name="ubuntu-22-toolbox" \
    usage="This image is meant to be used with the toolbox or distrobox command" \
    summary="A cloud-native terminal experience powered by Ubuntu" \
    maintainer="drew@moseleynet.net"

COPY extra-packages /toolbox-packages

RUN rm /etc/apt/apt.conf.d/docker-gzip-indexes /etc/apt/apt.conf.d/docker-no-languages && \
    sed -Ei 's/^(hosts:.*)(\<files\>)\s*(.*)/\1\2 myhostname \3/' /etc/nsswitch.conf && \
    sed -Ei '/apt-get (update|upgrade)/s/^/#/' /usr/local/sbin/unminimize && \
    apt-get update && \
    yes | /usr/local/sbin/unminimize && \
    DEBIAN_FRONTEND=noninteractive apt-get -y install \
    ubuntu-minimal ubuntu-standard \
    libnss-myhostname \
    flatpak-xdg-utils \
    $(cat toolbox-packages | xargs) && \
    rm -rd /var/lib/apt/lists/* && \
    rm /toolbox-packages && \
    mkdir /usr/share/empty && \
    userdel --remove ubuntu || true && \
    curl -sLo /usr/bin/host-spawn https://github.com/1player/host-spawn/releases/download/1.5.0/host-spawn-x86_64 && \
    chmod +x /usr/bin/host-spawn && \
    rm /etc/apt/apt.conf.d/20apt-esm-hook.conf && \
    ln -s /usr/libexec/flatpak-xdg-utils/flatpak-spawn /usr/bin/ && \
    ln -fs /usr/bin/distrobox-host-exec /usr/local/bin/docker && \
    ln -fs /usr/bin/distrobox-host-exec /usr/local/bin/flatpak && \ 
    ln -fs /usr/bin/distrobox-host-exec /usr/local/bin/podman && \
    ln -fs /usr/bin/distrobox-host-exec /usr/local/bin/rpm-ostree && \
    echo "ALL ALL = (ALL) NOPASSWD: ALL" >> /etc/sudoers
