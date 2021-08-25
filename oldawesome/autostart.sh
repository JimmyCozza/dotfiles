#!/usr/bin/env bash
# .scripts/awesome/autostart.sh
# Launch Apps when AwesomeWM starts.

function run {
  if ! pgrep -f $1 ;
  then
    $@&
  fi
}

# List the apps you wish to run on startup below preceded with "run"

# Policy kit (needed for GUI apps to ask for password)
run /usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
# xrandr layout for AwesomeWM
run ~/.scripts/awesome/awesome_display_layout.sh &
# Start compositor
run picom --experimental-backend &
# sxhkd Hotkeys
run sxhkd &
# Start Volume Control applet
run volctl &
# Start Network Manager Applet 
run nm-applet &
# Set Numlock key to active.
run numlockx &
# Start Guake terminal  
run guake &
# Screensaver
run xscreensaver -no-splash &
# Greenclip for Rofi
run greenclip daemon &
# Pamac system update notifications
run pamac-tray &
# Start Dropbox
run dropbox &
# Bluetooth
run blueman-tray &
# MPD
run mpd ~/.config/mpd/mpd.conf &
# Unclutter - (hides mouse pointer after 5 seconds of inactivity)
run unclutter &
