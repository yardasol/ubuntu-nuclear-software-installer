# ubuntu-nuclear-software-installer
This repository contains some scripts I wrote to install software I use and contribute to in my research. The scripts also sets up local git repositories and links them to user forks (ORIGIN) and the project host repositories (UPSTREAM).

This set of scripts installs, builds, and tests (if possible) various nuclear reactor physics and related software. 
The scripts install the following:
- [OpenMC](https://github.com/openmc-dev/openmc)
- [PyNE](https://github.com/pyne/pyne)
- [SaltProc](https://github.com/arfc/saltproc)
- [CPython](https://github.com/python/cpython) 

  builds python with debugging symbols turned on as a conda package. This is useful for using interactive debuggers (e.g. `gdb`) on software like PyNE that use both C and Python)
- [Serpent2](http://montecarlo.vtt.fi/) 
 
  **note**: since serpent is export-controlled software, you'll need to obtain the source code on your own. All information used to modify install flags and apply bug fixes can be found on the [installation page in the Serpent wiki](https://serpent.vtt.fi/mediawiki/index.php/Installing_and_running_Serpent) and the [Serpent forums](https://ttuki.vtt.fi/serpent/index.php?sid=3038d3b423fe27ac9e5a75c11425fa00) respectively. See `serpent/bugfixes/` for an itemized list of
    each bug.


# Requirements
 - The user must have a fork of the desired software tool(s) (if a public repository exists) for the scripts to run successfully. 
 - The user must have [conda](https://docs.conda.io/en/latest/) installed for software that uses python. Currently, the software only works if with anaconda. The `anaconda3` folder must be located in `home`. I recommend using Sam Dotson's script [ubuntu-post-installer](https://github.com/samgdotson/ubuntu-post-installer) to do this, as well as set up a few other useful pieces of software on ubuntu)

# Installation
Assuming you have set up [ssh keys](https://docs.github.com/en/github/authenticating-to-github/connecting-to-github-with-ssh), run the following in your terminal
```bash
git clone git@github.com:yardasol/ubuntu-nuclear-software-installer
```
Boom. You're done

# Usage
The following variables should be set by the end user:
 - `GITHUB_UNAME` in `install.bash`

To use the software, run the following in your terminal
```bash
cd ubuntu-nuclear-software-installer
bash ubuntu-nuclear-software-installer.bash CODENAME
```

If something went wrong and you want to try again, add the `--clean` flag:
```bash
bash ubuntu-nuclear-software-installer.bash CODENAME --clean
```

Boom. You're done.

# Contributing
Please read [CONTRIBUTING.md](https://github.com/yardasol/ubuntu-nuclear-software-installer/blob/main/CONTRIBUTING.md) before making any changes

# Credits
The [ubuntu-post-installer](https://github.com/samgdotson/ubuntu-post-installer) and [awesome-nuclear](https://github.com/paulromano/awesome-nuclear) repositories inspired this project. The following wikis, forums, and docs were invaluable resources in writing these scripts:
- `openmc/`
  - [OpenMC docs](https://docs.openmc.org)
  - [OpenMC forums](https://openmc.discourse.group/)
- `pyne/`
  - [PyNE docs](https://pyne.io/)
  - [PyNE forums](https://groups.google.com/g/pyne-dev?pli=1)
- `cpython/`
  - [Python Developers guide](https://devguide.python.org/setup/)
  - [`conda-build` documentation](https://docs.conda.io/projects/conda-build/en/latest/)
  - [`python-feedstock` recipe](https://github.com/conda-forge/python-feedstock/tree/main/recipe) 
- `serpent/`
  - [The serpent forums](https://ttuki.vtt.fi/serpent/index.php)
  - [Serpent wiki](https://serpent.vtt.fi/mediawiki/index.php/Installing_and_running_Serpent)
- `saltproc/`
  - All of the above
  - [The SaltProc docs](https://arfc.github.io/saltproc/)
