# SBC WFE Remote

A docker version of the WifiExplorer sensor (see https://www.intuitibits.com/products/wifi-explorer-pro/ for product details)

## Pre-requisites

Build the host machine as recommended is [this document][main_index].

Also, connect eth0 to an Internet connected Ethernet switch port, and insert a wireless NIC that supports Monitor mode in to the USB port.

## Pull & Run From Dockerhub

On a host machine simply enter one of these commands:

```
# container not peristent (disappears on reboot or container stop)
docker run -d -it --rm --net host --privileged --name wifiexplorer-sensor sbcprobe/wfe_remote:latest

# container starts automatically & persists (always started on reboot/power-up)
docker run -d -it --restart always --net host --privileged --name wifiexplorer-sensor sbcprobe/wfe_remote:latest
```

## Build Your Own Image From the Dockerfile

To build the image yourself, run the following on your Docker host:


```
git clone https://github.com/wifinigel/sbc_network_probe.git
cd wfe_remote
docker build -t sbcprobe/wfe_remote .
```

To run the built container use one of these commands:

```
# container not peristent (disappears on reboot or container stop)
docker run -d -it --rm --net host --privileged --name wifiexplorer-sensor sbcprobe/wfe_remote:latest

# container starts automatically & persists(always started on reboot/power-up)
docker run -d -it --restart always --net host --privileged --name wifiexplorer-sensor sbcprobe/wfe_remote:latest
```

## GitHub Repo

More info at the GitHub Repo : [here][github_repo]

<!-- Link list -->
[main_index]: https://github.com/wifinigel/sbc_network_probe/blob/main/README.md
[github_repo]: https://github.com/wifinigel/sbc_network_probe