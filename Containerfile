FROM quay.io/toolbx-images/alpine-toolbox

LABEL com.github.containers.toolbox="true" \
      usage="This image is meant to be used with the toolbox or distrobox command" \
      summary="A cloud-native terminal experience" \
      maintainer="benrobertson150@hotmail.co.uk"

COPY extra-packages /
COPY brew-packages /
COPY homebrewPath.sh /etc/profile.d/
#Update core packages
RUN apk upgrade && \
    grep -v '^#' /extra-packages | xargs apk add
#Install and configure homebrew
#RUN useradd -m -s /bin/bash linuxbrew && \
    #usermod -aG sudo linuxbrew &&  \
    #mkdir -p /home/linuxbrew/.linuxbrew && \
    #chown -R linuxbrew: /home/linuxbrew/.linuxbrew
#USER linuxbrew
#RUN NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" && \
#grep -v '^#' /brew-packages | xargs /home/linuxbrew/.linuxbrew/bin/brew install 
#USER root
#RUN chown -R $CONTAINER_USER: /home/linuxbrew/.linuxbrew
#ENV PATH="$PATH:/home/linuxbrew/.linuxbrew/bin"

RUN rm /extra-packages && rm /brew-packages
CMD /bin/bash
#RUN   ln -fs /bin/sh /usr/bin/sh && \
#      ln -fs /usr/bin/distrobox-host-exec /usr/local/bin/docker && \
#      ln -fs /usr/bin/distrobox-host-exec /usr/local/bin/flatpak && \ 
#      ln -fs /usr/bin/distrobox-host-exec /usr/local/bin/podman && \
#      ln -fs /usr/bin/distrobox-host-exec /usr/local/bin/rpm-ostree && \
#      ln -fs /usr/bin/distrobox-host-exec /usr/local/bin/transactional-update
     
