FROM ubuntu:20.04

WORKDIR /

ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Asia/Tokyo 
ENV PATH=/usr/local/bin/cmake/bin:$PATH
ENV PICO_SDK_PATH=/opt/pico-sdk

RUN apt-get update \
    && apt-get upgrade -y \
    && apt-get install -y --no-install-recommends git gcc-arm-none-eabi libnewlib-arm-none-eabi wget make\
    && apt-get purge cmake -y \
    && apt-get -y clean \
    && rm -rf /var/lib/apt/lists/* \
    && wget https://github.com/Kitware/CMake/releases/download/v3.19.4/cmake-3.19.4-Linux-x86_64.tar.gz --no-check-certificate\
    && tar -zxvf cmake-3.19.4-Linux-x86_64.tar.gz \
    && mv cmake-3.19.4-Linux-x86_64 cmake \
    && mv cmake /usr/local/bin/cmake \
    && rm cmake-3.19.4-Linux-x86_64.tar.gz \
    && git clone -b master --depth 1 https://github.com/raspberrypi/pico-sdk.git --no-check-certificate\
    && cd pico-sdk\
    && git submodule update --init\
    && cd ../ \
    && mv pico-sdk /opt/pico-sdk \
    && git clone -b master --depth 1 https://github.com/raspberrypi/pico-examples.git --no-check-certificate\
    && git clone -b master --depth 1 https://github.com/raspberrypi/picotool.git --no-check-certificate\
    && cd picotool \
    && mkdir build \
    && cd build \
    && cmake .. \
    && make 

ENTRYPOINT [ "/bin/bash" ]