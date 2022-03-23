#! ~/bin/bash

# Paths
BRC=$HOME/.bashrc
CURRENT=`pwd`

# Build saltproc from source
cd $CODEPATH

# Build and install
pip install .

# Return to execution directory
cd $CURRENT
