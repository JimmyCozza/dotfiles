export CONFIG_FILES_PATH=$HOME/dotfiles
ZSH_DISABLE_COMPFIX=true
export ZSH=~/.oh-my-zsh
export GOPATH=$HOME/go
export PATH=$PATH:/usr/local/go/bin:$GOPATH/bin
export PATH=$PATH:/usr/local/opt/rabbitmq/sbin
export PATH=$HOME/.emacs.d/bin:$PATH
export PATH=$HOME/.cargo/bin:$PATH
export PATH=$HOME/.local/bin:$PATH
export TODO_PATH=$HOME/notes/vimwiki/todo/
export EDITOR="nvim"
export VISUAL=nvim
export RIPGREP_CONFIG_PATH="$CONFIG_FILES_PATH/ripgreprc"

ZSH_THEME="muse"
plugins=(
  #git
  macos
)

source $ZSH/oh-my-zsh.sh
#source $CONFIG_FILES_PATH/growvars
source $CONFIG_FILES_PATH/aliases

#Workflow improvements
bindkey '\C-e' edit-command-line

#Uses bat to print git diff
batdiff() {
    git diff --name-only --diff-filter=d | xargs bat --diff
}

#Uses bat to print man pages
export MANPAGER="sh -c 'col -bx | bat -l man -p'"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_COMMAND='rg --files --hidden --follow --glob "!.git/*"'

# The next line updates PATH for the Google Cloud SDK.
#if [ -f '$HOME/google-cloud-sdk/path.zsh.inc' ]; then source '$HOME/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '$HOME/google-cloud-sdk/completion.zsh.inc' ]; then source '$HOME/google-cloud-sdk/completion.zsh.inc'; fi

gitclone() {
 git clone "$1" && cd "$(basename "$1" .git)" || return
}


export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

#export PATH="/usr/local/opt/awscli@1/bin:$PATH"
eval "$(direnv hook zsh)"

# fnm
export PATH=/home/jimmy/.fnm:$PATH
eval "`fnm env`"
