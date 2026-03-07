#!/usr/bin/env -S just --justfile

# boxkit - Justfile for local development and testing
# Container provisioning logic lives in scripts/

# Build boxkit image locally (without chunkah - chunkah requires buildah)
build-boxkit:
    podman build --target=builder -f Containerfiles/boxkit -t boxkit:local .

# Build fedora-example image locally (without chunkah - chunkah requires buildah)
build-fedora-example:
    podman build --target=builder -f Containerfiles/fedora-example -t fedora-example:local .

# Build all images
build-all: build-boxkit build-fedora-example

# Run boxkit in distrobox
run-boxkit:
    @distrobox create -i boxkit:local -n boxkit 2>/dev/null || true
    distrobox enter boxkit

# Run fedora-example in distrobox
run-fedora-example:
    @distrobox create -i fedora-example:local -n fedora-example 2>/dev/null || true
    distrobox enter fedora-example

# Clean built images
clean:
    podman rmi -f boxkit:local fedora-example:local 2>/dev/null || true
    @echo "✓ Local images cleaned"

# Clean distrobox containers
clean-distrobox:
    @distrobox rm -f boxkit fedora-example 2>/dev/null || true
    @echo "✓ Distrobox containers removed"

# Full cleanup
clean-all: clean clean-distrobox
