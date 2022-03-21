#! ~/bin/bash

# Paths
BRC=$HOME/.bashrc
CURRENT=`pwd`
SALTPROC_PATH=$HOME/projects/saltproc

# Build saltproc from source
cd $SALTPROC_PATH

# Build and install
pip install .

# Return to execution directory
cd $CURRENT
