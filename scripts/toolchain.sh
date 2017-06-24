#!/bin/bash

export DECLAIMER_PATH=/home/jinf/30.declaimer

# Download source code from github
SOURCE_CODE_PATH=$DECLAIMER_PATH/sourcecode
mkdir -p $SOURCE_CODE_PATH; cd $SOURCE_CODE_PATH; rm -rf *
echo "Get or1k-src from openrisc-declaimer github ..."
git clone https://github.com/openrisc-declaimer/or1k-src.git
echo "Get or1k-linux from openrisc-declaimer github ..."
git clone https://github.com/openrisc-declaimer/or1k-linux.git
echo "Get or1k-gcc from openrisc-declaimer github ..."
git clone https://github.com/openrisc-declaimer/or1k-gcc.git
echo "Get or1k-sim from openrisc-declaimer github ..."
git clone --branch or1k-master https://github.com/openrisc-declaimer/or1k-sim.git

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
                                     --prefix=$DECLAIMER_PATH/simulator
make all; make install
export PATH=$DECLAIMER_PATH/simulator/bin:$PATH

# Build Linux
cd $DECLAIMER_PATH/or1k-linux
cd linux
make ARCH=openrisc defconfig
make ARCH=openrisc CROSS_COMPILE=or1k-elf- vmlinux

