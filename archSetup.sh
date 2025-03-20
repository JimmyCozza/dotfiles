#!/bin/bash
echo "Setup directories"
mkdir -p $HOME/Pictures
mkdir -p $HOME/Downloads
mkdir -p $HOME/projects
mkdir -p $HOME/tools

sudo pacman -Syu --needed base-devel
git clone https://aur.archlinux.org/yay.git $HOME/tools/yay
cd $HOME/tools/yay && makepkg -si

ARCH_LIST="ripgrep docker docker-compose cmake unzip ninja tree-sitter curl fish python-pip ruby lazygit direnv wezterm pipewire pipewire-audio brightnessctl thunar thunar-volman gvfs libinput wayland wlroots libxkbcommon wayland-protocols pkgconf bemenu bemenu-wayland firefox"
AUR_LIST="fnm-bin lazydocker xorg-xwayland lua-lgi ttf-go-nerd ttf-jetbrains-mono-nerd zsh-syntax-highlighting-git slack-desktop beekeeper-studio-appimage feh wl-clipboard python2 python-pynvim"

echo "Fetching standard arch packages"
sudo pacman -Syu --noconfirm $ARCH_LIST
echo "Fetching AUR packages"
yay -Syu $AUR_LIST

curl https://raw.githubusercontent.com/oh-my-fish/oh-my-fish/master/bin/install | fish

chsh -s $(which fish)

git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install

git clone https://github.com/neovim/neovim $HOME/tools/neovim
cd $HOME/tools/neovim && make CMAKE_BUILD_TYPE=Release
sudo make install


mv $HOME/.zshrc $HOME/.zshrc.bak

echo "symlinking dotfiles"
ln -s "$HOME/dotfiles/zshrc" "$HOME/.zshrc"
source "$HOME/.zshrc"

ln -s "$CONFIG_FILES_PATH/newvim" "$HOME/.config/nvim"
ln -s "$CONFIG_FILES_PATH/gitconfig" "$HOME/.gitconfig"
ln -s "$CONFIG_FILES_PATH/gitignore_global" "$HOME/.gitignore_global"
ln -s "$CONFIG_FILES_PATH/wezterm" "$HOME/.config/wezterm"

sudo groupadd docker
sudo usermod -aG docker $USER

source "$HOME/.zshrc"

fnm install 20
fnm default 20
sudo systemctl enable docker.service
sudo systemctl enable containerd.service
sudo gem install neovim

source "$HOME/.zshrc"

read -p "Do you want to generate an SSH key for GitHub? (y/n) " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    # Prompt for email address
    read -p "Please enter your email address for the SSH key: " email_address

    echo "Generating SSH key"
    ssh-keygen -t ed25519 -C "$email_address"
    eval "$(ssh-agent -s)"
    ssh-add ~/.ssh/id_ed25519
    echo "Your public SSH key:"
    cat ~/.ssh/id_ed25519.pub
    echo "Please add this key to your GitHub account."
fi

echo "I have exercised the demons.  This house is clean"
echo "Reboot"
