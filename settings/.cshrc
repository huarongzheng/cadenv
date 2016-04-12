set UTILS_PATH=/proot/workareas/utils
# verbose option
if ( $?SOURCE_VERBOSE ) echo "Sourcing $UTILS_PATH/settings/cmn.cshrc"

# get common setting
if ( -r /tools/utils/cadenv/settings/cmn.tcshrc ) source $UTILS_PATH/settings/cmn.tcshrc

# source ~/.cshrclocal
if( -f ~/.cshrclocal ) source ~/.cshrclocal


# If login, open bash
# if ( $?interactivesh && $?loginsh ) then
#   unsetenv MACHTYPE
#   unsetenv HOSTTYPE
#   unsetenv OSTYPE
#   unsetenv VENDOR
#   exec /bin/bash --login
# endif

#umask 0002
#cshrc_exec_bash

#----------------------------
#    prompt & cshell 
#----------------------------
set prompt="%{\033[34m%}%B${shell:t} %n@%m%b %/ (%h)\n%# "
set autolist

#----------------------------
#     aliases
#----------------------------
if( -f $UTILS_PATH/settings/.aliasesc) source $UTILS_PATH/settings/.aliasesc

#----------------------------
#     add tools     
#----------------------------
############### cvs 
setenv CVS_RSH ssh

############### synopsys tools
setenv SYNOPSYS_CCSS        /tools/synopsys/linux/ccss
setenv LM_LICENSE_FILE      /tools/license_pool/synopsys_license.dat
setenv SNPSLMD_LICENSE_FILE /tools/license_pool/synopsys_license.dat
setenv SNPS_ARCH linux

############### vim
#setenv VIMRUNTIME /tools/vim/vim64/share/vim/vim64
#setenv SHLIB_PATH $SHLIB_PATH:$SYNOPSYS_CCSS/lib:$CADENCE_DIR/lib


setenv PATH /proot/workareas/utils/cadenv/0001:/proot/workareas/utils/project_manage/0001:$PATH

#!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
#  example on how to mount nas folder
#  192.168.x.yy is the ip current assigned to u1-nas
#  Using File Browser access: smb://192.168.1.3/BT or smb://nas-cadf9a with the ip alias  (File Browser->Computer->Network->Windows Network->workgroup->nas-cadf9a)

#mount //192.168.1.3/BT /mnt/samba_u1-nas

