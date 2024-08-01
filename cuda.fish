set distro ubuntu2404
set arch x86_64

proxy-aria2c "https://developer.download.nvidia.com/compute/cuda/repos/$distro/$arch/cuda-keyring_1.1-1_all.deb"
sudo apt install ./cuda-keyring_1.1-1_all.deb
sudo rm /etc/apt/preferences.d/cuda*

sudo apt install cuda nvidia-gds libcudnn8-dev libcudnn9-dev-cuda-12 libnccl-dev
