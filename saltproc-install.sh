#! ~/bin/bash
# Paths
BRC=$HOME/.bashrc
CURRENT=`pwd`
PROJECTS=$HOME/projects

# Make projects directory
if [[ ! -d "$PROJECTS" ]]; then
	mkdir $PROJECTS
fi

# github username
GITHUB_UNAME=yardasol

# Set up local git branch
git clone git@github.com:$GITHUB_UNAME/saltproc $HOME/projects/saltproc
cd $PROJECTS/saltproc
git remote add upstream git@github.com:arfc/saltproc
git fetch upstream
git merge upstream/master
git push

# Return to execution directory
cd $CURRENT
