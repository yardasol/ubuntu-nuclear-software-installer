#! ~/bin/bash
if [ !$1 ]
then	
	echo "Directory to store OpenMC: "
	read 
	export OPENMC_DIR=$
else
	export OPENMC_DIR=$1
# Create projects directory
if [ !$1 ]
then
	export NUC_SOFTWARE=$HOME/$1
else
	export NUC_SOFTWARE=$HOME/projects
fi

#github username
GITHUB_UNAME=yardasol

#Set up local git branch
git clone git@github.com:$GITHUB_UNAME/openmc
cd openmc
git remote add upstream git@github.com:openmc-dev/openmc
git fetch upstream
git merge upstream/develop
git push
git checkout upstream/master
git switch -c main
git checkout main
cd ../
