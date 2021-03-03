#! ~/bin/bash

cd $HOME/projects/openmc/tools/ci
source download-xs.sh
export OPENMC_CROSS_SECTIONS=$HOME/nndc_hdf5/cross_sections.xml
export OPENMC_ENDF_DATA=$HOME/endf-b-vii.1
cd ../../tests
conda activate openmc-env
pytest
