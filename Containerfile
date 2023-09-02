FROM quay.io/toolbx-images/ubuntu-toolbox:22.04 as obs-studio-portable

LABEL com.github.containers.toolbox="true" \
      usage="This image is meant to be used with the toolbox or distrobox command" \
      summary="OBS Studio Portable" \
      maintainer="jorge.castro@gmail.com"

COPY ./extra-packages /extra-packages

RUN apt-get update && \ 
    apt-get upgrade -y && \
    DEBIAN_FRONTEND=noninteractive apt-get -y install \
        $(cat extra-packages | xargs) && \
    rm -rd /var/lib/apt/lists/*

# Install OBS Studio Portable
RUN wget https://github.com/jqlang/jq/releases/download/jq-1.6/jq-linux64 -O /usr/bin/jq && \
    chmod +x /usr/bin/jq && \
    mkdir -p /tmp/obs_portable && \
    wget \
        $(curl -s https://api.github.com/repos/wimpysworld/obs-studio-portable/releases/latest | \
        jq -r ".assets[] | select(.name | test(\"ubuntu-$(lsb_release -rs).tar.bz2\")) | .browser_download_url") \
        -O /tmp/obs_portable/latest.tar.bz2 && \
    tar xvf /tmp/obs_portable/latest.tar.bz2 -C /tmp/obs_portable --strip-components=1 && \
    rm /tmp/obs_portable/latest.tar.bz2 && \
    /tmp/obs_portable/latest/obs-dependencies && \
    mv /tmp/obs_portable /opt/obs_portable && \
    rm /usr/bin/jq
