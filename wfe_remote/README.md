# SBC WFE_Remote

A docker version of the WifiExplorer remote sensor (see https://www.intuitibits.com/products/wifi-explorer-pro/ for product details)

To build it yourself, run the following on your Docker host:

```
git clone https://github.com/wifinigel/sbc_wfe_remote.git
cd sbc_wfe_remote
docker build -t sbcprobe/wfe_remote .
```

To run the container

```
# container not peristant
docker run -d -it --rm --net host --privileged --name wifiexplorer-sensor sbcprobe/wfe_remote:latest
# container starts automatically & persists
docker run -d -it --restart always --net host --privileged --name wifiexplorer-sensor sbcprobe/wfe_remote:latest
```

