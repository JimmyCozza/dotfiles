if [[ -v ZSH_PROF ]]; then
  # run the following command to use this zsh/zprof stuff
  # "env ZSH_PROF=1 zsh -ic zprof"
  zmodload zsh/zprof
fi

# Environment Variables
export CONFIG_FILES_PATH=$HOME/dotfiles
export GOPATH=$HOME/go
export TODO_PATH=$HOME/notes/vimwiki/todo/
export EDITOR="nvim"
export VISUAL=nvim
export RIPGREP_CONFIG_PATH="$CONFIG_FILES_PATH/ripgreprc"

# Path Configuration
export PATH=$HOME/.local/bin:$PATH
export PATH=$HOME/bin:$PATH
export PATH=$HOME/.cargo/bin:$PATH
export PATH=$HOME/.emacs.d/bin:$PATH
export PATH=$PATH:/usr/local/go/bin:$GOPATH/bin
export PATH=$PATH:$HOME/projects/wsome/wsome
export PATH=$PATH:/usr/local/opt/rabbitmq/sbin
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

# Zsh Options
setopt AUTO_CD              # Change directory without cd
setopt EXTENDED_HISTORY     # Record timestamp of command
setopt HIST_EXPIRE_DUPS_FIRST # Delete duplicates first when HISTFILE size exceeds HISTSIZE
setopt HIST_IGNORE_DUPS     # Ignore duplicated commands history list
setopt HIST_IGNORE_SPACE    # Ignore commands that start with space
setopt HIST_VERIFY          # Show command with history expansion before running it
setopt SHARE_HISTORY        # Share command history data
setopt APPEND_HISTORY       # Append history to the history file
setopt INC_APPEND_HISTORY   # Write to the history file immediately
setopt CORRECT              # Auto correct mistakes
setopt EXTENDED_GLOB        # Extended globbing
setopt MENU_COMPLETE        # Autoselect the first completion entry
setopt AUTO_LIST            # Automatically list choices on ambiguous completion
setopt COMPLETE_IN_WORD     # Complete from both ends of a word
setopt ALWAYS_TO_END        # Move cursor to the end of a completed word

# History Configuration
HISTFILE=~/.zsh_history
HISTSIZE=50000
SAVEHIST=50000

# Enable modern completion system
autoload -Uz compinit
compinit

# Completion styling
zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

# Git completion and prompt functions
autoload -Uz vcs_info
precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )
setopt prompt_subst
zstyle ':vcs_info:git:*' formats ' %F{240}(%b)%f'
zstyle ':vcs_info:*' enable git

# Custom prompt
PROMPT='%F{cyan}%n%f@%F{blue}%m%f %F{yellow}%~%f${vcs_info_msg_0_} %F{green}❯%f '

# Key bindings
autoload -U edit-command-line
zle -N edit-command-line
bindkey '\C-e' edit-command-line
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
bindkey '^[[1;5C' forward-word
bindkey '^[[1;5D' backward-word

# History substring search
autoload -U history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^[[A" history-beginning-search-backward-end
bindkey "^[[B" history-beginning-search-forward-end

source $CONFIG_FILES_PATH/aliases

#Uses bat to print git diff
# batdiff() {
#     git diff --name-only --diff-filter=d | xargs bat --diff
# }

#Uses bat to print man pages
# export MANPAGER="sh -c 'col -bx | bat -l man -p'"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_COMMAND='rg --files --hidden --follow --glob "!.git/*"'

gitclone() {
 git clone "$1" && cd "$(basename "$1" .git)" || return
}

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

eval "$(direnv hook zsh)"

# fnm
eval "$(fnm env --use-on-cd)"
export PATH=$PATH:$HOME/bin

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/home/jimmy/google-cloud-sdk/path.zsh.inc' ]; then . '/home/jimmy/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/home/jimmy/google-cloud-sdk/completion.zsh.inc' ]; then . '/home/jimmy/google-cloud-sdk/completion.zsh.inc'; fi
