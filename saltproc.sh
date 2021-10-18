#
conda create -n saltproc
conda activate saltproc

conda config --env --append channels conda-forge
conda config --env --set pip_interop_enabled True

conda install numpy scipy matplotlib notebook nb_conda_kernels 
cd $HOME/projects/pyne
python setup.py install --user
pip install tables networkx[default] pydotplus sphinx
