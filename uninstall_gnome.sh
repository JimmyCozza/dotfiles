#!/bin/bash
# Script to uninstall GNOME and its dependencies

# Make sure we're running as a user with sudo privileges
if [ "$(id -u)" -eq 0 ]; then
    echo "Please don't run this script as root directly. Use your normal user with sudo privileges."
    exit 1
fi

echo "This script will uninstall GNOME and its related packages."
echo "First, let's identify what window manager you want to keep using."
echo "Based on your config files, it looks like you might have been using awesome WM."
echo "Press Enter to continue or Ctrl+C to abort..."
read

# Remove GNOME session and core components
echo "Removing GNOME core components..."
sudo pacman -Rns gnome gnome-shell gnome-session gdm

# Remove common GNOME apps that were likely installed
echo "Removing GNOME applications..."
sudo pacman -Rns gnome-terminal nautilus epiphany gnome-control-center gnome-settings-daemon \
    gnome-backgrounds gnome-calculator gnome-calendar gnome-characters gnome-clocks gnome-contacts \
    gnome-disk-utility gnome-font-viewer gnome-keyring gnome-logs gnome-maps gnome-menus \
    gnome-music gnome-photos gnome-remote-desktop gnome-screenshot gnome-shell-extensions \
    gnome-system-monitor gnome-user-docs gnome-user-share gnome-weather gnome-boxes evolution

# Remove remaining optional dependencies
echo "Cleaning up optional GNOME dependencies..."
sudo pacman -Rns gsettings-desktop-schemas tracker tracker3 tracker3-miners xdg-desktop-portal-gnome \
    yelp gvfs-afc gvfs-goa gvfs-google gvfs-gphoto2 gvfs-mtp gvfs-nfs gvfs-smb

# Clean up orphaned packages
echo "Removing orphaned packages..."
sudo pacman -Rns $(pacman -Qtdq) || echo "No orphaned packages to remove"

# Clean up GNOME configuration files
echo "Cleaning up GNOME configuration files..."
rm -rf ~/.config/dconf ~/.config/gnome-* ~/.config/evolution ~/.config/nautilus

echo "GNOME should now be uninstalled."
echo "You might want to check if your preferred window manager is set as default."
echo "If you're using a display manager like LightDM, make sure it's properly configured."
echo "If you were using GDM (GNOME's display manager), you might need to install and configure"
echo "another display manager like LightDM, SDDM, or simply use startx."

# Check if awesome is still installed and provide instructions
if pacman -Q awesome &>/dev/null; then
    echo "awesome WM is still installed. You can start it with 'startx /usr/bin/awesome'"
    echo "or configure your display manager to use awesome."
else
    echo "Note: awesome WM doesn't seem to be installed. If you want to use it,"
    echo "install it with 'sudo pacman -S awesome'"
fi

# Suggesting to restart the system
echo "It's recommended to restart your system now."
echo "Would you like to restart now? (y/n)"
read restart
if [ "$restart" = "y" ] || [ "$restart" = "Y" ]; then
    sudo systemctl reboot
else
    echo "Please restart your system manually when ready."
fi
