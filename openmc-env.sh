#! ~/bin/bash
# Create empty openmc environment
conda create --name openmc-env --yes
conda activate openmc-env

# Configure conda to work with conda-forge 
conda config --env --add channels conda-forge 
conda config --env --set pip_interop_enabled True

# Back to base
conda activate base

# Create environments that have more recent versions of the software
shared_conda_pkgs="numpy \
                   scipy \
                   cython \
                   matplotlib \
                   jupyterlab \
                   nb_conda_kernels \
                   mamba"
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
# Create environments that have more recent versions of the software
mamba install ${shared_conda_pkgs} ${openmc_conda_pkgs} -n openmc-env -c conda-forge --yes
