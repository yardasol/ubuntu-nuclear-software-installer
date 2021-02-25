# ubuntu-nuclear-software-installer
This repository contains some scripts I wrote to install software I use and contribute to in my research. The scripts also sets up local git repositories and links them to user forks (ORIGIN) and the project host repositories (UPSTREAM).

# Requirements
The user must fork all of the software tools listed below for the scripts to run successfully. 

This set of scripts installs, builds, and tests (if possible) various nuclear reactor physics and related software. 
The scripts install the following:
- [OpenMC](https://github.com/openmc-dev/openmc)
- [MOOSE](https://github.com/idaholab/moose)
- [Moltres](https://github.com/arfc/moltres)
- [PyNE](https://github.com/pyne/pyne)

There are also scripts for installing software individually. Software that currently has individual install scripts:
- [TEMOA](https://github.com/TemoaProject/temoa)


The [ubuntu-post-installer](https://github.com/samgdotson/ubuntu-post-installer) and [awesome-nuclear](https://github.com/paulromano/awesome-nuclear) repositories inspired this project
