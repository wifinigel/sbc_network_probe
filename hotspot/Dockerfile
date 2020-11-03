# Image that creates a temporary hotspot
# with dhcp, NAT & forwarding to eth0 
FROM alpine:3.12

LABEL maintainer="wifinigel@gmail.com" \
      version="0.01" \
      documentation="https://github.com/wifinigel/sbc_network_probe/hotspot"

RUN apk update && apk add hostapd dhcp tini iw iptables \
    && rm /var/cache/apk/*

ADD . .
RUN mkdir -p /etc/sbc_probe/hotspot \
    && chmod +x /launchpoint.sh

# Add Tini to process signals
ENTRYPOINT ["/sbin/tini", "-v", "--"]
CMD ["/launchpoint.sh"]

# Props to HARTEK for this article that helped me out a lot:
# https://fwhibbit.es/en/automatic-access-point-with-docker-and-raspberry-pi-zero-w
#
# Usage:
# docker build -t sbcprobe/hotspot .
# docker run -d -i -t  --rm --net host --privileged --name hotspot sbcprobe/hotspot:latest
# docker run -d -i -t  --rm --net host -v /etc/sbc_probe/hotspot:/etc/sbc_probe/hotspot:ro --privileged --name hotspot sbcprobe/hotspot:latest