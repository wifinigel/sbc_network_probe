# SBC Network Probe

There are many Single-Board Computers (SBC) available which can provide a powerful, low cost solution when used as a network probe to gather data for troubleshooting and analysis. This can include functions such as packet captures, performance testing and end-user experience data gathering. My own personal preference is for Wi-Fi related tools, but many of the tools are applicable to other networking technology areas.

Although these functions are readily available via existing Linux utilities and various open source packages, they can be quite challenging to set up and get working in short timescales.

After recently learning about the power of containers and Docker, I decided to try packaging up a number of utilities that could be quickly and easily pulled on to an SBC as required to provide a number of different network testing "personas". 

At any time, the SBC can run one persona, as provided by an easily obtainable container. This can be swapped out for another persona at a later time when a different feature is required. For example, the SBC may be configured as a wireless hotspot for one activity, then reconfigured as a TFTP server for a later activity - all achieved by swapping containers in and out as required.

The containers are run on a docker host, which in my case is a Ubuntu 20.04 image that is built using the instructions provided below. The image only needs to be built once. The containers are then installed and removed as required to provide the required network utilities.

## Supported Platforms
![Neo3 Image](neo3.jpg)

As this project is still in its infancy, only one low cost SBC has been tested to date: the [Friendly Elec NEO3-LTS][neo3]. Theoretically, any similar Arm64 SBC running Ubuntu 20.04 will likely work fine with the containers provided in this project.

Here is a basic build guide for the Neo3 to be used for the SBC probe project: [link][neo3_build]


### Supported Wireless Adapters

Some of the functions provided by this project require wireless adapters that can support monitor mode and AP mode. Support for adapter modes varies between adapters (primarily determined by their wireless chipset). Unfortunately Linux adapter support is generally very limited and/or variable when looking for advanced features such as monitor mode and frame injection.

During testing with the recommended base [platform build][neo3_build], the following adapters appear to work well for all containers (this list will hopefully become refined over time):

* Comfast CF-912  (2 stream adapter)
* Comfast CF-915  (1 stream adapter)

## Docker Images 

The following docker images are available for this project:

* tftpd
    * DockerHub link: https://hub.docker.com/repository/docker/sbcprobe/tftpd
    * GitHub: https://github.com/wifinigel/sbc_network_probe/tree/main/tftpd
* tcpdumper 
    * DockerHub link: https://hub.docker.com/repository/docker/sbcprobe/tcpdumper
    * GitHub: https://github.com/wifinigel/sbc_network_probe/tree/main/tcpdumper
* hotspot
    * DockerHub link: https://hub.docker.com/repository/docker/sbcprobe/hotspot
    * GitHub: https://github.com/wifinigel/sbc_network_probe/tree/main/hotspot
* wfe_remote
    * DockerHub link: https://hub.docker.com/repository/docker/sbcprobe/wfe_remote
    * GitHub: https://github.com/wifinigel/sbc_network_probe/tree/main/wfe_remote
* wconsole
    * DockerHub link: https://hub.docker.com/repository/docker/sbcprobe/wconsole
    * GitHub: https://github.com/wifinigel/sbc_network_probe/tree/main/wconsole

There are other Docker images available that are not part of this project, but are useful for your test probe. Check out these other publicly available images (link below): 

[Tested_containers](Tested_Containers.md)



__Note:__ After creating and using each container, it is strongly advised that you remove it before creating another container on the same host (some containers take over the host networking and will not play nicely with other containers):

```
# remove container (force removal even if running)
docker container rm -f tftpd
docker container rm -f hotspot
docker container rm -f tcpdumper
docker container rm -f wfe_remote
docker container rm -f wconsole
```

<!-- Link list -->
[neo3]: https://www.friendlyarm.com/index.php?route=product/product&product_id=279
[neo3_build]: https://github.com/wifinigel/sbc_network_probe/blob/main/Probe_base_image_build(Neo3).md