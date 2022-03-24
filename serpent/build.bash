#! ~/bin/bash

# Paths
BRC=$HOME/.bashrc
CURRENT=`pwd`

# Build serpent from source
cd $CODEPATH

# Build and install
cd src
make
source $BRC

# Return to execution directory
cd $CURRENT
