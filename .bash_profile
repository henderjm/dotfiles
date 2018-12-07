#!/usr/bin/env bash
#!/usr/bin/env bash
set +x
brew_prefix=$(brew --prefix)

## Environment Variables
export HISTCONTROL=ignoreboth:erasedups

export PATH="${HOME}/go/bin:${PATH}"
export PATH="${HOME}/.local/bin:${PATH}"
RUST_SRC_PATH="$(rustc --print sysroot)/lib/rustlib/src/rust/src/:${PATH}"
export RUST_SRC_PATH
export CLICOLOR=2

## Aliases

if [ -f ~/.bash_aliases ]; then
    # shellcheck source=/dev/null
  source "${HOME}/.bash_aliases"
fi

## BASH Completion
# Lock and Load a custom theme file
# location /.bash_it/themes/
export BASH_IT_THEME='bobby'
source "${brew_prefix}/etc/bash_completion"

# Load Bash It
source "$BASH_IT"/bash_it.sh

# (Advanced): Change this to the name of your remote repo if you
# cloned bash-it with a remote other than origin such as `bash-it`.
# export BASH_IT_REMOTE='bash-it'

# Your place for hosting Git repos. I use this for private repos.
export GIT_HOSTING='git@git.domain.com'

## Aliases + Autocompletion
__git_complete gti __git_main
complete -o default -o nospace -F __start_kubectl kbuectl
complete -o default -o nospace -F __start_kubectl k

## GIT Prompt

if [ -f "${brew_prefix}/opt/bash-git-prompt/share/gitprompt.sh" ]; then
# shellcheck disable=SC2034
__GIT_PROMPT_DIR="${brew_prefix}/opt/bash-git-prompt/share"

# shellcheck source=/dev/null
source "${brew_prefix}/opt/bash-git-prompt/share/gitprompt.sh"
fi

## AutoJump and FASD

[ -f /usr/local/etc/profile.d/autojump.sh ] && . /usr/local/etc/profile.d/autojump.sh

eval "$(fasd --init auto)"

## Direnv

eval "$(direnv hook bash)"

alias vim=nvim
alias vi=nvim

test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/henderjm/google-cloud-sdk/path.bash.inc' ]; then . '/Users/henderjm/google-cloud-sdk/path.bash.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/henderjm/google-cloud-sdk/completion.bash.inc' ]; then . '/Users/henderjm/google-cloud-sdk/completion.bash.inc'; fi

# Path to the bash it configuration
export BASH_IT="/Users/henderjm/.bash_it"

# Lock and Load a custom theme file.
# Leave empty to disable theming.
# location /.bash_it/themes/
export BASH_IT_THEME='bobby'

# (Advanced): Change this to the name of your remote repo if you
# cloned bash-it with a remote other than origin such as `bash-it`.
# export BASH_IT_REMOTE='bash-it'

# Your place for hosting Git repos. I use this for private repos.
export GIT_HOSTING='git@git.domain.com'

# Don't check mail when opening terminal.
unset MAILCHECK

# Change this to your console based IRC client of choice.
export IRC_CLIENT='irssi'

# Set this to the command you use for todo.txt-cli
export TODO="t"

# Set this to false to turn off version control status checking within the prompt for all themes
export SCM_CHECK=true

# Set Xterm/screen/Tmux title with only a short hostname.
# Uncomment this (or set SHORT_HOSTNAME to something else),
# Will otherwise fall back on $HOSTNAME.
#export SHORT_HOSTNAME=$(hostname -s)

# Set Xterm/screen/Tmux title with only a short username.
# Uncomment this (or set SHORT_USER to something else),
# Will otherwise fall back on $USER.
#export SHORT_USER=${USER:0:8}

# Set Xterm/screen/Tmux title with shortened command and directory.
# Uncomment this to set.
#export SHORT_TERM_LINE=true

# Set vcprompt executable path for scm advance info in prompt (demula theme)
# https://github.com/djl/vcprompt
#export VCPROMPT_EXECUTABLE=~/.vcprompt/bin/vcprompt

# (Advanced): Uncomment this to make Bash-it reload itself automatically
# after enabling or disabling aliases, plugins, and completions.
# export BASH_IT_AUTOMATIC_RELOAD_AFTER_CONFIG_CHANGE=1

# Uncomment this to make Bash-it create alias reload.
# export BASH_IT_RELOAD_LEGACY=1

# Load Bash It
source "$BASH_IT"/bash_it.sh
