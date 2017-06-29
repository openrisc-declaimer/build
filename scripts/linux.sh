#!/bin/bash

DECLAIMER_PATH=/home/jinf/30.declaimer
SOURCE_CODE_PATH=$DECLAIMER_PATH/sourcecode

echo "Get or1k-linux from openrisc-declaimer github ..."
cd $SOURCE_CODE_PATH
if [ -d or1k-linux ]; then 
	cd or1k-linux; git pull
else
	git clone https://github.com/openrisc-declaimer/or1k-linux.git
fi

# setting env
export PATH=$PATH:$DECLAIMER_PATH/toolchain/bin
export PATH=$DECLAIMER_PATH/simulator/bin:$PATH

# Build Linux
mkdir -p $DECLAIMER_PATH/kernel; cd $DECLAIMER_PATH/kernel; rm -rf *
cp $DECLAIMER_PATH/or1k-linux . -rf
cd or1k-linux
make ARCH=openrisc defconfig
make ARCH=openrisc CROSS_COMPILE=or1k-elf- vmlinux
