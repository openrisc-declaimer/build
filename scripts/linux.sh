#!/bin/bash

DECLAIMER_PATH=/home/jinf/30.declaimer
SOURCE_CODE_PATH=$DECLAIMER_PATH/sourcecode
TOOLS_PATH=$DECLAIMER_PATH/tools

# Download source code from github
echo "Get or1k-linux from openrisc-declaimer github ..."
mkdir -p $SOURCE_CODE_PATH; cd $SOURCE_CODE_PATH
if [ -d or1k-linux ]; then 
	cd or1k-linux; git pull
else
	git clone https://github.com/openrisc-declaimer/or1k-linux.git
fi

# setting env
export PATH=$PATH:$TOOLS_PATH/or1kgcc-5.3.0/bin
export PATH=$PATH:$TOOLS_PATH/simulator/bin

# Build Linux
mkdir -p $DECLAIMER_PATH/kernel; cd $DECLAIMER_PATH/kernel; rm -rf *
cp $SOURCE_CODE_PATH/or1k-linux . -rf
cd or1k-linux
make ARCH=openrisc defconfig
make ARCH=openrisc CROSS_COMPILE=or1k-elf- vmlinux
