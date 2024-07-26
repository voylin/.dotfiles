#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

#export SSH_ASKPASS=/dev/null
#eval "$(ssh-agent -s)"
#ssh-add ~/.ssh/conoha-voylins-servers.key


alias ls='ls --color=auto'
alias grep='grep --color=auto'

alias vim='nvim'
alias vvim='nvim .'

alias vimgodot='vvim --listen 127.0.0.1:6004'
alias gozen_vim='cd /storage/programming/GoZen && vim_godot' 
PS1='[\u@\h \W]\$ '

alias tmuxopen='tmux a -t '
alias tmuxnew_session='tmux new-session -s '

alias search='cd "$(find . -mindepth 1 -maxdepth 2 -type d | fzf)"'
alias psearch='cd "$(find /storage/programming -mindepth 1 -maxdepth 2 -type d | fzf)"'
alias ysearch='cd "$(find /storage/Youtube -mindepth 1 -maxdepth 1 -type d | fzf)"'

alias vsearch='cd "$(find . -mindepth 1 -maxdepth 2 -type f | fzf"'

alias dotfiles='/usr/bin/git --git-dir=$HOME/dotfiles --work-tree=$HOME'
