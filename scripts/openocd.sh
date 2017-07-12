#!/bin/bash

# setting env
DECLAIMER_PATH=/home/jinf/30.declaimer
SOURCE_CODE_PATH=$DECLAIMER_PATH/sourcecode
TOOLS_PATH=$DECLAIMER_PATH/tools
export PATH=$PATH:$TOOLS_PATH/or1kgcc-5.3.0/bin
export PATH=$PATH:$TOOLS_PATH/simulator/bin

# Download source code from github
echo "Get openOCD from openrisc-declaimer github ..."
cd $SOURCE_CODE_PATH
if [ -d openOCD ]; then 
	cd openOCD; git pull
else
	git clone https://github.com/openrisc-declaimer/openOCD.git
fi

# Build openOCD
mkdir -p $DECLAIMER_PATH/build_openocd; cd $DECLAIMER_PATH/build_openocd; rm -rf *
cp $SOURCE_CODE_PATH/openOCD . -rf
cd openOCD
./bootstrap
./configure --enable-ftdi --enable-usb_blaster_libftdi --enable-maintainer-mode
make
make install
