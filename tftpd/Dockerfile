# Image that creates a tftfd server with rw access to allow uploads in addition to downloads
FROM alpine:3.12

LABEL maintainer="wifinigel@gmail.com" \
      version="0.01" \
      documentation="https://github.com/wifinigel/sbc_network_probe/tftpd"

RUN apk update && apk add tftp-hpa \
    && rm /var/cache/apk/* 

EXPOSE 69/udp

ENTRYPOINT [ "in.tftpd", "--foreground", "--create", "--secure", "/tmp"]

#
# Usage:
# docker build -t sbcprobe/tftpd .
# docker run -d -i -t  -p 69:69/udp  -v /tmp:/tmp:rw --name tftpd sbcprobe/tftpd:latest
