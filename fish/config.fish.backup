export CONFIG_FILES_PATH=$HOME/dotfiles
if status is-interactive
    # Commands to run in interactive sessions can go here
end

source $CONFIG_FILES_PATH/aliases
set fish_greeting ""

set -x GOPATH (go env GOPATH)
set -x PATH $PATH (go env GOPATH)/bin

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/jimmy/Downloads/google-cloud-sdk/path.fish.inc' ]; . '/Users/jimmy/Downloads/google-cloud-sdk/path.fish.inc'; end
