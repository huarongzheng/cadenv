#!/bin/bash

print_usage () {
    echo "####################################################################"
    echo "## Usage:  setup_user.sh user_name group_name default_shell"
    echo "####################################################################"
}

if [ $# -lt 3 ]; then
    echo "ERROR: expecting 3 parameters but get only $#"
    print_usage 
    exit 1
else
    USER_NAME=$1
    GROUP_NAME=$2
    SHELL_NAME=$3 # should like /bin/tcsh
fi

#UTILS_CADENV=/proot/workareas/utils

###########  for others  ###########
GROUP_INFO=`getent group | grep $GROUP_NAME | awk -F ":" -v groupname=$GROUP_NAME '{if ($1==groupname) {print $1}}'`
if [[ "$GROUP_INFO" == "" && "$USER_NAME" != "root" ]]; then
    echo "INFO: group $GROUP_NAME doesn't exist, creating one ..."
    groupadd $GROUP_NAME
fi

USER_INFO=`getent passwd | grep $USER_NAME`
if [[ "$USER_INFO" == "" && "$USER_NAME" != "root" ]]; then
    echo "INFO: user $USER_NAME doesn't exist, creating one ..."
    useradd -g $GROUP_NAME -G $GROUP_NAME -s $SHELL_NAME $USER_NAME
fi

if [ "$USER_NAME" != "root" ]; then
    HOME_PATH="/home"
else
    HOME_PATH=
fi

chsh -s $SHELL_NAME $USER_NAME


ln -sf $UTILS_CADENV/settings/.cvsrc    $HOME_PATH/$USER_NAME/.cvsrc
ln -sf $UTILS_CADENV/settings/.vim      $HOME_PATH/$USER_NAME/.vim
ln -sf $UTILS_CADENV/settings/.vimrc    $HOME_PATH/$USER_NAME/.vimrc
ln -sf $UTILS_CADENV/settings/.cshrc    $HOME_PATH/$USER_NAME/.cshrc
ln -sf $UTILS_CADENV/settings/.bashrc   $HOME_PATH/$USER_NAME/.bashrc
ln -sf $UTILS_CADENV/settings/.tcshrc   $HOME_PATH/$USER_NAME/.tcshrc
ln -sf $UTILS_CADENV/settings/.aliasesc $HOME_PATH/$USER_NAME/.aliasesc
ln -sf $UTILS_CADENV/settings/.aliasesb $HOME_PATH/$USER_NAME/.aliasesb

usermod -g $GROUP_NAME $USER_NAME
usermod -G $GROUP_NAME $USER_NAME
chgrp $GROUP_NAME $HOME_PATH/$USER_NAME/.vim
chgrp $GROUP_NAME $HOME_PATH/$USER_NAME/.vimrc
chgrp $GROUP_NAME $HOME_PATH/$USER_NAME/.cshrc
chgrp $GROUP_NAME $HOME_PATH/$USER_NAME/.bashrc
chgrp $GROUP_NAME $HOME_PATH/$USER_NAME/.tcshrc
chgrp $GROUP_NAME $HOME_PATH/$USER_NAME/.aliasesc
chgrp $GROUP_NAME $HOME_PATH/$USER_NAME/.aliasesb

chown $USER_NAME  $HOME_PATH/$USER_NAME/.vim
chown $USER_NAME  $HOME_PATH/$USER_NAME/.vimrc
chown $USER_NAME  $HOME_PATH/$USER_NAME/.cshrc
chown $USER_NAME  $HOME_PATH/$USER_NAME/.bashrc
chown $USER_NAME  $HOME_PATH/$USER_NAME/.tcshrc
chown $USER_NAME  $HOME_PATH/$USER_NAME/.aliasesc
chown $USER_NAME  $HOME_PATH/$USER_NAME/.aliasesb


GROUP_INFO=`getent group | grep $USER_NAME | awk -F ":" '{print $1}'`
if [[ "$GROUP_INFO" == "$USER_NAME" && "$GROUP_INFO" != "root" ]]; then
    echo "INFO: group: $USER_NAME is redundant, deleting ..."
    groupdel $USER_NAME
fi

