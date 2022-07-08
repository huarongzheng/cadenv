#!/bin/bash

print_usage () {
    echo "####################################################################"
    echo "## Usage:  setup_user.sh user_name group_name"
    echo "####################################################################"
}

if [ $# -lt 2 ]; then
    echo "ERROR: expecting 3 parameters but get only $#"
    print_usage 
    exit 1
else
    USER_NAME=$1
    GROUP_NAME=$2
fi

SHELL_NAME=/usr/bin/zsh
UTILS_CADENV=/home/tools/proot

###########  for others  ###########
GROUP_INFO=`getent group | grep "^$GROUP_NAME:"`
if [[ "$GROUP_INFO" == "" ]]; then
    echo "INFO: group $GROUP_NAME doesn't exist, creating one ..."
    groupadd $GROUP_NAME
else
    echo "INFO: exist $GROUP_INFO"
fi

USER_INFO=`getent passwd | grep "^$USER_NAME:"`
if [[ "$USER_INFO" == "" ]]; then
    echo "INFO: user $USER_NAME doesn't exist, creating one ..."
    useradd -g $GROUP_NAME -s $SHELL_NAME -m $USER_NAME
    groups $USER_NAME # show which group for this user
    #chsh -s $SHELL_NAME $USER_NAME
else
    #usermod -a -G $GROUP_NAME $USER_NAME # add user to the group
    echo "INFO: exist $USER_INFO"
fi

if [ "$USER_NAME" != "root" ]; then
    HOME_PATH="/home"
else
    HOME_PATH="/"
fi

ln -sf $UTILS_CADENV/ohmyzsh                    $HOME_PATH/$USER_NAME/ohmyzsh
ln -sf $UTILS_CADENV/cadenv/settings/.aliasesb  $HOME_PATH/$USER_NAME/.aliasesb
ln -sf $UTILS_CADENV/cadenv/settings/.gitconfig $HOME_PATH/$USER_NAME/.gitconfig 
ln -sf $UTILS_CADENV/cadenv/settings/.localrc   $HOME_PATH/$USER_NAME/.localrc
ln -sf $UTILS_CADENV/cadenv/settings/.zshrc     $HOME_PATH/$USER_NAME/.zshrc
ln -sf $UTILS_CADENV/cadenv/settings/.vim       $HOME_PATH/$USER_NAME/.vim
ln -sf $UTILS_CADENV/cadenv/settings/.vimrc     $HOME_PATH/$USER_NAME/.vimrc

