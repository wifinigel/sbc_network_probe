# Image: sbcprobe/tftpd
# Image that creates a tftfd server with rw access to allow uploads in addition to downloads

FROM alpine:3.12

LABEL maintainer="wifinigel@gmail.com" \
      version="0.02" \
      documentation="https://github.com/wifinigel/sbc_network_probe/tftpd"

RUN apk update && apk add tftp-hpa \
    && rm /var/cache/apk/* \
    && mkdir -p /var/tftpboot \
    && chmod 666 /var/tftpboot

EXPOSE 69/udp

ENTRYPOINT [ "in.tftpd", "--foreground", "--create", "--secure", "/var/tftpboot"]

#
# Usage:
# git clone https://github.com/wifinigel/sbc_network_probe.git
# cd tftpd
# docker build -t sbcprobe/tftpd .
# docker run -d -i -t --restart always -p 69:69/udp  -v /var/tftpboot:/var/tftpboot:rw --name tftpd sbcprobe/tftpd:latest
