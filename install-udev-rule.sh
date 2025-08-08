#!/bin/bash

# Simple script to install the udev rule with proper sudo handling
echo "Installing autorandr udev rule..."
echo "This will copy the rule to /etc/udev/rules.d/ and reload udev"
echo ""
echo "Please enter your sudo password when prompted:"

# Copy the rule
sudo cp /home/jimmy/dotfiles/udev-autorandr.rules /etc/udev/rules.d/99-autorandr.rules

if [ $? -eq 0 ]; then
    echo "Rule copied successfully"
    
    # Reload udev rules
    sudo udevadm control --reload-rules
    sudo udevadm trigger
    
    echo ""
    echo "✓ Udev rule installed successfully!"
    echo ""
    echo "Autorandr will now automatically switch between:"
    echo "  • 'laptop' profile when HDMI is disconnected"
    echo "  • 'docked' profile when HDMI is connected"
else
    echo "Failed to install udev rule"
    exit 1
fi