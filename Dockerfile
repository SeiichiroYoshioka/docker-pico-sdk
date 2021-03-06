FROM ubuntu:20.04

WORKDIR /

ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Asia/Tokyo 
ENV PATH=/usr/local/bin/cmake/bin:$PATH
ENV PICO_SDK_PATH=/opt/pico-sdk

RUN apt-get update \
    && apt-get upgrade -y \
    && apt-get install -y --no-install-recommends git gcc-arm-none-eabi \
        libnewlib-arm-none-eabi libstdc++-arm-none-eabi-newlib build-essential wget make libusb-1.0-0-dev \
        pkg-config libusb-1.0 python3 python3-dev python3-pip\
    && apt-get purge cmake -y \
    && apt-get -y clean \
    && rm -rf /var/lib/apt/lists/* \
    && wget https://github.com/Kitware/CMake/releases/download/v3.19.4/cmake-3.19.4-Linux-x86_64.tar.gz --no-check-certificate\
    && tar -zxvf cmake-3.19.4-Linux-x86_64.tar.gz \
    && mv cmake-3.19.4-Linux-x86_64 cmake \
    && mv cmake /usr/local/bin/cmake \
    && rm cmake-3.19.4-Linux-x86_64.tar.gz \
    && git config --global http.sslverify false \
    && git clone https://github.com/raspberrypi/pico-sdk.git\
    && cd pico-sdk\
    && git submodule update --init\
    && cd /pico-sdk/tools/elf2uf2 \
    && mkdir build \
    && cd build \
    && cmake .. \
    && make \
    && mv elf2uf2  /usr/local/bin/ \
    && cd /pico-sdk/tools/pioasm \
    && mkdir build \
    && cd build \
    && cmake .. \
    && make \
    && mv pioasm /usr/local/bin/ \
    && cd / \
    && mv pico-sdk /opt/pico-sdk \
    && git clone https://github.com/raspberrypi/pico-examples.git\
    && git clone https://github.com/raspberrypi/picotool.git\
    && cd picotool \
    && mkdir build \
    && cd build \
    && cmake ..\
    && make \
    && mv picotool /usr/local/bin/

ENTRYPOINT [ "/bin/bash" ]