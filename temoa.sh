#! ~/bin/bash

cd ~/projects
mkdir temoa-py3; cd temoa-py3
wget https://raw.githubusercontent.com/TemoaProject/temoa/energysystem/environment.yml
conda env create
conda activate temoa-py3
git clone https://github.com/TemoaProject/temoa
git clone https://github.com/yardasol/pride
cd pride
git remote set-url origin git@github.com:yardasol/pride
git remote add upstream https://github.com/arfc/pride
git fetch upstream
git merge upstream/master
