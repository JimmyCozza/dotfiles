#!/bin/bash

# Script to help set up docked profile with external monitor

echo "Checking for external displays..."
EXTERNAL_DISPLAYS=$(xrandr | grep -E "^(HDMI|DP-[0-9])" | grep " connected" | cut -d' ' -f1)

if [ -z "$EXTERNAL_DISPLAYS" ]; then
    echo "No external display detected. Please connect your HDMI/DP cable and run this script again."
    exit 1
fi

echo "Found external display(s): $EXTERNAL_DISPLAYS"

# Get the first external display
EXTERNAL=$(echo "$EXTERNAL_DISPLAYS" | head -n1)
echo "Using display: $EXTERNAL"

# Get current resolution of laptop screen
LAPTOP_RES=$(xrandr | grep "^eDP-1" -A1 | grep "\*" | awk '{print $1}')

# Get best resolution for external display
EXTERNAL_RES=$(xrandr | grep "^$EXTERNAL" -A1 | grep -oE "[0-9]+x[0-9]+" | head -n1)

echo "Setting up dual display configuration..."
echo "  Laptop (eDP-1): $LAPTOP_RES"
echo "  External ($EXTERNAL): $EXTERNAL_RES"

# Configure dual display - external as primary, laptop to the right
xrandr --output eDP-1 --mode $LAPTOP_RES --pos ${EXTERNAL_RES%x*}x0 \
       --output $EXTERNAL --primary --mode $EXTERNAL_RES --pos 0x0

echo "Dual display configured. Saving as 'docked' profile..."
autorandr --save docked

echo "Profile saved! Autorandr will now automatically switch between:"
echo "  - 'laptop' profile when external display is disconnected"
echo "  - 'docked' profile when external display is connected"

# Show current profiles
echo ""
echo "Available profiles:"
autorandr --list