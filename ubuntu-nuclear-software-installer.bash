# Stop the scripts if anything goes wrong
set -e

# Get conda working in non-interactive shell
CONDA_PATH=$(conda info | grep -i 'base environment' | awk '{print $4}')
source $CONDA_PATH/etc/profile.d/conda.sh

# Paths
CURRENT=`pwd`
CODENAME=$1
COREPATH=$CURRENT/$CODENAME
BRC=$HOME/.bashrc
PROJECTS=$HOME/projects
CODEPATH=$PROJECTS/$CODENAME

# Step 0: Get parameters for running the install, build, and test scripts
source $CODENAME/get-params.bash

if [[ "$2" == "--clean" || ! -d $CODEPATH ]]; then
    if [[ $CODENAME != "serpent" ]]
    then
        # Step 1: install software, build tools, and all dependencies
        echo "Installing $CODENAME"
        source install.bash

        # Step 2: setup conda environments
        echo "Creating environment for $CODENAME"
        source env.bash
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
if [[ -f $CODENAME/pretest.sh ]]; then
    source $CODENAME/pretest.bash
fi
source $CODENAME/test.bash
