FROM rshariffdeen/patchweave:latest
MAINTAINER Ridwan Shariffdeen <ridwan@comp.nus.edu.sg>

RUN mkdir /data

RUN apt-get update && apt-get  install -y \
    autogen \
    automake \
    bison \
    cmake \
    flex \
    libflac-dev \
    libflac8 \
    libfl-dev \
    libfreetype6-dev \
    libogg-dev \
    libogg0  \
    libvorbis-dev \
    libtool \
    make \
    pkg-config


COPY benchmarks /patchweave/experiment
