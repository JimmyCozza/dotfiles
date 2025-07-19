#!/bin/bash

# Exit immediately if a command exits with a non-zero status.
set -e

echo "Setup directories"
mkdir -p "$HOME/Pictures"
mkdir -p "$HOME/Downloads"
mkdir -p "$HOME/projects"
mkdir -p "$HOME/tools"

echo "Updating system and installing base-devel and linux-firmware"
# Ensure linux-firmware is installed, and system is up-to-date
sudo pacman -Rdd linux-firmware
sudo pacman -Syu --needed base-devel linux-firmware

# Install yay (AUR helper)
echo "Installing yay (AUR helper)..."
if [ ! -d "$HOME/tools/yay" ]; then
    git clone https://aur.archlinux.org/yay.git "$HOME/tools/yay"
fi
cd "$HOME/tools/yay"
makepkg -si --noconfirm

# Check if yay installed successfully
if ! command -v yay &> /dev/null; then
    echo "Error: yay failed to install. Cannot proceed with AUR packages."
    exit 1
fi

ARCH_LIST="ripgrep docker docker-compose cmake unzip ninja tree-sitter curl python-pip ruby lazygit direnv wezterm pipewire pipewire-audio pipewire-alsa brightnessctl thunar thunar-volman gvfs libinput wayland wlroots libxkbcommon wayland-protocols pkgconf bemenu bemenu-wayland dmenu slurp grim firefox bluez bluez-utils blueman-manager noto-fonts-emoji noto-fonts-cjk"
AUR_LIST="fnm-bin lazydocker xorg-xwayland lua-lgi ttf-go-nerd ttf-jetbrains-mono-nerd zsh-syntax-highlighting-git slack-desktop beekeeper-studio-appimage feh wl-clipboard python2 python-pynvim"

echo "Fetching standard Arch packages..."
sudo pacman -Syu --noconfirm $ARCH_LIST

echo "Fetching AUR packages..."
yay -Syu --noconfirm $AUR_LIST

# Install Neovim from source (after cmake, ninja are installed)
echo "Installing/updating Neovim from source..."
if [ ! -d "$HOME/tools/neovim" ]; then
    git clone https://github.com/neovim/neovim "$HOME/tools/neovim"
fi
cd "$HOME/tools/neovim"
make CMAKE_BUILD_TYPE=Release
sudo make install

# Setup fzf
echo "Setting up FZF..."
if [ ! -d "$HOME/.fzf" ]; then
    git clone --depth 1 https://github.com/junegunn/fzf.git "$HOME/.fzf"
    "$HOME/.fzf/install" --all
fi

# Backup existing zshrc and symlink dotfiles
echo "Backing up existing configuration files and symlinking dotfiles..."
[ -f "$HOME/.zshrc" ] && mv "$HOME/.zshrc" "$HOME/.zshrc.bak"
ln -s "$HOME/dotfiles/zshrc" "$HOME/.zshrc"

# Assuming CONFIG_FILES_PATH is set in zshrc or otherwise available.
# For this script's execution, let's explicitly set it.
export CONFIG_FILES_PATH="$HOME/dotfiles"

ln -s "$CONFIG_FILES_PATH/nvim" "$HOME/.config/nvim"
ln -s "$CONFIG_FILES_PATH/gitconfig" "$HOME/.gitconfig"
ln -s "$CONFIG_FILES_PATH/gitignore_global" "$HOME/.gitignore_global"
ln -s "$CONFIG_FILES_PATH/wezterm" "$HOME/.config/wezterm"

# Docker group setup (requires logout/login to take effect for the user)
echo "Setting up Docker permissions. You may need to log out and log back in for changes to take effect."
sudo groupadd docker || true # '|| true' to prevent script from exiting if group already exists
sudo usermod -aG docker "$USER"

# Enable Docker services
sudo systemctl enable docker.service
sudo systemctl enable containerd.service

# Setup fnm and Node.js (assuming fnm-bin is installed by yay)
echo "Setting up Node.js with fnm..."
# Source fnm environment for current session, required before using fnm commands
eval "$(fnm env --use-on-cd)"
fnm install --lts
fnm default lts-latest

# Install Ruby gems
echo "Installing Ruby gems..."
sudo gem install neovim

# Install Python packages
echo "Installing Python packages..."
python3 -m pip install --user pynvim

# Generate SSH key for GitHub (optional)
read -p "Do you want to generate an SSH key for GitHub? (y/n) " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    read -p "Please enter your email address for the SSH key: " email_address

    echo "Generating SSH key..."
    ssh-keygen -t ed25519 -C "$email_address"
    eval "$(ssh-agent -s)" # Start ssh-agent if not already running
    ssh-add ~/.ssh/id_ed25519

    echo "Your public SSH key:"
    cat ~/.ssh/id_ed25519.pub
    echo "Please add this key to your GitHub account."
fi

# Set Zsh as default shell (moved to the end)
echo "Setting Zsh as default shell. You will need to log out and log back in, or restart your terminal."
chsh -s "$(which zsh)"

echo "I have exercised the demons. This house is clean"
echo "Please reboot your system or open a new terminal session for all changes to take effect."
