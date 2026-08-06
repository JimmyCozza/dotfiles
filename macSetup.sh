#!/bin/bash

echo "🍎 Setting up macOS development environment..."

# Create essential directories
echo "📁 Creating directories..."
mkdir -p $HOME/Pictures
mkdir -p $HOME/Downloads
mkdir -p $HOME/projects
mkdir -p $HOME/tools

# Check if Homebrew is installed, if not install it
if ! command -v brew &> /dev/null; then
    echo "🍺 Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
    eval "$(/opt/homebrew/bin/brew shellenv)"
else
    echo "🍺 Homebrew already installed, updating..."
    brew update
fi

# Essential development tools
BREW_PACKAGES="ripgrep cmake unzip curl tree-sitter direnv lazygit git fzf bat fnm docker docker-compose golang rust node python ruby fd jq btop gh neovim tmux zsh-syntax-highlighting"

# GUI applications
BREW_CASKS="wezterm firefox docker slack beekeeper-studio"

# Fonts
BREW_FONTS="font-jetbrains-mono-nerd-font font-go-mono-nerd-font"

echo "🔧 Installing essential packages..."
brew install $BREW_PACKAGES

echo "🖥️  Installing GUI applications..."
brew install --cask $BREW_CASKS

echo "🔤 Installing fonts..."
brew tap homebrew/cask-fonts
brew install --cask $BREW_FONTS

# Install FZF key bindings and fuzzy completion
echo "🔍 Setting up FZF..."
$(brew --prefix)/opt/fzf/install --all

# Set up environment variables for this session
export CONFIG_FILES_PATH=$HOME/dotfiles

# Create symlinks for dotfiles (backing up anything already in place)
echo "🔗 Creating symlinks for dotfiles..."
create_symlink() {
    local source="$1"
    local target="$2"
    mkdir -p "$(dirname "$target")"
    if [ -L "$target" ]; then
        rm "$target"
    elif [ -f "$target" ] || [ -d "$target" ]; then
        mv "$target" "${target}.bak"
    fi
    ln -s "$source" "$target"
}

create_symlink "$CONFIG_FILES_PATH/zshrc" "$HOME/.zshrc"
create_symlink "$CONFIG_FILES_PATH/gitconfig" "$HOME/.gitconfig"
create_symlink "$CONFIG_FILES_PATH/gitignore_global" "$HOME/.gitignore_global"
create_symlink "$CONFIG_FILES_PATH/nvim" "$HOME/.config/nvim"
create_symlink "$CONFIG_FILES_PATH/wezterm" "$HOME/.config/wezterm"
create_symlink "$CONFIG_FILES_PATH/ghostty" "$HOME/.config/ghostty"
create_symlink "$CONFIG_FILES_PATH/psqlrc" "$HOME/.psqlrc"
create_symlink "$CONFIG_FILES_PATH/tmux/tmux.conf" "$HOME/.config/tmux/tmux.conf"

# Set up tmux plugin manager (tmux.conf loads plugins via TPM)
echo "🧩 Setting up tmux plugin manager..."
if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
    git clone https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm"
fi
"$HOME/.tmux/plugins/tpm/scripts/install_plugins.sh"

# Set up Node.js with fnm
echo "📦 Setting up Node.js with fnm..."
eval "$(fnm env --use-on-cd)"
fnm install --lts
fnm default lts-latest

# Install global npm packages that might be useful
npm install -g yarn pnpm

# Set up Ruby gems path
echo "💎 Setting up Ruby environment..."
gem install neovim

# Set up Python packages
echo "🐍 Setting up Python packages..."
python3 -m pip install --user pynvim

# macOS specific settings
echo "🖥️  Configuring macOS settings..."

# Show hidden files in Finder
defaults write com.apple.finder AppleShowAllFiles -bool true

# Show file extensions in Finder
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# Disable the "Are you sure you want to open this application?" dialog
defaults write com.apple.LaunchServices LSQuarantine -bool false

# Speed up Mission Control animations
defaults write com.apple.dock expose-animation-duration -float 0.1

# Remove the auto-hiding Dock delay
defaults write com.apple.dock autohide-delay -float 0

# Make Dock icons of hidden applications translucent
defaults write com.apple.dock showhidden -bool true

# Restart Finder and Dock to apply changes
killall Finder
killall Dock

# Set up Git (will use the gitconfig from dotfiles)
echo "📋 Git configuration will use your dotfiles/gitconfig"

# Generate SSH key for GitHub (optional)
read -p "🔑 Do you want to generate an SSH key for GitHub? (y/n) " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    read -p "📧 Please enter your email address for the SSH key: " email_address
    
    echo "🔐 Generating SSH key..."
    ssh-keygen -t ed25519 -C "$email_address"
    eval "$(ssh-agent -s)"
    ssh-add ~/.ssh/id_ed25519
    
    echo "🔑 Your public SSH key:"
    cat ~/.ssh/id_ed25519.pub
    echo "📋 Please add this key to your GitHub account at: https://github.com/settings/keys"
fi

echo "🎉 macOS development environment setup complete!"
echo "🔄 Please restart your terminal or run 'source ~/.zshrc' to load the new configuration"