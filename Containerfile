FROM docker.io/library/archlinux:latest

LABEL com.github.containers.toolbox="true" \
      usage="This image is meant to be used with the toolbox or distrobox command" \
      summary="A cloud-native terminal experience" \
      maintainer="lucasvsribeiro1@gmail.coms>"

ENV YAY_BUILDER="yay"

COPY --from=docker.io/mikefarah/yq /usr/bin/yq /usr/bin/yq
ADD packages.json /tmp/packages.json
ADD build.sh /tmp/build.sh

RUN mkdir /etc/sudoers.d

RUN useradd --system --create-home $YAY_BUILDER && echo "$YAY_BUILDER ALL=(ALL:ALL) NOPASSWD:ALL" | tee /etc/sudoers.d/$YAY_BUILDER

RUN pacman -Syu --noconfirm $(yq -r ".pacman[]" /tmp/packages.json)

USER $YAY_BUILDER

WORKDIR /home/${YAY_BUILDER}

RUN /tmp/build.sh

USER root

WORKDIR /

RUN   ln -fs /bin/sh /usr/bin/sh && \
      ln -fs /usr/bin/distrobox-host-exec /usr/local/bin/docker && \
      ln -fs /usr/bin/distrobox-host-exec /usr/local/bin/flatpak && \ 
      ln -fs /usr/bin/distrobox-host-exec /usr/local/bin/podman && \
      ln -fs /usr/bin/distrobox-host-exec /usr/local/bin/rpm-ostree && \
      ln -fs /usr/bin/distrobox-host-exec /usr/local/bin/transactional-update
     
