#! ~/bin/bash
HDF5_PATH=/usr
PYNE_PATH=$CODEPATH
BT=debug

# Activate conda environment
conda activate pyne-env
conda list

cd $PYNE_PATH

python setup.py install \
    --clean \
    --build-type $BT \
    -j 8 \
    --hdf5 $HDF5_PATH \
    --no_spatial_solvers \
    --build-dir build

# Return to execution directory
cd $CURRENT
