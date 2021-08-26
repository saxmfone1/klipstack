
BUILD := $(shell git rev-parse --short HEAD)


.PHONY: klipper
klipper:
	sudo docker buildx build --platform linux/arm/v7 --load moonraker -t klipper:$(BUILD)

.PHONY: moonraker
moonraker:
	sudo docker buildx build --platform linux/arm/v7 --load moonraker -t moonraker:$(BUILD)

.PHONY: fluidd
fluidd:
	sudo docker buildx build --platform linux/arm/v7 --load fluidd -t fluidd:$(BUILD)
