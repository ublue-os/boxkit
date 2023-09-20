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
- [WebSockets](https://github.com/obsproject/obs-websocket) 5.0.1 and 4.9.1-compat are both included

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

## NVIDIA support

The appropriate NVIDIA libraries on the host should be automatically be linked inside the container 🪄
However the capability for Distrobox to automatically connect NVIDIA libraries was recently added in Distrobox 1.5.0, and is also not supported on all distros; NixOS for example.

Therefore, if your are running an older version of Distrobox or the NVIDIA drivers are not automatically linked inside the container you can install them as follows:
  - Change the version number (***535** in the example below*) to match the version of the NVIDIA drivers you have installed on the host.

### NVIDIA complete driver stack

Required if the display is rendered by an NVIDIA GPU.

```bash
distrobox create --image ghcr.io/ublue-os/obs-studio-portable:latest --name obs --pull --additional-packages nvidia-driver-535
```

### NVIDIA compute only

Suitable for multi-GPU systems where the NVIDIA GPU is not rendering the display and only being used for compute.

```bash
distrobox create --image ghcr.io/ublue-os/obs-studio-portable:latest --name obs --pull --additional-packages libnvidia-encode-535 nvidia-headless-no-dkms-535

3. Run the initial setup.

```bash
distrobox enter --name obs -- true
```

4. From now on, launch OBS Studio Portable using the `obs-portable` launcher.

```bash
distrobox enter --name obs -- /opt/obs-portable/obs-portable
```

If the OBS Studio Portable container cannot connect to the host X11 server, add [`xhost +si:localuser:$USER`](https://github.com/89luca89/distrobox/blob/main/docs/compatibility.md#compatibility-notes) to `~/.distroboxrc`.

# More information

This container image of OBS Studio Portable is maintained as a collaborative effort between [Universal Blue](https://github.com/ublue-os) and [Martin Wimpress](https://github.com/flexiondotorg), the maintainer of [OBS Studio Portable](https://github.com/wimpysworld/obs-studio-portable), where you can find more information of OBS Studio Portable:

- <https://github.com/wimpysworld/obs-studio-portable>
