XSDIR=$PROJECTS/cross-section-libraries

# Make cross sections directory
if [[ ! -d "$XSDIR" ]]; then
	mkdir $XSDIR
fi

# Install cross sections
source $CODEPATH/scripts/xsdata/process_j312.bash

# Run the xsdirconvert script
perl $XSDIR/xsdirconvert.pl $XSDIR/jeff312/sss_jeff312.xsdir > $XSDIR/jeff312/sss_jeff312.xsdata

# Add .xsdata file to PATH (to be created)
echo "export SERPENT_DATA="$XSDIR"/jeff312" >> $BRC
echo "export SERPENT_ACELIB="$XSDIR/jeff312/sss_jeff312.xsdata"" >> $BRC

source $HOME/.bashrc
