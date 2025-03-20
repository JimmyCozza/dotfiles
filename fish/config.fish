if status is-interactive
    # Commands to run in interactive sessions can go here
end

# Fish shell configuration

# Set the path to your dotfiles
set -gx CONFIG_FILES_PATH $HOME/dotfiles

# Set the path to your Go workspace
set -gx GOPATH $HOME/go

# Set up PATH
set -gx PATH $PATH /usr/local/go/bin $GOPATH/bin
set -gx PATH $PATH $HOME/tools/wsome/wsome
set -gx PATH $PATH /usr/local/opt/rabbitmq/sbin
set -gx PATH $HOME/.config/emacs/bin $PATH
set -gx PATH $HOME/.cargo/bin $PATH
set -gx PATH $HOME/.local/bin $PATH

# Set the path to your todo file
set -gx TODO_PATH $HOME/notes/vimwiki/todo/

# Set the default editor
set -gx EDITOR "nvim"
set -gx VISUAL "nvim"

# Set the path to your ripgrep configuration
set -gx RIPGREP_CONFIG_PATH "$CONFIG_FILES_PATH/ripgreprc"

# Source aliases file
source $CONFIG_FILES_PATH/aliases

# Workflow improvements
function fish_user_key_bindings
    bind \ce edit_command_buffer
end

# Set up fzf
set -gx FZF_DEFAULT_COMMAND 'rg --files --hidden --follow --glob "!.git/*"'

# Use .env from dotfiles
if test -f ~/dotfiles/.env
    load_dotenv
end
# Git clone function
function gitclone
    git clone $argv[1]
    and cd (basename $argv[1] .git)
end

# Set up yarn path
set -gx PATH $HOME/.yarn/bin $HOME/.config/yarn/global/node_modules/.bin $PATH

# Set up direnv
direnv hook fish | source

# Set up fnm
fnm env --use-on-cd | source

# Add custom bin directory to PATH
set -gx PATH $PATH $HOME/bin

# Set up Google Cloud SDK
if test -f '/home/jimmy/google-cloud-sdk/path.fish.inc'
    source '/home/jimmy/google-cloud-sdk/path.fish.inc'
end

if test -f '/home/jimmy/google-cloud-sdk/completion.fish.inc'
    source '/home/jimmy/google-cloud-sdk/completion.fish.inc'
end

set -gx NPM_TOKEN (cat ~/.npmrc | grep _authToken | cut -d'=' -f2)

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/home/jimmy/Downloads/google-cloud-sdk/path.fish.inc' ]; . '/home/jimmy/Downloads/google-cloud-sdk/path.fish.inc'; end

# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH
