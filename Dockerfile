FROM ubuntu:20.04

WORKDIR /

ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Asia/Tokyo 
ENV PATH=/usr/local/cmake/bin:$PATH
ENV PICO_SDK_PATH=/opt/pico-sdk

RUN apt-get update \
    && apt-get upgrade -y \
    && apt-get install -y --no-install-recommends git gcc-arm-none-eabi libnewlib-arm-none-eabi wget\
    && apt-get purge cmake -y \
    && apt-get -y clean \
    && rm -rf /var/lib/apt/lists/* \
    && wget https://github.com/Kitware/CMake/releases/download/v3.19.4/cmake-3.19.4-Linux-x86_64.tar.gz \
    && tar -zxvf cmake-3.19.4-Linux-x86_64.tar.gz \
    && mv cmake-3.19.4-Linux-x86_64 cmake \
    && mv cmake /usr/local/bin/cmake \
    && git clone -depth 1 https://github.com/raspberrypi/pico-sdk.git \
    && mnv pico-sdk /opt/pico-sdk

ENTRYPOINT [ "/bin/bash" ]