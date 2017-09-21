#!/usr/bin/env bash

export BASH_IT="${HOME}/.bash_it"
export BASH_IT_THEME='bobby'
export SCM_CHECK=true
unset MAILCHECK
export SCM_CHECK=true
source "$BASH_IT/bash_it.sh"

export EDITOR=vim
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

export GIT_DUET_GLOBAL=true
export GIT_DUET_ROTATE_AUTHOR=1
export LPASS_AGENT_TIMEOUT=$((9 * 3600))
export VM_MEMORY=$((10 * 1024))

# Ruby

# Go
export GOPATH=~/go
export PATH=$GOPATH/bin:$PATH

export PATH="${HOME}/.local/bin:${PATH}"
export PATH="${HOME}/bin:${PATH}"
export PATH="${HOME}/.local/bin:${PATH}"

alias z='fasd_cd -d'
alias gsu='git submodule update --init --recursive'

eval "$(direnv hook bash)"
export PATH="/usr/local/opt/qt@5.5/bin:$PATH"

# Enable tab completion for custom commands
source "${HOME}/bin/_go_jump.bash"
source "${HOME}/bin/_autocomplete_cmds.bash"
