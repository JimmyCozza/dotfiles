#!/bin/bash
#########################################################
#########################################################
# THIS WAS AUTO GENERATED VIA ORG-BABEL-TANGLE
# CHECK THE archSetup.org FILE FOR MORE DETAILS
#########################################################
#########################################################
echo "Setup directories"
mkdir -p $HOME/Pictures
mkdir -p $HOME/Downloads
mkdir -p $HOME/work
mkdir -p $HOME/projects
mkdir -p $HOME/tools

sudo pacman -Syu --needed base-devel
git clone https://aur.archlinux.org/yay.git $HOME/tools/yay
cd $HOME/tools/yay && makepkg -si

ARCH_LIST="ripgrep bat discord docker docker-compose rofi flameshot aws-cli nginx base-devel cmake unzip ninja tree-sitter curl zsh python-pip ruby lazygit picom direnv emacs lightdm lua-lgi wezterm imagemagick qemu-full lightdm-gtk-greeter pulseaudio pamixer brightnessctl"

AUR_LIST="fnm-bin lazydocker nerd-fonts-complete zsh-syntax-highlighting-git slack-desktop beekeeper-studio-appimage tdrop-git feh xclip python2"

echo "Fetching standard arch packages"
sudo pacman -Syu --noconfirm $ARCH_LIST
echo "Fetching AUR packages"
yay -Syu $AUR_LIST

git clone --depth 1 https://github.com/wbthomason/packer.nvim\
 ~/.local/share/nvim/site/pack/packer/start/packer.nvim

sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

yay -R grml-zsh-config

curl -sS https://downloads.1password.com/linux/keys/1password.asc | gpg --import
git clone https://aur.archlinux.org/1password.git $HOME/tools/1password
cd $HOME/tools/1password && makepkg -si

git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install

git clone https://github.com/JimmyCozza/awe.git $HOME/awe
git clone https://github.com/BlingCorp/bling.git $HOME/tools/bling
git clone https://github.com/andOrlando/rubato.git $HOME/tools/rubato

git clone https://github.com/JimmyCozza/awesome.git $HOME/tools/awesome
cd $HOME/tools/awesome && make && sudo make install
sudo mkdir /usr/share/xsessions && sudo cp $HOME/tools/awesome/awesome.desktop /usr/share/xsessions
sudo systemctl enable lightdm.service

git clone https://github.com/neovim/neovim $HOME/tools/neovim
cd $HOME/tools/neovim && make CMAKE_BUILD_TYPE=Release
sudo make install

 rm -rf $HOME/.emacs.d
 git clone --depth 1 https://github.com/hlissner/doom-emacs ~/.emacs.d
 ~/.emacs.d/bin/doom install
 rm -r $HOME/.doom.d

mv $HOME/.zshrc $HOME/.zshrc.bak
mv $HOME/.config/autostart $HOME/.config/bak.autostart

echo "symlinking dotfiles"
ln -s "$HOME/dotfiles/zshrc" "$HOME/.zshrc"
source "$HOME/.zshrc"

ln -s "$HOME/awe" "$HOME/.config/awesome"
ln -s "$CONFIG_FILES_PATH/doom" "$HOME/.doom.d"
ln -s "$CONFIG_FILES_PATH/picom" "$HOME/.config/picom"
ln -s "$CONFIG_FILES_PATH/rofi" "$HOME/.config/rofi"
ln -s "$CONFIG_FILES_PATH/autostart" "$HOME/.config/autostart"
ln -s "$CONFIG_FILES_PATH/nvim" "$HOME/.config/nvim"
ln -s "$CONFIG_FILES_PATH/gitconfig" "$HOME/.gitconfig"
ln -s "$CONFIG_FILES_PATH/gitignore_global" "$HOME/.gitignore_global"
ln -s "$CONFIG_FILES_PATH/wezterm" "$HOME/.config/wezterm"
ln -s "$HOME/tools/bling" "$HOME/awe/modules/bling"
ln -s "$HOME/tools/rubato" "$HOME/awe/modules/rubato"

sudo groupadd docker
sudo usermod -aG docker $USER

source "$HOME/.zshrc"

fnm install 14
fnm default 14
sudo systemctl enable docker.service
sudo systemctl enable containerd.service
sudo pip3 install neovim
sudo pip3 install neovim-remote
sudo gem install neovim

chsh -s $(which zsh)
source "$HOME/.zshrc"
xdg-mime default google-chrome-unstable.desktop x-scheme-handler/https x-scheme-handler/http

echo "I have exercised the demons.  This house is clean"
echo "nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'" #I don't care enough to make this work right now...
echo "Reboot"
echo "install emacs-git sometime, but do it when the system is up and running because that takes as long as the rest of this install combined."
