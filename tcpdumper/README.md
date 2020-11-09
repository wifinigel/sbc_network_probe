# SBC TCPDumper

A container running an sshd server with tcpdump to allow remote streaming of a wireless packet capture (e.g. Wireshark, WinFi)

The SSH server uses simple password-based authentication, with the SSH account password being set via the docker run command. 

The SSH session allows a stream of frame capture data (gathered by tcpdump) to be streamed back to tools such as Wireshark and WinFi for decoding/analysis

This Dockerfile is heavily influenced by the amazing work done by the project: panubo/sshd (https://github.com/panubo/docker-sshd). The quality of the work put in to that project is superb. Thanks to them for making their work available to help me create this image.

## Pre-requisites

Build the host machine as recommended is [this document][main_index].

Also, connect eth0 to an Internet-connected Ethernet switch port, and insert a wireless NIC that supports Monitor mode in to the USB port.

## Pull & Run From Dockerhub

On a host machine simply enter one of these commands:

```
# container not peristent (disappears on reboot or container stop)
docker run -d --net host --privileged --name tcpdumper -e SSH_PWD=password1 sbcprobe/tcpdumper

# container starts automatically & persists (always started on reboot/power-up)
docker run -d --net host --privileged --restart always --name tcpdumper -e SSH_PWD=password1 sbcprobe/tcpdumper
```

(See *SSH Login Notes* below for more password options)

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
docker run -d --rm --net host --privileged --name tcpdumper -e SSH_PWD=password1 sbcprobe/tcpdumper

# container starts automatically & persists(always started on reboot/power-up)
docker run -d --net host --privileged --restart always --name tcpdumper -e SSH_PWD=password1 sbcprobe/tcpdumper
```

(See *SSH Login Notes* below for more password options)

## SSH Login Notes

SSH login details:

* User: tcpdumper
* Pwd: *(set from docker run command - see below)*
* Port: 8022

Set the password on the command line with the docker run command using the "-e SSH_PWD" option:
```
docker run -d --restart always --net host --privileged --name tcpdumper -e SSH_PWD=ComplexPassword sbcprobe/tcpdumper
```

__*Or*,__ allow a password to be generated on startup and view it in the docker logs (only on first startup of container):
```
docker run -d --restart always --net host --privileged --name tcpdumper sbcprobe/tcpdumper
docker logs tcpdumper  # (look for line with text like this: *** Randomized SSH pwd: sDyfpklnyhbT ***)
```


## GitHub Repo

More info at the GitHub Repo : [here][github_repo]

## Credits

This Dockerfile is heavily influenced by the amazing work done for the project: panubo/sshd (https://github.com/panubo/docker-sshd). The quality
of the work put in to that project is superb. Thanks for sharing. 

<!-- Link list -->
[main_index]: https://github.com/wifinigel/sbc_network_probe/blob/main/README.md
[github_repo]: https://github.com/wifinigel/sbc_network_probe