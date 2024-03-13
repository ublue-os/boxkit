FROM quay.io/toolbx-images/debian-toolbox:12

LABEL com.github.containers.toolbox="true" \
      usage="This image is meant to be used with the toolbox or distrobox command" \
      summary="A cloud-native terminal experience" \
      maintainer="benrobertson150@hotmail.co.uk"

COPY extra-packages /
COPY brew-packages /
#Update core packages
RUN apt-get update && \
    apt-get -y upgrade && \
    grep -v '^#' /extra-packages | xargs apt-get -y install
#Install and configure homebrew
RUN useradd -m -s /bin/bash linuxbrew && \
    usermod -aG sudo linuxbrew &&  \
    mkdir -p /home/linuxbrew/.linuxbrew && \
    chown -R linuxbrew: /home/linuxbrew/.linuxbrew
USER linuxbrew
RUN NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" && \
grep -v '^#' /brew-packages | xargs /home/linuxbrew/.linuxbrew/bin/brew install 
USER root
RUN chown -R $CONTAINER_USER: /home/linuxbrew/.linuxbrew
ENV PATH="/home/linuxbrew/.linuxbrew/bin:${PATH}"
#Install Rider
#RUN wget https://download.jetbrains.com/rider/JetBrains.Rider-2023.3.3.tar.gz -O /opt/rider.tar.gz && \
#    tar -xf /opt/rider.tar.gz -C /opt/

RUN rm /extra-packages && rm /brew-packages
RUN   ln -fs /bin/sh /usr/bin/sh && \
      ln -fs /usr/bin/distrobox-host-exec /usr/local/bin/docker && \
      ln -fs /usr/bin/distrobox-host-exec /usr/local/bin/flatpak && \ 
      ln -fs /usr/bin/distrobox-host-exec /usr/local/bin/podman && \
      ln -fs /usr/bin/distrobox-host-exec /usr/local/bin/rpm-ostree && \
      ln -fs /usr/bin/distrobox-host-exec /usr/local/bin/transactional-update
CMD   /bin/bash
     
