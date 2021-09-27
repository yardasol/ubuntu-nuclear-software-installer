#! ~/bin/bash

# Create empty pyne environment
conda create --name pyne-env --yes
conda activate pyne-env

# Configure conda to work with conda-forge 
conda config --env --add channels conda-forge 
conda config --env --set pip_interop_enabled True

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
pyne_conda_pkgs="nose \
                 jinja2 \
                 setuptools \
                 future"
pyne_pip_pkgs="tables"


# Create environments that have more recent versions of the software
conda install ${shared_conda_pkgs} ${openmc_conda_pkgs} ${pyne_conda_pkgs} --yes

pip install --upgrade-strategy only-if-needed ${pyne_pip_pkgs} 
