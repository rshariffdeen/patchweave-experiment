FROM ubuntu:16.04

#install the requirements for muScalpel
RUN apt-get update && apt-get install -y \
    autoconf \
    automake \
    bison \
    check \
    cflow \
    flex \
    gcc-4.8 \
    g++-4.8  \
    gfortran-4.8 \
    git  \
    libgcrypt20 \
    libglib2.0-dev \
    libtool \
    make \
    nano \
    pkg-config \
    python \
    python3 \
    python-pip \
    python3-pip \
    vim \
    wget


RUN cp /usr/bin/gcc-4.8 /usr/bin/gcc
RUN cp /usr/bin/g++-4.8 /usr/bin/g++
RUN cp /usr/bin/gfortran-4.8 /usr/bin/gfortran


ADD muScalpel.tar.gz /muscalpel
COPY benchmarks /experiment


RUN git clone https://gitlab.com/akihe/radamsa.git /radamsa
RUN cd /radamsa; git checkout 30770f6e; make; make install

RUN git config --global user.email "rshariffdeen@gmail.com"
RUN git config --global user.name "Ridwan"