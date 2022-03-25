#! ~/bin/bash
# Paths
SERPENTAPP=$CODEPATH/app

# Make serpent app directory
if [[ ! -d "$SERPENTAPP" ]]; then
    mkdir $SERPENTAPP
fi

# Build and install
cd $CODEPATH/src
make

# Add serpent executable to PATH
mv sss2 $SERPENTAPP/.
echo "export PATH="$SERPENTAPP:\$PATH"" >> $BRC

# Return to execution directory
cd $CURRENT
