#! ~/bin/bash
# Activate conda environment
conda activate cpython-env
conda-build python-dbg

# Return to execution directory
cd $CURRENT
