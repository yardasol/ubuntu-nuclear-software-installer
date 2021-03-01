#! ~/bin/bash

# Change to the openmc directory
cd ~/projects/openmc

# Create empty openmc environment
conda create --name openmc-env --yes
conda activate openmc-env

# Configure conda to work with conda-forge 
conda config --env --append channels conda-forge 
conda config --env --set pip_interop_enabled True

# Create environements that have more recent versions of the software
conda install hdf5=1.10.4 h5py pandas numpy scipy matplotlib uncertainties lxml mpi4py cython vtk pytest jupyterlab jinja2 --yes


# Build Openmc from source
mkdir build app && cd build
CC=gcc \
CXX=g++ \
HDF5_ROOT=/home/ooblack/anaconda3/envs/openmc-env \
cmake \ -Ddebug=on -Doptimize=on -DCMAKE_INSTALL_PREFIX=$HOME/projects/openmc/app ..
make
make install

cd ..
HDF5_DIR=/home/ooblack/anaconda3/envs/openmc-env/bin pip install --upgrade-strategy only-if-needed --no-binary=h5py h5py
python pip install --upgrade-strategy only-if-needed -e .[test]
#python setup.py develop

