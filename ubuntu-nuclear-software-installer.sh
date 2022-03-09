# Step 0: Stop the scripts if anything goes wrong
set -e

# Get conda working in non-interactive shell
CONDA_PATH=$(conda info | grep -i 'base environment' | awk '{print $4}')
source $CONDA_PATH/etc/profile.d/conda.sh

# Move into the directory for the code we want to install
CODENAME=$1
BRC=$HOME/.bashrc
PROJECTS=$HOME/projects
CODEPATH=$PROJECTS/$CODENAME
source $CODENAME/get-params.sh

# Step 1: install software, build tools, and all dependencies
echo "Installing $CODENAME"
source install.sh

# Step 2: setup conda environments
echo "Creating environment for $CODENAME"
source env.sh

# Step 3: build software from source
echo "Building $CODENAME"
cd $CODENAME
source build.sh

# Step 4: test that software works
echo "Testing $CODENAME"
if [[ -f pretest.sh ]]; then
    source pretest.sh
fi
source test.sh
