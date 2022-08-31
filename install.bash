#! ~/bin/bash

# github username
GITHUB_UNAME=yardasol

# Set up local git branch
if [[ ! -d "$CODEPATH" ]]
then
    git clone --recurse-submodules git@github.com:$GITHUB_UNAME/$CODENAME $CODEPATH
    cd $CODEPATH
    git remote add upstream git@github.com:$ORGNAME/$CODENAME
fi
cd $CODEPATH
git fetch upstream
if [[ ! $(git branch --list $BRANCH) ]]
then
    if [[ $TAG ]]
    then
        git checkout tags/$TAG -b $BRANCH
    else
        git checkout upstream/$BRANCH
        git switch -c $BRANCH
    fi
else
    git checkout $BRANCH
fi
git merge upstream/$BRANCH
git push --set-upstream origin $BRANCH

# Return to execution directory
cd $CURRENT

if [[ $INSTALLEXTRA -eq 1 ]]; then
    source $CODENAME/install-extra.bash
fi
