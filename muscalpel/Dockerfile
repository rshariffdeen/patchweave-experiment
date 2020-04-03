FROM ubuntu:16.04

#install the requirements for muScalpel
RUN apt-get update && apt-get install -y \
    git  \
    wget  \
    gcc-4.8 \
    g++-4.8  \
    gfortran-4.8 \
    autoconf \
    automake \
    libtool \
    flex \
    bison \
    vim \
    cflow \
    make \
    check \
    pkg-config \
    libglib2.0-dev \
    libgcrypt20 \
    nano

RUN cp /usr/bin/gcc-4.8 /usr/bin/gcc
RUN cp /usr/bin/g++-4.8 /usr/bin/g++
RUN cp /usr/bin/gfortran-4.8 /usr/bin/gfortran

#build the folder structure
RUN mkdir /home/muScalpelExperiments
ADD muScalpel.tar.gz /muscalpel
