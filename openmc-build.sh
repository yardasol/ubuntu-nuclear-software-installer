set -e

module unload intel
# environment
conda create -n openmc-env -y
conda activate openmc-env
conda install -c conda-forge mamba -y
mamba install -c conda-forge mpich mpi4py "h5py=*=*mpich*" gxx_linux-64 -y

mamba install -c conda-forge numpy scipy matplotlib pandas uncertainties lxml pytest requests entrypoints pyyaml coverage pytest-cov colorama -y

#cd $HOME/openmc
#mkdir -p app build
#make clean
#cd build
#module load cmake
#HDF5_ROOT=$CONDA_PREFIX CC=mpicc CXX=mpicxx cmake -DCMAKE_FIND_ROOT_PATH=$CONDA_PREFIX -DCMAKE_INSTALL_PREFIX=../app -DOPENMC_USE_MPI=on -DHDF5_PREFER_PARALLEL=on ..
#make
#make install

#cd ../
#pip install -e .[test]
