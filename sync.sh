#! ~/bin/bash

# Remote variables
UPSTREAM=origin
ORIGIN=origin

# Get any changes
git fetch $UPSTREAM

# loop variables
branches=("main" "devel")
indices=(0 1)

# Update branches
for i in ${indices[*]}; do
	git checkout ${branches[$i]}
	git merge $UPSTREAM/${branches[$i]}
	git push $ORIGIN
done
