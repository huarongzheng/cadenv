# verbose option
if [ "$SOURCE_VERBOSE" != "" ]; then
    echo "Info: Sourcing $HOME/.bashrc"
fi

# source ~/.cshrclocal
if [ -f ~/.bashrclocal ];then
    source ~/.bashrclocal
fi

#----------------------------
#         Prompt & bashell 
#----------------------------
prompt_command () {

  if [ ${#PWD} -le 1000 ]; then
    local CWD=$PWD
  else
    if [ "$OSTYPE" = "solaris2.9" ]; then
      local CWD="...`echo -n $PWD | tail -37c`"
    else
      local CWD="...`echo -n $PWD | tail -c37`"
    fi
  fi

  if [ "$PROJECT" != "" ]; then
    local PRJ=":$PROJECT"
  else
    local PRJ=""
  fi

  if [ -z "${TERM##*xterm*}" ]; then
    if [ "$TITLE" != "" ]; then
      echo -n -e "\033]2;$TITLE\007"
      echo -n -e "\033]1;$TITLE\007"
    else
      echo -n -e "\033]2;${SHELL##*/} $USER@${HOSTNAME%%.${DOMAINNAME}} $CWD\007"
      echo -n -e "\033]1;${SHELL##*/} $USER@${HOSTNAME%%.${DOMAINNAME}} \007"
    fi
#   PS1="\033[1m${SHELL##*/} $USER$PRJ@${HOSTNAME%%.${DOMAINNAME}}\033[m $CWD (\!)\n\\\$ "
    PS1="\[\e[${AUTO_PROMPT_COLOR_SHELL:-0};1m\]${SHELL##*/} \[\e[${AUTO_PROMPT_COLOR_USER:-0};1m\]$USER$PRJ@${HOSTNAME%%.${DOMAINNAME}} \[\e[0m\e[${AUTO_PROMPT_COLOR_PATH:-0}m\]$CWD \[\e[${AUTO_PROMPT_COLOR_COUNT:-0}m\](\!)\[\e[${AUTO_PROMPT_COLOR_DOLLAR:-0}m\]\n\\\$\[\e[0m\] "
  else
    PS1="${SHELL##*/} $USER$PRJ@${HOSTNAME%%.${DOMAINNAME}} $CWD (\!)\n\\\$ "
  fi
   
  if [ -O $HOME/.message ]; then
    echo -e "\033[1m### MESSAGES FROM SYSTEM\033[m" > /dev/null 1>&2
    cat $HOME/.message > /dev/null 1>&2
    cat $HOME/.message >> $HOME/.message.log
    rm $HOME/.message
  fi

}

PROMPT_COMMAND="prompt_command"
#export DISPLAY COLOR TERM
export AUTO_PROMPT_COLOR_SHELL=34
export AUTO_PROMPT_COLOR_USER=34
export AUTO_PROMPT_COLOR_PATH=35
export AUTO_PROMPT_COLOR_COUNT=35
export AUTO_PROMPT_COLOR_DOLLAR=35

set autolist


#----------------------------
#        aliases
#----------------------------
if [ "$BASH_VERSION" != "" ]; then
    ##### aliases 
    if [ -f ~/.aliasesb  ]; then
        source ~/.aliasesb
    fi
    ##### Completions newer bashes
	if [ ${BASH_VERSINFO[1]%%[a-z]} -gt 3 ]; then
		LIST=`ypcat hosts | /bin/sed -e 's/^[0-9.]*[^a-z]*\([a-z]*\)\..*$/\1/' | tr '\012' ' '`
		complete -W "$LIST" rlogin rsh
        FIGNORE=CVS
	fi
fi

#----------------------------
#     load tools     
#----------------------------
#eval `tclsh /home/utils/modules/tcl/modulecmd.tcl sh autoinit`
#module load promanage
#module load cadenv
#module load ccss
#module load vim
#module load tkcvs
#module load genmake/2.1
#module load build_drxmap/1.10
#module load eclipse/indigo-SR1


################ cvs
export CVSROOT=:local:/proot/.repository
export EDITOR=vim
export CVS_RSH=ssh

#export DISPLAY=$HOSTNAME:0.0
#export mdd_env_version=1.1
#export AUTO_MSD_VERSION=1.28.2
#export AUTO_UMASK=0002

#mount -o shortname=mixed //192.168.1.3/public /mnt/samba_u1-nas

