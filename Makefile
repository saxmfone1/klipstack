
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
generate-klipper-conf: klipper
	docker run --rm -it --platform linux/arm/v7 --entrypoint bash -v $(HOME)/firmware/conf:/home/klippy/conf klipper:$(BUILD) -c "make -C /home/klippy/klipper menuconfig KCONFIG_CONFIG=/home/klippy/conf && chown /home/klippy/conf"
 