#----------------------------
#         Prompt & bashell 
#----------------------------
PS1='[${debian_chroot:+($debian_chroot)}\[\033[01;35m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]]
% '
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

