XSDIR=$PROJECTS/cross-section-libraries 
SERPENTDIR=$PROJECTS/serpent
SERPENTSRC=$SERPENTDIR/src
SERPENTAPP=$SERPENTDIR/app

# Make cross sections directory
if [[ ! -d "$XSDIR" ]]; then
	mkdir $XSDIR
fi

# Make serpent directory
if [[ ! -d "$SERPENTDIR" ]]; then
    mkdir $SERPENTDIR
fi

# Make serpent src directory
if [[ ! -d "$SERPENTSRC" ]]; then
    mkdir $SERPENTSRC
fi

# Make serpent app directory
if [[ ! -d "$SERPENTAPP" ]]; then
    mkdir $SERPENTAPP
fi

# Extract serpent
cd $SERPENTDIR
if [[ ! -d $CODEPATH/xsdata ]]
then
    echo "Cross setions not extracted"
    unzip serpent-2.32.zip -x 'Release notes.htm' README.htm xsdata/README.htm
else
    echo "Cross sections already extracted"
    unzip serpent-2.32.zip -x 'Release notes.htm' README.htm xsdata/README.htm xsdata/*.zip
fi


# Extract serpent source code
tar -xzf Serpent2.tar.gz -C $SERPENTSRC 
tar -xzf sssup2.1.32.tar.gz -C $SERPENTSRC
cd $SERPENTSRC
BFPATH=$COREPATH/bugfixes

# Apply bugfixes
BUG1="$(cat $BFPATH/bug1.txt)"
BUG2="$(cat $BFPATH/bug2.txt)"
BUG3="$(cat $BFPATH/bug3.txt)"
BUG4="$(cat $BFPATH/bug4.txt)"
BUG5="$(cat $BFPATH/bug5.txt)"
FIX1="$(cat $BFPATH/fix1.txt)"
FIX2="$(cat $BFPATH/fix2.txt)"
FIX3="$(cat $BFPATH/fix3.txt)"
FIX4="$(cat $BFPATH/fix4.txt)"
FIX5="$(cat $BFPATH/fix5.txt)"

# this isn't working for some reason...
# see https://stackoverflow.com/questions/31056599/bash-sed-replace-text-with-file-content
echo "bugfix 1"
sed -i "s/$BUG1/$FIX1/g" processsymmetries.c
#echo "bugfix 2"
#sed -i "s/$BUG2/$FIX2/g" xsplotter.c
echo "bugfix 3"
sed -i "s/'$BUG3'/'$FIX3'/g" xsplotter.c
echo "bugfix 4"
sed -i "s/$BUG4/$FIX4/g" adjustsabdata.c
echo "bugfix 5"
sed -i "s/$BUG5/$FIX5/g" fissmtxoutput.c

# Modify serpent Makefile
sed -i "LDFLAGS += -lgd/#LDFLAGS += -lgd/g" Makefile
sed -i "s/#CFLAGS += -DNO_GFX_MODE/CFLAGS += -DNO_GFX_MODE/g" Makefile
sed -i "s/EXE     = sss2/EXE     = $SERPENTAPP\/sss2/g" Makefile

# Add serpent executable to PATH
echo "export PATH="$SERPENTAPP:\$PATH"" >> $BRC

source $HOME/.bashrc
