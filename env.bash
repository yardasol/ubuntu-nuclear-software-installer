#! ~/bin/bash
#
conda create -n $CODENAME-env
echo "Activate the env"
conda activate $CODENAME-env

# Configure conda to work with conda-forge
EXPR="$(conda config --show channels)"
if [[ $EXPR =~ "conda-forge" ]]
then
    echo "conda-forge already in channels"
else
    conda config --env --append channels conda-forge
fi
conda config --env --set pip_interop_enabled True

echo "update the env"
conda env update -f $CODENAME/environment.yml
