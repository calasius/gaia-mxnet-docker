#intel MKL IPP TBB
cd /tmp
wget https://apt.repos.intel.com/intel-gpg-keys/GPG-PUB-KEY-INTEL-SW-PRODUCTS-2019.PUB
apt-key add GPG-PUB-KEY-INTEL-SW-PRODUCTS-2019.PUB
sudo sh -c 'echo deb https://apt.repos.intel.com/mkl all main > /etc/apt/sources.list.d/intel-mkl.list'
sudo sh -c 'echo deb https://apt.repos.intel.com/ipp all main > /etc/apt/sources.list.d/intel-ipp.list'
sudo sh -c 'echo deb https://apt.repos.intel.com/tbb all main > /etc/apt/sources.list.d/intel-tbb.list'
sudo sh -c 'echo deb https://apt.repos.intel.com/daal all main > /etc/apt/sources.list.d/intel-daal.list'
apt-get update
apt-get install -y intel-mkl-64bit-2020.0-088
apt-get install -y intel-ipp-64bit-2020.0-088
apt-get install -y intel-tbb-64bit-2020.0-088
apt-get install -y intel-daal-64bit-2020.0-088
echo "/opt/intel/lib/intel64_lin"     >  /etc/ld.so.conf.d/mkl.conf
echo "/opt/intel/mkl/lib/intel64_lin" >> /etc/ld.so.conf.d/mkl.conf
echo "/opt/intel/ipp/lib/intel64_lin" >> /etc/ld.so.conf.d/mkl.conf
echo "/opt/intel/tbb/lib/intel64_lin" >> /etc/ld.so.conf.d/mkl.conf
echo "/opt/intel/daal/lib/intel64_lin" >> /etc/ld.so.conf.d/mkl.conf
ldconfig
