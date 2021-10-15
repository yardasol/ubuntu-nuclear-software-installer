#! ~/bin/bash

# Create empty pyne environment
conda create --name saltproc-env --yes
conda activate saltproc-env

# Configure conda to work with conda-forge 
conda config --env --add channels conda-forge 
conda config --env --set pip_interop_enabled True

# Create environments that have more recent versions of the software
shared_conda_pkgs="numpy \
                   scipy \
                   cython \
                   matplotlib \
                   jupyterlab \
                   nb_conda_kernels"
openmc_conda_pkgs="pandas \
                   uncertainties \
                   lxml \
                   pytest \
                   requests \
                   entrypoints \
                   pyyaml \
                   vtk \
                   coverage \
                   pytest-cov \
                   colorama"
saltproc_conda_pkgs="pyne pytables vitables qtpy argparse"
saltproc_pip_pkgs="networkx \
                   pydotplus \
                   vitables"
conda install ${shared_conda_pkgs} ${openmc_conda_pkgs} ${saltproc_conda_pkgs} --yes

pip install --upgrade-strategy only-if-needed ${saltproc_pip_pkgs}
