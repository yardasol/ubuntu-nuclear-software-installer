#! ~/bin/bash
# Activate conda environment
conda activate openmc-env

# Paths
#HDF5_PATH=$CONDA_PREFIX
#HDF5_PATH=/usr

# build h5py
#HDF5_DIR=$HDF5_PATH \
CC=gcc \
pip install --upgrade-strategy only-if-needed --no-binary=h5py h5py

# Build Openmc from source
cd $CODEPATH && mkdir -p build app && cd build
CC=gcc \
CXX=g++ \
HDF5_ROOT=$HDF5_PATH \
cmake -DCMAKE_FIND_ROOT_PATH=$CONDA_PREFIX \
-DCMAKE_BUILD_TYPE=Release \
-DCMAKE_INSTALL_PREFIX=$CODEPATH/app ..
make
make install

# Build test suite
cd ..
pip install --upgrade-strategy only-if-needed -e .[test]

# Add OpenMC to path
if [[ $(grep "export PATH="$CODEPATH/app/bin:'$PATH'"" $BRC) ]]
then
    echo "OpenMC already on PATH"
else
    echo "export PATH="$CODEPATH/app/bin:'$PATH'"" >> $BRC
    export PATH="$CODEPATH/app/bin:'$PATH'"
fi
#source $HOME/.bashrc

# Return to execution directory
cd $CURRENT
