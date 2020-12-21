#! ~/bin/bash

# Install gcc
sudo apt-get install gcc -y
sudo apt-get install update

# Install g++
sudo apt-get install g++ -y
sudo apt-get install update

# Install make
sudo apt-get install make -y
sudo apt-get install update

# Install cmake
sudo apt-get install cmake -y
sudo apt-get install update

# Configure conda to work with conda-forge 
conda config --add channels conda-forge

# Add the MOOSE framework channel
conda config --add channels idaholab

# Create nuclear environment and install the OpenMC, MOOSE, yt, gmsh, pyne packages
conda create --name nuclear openmc pyne yt gmsh moose-libmesh moose-tools jupyter --yes

# Create environements that have more recent versions of the software
conda create --name moose-env moose-libmesh moose-tools --yes
conda create --name openmc-env openmc pyne jupyter yt gmsh --yes

# Create projects directory
mkdir ~/projects
cd ~/projects

# Install sources for nuclear software
git clone https://github.com/idaholab/moose
git clone https://github.com/arfc/moltres
git clone https://github.com/openmc-dev/openmc
git clone https://github.com/pyne/pyne

# Activate the moove-env environment
conda init bash
conda activate moose-env

# Compile MOOSE
cd ~/projects/moose/test
make -j 4

# Initalize Moltres
cd ~/projects/moltres
git submodule init
git submodule update
./build_libmesh_and_moltres.sh

# Leave the nuclear environment
conda deactivate
