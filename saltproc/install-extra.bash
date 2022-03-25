XSDIR=$PROJECTS/cross-section-libraries

# Make cross sections directory
if [[ ! -d "$XSDIR" ]]; then
	mkdir $XSDIR
fi

# Install cross sections
source $CODEPATH/scripts/xsdata/process_j312.bash

source $HOME/.bashrc
