FROM ubuntu:20.04

WORKDIR /

RUN apt-get update \
    && apt-get upgrade -y \
    && apt-get install -y --no-install-recommends git gcc-arm-none-eabi libnewlib-arm-none-eabi cmake \
    && apt-get -y clean \
    && rm -rf /var/lib/apt/lists/* \
    && git clone -depth 1 https://github.com/raspberrypi/pico-sdk.git 

ENTRYPOINT [ "/bin/bash" ]