#! ~/bin/bash
# Paths
BRC=$HOME/.bashrc
CURRENT=`pwd`
PROJECTS=$HOME/projects
XSDIR=$PROJECTS/cross-section-libraries

# Make projects directory
if [[ ! -d "$PROJECTS" ]]; then
	mkdir $PROJECTS
fi

#github username
GITHUB_UNAME=yardasol

#Set up local git branch
git clone git@github.com:$GITHUB_UNAME/openmc $HOME/projects/openmc
cd $PROJECTS/openmc
git remote add upstream git@github.com:openmc-dev/openmc
git fetch upstream
git merge upstream/develop
git push
git checkout upstream/master
git switch -c main
git checkout main
git branch --set-upstream-to=origin/master
git merge upstream/master
git push

# Return to execution directory
cd $CURRENT

# Make cross sections directory
if [[ ! -d "$XSDIR" ]]; then
	mkdir $XSDIR
fi

# Download cross sections
wget -O - https://anl.box.com/shared/static/9igk353zpy8fn9ttvtrqgzvw1vtejoz6.xz | tar -C $XSDIR -xJ
# Add to PATH
echo "export OPENMC_CROSS_SECTIONS="$XSDIR/endfb71_hdf5/cross_sections.xml"" >> $BRC
source $HOME/.bashrc
