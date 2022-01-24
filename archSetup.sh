#!/bin/bash
#########################################################
#########################################################
# THIS WAS AUTO GENERATED VIA ORG-BABEL-TANGLE
# CHECK THE archSetup.org FILE FOR MORE DETAILS
#########################################################
#########################################################
echo "Setup directories"
mkdir $HOME/work
mkdir $HOME/projects
mkdir $HOME/tools

ARCH_LIST="alacritty fzf ripgrep tmux firefox bat discord docker docker-compose rofi sxhkd flameshot aws-cli nginx python2 base-devel cmake unzip ninja tree-sitter curl zsh python-pip ruby lazygit"

AUR_LIST="fnm-bin lazydocker nerd-fonts-complete zsh-syntax-highlighting-git slack-desktop tableplus tdrop-git awesome-git emacs-git google-chrome-dev playerctl arcolinux-logout"

echo "Fetching standard arch packages"
sudo pacman -Syu --noconfirm $ARCH_LIST
echo "Fetching AUR packages"
yay -Syu $AUR_LIST

git clone --depth 1 https://github.com/wbthomason/packer.nvim\
 ~/.local/share/nvim/site/pack/packer/start/packer.nvim

sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

curl -sS https://downloads.1password.com/linux/keys/1password.asc | gpg --import
git clone https://aur.archlinux.org/1password.git $HOME/tools/1password
cd $HOME/tools/1password && makepkg -si

git clone https://github.com/neovim/neovim $HOME/tools/neovim
cd $HOME/tools/neovim && make
sudo make install

rm -rf $HOME/.emacs.d
git clone --depth 1 https://github.com/hlissner/doom-emacs ~/.emacs.d
~/.emacs.d/bin/doom install
rm -r $HOME/.doom.d

sudo tee -a /etc/pacman.conf << EOF
[pritunl]
Server = https://repo.pritunl.com/stable/pacman
EOF

sudo pacman-key --keyserver hkp://keyserver.ubuntu.com -r 7568D9BB55FF9E5287D586017AE645C0CF8E292A
sudo pacman-key --lsign-key 7568D9BB55FF9E5287D586017AE645C0CF8E292A
sudo pacman -Sy
sudo pacman -S pritunl-client-electron
sudo pacman -S pritunl-client-electron-numix-theme

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

fnm install 12
fnm default 12

sudo pip3 install neovim
sudo pip3 install neovim-remote
sudo gem install neovim

chsh -s $(which zsh)
source "$HOME/.zshrc"

echo "I have exercised the demons.  This house is clean"
echo "Start TMUX and run tmux-plugin-manager install"
echo "nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'" #I don't care enough to make this work right now...
echo "Reboot"
