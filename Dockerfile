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
    && wget https://github.com/Kitware/CMake/releases/download/v3.19.4/cmake-3.19.4-Linux-x86_64.tar.gz --no-check-certificate\
    && tar -zxvf cmake-3.19.4-Linux-x86_64.tar.gz \
    && mv cmake-3.19.4-Linux-x86_64 cmake \
    && mv cmake /usr/local/bin/cmake \
    && wget https://github.com/raspberrypi/pico-sdk/archive/1.0.1.tar.gz --no-check-certificate\
    && tar -zxvf 1.0.1.tar.gz \
    && mv pico-sdk-1.0.1 pico-sdk \
    && mv pico-sdk /opt/pico-sdk \
    && rm cmake-3.19.4-Linux-x86_64.tar.gz \
    && rm 1.0.1.tar.gz

ENTRYPOINT [ "/bin/bash" ]