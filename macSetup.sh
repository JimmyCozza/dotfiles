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
BREW_PACKAGES="ripgrep cmake unzip curl tree-sitter direnv lazygit git fzf bat fnm docker docker-compose golang rust node python ruby"

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

# Install/Update Neovim to latest
echo "📝 Installing/updating Neovim..."
brew install neovim

# Set up fish shell if not already installed
if ! command -v fish &> /dev/null; then
    echo "🐟 Installing Fish shell..."
    brew install fish
    
    # Install Oh My Fish
    curl https://raw.githubusercontent.com/oh-my-fish/oh-my-fish/master/bin/install | fish
    
    # Add Fish to shells and set as default
    echo /opt/homebrew/bin/fish | sudo tee -a /etc/shells
    chsh -s /opt/homebrew/bin/fish
else
    echo "🐟 Fish shell already installed"
fi

# Backup existing config files
echo "💾 Backing up existing configuration files..."
[ -f "$HOME/.zshrc" ] && mv "$HOME/.zshrc" "$HOME/.zshrc.bak"
[ -f "$HOME/.gitconfig" ] && mv "$HOME/.gitconfig" "$HOME/.gitconfig.bak"
[ -f "$HOME/.gitignore_global" ] && mv "$HOME/.gitignore_global" "$HOME/.gitignore_global.bak"

# Create symlinks for dotfiles
echo "🔗 Creating symlinks for dotfiles..."
ln -sf "$HOME/dotfiles/zshrc" "$HOME/.zshrc"
ln -sf "$HOME/dotfiles/gitconfig" "$HOME/.gitconfig"
ln -sf "$HOME/dotfiles/gitignore_global" "$HOME/.gitignore_global"
ln -sf "$HOME/dotfiles/nvim" "$HOME/.config/nvim"
ln -sf "$HOME/dotfiles/wezterm" "$HOME/.config/wezterm"

# Set up environment variables for this session
export CONFIG_FILES_PATH=$HOME/dotfiles

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
echo "🐟 If you want to use Fish as your default shell, it has been set up but may require a terminal restart"