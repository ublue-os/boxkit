<h1 align="center">
  <img src="https://avatars1.githubusercontent.com/u/7725691?v=3&s=256" alt="OBS Studio">
  <br />
  OBS Studio <i>Portable</i> for Linux
</h1>

<p align="center"><b>Portable builds of OBS Studio for Linux, pre-loaded with extra features and plugins for live streaming and screen recording</b>
<br />
Made with 💝 for 🐧</p>

# OBS Studio Portable for Linux

- Includes nearly 50 of the best 3rd Party plugins for OBS Studio!
- Chromium Embedded Frameworks (CEF) to enable Browser Sources
- NVENC (NVIDIA) and VA-API (AMD & Intel) accelerated video encoding
- Fraunhofer FDK AAC Codec
- VLC and GStreamer Media sources
- AJA NTV2 SDK

# Installation

Use [Distrobox](https://distrobox.privatedns.org/) to run [OBS Studio Portable]() on any Linux 🐧 distro.

- The OBS Studio configuration is exposed in your home directory on the host via the `~/.config/obs-portable` directory.
- Launching multiple instances of OBS Studio Portable containers is not recommended as the configuration location is shared.

**Running a single instance of OBS Studio Portable works great!**

1. Install Distrobox (*1.4.2.1 or newer*) and Podman (*recommended*) or Docker.
2. Create a Distrobox container for OBS Studio Portable.

```bash
distrobox create --image ghcr.io/ublue-os/obs-studio-portable:latest --name obs --pull
```

If you have an NVIDIA GPU, install the required CUDA and NVENC support in the container.
- The `--nvidia` option, added in Distrobox 1.5.0, does not work on NixOS; so I install the required libraries in the container.
  - Change the version number (***535** in the example below*) to match the version of the NVIDIA drivers you have installed on the host.

```bash
distrobox create --image ghcr.io/ublue-os/obs-studio-portable:latest --name obs --pull --additional-packages "nvidia-headless-no-dkms-535 libnvidia-encode-535"
```

3. Run the initial setup.

```bash
distrobox-enter --name obs -- /etc/profile.d/99-obs-config-fix.sh
```

4. From now on, launch OBS Studio Portable using the `obs-portable` launcher.

```bash
distrobox-enter --name obs -- /opt/obs-portable/obs-portable
```

# More information

This container image of OBS Studio Portable is maintained as a collaborative effort between [Universal Blue](https://github.com/ublue-os) and [Martin Wimpress](https://github.com/flexiondotorg), the maintainer of [OBS Studio Portable](https://github.com/wimpysworld/obs-studio-portable), where you can find more information of OBS Studio Portable:

- <https://github.com/wimpysworld/obs-studio-portable>
