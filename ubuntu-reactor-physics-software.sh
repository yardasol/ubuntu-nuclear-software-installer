#! ~/bin/bash

#create projects directory
mkdir ~/projects
cd ~/projects

#install MOOSE, Moltres, and ARMI from github
git clone https://github.com/idaholab/moose
git clone https://github.com/arfc/moltres
git clone https://github.com/terrapower/armi

#activate the MOOSE environment
conda init bash
conda activate moose

#compile MOOSE
cd ~/projects/moose/test
make -j 4

#Initalize Moltres
cd ~/projects/moltres
git submodule init
git submodule update
./build_libmesh_and_moltres.sh

#leave the MOOSE environment
conda deactivate

#Setup ARMI
cd ~/projects/armi
pip3 install -r requirements.txt
python3 setup.py install
armi
pip3 install -r requirements-testing.txt
