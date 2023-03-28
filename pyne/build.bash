#! ~/bin/bash
HDF5_PATH=$CONDA_PREFIX
#HDF5_PATH=/usr
BT=debug

# Activate conda environment
conda activate pyne-env
conda list

cd $CODEPATH

python setup.py install \
    --clean \
    --build-type $BT \
    -D PYTHON_INCLUDE_DIR=$(python -c "from distutils.sysconfig import get_python_inc; print(get_python_inc())")  \
    -D PYTHON_LIBRARIES=$(python -c "import distutils.sysconfig as sysconfig; print(sysconfig.get_config_var('LIBDIR'))") \
    -D CMAKE_C_COMPILER=gcc-9 \
    -D CMAKE_CXX_COMPILER=g++-9 \
    -D CMAKE_Fortran_COMPILER=gfortran-9 \
    -j 8 \
    --hdf5 $HDF5_PATH \
    --no_spatial_solvers \
    --build-dir build

cd
nuc_data_make

# Return to execution directory
cd $CURRENT
