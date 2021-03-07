#!/bin/bash
# run as "yes | ./install.sh"

# Get the release number of the current operating system.
UBUNTU_RELEASE=`lsb_release -rs`

if [[ $UBUNTU_RELEASE == "16.04" ]]; then
    UBUNTU_PATH=ubuntu1604
elif [[ $UBUNTU_RELEASE == "18.04" ]]; then
    UBUNTU_PATH=ubuntu1804
fi

echo "========================="
echo "install on os: "$UBUNTU_RELEASE 
echo "========================="

sudo apt update
sudo apt install \
    net-tools \
    dconf-editor \
    zsh \
    vim \
    vim-gnome \
    xfce4 \
    xfce4-goodies \
    vnc4server \
    openssh-server \
    nmap \
    samba \
    network-manager-openconnect-gnome \
    tmux \
    exuberant-ctags \
    meld \
    doxygen \
    dpkg-dev \
    cmake \
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
    libglu1-mesa-dev \
    libglfw3-dev \
    libgles2-mesa-dev \
    python3 \
    python3-pip \
    cifs-utils \
    libjpeg-dev \

echo "========================="
echo " Install Git and Git LFS "
echo "========================="
sudo apt install git
sudo apt install git-lfs
git lfs install


if [[ $1 == "extra" ]]; then
    sudo apt install \
    python-minimal \
    libcurl4-gnutls-dev \
    libpng-dev

    # Add xenial to /etc/apt/sources.list temporarily
    sudo add-apt-repository "deb http://cn.archive.ubuntu.com/ubuntu/ xenial main"
    sudo add-apt-repository "deb http://cn.archive.ubuntu.com/ubuntu/ xenial universe"
    sudo apt update
    
    sudo apt install pinta #(useful for annotating visual profiles on Linux)
    
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

    #sudo groupadd splendor
    #sudo useradd -m -g splendor ronz
fi

echo " -------------------------------------------------------------------------------------"
echo " + All the work finished! Now reboot"
echo " -------------------------------------------------------------------------------------"
