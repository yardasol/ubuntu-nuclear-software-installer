#! ~/bin/bash

# Create empty openmc environment
conda create --name openmc-env

# Configure conda to work with conda-forge 
conda config --append channels conda-forge idaholab

# Create environements that have more recent versions of the software
conda create --name openmc-env hdf5=1.10.4 h5py numpy scipy matplotlib uncertainties lxml mpi4py cython vtk pytest jupyterlab jinja2 --yes

# Create projects directory
if [ !$1 ]
then
	export NUC_SOFTWARE=$HOME/$1
else
	export NUC_SOFTWARE=$HOME/projects
fi

#github username
GITHUB_UNAME=yardasol

#Set up local git branch
git clone git@github.com:$GITHUB_UNAME/openmc
cd openmc
git remote add upstream git@github.com:openmc-dev/openmc
git fetch upstream
git merge upstream/develop
git push
cd ../
