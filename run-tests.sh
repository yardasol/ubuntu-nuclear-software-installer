#activate the MOOSE environment
conda init bash
conda activate moose

#test MOOSE
cd ~/projects/moose/test
./run_tests -j 4

#Test Moltres
cd ~/projects/moltres
./run_tests -j8

#leave the MOOSE environment
conda deactivate

#Compile and test ARMI
cd ~/projects/armi
tox -- -n 6

#
cd ~/ubuntu-reactor-physics-software
