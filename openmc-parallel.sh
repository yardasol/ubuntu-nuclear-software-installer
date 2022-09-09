set -e
module unload intel

# environment
conda create -n openmc-parallel
conda activate openmc-parallel
conda install -c conda-forge mamba -y
mamba install -c conda-forge mpich numpy -y
mamba install -c conda-forge gxx_linux-64 -y

# install hdf5
HDF5_PATH=$HOME/hdf5-1.12.2
#tar -xzf $HDF5_PATH.tar.gz
cd $HDF5_PATH
make clean
CC=mpicc ./configure --enable-parallel --prefix=$HOME/openmc_parallel/hdf5
make -j -l6
sbatch check-s.sbatch
sbatch check-p.sbatch
make install

CC=mpicc pip install mpi4py
CC=mpicc CXX=mpicxx HDF5_MPI=ON HDF5_DIR=$HOME/openmc_parallel/hdf5 pip install --no-binary=h5py h5py
mamba install -c conda-forge scipy matplotlib pandas uncertainties lxml pytest requests entrypoints pyyaml coverage pytest-cov colorama -y

cd $HOME/openmc
mkdir -p build_parallel
cd build_parallel
module load cmake
HDF5_ROOT=$HOME/openmc_parallel/hdf5 CC=mpicc CXX=mpicxx cmake -DCMAKE_FIND_ROOT_PATH=$CONDA_PREFIX -DCMAKE_INSTALL_PREFIX=../../openmc_parallel/openmc -DOPENMC_USE_MPI=on -DHDF5_PREFER_PARALLEL=on ..
make
make install
cd ../
pip install -e .[test]
