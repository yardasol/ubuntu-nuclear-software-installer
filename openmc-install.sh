#! ~/bin/bash
CURRENT=pwd
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

# Make cross sections directory
if [[ ! -d "$XSDIR" ]]; then
	mkdir $XSDIR
fi

# Download cross sections
wget -O $XSDIR/endfb71.tar.xz https://anl.box.com/shared/static/9igk353zpy8fn9ttvtrqgzvw1vtejoz6.xz
tar -xJf $XSDIR/endfb71.tar.xz -C $XSDIR/.
