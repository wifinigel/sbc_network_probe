# SBC Hotspot

A ready made hotspot for your SBC probe.

## Pre-requisites

Build the host machine as recommended is [this document][main_index].

Also, connect eth0 to an Internet connected Ethernet switch port, and insert a wireless NIC that supports AP mode in to the USB port.

## Pull & Run From Dockerhub

On a host machine enter this command:

```
docker run -d -i -t --restart always --net host -v /etc/sbc_probe/hotspot:/etc/sbc_probe/hotspot:ro --privileged --name hotspot sbcprobe/hotspot:latest
```

## Build Your Own Image From the Dockerfile

To build the image yourself, run the following on your Docker host:

```
git clone https://github.com/wifinigel/sbc_network_probe.git
cd sbc_network_probe
cd hotspot
docker build -t sbcprobe/hotspot .
```

To run with default SSID & password:

```
docker run -d -i -t --restart always --net host --privileged --name hotspot sbcprobe/hotspot:latest
```

To run using hostapd config file in host machine file /etc/sbc_probe/hotspot/hostapd.conf:

```
docker run -d -i -t --restart always --net host -v /etc/sbc_probe/hotspot:/etc/sbc_probe/hotspot:ro --privileged --name hotspot sbcprobe/hotspot:latest
```

## GitHub Repo

More info at the GitHub Repo : [here][github_repo]

<!-- Link list -->
[main_index]: https://github.com/wifinigel/sbc_network_probe/blob/main/README.md
[github_repo]: https://github.com/wifinigel/sbc_network_probe