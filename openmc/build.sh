#! ~/bin/bash
# Activate conda environment
conda activate openmc-env

# Paths
BRC=$HOME/.bashrc
CURRENT=`pwd`
#HDF5_PATH=$CONDA_PREFIX
HDF5_PATH=/usr
OPENMC_PATH=$HOME/projects/openmc

# build h5py
CC=gcc \
HDF5_DIR=$HDF5_PATH \
pip install --upgrade-strategy only-if-needed --no-binary=h5py h5py


# Build Openmc from source
cd $OPENMC_PATH && mkdir -p build app && cd build
CC=gcc \
CXX=g++ \
HDF5_ROOT=$HDF5_PATH \
cmake -Ddebug=on -Doptimize=on -DCMAKE_INSTALL_PREFIX=$OPENMC_PATH/app ..
make
make install

# Build test suite
cd ..
pip install --upgrade-strategy only-if-needed -e .[test]

# Add OpenMC to path
echo "export PATH="$OPENMC_PATH/app/bin:'$PATH'"" >> $BRC
source $HOME/.bashrc

# Return to execution directory
cd $CURRENT
