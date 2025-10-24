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

# Fix keyring issues (common on fresh installs)
echo "Initializing and updating keyring..."
sudo pacman-key --init
sudo pacman-key --populate archlinux
sudo pacman -Sy --noconfirm archlinux-keyring

# Ensure system time is correct (keyring verification needs accurate time)
echo "Syncing system time..."
sudo timedatectl set-ntp true
sleep 2

echo "Setup directories"
mkdir -p "$HOME/Pictures"
mkdir -p "$HOME/Downloads"
mkdir -p "$HOME/projects"
mkdir -p "$HOME/tools"

echo "Updating system and installing base-devel"
# Update system and install essential packages
sudo pacman -Syu --noconfirm --needed base-devel linux-firmware

# Install yay (AUR helper)
echo "Checking for yay (AUR helper)..."
if ! command -v yay &> /dev/null; then
    echo "Installing yay..."
    if [ ! -d "$HOME/tools/yay" ]; then
        git clone https://aur.archlinux.org/yay.git "$HOME/tools/yay"
    fi
    cd "$HOME/tools/yay"
    makepkg -si --noconfirm
    cd - > /dev/null

    # Verify installation
    if ! command -v yay &> /dev/null; then
        echo "Error: yay failed to install. Cannot proceed with AUR packages."
        exit 1
    fi
else
    echo "yay is already installed, skipping..."
fi

ARCH_LIST="ripgrep docker docker-compose cmake unzip ninja tree-sitter curl python-pip ruby lazygit direnv wezterm pipewire pipewire-audio pipewire-alsa brightnessctl thunar thunar-volman gvfs libinput wayland wlroots0.18 libxkbcommon wayland-protocols pkgconf bemenu bemenu-wayland dmenu slurp grim firefox bluez bluez-utils blueman noto-fonts-emoji noto-fonts-cjk autorandr xorg-server xorg-xinit xorg-xrandr xorg-setxkbcommon sddm tmux btop git rsync openssh alsa-utils fd jq gnome-keyring polkit-gnome xclip imagemagick flameshot maim arandr discord postgresql github-cli terraform kubectl terminus-font"
AUR_LIST="fnm-bin lazydocker xorg-xwayland lua-lgi ttf-go-nerd ttf-jetbrains-mono-nerd zsh-syntax-highlighting-git slack-desktop beekeeper-studio-appimage feh wl-clipboard python2 python-pynvim tableplus postman-bin ghostty"

echo "Fetching standard Arch packages..."
sudo pacman -S --noconfirm --needed $ARCH_LIST || echo "Some packages may have failed, continuing..."

echo ""
echo "Fetching AUR packages..."
echo "NOTE: If any AUR package fails, you can install it manually later with: yay -S <package-name>"
yay -S --noconfirm --needed $AUR_LIST || echo "Some AUR packages may have failed, continuing..."

echo ""
echo "Package installation complete!"

# Install Neovim from source (after cmake, ninja are installed)
echo ""
echo "Installing/updating Neovim from source..."

# Verify build dependencies are installed
if ! command -v cmake &> /dev/null; then
    echo "  ERROR: cmake not found! Installing cmake..."
    sudo pacman -S --noconfirm cmake
fi

if ! command -v ninja &> /dev/null; then
    echo "  ERROR: ninja not found! Installing ninja..."
    sudo pacman -S --noconfirm ninja
fi

# Verify dependencies are now available
if ! command -v cmake &> /dev/null || ! command -v ninja &> /dev/null; then
    echo "  ERROR: Required build tools (cmake, ninja) not available. Skipping Neovim build."
    echo "  You can build it manually later by running:"
    echo "    cd ~/tools/neovim && make CMAKE_BUILD_TYPE=Release && sudo make install"
else
    if [ ! -d "$HOME/tools/neovim" ]; then
        echo "  Cloning Neovim repository..."
        git clone https://github.com/neovim/neovim "$HOME/tools/neovim"
    fi
    cd "$HOME/tools/neovim"
    echo "  Building Neovim (this may take a few minutes)..."
    make CMAKE_BUILD_TYPE=Release
    echo "  Installing Neovim..."
    sudo make install
    cd - > /dev/null
    echo "  Neovim installation complete!"
fi

# Setup fzf
echo ""
echo "Setting up FZF..."
if [ ! -d "$HOME/.fzf" ]; then
    git clone --depth 1 https://github.com/junegunn/fzf.git "$HOME/.fzf"
    "$HOME/.fzf/install" --all
else
    echo "FZF already installed, skipping..."
fi

# Backup existing configs and create symlinks
echo ""
echo "Setting up dotfile symlinks..."
export CONFIG_FILES_PATH="$HOME/dotfiles"

# Function to safely create symlink
create_symlink() {
    local source="$1"
    local target="$2"

    if [ -L "$target" ]; then
        echo "  Symlink $target already exists, removing..."
        rm "$target"
    elif [ -f "$target" ] || [ -d "$target" ]; then
        echo "  Backing up existing $target to ${target}.bak..."
        mv "$target" "${target}.bak"
    fi

    ln -s "$source" "$target"
    echo "  Created symlink: $target -> $source"
}

create_symlink "$CONFIG_FILES_PATH/zshrc" "$HOME/.zshrc"
create_symlink "$CONFIG_FILES_PATH/nvim" "$HOME/.config/nvim"
create_symlink "$CONFIG_FILES_PATH/gitconfig" "$HOME/.gitconfig"
create_symlink "$CONFIG_FILES_PATH/gitignore_global" "$HOME/.gitignore_global"
create_symlink "$CONFIG_FILES_PATH/wezterm" "$HOME/.config/wezterm"
create_symlink "$CONFIG_FILES_PATH/xinitrc" "$HOME/.xinitrc"
create_symlink "$CONFIG_FILES_PATH/ghostty" "$HOME/.config/ghostty"
create_symlink "$CONFIG_FILES_PATH/psqlrc" "$HOME/.psqlrc"

# Docker group setup (requires logout/login to take effect for the user)
echo ""
echo "Setting up Docker..."
sudo groupadd docker 2>/dev/null || echo "  Docker group already exists"
sudo usermod -aG docker "$USER"
echo "  Added $USER to docker group (requires logout to take effect)"

# Enable system services
echo ""
echo "Enabling system services..."
sudo systemctl enable docker.service 2>/dev/null && echo "  ✓ Docker service enabled" || echo "  Docker service already enabled"
sudo systemctl enable containerd.service 2>/dev/null && echo "  ✓ Containerd service enabled" || echo "  Containerd already enabled"
sudo systemctl enable sddm.service 2>/dev/null && echo "  ✓ SDDM display manager enabled" || echo "  SDDM already enabled"
sudo systemctl enable bluetooth.service 2>/dev/null && echo "  ✓ Bluetooth service enabled" || echo "  Bluetooth already enabled"

# Setup autorandr for automatic display configuration
echo ""
echo "Setting up autorandr..."
# Skip if not in graphical environment
if command -v xrandr &> /dev/null && xrandr &> /dev/null; then
    if xrandr | grep -q "eDP"; then
        echo "  Saving laptop-only display profile..."
        LAPTOP_OUTPUT=$(xrandr | grep "eDP" | grep " connected" | cut -d' ' -f1)
        xrandr --output "$LAPTOP_OUTPUT" --auto --primary
        # Turn off all other outputs
        for output in $(xrandr | grep -E "^(HDMI|DP-[0-9]|DP[0-9])" | cut -d' ' -f1); do
            xrandr --output "$output" --off 2>/dev/null || true
        done
        autorandr --save laptop 2>/dev/null || echo "  Could not save autorandr profile"
        echo "  Laptop profile saved!"
    fi
else
    echo "  Skipping (not in graphical environment - run 'autorandr --save laptop' after first X session)"
fi

# Install udev rule for automatic display switching
if [ -f "$CONFIG_FILES_PATH/udev-autorandr.rules" ]; then
    echo ""
    echo "Installing udev rule for automatic display switching..."
    sudo cp "$CONFIG_FILES_PATH/udev-autorandr.rules" /etc/udev/rules.d/99-autorandr.rules
    sudo udevadm control --reload-rules
    sudo udevadm trigger
    echo "  ✓ Autorandr udev rule installed"
fi

# Setup fnm and Node.js
echo ""
echo "Setting up Node.js with fnm..."
if command -v fnm &> /dev/null; then
    eval "$(fnm env --use-on-cd)"
    fnm install --lts
    fnm default lts-latest
    echo "  ✓ Node.js LTS installed"
else
    echo "  fnm not found, skipping Node.js setup"
fi

# Install Ruby gems
echo ""
echo "Installing Ruby gems..."
sudo gem install neovim 2>/dev/null && echo "  ✓ Neovim Ruby gem installed" || echo "  Ruby gem already installed or failed"

# Generate SSH key for GitHub (optional)
echo ""
read -p "Do you want to generate an SSH key for GitHub? (y/n) " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    read -p "Please enter your email address for the SSH key: " email_address
    echo "  Generating SSH key..."
    ssh-keygen -t ed25519 -C "$email_address"
    eval "$(ssh-agent -s)"
    ssh-add ~/.ssh/id_ed25519
    echo ""
    echo "  Your public SSH key:"
    cat ~/.ssh/id_ed25519.pub
    echo ""
    echo "  Add this key to GitHub: https://github.com/settings/keys"
else
    echo "  Skipping SSH key generation"
fi

# Set Zsh as default shell
echo ""
echo "Setting Zsh as default shell..."
if [ "$SHELL" = "$(which zsh)" ]; then
    echo "  Zsh is already your default shell"
else
    chsh -s "$(which zsh)"
    echo "  ✓ Zsh set as default shell (logout required to take effect)"
fi

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
