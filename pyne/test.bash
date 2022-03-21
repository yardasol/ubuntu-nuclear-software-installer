#! ~/bin/bash

# Run unit tests
cd $CODEPATH/tests
source travis-run-tests.sh

# Run example tests
cd $CODEPATH/examples
python execer.py

# Run tutorial tests
cd $CODEPATH/tutorial
python execer.py

# Initialize en# Return to execution directory
cd $CURRENT
