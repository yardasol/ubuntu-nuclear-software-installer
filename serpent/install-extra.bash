SERPENTSRC=$CODEPATH/src

# download cross section dir convert script
wget -O $XSDIR/xsdirconvert.pl http://montecarlo.vtt.fi/download/xsdirconvert.pl

# Make serpent directory
if [[ ! -d "$CODEPATH" ]]; then
    mkdir $CODEPATH
fi

# Make serpent src directory
if [[ ! -d "$SERPENTSRC" ]]; then
    mkdir $SERPENTSRC
fi

# Extract serpent
cd $CODEPATH
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
echo "bugfix 1"
sed -i "s/$(cat $BFPATH/bug1.txt)/$(cat $BFPATH/fix1.txt)/g" processsymmetries.c
echo "bugfix 2"
sed -i "$(head -n 1 $BFPATH/bug2.txt)/,/$(tail -n 1 $BFPATH/bug2.txt)/c $(cat $BFPATH/fix2.txt)" xsplotter.c
echo "bugfix 3"
sed -i "169c $(cat $BFPATH/fix3.txt)" adjustsabdata.c
echo "bugfix 4"
sed -i "37c $(cat $BFPATH/fix4.txt)" fissmtxoutput.c

# Modify serpent Makefile
echo "comment out LDFLAGS"
sed -i "s/LDFLAGS += -lgd/#LDFLAGS += -lgd/g" Makefile
echo "uncomment CFLAGS"
sed -i "s/#CFLAGS += -DNO_GFX_MODE/CFLAGS += -DNO_GFX_MODE/g" Makefile

cd $CURRENT
