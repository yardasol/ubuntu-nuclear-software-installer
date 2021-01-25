#! ~/bin/bash

cd ~/projects/openmc
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

cd ~/projects/pyne
python setup.py install --hdf5 h5cc


# Activate the moove-env environment
conda init bash
conda activate moose-env

# Compile MOOSE
cd ~/projects/moose/test
make -j 4

# Initalize Moltres
cd ~/projects/moltres
git submodule init

git submodule update
./build_libmesh_and_moltres.sh

# Leave the nuclear environment
conda deactivate

