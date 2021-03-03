#!/bin/bash
# basic install
# run as "yes | ./basic_install.sh"

# Get the release number of the current operating system.
UBUNTU_RELEASE=`lsb_release -rs`

if [[ $UBUNTU_RELEASE == "16.04" ]]; then
    UBUNTU_PATH=ubuntu1604
elif [[ $UBUNTU_RELEASE == "18.04" ]]; then
    UBUNTU_PATH=ubuntu1804
else
    echo "Invalid release number !!!"
    exit 1
fi

sudo apt update
sudo apt install \
    zsh \
    nmap \
    samba \
    network-manager-openconnect-gnome \
    tmux \
    exuberant-ctags \
    xfce4 \
    vnc4server \
    dconf-editor \
    doxygen \
    dpkg-dev \
    gcc \
    g++ \
    gfortran \
    glew-utils \
    isc-dhcp-server \
    libavcodec-dev \
    libavformat-dev \
    libboost-dev \
    libboost-filesystem-dev \
    libboost-program-options-dev \
    libbz2-dev \
    libglew-dev \
    librtmp-dev \
    libssl-dev \
    libswscale-dev \
    libusb-1.0-0-dev \
    libx11-dev \
    libxrandr-dev \
    libxcursor-dev \
    libxxf86vm-dev \
    libxinerama-dev \
    libxi-dev \
    minicom \
    nfs-kernel-server \
    software-properties-common \
    sshpass \
    x11-xserver-utils \
    xorg-dev \
    zlib1g-dev \
    libz1 \
    libncurses5 \
    libbz2-1.0:i386 \
    libstdc++6 \
    libbz2-1.0 \
    lib32z1 \
    lib32ncurses5  \
    lib32stdc++6 \
    htop \
    vim \
    vim-gnome \
    libglu1-mesa-dev \
    libglfw3-dev \
    libgles2-mesa-dev \
    python3 \
    python3-pip \
    cifs-utils \
    libjpeg-dev

if [[ $UBUNTU_RELEASE == "18.04" ]]; then
    # python2.7 for 1804
    sudo apt install \
    python-minimal \
    libcurl4-gnutls-dev \
    libpng-dev
else
    sudo apt install \
    libgnutls-dev \
    libpng12-dev
fi

echo "=========================================="
echo " Install gstreamer0.10-ffmpeg"
echo "=========================================="
if [[ $UBUNTU_RELEASE == "16.04" ]]; then
    sudo add-apt-repository ppa:mc3man/gstffmpeg-keep 
    sudo apt update
    sudo apt install gstreamer0.10-ffmpeg gstreamer1.0-plugins-ugly gstreamer1.0-libav
fi

echo "=========================================="
echo " Installing cmake"
echo "=========================================="
TEMP_DIR=~/basic_install
CMAKE_VERSION=3.13.3
sudo rm $TEMP_DIR -rf
mkdir $TEMP_DIR
cd $TEMP_DIR
wget https://github.com/Kitware/CMake/releases/download/v${CMAKE_VERSION}/cmake-${CMAKE_VERSION}.tar.gz
tar xf cmake-${CMAKE_VERSION}.tar.gz
cd cmake-${CMAKE_VERSION}/
./configure && make && sudo make install

# Add xenial to /etc/apt/sources.list temporarily
if [[ $UBUNTU_RELEASE == "18.04" ]]; then
    sudo add-apt-repository "deb http://cn.archive.ubuntu.com/ubuntu/ xenial main"
    sudo add-apt-repository "deb http://cn.archive.ubuntu.com/ubuntu/ xenial universe"
    sudo apt update
fi
sudo apt install gcc-4.9
sudo apt install g++-4.9

echo "========================="
echo " Install Git and Git LFS "
echo "========================="
sudo apt-add-repository ppa:git-core/ppa
sudo apt update
sudo apt install git
# For git-lfs: which provides revision control on large binary files
wget https://packagecloud.io/install/repositories/github/git-lfs/script.deb.sh
chmod +x script.deb.sh
sudo ./script.deb.sh
sudo apt update
sudo apt install git-lfs
git lfs install

echo "=========================="
echo " Install other useful apps "
echo "=========================="
sudo apt install vlc  #(for viewing RR test h.264 videos)
sudo apt install meld  #(useful graphical diff utility on Linux)
sudo apt install openssh-server #(allows easy copying of files between your desktop and DDPX)
sudo apt install pinta #(useful for annotating visual profiles on Linux)

# SimpleScreenRecorder
sudo add-apt-repository ppa:maarten-baert/simplescreenrecorder
sudo apt update
sudo apt install simplescreenrecorder simplescreenrecorder-lib

# In order to flash using docker, you will need to install a specific version of the docker software.
echo "=========================================================================="
echo " Install Docker and enable Non-root Users to Run Docker Commands"
echo "=========================================================================="
sudo apt update
# sudo apt install linux-image-extra-$(uname -r) linux-image-extra-virtual
# Install a few prerequisite packages which let apt use packages over HTTPS
sudo apt install apt-transport-https ca-certificates curl software-properties-common
# Add the GPG key for the official Docker repository to your system
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
# Add the Docker repository to APT sources:
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt update
sudo apt install docker-ce
sudo usermod -aG docker $USER

# Update setuptools
pip3 install --upgrade setuptools --user

echo " -------------------------------------------------------------------------------------"
echo " + All the work finished !"
echo " + Now, reboot | relog out and log back in to have your new permissions take effect."
echo " -------------------------------------------------------------------------------------"
