#! ~/bin/bash

# Do we need to reinitialize the environment?
echo "recreate openmc environment?"
echo "'y' if so, otherwise enter any other charater(s)"

read input

if [[ $input = "y" ]];
	then
	# Remove current openmc environment
	conda activate base
	conda env remove -n openmv-env

	# Create empty openmc environment
	conda create --name openmc-env --yes
	conda activate openmc-env

	# Configure conda to work with conda-forge
	conda config --env --append channels conda-forge
	conda config --env --set pip_interop_enabled True

	# Create environments that have more recent versions of the software
	conda install numpy scipy pandas matplotlib uncertainties lxml pytest requests entrypoints pyyaml jupyterlab nb_conda_kernels --yes

	# build h5py
	CC=gcc \
	HDF5_DIR=/usr/local/hdf5-$HDF5_VERSION \
	pip install --upgrade-strategy only-if-needed --no-binary=h5py h5py

	# Install cython, vtk for additional tests
	pip install cython
	pip install vtk

	pip install --upgrade-strategy only-if-needed -e .[test]
else
	conda activate openmc-env
fi


cd $HOME/projects/openmc

# Download the test cross sections
cd tools/ci
./download-xs.sh
mv $HOME/endf-b-vii.1 $XSDIR/endf-b-vii.1
mv $HOME/nndc_hdf5 $XSDIR/nndc_hdf5

# NJOY requires a bit more effort to get
DIR=$HOME/projects/NJOY2016
if [[ ! -d "$DIR" ]]; then
	git clone git@github.com:njoy/NJOY2016 $DIR
	cd $DIR
	mkdir bin && cd bin
else
	cd $DIR
	git checkout master
	git fetch origin
	git merge origin/master
	cd bin
fi
cmake -D CMAKE_BUILD_TYPE=Release ../
make -j $N_THREADS
make test

# Return to execution directory
cd $CURRENT
