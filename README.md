<h1 align="center">
  <img src="https://avatars1.githubusercontent.com/u/7725691?v=3&s=256" alt="OBS Studio">
  <br />
  OBS Studio <i>Portable</i> for Linux
</h1>

<p align="center"><b>OBS Studio Portable is an OCI image that provides current <a href="https://obsproject.com/" target=_blank">OBS Studio</a>, for Linux, pre-loaded with extra features and a curated collection of 3rd party OBS Studio plugins for live streaming and screen recording.</b>
<br />
Made with 💝 for 🐧</p>

[![build-obs-studio-portable](https://github.com/ublue-os/obs-studio-portable/actions/workflows/build.yml/badge.svg)](https://github.com/ublue-os/obs-studio-portable/actions/workflows/build.yml)

# OBS Studio Portable for Linux

OBS Studio Portable is built from [toolbx-images/images](https://github.com/toolbx-images/images) and [wimpysworld/obs-studio-portable](https://github.com/wimpysworld/obs-studio-portable) using Ubuntu. Additionally, OBS Studio Portable for Linux includes the following features:

- Includes **50 of the best 3rd Party plugins for OBS Studio**!
- Chromium Embedded Frameworks (CEF) to enable Browser Sources
- NVENC (NVIDIA) and VA-API (AMD & Intel) accelerated video encoding
- Shader and GStreamer effects filters
- Fraunhofer FDK AAC Codec
- Pipewire application specific audio capture
- VLC and GStreamer Media sources
- AJA NTV2 SDK
- [WebSockets](https://github.com/obsproject/obs-websocket) 5.x and 4.9.1-compat are both included
- [NewTek NDI™ integration](https://github.com/obs-ndi/obs-ndi) and [Teleport](https://github.com/fzwoch/obs-teleport) support
- [SRT & RIST Protocol](https://obsproject.com/wiki/Streaming-With-SRT-Or-RIST-Protocols) support
- Markdown, Pango and API text sources

Using this container image of OBS Studio Portable it is possible to run an isolated OBS Studio on *any Linux distro*.

- A complete OBS Studio for Fedora Silver Blue users.
- A fast-moving and compatible OBS Studio software stack for NixOS users.
- Run current and fully equipped OBS Studio on Debian stable.
- Run OBS Studio built with current Ubuntu interim releases with new OBS features enabled (thanks to access to newer libraries) on current and old Ubuntu LTS.

# Installation

Use [Distrobox](https://distrobox.it/) to run [OBS Studio Portable](https://github.com/wimpysworld/obs-studio-portable) on any Linux 🐧 distro.

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

This container image of OBS Studio Portable is maintained as a collaborative effort between [Universal Blue](https://github.com/ublue-os) and [Martin Wimpress](https://github.com/flexiondotorg), the maintainer of [OBS Studio Portable for Ubuntu](https://github.com/wimpysworld/obs-studio-portable).

## OBS Studio Portable Plugins

Thanks to the OBS Studio developers and developers of the growing list of excellent plugins.
OBS Studio Portable for Linux celebrates the best of what's available. Thank you! 🙇

Here are the 3rd party plugins that come bundled with OBS Studio Portable for Linux:

### Audio 🔉

- **[Audio Pan](https://github.com/norihiro/obs-audio-pan-filter)** plugin; control stereo pan of audio sources.
- **[Local Vocal](https://github.com/obs-ai/obs-localvocal)** plugin; local speech and text AI processing routines and  AI transcription.
- **[Mute Filter](https://github.com/norihiro/obs-mute-filter)** plugin; to mute audio from a source.
- **[PipeWire Audio Capture](https://github.com/dimtpap/obs-pipewire-audio-capture)** plugin; capture application audio from PipeWire.
- **[Scale to Sound](https://github.com/Qufyy/obs-scale-to-sound)** plugin; adds a filter which makes a source scale based on the audio levels of any audio source you choose
- **[Soundboard](https://github.com/cg2121/obs-soundboard)** plugin; adds a soundboard dock.
- **[Waveform](https://github.com/phandasm/waveform)** plugin; audio spectral analysis.

### Automation 🎛

- **[Advanced Scene Switcher](https://github.com/WarmUpTill/SceneSwitcher)** plugin; an automated scene switcher.
- **[Directory Watch Media](https://github.com/exeldro/obs-dir-watch-media)** plugin; filter you can add to a media source to load the oldest or newest file in a directory.
- **[Dummy Source](https://github.com/norihiro/obs-command-source)** plugin; provides a dummy source to execute arbitrary commands when a scene is switched.
- **[Source Switcher](https://github.com/exeldro/obs-source-switcher)** plugin; to switch between a list of sources.
- **[Transition Table](https://github.com/exeldro/obs-transition-table)** plugin; customize scene transitions.
- **[Websockets](https://github.com/obsproject/obs-websocket)** plugin; remote-control OBS Studio through WebSockets.
  - 5.x and 4.9.1-compat are both included

### Effects ✨

- **[3D Effect](https://github.com/exeldro/obs-3d-effect)** plugin; 3D effect filter.
- **[Browser Transition](https://github.com/exeldro/obs-browser-transition)** plugin; show a browser source during scene transition.
- **[Composite Blur](https://github.com/FiniteSingularity/obs-composite-blur)** plugin; comprehensive blur plugin that provides several different blur algorithms, and proper compositing.
- **[DVD Screensaver](https://github.com/univrsal/dvds3)** plugin; a DVD screen saver source type.
- **[Downstream Keyer](https://github.com/exeldro/obs-downstream-keyer)** plugin; add a Downstream Keyer dock.
- **[Dynamic Delay](https://github.com/exeldro/obs-dynamic-delay)** plugin; filter for dynamic delaying a video source.
- **[Face Tracker](https://github.com/norihiro/obs-face-tracker)** plugin; face tracking plugin
- **[Freeze Filter](https://github.com/exeldro/obs-freeze-filter)** plugin; freeze a source using a filter.
- **[Gradient](https://github.com/exeldro/obs-gradient-source)** plugin; adding gradients as a source.
- **[Move Transition](https://github.com/exeldro/obs-move-transition)** plugin; move source to a new position during a scene transition.
- **[Multi Source Effect](https://github.com/norihiro/obs-multisource-effect)** plugin; provides a custom effect to render multiple sources.
- **[Pixel Art](https://github.com/dspstanky/pixel-art)** plugin; create retro-inspired pixel art visuals.
- **[Recursion Effect](https://github.com/exeldro/obs-recursion-effect)** plugin; recursion effect filter.
- **[Replay Source](https://github.com/exeldro/obs-replay-source)** plugin; slow motion replay async sources from memory.
- **[RGB Levels](https://github.com/wimpysworld/obs-rgb-levels-filter)** plugin; simple filter to adjust RGB levels.
- **[Scene as Transition](https://github.com/andilippi/obs-scene-as-transition)** plugin; use scenes as transitions.
- **[Shader Filter](https://github.com/exeldro/obs-shaderfilter)** plugin; for applying an arbitrary shader to a source.
- **[Stroke Glow Shadow](https://github.com/FiniteSingularity/obs-stroke-glow-shadow)** plugin; provide efficient Stroke, Glow, and Shadow effects on masked sources.
- **[Time Shift](https://github.com/exeldro/obs-time-shift)** plugin;  time shift a source using a filter.
- **[Time Warp Scan](https://github.com/exeldro/obs-time-warp-scan)** plugin; a time warp scan filter.
- **[Vintage Filter](https://github.com/cg2121/obs-vintage-filter)** plugin; a filter to make source black & white or sepia.

### Encoding & Output 🎞

- **[Game Capture](https://github.com/nowrep/obs-vkcapture)** plugin; Vulkan/OpenGL game capture.
- **[GStreamer](https://github.com/fzwoch/obs-gstreamer)** plugin; feed GStreamer launch pipelines into OBS Studio.
- **[NDI](https://github.com/obs-ndi/obs-ndi)** plugin; Network A/V in OBS Studio with NewTek's NDI technology.
- **[Source Record](https://github.com/exeldro/obs-source-record)** plugin; make sources available to record via a filter.
- **[StreamFX](https://github.com/Xaymar/obs-StreamFX)** plugin; unlocks the full potential of NVENC along with encoders for Avid DNxHR, Apple ProRes and CineForm.
  - **Only the *stable* StreamFX encoders, Color Grading and Dynamic Mask filters are enabled in OBS Studio Portable for Linux**.
- **[Teleport](https://github.com/fzwoch/obs-teleport)** plugin; open NDI-like replacement. (*not NDI compatible*)
- **[VA-API](https://github.com/exeldro/obs-transition-table)** plugin; GStreamer-based VA-API encoder implementation.
- **[Vertical Canvas](https://github.com/Aitum/obs-vertical-canvas)** plugin; make content for TikTok, YouTube Shorts, Instagram Live, and more without the fuss.

### Tools 🛠

- **[Scene Notes Dock](https://github.com/exeldro/obs-scene-notes-dock)** plugin; create a Dock for showing and editing notes for the currently active scene.
- **[Source Clone](https://github.com/exeldro/obs-source-clone)** plugin; add source cloning
- **[Source Copy](https://github.com/exeldro/obs-source-copy)** plugin; adds copy-and-paste options to the tools menu.
- **[Source Dock](https://github.com/exeldro/obs-source-dock)** plugin; adds browser sources as custom docks.

### Text 📝

- **[Markdown](https://github.com/exeldro/obs-markdown)** plugin; add Markdown sources
- **[Text PThread](https://github.com/norihiro/obs-text-pthread)** plugin; Rich text source plugin with many advanced features, including multi-language support, emoji support, vertical rendering and RTL support.
- **[URL Source](https://github.com/obs-ai/obs-urlsource)** plugin; fetch data from a URL (API), parse and display live update in scene.
