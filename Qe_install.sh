#!/bin/bash
#Just remember to edit the quantum espresso link 
#This is just for Quantum Espresso 7.2
#After appropriate changes can work for any Quantum Espresso version
#Done by Ronan
#Do Not remove this copyright
sudo apt install build-essential
sudo apt install gfortran
which make
which gfortran
which gcc
wget https://www.fftw.org/fftw-3.3.10.tar.gz
wget https://github.com/Reference-LAPACK/lapack/archive/refs/tags/v3.11.tar.gz
wget https://www.quantum-espresso.org/rdm-download/488/v7-2/e1050e356ccbe0146cfff2a7a856e63e/qe-7.2-ReleasePack.tar.gz
tar -zxf fftw-3.3.10.tar.gz 
tar -zxf qe-7.2-ReleasePack.tar.gz 
tar -zxf v3.11.tar.gz
cd fftw-3.3.10
./configure --enable-shared --enable-static
make
make check
sudo make install
make clean
cd
cd lapack-3.11
cd INSTALL
cp make.inc.gfortran ../make.inc
cd ../
sed -i 's/sh/bash/' make.inc
sed -i 's/librefblas.a/libblas.a/' make.inc
make blaslib
make lapacklib
sudo cp libblas.a /usr/local/lib/
sudo cp liblapack.a /usr/local/lib/
make clean
cd
sudo apt update
sudo apt upgrade
sudo apt-get install openmpi-bin openmpi-doc libopenmpi-dev
cd qe-7.2
./configure
make pwall
cd bin
MYPWD=$(pwd)
cd 
echo "" | cat >> .bashrc
echo -n 'PATH="' | cat >> .bashrc
echo -n ${MYPWD} | cat >> .bashrc
echo -n ':$' | cat >> .bashrc
echo -n 'PATH"' | cat >> .bashrc
exit
