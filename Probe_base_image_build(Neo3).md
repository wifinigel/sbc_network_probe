
## Base Image Build (Neo3)

1. Go to the image download page for the Neo3 on the Armbian site:

    https://www.armbian.com/nanopineo3/

2. Select the "Armbian Buster" direct download link (at time of writing, this was: https://redirect.armbian.com/nanopineo3/Buster_current)

3. Burn the image on to an SD card (16G or better recommended) using balenaEtcher (https://www.balena.io/etcher/)

4. Once the image is burned on to the SD card, put the SD card in to the Neo3 and power it on

5. Plug the Neo3 in to an Ethernet port so that it can get an IP address (You will likely need to look on your DHCP server or switch MAC/ARP table to figure out the IP address assigned). The port will also need Internet access to allow package downloads.

6. Once you have the IP address of the Neo3, SSH to it and login with the following credentials:
    ```
    username: root
    password: 1234
    ```

7. During this initial login, you will be prompted to provide:
    a. New root password
    b. optionally configure your locale
    c. Create an "every day" user account that should be used to administer the probe (e.g. dockeruser)

8. Create a Linux group for docker and add your everyday user to the group. This ensures that docker commands can be executed by your everyday users and avoid using the root user for executing docker commands:
    ```
    sudo groupadd docker
    sudo usermod -aG docker dockeruser
    ```

8. Drop the SSH session and establish a new session using the new username.

9. The NetworkManager package can be very problematic for networking, so we need to disable it. Follow these steps to disable it and create a static configuration file for eth0:

    a. Create a static config file to ensure eth0 gets an IP address from DHCP

    ```
    sudo sh -c "printf '\n\nallow-hotplug eth0 \niface eth0 inet dhcp\n' >> /etc/network/interfaces"
    ```

    b. Disable NetworkManager
    ```
    sudo systemctl stop NetworkManager
    sudo systemctl disable NetworkManager
    ```

    c. Reboot:

    ```
    sudo reboot
    ```

10. Perform an update of all packages before adding any new software, followed by a reboot of the probe:
    ```
    sudo apt-get update
    sudo apt-get -y upgrade
    # add update to use traditional interface names (e.g. wlan0)
    sudo sh -c "echo 'extraargs=net.ifnames=0' >> /boot/armbianEnv.txt"
    sudo sync; sudo reboot
    ```
11. SSH back in to the probe and add a number of required packages:
    ```
    sudo apt-get update
    sudo apt-get -y install docker docker.io 
    sudo apt-get -y install cockpit cockpit-docker
    ```
12. Start Cockpit:
    ```
    sudo systemctl start cockpit
    ```
13. Login to Cockpit using your everyday account (check the checkbox for privileged tasks) and view Cockpit GUI (inc Containers menu item on left)

    http://ip_address:9090/

14. To add a test container, on the CLI of the probe, execute the following commands to load up an Openspeedtest container:
    ```
    docker pull openspeedtest/latest
    docker run --restart=unless-stopped --name=openspeedtest -d -p 80:8080 openspeedtest/latest
    ```
    (Check in Containers section of Cockpit - new openspeedtest container now available)

    Browse to http://ip_address and see Openspeedtest GUI




