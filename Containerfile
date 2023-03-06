FROM docker.io/library/archlinux:latest

LABEL com.github.containers.toolbox="true" \
      usage="Imagem para desenvolvimento web em ambiente Arch (Distrobox e Toolbox)" \
      summary="Uma experiência em nuvem" \
      maintainer="lucasvsribeiro1@gmail.com>"

ENV YAY_BUILDER="yay"
ENV WHEREAMI="$PWD"

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

RUN userdel -r ${YAY_BUILDER}

WORKDIR ${WHEREAMI}
     
