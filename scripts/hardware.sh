#!/bin/bash

DECLAIMER_PATH=/home/jinf/30.declaimer
SOURCE_CODE_PATH=$DECLAIMER_PATH/sourcecode

# Download source code from github
echo "Get or1k-xxx from openrisc-declaimer github ..."
mkdir -p $SOURCE_CODE_PATH; cd $SOURCE_CODE_PATH
if [ -d cd or1k-xxx ]; then 
	cd or1k-xxx; git pull
else
	git clone https://github.com/openrisc-declaimer/or1k-xxx.git
fi

# Build full GCC
cd $DECLAIMER_PATH; mkdir -p build_gcc; cd build_gcc; rm -rf *
$SOURCE_CODE_PATH/or1k-gcc/configure --target=or1k-elf \
                                     --prefix=$DECLAIMER_PATH/toolchain \
					                 --enable-languages=c,c++ --disable-shared --disable-libssp --with-newlib
make; make install

# Build simulator
cd $DECLAIMER_PATH; mkdir -p build_sim; cd build_sim; rm -rf *
$SOURCE_CODE_PATH/or1k-sim/configure --target=or1k-elf \
                                     --prefix=$DECLAIMER_PATH/simulator
make all; make install

