#!/bin/bash

##################################################
############### General Setup ####################
##################################################

# Pre-reqs
ARCH_LIST="alacritty fzf ripgrep tmux firefox bat discord docker docker-compose rofi sxhkd flameshot aws-cli nginx python2 base-devel cmake unzip ninja tree-sitter curl zsh python-pip ruby lazygit"
AUR_LIST="fnm-bin lazydocker nerd-fonts-go-mono nerd-fonts-fira-code zsh-syntax-highlighting-git slack-desktop tableplus tdrop-git awesome-git emacs-git google-chrome playerctl arcolinux-logout"
sudo pacman -Syuv --noconfirm $ARCH_LIST
yay -Syu $AUR_LIST

echo "Setup directories"
mkdir $HOME/work
mkdir $HOME/personal
mkdir $HOME/tools

echo "Downloading manual programs"
# Packer.nvim
git clone --depth 1 https://github.com/wbthomason/packer.nvim\
 ~/.local/share/nvim/site/pack/packer/start/packer.nvim
# oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
# tmux
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
# 1password
curl -sS https://downloads.1password.com/linux/keys/1password.asc | gpg --import
git clone https://aur.archlinux.org/1password.git $HOME/tools/1password
cd $HOME/tools/1password && makepkg -si
# Build Neovim nightly
git clone https://github.com/neovim/neovim $HOME/tools/neovim
cd $HOME/tools/neovim && make
sudo make install
# Doom Emacs
rm -rf $HOME/.emacs.d
git clone --depth 1 https://github.com/hlissner/doom-emacs ~/.emacs.d
~/.emacs.d/bin/doom install
rm -r $HOME/.doom.d
# Pritunl
sudo tee -a /etc/pacman.conf << EOF
[pritunl]
Server = https://repo.pritunl.com/stable/pacman
EOF

sudo pacman-key --keyserver hkp://keyserver.ubuntu.com -r 7568D9BB55FF9E5287D586017AE645C0CF8E292A
sudo pacman-key --lsign-key 7568D9BB55FF9E5287D586017AE645C0CF8E292A
sudo pacman -Sy
sudo pacman -S pritunl-client-electron
sudo pacman -S pritunl-client-electron-numix-theme

##################################################
################# Symlinks #######################
##################################################
mv $HOME/.zshrc $HOME/.zshrc.bak
mv $HOME/.config/autostart $HOME/.config/bak.autostart
echo "symlinking dotfiles"
ln -s "$HOME/dotfiles/zshrc" "$HOME/.zshrc"
source "$HOME/.zshrc"

ln -s "$CONFIG_FILES_PATH/alacritty" "$HOME/.config/alacritty"
ln -s "$CONFIG_FILES_PATH/awesome" "$HOME/.config/awesome"
ln -s "$CONFIG_FILES_PATH/doom" "$HOME/.doom.d"
ln -s "$CONFIG_FILES_PATH/picom" "$HOME/.config/picom"
ln -s "$CONFIG_FILES_PATH/rofi" "$HOME/.config/rofi"
ln -s "$CONFIG_FILES_PATH/sxhkd" "$HOME/.config/sxhkd"
ln -s "$CONFIG_FILES_PATH/autostart" "$HOME/.config/autostart"
ln -s "$CONFIG_FILES_PATH/tmux.conf" "$HOME/.tmux.conf"
ln -s "$CONFIG_FILES_PATH/nvim" "$HOME/.config/nvim"
ln -s "$CONFIG_FILES_PATH/gitconfig" "$HOME/.gitconfig"
ln -s "$CONFIG_FILES_PATH/gitignore_global" "$HOME/.gitignore_global"

source "$HOME/.zshrc"

# FNM/node default
fnm install 12
fnm default 12

# Docker
sudo groupadd docker
sudo usermod -aG docker jimmy
sudo systemctl enable docker.service
sudo systemctl enable containerd.service

##################################################
############### Neovim Setup #####################
##################################################

sudo pip3 install neovim
sudo pip3 install neovim-remote
sudo gem install neovim

chsh -s $(which zsh)
source "$HOME/.zshrc"

# All good
echo "Done"
echo "Start TMUX and run tmux-plugin-manager install"
echo "nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'" #I don't care enough to make this work right now...
echo "Reboot"
