# SBC Hotspot

A ready made hotspot for your SBC probe.

To build it yourself, run the following on your Docker host:

```
git clone https://github.com/wifinigel/sbc_network_probe.git
cd sbc_network_probe
cd hotspot
docker build -t sbc-probe/hotspot .
```

To run with default SSID & password:

```
docker run -d -i -t  --rm --net host --privileged --name hotspot sbc-probe/hotspot:latest
```

To run using hostapd config file in host machine file /etc/sbc_probe/hotspot/hostapd.conf:

```
docker run -d -i -t  --rm --net host -v /etc/sbc_probe/hotspot:/etc/sbc_probe/hotspot:ro --privileged --name hotspot sbc-probe/hotspot:latest
```

