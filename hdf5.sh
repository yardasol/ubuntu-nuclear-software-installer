#! ~\bin\bash

VERSION=1.10
SUBVERSION=4
wget -q -O - https://support.hdfgroup.org/ftp/HDF5/releases/hdf5-$VERSION/hdf5-$VERSION.$SUBVERSION/src/hdf5-$VERSION.$SUBVERSION.tar.gz | tar -C $HOME -zx

HDF5_INSTALL_PATH=/usr/local/hdf5-$VERSION
cd $HOME/hdf5-$VERSION.$SUBVERSION
CC=gcc ./configure --prefix=$HDF5_INSTALL_PATH --enable-cxx
make
make check
sudo make install
sudo make check-install
