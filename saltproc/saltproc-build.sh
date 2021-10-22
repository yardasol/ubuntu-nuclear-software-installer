#! ~/bin/bash

# Paths
BRC=$HOME/.bashrc
CURRENT=`pwd`
SALTPROC_PATH=$HOME/projects/saltproc

# Build saltproc from source
cd $SALTPROC_PATH && mkdir -p build app

# Build and install
python setup.py build
python setup.py install

# Return to execution directory
cd $CURRENT
