#! ~/bin/bash

# Change to the openmc directory
cd ~/projects/openmc

# Create empty openmc environment
conda create --name openmc-env --yes
conda activate openmc-env

# Configure conda to work with conda-forge 
conda config --env --append channels conda-forge 

# Create environements that have more recent versions of the software
conda install hdf5=1.10.4 h5py numpy scipy matplotlib uncertainties lxml mpi4py cython vtk pytest jupyterlab jinja2 --yes

# Build Openmc from source
mkdir build app && cd build
#CXX=mpicxx.openmpi HDF5_ROOT=/usr cmake -Ddebug=on -Dprofile=on -Doptimize=on -Dcoverage=on -DHDF5_PREFER_PARALLEL=on -DCMAKE_INSTALL_PREFIX=$NUC_SOFTWARE/openmc/app ..
HDF5_ROOT=/home/ooblack/anaconda3/envs/openmc-env cmake -Ddebug=on -Doptimize=on -DCMAKE_INSTALL_PREFIX=$NUC_SOFTWARE/openmc/app ..
make
make install

conda activate openmc-env
cd ..
#MPICC=mpicc.openmpi pip install --upgrade-strategy only-if-needed mpi4py
#CC=mpicc.openmpi HDF5_MPI=ON HDF5_DIR=/usr pip install --upgrade-strategy only-if-needed --no-binary=h5py h5py
HDF5_DIR=/home/ooblack/anaconda3/envs/openmc-env/bin pip install --upgrade-strategy only-if-needed --no-binary=h5py h5py
pip install --upgrade-strategy only-if-needed -e .[test]


