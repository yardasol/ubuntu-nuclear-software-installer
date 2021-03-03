#! ~/bin/bash

cd $HOME/projects/openmc/tools/ci
# Download the test cross sections
source download-xs.sh
export OPENMC_CROSS_SECTIONS=$HOME/nndc_hdf5/cross_sections.xml
export OPENMC_ENDF_DATA=$HOME/endf-b-vii.1

# NJOY requires a bit more effort to get
git clone git@github.com:njoy/NJOY2016 $HOME/projects/NJOY2016
cd $HOME/projects/NJOY2016
mkdir bin && cd bin
cmake -D CMAKE_BUILD_TYPE=Release ../
make
make test
export PATH=$HOME/projects/NJOY2016/bin:$PATH

# Test OpenMC
cd ../../tests
conda activate openmc-env
pytest
