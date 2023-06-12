#! ~/bin/bash

# Activate conda environment
conda activate openmc-dagmc-env

# Paths
HDF5_PATH=$CONDA_PREFIX
#HDF5_PATH=/usr

# build h5py
#HDF5_DIR=$HDF5_PATH \
CC=gcc \
pip install --upgrade-strategy only-if-needed --no-binary=h5py h5py

# Dependencies
# Eigen3
sudo apt-get install libeigen3-dev

# MOAB
cd $PROJECTS
if [[ ! -d "moab" ]]
then
    git clone https://bitbucket.org/fathomteam/moab
    cd moab && mkdir -p build app && cd build
    cmake -DCMAKE_FIND_ROOT_PATH=$CONDA_PREFIX \
        -DENABLE_HDF5=ON \
        -DHDF5_ROOT=$HDF5_PATH \
        -DCMAKE_INSTALL_PREFIX=../app ..
    make -j $N_THREADS
    make check
    make install
fi
#export PATH=$PATH:$PROJECTS/HDF5/bin
export PATH=$PATH:$PROJECTS/moab/app/bin
#export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$PROJECTS/HDF5/lib
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$PROJECTS/moab/app/lib

which h5ls
which mbconvert

# Build DAGMC
cd $PROJECTS
if [[ ! -d "DAGMC" ]]
then
    cd $CODEPATH && mkdir -p build app && cd build
    INSTALL_PATH=$CODEPATH/app
    cmake -DCMAKE_FIND_ROOT_PATH=$CONDA_PREFIX \
        -DMOAB_DIR=$PROJECTS/moab/app \
        -DBUILD_TALLY=ON \
        -DCMAKE_INSTALL_PREFIX=$INSTALL_PATH ..
    make -j $N_THREADS
    make install
fi
echo "export LD_LIBRARY_PATH="'$LD_LIBRARY_PATH':$PROJECTS/DAGMC/app/lib"" >> $BRC
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$PROJECTS/DAGMC/app/lib

CODEPATH=$CODEPATH/../openmc
# Build Openmc from source
cd $CODEPATH && mkdir -p build_dagmc app_dagmc && cd build_dagmc
CC=gcc \
CXX=g++ \
HDF5_ROOT=$HDF5_PATH \
cmake -DCMAKE_FIND_ROOT_PATH=$CONDA_PREFIX \
-DCMAKE_BUILD_TYPE=Release \
-DOPENMC_USE_DAGMC=on \
-DCMAKE_PREFIX_PATH=$PROJECTS/DAGMC/app \
-DCMAKE_INSTALL_PREFIX=$CODEPATH/app_dagmc ..
make -j $N_THREADS
make install

# Build test suite
cd ..
pip install --no-build-isolation --upgrade-strategy only-if-needed -e .[test]

# Add OpenMC to path
if [[ $(grep "export PATH="$CODEPATH/app_dagmc/bin:'$PATH'"" $BRC) ]]
then
    echo "OpenMC already on PATH"
else
    echo "export PATH="$CODEPATH/app_dagmc/bin:'$PATH'"" >> $BRC
    export PATH="$CODEPATH/app_dagmc/bin:'$PATH'"
fi
#source $HOME/.bashrc

# Return to execution directory
cd $CURRENT
