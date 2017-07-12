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
	git clone --branch dev https://github.com/openrisc-declaimer/mor1kx-dev-env.git
fi

cd $SOURCE_CODE_PATH
if [ -d mor1kx ]; then 
	cd mor1kx; git pull
else
	git clone https://github.com/openrisc-declaimer/mor1kx.git
fi

# Build ...
mkdir -p $DECLAIMER_PATH/hardware; cd $DECLAIMER_PATH/hardware; rm -rf *
cp $SOURCE_CODE_PATH/mor1kx-dev-env . -rf
# cp $SOURCE_CODE_PATH/mor1kx . -rf



