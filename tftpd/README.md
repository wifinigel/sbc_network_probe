# SBC tftp Server

A simple TFTP server (mainly for lab use) that allows download and upload of files. Please remember that tftp is insecure and should only be used for brief, internal network applications such as in a pre-staging or in a lab environment. __Do not deploy in prod environments.__ 

## Pre-requisites

Build the host machine as recommended is [this document][main_index].

Also, connect eth0 to an Ethernet switch port that will supply an IP address via DHCP. (Note that Internet connectivity is required for the initial docker image pull or while you are building the image from scratch)

## Pull & Run From Dockerhub

On a host machine enter this command:

```
docker run -d -i -t  -p 69:69/udp  -v /tmp:/tmp:rw --name tftpd sbcprobe/tftpd:latest
```

## Build Your Own Image From the Dockerfile

To build the image yourself, run the following on your Docker host:


```
git clone https://github.com/wifinigel/sbc_network_probe.git
cd tftpd
docker build -t sbcprobe/tftpd .
```

To run the built container use the following command:

```
# docker run -d -i -t  -p 69:69/udp  -v /tmp:/tmp:rw --name tftpd sbcprobe/tftpd:latest
```

## Using tftpd

Once the container is running, files may be uploaded and downloaded via the `/tmp` directory of the _host_ machine (not the container).

## Caveat

__Remember:__ tftp is insecure and should only be used in protected environments and for brief/trivial activities (e.g. lab work)

<!-- Link list -->
[main_index]: https://github.com/wifinigel/sbc_network_probe/blob/main/README.md