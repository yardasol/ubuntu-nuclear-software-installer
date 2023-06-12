# Download cross sections
if [[ ! -d $XSDIR/endfb71_hdf5 ]]
then
    wget -O - https://anl.box.com/shared/static/9igk353zpy8fn9ttvtrqgzvw1vtejoz6.xz | tar -C $XSDIR -xJ
    mv $XSDIR/endf-b-vii.1-hdf5 $XSDIR/endfb71_hdf5
    # Add to PATH
    echo "export OPENMC_CROSS_SECTIONS="$XSDIR/endfb71_hdf5/cross_sections.xml"" >> $BRC
    source $HOME/.bashrc
fi
