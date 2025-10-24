# Post-Installation Manual Steps

After running `archSetup.sh`, complete these manual steps to finish your Arch Linux setup.

## 1. Build and Install AwesomeWM

Your custom AwesomeWM configuration lives in a separate repository.

```bash
cd ~
git clone https://github.com/YOUR_USERNAME/awesome-from-scratch
cd awesome-from-scratch

# Build AwesomeWM from source
# Follow the instructions in the awesome-from-scratch README
# Typically involves installing dependencies and running make

# After building, it should install to /usr/local/bin/awesome
# Verify installation:
awesome --version
```

The xinitrc is already configured to start AwesomeWM at `/usr/local/bin/awesome`.

## 2. Configure PostgreSQL

Set up PostgreSQL for local development:

```bash
# Initialize PostgreSQL data directory (if not already done)
sudo -u postgres initdb -D /var/lib/postgres/data

# Start and enable PostgreSQL
sudo systemctl start postgresql
sudo systemctl enable postgresql

# Create your user and database
sudo -u postgres createuser -s $USER
createdb $USER
```

## 3. Set Up Google Cloud SDK (Optional)

If you need gcloud:

```bash
cd ~/tools
curl -O https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-cli-linux-x86_64.tar.gz
tar -xf google-cloud-cli-linux-x86_64.tar.gz
cd google-cloud-sdk
./install.sh

# Initialize gcloud
gcloud init
```

The PATH is already configured in your zshrc.

## 4. Generate SSH Key for GitHub (Optional)

If you need SSH access to GitHub:

```bash
ssh-keygen -t ed25519 -C "your_email@example.com"
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519

# Copy the public key
cat ~/.ssh/id_ed25519.pub

# Add it to GitHub:
# https://github.com/settings/keys
```

## 5. Configure Display (First Boot)

On first boot into Xorg/AwesomeWM:

```bash
# Save your laptop-only display profile
autorandr --save laptop

# When connecting external displays, configure with arandr:
arandr

# Then save the profile:
autorandr --save docked
```

Automatic display switching via udev should already be configured.

## 6. Verify Services

Check that critical services are running:

```bash
systemctl status sddm
systemctl status bluetooth
systemctl status docker
```

## 7. First Neovim Launch

Launch Neovim to trigger plugin installation:

```bash
nvim
# Lazy.nvim will automatically install all plugins
# Wait for installation to complete
```

## 8. Configure Bluetooth Devices

Use Blueman to pair devices:

```bash
blueman-manager
# or
bluetoothctl
```

## 9. Test Docker

Verify Docker works without sudo:

```bash
# You may need to log out and back in first
docker run hello-world
```

## Troubleshooting

### AwesomeWM won't start
- Verify it's installed: `which awesome`
- Check logs: `~/.local/share/xorg/Xorg.0.log`
- Try starting manually: `startx`

### Display issues
- Run `xrandr` to see available outputs
- Reconfigure with `arandr`
- Check autorandr profiles: `autorandr --list`

### Neovim plugin issues
- Open Neovim and run `:Lazy sync`
- Check for errors: `:checkhealth`

### Missing packages
- Search the AUR: `yay -Ss package-name`
- Install manually: `yay -S package-name`
