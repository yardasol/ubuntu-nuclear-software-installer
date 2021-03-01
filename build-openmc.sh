#! ~/bin/bash

# Change to the openmc directory
cd ~/projects/openmc

# Create empty openmc environment
conda create --name openmc-env --yes
conda activate openmc-env

# Configure conda to work with conda-forge 
conda config --env --append channels conda-forge 
conda config --env --set pip_interop_enabled True

# Create environments that have more recent versions of the software
conda install pandas numpy scipy matplotlib uncertainties lxml mpi4py cython vtk pytest jupyterlab jinja2 --yes

# build h5py
cd ..
export CPATH=/usr/local/hdf5/include
CC=gcc \
HDF5_DIR=/usr/local/hdf5/bin \
HDF5_VERSION=1.12.0 \
pip install --upgrade-strategy only-if-needed --no-binary=h5py h5py

# Build Openmc from source
mkdir build app && cd build
CC=gcc \
CXX=g++ \
HDF5_ROOT=/usr/local/hdf5 \
cmake -Ddebug=on -Doptimize=on -DCMAKE_INSTALL_PREFIX=$HOME/projects/openmc/app ..
make
make install


#pip install --upgrade-strategy only-if-needed -e .[test]
python setup.py develop

