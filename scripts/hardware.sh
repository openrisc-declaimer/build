#!/bin/bash

DECLAIMER_PATH=/home/jinf/30.declaimer
SOURCE_CODE_PATH=$DECLAIMER_PATH/sourcecode
TOOLS_PATH=$DECLAIMER_PATH/tools

# Download source code from github
echo "Get mor1kx-dev-env from openrisc-declaimer github ..."
mkdir -p $SOURCE_CODE_PATH; cd $SOURCE_CODE_PATH
if [ -d mor1kx-dev-env ]; then 
	cd mor1kx-dev-env; git pull
else
	git clone https://github.com/openrisc-declaimer/mor1kx-dev-env.git
fi

# Build ...
mkdir -p $DECLAIMER_PATH/hardware; cd $DECLAIMER_PATH/hardware; rm -rf *
cp $SOURCE_CODE_PATH/mor1kx-dev-env . -rf
cd $DECLAIMER_PATH


