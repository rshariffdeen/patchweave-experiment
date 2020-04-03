#!/bin/bash

SUCCESFUL=1

VERSION="$(dpkg -s check | grep Version:)"
OUT=$?

if [ $OUT -eq 0 ];then
   echo "Check library installed!"
   if [ "$VERSION" == "Version: 0.9.10-6ubuntu3" ]; then
	echo "Correct version of check library!"
   else
	SUCCESFUL=0
	echo "Wrong version! muScalpel requires: Version: 0.9.10-6ubuntu3"
   fi
else
   echo "You are missing the check library!"
   SUCCESFUL=0
fi



VERSION="$(dpkg -s make | grep Version:)"
#echo $VERSION
OUT=$?

if [ $OUT -eq 0 ];then
   echo "make installed!"
   if [ "$VERSION" == "Version: 3.81-8.2ubuntu3" ]; then
	echo "Correct version of make!"
   else
	SUCCESFUL=0
	echo "Wrong version! muScalpel requires: Version: 3.81-8.2ubuntu3"
   fi
else
   echo "You are missing make!"
   SUCCESFUL=0
fi

VERSION="$(dpkg -s cflow | grep Version:)"
#echo $VERSION
OUT=$?

if [ $OUT -eq 0 ];then
   echo "cflow installed!"
   if [ "$VERSION" == "Version: 1:1.4+dfsg1-2ubuntu1" ]; then
	echo "Correct version of cflow!"
   else
	SUCCESFUL=0
	echo "Wrong version! muScalpel requires:Version: 1:1.4+dfsg1-2ubuntu1"
   fi
else
   echo "You are missing cflow!"
   SUCCESFUL=0
fi



VERSION="$(dpkg -s pkg-config | grep Version:)"
OUT=$?

if [ $OUT -eq 0 ];then
   echo "pkg-config installed!"
else
   echo "You are missing pkg-config!"
   SUCCESFUL=0
fi



VERSION="$(dpkg -s gcc-4.8 | grep Version:)"
#echo $VERSION
OUT=$?

if [ $OUT -eq 0 ];then
   echo "gcc-4.8 installed!"
   if [ "$VERSION" == "Version: 4.8.2-19ubuntu1" ]; then
	echo "Correct version of gcc-4.8!"
   else
	SUCCESFUL=0
	echo "Wrong version! muScalpel requires: Version: 4.8.2-19ubuntu1"
   fi
else
   echo "You are missing gcc-4.8!"
   SUCCESFUL=0
fi




VERSION="$(dpkg -s libglib2.0-dev | grep Version:)"
#echo $VERSION
OUT=$?

if [ $OUT -eq 0 ];then
   echo "libglib2.0-dev!"
   if [ "$VERSION" == "Version: 2.40.2-0ubuntu1" ]; then
	echo "Correct version of libglib2.0-dev!"
   else
	SUCCESFUL=0
	echo "Wrong version! muScalpel requires: Version: 2.40.2-0ubuntu1"
   fi
else
   echo "You are missing libglib2.0-dev!"
   SUCCESFUL=0
fi







VERSION="$(dpkg -s libgcrypt20 | grep Version:)"
OUT=$?

if [ $OUT -eq 0 ];then
   echo "libgcrypt20 installed!"
   if [ "$VERSION" == "Version: 1.6.1-2ubuntu1" ]; then
	echo "Correct version of libgcrypt20!"
   else
	SUCCESFUL=0
	echo "Wrong version! muScalpel requires: Version: 1.6.1-2ubuntu1"
   fi
else
   echo "You are missing libgcrypt20!"
   SUCCESFUL=0
fi

VERSION="$(cat /etc/lsb-release | grep DISTRIB_DESCRIPTION)"
OUT=$?
if [ "$VERSION" == "DISTRIB_DESCRIPTION=\"Ubuntu 14.04.1 LTS\"" ]; then
	echo "Correct version of Ubuntu!"
else
	SUCCESFUL=0
	echo "Wrong version! muScalpel requires: DISTRIB_DESCRIPTION=\"Ubuntu 14.04.1 LTS\""
fi


VERSION="$(cat /proc/cpuinfo | grep processor | wc -l)"
OUT=$?
if [ "$VERSION" == "8" ]; then
	echo "Right number of cores!"
else
	SUCCESFUL=0
	echo "Different number of cores! Our experiments where run on a 8 core machine"
fi


VERSION="$(grep MemTotal /proc/meminfo)"
OUT=$?
if [ "$VERSION" == "MemTotal:       16351624 kB" ]; then
	echo "Right amount of RAM memory!"
else
	SUCCESFUL=0
	echo "Different RAM capacity! Our experiments were run on a machine with 16351624 kB RAMs"
fi



VERSION="$(lscpu | grep Architecture:)"
OUT=$?
if [ "$VERSION" == "Architecture:          x86_64" ]; then
	echo "Right preocessor architecture!"
else
	SUCCESFUL=0
	echo "Different processor architecture. It is high likely that the experiments will fail!  Our experiments were run on a machine with x86_64 architecture"
fi

echo $SUCCESFUL
exit $SUCCESFUL




#libglib2.0-dev
#dpkg -s make
#dpkg -s cflow
#dpkg -s pkg-config
#dpkg -s gcc-4.8
#dpkg -s libgcrypt20


