#! ~/bin/bash
# Build saltproc from source
cd $CODEPATH

if [[ -d ../openmc ]]; then
    cd ../openmc
    pip install -e .
    cd $CODEPATH
else
    mamba install openmc
fi

# Build and install
pip install .

# Return to execution directory
cd $CURRENT
