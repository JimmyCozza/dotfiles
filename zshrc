HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000

setopt HIST_SAVE_NO_DUPS
setopt INC_APPEND_HISTORY

# Configure the push directory stack (most people don't need this)
setopt AUTO_PUSHD
setopt PUSHD_IGNORE_DUPS
setopt PUSHD_SILENT

# Enable prompt substitution
setopt PROMPT_SUBST

# Git prompt functions
git_prompt_info() {
    local branch=$(git symbolic-ref --short HEAD 2>/dev/null)
    if [[ -n $branch ]]; then
        echo " %F{012}($branch$(git_prompt_dirty))%f"
    fi
}

git_prompt_dirty() {
    if [[ -n $(git status --porcelain 2>/dev/null) ]]; then
        echo " %F{133}󰅖%f"
    else
        echo " %F{118}%f"
    fi
}

# Simple prompt with git info
PROMPT='%F{117}%~%f$(git_prompt_info) %F{077}%f '


# Environment Variables
export CONFIG_FILES_PATH=$HOME/dotfiles
export GOPATH=$HOME/go
export EDITOR="nvim"
export VISUAL=nvim
export RIPGREP_CONFIG_PATH="$CONFIG_FILES_PATH/ripgreprc"

# Path Configuration
export PATH=$HOME/.local/bin:$PATH
export PATH=$HOME/bin:$PATH
export PATH=$HOME/.cargo/bin:$PATH
export PATH=$HOME/.config/emacs/bin:$PATH
export PATH=$PATH:/usr/local/go/bin:$GOPATH/bin
export PATH=$PATH:/usr/local/opt/rabbitmq/sbin
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
export PATH=$PATH:/opt/postgresql16/bin
export PATH=$PATH:$HOME/tools/wsome/wsome
export PATH=$PATH:$HOME/.local/share/gem/ruby/3.3.0/bin

# Bun
export BUN_INSTALL="$HOME/.bun"
export PATH=$BUN_INSTALL/bin:$PATH

# PKG_CONFIG_PATH for wlroots
export PKG_CONFIG_PATH=$HOME/.local/lib/pkgconfig:$PKG_CONFIG_PATH

source $CONFIG_FILES_PATH/aliases

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_COMMAND='rg --files --hidden --follow --glob "!.git/*"'

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

eval "$(direnv hook zsh)"

# fnm
eval "$(fnm env --use-on-cd)"
export PATH=$PATH:$HOME/bin

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/home/jimmy/google-cloud-sdk/path.zsh.inc' ]; then . '/home/jimmy/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/home/jimmy/google-cloud-sdk/completion.zsh.inc' ]; then . '/home/jimmy/google-cloud-sdk/completion.zsh.inc'; fi

# eval "$(starship init zsh)"
