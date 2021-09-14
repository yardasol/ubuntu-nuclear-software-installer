# Step 0: Stop the scripts if anything goes wrong
set -e

# Step 1: install software, build tools, and all dependencies
source install.sh

# Step 2: build software from source
source build.sh

# Step 3: test that software works
source test.sh
