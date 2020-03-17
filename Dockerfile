FROM rshariffdeen/patchweave:latest
MAINTAINER Ridwan Shariffdeen <ridwan@comp.nus.edu.sg>

RUN mkdir /data

RUN apt-get update && apt-get  install -y \
    autogen \
    bison \
    flex \
    libfreetype6-dev \
    pkg-config

COPY benchmarks /patchweave/experiment
