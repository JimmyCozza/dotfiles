#!/bin/bash

##################################################
############### General Setup ####################
##################################################
echo "Setup directories"
mkdir $HOME/work
mkdir $HOME/personal
mkdir $HOME/tools


echo "Downloading manual programs"
curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
curl -sS https://downloads.1password.com/linux/keys/1password.asc | gpg --import
git clone https://aur.archlinux.org/1password.git $HOME/tools/1password
cd $HOME/tools/1password
makepkg -si
ch $HOME/dotfiles

##################################################
################# Symlinks #######################
##################################################
mv $HOME/.zshrc $HOME/.zshrc.bak
echo "symlinking dotfiles"
ln -s "$HOME/dotfiles/zshrc" "$HOME/.zshrc"

source "$HOME/.zshrc"

ln -s "$CONFIG_FILES_PATH/alacritty.yml" "$HOME/.alacritty.yml"
ln -s "$CONFIG_FILES_PATH/polybar" "$HOME/.config/polybar"
ln -s "$CONFIG_FILES_PATH/rofi" "$HOME/.config/rofi"
ln -s "$CONFIG_FILES_PATH/sxhkd" "$HOME/.config/sxhkd"
ln -s "$CONFIG_FILES_PATH/autostart/sxhkd.desktop" "$HOME/.config/sxhkd/sxhkd.desktop"
ln -s "$CONFIG_FILES_PATH/tmux.conf" "$HOME/.tmux.conf"
ln -s "$CONFIG_FILES_PATH/nvim" "$HOME/.config/nvim"
ln -s "$CONFIG_FILES_PATH/gitconfig" "$HOME/.gitconfig"
ln -s "$CONFIG_FILES_PATH/gitignore_global" "$HOME/.gitignore_global"

##################################################
################## Pacman ########################
##################################################

sudo pacman -Syuv --noconfirm awesome alacritty fzf ripgrep tmux firefox bat discord docker docker-compose rofi polybar sxhkd flameshot emacs aws-cli nginx python2
source "$HOME/.zshrc"

##################################################
############### AUR Packages #####################
##################################################

pamac install neovim-nightly-bin fnm-bin lazygit-bin lazydocker nerd-fonts-go-mono nerd-fonts-fira-code zsh-syntax-highlighting-git slack-desktop tableplus tdrop-git

# Some things
fnm install 14
fnm default 14
sudo groupadd docker
sudo usermod -aG docker jimmy
sudo systemctl enable docker.service
sudo systemctl enable containerd.service

##################################################
################## Neovim ########################
##################################################

source "$HOME/.zshrc"
sudo pip3 install neovim
sudo pip3 install neovim-remote
sudo gem install neovim
nvim --headless +PlugInstall +qa
nvim --headless +UpdateRemotePlugins +qa

chsh -s $(which zsh)
source "$HOME/.zshrc"

echo "Done"
echo "Start TMUX and run tmux-plugin-manager install"
echo "Reboot"
