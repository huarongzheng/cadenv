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

set autocorrect
set autolist
set autoexpand
set complete
set color


if [ -f ~/.localrc ];then
    source ~/.localrc
fi

