# Image: sbcprobe/wconsole
# Image that creates a remote serail console cnnection

FROM alpine:3.12

LABEL maintainer="wifinigel@gmail.com" \
      version="0.01" \
      documentation="https://github.com/wifinigel/sbc_network_probe/wconsole"

RUN apk update && apk add hostapd dhcp tini iw iproute2 ser2net \
    && rm /var/cache/apk/*

ADD . .
RUN mkdir -p /etc/sbc_probe/wconsole \
    && chmod +x /launchpoint.sh

# Add Tini to process signals
ENTRYPOINT ["/sbin/tini", "-v", "--"]
CMD ["/launchpoint.sh"]

#
# Usage:
# git clone https://github.com/wifinigel/sbc_network_probe.git
# cd wconsole
# docker build -t sbcprobe/wconsole .
# docker run -d -i -t --restart always --net host --privileged --name wconsole sbcprobe/wconsole:latest
# docker run -d -i -t --restart always --net host -v /etc/sbc_probe/wconsole:/etc/sbc_probe/wconsole:ro --privileged --name wconsole sbcprobe/wconsole:latest