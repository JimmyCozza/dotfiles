#!/bin/bash

# Script to install udev rule for autorandr

UDEV_RULE="/home/jimmy/dotfiles/udev-autorandr.rules"
UDEV_DEST="/etc/udev/rules.d/99-autorandr.rules"

echo "Installing udev rule for autorandr..."

# Check if rule already exists
if [ -f "$UDEV_DEST" ]; then
    echo "Udev rule already exists at $UDEV_DEST"
    echo "Do you want to overwrite it? (y/n)"
    read -r response
    if [ "$response" != "y" ]; then
        echo "Skipping udev rule installation."
        exit 0
    fi
fi

# Copy the rule (requires sudo)
echo "Installing udev rule (requires sudo)..."
sudo cp "$UDEV_RULE" "$UDEV_DEST"

# Reload udev rules
echo "Reloading udev rules..."
sudo udevadm control --reload-rules
sudo udevadm trigger

echo "Udev rule installed successfully!"
echo ""
echo "Autorandr will now automatically:"
echo "  - Switch to 'laptop' profile when external displays are disconnected"
echo "  - Switch to 'docked' profile when external displays are connected"
echo ""
echo "Note: You need to run './setup-docked-profile.sh' with your external"
echo "      display connected to save the 'docked' profile first."