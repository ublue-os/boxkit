ARG FEDORA_VERSION=${FEDORA_VERSION:-38}
FROM registry.fedoraproject.org/fedora-toolbox:${FEDORA_VERSION}

LABEL com.github.containers.toolbox="true" \
      usage="This image is meant to be used with the toolbox or distrobox command" \
      summary="A cloud-native terminal experience" \
      maintainer="Gordon Schulz <gordon@gordonschulz.de>"

ARG CHEZMOI_VERSION=${CHEZMOI_VERSION:-2.33.3}

RUN dnf --assumeyes copr enable atim/starship && \
        dnf --assumeyes copr enable atim/lazygit && \
        dnf --assumeyes copr enable varlad/zellij && \
        dnf --assumeyes copr enable awood/bat-extras && \
        dnf --assumeyes update && \
        dnf clean all
COPY packages /
RUN grep -v '^#' packages | xargs dnf --assumeyes install && \
    dnf --assumeyes install https://github.com/twpayne/chezmoi/releases/download/v${CHEZMOI_VERSION}/chezmoi-${CHEZMOI_VERSION}-$(uname -m).rpm && \
    dnf clean all

RUN ln -fs /usr/bin/distrobox-host-exec /usr/local/bin/flatpak && \
        ln -fs /usr/bin/distrobox-host-exec /usr/local/bin/podman && \
        ln -fs /usr/bin/distrobox-host-exec /usr/local/bin/rpm-ostree


