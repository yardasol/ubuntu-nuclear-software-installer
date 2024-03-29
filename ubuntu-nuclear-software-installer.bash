# Stop the scripts if anything goes wrong
set -e

# Get conda working in non-interactive shell
CONDA_PATH=$(conda info | grep -i 'base environment' | awk '{print $4}')
source $CONDA_PATH/etc/profile.d/conda.sh

# Get # threads
N_THREADS=$(($(cat /proc/cpuinfo | grep processor | wc -l)-1)) 
if [[ $N_THREADS -le 0 ]]
then
    N_THREADS=1
fi

# Paths
CURRENT=`pwd`
CODENAME=$1
COREPATH=$CURRENT/$CODENAME
BRC=$HOME/.bashrc
PROJECTS=$HOME/projects
XSDIR=$PROJECTS/cross-section-libraries
CODEPATH=$PROJECTS/$CODENAME

# Make projects directory
if [[ ! -d "$PROJECTS" ]]; then
	mkdir $PROJECTS
fi

# Make cross section data directory
if [[ ! -d $XSDIR ]]
then
    mkdir $XSDIR
fi

# Step 0: Get parameters for running the install, build, and test scripts
source $CODENAME/get-params.bash


if [[ "$2" == "--clean" || ! -d $CODEPATH ]]; then
    if [[ $CODENAME != "serpent" ]]
    then
        # Step 1: install software, build tools, and all dependencies
        echo "Installing $CODENAME"
        source install.bash

        if [[ $CODENAME != "dagmc" ]]
        then
            # Step 2: setup conda environments
            echo "Creating environment for $CODENAME"
            source env.bash
        fi
    else
        echo "Setting up closed-source software files"
        source $CODENAME/install-extra.bash
    fi

    # Step 3: build software from source
    echo "Building $CODENAME"
    source $CODENAME/build.bash
fi

# Step 4: test that software works
echo "Testing $CODENAME"
if [[ -f $CODENAME/pretest.bash ]]; then
    source $CODENAME/pretest.bash
fi
source $CODENAME/test.bash
