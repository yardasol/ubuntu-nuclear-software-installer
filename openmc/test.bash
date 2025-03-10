#! ~/bin/bash

# Initialize envirnoment variables for openmc
export OPENMC_CROSS_SECTIONS=$XSDIR/nndc_hdf5/cross_sections.xml
export OPENMC_ENDF_DATA=$XSDIR/endf-b-vii.1
export PATH=$HOME/projects/NJOY2016/bin:$PATH
echo "export OPENMC_CROSS_SECTIONS=$XSDIR/nndc_hdf5/cross_sections.xml" >> $BRC
echo "export OPENMC_ENDF_DATA=$XSDIR/endf-b-vii.1" >> $BRC
echo "export PATH="HOME/projects/NJOY2016/bin:'$PATH'"" >> $BRC

# Test OpenMC
cd $CODEPATH/tests
conda activate openmc-env
pytest

# Return to execution directory
cd $CURRENT
