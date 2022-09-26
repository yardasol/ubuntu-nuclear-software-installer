#! ~/bin/bash
# Build NJOY from source
cd $CODEPATH && mkdir -p bin && cd bin
CC=gcc \
CXX=g++ \
FC=gfortran \
cmake -DCMAKE_BUILD_TYPE=Release ..
make

# Add NJOY to path
if [[ $(grep "export PATH="$CODEPATH/bin:'$PATH'"" $BRC) ]]
then
    echo "NJOY already on PATH"
else
    echo "export PATH="$CODEPATH/bin:'$PATH'"" >> $BRC
    export PATH="$CODEPATH/bin:'$PATH'"
fi
#source $HOME/.bashrc

# Return to execution directory
cd $CURRENT
