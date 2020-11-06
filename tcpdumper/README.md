# SBC TCPDumper

A container running an sshd server with tcpdump to allow remote streaming of wireless packet capture (e.g. Wireshark, WinFi)

## Pre-requisites

Build the host machine as recommended is [this document][main_index].

Also, connect eth0 to an Internet connected Ethernet switch port, and insert a wireless NIC that supports Monitor mode in to the USB port.

## Pull & Run From Dockerhub

On a host machine simply enter one of these commands:

```
# container not peristent (disappears on reboot or container stop)
docker run -d --net host --privileged --name tcpdumper sbcprobe/tcpdumper

# container starts automatically & persists (always started on reboot/power-up)
docker run -d --net host --privileged --restart always --name tcpdumper sbcprobe/tcpdumper
```

## Build Your Own Image From the Dockerfile

To build the image yourself, run the following on your Docker host:


```
git clone https://github.com/wifinigel/sbc_network_probe.git
cd tcpdumper
docker build -t sbcprobe/tcpdumper .
```

To run the built container use one of these commands:

```
# container not peristent (disappears on reboot or container stop)
docker run -d --net host --privileged --name tcpdumper sbcprobe/tcpdumper

# container starts automatically & persists(always started on reboot/power-up)
docker run -d --net host --privileged --restart always --name tcpdumper sbcprobe/tcpdumper
```

<!-- Link list -->
[main_index]: https://github.com/wifinigel/sbc_network_probe/blob/main/README.md