# ubuntu-nuclear-software-installer
This repository contains some scripts I wrote to install software I use and contribute to in my research. The scripts also sets up local git repositories and links them to user forks (ORIGIN) and the project host repositories (UPSTREAM).

This set of scripts installs, builds, and tests (if possible) various nuclear reactor physics and related software. 
The scripts install the following:
- [OpenMC](https://github.com/openmc-dev/openmc)
- [PyNE]()
- [SaltProc]()

# Requirements
 - The user must have a fork of the desired software tool(s) (from the list of supported software below) for the scripts to run successfully. 
 - The user must have [conda](https://docs.conda.io/en/latest/) installed. Currently, the software only works if with anaconda. The `anaconda3` folder must be located in `home`. I recommend using Sam Dotson's script [ubuntu-post-installer](https://github.com/samgdotson/ubuntu-post-installer) to do this, as well as set up a few other useful pieces of software on ubuntu)

# Installation
Assuming you have set up [ssh keys](https://docs.github.com/en/github/authenticating-to-github/connecting-to-github-with-ssh), run the following in your terminal
```bash
git clone git@github.com:yardasol/ubuntu-nuclear-software-installer
```
Boom. You're done

# Usage
***NOTE:*** The scripts have my directory structure hard-coded in right now, so the instructions below will not work as-is without some tinkering on your part. This will be changed in the near future to be more generalized.

To use the software, run the following in your terminal
```bash
cd ubuntu-nuclear-software-installer
source ubuntu-nuclear-software-installer.sh CODENAME
```
Boom. You're done.

# Contributing
Please read [CONTRIBUTING.md](https://github.com/yardasol/ubuntu-nuclear-software-installer/blob/main/CONTRIBUTING.md) before making any changes

# License
These scripts are currently not licensed. I need to review the licenses of the software tools to see if I can do this, and if so, what my options are.

# Credits
The [ubuntu-post-installer](https://github.com/samgdotson/ubuntu-post-installer) and [awesome-nuclear](https://github.com/paulromano/awesome-nuclear) repositories inspired this project
