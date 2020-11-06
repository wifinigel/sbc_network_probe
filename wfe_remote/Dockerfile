# Image: sbcprobe/wfe_remote
# Image that creates a WifiExplorer remote sensor

FROM python:3.8-alpine

LABEL maintainer="wifinigel@gmail.com" \
      version="0.01" \
      documentation="https://github.com/wifinigel/sbc_network_probe/wfe_remote"

RUN apk update && apk add iw wget iproute2 \
    && rm /var/cache/apk/* \
    && pip install scapy

WORKDIR /usr/local/bin
RUN wget https://raw.githubusercontent.com/intuitibits/wifiexplorer-sensor/master/wifiexplorer-sensor \
    && chmod +x /usr/local/bin/wifiexplorer-sensor

ENTRYPOINT [ "python", "/usr/local/bin/wifiexplorer-sensor",  "wlan0",  ">", "/tmp/wifiexplorer-sensor.log",  "2>&1" ]

# The original code for this utility is created by Adrian Granados. Original documentation at:
# https://github.com/intuitibits/wifiexplorer-sensor
# Check out his fantastic wireless products at: https://www.intuitibits.com/products/wifi-explorer-pro/
#
# Usage:
# git clone https://github.com/wifinigel/sbc_network_probe.git
# cd wfe_remote
# docker build -t sbcprobe/wfe_remote .
# docker run -d -it --net host --privileged --name wifiexplorer-sensor sbcprobe/wfe_remote:latest
