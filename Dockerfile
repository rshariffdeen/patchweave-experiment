FROM rshariffdeen/patchweave:latest
MAINTAINER Ridwan Shariffdeen <ridwan@comp.nus.edu.sg>

RUN mkdir /data
RUN cd /patchweave && git pull origin

RUN apt install -y \
    bison \
    flex \
    libfreetype6-dev

COPY benchmarks /data