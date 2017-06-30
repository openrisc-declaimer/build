#!/bin/bash

# setting env
export DECLAIMER_PATH=/home/jinf/30.declaimer
export OR1k_BLDR=$DECLAIMER_PATH/bootldr
export OR1k_KERNEL=$DECLAIMER_PATH/kernel
export OR1k_IMAGES=$DECLAIMER_PATH/image
export OR1k_SYSAPPS=$DECLAIMER_PATH/sysapps
export OR1k_DOC=$DECLAIMER_PATH/doc
export OR1k_TFTP=$DECLAIMER_PATH/tftproot
export OR1K_HDW=$DECLAIMER_PATH/hardware
export OR1K_TOOLS=$DECLAIMER_PATH/tools

export OR1k_LINUX=$OR1k_KERNEL/or1k-linux
export OR1k_UBOOT=$OR1k_BLDR/or1k-uboot
export OR1k_PROCESS=$OR1K_HDW/or1k-skyone

# environment setting 。。。
export PATH=$PATH:$OR1K_TOOLS/or1kgcc-5.3.0/bin
export PATH=$PATH:$OR1K_TOOLS/simulator/bin

