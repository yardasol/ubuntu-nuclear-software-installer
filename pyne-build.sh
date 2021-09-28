#! ~/bin/bash

# Paths
BRC=$HOME/.bashrc
CURRENT=`pwd`
PROJECTS=$HOME/projects
PYNE_PATH=$PROJECTS/pyne

# Build optional dependencies

## OpenMC ##
source openmc-build.sh

# Reset the hdf5 path just in case
conda activate pyne-env
HDF5_PATH=/usr/lib/x86_64-linux-gnu/hdf5/serial
#HDF5_PATH=$CONDA_PREFIX/lib

# Build PyNE
mkdir -p $PYNE_PATH/build $PYNE_PATH/app && cd $PYNE_PATH
python setup.py install --clean \
                        --hdf5 $HDF5_PATH \
                        --prefix $PYNE_PATH/app \
                        --build-dir $PYNE_PATH/build
# Adding .local/lib to $LD_LIBRARY_PATH and $LIBRARY_PATH
export LD_LIBRARY_PATH="$HOME/.local/lib:$LD_LIBRARY_PATH"

# Adding .local//bin to $PATH
export PATH="$HOME/.local/bin:$PATH"

# Make Pyne Nuclear Data
cd  # cd without argument will take you back to your $HOME directory
nuc_data_make

# Add dependencies to path
if [ -z \$LD_LIBRARY_PATH ]; then 
  export LD_LIBRARY_PATH=\"$HDF5_PATH\"
else 
  export LD_LIBRARY_PATH=\"$HDF5_PATH:\$LD_LIBRARY_PATH\" 
fi 

# Update bashrc
source $BRC

cd $CURRENT
