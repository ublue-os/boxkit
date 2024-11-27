FROM quay.io/toolbx/ubuntu-toolbox:24.04 as obs-studio-portable

LABEL com.github.containers.toolbox="true" \
      usage="This image is meant to be used with the toolbox or distrobox command" \
      summary="OBS Studio Portable" \
      maintainer="jorge.castro@gmail.com"

COPY ./extra-packages /extra-packages

RUN apt-get update && \ 
    apt-get upgrade -y && \
    DEBIAN_FRONTEND=noninteractive apt-get -y --no-install-recommends install \
        $(cat extra-packages | xargs) && \
    rm -rd /var/lib/apt/lists/*

# Install OBS Studio Portable
RUN wget https://github.com/jqlang/jq/releases/download/jq-1.6/jq-linux64 -O /usr/bin/jq && \
    chmod +x /usr/bin/jq && \
    mkdir -p /tmp/obs-portable && \
    wget \
        $(curl -s https://api.github.com/repos/wimpysworld/obs-studio-portable/releases/latest | \
        jq -r ".assets[] | select(.name | test(\"ubuntu-$(lsb_release -rs).tar.bz2\$\")) | .browser_download_url") \
        -O /tmp/obs-portable/latest.tar.bz2 && \
    tar xvf /tmp/obs-portable/latest.tar.bz2 -C /tmp/obs-portable --strip-components=1 && \
    rm /tmp/obs-portable/latest.tar.bz2 && \
    /tmp/obs-portable/obs-container-dependencies && \
    mv /tmp/obs-portable /opt/obs-portable && \
    rm /usr/bin/jq

# Create desktop file from upstream
RUN wget https://raw.githubusercontent.com/obsproject/obs-studio/master/UI/cmake/linux/com.obsproject.Studio.desktop -O /usr/share/applications/com.obsproject.Studio.desktop && \
    wget https://raw.githubusercontent.com/obsproject/obs-studio/master/UI/cmake/linux/icons/obs-logo-128.png -O /usr/share/icons/hicolor/128x128/apps/com.obsproject.Studio.png && \
    wget https://raw.githubusercontent.com/obsproject/obs-studio/master/UI/cmake/linux/icons/obs-logo-256.png -O /usr/share/icons/hicolor/256x256/apps/com.obsproject.Studio.png && \
    wget https://raw.githubusercontent.com/obsproject/obs-studio/master/UI/cmake/linux/icons/obs-logo-512.png -O /usr/share/icons/hicolor/512x512/apps/com.obsproject.Studio.png && \
    wget https://raw.githubusercontent.com/obsproject/obs-studio/master/UI/cmake/linux/icons/obs-logo-scalable.svg -O /usr/share/icons/hicolor/scalable/apps/com.obsproject.Studio.svg && \
    sed -i 's@Exec=obs@Exec=/opt/obs-portable/obs-portable@g' /usr/share/applications/com.obsproject.Studio.desktop

COPY obs-config-fix.sh /etc/profile.d/99-obs-config-fix.sh
