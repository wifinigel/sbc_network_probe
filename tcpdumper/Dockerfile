FROM alpine:3.12

RUN apk update && \
    apk add openssh-server bash augeas tcpdump iw sudo wireless-tools && \
    rm -rf /var/cache/apk/*

EXPOSE 8022

COPY launchpoint.sh /launchpoint.sh
RUN chmod +x /launchpoint.sh


ENTRYPOINT ["/launchpoint.sh"]
CMD ["/usr/sbin/sshd", "-D", "-e", "-f", "/etc/ssh/sshd_config"]

# A docker image to run an ssh server and provide a number of commands to 
# allow remote wireless capture. It uses simple password-based authentication.
# An SSH session allows a stream of frame capture data (gathered by tcp dump)
# to be streamed back for tools such as Wireshark and WinFi  
#
# This Dockerfile is heavily influenced by the amazing work done for the 
# project: panubo/sshd (https://github.com/panubo/docker-sshd). The quality
# of the work put in to that project is superb. 
#
# Usage:
# git clone https://github.com/wifinigel/sbc_network_probe.git
# cd tcpdumper
# docker build -t sbcprobe/tcpdumper .
# docker run -d --net host --privileged --name tcpdumper sbcprobe/tcpdumper
# docker run -d --net host --privileged --restart always --name tcpdumper sbcprobe/tcpdumper