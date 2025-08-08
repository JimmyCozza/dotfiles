# Autorandr Display Management Setup

This setup enables automatic display configuration switching when you plug/unplug external monitors.

## Components

1. **autorandr** - Automatically detects and applies display configurations
2. **Profiles**:
   - `laptop` - Single screen (eDP-1 only)
   - `docked` - Dual screen with external monitor
3. **Udev rule** - Triggers autorandr on display hotplug events
4. **Helper scripts** - For easy setup and configuration

## Initial Setup

### Step 1: Install autorandr
```bash
yay -S autorandr
# or
sudo pacman -S autorandr
```

### Step 2: Save laptop-only profile
With only your laptop screen active:
```bash
autorandr --save laptop
```

### Step 3: Configure and save docked profile
1. Connect your external monitor via HDMI/DisplayPort
2. Run the setup script:
   ```bash
   cd ~/dotfiles/screenlayout
   ./setup-docked-profile.sh
   ```
   This will configure the external display as primary and save it as the 'docked' profile.

### Step 4: Install udev rule for automatic switching
```bash
cd ~/dotfiles/screenlayout
./install-autorandr-udev.sh
```

### Step 5: (Optional) Enable systemd service
For additional reliability at login:
```bash
systemctl --user enable ~/dotfiles/systemd/autorandr.service
systemctl --user start autorandr.service
```

## Testing

1. **Check current profile**:
   ```bash
   autorandr --current
   ```

2. **List available profiles**:
   ```bash
   autorandr --list
   ```

3. **Test automatic switching**:
   - Unplug HDMI cable → Should switch to 'laptop' profile
   - Plug HDMI cable → Should switch to 'docked' profile
   - Windows should automatically move to the active display(s)

4. **Manual profile switching** (if needed):
   ```bash
   autorandr --load laptop   # Switch to laptop-only
   autorandr --load docked   # Switch to dual display
   ```

## Troubleshooting

### Profile not switching automatically
1. Check if udev rule is installed:
   ```bash
   ls -la /etc/udev/rules.d/99-autorandr.rules
   ```

2. Monitor udev events:
   ```bash
   sudo udevadm monitor --property
   ```
   Then plug/unplug your HDMI cable to see if events are triggered.

3. Check autorandr detection:
   ```bash
   autorandr --detect
   ```

### Windows not moving to correct display
- The window manager should handle this automatically when displays change
- For X11 window managers, windows typically move to the primary display when a screen is removed

### Modifying display arrangement
To change how displays are arranged (e.g., external on left instead of right):
1. Use `arandr` GUI tool or `xrandr` commands to arrange displays
2. Save the new configuration:
   ```bash
   autorandr --save docked --force
   ```

## Manual Commands Reference

```bash
# List all outputs and modes
xrandr

# Apply laptop profile manually
xrandr --output eDP-1 --primary --auto --output DP-1 --off --output DP-2 --off

# Apply dual display manually (example)
xrandr --output DP-1 --primary --auto --output eDP-1 --auto --right-of DP-1

# Force autorandr to detect and switch
autorandr --change

# Save current configuration as new profile
autorandr --save profile_name
```