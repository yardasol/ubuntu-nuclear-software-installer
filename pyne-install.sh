#! ~/bin/bash
# Paths
BRC=$HOME/.bashrc
CURRENT=`pwd`
PROJECTS=$HOME/projects

# Make projects directory
if [[ ! -d "$PROJECTS" ]]; then
	mkdir $PROJECTS
fi

# github username
GITHUB_UNAME=yardasol

# Set up local git branch
git clone git@github.com:$GITHUB_UNAME/pyne $HOME/projects/pyne
cd $PROJECTS/pyne
git remote add upstream git@github.com:pyne/pyne
git fetch upstream
git merge upstream/develop
git push

# Return to execution directory
cd $CURRENT

# Check for necessary packages (apt)
apt_package_list="software-properties-common \
                  python3-pip \
                  wget \
                  build-essential \
                  git \
                  cmake \
                  gfortran \
                  libblas-dev \
                  liblapack-dev \
                  libeigen3-dev \
                  libhdf5-dev \
                  hdf5-tools"

sudo apt-get -y update
sudo apt-get install -y ${apt_package_list}

# Install other dependencies
cd $PROJECTS

# MOAB
if [[! -d $PROJECTS/moab ]]; then
    git clone --branch Version5.1.0 --single-branch https://bitbucket.org/fathomteam/moab moab
fi


# DAGMC
if [[! -d $PROJECTS/dagmc ]]; then
    git clone git@github.com:svalinn/DAGMC
fi


# OpenMC
if [[! -d $PROJECTS/openmc ]]; then
    git clone git@github.com:openmc-dev/openmc
fi

