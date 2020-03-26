FROM ubuntu:16.04
ADD prophet-0.1-src.tar.gz /prophet
RUN echo "deb http://apt.llvm.org/xenial/ llvm-toolchain-xenial main" >> /etc/apt/sources.list
RUN echo "deb-src http://apt.llvm.org/xenial/ llvm-toolchain-xenial main" >> /etc/apt/sources.list
RUN apt-get update && apt-get install -y \
    autoconf \
    automake \
    cmake \
    curl \
    g++ \
    libexplain-dev \
    libtool \
    libtinfo-dev \
    libz-dev \
    nano \
    python \
    subversion \
    wget

RUN mkdir -p /llvm/llvm-361; svn co  http://llvm.org/svn/llvm-project/llvm/tags/RELEASE_361/final /llvm/llvm-361/source;
RUN svn co http://llvm.org/svn/llvm-project/cfe/tags/RELEASE_361/final /llvm/llvm-361/source/tools/clang
RUN svn co https://llvm.org/svn/llvm-project/compiler-rt/tags/RELEASE_361/final/ /llvm/llvm-361/source/projects/compiler-rt
RUN mkdir /llvm/llvm-361/build; cd /llvm/llvm-361/build; cmake ../source -DCMAKE_BUILD_TYPE=Release -DCMAKE_ENABLE_ASSERTIONS=OFF -DLLVM_ENABLE_WERROR=OFF -DCMAKE_CXX_FLAGS="-std=c++11"
RUN cd /llvm/llvm-361/build; make -j32; make install

RUN cd /prophet/prophet-gpl;autoreconf -i;
RUN cd /prophet/prophet-gpl;CC=clang CXX=clang++ ./configure --host=x86_64 --build=x86_64
#RUN cd /prophet/prophet-gpl;make CFLAGS='-Wno-error' CXXFLAGS='-Wno-error -fno-rtti' -j64