make clean
./configure --with-pydebug --with-cxx-main=gcc-9 CC=gcc-9 CXX=g++-9 --prefix=$PREFIX
make -s -j8
make install

cd $PREFIX/bin
ln -s python3 python
ln -s pydoc3 pydoc
