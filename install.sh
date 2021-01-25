#! ~/bin/bash

# Install gcc, g++, make, cmake, hdf5, and openmpi
sudo apt update
sudo apt install gcc g++ gfortran make cmake -y
sudo apt install libhdf5-dev libhdf5-openmpi-dev openmpi-bin libopenmpi-dev -y
sudo apt update

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
GITHUB_UNAME=yardasol
authors=("idaholab" "arfc" "openmc-dev" "pyne")
repos=("moose" "moltres" "openmc" "pyne")
branches=("next" "devel" "develop" "develop")
indices=(0 1 2 3)

#Set up local git branches
for i in ${indices[*]}; do
  git clone https://github.com/$GITHUB_UNAME/${repos[$i]}
  cd ${repos[$i]}
  git remote set-url origin git@github.com:$GITHUB_UNAME/${repos[$i]}.git
  git remote add upstream https://github.com/${authors[$i]}/${repos[$i]}
  git fetch upstream
  git merge upstream/${branches[$i]}
  git push
  cd ../
done
