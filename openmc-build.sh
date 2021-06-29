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
conda config --env --add channels conda-forge 
conda config --env --set pip_interop_enabled True

# Create environments that have more recent versions of the software
conda install numpy scipy pandas matplotlib uncertainties lxml pytest requests entrypoints pyyaml jupyterlab nb_conda_kernels cython vtk --yes

# build h5py
CC=gcc \
HDF5_DIR=/usr/local/hdf5-$HDF5_VERSION \
pip install --upgrade-strategy only-if-needed --no-binary=h5py h5py

cd ..
pip install --upgrade-strategy only-if-needed -e .[test]
