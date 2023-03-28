#! ~/bin/bash
# Activate saltproc environment
conda activate saltproc-env

# Install pyne
HDF5_PATH=$CONDA_PREFIX
BT=release
cd $PROJECTS/pyne

python setup.py install \
    --clean \
    --build-type $BT \
    -D PYTHON_INCLUDE_DIR=$(python -c "from distutils.sysconfig import get_python_inc; print(get_python_inc())")  \
    -D PYTHON_LIBRARIES=$(python -c "import distutils.sysconfig as sysconfig; print(sysconfig.get_config_var('LIBDIR'))") \
    -D CMAKE_C_COMPILER=gcc \
    -D CMAKE_CXX_COMPILER=g++ \
    -D CMAKE_Fortran_COMPILER=gfortran \
    -j 8 \
    --hdf5 $HDF5_PATH \
    --no_spatial_solvers \
    --build-dir build

cd
nuc_data_make

# Install OpenMC
OPENMCPATH=$PROJECTS/openmc
CC=gcc \
HDF5_DIR=$HDF5_PATH \
pip install --upgrade-strategy only-if-needed --no-binary=h5py h5py


# Build Openmc from source
cd $OPENMCPATH && mkdir -p build app && cd build
CC=gcc \
CXX=g++ \
HDF5_ROOT=$HDF5_PATH \
cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=$OPENMCPATH/app ..
make
make install

# Build test suite
cd ..
pip install --upgrade-strategy only-if-needed -e .[test]

# Add OpenMC to path
if [[ $(grep "export PATH="$OPENMCPATH/app/bin:'$PATH'"" $BRC) ]]
then
    echo "OpenMC already on PATH"
else
    echo "export PATH="$OPENMCPATH/app/bin:'$PATH'"" >> $BRC
    export PATH="$OPENMCPATH/app/bin:'$PATH'"
fi

# Build saltproc from source
cd $CODEPATH

# Build and install
pip install .

# Return to execution directory
cd $CURRENT
