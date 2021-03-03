#! ~/bin/bash

# Create empty openmc environment
conda create --name openmc-env --yes
conda activate openmc-env

# Configure conda to work with conda-forge 
conda config --env --append channels conda-forge 
conda config --env --set pip_interop_enabled True

# Create environments that have more recent versions of the software
conda install numpy scipy pandas matplotlib uncertainties lxml pytest requests entrypoints pyyaml --yes

# build h5py
CC=gcc \
HDF5_DIR=/usr/local/hdf5-$HDF5_VERSION \
pip install --upgrade-strategy only-if-needed --no-binary=h5py h5py

# Install cython, vtk for additional tests
pip install cython
pip install vtk


# Conda is stuck on numpy v1.19, we need 1.20
# https://stackoverflow.com/questions/66060487/valueerror-numpy-ndarray-size-changed-may-indicate-binary-incompatibility-exp
pip uninstall numpy --yes
pip install numpy --yes

# Install openmc python API
cd $HOME/projects/openmc
pip install --upgrade-strategy only-if-needed -e .[test]
#python setup.py develop


# Download the test cross sections
cd tools/ci
source download-xs.sh

# NJOY requires a bit more effort to get
git clone git@github.com:njoy/NJOY2016 $HOME/projects/NJOY2016
cd $HOME/projects/NJOY2016
mkdir bin && cd bin
cmake -D CMAKE_BUILD_TYPE=Release ../
make
make test

