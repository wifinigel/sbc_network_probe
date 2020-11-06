#!/usr/bin/env bash

set -e

[ "$DEBUG" == 'true' ] && set -x

DAEMON=sshd

main () {

    # create our ssh user account & set pwd
    adduser -D -s /bin/bash tcpdumper
    echo "tcpdumper:framedecode" | chpasswd && \
    
    # add in some sym links to support various tools that expect these utils
    # to be in diff locations
    ln -s /usr/sbin/iw /sbin/iw && \
    ln -s /usr/sbin/iwconfig /sbin/iwconfig && \
    ln -s /bin/date /usr/bin/date &&\

    # ensure ssh account has sudo/no_pw access to important utils
    echo "tcpdumper ALL = (root) NOPASSWD: /sbin/ifconfig, /usr/sbin/tcpdump, /usr/sbin/iw, /sbin/iw, /usr/sbin/iwconfig, /sbin/iwconfig, /bin/date, /usr/bin/date" >> /etc/sudoers && \

    # run ssh server on port 8022 to avoid conflict with host
    echo -e "Port 8022\n" >> /etc/ssh/sshd_config && \

    # Provide support for legacy key exchange for Wireshark SSHDump
    printf "#Legacy changes \nKexAlgorithms +diffie-hellman-group1-sha1 \nCiphers +aes128-cbc" >> /etc/ssh/sshd_config

    # Generate Host keys, if required
    if ls /etc/ssh/keys/ssh_host_* 1> /dev/null 2>&1; then
        echo ">> Found host keys in keys directory"
        set_hostkeys
        print_fingerprints /etc/ssh/keys
    elif ls /etc/ssh/ssh_host_* 1> /dev/null 2>&1; then
        echo ">> Found Host keys in default location"
        # Don't do anything
        print_fingerprints
    else
        echo ">> Generating new host keys"
        mkdir -p /etc/ssh/keys
        ssh-keygen -A
        mv /etc/ssh/ssh_host_* /etc/ssh/keys/
        set_hostkeys
        print_fingerprints /etc/ssh/keys
    fi

    # enable password auth
    echo 'set /files/etc/ssh/sshd_config/PasswordAuthentication yes' | augtool -s 1> /dev/null

    echo "Running $*"
    if [ "$(basename $1)" == "$DAEMON" ]; then
        trap stop SIGINT SIGTERM
        "$@" &
        pid="$!"
        mkdir -p /var/run/$DAEMON && echo "${pid}" > /var/run/$DAEMON/$DAEMON.pid
        wait "${pid}"
        exit $?
    else
        exec "$@"
    fi

}

stop() {
    echo "Received SIGINT or SIGTERM. Shutting down $DAEMON"
    # Get PID
    local pid=$(cat /var/run/$DAEMON/$DAEMON.pid)
    # Set TERM
    kill -SIGTERM "${pid}"
    # Wait for exit
    wait "${pid}"
    # All done.
    echo "Done."
}

set_hostkeys() {
    printf '%s\n' \
        'set /files/etc/ssh/sshd_config/HostKey[1] /etc/ssh/keys/ssh_host_rsa_key' \
        'set /files/etc/ssh/sshd_config/HostKey[2] /etc/ssh/keys/ssh_host_dsa_key' \
        'set /files/etc/ssh/sshd_config/HostKey[3] /etc/ssh/keys/ssh_host_ecdsa_key' \
        'set /files/etc/ssh/sshd_config/HostKey[4] /etc/ssh/keys/ssh_host_ed25519_key' \
    | augtool -s 1> /dev/null
}

print_fingerprints() {
    local BASE_DIR=${1-'/etc/ssh'}
    for item in dsa rsa ecdsa ed25519; do
        echo ">>> Fingerprints for ${item} host key"
        ssh-keygen -E md5 -lf ${BASE_DIR}/ssh_host_${item}_key
        ssh-keygen -E sha256 -lf ${BASE_DIR}/ssh_host_${item}_key
        ssh-keygen -E sha512 -lf ${BASE_DIR}/ssh_host_${item}_key
    done
}


########################
# Call main
########################
main "$@"