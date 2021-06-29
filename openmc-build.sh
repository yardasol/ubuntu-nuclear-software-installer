#! ~/bin/bash

# Paths
HDF5_PATH=$HOME/anaconda3/envs/openmc-env/
OPENMC_PATH=$HOME/projects/openmc

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
HDF5_DIR=$HDF5_PATH \
pip install --upgrade-strategy only-if-needed --no-binary=h5py h5py


# Build Openmc from source
cd $OPENMC_PATH && mkdir build app && cd build
CC=gcc \
CXX=g++ \
HDF5_ROOT=$HDF5_PATH \
cmake -Ddebug=on -Doptimize=on -DCMAKE_INSTALL_PREFIX=$OPENMC_PATH/app ..
make
make install

cd ..
pip install --upgrade-strategy only-if-needed -e .[test]
