#! ~/bin/bash

# Change to the openmc directory
cd ~/projects/openmc

# Build Openmc from source
mkdir build app && cd build
HDF5_VERSION=1.10.7
CC=gcc \
CXX=g++ \
HDF5_ROOT=/usr/local/hdf5-$HDF5_VERSION \
cmake -Ddebug=on -Doptimize=on -DCMAKE_INSTALL_PREFIX=$HOME/projects/openmc/app ..
make
make install

# Create empty openmc environment
conda create --name openmc-env --yes
conda activate openmc-env

# Configure conda to work with conda-forge 
conda config --env --append channels conda-forge 
conda config --env --set pip_interop_enabled True

# Create environments that have more recent versions of the software
conda install numpy scipy pandas matplotlib uncertainties lxml pytest requests entrypoints pyyaml jupyterlab nb_conda_kernels --yes

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

cd ..
pip install --upgrade-strategy only-if-needed -e .[test]
#python setup.py develop

