XSDIR=$PROJECTS/cross-section-libraries

# Make cross sections directory
if [[ ! -d "$XSDIR" ]]; then
	mkdir $XSDIR
fi

# Install cross sections
source $CODEPATH/scripts/xsdir/process_j312.bash

# Add .xsdata file to PATH (to be created)
echo "export SERPENT_DATA="$XSDIR"" >> $BRC
echo "export SERPENT_ACELIB="$XSDIR/jeff312/sss_jeff312.xsdata"" >> $BRC
source $HOME/.bashrc
