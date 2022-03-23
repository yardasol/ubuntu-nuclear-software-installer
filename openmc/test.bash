#! ~/bin/bash

# Initialize envirnoment variables for openmc
export OPENMC_CROSS_SECTIONS=$HOME/nndc_hdf5/cross_sections.xml
export OPENMC_ENDF_DATA=$HOME/endf-b-vii.1
export PATH=$HOME/projects/NJOY2016/bin:$PATH

# Test OpenMC
cd $CODEPATH/tests
conda activate openmc-env
pytest

# Return to execution directory
cd $CURRENT
