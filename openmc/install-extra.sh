XSDIR=$PROJECTS/cross-section-libraries

# Make cross sections directory
if [[ ! -d "$XSDIR" ]]; then
	mkdir $XSDIR
fi

# Download cross sections
wget -O - https://anl.box.com/shared/static/9igk353zpy8fn9ttvtrqgzvw1vtejoz6.xz | tar -C $XSDIR -xJ

# Add to PATH
echo "export OPENMC_CROSS_SECTIONS="$XSDIR/endfb71_hdf5/cross_sections.xml"" >> $BRC
source $HOME/.bashrc