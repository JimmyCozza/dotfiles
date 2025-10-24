#!/bin/bash

# Exit immediately if a command exits with a non-zero status.
set -e

# Check network connectivity
echo "Checking network connectivity..."
if ! ping -c 1 archlinux.org &> /dev/null; then
    echo "Error: No network connectivity. Please connect to the internet and try again."
    exit 1
fi
echo "Network connectivity confirmed."

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

ARCH_LIST="ripgrep docker docker-compose cmake unzip ninja tree-sitter curl python-pip ruby lazygit direnv wezterm pipewire pipewire-audio pipewire-alsa brightnessctl thunar thunar-volman gvfs libinput wayland wlroots0.18 libxkbcommon wayland-protocols pkgconf bemenu bemenu-wayland dmenu slurp grim firefox bluez bluez-utils blueman noto-fonts-emoji noto-fonts-cjk autorandr xorg-server xorg-xinit xorg-xrandr xorg-setxkbcommon sddm tmux btop git rsync openssh alsa-utils fd jq gnome-keyring polkit-gnome xclip imagemagick flameshot maim arandr discord postgresql github-cli terraform kubectl terminus-font"
AUR_LIST="fnm-bin lazydocker xorg-xwayland lua-lgi ttf-go-nerd ttf-jetbrains-mono-nerd zsh-syntax-highlighting-git slack-desktop beekeeper-studio-appimage feh wl-clipboard python2 python-pynvim tableplus postman-bin ghostty"

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
ln -s "$CONFIG_FILES_PATH/xinitrc" "$HOME/.xinitrc"
ln -s "$CONFIG_FILES_PATH/ghostty" "$HOME/.config/ghostty"
ln -s "$CONFIG_FILES_PATH/psqlrc" "$HOME/.psqlrc"

# Docker group setup (requires logout/login to take effect for the user)
echo "Setting up Docker permissions. You may need to log out and log back in for changes to take effect."
sudo groupadd docker || true # '|| true' to prevent script from exiting if group already exists
sudo usermod -aG docker "$USER"

# Enable Docker services
sudo systemctl enable docker.service
sudo systemctl enable containerd.service

# Enable SDDM and Bluetooth
sudo systemctl enable sddm.service
sudo systemctl enable bluetooth.service

# Setup autorandr for automatic display configuration
echo "Setting up autorandr for automatic display management..."
# Save laptop-only profile (assuming laptop display is eDP-1 or eDP1)
if xrandr | grep -q "eDP"; then
    echo "Saving laptop-only display profile..."
    # Configure laptop display only
    LAPTOP_OUTPUT=$(xrandr | grep "eDP" | grep " connected" | cut -d' ' -f1)
    xrandr --output "$LAPTOP_OUTPUT" --auto --primary
    # Turn off all other outputs
    for output in $(xrandr | grep -E "^(HDMI|DP-[0-9]|DP[0-9])" | cut -d' ' -f1); do
        xrandr --output "$output" --off
    done
    autorandr --save laptop
    
    echo "Laptop profile saved. Connect external display and run setup-docked-profile.sh to configure dual display."
fi

# Install udev rule for automatic display switching
if [ -f "$CONFIG_FILES_PATH/udev-autorandr.rules" ]; then
    echo "Installing udev rule for automatic display switching..."
    sudo cp "$CONFIG_FILES_PATH/udev-autorandr.rules" /etc/udev/rules.d/99-autorandr.rules
    sudo udevadm control --reload-rules
    sudo udevadm trigger
    echo "Autorandr udev rule installed. Display will switch automatically on cable plug/unplug."
fi

# Setup fnm and Node.js (assuming fnm-bin is installed by yay)
echo "Setting up Node.js with fnm..."
# Source fnm environment for current session, required before using fnm commands
eval "$(fnm env --use-on-cd)"
fnm install --lts
fnm default lts-latest

# Install Ruby gems
echo "Installing Ruby gems..."
sudo gem install neovim

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
echo ""
echo "============================================"
echo "  INSTALLATION SUMMARY"
echo "============================================"
echo ""
echo "✓ System packages installed"
echo "✓ AUR packages installed"
echo "✓ Neovim built from source"
echo "✓ Dotfiles symlinked"
echo "✓ Docker configured"
echo "✓ SDDM and Bluetooth enabled"
echo "✓ FZF installed"
echo "✓ Node.js LTS installed via fnm"
echo ""
echo "MANUAL STEPS REQUIRED:"
echo "  1. Build and install AwesomeWM from ~/awesome-from-scratch"
echo "  2. Configure PostgreSQL (createuser, createdb)"
echo "  3. Set up gcloud SDK (if needed)"
echo "  4. Generate SSH key for GitHub (optional)"
echo ""
echo "See POST_INSTALL.md for detailed instructions."
echo ""
echo "Please reboot your system or open a new terminal session for all changes to take effect."
