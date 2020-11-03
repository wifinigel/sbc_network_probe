# SBC Network Probe

There are many Single-Board Computers (SBC) available which can provide a powerful, low cost solution when used as a network probe to gather data for troubleshooting and analysis. This can include functions such as packet captures, performance testing and end-user experience data gathering.

Although these functions are readily available via existing Linux utilities and various open source packages, they can be quite challenging to set up and get working in short timescales.

After recently learning about the power of containers and Docker, I decided to try packaging up a number of utilities that could be quickly and easily pulled on to an SBC as required to provide a number of different network testing "personas". At any time, the SBC can run one persona, as provided by an easily obtainable container. This can be swapped out for another persona at a later time when a different feature is required. For example, the SBC may be configured as a wireless hotspot for one activity, then reconfigured as a TFTP server for a later activity - all achieved by swapping containers in and out as required.

## Supported Platforms

As this project is still in its infancy, only one low cost SBC has been tested to date: the [Friendly Elec NEO3-LTS][neo3]. Theoretically, any similar Arm64 SNC running Ubuntu 20.04 will likely work fine with the containers provided in this project.

Here is a basic build guide for the Neo3 to be used for the SBC probe project: [link][neo3_build]


### Supported Wireless Adapters

Some of the functions provided by this project require wireless adapters that can support monitor mode and AP mode. Support for the modes varies from adapter to adapter, but I will provide a list of tested adapters in due course.

<!-- Link list -->
[neo3]: https://www.friendlyarm.com/index.php?route=product/product&product_id=279
[neo3_build]: https://github.com/wifinigel/sbc_network_probe/blob/main/Probe_base_image_build(Neo3).md