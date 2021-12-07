FROM ubuntu:20.04

RUN apt-get update && apt-get install -y \
    python3-virtualenv \
    python3-dev \
    libopenjp2-7 \
    python3-libgpiod \
    liblmdb0 \
    libsodium-dev \
    zlib1g-dev \
    build-essential \
    libjpeg-dev \
    libcurl4-openssl-dev \
    libssl-dev


RUN useradd -ms /bin/bash -u 1000 moonraker
COPY moonraker /home/moonraker/moonraker
RUN chown -R moonraker:moonraker /home/moonraker/moonraker
USER moonraker
RUN mkdir /home/moonraker/.config

WORKDIR /home/moonraker

RUN virtualenv -p python3 /home/moonraker/moonraker-env
RUN /home/moonraker/moonraker-env/bin/pip3 install -r /home/moonraker/moonraker/scripts/moonraker-requirements.txt
CMD ["/home/moonraker/moonraker-env/bin/python", "/home/moonraker/moonraker/moonraker/moonraker.py", "-c", "/home/moonraker/.config/moonraker.conf", "-l", "/var/log/moonraker.log"]
