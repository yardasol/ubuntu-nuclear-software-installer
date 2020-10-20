#! ~/bin/bash

#install gcc
sudo apt-get install gcc -y
sudo apt-get install update

#install make
sudo apt-get install make -y
sudo apt-get install update

#install Miniconda3
#curl -L -O https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
#bash Miniconda3-latest-Linux-x86_64.sh -b -p ~/miniconda3

#Export miniconda3 to your PATH
#export PATH=$HOME/miniconda3/bin:$PATH

#Configure conda to work with conda-forge 
conda config --add channels conda-forge

#add the MOOSE framework channel
conda config --add channels idaholab

#Create nuclear environment and install the OpenMC, MOOSE, and yt packages
conda create --name nuclear openmc moose-libmesh moose-tools yt tox 

#install gmsh
pip install --upgrade gmsh

#install pip3
sudo apt-get install python3-pip

#Install tox
pip install tox

