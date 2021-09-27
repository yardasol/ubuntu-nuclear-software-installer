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
pyne_conda_pkgs="nose \
                 jinja2 \
                 setuptools \
                 future"
pyne_pip_pkgs="tables"
saltproc_conda_pkgs="pytables"
saltproc_pip_pkgs="networkx \
                   pydotplus \
                   vitables"
conda install ${shared_conda_pkgs} ${openmc_conda_pkgs} ${pyne_conda_pkgs} ${saltproc_conda_pkgs} --yes

pip install --upgrade-strategy only-if-needed ${pyne_pip_pkgs} ${saltproc_pip_pkgs}
