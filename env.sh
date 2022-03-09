#! ~/bin/bash
#
conda create -n $CODENAME-env
echo "Activate the env"
conda activate $CODENAME-env

# Configure conda to work with conda-forge
conda config --env --append channels conda-forge
conda config --env --set pip_interop_enabled True

echo "update the env"
mamba env update -f $CODENAME/environment.yml
