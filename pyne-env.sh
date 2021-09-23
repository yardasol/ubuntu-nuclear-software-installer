#! ~/bin/bash

# Create empty pyne environment
conda create --name pyne-env --yes
conda activate pyne-env

# Configure conda to work with conda-forge 
conda config --env --add channels conda-forge 
conda config --env --set pip_interop_enabled True

# Create environments that have more recent versions of the software
conda install numpy scipy pandas uncertainties lxml pytest requests entrypoints pyyaml cython vtk nose matplotlib jinja2 setuptools future jupyterlab nb_conda_kernels --yes

pip install --upgrade-strategy only-if-needed tables
