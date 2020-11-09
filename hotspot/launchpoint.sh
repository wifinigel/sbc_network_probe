#!/usr/bin/env sh

HOSTAPDID=0
DHCPDID=0

main() {

    trap 'tidy_up' TERM INT
    rm -rf /tmp/*
    
    iptables_on
    /sbin/ifdown wlan0
    /sbin/ifup wlan0 
    

    # launch hostapd
    hostapd_proc
    HOSTAPDID=$!
    echo "hostadp PID = $HOSTAPDID"

    # launch dhcpd
    touch /tmp/dhcpd.leases

    dhcpd_proc
    DHCPDID=$!
    echo "dhcpd PID = $DHCPDID"

        sleep 1
    echo "Process list:"
    ps -elf

    echo "Started."

    wait $HOSTAPDID

    tidy_up
}

# launch hostapd
function hostapd_proc () {
    HOSTAPD_CONF=/etc/hostapd.conf
    HOSTAPD_USER_CONF=/etc/sbc_probe/hotspot/hostapd.conf

    # Use user-defined cfg file in host machine dir /etc/sbc_probe/hotspot/hostapd.conf
    # if volume has been mounted at run time
    if [ -e $HOSTAPD_USER_CONF ]; then
        HOSTAPD_CONF=$HOSTAPD_USER_CONF
    fi

    echo File used for hostapd = $HOSTAPD_CONF
    /usr/sbin/hostapd -i wlan0 $HOSTAPD_CONF &
}

# launch dhcpd
function dhcpd_proc () {
    /usr/sbin/dhcpd -f -cf /etc/dhcp/dhcpd.conf -pf /tmp/dhcp.pid -lf /tmp/dhcpd.leases &
}

function iptables_on () {
    iptables-nft -t nat -C POSTROUTING -o eth0 -j MASQUERADE || iptables-nft -t nat -A POSTROUTING -o eth0 -j MASQUERADE
    iptables-nft -C FORWARD -i eth0 -o wlan0 -m state --state RELATED,ESTABLISHED -j ACCEPT || iptables-nft -A FORWARD -i eth0 -o wlan0 -m state --state RELATED,ESTABLISHED -j ACCEPT
    iptables-nft -C FORWARD -i wlan0 -o eth0 -j ACCEPT || iptables-nft -A FORWARD -i wlan0 -o eth0 -j ACCEPT
}

function iptables_off () {
    iptables-nft -t nat -C POSTROUTING -o eth0 -j MASQUERADE && iptables-nft -t nat -D POSTROUTING -o eth0 -j MASQUERADE
    iptables-nft -C FORWARD -i eth0 -o wlan0 -m state --state RELATED,ESTABLISHED -j ACCEPT && iptables-nft -D FORWARD -i eth0 -o wlan0 -m state --state RELATED,ESTABLISHED -j ACCEPT
    iptables-nft -C FORWARD -i wlan0 -o eth0 -j ACCEPT && iptables-nft -D FORWARD -i wlan0 -o eth0 -j ACCEPT
}


# kill procs to tidy up on signal
function tidy_up() {
    echo "Signal received, tidying up..."

    echo "Process list:"
    ps -elf
    
    echo "Killing hostapd..."
    kill $HOSTAPDID

    echo "Killing dhcpd..."
    kill $DHCPDID

    echo "Restoring iptables..."
    iptables_off

    echo "Taking wlan0 down..."
    ip addr flush dev  wlan0
    ip link set wlan0 down

    echo "Summary info:"
    sleep 1
    ps -elf
    ifconfig -a

    exit 0
}

# Call main
main