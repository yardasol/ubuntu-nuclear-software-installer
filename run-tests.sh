# Activate the moove-env environment
conda init bash
conda activate moose-env

# Compile and test MOOSE
cd ~/projects/moose/test
make -j 4

# Compile and test Moltres
cd ~/projects/moltres
git submodule init
git submodule update
./build_libmesh_and_moltres.sh
./run-tests -j8

#leave the MOOSE environment
conda deactivate

# Return to the directory we started in
cd ~/ubuntu-reactor-physics-software
