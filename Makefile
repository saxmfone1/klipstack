
BUILD := $(shell git rev-parse --short HEAD)
HOME := $(shell pwd)

.PHONY: klipper
klipper:
	docker buildx build --platform linux/arm/v7 --load klipper -t klipper:$(BUILD)

.PHONY: moonraker
moonraker:
	docker buildx build --platform linux/arm/v7 --load moonraker -t moonraker:$(BUILD)

.PHONY: fluidd
fluidd:
	docker buildx build --platform linux/arm/v7 --load fluidd -t fluidd:$(BUILD)

.PHONY: generate-klipper-conf
generate-klipper-conf:
	docker run --rm -it --user 0 --platform linux/arm/v7 --entrypoint bash -v $(HOME)/klipstack/firmware/conf:/home/klippy/conf klipper:$(BUILD) -c "make -C /home/klippy/klipper menuconfig KCONFIG_CONFIG=/home/klippy/conf/.config && chown -R 1000:1000 /home/klippy/conf"

.PHONY: firmware
firmware:
	docker run --rm -it --user 0 --platform linux/arm/v7 --entrypoint bash -v $(HOME)/klipstack/firmware/conf:/home/klippy/conf -v $(HOME)/klipstack/firmware/out:/home/klippy/klipper/out klipper:$(BUILD) -c "make -C /home/klippy/klipper KCONFIG_CONFIG=/home/klippy/conf/.config && chown -R 1000:1000 /home/klippy/klipper/out"

.PHONY: flash
flash:
	docker run --rm -it --user 0 --platform linux/arm/v7 --entrypoint bash -v /dev:/dev -v $(HOME)/klipstack/firmware/out:/home/klippy/klipper/out klipper:$(BUILD) -c "make -C /home/klippy/klipper flash FLASH_DEVICE=$(FLASH_DEVICE)"

.PHONY: list-usb
list-usb:
	docker run --rm -it --user 0 --platform linux/arm/v7 --entrypoint bash -v /dev:/dev -v $(HOME)/klipstack/firmware/out:/home/klippy/klipper/out klipper:$(BUILD) -c "ls -al /dev/serial/by-id/*"