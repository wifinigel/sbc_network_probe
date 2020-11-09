# SBC wconsole

Turn your SBC probe in to a wireless serial console.

## Pre-requisites

Build the host machine as recommended is [this document][main_index].

Unless you are using a host device that has 2 USB ports, you will need a USB hub for this project, as 2 USB port are required. For instance, the Neo3 has only one USB port, so will require a USB hub.

Insert a wireless NIC that supports AP mode in to one USB port. Insert a USB to serial port connector cable in to the other USB port.

__Caveat:__ The power drain caused by some USB devices may cause operational issues (e.g. WLAN NIC bouncing unexpectedly). Try to use small, low power devices, ir perhaps use a powered USB hub if you run in to issues.

## Pull & Run From Dockerhub

To run with default SSID & password:

```
docker run -d -i -t --restart always --net host --privileged --name wconsole sbcprobe/wconsole:latest
```

To run using hostapd config file in host machine file /etc/sbc_probe/wconsole/hostapd.conf:

```
docker run -d -i -t --restart always --net host -v /etc/sbc_probe/wconsole:/etc/sbc_probe/wconsole:ro --privileged --name wconsole sbcprobe/wconsole:latest
```

## Build Your Own Image From the Dockerfile

To build the image yourself, run the following on your Docker host:

```
git clone https://github.com/wifinigel/sbc_network_probe.git
cd sbc_network_probe
cd wconsole
docker build -t sbcprobe/wconsole .
```

To run with default SSID & password:

```
docker run -d -i -t --restart always --net host --privileged --name wconsole sbcprobe/wconsole:latest
```

To run using hostapd config file in host machine file /etc/sbc_probe/wconsole/hostapd.conf:

```
docker run -d -i -t --restart always --net host -v /etc/sbc_probe/wconsole:/etc/sbc_probe/wconsole:ro --privileged --name wconsole sbcprobe/wconsole:latest
```

## GitHub Repo

More info at the GitHub Repo : [here][github_repo]

## More Info

This image is based on the WLAN Pi wconsole project. See this page for more information on how to use this image, please see the following related page: [project page][wconsole]

The default IP that will be assigned to your wireless client will be in the range 192.168.88.0/24. The host device will use an address of 192.168.88.1. Therefore, to access your serial console port using a 9600bps serial connection, open a telnet session to 192.168.88.1:9600. (See the [project page][wconsole] shown above for a more detailed explanation of how this all works).

<!-- Link list -->
[main_index]: https://github.com/wifinigel/sbc_network_probe/blob/main/README.md
[github_repo]: https://github.com/wifinigel/sbc_network_probe
[wconsole]: https://github.com/WLAN-Pi/wconsole