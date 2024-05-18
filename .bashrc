#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias vim='nvim'
alias vim_godot='vim . --listen 127.0.0.1'
alias gozen_vim='cd /storage/programming/GoZen && vim_godot' 

PS1='[\u@\h \W]\$ '
