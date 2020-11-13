# SBC Commands

A series of scripts to use as commands to simplify operation of the Docker env for an SBC probe. These scripts run on the Docker host and can be used for functions such as creating and destroying containers, together with listing images and containers.

If you'd like to completely re-initialize your environment and get rid of all images and containers, use the following command:

```
sbc_init
```

To install the scripts, perform the following commands at the end of your Docker host build:

```
git clone https://github.com/wifinigel/sbc_network_probe.git
cd sbc_network_probe/commands
sh ./install.sh
```

## Command summary

```
# Re-initialize Docker to clear all images & containers
sbc_init

# List all containers
sbc_containers_list

# Remove all containers
sbc_containers_clear

# List all images
sbc_images_list

# Remove all images
sbc_images_remove

# Generic form of container creation
sbc_<container name>_create

# Generic form of container destruction
sbc_<container name>_destroy

# example container creation
sbc_tftpd_create

# example container destruction
sbc_tftp_destroy
```

Remember, to see all possible commands, tab completion is your friend:
```
sbc_ <tab> <tab>
```


