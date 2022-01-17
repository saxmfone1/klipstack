# KLIPSTACK
## An easy way to run Klipper, Moonraker and Fluidd on your Raspberry Pi in Docker

### Requirements
- Make
- Docker (installed via Make)
- Docker Compose (installed via Make)

## Build Requirements
- Docker Buildkit + quemu-user-static + binfmt_misc (if building on an arch other than linux/arm/v7)

### Quickstart
Clone the git repository in your directory of choice on the Pi.

Run `make dependencies` to install the dependencies for Debian and Ubuntu based images. For other Linux distros, make sure to install Docker and a recent version of docker-compose.

Run `make generate-klipper-conf` to generate the proper config file to build the firmware. Choose the correct settings for your printer board. You can usually find hints for what to choose by looking at the example config for the Klipper runtime or by searching the internet. 

Run `make firmware` to generate the firmware binary. If you have a board that loads firmware from an sdcard, such as the SKR Mini, the file will be saved in `klipstack/firmware/out/klipper.bin`. Load this file to the flash and you can move on to running the compose.

If you flash your firmware via USB, determine your USB device by running `make list-usb` and then run `make flash FLASH_DEVICE=<your usb path here>`

Once flashed, you can now run Klipstack from Docker Compose.

Copy in the relevant Klipper and Moonraker configs into `klipstack/conf`. Alternatively, rename the example files that are included and edit those. 

**Warning:** The klipper config is just directly copied from the example SKR Mini E3 v2 board in the Klipper repo. You can find [example configs for Klipper here](https://github.com/KevinOConnor/klipper/tree/master/config).

Change into the directory and run:

`make pull start`

This will pull down pre-built images from this repo and bring them up. 

### Building from source
In order to build from source, you will also need to clone the submodules. After cloning you can issue the following command:

`git submodule update --init --recursive`

This will pull down the Klipper, Moonraker, and Fluidd projects.

You can then issue a `make klipper` or `make moonraker` or `make fluidd` to build the containers for each. It will tag them with the git hash.
