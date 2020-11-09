#!/usr/bin/env sh

HOSTAPDID=0
DHCPDID=0
SER2NETID=0

main () {

    trap 'tidy_up' TERM INT
    rm -rf /tmp/*
    
    ifdown wlan0
    ifup wlan0    

    # launch hostapd
    hostapd_proc
    HOSTAPDID=$!
    echo "hostadp PID = $HOSTAPDID"

    # launch dhcpd
    touch /tmp/dhcpd.leases

    dhcpd_proc
    DHCPDID=$!
    echo "dhcpd PID = $DHCPDID"

    # launch ser2net
    ser2net_proc
    SER2NETID=$!
    echo "ser2net PID = $SER2NETID"

    sleep 1
    ps -elf

    echo "Running..."

    wait $HOSTAPDID

    tidy_up
}

# launch hostapd
function hostapd_proc () {
    HOSTAPD_CONF=/etc/hostapd.conf
    HOSTAPD_USER_CONF=/etc/sbc_probe/wconsole/hostapd.conf

    # Use user-defined cfg file in host machine dir /etc/sbc_probe/wconsole/hostapd.conf
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

# launch ser2net
function ser2net_proc () {
    /usr/sbin/ser2net -c /etc/ser2net.conf -n &
}

# kill procs to tidy up on signal
function tidy_up() {
    echo "Signal received, tidying up..."

    echo "Process list:"
    ps -elf
    
    echo "Killing hostapd ($HOSTAPDID)..."
    kill $HOSTAPDID


    echo "Killing dhcpd ($DHCPDID)..."
    kill $DHCPDID


    echo "Killing ser2net ($SER2NETID)..."
    kill $SER2NETID


    echo "Taking wlan0 down..."
    ip addr flush dev  wlan0
    ip link set wlan0 down

    echo "Process list:"
    sleep 1
    ps -elf

    echo "Interface status:"
    ifconfig -a

    exit 0
}

# Call main
main