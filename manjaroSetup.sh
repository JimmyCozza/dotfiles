#!/bin/bash

##################################################
################# Symlinks #######################
##################################################
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
mv $HOME/.zshrc $HOME/.zshrc.bak
echo "symlinking dotfiles"
ln -s "$HOME/dotfiles/zshrc" "$HOME/.zshrc"
source "$HOME/.zshrc"
ln -s "$CONFIG_FILES_PATH/alacritty.yml" "$HOME/.alacritty.yml"
ln -s "$CONFIG_FILES_PATH/tmux.conf" "$HOME/.tmux.conf"
ln -s "$CONFIG_FILES_PATH/nvim" "$HOME/.config/nvim"
ln -s "$CONFIG_FILES_PATH/gitconfig" "$HOME/.gitconfig"
ln -s "$CONFIG_FILES_PATH/gitignore_global" "$HOME/.gitignore_global"

##################################################
################## Pacman ########################
##################################################

sudo pacman -Syu --noconfirm alacritty fzf ripgrep tmux
source "$HOME/.zshrc"
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

##################################################
############### AUR Packages #####################
##################################################

pamac install neovim-nightly-bin fnm-bin lazygit-bin lazydocker nerd-fonts-go-mono zsh-syntax-highlighting-git

##################################################
################## Neovim ########################
##################################################

curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
source "$HOME/.zshrc"
sudo pip3 install neovim
sudo pip3 install neovim-remote
sudo gem install neovim
nvim --headless +PlugInstall +qa
nvim --headless +UpdateRemotePlugins +qa

chsh -s $(which zsh)
source "$HOME/.zshrc"

echo "Boom"
