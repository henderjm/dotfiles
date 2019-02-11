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

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/henderjm/google-cloud-sdk/path.bash.inc' ]; then . '/Users/henderjm/google-cloud-sdk/path.bash.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/henderjm/google-cloud-sdk/completion.bash.inc' ]; then . '/Users/henderjm/google-cloud-sdk/completion.bash.inc'; fi
