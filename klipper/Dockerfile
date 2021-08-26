FROM ubuntu:18.04

RUN apt-get update && \
    apt-get install -y \
    virtualenv \
    python-dev \
    libffi-dev \
    build-essential \
    libncurses-dev \
    libusb-dev \
    avrdude \
    gcc-avr \
    binutils-avr \
    avr-libc \
    stm32flash \
    libnewlib-arm-none-eabi \
    gcc-arm-none-eabi \
    binutils-arm-none-eabi \
    libusb-1.0


RUN groupadd -g 1000 3dprinters
RUN useradd -ms /bin/bash -G dialout,3dprinters -u 1000 -g 1000 klippy
COPY klipper /home/klippy/klipper
RUN chown -R klippy:3dprinters /home/klippy/klipper
USER klippy
RUN mkdir /home/klippy/.config

WORKDIR /home/klippy

RUN virtualenv -p python2 /home/klippy/klippy-env
RUN /home/klippy/klippy-env/bin/pip install -r /home/klippy/klipper/scripts/klippy-requirements.txt


CMD ["/home/klippy/klippy-env/bin/python", "/home/klippy/klipper/klippy/klippy.py", "/home/klippy/.config/printer.cfg", "-l", "/var/log/klippy.log", "-a", "/tmp/klippy_uds"]