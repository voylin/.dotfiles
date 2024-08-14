#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

#export SSH_ASKPASS=/dev/null
#eval "$(ssh-agent -s)"
#ssh-add ~/.ssh/conoha-voylins-servers.key

git_branch() {
	git rev-parse --abbrev-ref HEAD 2> /dev/null
}

git_repo() {
	git config --get remote.origin.url | rev | cut -d/ -f1 | rev | cut -d. -f1
}

PS1() {
  local git_branch=$(git_branch)
  if [ -n "$git_branch" ]; then
	  local git_repo=$(git_repo)
	  PS1='(\[\033[01;32m\]'"$git_repo"'-'"$git_branch"'\[\033[00m\])[\u@\h \W]\$ '
  else
    PS1='[\u@\h \W]\$ '
  fi
}

PROMPT_COMMAND='PS1'

#PS1='[\u@\h \W]\$ '

alias ls='ls --color=auto'
alias grep='grep --color=auto'

alias vim='nvim'
alias vvim='nvim .'

alias vimgodot='vvim --listen 127.0.0.1:6004'
alias gozen_vim='cd /storage/programming/GoZen && vim_godot' 

alias tmuxopen='tmux a -t '
alias tmuxnew_session='tmux new-session -s '

alias search='cd "$(find . -mindepth 1 -maxdepth 2 -type d | fzf)"'
alias psearch='cd "$(find /storage/programming -mindepth 1 -maxdepth 2 -type d | fzf)"'
alias ysearch='cd "$(find /storage/Youtube -mindepth 1 -maxdepth 1 -type d | fzf)"'

alias vsearch='cd "$(find . -mindepth 1 -maxdepth 2 -type f | fzf"'

alias dotfiles='/usr/bin/git --git-dir=$HOME/dotfiles --work-tree=$HOME'
