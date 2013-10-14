#!/bin/bash -
set -e
cd ..
echo '---- Creating development environment ----'
mkdir -p development
echo '---- Checking out ehs trunk code ----'
svn checkout svn://svn.code.sf.net/p/ehs/code/trunk ehs-code
cd ehs-code
make -f Makefile.am
./configure --with-ssl --prefix=$(pwd)/
echo '---- Starting ehs build ----'
make
echo '---- Finished building ehs ----'
make install
echo '---- Finished installing ehs ----'
cd ..
echo '---- Checking out freerdp master ----'
git clone https://github.com/FreeRDP/FreeRDP.git
cd FreeRDP
mkdir -p build && cd build && cmake -DCMAKE_INSTALL_PREFIX=.. ..
echo '---- Building freerdp ----'
make
echo '---- Finished building freerdp ----'
make install
echo '---- Finished installing freerdp ----'
cd ../..
echo '---- Checking out webconnect code ----'
git clone https://github.com/mrd-cloudbase/FreeRDP-WebConnect.git
cd FreeRDP-WebConnect/wsgate/
make -f Makefile.am
./configure
echo '---- Building webconnect ----'
make
echo '---- Finished successfully ----'
echo '---- To run please use `./wsgate -c wsgate.mrd.ini` and connect on localhost:8888 ----'