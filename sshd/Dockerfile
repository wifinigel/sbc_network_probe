FROM alpine:3.12

RUN apk update && \
    apk add openssh-server bash nano augeas tcpdump iw sudo wireless-tools && \
    adduser -D -s /bin/bash wlanpi

RUN echo "wlanpi:wlanpi" | chpasswd && \
    ln -s /usr/sbin/iw /sbin/iw && \
    ln -s /usr/sbin/tcpdump /usr/local/bin/tcpdump && \
    ln -s /usr/sbin/iwconfig sbin/iwconfig && \
    ln -s /bin/date /usr/bin/date &&\
    echo "wlanpi ALL = (root) NOPASSWD: /sbin/ifconfig, /usr/sbin/tcpdump, /usr/sbin/iw, /sbin/iw, /usr/sbin/iwconfig, /sbin/iwconfig, /bin/date, /usr/bin/date" >> /etc/sudoers && \
    echo -e "Port 8022\n" >> /etc/ssh/sshd_config && \
    rm -rf /var/cache/apk/*

# Provide support for legacy key exchange for Wireshark SSHDump
RUN printf "#Legacy changes \nKexAlgorithms +diffie-hellman-group1-sha1 \nCiphers +aes128-cbc" >> /etc/ssh/sshd_config

EXPOSE 8022

COPY launchpoint.sh /launchpoint.sh
RUN chmod +x /launchpoint.sh


ENTRYPOINT ["/launchpoint.sh"]
CMD ["/usr/sbin/sshd", "-D", "-e", "-f", "/etc/ssh/sshd_config"]

#
# Usage:
# docker build -t sbcprobe/sshd .
# docker run -d --net host --privileged --name sshd sbcprobe/sshd
