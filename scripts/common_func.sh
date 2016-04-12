#!/bin/bash

#----------------------------
#      enter projects
#----------------------------
enter_proj () {
    if [ "$1" == "" ]; then
      project_name="ip_drx_ucode"
    else
      project_name=$1
    fi
    
    if [ "$2" == "" ]; then
      serial_num="0001"
    else
      serial_num=$2
    fi
    
    cd /cygdrive/e/proot/$project_name/$serial_num/workareas/zhenghr
}

#----------------------------
#         create ctags
#----------------------------
ctg () {
    ctags -R -f ~/.tags
}

#----------------------------
#      recursively remove
#----------------------------
rm_rcs () {
    paths=$(find -name $1)

    if [[ $2 == "-log" ]]; then
        if [[ ! -z $3 ]]; then
            echo "deleting $paths" > $3
        fi
    fi

    for arg in $paths
    do
        rm -rf $arg
    done
}

#-------------------------------------------------------------
#       Set The DISPLAY automatically
#-------------------------------------------------------------
#S_TTY=$(who am i | awk ' { print $2; } ')
#S_IP=$(last -i $S_TTY -n1 | head -1 | awk ' { print $3; } ')
#if [ -n "$S_IP" ]; then
#   DISPLAY="$S_IP":0.0
#   export DISPLAY
#fi 

# verbose option
if [ "$SOURCE_VERBOSE" != "" ]; then
    echo "Info: Sourcing $UTILS_CADENV/common_function"
fi


print_info () {
    echo "Info: $*"
}

print_warning () {
    echo "Warning: $*"
}

print_error () {
    echo "Error: $*"
}


