#cmake update
apt-get install -y ccache
sudo apt purge -y --auto-remove cmake
mkdir ~/temp
cd ~/temp
wget https://cmake.org/files/v3.16/cmake-3.16.5.tar.gz
tar -xzvf cmake-3.16.5.tar.gz
cd cmake-3.16.5/
./bootstrap
make -j$(nproc)
sudo make install
cmake --version
