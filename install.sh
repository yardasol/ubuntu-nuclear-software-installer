#! ~/bin/bash

conda init bash


# Install gcc, g++, make, cmake, hdf5, and openmpi
sudo apt-get install update
sudo apt-get install gcc g++ gfortran make cmake -y
sudo apt-get install libhdf5-dev libhdf5-openmpi-dev openmpi-bin libopenmpi-dev -y
sudo apt-get install update

# Configure conda to work with conda-forge 
conda config --append channels conda-forge idaholab
conda config --set pip_interop_enabled True

# Create environements that have more recent versions of the software
conda create --name moose-env --channel idaholab moose-libmesh moose-tools --yes
conda create --name openmc-env hdf5=1.10.4 h5py numpy scipy matplotlib uncertainties lxml mpi4py cython vtk pytest jupyterlab jinja2 --yes


# Create projects directory
if [ !$1 ]
then
	export $NUC_SOFTWARE=$HOME/$1
else
	export $NUC_SOFTWARE=$HOME/projects
fi

mkdir $NUC_SOFTWARE
cd $NUC_SOFTWARE

#github username
export $GITHUB_UNAME=yardasol

# Install forks for nuclear software
git clone https://github.com/$GITHUB_UNAME/moose
git clone https://github.com/$GITHUB_UNAME/moltres
git clone https://github.com/$GITHUB_UNAME/openmc
git clone https://github.com/$GITHUB_UNAME/pyne

# Create forks for development
cd moose
git remote add upstream https://github.com/idaholab/moose
git fetch upstream/next
git merge upstream/next

cd ../moltres
git remote add upstream https://github.com/arfc/moltres
git fetch upstream/devel
git merge upstream/devel

cd ../openmc
git remote add upstream https://github.com/openmc-dev/openmc
git fetch upstream/develop
git merge upstream/develop

cd ../pyne
git remote add upstream https://github.com/pyne/pyne
git fetch upstream/develop
git merge upstream/develop



