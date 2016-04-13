#!/bin/bash

if [ "$1" != "" ]; then
    install_path=$1
else
    install_path="~"
fi

#mkdir /wine
#mount -t vfat /dev/sda6 /wine
#cp -r /wine/tools/lin_software/install $install_path
#cp -r /wine/tools/Drivers/realtek_8111c_linux64_driver $install_path/install
#cp -r /wine/tools/Drivers/ati-driver-installer-10-6-x86.x86_64 $install_path/install

if (test -e "/tools") then
    echo "existing folder /tools"
else
    mkdir /tools
fi

#####################################
#####   software installation   #####
#####################################
cp -r $install_path/install/modules /tools/modules
cd /tools/modules/tcl
make clean
make

cd $install_path/install/cvs
unzip tkcvs_8_2.zip
cd $install_path/install/cvs/tkcvs_8_2
chmod +x ./doinstall.tcl
./doinstall.tcl -nox /tools/tkcvs/tkcvs_8_2

cd $install_path/install/vim
tar -jxvf vim-7.2.tar.bz2
cd $install_path/install/vim/vim72
./configure --prefix=/tools/vim/vim72
make install
#ln -sf /tools/vim/vim72/bin/vim /usr/local/bin/vim

cd $install_path/install/ccss
tar -xvf css_vV-2003.12_common.tar 
tar -xvf css_vV-2003.12_linux.tar 
cp $install_path/install/ccss/synopsys_license.dat /tools/synopsys/ccss/admin/license
./install.now
./install_wrap.sh
#ln -sf /tools/synopsys/linux/ccss/bin/ccss /usr/local/bin/ccss


#####################################
########   user settings   ##########
#####################################
eval `tclsh /tools/modules/tcl/modulecmd.tcl sh autoinit`
module load cadenv
module load promanage

$UTILS_CADENV/settings/auto.m*     /etc/       #automount list
$UTILS_CADENV/settings/custom.conf /etc/gdm/   #gdm configuration; also could be configured with /usr/sbin/gdmsetup

groupadd vedacom
setup_user.sh root   root    /bin/bash
setup_user.sh herman vedacom /bin/bash



#####################################
########       genmake     ##########
#####################################
cp -r /proot/workareas/utils/genmake/users/herman/units/top/source/ /tools/genmake
cd /tools/genmake/msc_source

