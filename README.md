Archiving, I found a better solution for acquiring all this software as flatpaks.

# dawbox

## What is dawbox ?

Dawbox is a project leveraging Cloud Native technologies to provide a ready-to-go Audio Production environment.  Its intended use-case is on Fedora Atomic and its derivatives like Universal Blue, though any Linux system with Distrobox will work :)

## Requirements

You will need:
- [Podman](https://podman.io/)
- [Distrobox](https://github.com/89luca89/distrobox)
- To be comfortable opening a terminal and running the install script in CLI

## Setup

Open your terminal of choice and run:
```
curl -sL https://raw.githubusercontent.com/Messaiga/DAWbox/refs/heads/main/install.sh -o install.sh && chmod +x install.sh && ./install.sh
```

- Select 1 to check if dawbox is installed.
- Select 2 to install dawbox.
- Select 3 to update dawbox.
- Select 4 to remove dawbox.
- Select 5 to exit.

After first run you may have to run this inside of the box for fonts to work in certain programs:

```
sudo fc-cache -Ers
```

## Key Software

Here's a quick highlight reel of the software packaged in DAWbox:
- [Ardour](https://ardour.org/)
- [Calf-plugins](https://calf-studio-gear.org/)
- [Carla](https://kx.studio/Applications:Carla)
- [Guitarix](http://guitarix.org/)
- [LMMS](https://lmms.io/)
- [Lsp-plugins](https://lsp-plug.in/)
- [QTractor](https://www.qtractor.org/)
- [Rackarrack](https://rakarrack.sourceforge.net/)
- [Raysession](https://github.com/Houston4444/RaySession)
- [Surge-XT](https://surge-synthesizer.github.io/)
- [Tal-plugins](https://tal-software.com/)
- [Tap-plugins](https://tomscii.sig7.se/tap-plugins/)
- [Zam-plugins](https://www.zamaudio.com/?p=976)

...And a lot more thanks to the [KX.Studio](https://kx.studio/) repo.  Please consider sending contributions or donations to any of these projects!
