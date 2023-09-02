FROM quay.io/toolbx-images/ubuntu-toolbox:22.04 as obs-studio-portable

LABEL com.github.containers.toolbox="true" \
      usage="This image is meant to be used with the toolbox or distrobox command" \
      summary="OBS" \
      maintainer="jorge.castro@gmail.com"

COPY ./extra-packages /extra-packages

RUN apt-get update && \ 
    apt-get upgrade -y && \
    DEBIAN_FRONTEND=noninteractive apt-get -y install \
        $(cat extra-packages | xargs) && \
    rm -rd /var/lib/apt/lists/*

RUN wget "https://github.com/wimpysworld/obs-studio-portable/releases/download/r23173/obs-portable-29.1.3-r23173-ubuntu-$(lsb_release -rs).tar.bz2"
RUN tar xvf obs-portable-29.1.3-r23173-ubuntu-$(lsb_release -rs).tar.bz2

RUN rm /extra-packages
