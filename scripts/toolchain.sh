#!/bin/bash

DECLAIMER_PATH=/home/jinf/30.declaimer
SOURCE_CODE_PATH=$DECLAIMER_PATH/sourcecode

# Download source code from github
mkdir -p $SOURCE_CODE_PATH;
echo "Get or1k-src from openrisc-declaimer github ..."
cd $SOURCE_CODE_PATH
if [ -d or1k-src ]; then 
	cd or1k-src; git pull
else
	git clone https://github.com/openrisc-declaimer/or1k-src.git
fi

echo "Get or1k-gcc from openrisc-declaimer github ..."
cd $SOURCE_CODE_PATH
if [ -d or1k-gcc ]; then 
	cd or1k-gcc; git pull
else
	git clone https://github.com/openrisc-declaimer/or1k-gcc.git
fi

echo "Get or1k-sim from openrisc-declaimer github ..."
cd $SOURCE_CODE_PATH
if [ -d or1k-sim ]; then 
	cd or1k-sim; git pull
else
	git clone --branch or1k-master https://github.com/openrisc-declaimer/or1k-sim.git	
fi

echo "Get openOCD from openrisc-declaimer github ..."
cd $SOURCE_CODE_PATH
if [ -d openOCD ]; then 
	cd openOCD; git pull
else
	git clone https://github.com/openrisc-declaimer/openOCD.git
fi

# setting env
mkdir -p $DECLAIMER_PATH/toolchain
export PATH=$PATH:$DECLAIMER_PATH/toolchain/bin

# Build the auxiliary tools
cd $DECLAIMER_PATH; mkdir -p build_src; cd build_src; rm -rf *
$SOURCE_CODE_PATH/or1k-src/configure --target=or1k-elf \
                                     --prefix=$DECLAIMER_PATH/toolchain --enable-shared \
                                     --disable-itcl --disable-tk --disable-tcl \
                                     --disable-winsup --disable-gdbtk \
                                     --disable-libgui --disable-rda --disable-sid \
                                     --disable-sim --disable-gdb --with-sysroot \
                                     --disable-newlib --disable-libgloss \
                                     --disable-werror
make; make install

# Build the bootstrap compiler
cd $DECLAIMER_PATH; mkdir -p build_gcc; cd build_gcc; rm -rf *
$SOURCE_CODE_PATH/or1k-gcc/configure --target=or1k-elf \
                                     --prefix=$DECLAIMER_PATH/toolchain --enable-languages=c \
                                     --disable-shared --disable-libssp
make; make install

# Build newlib and gdb
cd $DECLAIMER_PATH; mkdir -p build_src; cd build_src; rm -rf *
$SOURCE_CODE_PATH/or1k-src/configure --target=or1k-elf \
                                     --prefix=$DECLAIMER_PATH/toolchain --enable-shared \
                                     --disable-itcl --disable-tk --disable-tcl \
                                     --disable-winsup --disable-gdbtk --disable-libgui \
                                     --disable-rda --disable-sid --enable-sim \
                                     --disable-or1ksim --enable-gdb --with-sysroot \
                                     --enable-newlib --enable-libgloss
make; make install

# Build full GCC
cd $DECLAIMER_PATH; mkdir -p build_gcc; cd build_gcc; rm -rf *
$SOURCE_CODE_PATH/or1k-gcc/configure --target=or1k-elf \
                                     --prefix=$DECLAIMER_PATH/toolchain \
					                 --enable-languages=c,c++ --disable-shared --disable-libssp --with-newlib
make; make install

# Build simulator
cd $DECLAIMER_PATH; mkdir -p build_sim; cd build_sim; rm -rf *
$SOURCE_CODE_PATH/or1k-sim/configure --target=or1k-elf \
                                     --prefix=$DECLAIMER_PATH/toolchain
make all; make install
